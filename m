Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320021D5CDE
	for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747157202; cv=none; b=HSaruSPSKkkCzgPA/bzjRvFwgztYK76ipcMBoDdqsz5ApHmpYvX6n0OInJF5SuJBCIfzgwB91AfLYdsh4pf+prFeQpImzZv5/7DIceJMCCI3XCsKYQn+UQLY835Tp2XLLGmEexXSjw9ZD1rBqlYLLacZvPc022pX2tKxDVHOJrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747157202; c=relaxed/simple;
	bh=j7MG8fRFjn64P571yBnwfXSB6U8Ki0vuuY9QiefIPV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghrrLNn4YpARg2c0rbwnH/AxO0GCnaR851C/YArMalU3Gg+SKDMPLM0HBG86aKuen1q3GOPkU6KOawcc6KtLCnlOTuQK8arM50eAaR+6nKJNcwifLB1KhW9VhIcC/zkux06mHt+JuymY86AM9mcgUO0J5eQL1QxGgfS//lttZIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ypEIuLZB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ypEIuLZB"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22e42641d7cso17325ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 10:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747157199; x=1747761999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pt97d48gjNxSANYhlUYSzocgwjeBM/CBv6nzairLsS4=;
        b=ypEIuLZBfTWXmWpqvsQGdbfz1PwLCFuA03Afo9CgJGYAhv9MwzrRsnrwg4bM1Hsrak
         JDLs9XoeO1u8vkrIaTXsxKO8JG1bS3rL7uyiSUgjPPwHV8qt3W1cghzuHrCmTG3d2O+G
         psBwcTOap9o6htTXFfU1gPehP5P70n3/+RpF69MP5+LhcLnfYuF88ugH5StboRGTHgim
         2Kso82W3rtu5TCQuv4DcPixbJYq4jScW2A1ofYgiKhxgHpcZcRz9NwfB1vDWA3O+Y6JZ
         iv0DOOc/S+Tn6uco92SUVwpdPyD5LXd7yjz1N7Tn0BNV3sEaemyvNoRhJsFW5QqRe7R9
         v45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747157199; x=1747761999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pt97d48gjNxSANYhlUYSzocgwjeBM/CBv6nzairLsS4=;
        b=nbhJg8du0LsAB9RSdodtND+bA1bQbdUmqK8dp1n+vCaL+65bjEgAvx9QjsUujKUanT
         3M7AExN885Ot4AlGgZyIp+Plqm5QdsDeZ+fV+BuBZ4lzBJA8f/xgBj/ZK15V++wqQm2t
         u4PGb5UY/JK8S+gZ7idh3ZflwYGuLEc8wF3M7lJZS5y3nYYTa6ctZhFa8cWlQJLLCezB
         /Hea1dDNb5YVTrlp+4ce6v4AF/aUEbLDC/e6LeN+a1owTYDWfU5s8qCK6ErSMDZgVNBS
         g0Q/miBf8zYPWgUxHNK96RP0ddEVvSMgjcp2pZRNFTy9+a5KMFGc/RQR9mij91BI1xyW
         RKPA==
X-Forwarded-Encrypted: i=1; AJvYcCVxs7g50QZoaHH+5dKg8AHsysE3B2QjKmWzsfC+dObNRwHLciKaTtw7HFolJ1S22F0/hrAnxiisC6X4woXvQf6a@vger.kernel.org
X-Gm-Message-State: AOJu0YyxaSEHAHQQCro1qSOeJzAfvcR2FyG01JRzcMl4xRHXQ7vomrVD
	+gsl0vJpJ9kQ8GQEc8N7CXVYOVRz+tuo6cyTW1jfdDkdekEo1TYWznnAaGzRiEZm9hmgUcYB6jo
	et12iPbtDhnAeWxI6L9gN1JC1/0mFjb5gJlNDyjA/
X-Gm-Gg: ASbGnctK24N0c+IJZRt8SDQzYBPEZnasauFfDaYH/Ct9G3anrSNWxdoUXMUjcHyjL3v
	xz5xI0MAW5G8odPGElBlYIsZVRwoNF+CCugML5+38jHxLbcoj7xlxZU/Ydjzzo55nSBAKKC2uVb
	q9KCggsGCnKW0QGRBUEx/ijbqMdNYVZPT8cwLLKlQ1Xt8DircGiB8ZLe8Z8VB98A==
