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
    public class BrigadeListViewController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /BrigadeListView/
        public ActionResult Index()
        {
            return View(db.brigade_list.ToList());
        }

        // GET: /BrigadeListView/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            brigade_list brigade_list = db.brigade_list.Find(id);
            if (brigade_list == null)
            {
                return HttpNotFound();
            }
            return View(brigade_list);
        }

        // GET: /BrigadeListView/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: /BrigadeListView/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="brigade,brigades")] brigade_list brigade_list)
        {
            if (ModelState.IsValid)
            {
                db.brigade_list.Add(brigade_list);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(brigade_list);
        }

        // GET: /BrigadeListView/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            brigade_list brigade_list = db.brigade_list.Find(id);
            if (brigade_list == null)
            {
                return HttpNotFound();
            }
            return View(brigade_list);
        }

        // POST: /BrigadeListView/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="brigade,brigades")] brigade_list brigade_list)
        {
            if (ModelState.IsValid)
            {
                db.Entry(brigade_list).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(brigade_list);
        }

        // GET: /BrigadeListView/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            brigade_list brigade_list = db.brigade_list.Find(id);
            if (brigade_list == null)
            {
                return HttpNotFound();
            }
            return View(brigade_list);
        }

        // POST: /BrigadeListView/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            brigade_list brigade_list = db.brigade_list.Find(id);
            db.brigade_list.Remove(brigade_list);
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
