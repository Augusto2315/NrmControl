﻿using nrmcontrolextension.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace nrmcontrolextension.IRepositories
{
    public interface IDespenseTypeRepository
    {
        Task<List<DespenseType>> GetDespensesTypes();

        Task<DespenseType> InsertDespenseType(DespenseType despenseType);
        DespenseType UpdateDespenseType(DespenseType despenseType);
        void DeleteDespenseType(DespenseType despenseType);
    }
}