X-Google-Smtp-Source: AGHT+IFlIkzISAflQDFsf9GZe2dx0t09B6mo1dIn5rYsLY+FhyqTbGnWgAXgCe6we8o1uLkfk0pj6mv0d4VZl0VUorY=
X-Received: by 2002:a17:903:2b10:b0:21f:2ded:bfa0 with SMTP id
 d9443c01a7336-231803fbff3mr3273635ad.25.1747157199111; Tue, 13 May 2025
 10:26:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512184700.11691-1-irogers@google.com> <20250512184700.11691-2-irogers@google.com>
 <108f87fc28453adb52d6b8c2afd8d184e288a83e.camel@intel.com> <CAP-5=fVaC662z2nJnTwBHMu-RE+9HkRmvSyNT5qB448+zw6e9Q@mail.gmail.com>
In-Reply-To: <CAP-5=fVaC662z2nJnTwBHMu-RE+9HkRmvSyNT5qB448+zw6e9Q@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 May 2025 10:26:26 -0700
X-Gm-Features: AX0GCFvK2V6CRXEAzQUuHKbGYnq4DKTfCv9i3TVjKKobxEOPyde8mDvOMXOdHlo
Message-ID: <CAP-5=fW5gap1OOFiEq6Lrc500rDPx=h5UNwOF8mEg2LOgfBsew@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf test: Hybrid improvements for metric value
 validation test
To: "Falcon, Thomas" <thomas.falcon@intel.com>, "Wang, Weilin" <weilin.wang@intel.com>
Cc: "james.clark@linaro.org" <james.clark@linaro.org>, 
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, "Hunter, Adrian" <adrian.hunter@intel.com>, 
	"acme@kernel.org" <acme@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>, 
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 2:52=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, May 12, 2025 at 1:30=E2=80=AFPM Falcon, Thomas <thomas.falcon@int=
el.com> wrote:
> >
> > On Mon, 2025-05-12 at 11:47 -0700, Ian Rogers wrote:
> > > On my alderlake I currently see for the "perf metrics value validatio=
n" test:
> > > ```
> > > Total Test Count:  142
> > > Passed Test Count:  139
> > > [
> > > Metric Relationship Error:      The collected value of metric ['tma_f=
etch_latency', 'tma_fetch_bandwidth', 'tma_frontend_bound']
> > >                         is [31.137028] in workload(s): ['perf bench f=
utex hash -r 2 -s']
> > >                         but expected value range is [tma_frontend_bou=
nd, tma_frontend_bound]
> > >                         Relationship rule description: 'Sum of the le=
vel 2 children should equal level 1 parent',
> > > Metric Relationship Error:      The collected value of metric ['tma_m=
emory_bound', 'tma_core_bound', 'tma_backend_bound']
> > >                         is [6.564442] in workload(s): ['perf bench fu=
tex hash -r 2 -s']
> > >                         but expected value range is [tma_backend_boun=
d, tma_backend_bound]
> > >                         Relationship rule description: 'Sum of the le=
vel 2 children should equal level 1 parent',
> > > Metric Relationship Error:      The collected value of metric ['tma_l=
ight_operations', 'tma_heavy_operations', 'tma_retiring']
> > >                         is [57.806179] in workload(s): ['perf bench f=
utex hash -r 2 -s']
> > >                         but expected value range is [tma_retiring, tm=
a_retiring]
> > >                         Relationship rule description: 'Sum of the le=
vel 2 children should equal level 1 parent']
> > > Metric validation return with erros. Please check metrics reported wi=
th errors.
> > > ```
> > > I suspect it is due to two metrics for different CPU types being
> > > enabled. Add a -cputype option to avoid this. The test still fails wi=
th:
> > > ```
> > > Total Test Count:  115
> > > Passed Test Count:  114
> > > [
> > > Wrong Metric Value Error:       The collected value of metric ['tma_l=
2_hit_latency']
> > >                         is [117.947088] in workload(s): ['perf bench =
futex hash -r 2 -s']
> > >                         but expected value range is [0, 100]]
> > > Metric validation return with errors. Please check metrics reported w=
ith errors.
> > > ```
> > > which is a reproducible genuine error and likely requires a metric fi=
x.
> >
> > Hi Ian, I tested this on my alder lake and an arrow lake. All tests, in=
cluding tma_l2_hit_latency,
> > pass on my end.
> >
> > Tested-by: Thomas Falcon <thomas.falcon@intel.com>
>
> Thanks Thomas! It should also work for core_lowpower on ArrowLake. I
> find some times that tma_l2_hit_latency passes for me. Trying a few
> more times I see other failures, but they all seem to be "No Metric
> Value Error" - perhaps these shouldn't fail the test. In the testing
> code we're passing '-a' for system wide profiling:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/tests/shell/lib/perf_metric_validation.py?h=3Dperf-tool=
s-next#n380
> I believe this is done so that counters for things like AVX will
> gather values. I wonder if the tma_l2_hit_latency something is
> happening due to scaling counts:
> ```
> $ sudo /tmp/perf/perf stat -M tma_l2_hit_latency -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>      7,987,903,325      cpu_core/TOPDOWN.SLOTS/          #    210.2 %
> tma_l2_hit_latency       (87.27%)
>      3,131,119,398      cpu_core/topdown-retiring/
>                          (87.27%)
>      1,910,718,811      cpu_core/topdown-mem-bound/
>                          (87.27%)
>        481,456,610      cpu_core/topdown-bad-spec/
>                          (87.27%)
>      1,681,347,944      cpu_core/topdown-fe-bound/
>                          (87.27%)
>      2,798,109,902      cpu_core/topdown-be-bound/
>                          (87.27%)
>        365,736,554      cpu_core/MEMORY_ACTIVITY.STALLS_L1D_MISS/
>                                   (87.27%)
>        327,668,588      cpu_core/MEMORY_ACTIVITY.STALLS_L2_MISS/
>                                  (87.30%)
>         12,744,464      cpu_core/MEM_LOAD_RETIRED.L1_MISS/
>                            (75.32%)
>      1,403,250,041      cpu_core/CPU_CLK_UNHALTED.THREAD/
>                           (87.65%)
>          6,657,480      cpu_core/MEM_LOAD_RETIRED.L2_HIT/
>                           (87.66%)
>     59,424,499,192      TSC
>         40,830,608      cpu_core/MEM_LOAD_RETIRED.FB_HIT/
>                           (62.46%)
>      1,461,544,380      cpu_core/CPU_CLK_UNHALTED.REF_TSC/
>                            (74.79%)
>      1,008,604,319      duration_time
>
>        1.004974560 seconds time elapsed
> ```
> The values in the parentheses is a scaling amount which should mean
> for event multiplexing but for hybrid the events aren't running when
> on the other core type, so we're seeing these odd multiplexing values
> and these are used to scale counts:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/lib/perf/evsel.c?h=3Dperf-tools-next#n599
> I find when I run a benchmark rather than "sleep" the issue seems
> harder to reproduce.

