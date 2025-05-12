Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82833266B5C
	for <linux-perf-users@vger.kernel.org>; Mon, 12 May 2025 21:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747086741; cv=none; b=dThljP0EP73ZHGqpD4L66pKoTt4owu58/gEo9tNVk0i0y19SJ/8kX7nTA6/+krjiQFaodUhrTs5aXWL8QZXsb1eDMao64K41lIcJUCa5f/VDi9/nKkCOZfRi6fs3ucf4qs6ik++Io17+hhPBlxcp6hxccjQtX+tIQxm1GzgYMxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747086741; c=relaxed/simple;
	bh=F7NIGjlM1cQh3+6CvDK87nRJ9BjRJl1yK3hETvJ41zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVS72PVbQZVhYENLlJw0CNCGzhU3E/HdUQ1DLx1efD7ZZBZMDBFuP/sqDwUPYKSquQUxwUynAr3fxSxgg344Sw9UBRqjQA06x78pzrRNOd22DbzAEwjUCBnehuHTEsX84A1aZByow+dfjFe9uB7tVa5V464/4goQWwEXT/CXYg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XNM4Vdqk; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XNM4Vdqk"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d8c4222fc9so68015ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 May 2025 14:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747086738; x=1747691538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIke5FFZIrxP5cWy/lxL+75qMUHbqbG2lTLLGaqnF7s=;
        b=XNM4VdqkThJAACcvQ8izQhFh1gUUgmzmwV9hUfFEPhDByuVDqs00QLIrjZIZpY+swB
         2JzMMOEpTybpcliSM8QmdRHjhnPWROD43O7ZLre87W6DU89OvMsHNMHWFZ9ACm0Rfyre
         sGQq6FdvudA2qljwqId1DUuCV/IILeTgadLZiT0/izK43rLy9d3kGhw2NnBfyYFcEiz1
         C3ggJNbDgAQrtcx803lVemkLffZ867oZKQRizsbnHQMpv4W2uSyU4lIfvWnhKL1Fl8s3
         8pRiLT2RGOvoV3qysWonMdeChn5hE3joqqU0+Hm+ZCNqKz7NADd27pzxzJpPMu8m2ktk
         VSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747086738; x=1747691538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIke5FFZIrxP5cWy/lxL+75qMUHbqbG2lTLLGaqnF7s=;
        b=Qe7saSC43fUNO5RQeAsU3pYQqCusQv8jf8hzFpbArUTZ4evXirhcIZ49akS7DsUIF4
         sM5MI3OaI8IoibumV9tXWKuLkdJe1ZtW7oe+gvkHqSkhBGobz9joCoCqFZDB1fLn8ekK
         37TUNxGygP0Or97ADNSjKowq5pWH3IhRyiKyH9b3o6QjZc76+QtQ0+EcqIWLNxWDxmhY
         c/8cWGBnJQlln+3svGGjj2jiUhEnBRIzGNZu3kHnyn4a1n1Hp+S1m5tXFS0v5B6v66yC
         fkbBj/hFvDZBhsOIz1lhAo6stxzueoTsmPMvmT6sTIsBpZwcZBPgYrawrY5OReuEZrD8
         q+Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVHpjVM5JaRaWFclRbpHkfUaaflmlVNhmY/ave9OFQ02B2IiG+l53K5z61fu08MldI5oGU0bWHQ/rDphDuykq0x@vger.kernel.org
X-Gm-Message-State: AOJu0YycCy4lefFRgw8sSDqKQGKj+0M+EsDs4tzEJ790ee71mHa/izHc
	7Kzruxizptiw3F3HMz3GXOQiTEVceM+xrm+7xPZJEA/4MwoiL8IpYip6dltLzNUopikY82uOug+
	UhJgdu/vajb1czgLqVjUuL6NHNRdbO/hTnXF5Phcg
