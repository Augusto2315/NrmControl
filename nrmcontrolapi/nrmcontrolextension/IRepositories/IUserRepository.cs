using nrmcontrolextension.Filters;
using nrmcontrolextension.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace nrmcontrolextension.IRepositories
{
    public interface IUserRepository
    {

        Task<List<User>> GetUsers(UserFilter userFilter);

        Task<User> SaveUser(User User);
        Task<bool> ValidateLogin(User User);
        Task<bool> DeleteUser(User User);
    }
}