Ok chatting with Weilin and actually paying attention to warning
messages I think I see a problem. TSC (msr/tsc/) is aggregating data
across all CPUs (it is a software event and is a different performance
monitoring unit to cpu_core) while the counters are only on cpu_core.
So I think this means the TSC value is too large. However, even with
restricting the CPUs I see the >100% problem:
```
$ perf stat -M tma_l2_hit_latency -C 0-15 -a sleep 1

 Performance counter stats for 'system wide':

    27,985,670,146      cpu_core/TOPDOWN.SLOTS/          #    125.6 %
tma_l2_hit_latency       (87.22%)
     9,619,906,383      cpu_core/topdown-retiring/
                         (87.22%)
     2,333,124,385      cpu_core/topdown-mem-bound/
                         (87.22%)
     3,607,656,674      cpu_core/topdown-bad-spec/
                         (87.22%)
     9,839,779,867      cpu_core/topdown-fe-bound/
                         (87.22%)
     5,244,189,749      cpu_core/topdown-be-bound/
                         (87.22%)
       442,932,231      cpu_core/MEMORY_ACTIVITY.STALLS_L1D_MISS/
                                  (87.24%)
       360,126,840      cpu_core/MEMORY_ACTIVITY.STALLS_L2_MISS/
                                 (87.63%)
        31,264,814      cpu_core/MEM_LOAD_RETIRED.L1_MISS/
                           (75.26%)
     4,761,244,040      cpu_core/CPU_CLK_UNHALTED.THREAD/
                          (87.63%)
        28,429,277      cpu_core/MEM_LOAD_RETIRED.L2_HIT/
                          (87.62%)
    33,863,490,835      TSC
        23,533,366      cpu_core/MEM_LOAD_RETIRED.FB_HIT/
                          (62.25%)
     3,158,155,632      cpu_core/CPU_CLK_UNHALTED.REF_TSC/
                           (74.63%)
     1,003,102,327      duration_time

       1.001912038 seconds time elapsed
```
So we still need to figure this one out. The multiplexing numbers
still worry me.

Thanks,
Ian


