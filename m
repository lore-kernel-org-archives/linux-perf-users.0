From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Inlined functions in perf report
Date: Tue, 20 Dec 2016 10:54:50 -0300
Message-ID: <20161220135450.GA32756@kernel.org>
References: <20161220115954.GA35897@sesse.net>
 <20161220121755.GL3124@twins.programming.kicks-ass.net>
 <2027151.EnbG4A8ymx@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2027151.EnbG4A8ymx@milian-kdab2>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Steinar H. Gunderson" <sgunderson@bigfoot.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, "Liang, Kan" <kan.liang@intel.com>, "Jin, Yao" <yao.jin@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Dec 20, 2016 at 02:27:10PM +0100, Milian Wolff escreveu:
> On Tuesday, December 20, 2016 1:17:55 PM CET Peter Zijlstra wrote:
> > On Tue, Dec 20, 2016 at 12:59:54PM +0100, Steinar H. Gunderson wrote:
> > > FWIW, this is with perf from 4.10 (git as of a few days ago) and GCC
> > > 6.2.1.
> > 
> > OK, so it might be possible with: perf record -g --call-graph dwarf
> > but that's fairly heavy on the overhead, it will dump the top-of-stack
> > for each sample (8k default) and unwind using libunwind in userspace.
> 
> It is not even possible with that, perf report is lacking the steps required 
> to add inline frames - it will only add "real" frames it gets from either of 
> the unwind libraries.

Have you guys looked at this:

http://lkml.kernel.org/r/1481121822-2537-1-git-send-email-yao.jin@linux.intel.com

I have to review it and maybe you will help me with that ;-)

I've CCed Jin Yao, the author of this series.

- Arnaldo
 
> I have a WIP patch available for this functionality though, it can be found 
> here (depends on libbfd, i.e. bfd_find_inliner_info):
> 
> https://github.com/milianw/linux/commit/
> 71d031c9d679bfb4a4044226e8903dd80ea601b3
> 
> This is not yet upstreamable, but any early comments would be welcome. I hope 
> to get some more time to drive this in the coming weeks. If you want to test 
> it out, checkout my milian/perf branch of this repo, build it like you'd do 
> the normal user-space perf, then run
> 
> perf report -g srcline -s sym,srcline
> 
> > The default mechanism used for call-graphs is frame-pointers which are
> > (relatively) simple and fast to traverse from kernel space. The down
> > side is of course that all your userspace needs to be compiled with
> > frame pointers enabled and inlined functions, as you noticed, are
> > 'lost'.
> > 
> > There has been talk to attempt to utilize the ELF EH frames which are
> > mandatory in the x86_64 ABI (even for C) to attempt a kernel based
> > 'DWARF' unwind, but nobody has put forward working code for this yet.
> > Also, even if the EH stuff is mapped at runtime, it doesn't mean the
> > pages will actually be loaded (due to demand paging) and available for
> > use, which also will limit usability. (perf sampling is using
> > interrupt/NMI context and we cannot page from that, so we're limited to
> > memory that's present.)
> 
> While all of this would be nice to have, it is not directly related to 
> inlining from what I gathered.
> 
> Bye
> 
> -- 
> Milian Wolff | milian.wolff@kdab.com | Software Engineer
> KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt Experts
