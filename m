From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 07/12] perf hists browser: Allow passing an initial hotkey
Date: Wed, 18 Dec 2019 11:08:31 -0300
Message-ID: <20191218140831.GC13395@kernel.org>
References: <20191217144828.2460-1-acme@kernel.org>
 <20191217144828.2460-8-acme@kernel.org>
 <20191218080818.GD19062@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191218080818.GD19062@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Dec 18, 2019 at 09:08:18AM +0100, Jiri Olsa escreveu:
> On Tue, Dec 17, 2019 at 11:48:23AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> SNIP
> 
> > diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> > index 6dfdd8d5a743..3b7af5a8d101 100644
> > --- a/tools/perf/ui/browsers/hists.c
> > +++ b/tools/perf/ui/browsers/hists.c
> > @@ -673,9 +673,8 @@ static int hist_browser__title(struct hist_browser *browser, char *bf, size_t si
> >  }
> >  
> >  int hist_browser__run(struct hist_browser *browser, const char *help,
> > -		      bool warn_lost_event)
> > +		      bool warn_lost_event, int key)
> >  {
> > -	int key;
> >  	char title[160];
> >  	struct hist_browser_timer *hbt = browser->hbt;
> >  	int delay_secs = hbt ? hbt->refresh : 0;
> > @@ -688,9 +687,12 @@ int hist_browser__run(struct hist_browser *browser, const char *help,
> >  	if (ui_browser__show(&browser->b, title, "%s", help) < 0)
> >  		return -1;
> >  
> > +	if (key)
> > +		goto do_hotkey;
> > +
> >  	while (1) {
> >  		key = ui_browser__run(&browser->b, delay_secs);
> > -
> > +do_hotkey:
> 
> or we could switch the 'swtich' and ui_browser__run, and get rid of the goto, like:
> 
> 	while (1) {
>   		switch (key) {
> 		...
> 		}
> 
> 		key = ui_browser__run(&browser->b, delay_secs);
> 	}

I think those are equivalent and having the test like I did is more
clear, i.e. "has this key been provided" instead of going to the switch
just to hit the default case for the zero in key and call
ui_browser__run().

- Arnaldo
 
> jirka
> 
> >  		switch (key) {
> >  		case K_TIMER: {
> >  			u64 nr_entries;
> > @@ -2994,8 +2996,7 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
> >  
> >  		nr_options = 0;
> >  
> > -		key = hist_browser__run(browser, helpline,
> > -					warn_lost_event);
> > +		key = hist_browser__run(browser, helpline, warn_lost_event, 0);
> >  
> >  		if (browser->he_selection != NULL) {
> >  			thread = hist_browser__selected_thread(browser);
> > @@ -3573,7 +3574,7 @@ int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
> >  	memset(&action, 0, sizeof(action));
> >  
> >  	while (1) {
> > -		key = hist_browser__run(browser, "? - help", true);
> > +		key = hist_browser__run(browser, "? - help", true, 0);
> >  
> >  		switch (key) {
> >  		case 'q':
> > diff --git a/tools/perf/ui/browsers/hists.h b/tools/perf/ui/browsers/hists.h
> > index 078f2f2c7abd..1e938d9ffa5e 100644
> > --- a/tools/perf/ui/browsers/hists.h
> > +++ b/tools/perf/ui/browsers/hists.h
> > @@ -34,7 +34,7 @@ struct hist_browser {
> >  struct hist_browser *hist_browser__new(struct hists *hists);
> >  void hist_browser__delete(struct hist_browser *browser);
> >  int hist_browser__run(struct hist_browser *browser, const char *help,
> > -		      bool warn_lost_event);
> > +		      bool warn_lost_event, int key);
> >  void hist_browser__init(struct hist_browser *browser,
> >  			struct hists *hists);
> >  #endif /* _PERF_UI_BROWSER_HISTS_H_ */
> > -- 
> > 2.21.0
> > 

-- 

- Arnaldo