> Thanks,
> Ian
>
> > Thanks,
> > Tom
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  .../tests/shell/lib/perf_metric_validation.py   | 12 +++++++++---
> > >  tools/perf/tests/shell/stat_metrics_values.sh   | 17 +++++++++++----=
--
> > >  2 files changed, 20 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/tools/perf/tests/shell/lib/perf_metric_validation.py b/t=
ools/perf/tests/shell/lib/perf_metric_validation.py
> > > index 0b94216c9c46..dea8ef1977bf 100644
> > > --- a/tools/perf/tests/shell/lib/perf_metric_validation.py
> > > +++ b/tools/perf/tests/shell/lib/perf_metric_validation.py
> > > @@ -35,7 +35,8 @@ class TestError:
> > >
> > >
> > >  class Validator:
> > > -    def __init__(self, rulefname, reportfname=3D'', t=3D5, debug=3DF=
alse, datafname=3D'', fullrulefname=3D'', workload=3D'true', metrics=3D''):
> > > +    def __init__(self, rulefname, reportfname=3D'', t=3D5, debug=3DF=
alse, datafname=3D'', fullrulefname=3D'',
> > > +                 workload=3D'true', metrics=3D'', cputype=3D'cpu'):
> > >          self.rulefname =3D rulefname
> > >          self.reportfname =3D reportfname
> > >          self.rules =3D None
> > > @@ -43,6 +44,7 @@ class Validator:
> > >          self.metrics =3D self.__set_metrics(metrics)
> > >          self.skiplist =3D set()
> > >          self.tolerance =3D t
> > > +        self.cputype =3D cputype
> > >
> > >          self.workloads =3D [x for x in workload.split(",") if x]
> > >          self.wlidx =3D 0  # idx of current workloads
> > > @@ -377,7 +379,7 @@ class Validator:
> > >
> > >      def _run_perf(self, metric, workload: str):
> > >          tool =3D 'perf'
> > > -        command =3D [tool, 'stat', '-j', '-M', f"{metric}", "-a"]
> > > +        command =3D [tool, 'stat', '--cputype', self.cputype, '-j', =
'-M', f"{metric}", "-a"]
> > >          wl =3D workload.split()
> > >          command.extend(wl)
> > >          print(" ".join(command))
> > > @@ -443,6 +445,8 @@ class Validator:
> > >                  if 'MetricName' not in m:
> > >                      print("Warning: no metric name")
> > >                      continue
> > > +                if 'Unit' in m and m['Unit'] !=3D self.cputype:
> > > +                    continue
> > >                  name =3D m['MetricName'].lower()
> > >                  self.metrics.add(name)
> > >                  if 'ScaleUnit' in m and (m['ScaleUnit'] =3D=3D '1%' =
or m['ScaleUnit'] =3D=3D '100%'):
> > > @@ -578,6 +582,8 @@ def main() -> None:
> > >      parser.add_argument(
> > >          "-wl", help=3D"Workload to run while data collection", defau=
lt=3D"true")
> > >      parser.add_argument("-m", help=3D"Metric list to validate", defa=
ult=3D"")
> > > +    parser.add_argument("-cputype", help=3D"Only test metrics for th=
e given CPU/PMU type",
> > > +                        default=3D"cpu")
> > >      args =3D parser.parse_args()
> > >      outpath =3D Path(args.output_dir)
> > >      reportf =3D Path.joinpath(outpath, 'perf_report.json')
> > > @@ -586,7 +592,7 @@ def main() -> None:
> > >
> > >      validator =3D Validator(args.rule, reportf, debug=3Dargs.debug,
> > >                            datafname=3Ddatafile, fullrulefname=3Dfull=
rule, workload=3Dargs.wl,
> > > -                          metrics=3Dargs.m)
> > > +                          metrics=3Dargs.m, cputype=3Dargs.cputype)
> > >      ret =3D validator.test()
> > >
> > >      return ret
> > > diff --git a/tools/perf/tests/shell/stat_metrics_values.sh b/tools/pe=
rf/tests/shell/stat_metrics_values.sh
> > > index 279f19c5919a..30566f0b5427 100755
> > > --- a/tools/perf/tests/shell/stat_metrics_values.sh
> > > +++ b/tools/perf/tests/shell/stat_metrics_values.sh
> > > @@ -16,11 +16,16 @@ workload=3D"perf bench futex hash -r 2 -s"
> > >  # Add -debug, save data file and full rule file
> > >  echo "Launch python validation script $pythonvalidator"
> > >  echo "Output will be stored in: $tmpdir"
> > > -$PYTHON $pythonvalidator -rule $rulefile -output_dir $tmpdir -wl "${=
workload}"
> > > -ret=3D$?
> > > -rm -rf $tmpdir
> > > -if [ $ret -ne 0 ]; then
> > > -     echo "Metric validation return with erros. Please check metrics=
 reported with errors."
> > > -fi
> > > +for cputype in /sys/bus/event_source/devices/cpu_*; do
> > > +     cputype=3D$(basename "$cputype")
> > > +     echo "Testing metrics for: $cputype"
> > > +     $PYTHON $pythonvalidator -rule $rulefile -output_dir $tmpdir -w=
l "${workload}" \
> > > +             -cputype "${cputype}"
> > > +     ret=3D$?
> > > +     rm -rf $tmpdir
> > > +     if [ $ret -ne 0 ]; then
> > > +             echo "Metric validation return with errors. Please chec=
k metrics reported with errors."
> > > +     fi
> > > +done
> > >  exit $ret
> > >
> >
