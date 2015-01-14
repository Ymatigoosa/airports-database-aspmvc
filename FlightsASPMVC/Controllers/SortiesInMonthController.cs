using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using FlightsASPMVC.Models;

namespace FlightsASPMVC.Controllers
{
    public class SortiesInMonthController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /SortiesInMonth/
        public ActionResult Index()
        {
            return View(db.sorties_in_month.ToList());
        }

        // GET: /SortiesInMonth/Details/5
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            sorties_in_month sorties_in_month = db.sorties_in_month.Find(id);
            if (sorties_in_month == null)
            {
                return HttpNotFound();
            }
            return View(sorties_in_month);
        }

        // GET: /SortiesInMonth/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: /SortiesInMonth/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="id,plane_id,plane_model_name,team,passenger_capacity,bought,free,sortie_start,sortie_delta_time,landing_start,landing_delta_time")] sorties_in_month sorties_in_month)
        {
            if (ModelState.IsValid)
            {
                db.sorties_in_month.Add(sorties_in_month);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(sorties_in_month);
        }

        // GET: /SortiesInMonth/Edit/5
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            sorties_in_month sorties_in_month = db.sorties_in_month.Find(id);
            if (sorties_in_month == null)
            {
                return HttpNotFound();
            }
            return View(sorties_in_month);
        }

        // POST: /SortiesInMonth/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="id,plane_id,plane_model_name,team,passenger_capacity,bought,free,sortie_start,sortie_delta_time,landing_start,landing_delta_time")] sorties_in_month sorties_in_month)
        {
            if (ModelState.IsValid)
            {
                db.Entry(sorties_in_month).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(sorties_in_month);
        }

        // GET: /SortiesInMonth/Delete/5
        public ActionResult Delete(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            sorties_in_month sorties_in_month = db.sorties_in_month.Find(id);
            if (sorties_in_month == null)
            {
                return HttpNotFound();
            }
            return View(sorties_in_month);
        }

        // POST: /SortiesInMonth/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            sorties_in_month sorties_in_month = db.sorties_in_month.Find(id);
            db.sorties_in_month.Remove(sorties_in_month);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
