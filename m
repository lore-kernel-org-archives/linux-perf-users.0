From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 07/12] perf hists browser: Allow passing an initial hotkey
Date: Thu, 19 Dec 2019 14:26:42 -0300
Message-ID: <20191219172642.GB13699@kernel.org>
References: <20191217144828.2460-1-acme@kernel.org>
 <20191217144828.2460-8-acme@kernel.org>
 <20191218080818.GD19062@krava>
 <20191218140831.GC13395@kernel.org>
 <20191218142321.GB15571@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191218142321.GB15571@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Dec 18, 2019 at 03:23:21PM +0100, Jiri Olsa escreveu:
> On Wed, Dec 18, 2019 at 11:08:31AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Dec 18, 2019 at 09:08:18AM +0100, Jiri Olsa escreveu:
> > > On Tue, Dec 17, 2019 at 11:48:23AM -0300, Arnaldo Carvalho de Melo wrote:
> > > > +	if (key)
> > > > +		goto do_hotkey;
> > > > +
> > > >  	while (1) {
> > > >  		key = ui_browser__run(&browser->b, delay_secs);
> > > > -
> > > > +do_hotkey:

> > > or we could switch the 'swtich' and ui_browser__run, and get rid of the goto, like:

> > > 	while (1) {
> > >   		switch (key) {
> > > 		...
> > > 		}
> > > 
> > > 		key = ui_browser__run(&browser->b, delay_secs);
> > > 	}

> > I think those are equivalent and having the test like I did is more
> > clear, i.e. "has this key been provided" instead of going to the switch
> > just to hit the default case for the zero in key and call
> > ui_browser__run().

> sure, I just don't like goto other than for error handling,
> looks too hacky to me ;-) but of course it's your call

How about the one below?

- Arnaldo

