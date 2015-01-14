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
    public class BrigadeController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /Brigade/
        public ActionResult Index()
        {
            return View(db.brigade.ToList());
        }

        // GET: /Brigade/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            brigade brigade = db.brigade.Find(id);
            if (brigade == null)
            {
                return HttpNotFound();
            }
            return View(brigade);
        }

        // GET: /Brigade/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: /Brigade/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="id,comment")] brigade brigade)
        {
            if (ModelState.IsValid)
            {
                db.brigade.Add(brigade);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(brigade);
        }

        // GET: /Brigade/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            brigade brigade = db.brigade.Find(id);
            if (brigade == null)
            {
                return HttpNotFound();
            }
            return View(brigade);
        }

        // POST: /Brigade/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="id,comment")] brigade brigade)
        {
            if (ModelState.IsValid)
            {
                db.Entry(brigade).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(brigade);
        }

        // GET: /Brigade/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            brigade brigade = db.brigade.Find(id);
            if (brigade == null)
            {
                return HttpNotFound();
            }
            return View(brigade);
        }

        // POST: /Brigade/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            brigade brigade = db.brigade.Find(id);
            db.brigade.Remove(brigade);
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
