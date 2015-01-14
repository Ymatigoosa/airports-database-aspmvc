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
    public class SortieController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /Sortie/
        public ActionResult Index()
        {
            var sortie = db.sortie.Include(s => s.flight1);
            return View(sortie.ToList());
        }

        // GET: /Sortie/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            sortie sortie = db.sortie.Find(id);
            if (sortie == null)
            {
                return HttpNotFound();
            }
            return View(sortie);
        }

        // GET: /Sortie/Create
        public ActionResult Create()
        {
            ViewBag.flight = new SelectList(db.flight, "id", "id");
            return View();
        }

        // POST: /Sortie/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="id,flight,state,delta_time,start,reason")] sortie sortie)
        {
            if (ModelState.IsValid)
            {
                db.sortie.Add(sortie);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.flight = new SelectList(db.flight, "id", "id", sortie.flight);
            return View(sortie);
        }

        // GET: /Sortie/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            sortie sortie = db.sortie.Find(id);
            if (sortie == null)
            {
                return HttpNotFound();
            }
            ViewBag.flight = new SelectList(db.flight, "id", "id", sortie.flight);
            return View(sortie);
        }

        // POST: /Sortie/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="id,flight,state,delta_time,start,reason")] sortie sortie)
        {
            if (ModelState.IsValid)
            {
                db.Entry(sortie).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.flight = new SelectList(db.flight, "id", "id", sortie.flight);
            return View(sortie);
        }

        // GET: /Sortie/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            sortie sortie = db.sortie.Find(id);
            if (sortie == null)
            {
                return HttpNotFound();
            }
            return View(sortie);
        }

        // POST: /Sortie/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            sortie sortie = db.sortie.Find(id);
            db.sortie.Remove(sortie);
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
