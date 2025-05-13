Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7422B28C873
	for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 19:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747163259; cv=none; b=iuPr1An/79mkjfcIZoRtPNpgLxwXtz/PpfAQA5fRjLOFnlreGb7OXwhu30yNHoom8hF8md8pRrGzU2T+iHx7A0YiETk3MaKDdHaTWhSRrxPDrrsM99Lw5xgqxdw5Vi8Ea286p1pxrkJKxqxzwvB/HSLPoge3moWIDv88FpOdqQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747163259; c=relaxed/simple;
	bh=BfIIdAmYgagg8bgmfKPMbA/yNS8HDi+q7tLjHe0l8yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZRygLcDDDMrp9bDbNlBjJKkr61eCnauGVtS+Ge7ijiNld9hcBYA8RX6OQqU6CKcykFTqJAl0cUwTjo3O/li285OhZUkP4WAeXLeT4HNgexrAL+EoS1GxJaQSCVP+GdKJLPyBd9sMEkOHt8Bqr2TB17S6EXjuIkrqdp1DabSbLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D8KHP6Rm; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D8KHP6Rm"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22fa47f295dso31965ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 12:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747163256; x=1747768056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEL74c2SOBaH5lHHG44gJaQWn8jnoJ1Naxq4P6yhI70=;
        b=D8KHP6RmzaIqO48wRKqFYB9BwWFrkilj62soDrrPMH2hCH1nJK8BchOncTkHEu8/jd
         Z1AF6eNhYwlrMfyatLy/A7MTmTHqFFtad9vMQbqUf6/JXxcrAafrNhGww6UJwepjABf2
         3ynraTBWsrTHUdAknrBFBOYs5wUsUW9i8Mr5T6hyKzSfDZPL+zvRzV/guGb+0OwFEM9e
         WU0Hc3zPHvtw973WThutQAHdMAbyZk+dCnD+jzQqSaVR2DxmYL95nsBpFD3lSybBU+qh
         TQFO+EbaYnfx/zBMhOwSyIFF9AdrCTUN62ZD9XQzO0ENMzYwqZLqyBtLXVunrTbXMt2D
         tdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747163256; x=1747768056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEL74c2SOBaH5lHHG44gJaQWn8jnoJ1Naxq4P6yhI70=;
        b=TmaKssroMvr2B//xXGKT0scFh2y2hEtMvZALxn9z+4EXwvktU4SMFmdtzopYoji1JV
         m+RDVHzvt/l5ty+frmqJtVZB76oiTcSLA2UT7tXtapJf5cDwsVQ2ayt+Pi9uyBX/X9Gv
         K0jnmww2JNLiOEsxdoo9H6KifZFJ0pJbN5kz3lZ9kz7a2x+q4A6WXsJ9mUhqbC3LSJfl
         f8cbsfpCirOAvgCzx4LY3k3iB2DOhLjwROHXNu80EJGCEHZjtbYq1UsGMUvttmn/lSjW
         OXU0gp4tq239IBTtVioKEDtQf+MWoSbw18GtjR1JHUS+YY1aq2vsVd7BC+uwrWuu3Zc1
         HPrw==
X-Forwarded-Encrypted: i=1; AJvYcCW1EO6vit/dYM2nhqZRkj7SsvmQ8Pkx+pXfPcLiCLXI4sAy9kvFFQueB0vDpv9NcKe7yO7VoL93dd+jb3L15gOq@vger.kernel.org
X-Gm-Message-State: AOJu0YziAZyPJBFZVxiQWzRa3nx6YSp9tCPJQA3AEvQ2XDwFxSZxbtvX
	UUaDfvms5UAkcAJkiRC7PalX2+FO9gBY5amxHwp+OM/XespBHw7f1bwpSdvYzM70JyzfnKzL+jy
	w9e9lVAPvOQRf5/X+HRJX14OEawUIOon+q3cFvCwf
X-Gm-Gg: ASbGncvw8NUlXvK6Kgq5KHKoiv7IvLLxy/QIRrQ5yEHv/VZeNjVlZJWrfDnzcNBPqLF
	CGnQ3vi8iIsHTRwzAXMwccsvhuMxyxjSIDiwrzumwwBUGFfaTpRQnNsQsMlh61nykGk3CazK3D1
	MVsn362ItfZUx5vvgi581f5/FWPqFemcjfbgN9pmFLlCWR4yBF6NUTOt0wWqJK
