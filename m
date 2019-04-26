From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] perf/report: Report OOM in perf report status line
Date: Fri, 26 Apr 2019 11:10:32 -0300
Message-ID: <20190426141032.GA23426@kernel.org>
References: <20190423105303.61683-1-tmricht@linux.ibm.com>
 <20190426140907.GB22086@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190426140907.GB22086@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, jolsa@redhat.com
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Apr 26, 2019 at 11:09:07AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Apr 23, 2019 at 12:53:03PM +0200, Thomas Richter escreveu:
> > An -ENOMEM error is not reported in the GTK GUI.
> > Instead this error message pops up on the screen:
> > 
> > [root@m35lp76 perf]# ./perf  report -i perf.data.error68-1
> > 
> > 	Processing events... [974K/3M]
> > 	Error:failed to process sample
> > 
> > 	0xf4198 [0x8]: failed to process type: 68
> 
> Thanks, applied to perf/urgent.

Well, I tried to, now trying to fix this...


[acme@quaco perf]$ m
make: Entering directory '/home/acme/git/perf/tools/perf'
  BUILD:   Doing 'make -j8' parallel build
  INSTALL  GTK UI
  INSTALL  trace_plugins
  CC       /tmp/build/perf/util/session.o
util/session.c: In function ‘perf_session__process_events’:
util/session.c:1936:7: error: ‘skip’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
   err = skip;
   ~~~~^~~~~~
util/session.c:1874:6: note: ‘skip’ was declared here
  s64 skip;
      ^~~~
cc1: all warnings being treated as errors
mv: cannot stat '/tmp/build/perf/util/.session.o.tmp': No such file or directory
make[4]: *** [/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/session.o] Error 1
make[3]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
make[2]: *** [Makefile.perf:559: /tmp/build/perf/perf-in.o] Error 2
make[1]: *** [Makefile.perf:215: sub-make] Error 2
make: *** [Makefile:110: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf/tools/perf'

 Performance counter stats for 'make -k O=/tmp/build/perf -C tools/perf install-bin':

     4,913,757,758      cycles:u
     7,432,572,002      instructions:u            #    1.51  insn per cycle

       1.345541349 seconds time elapsed

       1.412713000 seconds user
       0.572540000 seconds sys


[acme@quaco perf]$
