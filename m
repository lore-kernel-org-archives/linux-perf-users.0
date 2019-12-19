From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 07/12] perf hists browser: Allow passing an initial hotkey
Date: Thu, 19 Dec 2019 22:44:24 +0100
Message-ID: <20191219214424.GB27481@krava>
References: <20191217144828.2460-1-acme@kernel.org>
 <20191217144828.2460-8-acme@kernel.org>
 <20191218080818.GD19062@krava>
 <20191218140831.GC13395@kernel.org>
 <20191218142321.GB15571@krava>
 <20191219172642.GB13699@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191219172642.GB13699@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Dec 19, 2019 at 02:26:42PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Dec 18, 2019 at 03:23:21PM +0100, Jiri Olsa escreveu:
> > On Wed, Dec 18, 2019 at 11:08:31AM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Wed, Dec 18, 2019 at 09:08:18AM +0100, Jiri Olsa escreveu:
> > > > On Tue, Dec 17, 2019 at 11:48:23AM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > +	if (key)
> > > > > +		goto do_hotkey;
> > > > > +
> > > > >  	while (1) {
> > > > >  		key = ui_browser__run(&browser->b, delay_secs);
> > > > > -
> > > > > +do_hotkey:
> 
> > > > or we could switch the 'swtich' and ui_browser__run, and get rid of the goto, like:
> 
> > > > 	while (1) {
> > > >   		switch (key) {
> > > > 		...
> > > > 		}
> > > > 
> > > > 		key = ui_browser__run(&browser->b, delay_secs);
> > > > 	}
> 
> > > I think those are equivalent and having the test like I did is more
> > > clear, i.e. "has this key been provided" instead of going to the switch
> > > just to hit the default case for the zero in key and call
> > > ui_browser__run().
> 
> > sure, I just don't like goto other than for error handling,
> > looks too hacky to me ;-) but of course it's your call
> 
> How about the one below?

looks good, thanks

jirka