X-Google-Smtp-Source: AGHT+IFwdsPT6+6RkvJxXLy3zo+LPCFyRXTUHWRP+m7DkI1VtSOnHZRCHu1WV9UtnVz/sCV1SdFwGbfGlIKW4ECRDNg=
X-Received: by 2002:a17:903:244a:b0:224:6c8:8d84 with SMTP id
 d9443c01a7336-2319906cfb6mr449655ad.4.1747163256295; Tue, 13 May 2025
 12:07:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512184700.11691-1-irogers@google.com> <20250512184700.11691-2-irogers@google.com>
 <108f87fc28453adb52d6b8c2afd8d184e288a83e.camel@intel.com>
 <CAP-5=fVaC662z2nJnTwBHMu-RE+9HkRmvSyNT5qB448+zw6e9Q@mail.gmail.com> <CAP-5=fW5gap1OOFiEq6Lrc500rDPx=h5UNwOF8mEg2LOgfBsew@mail.gmail.com>
In-Reply-To: <CAP-5=fW5gap1OOFiEq6Lrc500rDPx=h5UNwOF8mEg2LOgfBsew@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 May 2025 12:07:24 -0700
X-Gm-Features: AX0GCFscnAabIE4jY1VGOomuoUWx0fFM4LdVeYZd19rTeRAhgOJVom0cEP2gKDs
Message-ID: <CAP-5=fXr4bydqx5vXdFkJW99Asa3+Bzhk8AWnQc9_g8pywDaTg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf test: Hybrid improvements for metric value
 validation test
To: "Falcon, Thomas" <thomas.falcon@intel.com>, "Wang, Weilin" <weilin.wang@intel.com>, 
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, Stephane Eranian <eranian@google.com>
Cc: "james.clark@linaro.org" <james.clark@linaro.org>, 
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, "Hunter, Adrian" <adrian.hunter@intel.com>, 
	"acme@kernel.org" <acme@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>, 
	"jolsa@kernel.org" <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 10:26=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Mon, May 12, 2025 at 2:52=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Mon, May 12, 2025 at 1:30=E2=80=AFPM Falcon, Thomas <thomas.falcon@i=
