From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v4 2/2] perf stat: Add support to print counts after a
 period of time
Date: Fri, 16 Feb 2018 10:18:15 -0300
Message-ID: <20180216131815.GB24436@kernel.org>
References: <1517217923-8302-1-git-send-email-ufo19890607@gmail.com>
 <1517217923-8302-3-git-send-email-ufo19890607@gmail.com>
 <20180215133921.GC22818@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180215133921.GC22818@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ufo19890607 <ufo19890607@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, adrian.hunter@intel.com, wangnan0@huawei.com, Kan.liang@intel.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Feb 15, 2018 at 10:39:21AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Jan 29, 2018 at 10:25:23AM +0100, ufo19890607 escreveu:
> > From: yuzhoujian <yuzhoujian@didichuxing.com>
> > 
> > Introduce a new option to print counts after N milliseconds
> 
> This doesn't just print counts after N ms, it _stops_ the workload after
> that time _and_ prints the counts, right?
> 
> Can you please send a followup patch fixing the description and
> documentation?
> 
> I've applied this already, but clarifying what this option does is in
> demand.

So, this fails to build on centos:5 and centos:6 and similar systems
where the use of 'time' for a variable name breaks the build:

  CC       /tmp/build/perf/builtin-stat.o
cc1: warnings being treated as errors
builtin-stat.c: In function '__run_perf_stat':
builtin-stat.c:576: warning: declaration of 'time' shadows a global declaration
/usr/include/time.h:187: warning: shadowed declaration is here
builtin-stat.c: In function 'cmd_stat':
builtin-stat.c:2710: warning: declaration of 'time' shadows a global declaration
/usr/include/time.h:187: warning: shadowed declaration is here
mv: cannot stat `/tmp/build/perf/.builtin-stat.o.tmp': No such file or directory
make[3]: *** [/tmp/build/perf/builtin-stat.o] Error 1
make[3]: *** Waiting for unfinished jobs....
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/evsel_fprintf.o
make[2]: *** [/tmp/build/perf/perf-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....

So since I had to rename that I replaced it with 'timeout', so that it
gets clear that when you specify this option you are setting a timeout
period that if hit will stop the 'perf stat' session and then print the
specified counters.

Please let us know if you have any strong objection to this,

- Arnaldo