X-Gm-Gg: ASbGnctH84O1GmtEsq6HlZvzMgJ5DpERYR01oYL6Ap1vXEN2jx51+n12r95c9zIQen9
	H7xFi4rIyxHWkIts9MrMilS0sjrC9ReDY2w3NHpLH4xQ7xd3FDA0KDyFG1YMygE4tiuidOyOS4s
	bRk1lKG9s7xFcnP/mooX8MPZCbWu2qfE4radpzZLG+pg/OUzMlNX/1MUPFup+VwHK6lvcw43f6
X-Google-Smtp-Source: AGHT+IGfTGAlA9ahZpaBwSN4Iyx37wWVY6q/jo8/qxfSSW1O/WI3zEkMtXBJxJyRpq1D1xgpcMsIx6ZVAtBH5KIOFcE=
X-Received: by 2002:a05:6e02:3186:b0:3d4:2362:9fbc with SMTP id
 e9e14a558f8ab-3db67ad1566mr360125ab.27.1747086738314; Mon, 12 May 2025
 14:52:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512184700.11691-1-irogers@google.com> <20250512184700.11691-2-irogers@google.com>
 <108f87fc28453adb52d6b8c2afd8d184e288a83e.camel@intel.com>
In-Reply-To: <108f87fc28453adb52d6b8c2afd8d184e288a83e.camel@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 May 2025 14:52:07 -0700
X-Gm-Features: AX0GCFsJ9AcZxH-AcxltPTYznUhGILI8_URX6jXrUU6RR9BCSXa-bHt6Vqyzkfc
Message-ID: <CAP-5=fVaC662z2nJnTwBHMu-RE+9HkRmvSyNT5qB448+zw6e9Q@mail.gmail.com>
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

On Mon, May 12, 2025 at 1:30=E2=80=AFPM Falcon, Thomas <thomas.falcon@intel=
.com> wrote:
>
> On Mon, 2025-05-12 at 11:47 -0700, Ian Rogers wrote:
> > On my alderlake I currently see for the "perf metrics value validation"=
 test:
> > ```
> > Total Test Count:  142
> > Passed Test Count:  139
> > [
> > Metric Relationship Error:      The collected value of metric ['tma_fet=
ch_latency', 'tma_fetch_bandwidth', 'tma_frontend_bound']
> >                         is [31.137028] in workload(s): ['perf bench fut=
ex hash -r 2 -s']
> >                         but expected value range is [tma_frontend_bound=
, tma_frontend_bound]
> >                         Relationship rule description: 'Sum of the leve=
l 2 children should equal level 1 parent',
> > Metric Relationship Error:      The collected value of metric ['tma_mem=
ory_bound', 'tma_core_bound', 'tma_backend_bound']
> >                         is [6.564442] in workload(s): ['perf bench fute=
x hash -r 2 -s']
> >                         but expected value range is [tma_backend_bound,=
 tma_backend_bound]
> >                         Relationship rule description: 'Sum of the leve=
l 2 children should equal level 1 parent',
> > Metric Relationship Error:      The collected value of metric ['tma_lig=
ht_operations', 'tma_heavy_operations', 'tma_retiring']
> >                         is [57.806179] in workload(s): ['perf bench fut=
ex hash -r 2 -s']
> >                         but expected value range is [tma_retiring, tma_=
retiring]
> >                         Relationship rule description: 'Sum of the leve=
l 2 children should equal level 1 parent']
> > Metric validation return with erros. Please check metrics reported with=
 errors.
> > ```
> > I suspect it is due to two metrics for different CPU types being
> > enabled. Add a -cputype option to avoid this. The test still fails with=
:
> > ```
> > Total Test Count:  115
> > Passed Test Count:  114
> > [
> > Wrong Metric Value Error:       The collected value of metric ['tma_l2_=
hit_latency']
> >                         is [117.947088] in workload(s): ['perf bench fu=
tex hash -r 2 -s']
> >                         but expected value range is [0, 100]]
> > Metric validation return with errors. Please check metrics reported wit=
h errors.
> > ```
> > which is a reproducible genuine error and likely requires a metric fix.
>
> Hi Ian, I tested this on my alder lake and an arrow lake. All tests, incl=
uding tma_l2_hit_latency,
> pass on my end.
>
> Tested-by: Thomas Falcon <thomas.falcon@intel.com>