ntel.com> wrote:
> > >
> > > On Mon, 2025-05-12 at 11:47 -0700, Ian Rogers wrote:
> > > > On my alderlake I currently see for the "perf metrics value validat=
ion" test:
> > > > ```
> > > > Total Test Count:  142
> > > > Passed Test Count:  139
> > > > [
> > > > Metric Relationship Error:      The collected value of metric ['tma=
_fetch_latency', 'tma_fetch_bandwidth', 'tma_frontend_bound']
> > > >                         is [31.137028] in workload(s): ['perf bench=
 futex hash -r 2 -s']
> > > >                         but expected value range is [tma_frontend_b=
ound, tma_frontend_bound]
> > > >                         Relationship rule description: 'Sum of the =
level 2 children should equal level 1 parent',
> > > > Metric Relationship Error:      The collected value of metric ['tma=
_memory_bound', 'tma_core_bound', 'tma_backend_bound']
> > > >                         is [6.564442] in workload(s): ['perf bench =
futex hash -r 2 -s']
> > > >                         but expected value range is [tma_backend_bo=
und, tma_backend_bound]
> > > >                         Relationship rule description: 'Sum of the =
level 2 children should equal level 1 parent',
> > > > Metric Relationship Error:      The collected value of metric ['tma=
_light_operations', 'tma_heavy_operations', 'tma_retiring']
> > > >                         is [57.806179] in workload(s): ['perf bench=
 futex hash -r 2 -s']
> > > >                         but expected value range is [tma_retiring, =
tma_retiring]
> > > >                         Relationship rule description: 'Sum of the =
level 2 children should equal level 1 parent']
> > > > Metric validation return with erros. Please check metrics reported =
with errors.
> > > > ```
> > > > I suspect it is due to two metrics for different CPU types being
> > > > enabled. Add a -cputype option to avoid this. The test still fails =
with:
> > > > ```
> > > > Total Test Count:  115
> > > > Passed Test Count:  114
> > > > [
> > > > Wrong Metric Value Error:       The collected value of metric ['tma=
_l2_hit_latency']
> > > >                         is [117.947088] in workload(s): ['perf benc=
h futex hash -r 2 -s']
> > > >                         but expected value range is [0, 100]]
> > > > Metric validation return with errors. Please check metrics reported=
 with errors.
> > > > ```
> > > > which is a reproducible genuine error and likely requires a metric =
fix.
> > >
> > > Hi Ian, I tested this on my alder lake and an arrow lake. All tests, =
including tma_l2_hit_latency,
> > > pass on my end.
> > >
> > > Tested-by: Thomas Falcon <thomas.falcon@intel.com>
> >
> > Thanks Thomas! It should also work for core_lowpower on ArrowLake. I
> > find some times that tma_l2_hit_latency passes for me. Trying a few
> > more times I see other failures, but they all seem to be "No Metric
> > Value Error" - perhaps these shouldn't fail the test. In the testing
> > code we're passing '-a' for system wide profiling:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/tests/shell/lib/perf_metric_validation.py?h=3Dperf-to=
ols-next#n380
> > I believe this is done so that counters for things like AVX will
> > gather values. I wonder if the tma_l2_hit_latency something is
> > happening due to scaling counts:
> > ```
> > $ sudo /tmp/perf/perf stat -M tma_l2_hit_latency -a sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> >      7,987,903,325      cpu_core/TOPDOWN.SLOTS/          #    210.2 %
> > tma_l2_hit_latency       (87.27%)
> >      3,131,119,398      cpu_core/topdown-retiring/
> >                          (87.27%)
> >      1,910,718,811      cpu_core/topdown-mem-bound/
> >                          (87.27%)
> >        481,456,610      cpu_core/topdown-bad-spec/
> >                          (87.27%)
> >      1,681,347,944      cpu_core/topdown-fe-bound/
> >                          (87.27%)
> >      2,798,109,902      cpu_core/topdown-be-bound/
> >                          (87.27%)
> >        365,736,554      cpu_core/MEMORY_ACTIVITY.STALLS_L1D_MISS/
> >                                   (87.27%)
> >        327,668,588      cpu_core/MEMORY_ACTIVITY.STALLS_L2_MISS/
> >                                  (87.30%)
> >         12,744,464      cpu_core/MEM_LOAD_RETIRED.L1_MISS/
> >                            (75.32%)
> >      1,403,250,041      cpu_core/CPU_CLK_UNHALTED.THREAD/
> >                           (87.65%)
> >          6,657,480      cpu_core/MEM_LOAD_RETIRED.L2_HIT/
> >                           (87.66%)
> >     59,424,499,192      TSC
> >         40,830,608      cpu_core/MEM_LOAD_RETIRED.FB_HIT/
> >                           (62.46%)
> >      1,461,544,380      cpu_core/CPU_CLK_UNHALTED.REF_TSC/
> >                            (74.79%)
> >      1,008,604,319      duration_time
> >
> >        1.004974560 seconds time elapsed
> > ```
> > The values in the parentheses is a scaling amount which should mean
> > for event multiplexing but for hybrid the events aren't running when
> > on the other core type, so we're seeing these odd multiplexing values
> > and these are used to scale counts:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/lib/perf/evsel.c?h=3Dperf-tools-next#n599
> > I find when I run a benchmark rather than "sleep" the issue seems
> > harder to reproduce.
>
> Ok chatting with Weilin and actually paying attention to warning
> messages I think I see a problem. TSC (msr/tsc/) is aggregating data
> across all CPUs (it is a software event and is a different performance
> monitoring unit to cpu_core) while the counters are only on cpu_core.
> So I think this means the TSC value is too large. However, even with
> restricting the CPUs I see the >100% problem:
> ```
> $ perf stat -M tma_l2_hit_latency -C 0-15 -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>     27,985,670,146      cpu_core/TOPDOWN.SLOTS/          #    125.6 %
> tma_l2_hit_latency       (87.22%)
>      9,619,906,383      cpu_core/topdown-retiring/
>                          (87.22%)
>      2,333,124,385      cpu_core/topdown-mem-bound/
>                          (87.22%)
>      3,607,656,674      cpu_core/topdown-bad-spec/
>                          (87.22%)
>      9,839,779,867      cpu_core/topdown-fe-bound/
>                          (87.22%)
>      5,244,189,749      cpu_core/topdown-be-bound/
>                          (87.22%)
>        442,932,231      cpu_core/MEMORY_ACTIVITY.STALLS_L1D_MISS/
>                                   (87.24%)
>        360,126,840      cpu_core/MEMORY_ACTIVITY.STALLS_L2_MISS/
>                                  (87.63%)
>         31,264,814      cpu_core/MEM_LOAD_RETIRED.L1_MISS/
>                            (75.26%)
>      4,761,244,040      cpu_core/CPU_CLK_UNHALTED.THREAD/
>                           (87.63%)
>         28,429,277      cpu_core/MEM_LOAD_RETIRED.L2_HIT/
>                           (87.62%)
>     33,863,490,835      TSC
>         23,533,366      cpu_core/MEM_LOAD_RETIRED.FB_HIT/
>                           (62.25%)
>      3,158,155,632      cpu_core/CPU_CLK_UNHALTED.REF_TSC/
>                            (74.63%)
>      1,003,102,327      duration_time
>
>        1.001912038 seconds time elapsed
> ```
> So we still need to figure this one out. The multiplexing numbers
> still worry me.

