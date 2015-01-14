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
    public class AirportController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /Airport/
        public ActionResult Index()
        {
            var airport = db.airport.Include(a => a.airline1).Include(a => a.city1);
            return View(airport.ToList());
        }

        // GET: /Airport/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            airport airport = db.airport.Find(id);
            if (airport == null)
            {
                return HttpNotFound();
            }
            return View(airport);
        }

        // GET: /Airport/Create
        public ActionResult Create()
        {
            ViewBag.airline = new SelectList(db.airline, "id", "name");
            ViewBag.city = new SelectList(db.city, "id", "name");
            return View();
        }

        // POST: /Airport/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="id,city,airline")] airport airport)
        {
            if (ModelState.IsValid)
            {
                db.airport.Add(airport);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.airline = new SelectList(db.airline, "id", "name", airport.airline);
            ViewBag.city = new SelectList(db.city, "id", "name", airport.city);
            return View(airport);
        }

        // GET: /Airport/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            airport airport = db.airport.Find(id);
            if (airport == null)
            {
                return HttpNotFound();
            }
            ViewBag.airline = new SelectList(db.airline, "id", "name", airport.airline);
            ViewBag.city = new SelectList(db.city, "id", "name", airport.city);
            return View(airport);
        }

        // POST: /Airport/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="id,city,airline")] airport airport)
        {
            if (ModelState.IsValid)
            {
                db.Entry(airport).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.airline = new SelectList(db.airline, "id", "name", airport.airline);
            ViewBag.city = new SelectList(db.city, "id", "name", airport.city);
            return View(airport);
        }

        // GET: /Airport/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            airport airport = db.airport.Find(id);
            if (airport == null)
            {
                return HttpNotFound();
            }
            return View(airport);
        }

        // POST: /Airport/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            airport airport = db.airport.Find(id);
            db.airport.Remove(airport);
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
