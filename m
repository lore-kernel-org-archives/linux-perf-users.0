From: =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Date: Thu, 23 Apr 2020 16:28:46 -0500
Message-ID: <CAEUSe7_wmKS361mKLTB1eYbzYXcKkXdU26BX5BojdKRz8MfPCw@mail.gmail.com>
References: <20200420115316.18781-1-acme@kernel.org> <20200422120943.GA110748@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200422120943.GA110748@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, open list <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andreas Gerstmayr <agerstmayr@redhat.com>, He Zhe <zhe.he@windriver.com>, Ian Rogers <irogers@google.com>, Kajol Jain <kjain@linux.ibm.com>, Kan Liang <kan.liang@linux.intel.com>, Konstantin Kharlamov <hi-angel@yandex.ru>, Stephane Eranian <eranian@google.com>, Thomas Richter <tmricht@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, lkft-triage@lists.linaro.org
List-Id: linux-perf-users.vger.kernel.org

Hello!

On Wed, 22 Apr 2020 at 07:09, Ingo Molnar <mingo@kernel.org> wrote:
> * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> > Hi Ingo/Thomas,
> >
> >       Please consider pulling,
> >
> > Best regards,
> >
> > - Arnaldo
> >
> > Test results at the end of this message, as usual.
> >
> > The following changes since commit cd0943357bc7570f081701d005318c209821=
78b8:
> >
> >   Merge tag 'perf-urgent-for-mingo-5.7-20200414' of git://git.kernel.or=
g/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2020-04-16 10:21:31=
 +0200)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/per=
f-core-for-mingo-5.8-20200420
> >
> > for you to fetch changes up to 12e89e65f446476951f42aedeef56b6bd6f7f1e6=
:
> >
> >   perf hist: Add fast path for duplicate entries check (2020-04-18 09:0=
5:01 -0300)
>
> >  85 files changed, 1851 insertions(+), 513 deletions(-)
>
> Pulled, thanks a lot Arnaldo!

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

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
