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
    public class LandingController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /Landing/
        public ActionResult Index()
        {
            var landing = db.landing.Include(l => l.flight1);
            return View(landing.ToList());
        }

        // GET: /Landing/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            landing landing = db.landing.Find(id);
            if (landing == null)
            {
                return HttpNotFound();
            }
            return View(landing);
        }

        // GET: /Landing/Create
        public ActionResult Create()
        {
            ViewBag.flight = new SelectList(db.flight, "id", "id");
            return View();
        }

        // POST: /Landing/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="id,flight,state,delta_time,start,reason")] landing landing)
        {
            if (ModelState.IsValid)
            {
                db.landing.Add(landing);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.flight = new SelectList(db.flight, "id", "id", landing.flight);
            return View(landing);
        }

        // GET: /Landing/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            landing landing = db.landing.Find(id);
            if (landing == null)
            {
                return HttpNotFound();
            }
            ViewBag.flight = new SelectList(db.flight, "id", "id", landing.flight);
            return View(landing);
        }

        // POST: /Landing/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="id,flight,state,delta_time,start,reason")] landing landing)
        {
            if (ModelState.IsValid)
            {
                db.Entry(landing).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.flight = new SelectList(db.flight, "id", "id", landing.flight);
            return View(landing);
        }

        // GET: /Landing/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            landing landing = db.landing.Find(id);
            if (landing == null)
            {
                return HttpNotFound();
            }
            return View(landing);
        }

        // POST: /Landing/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            landing landing = db.landing.Find(id);
            db.landing.Remove(landing);
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
