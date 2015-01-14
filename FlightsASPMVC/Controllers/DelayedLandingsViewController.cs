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
    public class DelayedLandingsViewController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /DelayedLandingsView/
        public ActionResult Index()
        {
            return View(db.delayed_landings.ToList());
        }

        // GET: /DelayedLandingsView/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            delayed_landings delayed_landings = db.delayed_landings.Find(id);
            if (delayed_landings == null)
            {
                return HttpNotFound();
            }
            return View(delayed_landings);
        }

        // GET: /DelayedLandingsView/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: /DelayedLandingsView/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="id,flight,state,delta_time,start,reason")] delayed_landings delayed_landings)
        {
            if (ModelState.IsValid)
            {
                db.delayed_landings.Add(delayed_landings);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(delayed_landings);
        }

        // GET: /DelayedLandingsView/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            delayed_landings delayed_landings = db.delayed_landings.Find(id);
            if (delayed_landings == null)
            {
                return HttpNotFound();
            }
            return View(delayed_landings);
        }

        // POST: /DelayedLandingsView/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="id,flight,state,delta_time,start,reason")] delayed_landings delayed_landings)
        {
            if (ModelState.IsValid)
            {
                db.Entry(delayed_landings).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(delayed_landings);
        }

        // GET: /DelayedLandingsView/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            delayed_landings delayed_landings = db.delayed_landings.Find(id);
            if (delayed_landings == null)
            {
                return HttpNotFound();
            }
            return View(delayed_landings);
        }

        // POST: /DelayedLandingsView/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            delayed_landings delayed_landings = db.delayed_landings.Find(id);
            db.delayed_landings.Remove(delayed_landings);
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
