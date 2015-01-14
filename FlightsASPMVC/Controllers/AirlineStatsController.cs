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
    public class AirlineStatsController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /AirlineStats/
        public ActionResult Index()
        {
            return View(db.airline_statistics.ToList());
        }

        // GET: /AirlineStats/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            airline_statistics airline_statistics = db.airline_statistics.Find(id);
            if (airline_statistics == null)
            {
                return HttpNotFound();
            }
            return View(airline_statistics);
        }

        // GET: /AirlineStats/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: /AirlineStats/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="id,airline_name,avg_day_sortie_count")] airline_statistics airline_statistics)
        {
            if (ModelState.IsValid)
            {
                db.airline_statistics.Add(airline_statistics);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(airline_statistics);
        }

        // GET: /AirlineStats/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            airline_statistics airline_statistics = db.airline_statistics.Find(id);
            if (airline_statistics == null)
            {
                return HttpNotFound();
            }
            return View(airline_statistics);
        }

        // POST: /AirlineStats/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="id,airline_name,avg_day_sortie_count")] airline_statistics airline_statistics)
        {
            if (ModelState.IsValid)
            {
                db.Entry(airline_statistics).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(airline_statistics);
        }

        // GET: /AirlineStats/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            airline_statistics airline_statistics = db.airline_statistics.Find(id);
            if (airline_statistics == null)
            {
                return HttpNotFound();
            }
            return View(airline_statistics);
        }

        // POST: /AirlineStats/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            airline_statistics airline_statistics = db.airline_statistics.Find(id);
            db.airline_statistics.Remove(airline_statistics);
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
