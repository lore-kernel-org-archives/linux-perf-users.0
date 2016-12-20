From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: Inlined functions in perf report
Date: Tue, 20 Dec 2016 14:43:41 +0100
Message-ID: <20161220134341.GA4183@sesse.net>
References: <20161220115954.GA35897@sesse.net>
 <20161220121755.GL3124@twins.programming.kicks-ass.net>
 <2027151.EnbG4A8ymx@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2027151.EnbG4A8ymx@milian-kdab2>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Tue, Dec 20, 2016 at 02:27:10PM +0100, Milian Wolff wrote:
> It is not even possible with that, perf report is lacking the steps required 
> to add inline frames - it will only add "real" frames it gets from either of 
> the unwind libraries.
> 
> I have a WIP patch available for this functionality though, it can be found 
> here (depends on libbfd, i.e. bfd_find_inliner_info):
> 
> https://github.com/milianw/linux/commit/
> 71d031c9d679bfb4a4044226e8903dd80ea601b3

Thanks, I'll be sure to try it out. I assume this works only with -g dwarf?
I.e., for non-graph runs, I will still get the bottom function only, not the
inlined one.

/* Steinar */
-- 
Homepage: https://www.sesse.net/
