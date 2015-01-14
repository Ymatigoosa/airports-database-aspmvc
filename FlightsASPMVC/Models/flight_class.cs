//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace FlightsASPMVC.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    
    public partial class flight_class
    {
        public flight_class()
        {
            this.flight = new HashSet<flight>();
        }

        [Display(Name = "Flight class identifier")]
        public int id { get; set; }

        [Display(Name = "From")]
        public int from { get; set; }

        [Display(Name = "To")]
        public int to { get; set; }

        [Display(Name = "Type of periodicity")]
        public string periodicity_type { get; set; }

        [Display(Name = "Period (days)")]
        public int period { get; set; }

        [Display(Name = "Time of departure")]
        public System.TimeSpan time_of_departure { get; set; }

        [Display(Name = "Time in travel")]
        public System.TimeSpan travel_time { get; set; }

        [Display(Name = "Range")]
        public int range { get; set; }

        [Display(Name = "Type")]
        public string type { get; set; }

        [Display(Name = "Common price")]
        public int common_price { get; set; }

        [Display(Name = "Premium price")]
        public Nullable<int> premium_price { get; set; }
    
        public virtual airport airport { get; set; }
        public virtual airport airport1 { get; set; }
        public virtual ICollection<flight> flight { get; set; }
    }
}
