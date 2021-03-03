import matplotlib.pyplot as plt
import numpy as np
import matplotlib as mplt


def polar_trajectories(X, cmap_name = None, alpha0 = 0.1, alpha_change = True, last_black = True):
    # Dimensions of the trajectories
    nx          = X.shape[0]
    nt          = X.shape[1]
    nx0         = X.shape[2]
    thetas      = canonical_directions_angles(nx)
    # Handle options
    if cmap_name is None:
        cmap_name = 'hsv'
    cmap    = plt.cm.get_cmap(cmap_name)
    #
    m0  = np.abs(np.amin(X))
    M   = np.amax(X)
    #
    if alpha_change:
        alphafun = lambda j: alpha0 * (1 - j/nx0)
    else:
        alphafun =lambda j : alpha0
    # Figure and axis properties
    for j in range(nx0):
        rgba = cmap((j+1)/nx0)
        if last_black and j == nx0-1:
            rgba = (0,0,0,1)
        for i in range(nt):
            polar_x(X[:,i,j], m0, thetas, rgba, alpha = alphafun(j))
    # Display the figure
    plt.xticks([])
    plt.yticks([])
    ax = plt.axes()
    ax.set_facecolor('black')
    ax.set_aspect('equal')
    #
    lim = m0 + M
    plt.xlim([-lim,lim])
    plt.ylim([-lim,lim])
    plt.show()


def polar_x(x, m0, thetas, rgba, alpha):
    # Radial projection of the state
    z =  (m0+x) * np.exp(1j * thetas)
    z = np.append(z,z[0])
    # Add that to the plot
    plt.plot(np.real(z), np.imag(z),color=rgba,alpha=alpha)

def canonical_directions_angles(n):
    return np.arange(n)*2*np.pi/n

# System related routines

def random_ss(n):
    B = np.random.rand(n,1)
    C = np.random.rand(1,n)
    D = np.random.rand(1)
    # Dynamic matrix
    nc          = np.random.randint(1,np.floor(n/2))
    nr          = n - 2*nc
    lambda_r    = -1 + 2*np.random.rand(nr)
    lambda_c    = np.random.rand(nc) * np.exp(1j*np.random.rand(nc)*2*np.pi)
    A           = np.random.rand(n,n)
    for i in range(n):
        A[i+1:,i] = 0
    for i in range(nr):
        A[i,i] = lambda_r[i]
    for i in range(nc):
        k           =  nr+2*i
        A[k,k]      =  np.real(lambda_c[i])
        A[k+1,k+1]  =  np.real(lambda_c[i])
        A[k,k+1]    =  np.imag(lambda_c[i])
        A[k+1,k]    = -np.imag(lambda_c[i])
    # Random basis
    X = 10 * np.random.rand(n,n)
    A = np.linalg.solve(X,A) @ X
    B = np.linalg.solve(X,B)
    C = C @ X
    return [A, B, C, D]

def free_ss_response(A, x0, T, tf):
    nx      = x0.shape[0]
    nx0     = x0.shape[1]
    #
    nt      = int(np.floor(tf/T))
    t       = np.linspace(0,tf,nt)
    X       = np.zeros([nx, nt, nx0])
    for i in range(nx0):
        X[:,0,i] = x0[:,i]
        for j  in range(nt-1):
            X[:,j+1,i] = np.matmul(A,X[:,j,i])
    return [X,t]
# Demo
def demo():
    n       = 80
    ncases  = 20
    while (True):
        [A,B,C,D]   = random_ss(n)
        [X,t]       = free_ss_response(A,  np.random.randn(n,ncases),0.05, 20)
        polar_trajectories(X, alpha0 = 0.2, last_black=True,alpha_change=False)

demo()
