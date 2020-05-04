From: =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Date: Mon, 4 May 2020 14:07:56 -0500
Message-ID: <CAEUSe7_Ybp=7XC-2xMSEGYmCHvEMff0YbZq1f6akvxLVcS_ePA@mail.gmail.com>
References: <20200420115316.18781-1-acme@kernel.org> <20200422120943.GA110748@gmail.com>
 <CAEUSe7_wmKS361mKLTB1eYbzYXcKkXdU26BX5BojdKRz8MfPCw@mail.gmail.com>
 <20200424130722.GK19437@kernel.org> <0f6403ec-36cd-f43f-b3a6-b87e628f3789@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0f6403ec-36cd-f43f-b3a6-b87e628f3789@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Gerstmayr <agerstmayr@redhat.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, open list <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, He Zhe <zhe.he@windriver.com>, Ian Rogers <irogers@google.com>, Kajol Jain <kjain@linux.ibm.com>, Kan Liang <kan.liang@linux.intel.com>, Konstantin Kharlamov <hi-angel@yandex.ru>, Stephane Eranian <eranian@google.com>, Thomas Richter <tmricht@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, lkft-triage@lists.linaro.org
List-Id: linux-perf-users.vger.kernel.org

Hello!

On Fri, 24 Apr 2020 at 09:10, Andreas Gerstmayr <agerstmayr@redhat.com> wro=
te:
>
> On 24.04.20 15:07, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Apr 23, 2020 at 04:28:46PM -0500, Daniel D=C3=ADaz escreveu:
> >> On Wed, 22 Apr 2020 at 07:09, Ingo Molnar <mingo@kernel.org> wrote:
> >>>>   85 files changed, 1851 insertions(+), 513 deletions(-)
> >
> >>> Pulled, thanks a lot Arnaldo!
> >
> >> Our OpenEmbedded builds detected an issue with 5287f9269206 ("perf
> >> script: Add flamegraph.py script"):
> >>    ERROR: perf-1.0-r9 do_package_qa: QA Issue:
> >> /usr/libexec/perf-core/scripts/python/bin/flamegraph-report contained
> >> in package perf-python requires /usr/bin/sh, but no providers found in
> >> RDEPENDS_perf-python? [file-rdeps]
> >
> >
> > yeah, the flamegraph scripts are the outliers, there, everything else i=
s
> > using /bin/bash, so I'll switch to that, ok Andreas?
>
> Sure, no problem. Thanks!

Just a gentle reminder that this can still be fixed in today's
linux-next tree (next-20200504).

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
