From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 07/12] perf hists browser: Allow passing an initial hotkey
Date: Wed, 18 Dec 2019 15:23:21 +0100
Message-ID: <20191218142321.GB15571@krava>
References: <20191217144828.2460-1-acme@kernel.org>
 <20191217144828.2460-8-acme@kernel.org>
 <20191218080818.GD19062@krava>
 <20191218140831.GC13395@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191218140831.GC13395@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Dec 18, 2019 at 11:08:31AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Dec 18, 2019 at 09:08:18AM +0100, Jiri Olsa escreveu:
> > On Tue, Dec 17, 2019 at 11:48:23AM -0300, Arnaldo Carvalho de Melo wrote:
> > 
> > SNIP
> > 
> > > diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> > > index 6dfdd8d5a743..3b7af5a8d101 100644
> > > --- a/tools/perf/ui/browsers/hists.c
> > > +++ b/tools/perf/ui/browsers/hists.c
> > > @@ -673,9 +673,8 @@ static int hist_browser__title(struct hist_browser *browser, char *bf, size_t si
> > >  }
> > >  
> > >  int hist_browser__run(struct hist_browser *browser, const char *help,
> > > -		      bool warn_lost_event)
> > > +		      bool warn_lost_event, int key)
> > >  {
> > > -	int key;
> > >  	char title[160];
> > >  	struct hist_browser_timer *hbt = browser->hbt;
> > >  	int delay_secs = hbt ? hbt->refresh : 0;
> > > @@ -688,9 +687,12 @@ int hist_browser__run(struct hist_browser *browser, const char *help,
> > >  	if (ui_browser__show(&browser->b, title, "%s", help) < 0)
> > >  		return -1;
> > >  
> > > +	if (key)
> > > +		goto do_hotkey;
> > > +
> > >  	while (1) {
> > >  		key = ui_browser__run(&browser->b, delay_secs);
> > > -
> > > +do_hotkey:
> > 
> > or we could switch the 'swtich' and ui_browser__run, and get rid of the goto, like:
> > 
> > 	while (1) {
> >   		switch (key) {
> > 		...
> > 		}
> > 
> > 		key = ui_browser__run(&browser->b, delay_secs);
> > 	}
> 
> I think those are equivalent and having the test like I did is more
> clear, i.e. "has this key been provided" instead of going to the switch
> just to hit the default case for the zero in key and call
> ui_browser__run().

sure, I just don't like goto other than for error handling,
looks too hacky to me ;-) but of course it's your call

jirka
