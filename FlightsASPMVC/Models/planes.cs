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
    
    public partial class planes
    {
        [Display(Name = "Planes identifier")]
        public int id { get; set; }

        [Display(Name = "Airline")]
        public string airline { get; set; }

        [Display(Name = "Passenger capacity")]
        public short passenger_capacity { get; set; }

        [Display(Name = "Planes model")]
        public string model { get; set; }
    }
}