Thanks Thomas! It should also work for core_lowpower on ArrowLake. I
find some times that tma_l2_hit_latency passes for me. Trying a few
more times I see other failures, but they all seem to be "No Metric
Value Error" - perhaps these shouldn't fail the test. In the testing
code we're passing '-a' for system wide profiling:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/lib/perf_metric_validation.py?h=3Dperf-tools-=
next#n380
I believe this is done so that counters for things like AVX will
gather values. I wonder if the tma_l2_hit_latency something is
happening due to scaling counts:
```
$ sudo /tmp/perf/perf stat -M tma_l2_hit_latency -a sleep 1

 Performance counter stats for 'system wide':

     7,987,903,325      cpu_core/TOPDOWN.SLOTS/          #    210.2 %
tma_l2_hit_latency       (87.27%)
     3,131,119,398      cpu_core/topdown-retiring/
                         (87.27%)
     1,910,718,811      cpu_core/topdown-mem-bound/
                         (87.27%)
       481,456,610      cpu_core/topdown-bad-spec/
                         (87.27%)
     1,681,347,944      cpu_core/topdown-fe-bound/
                         (87.27%)
     2,798,109,902      cpu_core/topdown-be-bound/
                         (87.27%)
       365,736,554      cpu_core/MEMORY_ACTIVITY.STALLS_L1D_MISS/
                                  (87.27%)
       327,668,588      cpu_core/MEMORY_ACTIVITY.STALLS_L2_MISS/
                                 (87.30%)
        12,744,464      cpu_core/MEM_LOAD_RETIRED.L1_MISS/
                           (75.32%)
     1,403,250,041      cpu_core/CPU_CLK_UNHALTED.THREAD/
                          (87.65%)
         6,657,480      cpu_core/MEM_LOAD_RETIRED.L2_HIT/
                          (87.66%)
    59,424,499,192      TSC
        40,830,608      cpu_core/MEM_LOAD_RETIRED.FB_HIT/
                          (62.46%)
     1,461,544,380      cpu_core/CPU_CLK_UNHALTED.REF_TSC/
                           (74.79%)
     1,008,604,319      duration_time

       1.004974560 seconds time elapsed
```
The values in the parentheses is a scaling amount which should mean
for event multiplexing but for hybrid the events aren't running when
on the other core type, so we're seeing these odd multiplexing values
and these are used to scale counts:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/lib/perf/evsel.c?h=3Dperf-tools-next#n599
I find when I run a benchmark rather than "sleep" the issue seems
harder to reproduce.

Thanks,
Ian