commit 9290297c911ad6c315c5f46f35afa3ce517a4c9f
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Thu Dec 12 15:31:40 2019 -0300

    perf hists browser: Allow passing an initial hotkey
    
    Sometimes we're in an outer code, like the main hists browser popup menu
    and the user follows a suggestion about using some hotkey, and that
    hotkey is really handled by hists_browser__run(), so allow for calling
    it with that hotkey, making it handle it instead of waiting for the user
    to press one.
    
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Andi Kleen <ak@linux.intel.com>
    Cc: Jin Yao <yao.jin@linux.intel.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Kan Liang <kan.liang@intel.com>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Link: https://lkml.kernel.org/n/tip-xv2l7i6o4urn37nv1h40ryfs@git.kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index e69f44941aad..346351260c0b 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2384,7 +2384,7 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
 	c2c_browser__update_nr_entries(browser);
 
 	while (1) {
-		key = hist_browser__run(browser, "? - help", true);
+		key = hist_browser__run(browser, "? - help", true, 0);
 
 		switch (key) {
 		case 's':
@@ -2453,7 +2453,7 @@ static int perf_c2c__hists_browse(struct hists *hists)
 	c2c_browser__update_nr_entries(browser);
 
 	while (1) {
-		key = hist_browser__run(browser, "? - help", true);
+		key = hist_browser__run(browser, "? - help", true, 0);
 
 		switch (key) {
 		case 'q':
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 6dfdd8d5a743..ac118aef5ed1 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -672,10 +672,81 @@ static int hist_browser__title(struct hist_browser *browser, char *bf, size_t si
 	return browser->title ? browser->title(browser, bf, size) : 0;
 }
 
+static int hist_browser__handle_hotkey(struct hist_browser *browser, bool warn_lost_event, char *title, int key)
+{
+	switch (key) {
+	case K_TIMER: {
+		struct hist_browser_timer *hbt = browser->hbt;
+		u64 nr_entries;
+
+		WARN_ON_ONCE(!hbt);
+
+		if (hbt)
+			hbt->timer(hbt->arg);
+
+		if (hist_browser__has_filter(browser) || symbol_conf.report_hierarchy)
+			hist_browser__update_nr_entries(browser);
+
+		nr_entries = hist_browser__nr_entries(browser);
+		ui_browser__update_nr_entries(&browser->b, nr_entries);
+
+		if (warn_lost_event &&
+		    (browser->hists->stats.nr_lost_warned !=
+		    browser->hists->stats.nr_events[PERF_RECORD_LOST])) {
+			browser->hists->stats.nr_lost_warned =
+				browser->hists->stats.nr_events[PERF_RECORD_LOST];
+			ui_browser__warn_lost_events(&browser->b);
+		}
+
+		hist_browser__title(browser, title, sizeof(title));
+		ui_browser__show_title(&browser->b, title);
+		break;
+	}
+	case 'D': { /* Debug */
+		struct hist_entry *h = rb_entry(browser->b.top, struct hist_entry, rb_node);
+		static int seq;
+
+		ui_helpline__pop();
+		ui_helpline__fpush("%d: nr_ent=(%d,%d), etl: %d, rows=%d, idx=%d, fve: idx=%d, row_off=%d, nrows=%d",
+				   seq++, browser->b.nr_entries, browser->hists->nr_entries,
+				   browser->b.extra_title_lines, browser->b.rows,
+				   browser->b.index, browser->b.top_idx, h->row_offset, h->nr_rows);
+	}
+		break;
+	case 'C':
+		/* Collapse the whole world. */
+		hist_browser__set_folding(browser, false);
+		break;
+	case 'c':
+		/* Collapse the selected entry. */
+		hist_browser__set_folding_selected(browser, false);
+		break;
+	case 'E':
+		/* Expand the whole world. */
+		hist_browser__set_folding(browser, true);
+		break;
+	case 'e':
+		/* Expand the selected entry. */
+		hist_browser__set_folding_selected(browser, true);
+		break;
+	case 'H':
+		browser->show_headers = !browser->show_headers;
+		hist_browser__update_rows(browser);
+		break;
+	case '+':
+		if (hist_browser__toggle_fold(browser))
+			break;
+		/* fall thru */
+	default:
+		return -1;
+	}
+
+	return 0;
+}
+
 int hist_browser__run(struct hist_browser *browser, const char *help,
-		      bool warn_lost_event)
+		      bool warn_lost_event, int key)
 {
-	int key;
 	char title[160];
 	struct hist_browser_timer *hbt = browser->hbt;
 	int delay_secs = hbt ? hbt->refresh : 0;
@@ -688,79 +759,14 @@ int hist_browser__run(struct hist_browser *browser, const char *help,
 	if (ui_browser__show(&browser->b, title, "%s", help) < 0)
 		return -1;
 
+	if (key && hist_browser__handle_hotkey(browser, warn_lost_event, title, key))
+		goto out;
+
 	while (1) {
 		key = ui_browser__run(&browser->b, delay_secs);
 
-		switch (key) {
-		case K_TIMER: {
-			u64 nr_entries;
-
-			WARN_ON_ONCE(!hbt);
-
-			if (hbt)
-				hbt->timer(hbt->arg);
-
-			if (hist_browser__has_filter(browser) ||
-			    symbol_conf.report_hierarchy)
-				hist_browser__update_nr_entries(browser);
-
-			nr_entries = hist_browser__nr_entries(browser);
-			ui_browser__update_nr_entries(&browser->b, nr_entries);
-
-			if (warn_lost_event &&
-			    (browser->hists->stats.nr_lost_warned !=
-			    browser->hists->stats.nr_events[PERF_RECORD_LOST])) {
-				browser->hists->stats.nr_lost_warned =
-					browser->hists->stats.nr_events[PERF_RECORD_LOST];
-				ui_browser__warn_lost_events(&browser->b);
-			}
-
-			hist_browser__title(browser, title, sizeof(title));
-			ui_browser__show_title(&browser->b, title);
-			continue;
-		}
-		case 'D': { /* Debug */
-			static int seq;
-			struct hist_entry *h = rb_entry(browser->b.top,
-							struct hist_entry, rb_node);
-			ui_helpline__pop();
-			ui_helpline__fpush("%d: nr_ent=(%d,%d), etl: %d, rows=%d, idx=%d, fve: idx=%d, row_off=%d, nrows=%d",
-					   seq++, browser->b.nr_entries,
-					   browser->hists->nr_entries,
-					   browser->b.extra_title_lines,
-					   browser->b.rows,
-					   browser->b.index,
-					   browser->b.top_idx,
-					   h->row_offset, h->nr_rows);
-		}
-			break;
-		case 'C':
-			/* Collapse the whole world. */
-			hist_browser__set_folding(browser, false);
-			break;
-		case 'c':
-			/* Collapse the selected entry. */
-			hist_browser__set_folding_selected(browser, false);
-			break;
-		case 'E':
-			/* Expand the whole world. */
-			hist_browser__set_folding(browser, true);
+		if (hist_browser__handle_hotkey(browser, warn_lost_event, title, key))
 			break;
-		case 'e':
-			/* Expand the selected entry. */
-			hist_browser__set_folding_selected(browser, true);
-			break;
-		case 'H':
-			browser->show_headers = !browser->show_headers;
-			hist_browser__update_rows(browser);
-			break;
-		case '+':
-			if (hist_browser__toggle_fold(browser))
-				break;
-			/* fall thru */
-		default:
-			goto out;
-		}
 	}
 out:
 	ui_browser__hide(&browser->b);
@@ -2994,8 +3000,7 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 
 		nr_options = 0;
 
-		key = hist_browser__run(browser, helpline,
-					warn_lost_event);
+		key = hist_browser__run(browser, helpline, warn_lost_event, 0);
 
 		if (browser->he_selection != NULL) {
 			thread = hist_browser__selected_thread(browser);
@@ -3573,7 +3578,7 @@ int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
 	memset(&action, 0, sizeof(action));
 
 	while (1) {
-		key = hist_browser__run(browser, "? - help", true);
+		key = hist_browser__run(browser, "? - help", true, 0);
 
 		switch (key) {
 		case 'q':
diff --git a/tools/perf/ui/browsers/hists.h b/tools/perf/ui/browsers/hists.h
index 078f2f2c7abd..1e938d9ffa5e 100644
--- a/tools/perf/ui/browsers/hists.h
+++ b/tools/perf/ui/browsers/hists.h
@@ -34,7 +34,7 @@ struct hist_browser {
 struct hist_browser *hist_browser__new(struct hists *hists);
 void hist_browser__delete(struct hist_browser *browser);
 int hist_browser__run(struct hist_browser *browser, const char *help,
-		      bool warn_lost_event);
+		      bool warn_lost_event, int key);
 void hist_browser__init(struct hist_browser *browser,
 			struct hists *hists);
 #endif /* _PERF_UI_BROWSER_HISTS_H_ */
