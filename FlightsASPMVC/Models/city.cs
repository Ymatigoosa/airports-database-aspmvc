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
    
    public partial class city
    {
        public city()
        {
            this.airport = new HashSet<airport>();
            this.passenger = new HashSet<passenger>();
            this.employee = new HashSet<employee>();
        }

        [Display(Name = "City identifier")]
        public int id { get; set; }

        [Display(Name = "City")]
        public string name { get; set; }
        public int country { get; set; }
    
        public virtual ICollection<airport> airport { get; set; }
        public virtual country country1 { get; set; }
        public virtual ICollection<passenger> passenger { get; set; }
        public virtual ICollection<employee> employee { get; set; }
    }
}