> Thanks,
> Tom
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  .../tests/shell/lib/perf_metric_validation.py   | 12 +++++++++---
> >  tools/perf/tests/shell/stat_metrics_values.sh   | 17 +++++++++++------
> >  2 files changed, 20 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/lib/perf_metric_validation.py b/too=
ls/perf/tests/shell/lib/perf_metric_validation.py
> > index 0b94216c9c46..dea8ef1977bf 100644
> > --- a/tools/perf/tests/shell/lib/perf_metric_validation.py
> > +++ b/tools/perf/tests/shell/lib/perf_metric_validation.py
> > @@ -35,7 +35,8 @@ class TestError:
> >
> >
> >  class Validator:
> > -    def __init__(self, rulefname, reportfname=3D'', t=3D5, debug=3DFal=
se, datafname=3D'', fullrulefname=3D'', workload=3D'true', metrics=3D''):
> > +    def __init__(self, rulefname, reportfname=3D'', t=3D5, debug=3DFal=
se, datafname=3D'', fullrulefname=3D'',
> > +                 workload=3D'true', metrics=3D'', cputype=3D'cpu'):
> >          self.rulefname =3D rulefname
> >          self.reportfname =3D reportfname
> >          self.rules =3D None
> > @@ -43,6 +44,7 @@ class Validator:
> >          self.metrics =3D self.__set_metrics(metrics)
> >          self.skiplist =3D set()
> >          self.tolerance =3D t
> > +        self.cputype =3D cputype
> >
> >          self.workloads =3D [x for x in workload.split(",") if x]
> >          self.wlidx =3D 0  # idx of current workloads
> > @@ -377,7 +379,7 @@ class Validator:
> >
> >      def _run_perf(self, metric, workload: str):
> >          tool =3D 'perf'
> > -        command =3D [tool, 'stat', '-j', '-M', f"{metric}", "-a"]
> > +        command =3D [tool, 'stat', '--cputype', self.cputype, '-j', '-=
M', f"{metric}", "-a"]
> >          wl =3D workload.split()
> >          command.extend(wl)
> >          print(" ".join(command))
> > @@ -443,6 +445,8 @@ class Validator:
> >                  if 'MetricName' not in m:
> >                      print("Warning: no metric name")
> >                      continue
> > +                if 'Unit' in m and m['Unit'] !=3D self.cputype:
> > +                    continue
> >                  name =3D m['MetricName'].lower()
> >                  self.metrics.add(name)
> >                  if 'ScaleUnit' in m and (m['ScaleUnit'] =3D=3D '1%' or=
 m['ScaleUnit'] =3D=3D '100%'):
> > @@ -578,6 +582,8 @@ def main() -> None:
> >      parser.add_argument(
> >          "-wl", help=3D"Workload to run while data collection", default=
=3D"true")
> >      parser.add_argument("-m", help=3D"Metric list to validate", defaul=
t=3D"")
> > +    parser.add_argument("-cputype", help=3D"Only test metrics for the =
given CPU/PMU type",
> > +                        default=3D"cpu")
> >      args =3D parser.parse_args()
> >      outpath =3D Path(args.output_dir)
> >      reportf =3D Path.joinpath(outpath, 'perf_report.json')
> > @@ -586,7 +592,7 @@ def main() -> None:
> >
> >      validator =3D Validator(args.rule, reportf, debug=3Dargs.debug,
> >                            datafname=3Ddatafile, fullrulefname=3Dfullru=
le, workload=3Dargs.wl,
> > -                          metrics=3Dargs.m)
> > +                          metrics=3Dargs.m, cputype=3Dargs.cputype)
> >      ret =3D validator.test()
> >
> >      return ret
> > diff --git a/tools/perf/tests/shell/stat_metrics_values.sh b/tools/perf=
/tests/shell/stat_metrics_values.sh
> > index 279f19c5919a..30566f0b5427 100755
> > --- a/tools/perf/tests/shell/stat_metrics_values.sh
> > +++ b/tools/perf/tests/shell/stat_metrics_values.sh
> > @@ -16,11 +16,16 @@ workload=3D"perf bench futex hash -r 2 -s"
> >  # Add -debug, save data file and full rule file
> >  echo "Launch python validation script $pythonvalidator"
> >  echo "Output will be stored in: $tmpdir"
> > -$PYTHON $pythonvalidator -rule $rulefile -output_dir $tmpdir -wl "${wo=
rkload}"
> > -ret=3D$?
> > -rm -rf $tmpdir
> > -if [ $ret -ne 0 ]; then
> > -     echo "Metric validation return with erros. Please check metrics r=
eported with errors."
> > -fi
> > +for cputype in /sys/bus/event_source/devices/cpu_*; do
> > +     cputype=3D$(basename "$cputype")
> > +     echo "Testing metrics for: $cputype"
> > +     $PYTHON $pythonvalidator -rule $rulefile -output_dir $tmpdir -wl =
"${workload}" \
> > +             -cputype "${cputype}"
> > +     ret=3D$?
> > +     rm -rf $tmpdir
> > +     if [ $ret -ne 0 ]; then
> > +             echo "Metric validation return with errors. Please check =
metrics reported with errors."
> > +     fi
> > +done
> >  exit $ret
> >
>
