From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Date: Tue, 5 May 2020 13:37:45 -0300
Message-ID: <20200505163745.GD3777@redhat.com>
References: <20200420115316.18781-1-acme@kernel.org>
 <20200422120943.GA110748@gmail.com>
 <CAEUSe7_wmKS361mKLTB1eYbzYXcKkXdU26BX5BojdKRz8MfPCw@mail.gmail.com>
 <20200424130722.GK19437@kernel.org>
 <0f6403ec-36cd-f43f-b3a6-b87e628f3789@redhat.com>
 <CAEUSe7_Ybp=7XC-2xMSEGYmCHvEMff0YbZq1f6akvxLVcS_ePA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEUSe7_Ybp=7XC-2xMSEGYmCHvEMff0YbZq1f6akvxLVcS_ePA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc: Andreas Gerstmayr <agerstmayr@redhat.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, open list <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, He Zhe <zhe.he@windriver.com>, Ian Rogers <irogers@google.com>, Kajol Jain <kjain@linux.ibm.com>, Kan Liang <kan.liang@linux.intel.com>, Konstantin Kharlamov <hi-angel@yandex.ru>, Stephane Eranian <eranian@google.com>, Thomas Richter <tmricht@linux.ibm.com>, lkft-triage@lists.linaro.org
List-Id: linux-perf-users.vger.kernel.org

Em Mon, May 04, 2020 at 02:07:56PM -0500, Daniel Díaz escreveu:
> Hello!
> 
> On Fri, 24 Apr 2020 at 09:10, Andreas Gerstmayr <agerstmayr@redhat.com> wrote:
> >
> > On 24.04.20 15:07, Arnaldo Carvalho de Melo wrote:
> > > Em Thu, Apr 23, 2020 at 04:28:46PM -0500, Daniel Díaz escreveu:
> > >> On Wed, 22 Apr 2020 at 07:09, Ingo Molnar <mingo@kernel.org> wrote:
> > >>>>   85 files changed, 1851 insertions(+), 513 deletions(-)
> > >
> > >>> Pulled, thanks a lot Arnaldo!
> > >
> > >> Our OpenEmbedded builds detected an issue with 5287f9269206 ("perf
> > >> script: Add flamegraph.py script"):
> > >>    ERROR: perf-1.0-r9 do_package_qa: QA Issue:
> > >> /usr/libexec/perf-core/scripts/python/bin/flamegraph-report contained
> > >> in package perf-python requires /usr/bin/sh, but no providers found in
> > >> RDEPENDS_perf-python? [file-rdeps]
> > >
> > >
> > > yeah, the flamegraph scripts are the outliers, there, everything else is
> > > using /bin/bash, so I'll switch to that, ok Andreas?
> >
> > Sure, no problem. Thanks!
> 
> Just a gentle reminder that this can still be fixed in today's
> linux-next tree (next-20200504).

Thanks for the reminder, I've just added this to my tree:

commit c74ab13a30d3bec443c116e25b611255c58f32c0
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Tue May 5 13:33:12 2020 -0300

    perf flamegraph: Use /bin/bash for report script
    
    As all the other tools/perf/scripts/python/bin/*-report scripts, fixing
    the this problem reported by Daniel Diaz:
    
      Our OpenEmbedded builds detected an issue with 5287f9269206 ("perf
      script: Add flamegraph.py script"):
        ERROR: perf-1.0-r9 do_package_qa: QA Issue:
      /usr/libexec/perf-core/scripts/python/bin/flamegraph-report contained
      in package perf-python requires /usr/bin/sh, but no providers found in
      RDEPENDS_perf-python? [file-rdeps]
    
      This means that there is a new binary pulled in in the shebang line
      which was unaccounted for: `/usr/bin/sh`. I don't see any other usage
      of /usr/bin/sh in the kernel tree (does not even exist on my Ubuntu
      dev machine) but plenty of /bin/sh. This patch is needed:
      -----8<----------8<----------8<-----
      diff --git a/tools/perf/scripts/python/bin/flamegraph-record
      b/tools/perf/scripts/python/bin/flamegraph-record
      index 725d66e71570..a2f3fa25ef81 100755
      --- a/tools/perf/scripts/python/bin/flamegraph-record
      +++ b/tools/perf/scripts/python/bin/flamegraph-record
      @@ -1,2 +1,2 @@
      -#!/usr/bin/sh
      +#!/bin/sh
       perf record -g "$@"
      diff --git a/tools/perf/scripts/python/bin/flamegraph-report
      b/tools/perf/scripts/python/bin/flamegraph-report
      index b1a79afd903b..b0177355619b 100755
      --- a/tools/perf/scripts/python/bin/flamegraph-report
      +++ b/tools/perf/scripts/python/bin/flamegraph-report
      @@ -1,3 +1,3 @@
      -#!/usr/bin/sh
      +#!/bin/sh
       # description: create flame graphs
       perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
      ----->8---------->8---------->8-----
    
    Fixes: 5287f9269206 ("perf script: Add flamegraph.py script")
    Reported-by: Daniel Díaz <daniel.diaz@linaro.org>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Andreas Gerstmayr <agerstmayr@redhat.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: lkft-triage@lists.linaro.org
    Cc: Namhyung Kim <namhyung@kernel.org>
    Link: http://lore.kernel.org/lkml/CAEUSe7_wmKS361mKLTB1eYbzYXcKkXdU26BX5BojdKRz8MfPCw@mail.gmail.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/scripts/python/bin/flamegraph-report b/tools/perf/scripts/python/bin/flamegraph-report
index b1a79afd903b..53c5dc90c87e 100755
--- a/tools/perf/scripts/python/bin/flamegraph-report
+++ b/tools/perf/scripts/python/bin/flamegraph-report
@@ -1,3 +1,3 @@
-#!/usr/bin/sh
+#!/bin/bash
 # description: create flame graphs
 perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
