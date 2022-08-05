using MongoDB.Bson.Serialization.Attributes;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace nrmcontrolextension.Models
{
    [BsonIgnoreExtraElements]
    public class DespenseType
    {
        [JsonProperty]
        public int Id { get; set; }

        [JsonProperty]
        public string Description { get; set; }
        [JsonProperty]
        public string UserId { get; set; }

        [JsonProperty]
        public bool MonthFixed { get; set; }

        [JsonProperty]
        public DateTime? StartDate { get; set; }

        [JsonProperty]
        public double? Value { get; set; }

        [JsonProperty]
        public int? IconData { get; set; }

        public DespenseType(int id) : this(id, string.Empty, string.Empty, false,null, null,null) { }

        [JsonConstructor()]
        public DespenseType(int id,
            string userId,
            string description,
            bool monthFixed,
            int? iconData,
            DateTime? startDate,
            double? value)
        {
            this.Id = id;
            this.UserId = userId;
            this.Description = description;
            this.MonthFixed = monthFixed;
            this.IconData = iconData;
            this.StartDate = startDate;
            this.Value = value;
        }
    }
}
