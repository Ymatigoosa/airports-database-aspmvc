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
    public class SortiesWithPassangersController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /SortiesWithPassangers/
        public ActionResult Index()
        {
            return View(db.sorties_with_passengers.ToList());
        }

        // GET: /SortiesWithPassangers/Details/5
        public ActionResult Details(DateTime id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            sorties_with_passengers sorties_with_passengers = db.sorties_with_passengers.Find(id);
            if (sorties_with_passengers == null)
            {
                return HttpNotFound();
            }
            return View(sorties_with_passengers);
        }

        // GET: /SortiesWithPassangers/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: /SortiesWithPassangers/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="start,name,lastname,place,baggages_count")] sorties_with_passengers sorties_with_passengers)
        {
            if (ModelState.IsValid)
            {
                db.sorties_with_passengers.Add(sorties_with_passengers);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(sorties_with_passengers);
        }

        // GET: /SortiesWithPassangers/Edit/5
        public ActionResult Edit(DateTime id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            sorties_with_passengers sorties_with_passengers = db.sorties_with_passengers.Find(id);
            if (sorties_with_passengers == null)
            {
                return HttpNotFound();
            }
            return View(sorties_with_passengers);
        }

        // POST: /SortiesWithPassangers/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="start,name,lastname,place,baggages_count")] sorties_with_passengers sorties_with_passengers)
        {
            if (ModelState.IsValid)
            {
                db.Entry(sorties_with_passengers).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(sorties_with_passengers);
        }

        // GET: /SortiesWithPassangers/Delete/5
        public ActionResult Delete(DateTime id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            sorties_with_passengers sorties_with_passengers = db.sorties_with_passengers.Find(id);
            if (sorties_with_passengers == null)
            {
                return HttpNotFound();
            }
            return View(sorties_with_passengers);
        }

        // POST: /SortiesWithPassangers/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(DateTime id)
        {
            sorties_with_passengers sorties_with_passengers = db.sorties_with_passengers.Find(id);
            db.sorties_with_passengers.Remove(sorties_with_passengers);
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