So I think the TSC bug is genuine, perhaps Kan has thoughts on how to
restrict the cpu mask to just the core cpus. The tma_l2_hit_latency
>100% bug appears to be global. I see the problem on a tigerlake:
```
$ perf stat --metric-no-threshold -M tma_l2_hit_latency -a sleep 1

Performance counter stats for 'system wide':

       46,745,378      MEM_LOAD_RETIRED.FB_HIT          #    105.8 %
tma_l2_hit_latency
    1,445,788,955      CPU_CLK_UNHALTED.REF_TSC
    2,532,066,403      CPU_CLK_UNHALTED.THREAD
   40,008,507,350      TSC
       11,922,390      MEM_LOAD_RETIRED.L1_MISS
        2,587,517      MEM_LOAD_RETIRED.L2_HIT
    1,002,819,485      duration_time

      1.002198593 seconds time elapsed
```
Anyway, I think this patch series should land and we can worry about
this metric and the hybrid problems separately.

Thanks,
Ian

> >
> > > Thanks,
> > > Tom
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  .../tests/shell/lib/perf_metric_validation.py   | 12 +++++++++---
> > > >  tools/perf/tests/shell/stat_metrics_values.sh   | 17 +++++++++++--=
----
> > > >  2 files changed, 20 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/tools/perf/tests/shell/lib/perf_metric_validation.py b=
/tools/perf/tests/shell/lib/perf_metric_validation.py
> > > > index 0b94216c9c46..dea8ef1977bf 100644
> > > > --- a/tools/perf/tests/shell/lib/perf_metric_validation.py
> > > > +++ b/tools/perf/tests/shell/lib/perf_metric_validation.py
> > > > @@ -35,7 +35,8 @@ class TestError:
> > > >
> > > >
> > > >  class Validator:
> > > > -    def __init__(self, rulefname, reportfname=3D'', t=3D5, debug=
=3DFalse, datafname=3D'', fullrulefname=3D'', workload=3D'true', metrics=3D=
''):
> > > > +    def __init__(self, rulefname, reportfname=3D'', t=3D5, debug=
=3DFalse, datafname=3D'', fullrulefname=3D'',
> > > > +                 workload=3D'true', metrics=3D'', cputype=3D'cpu')=
:
> > > >          self.rulefname =3D rulefname
> > > >          self.reportfname =3D reportfname
> > > >          self.rules =3D None
> > > > @@ -43,6 +44,7 @@ class Validator:
> > > >          self.metrics =3D self.__set_metrics(metrics)
> > > >          self.skiplist =3D set()
> > > >          self.tolerance =3D t
> > > > +        self.cputype =3D cputype
> > > >
> > > >          self.workloads =3D [x for x in workload.split(",") if x]
> > > >          self.wlidx =3D 0  # idx of current workloads
> > > > @@ -377,7 +379,7 @@ class Validator:
> > > >
> > > >      def _run_perf(self, metric, workload: str):
> > > >          tool =3D 'perf'
> > > > -        command =3D [tool, 'stat', '-j', '-M', f"{metric}", "-a"]
> > > > +        command =3D [tool, 'stat', '--cputype', self.cputype, '-j'=
, '-M', f"{metric}", "-a"]
> > > >          wl =3D workload.split()
> > > >          command.extend(wl)
> > > >          print(" ".join(command))
> > > > @@ -443,6 +445,8 @@ class Validator:
> > > >                  if 'MetricName' not in m:
> > > >                      print("Warning: no metric name")
> > > >                      continue
> > > > +                if 'Unit' in m and m['Unit'] !=3D self.cputype:
> > > > +                    continue
> > > >                  name =3D m['MetricName'].lower()
> > > >                  self.metrics.add(name)
> > > >                  if 'ScaleUnit' in m and (m['ScaleUnit'] =3D=3D '1%=
' or m['ScaleUnit'] =3D=3D '100%'):
> > > > @@ -578,6 +582,8 @@ def main() -> None:
> > > >      parser.add_argument(
> > > >          "-wl", help=3D"Workload to run while data collection", def=
ault=3D"true")
> > > >      parser.add_argument("-m", help=3D"Metric list to validate", de=
fault=3D"")
> > > > +    parser.add_argument("-cputype", help=3D"Only test metrics for =
the given CPU/PMU type",
> > > > +                        default=3D"cpu")
> > > >      args =3D parser.parse_args()
> > > >      outpath =3D Path(args.output_dir)
> > > >      reportf =3D Path.joinpath(outpath, 'perf_report.json')
> > > > @@ -586,7 +592,7 @@ def main() -> None:
> > > >
> > > >      validator =3D Validator(args.rule, reportf, debug=3Dargs.debug=
,
> > > >                            datafname=3Ddatafile, fullrulefname=3Dfu=
llrule, workload=3Dargs.wl,
> > > > -                          metrics=3Dargs.m)
> > > > +                          metrics=3Dargs.m, cputype=3Dargs.cputype=
)
> > > >      ret =3D validator.test()
> > > >
> > > >      return ret
> > > > diff --git a/tools/perf/tests/shell/stat_metrics_values.sh b/tools/=
perf/tests/shell/stat_metrics_values.sh
> > > > index 279f19c5919a..30566f0b5427 100755
> > > > --- a/tools/perf/tests/shell/stat_metrics_values.sh
> > > > +++ b/tools/perf/tests/shell/stat_metrics_values.sh
> > > > @@ -16,11 +16,16 @@ workload=3D"perf bench futex hash -r 2 -s"
> > > >  # Add -debug, save data file and full rule file
> > > >  echo "Launch python validation script $pythonvalidator"
> > > >  echo "Output will be stored in: $tmpdir"
> > > > -$PYTHON $pythonvalidator -rule $rulefile -output_dir $tmpdir -wl "=
${workload}"
> > > > -ret=3D$?
> > > > -rm -rf $tmpdir
> > > > -if [ $ret -ne 0 ]; then
> > > > -     echo "Metric validation return with erros. Please check metri=
cs reported with errors."
> > > > -fi
> > > > +for cputype in /sys/bus/event_source/devices/cpu_*; do
> > > > +     cputype=3D$(basename "$cputype")
> > > > +     echo "Testing metrics for: $cputype"
> > > > +     $PYTHON $pythonvalidator -rule $rulefile -output_dir $tmpdir =
-wl "${workload}" \
> > > > +             -cputype "${cputype}"
> > > > +     ret=3D$?
> > > > +     rm -rf $tmpdir
> > > > +     if [ $ret -ne 0 ]; then
> > > > +             echo "Metric validation return with errors. Please ch=
eck metrics reported with errors."
> > > > +     fi
> > > > +done
> > > >  exit $ret
> > > >
> > >
