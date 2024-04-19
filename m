Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37A84C8A
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Apr 2024 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540218; cv=none; b=Lt4eiQ+bCcp56t55ttYDM+QbX/xWO96vFuS/M8N99m0p/KoomcFMVWtEMJZ3I+sLCv2i6uCjIF3nrk89MbRyCxJRoO7hisdtTl8ZhGNv1zYCmzaWWATDweVodcLnOqgMuaVsaf9kZddxRVA2pK4A0IW6nwFOLkT+G5Pg5oVrm1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540218; c=relaxed/simple;
	bh=GIAimIXdqLxzYbNegjt+SwqQglE9A8ZOB26zfIsr6Mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwHejLtKWBcrcbpn3/wAGC6psmC8Vw1NIa80mmRSZoz2xvp101eStSUo+Y5hN8GquTH0KyPcSCSX/CHT5mnk4J95YkwxvWZW8+DBlY4WetaTJsg4pSgIaXzuimfchNfM3k2ALzSQh0nnQiLYthQXa5pmeh4mKg+6d1Qh19d0tsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mgVGwByA; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mgVGwByA"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-436ed871225so294001cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Apr 2024 08:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713540215; x=1714145015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqqvqqU0RLWeLV5OEenfyC9RG8V0cWxiI7JG1ryx5y8=;
        b=mgVGwByAG9L0RHayyUke4i9TfmRRTlBFMjFzWGP50n+7rgPIF9PGA80LMfKyogBzbR
         tYKJZI1M5BRchedttEFxdQjNk86O9VcQeQaSd8wEU0zke/3qpSyjmr+HHPtzthoU8TC7
         yir/FnZosz/aWUoHijNzkq3rrhahR7FngYxvFDvMmO4uKeZ81wSsr4T0fB7nkes3GsVf
         6ETZlITZxvym/D8sCwrfo4C+sTieBDS8Lqs28D43+dbU3/TBmrSgipocCp92HiUN2BC/
         DhnepNF8lcbJ4QU45IYaONTQtbFQZTz9AeFL38BP2HkOEQiQyaqJLwnS2o/XWsWCy3DQ
         TirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713540215; x=1714145015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqqvqqU0RLWeLV5OEenfyC9RG8V0cWxiI7JG1ryx5y8=;
        b=R321pZ/sd9UUOiJ2Z/OTFIHeKL1GVBVdPlbK5auTwP1uoZBb4Dg+uX11zYm5U2Nmep
         XZuBda0OCffOkoU511J9aXsMNZHt0LloPk1q0nTB7f20FzUgWDjqqMk7pfYIQ+4C97Io
         orTA0BCAdMRkleD6hFc8UjHFgCjPjNM9FD1raj6mdFKGXR4coY2SCB3UM5LvTbCjvAhY
         PEErYYgimAOEZxnLNhMbRecQNoW+OmZIY+pHOm5jyk+EfKB3izCImSxg9MNqFS1jF52g
         QHg+Pn/VFrtIJgEZ+HnFR03j8IWt3h2ODYate41Nr+boYvso1E0c12SHWVH8vACGyvW6
         RJSw==
X-Forwarded-Encrypted: i=1; AJvYcCXb/tU1OjJP7hqANrmqbJw4TmJly26/edMwxsqD4a5oyy2tl10TB2sQPcuotmqD43+f6b6efhpWBBjmIOnjMavVNEEwOaNnBelmTCgf1awd8g==
X-Gm-Message-State: AOJu0YwamN2YEXv6ZhPcdynP2x1CPLgFLPC777e87iLBLUVpWfcZGotW
	ZcKMkF///jLWc5hAx0iZtJes3ZcViaQVUdd47x6uooctzeY6v/5MVqVnBDpxhLQTpbooOKnEpka
	pyB45N+JY/Kv3Z533Sz6HsPOlPKmrkuw7jqZC
X-Google-Smtp-Source: AGHT+IEx/0aFlucL09+ooXR2fa2x36BqtRpTp/YtvG1FZYkQ0FXIjdBQPiW8SMC2zY2Fr8KdF2XJZxb0Db7uroLI51U=
X-Received: by 2002:a05:622a:188f:b0:437:a00d:62ca with SMTP id
 v15-20020a05622a188f00b00437a00d62camr268383qtc.7.1713540215414; Fri, 19 Apr
 2024 08:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417183219.1208493-1-irogers@google.com> <c68bf005-af20-4995-86d5-a62e171763e3@linux.intel.com>
 <CAP-5=fUG_b6e9Q=qMFMtuKpzvz7D1xoLXNxeyfqwyX8qSsBwsg@mail.gmail.com> <b48c2040-7ee9-40a4-a97e-54bcb82cfc3e@linux.intel.com>
In-Reply-To: <b48c2040-7ee9-40a4-a97e-54bcb82cfc3e@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 19 Apr 2024 08:23:22 -0700
Message-ID: <CAP-5=fV-mGX7QXT4G=VyzWjL5_AJuZ_69aj6JYbV8NVhuy-8TA@mail.gmail.com>
Subject: Re: [PATCH v1] perf test: Avoid hard coded metrics in stat std output test
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 8:09=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-04-19 10:40 a.m., Ian Rogers wrote:
> > On Fri, Apr 19, 2024 at 6:54=E2=80=AFAM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> >>
> >>
> >>
> >> On 2024-04-17 2:32 p.m., Ian Rogers wrote:
> >>> Hard coded metric names fail on ARM testing.
> >>>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>  tools/perf/tests/shell/stat+std_output.sh | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/t=
ests/shell/stat+std_output.sh
> >>> index cbf2894b2c84..845f83213855 100755
> >>> --- a/tools/perf/tests/shell/stat+std_output.sh
> >>> +++ b/tools/perf/tests/shell/stat+std_output.sh
> >>> @@ -13,7 +13,7 @@ stat_output=3D$(mktemp /tmp/__perf_test.stat_output=
.std.XXXXX)
> >>>
> >>>  event_name=3D(cpu-clock task-clock context-switches cpu-migrations p=
age-faults stalled-cycles-frontend stalled-cycles-backend cycles instructio=
ns branches branch-misses)
> >>>  event_metric=3D("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec"=
 "frontend cycles idle" "backend cycles idle" "GHz" "insn per cycle" "/sec"=
 "of all branches")
> >>> -skip_metric=3D("stalled cycles per insn" "tma_" "retiring" "frontend=
_bound" "bad_speculation" "backend_bound")
> >>> +skip_metric=3D($(perf list --raw Default 2> /dev/null))
> >>
> >>
> >> The "perf list --raw Default" only gives the topdown metrics.
> >> The "stalled cycles per insn" is not covered.
> >> The check should skip the line of "stalled cycles per insn" as well.
> >>
> >>      3,856,436,920 stalled-cycles-frontend   #   74.09% frontend cycle=
s idle
> >>      1,600,790,871 stalled-cycles-backend    #   30.75% backend  cycle=
s idle
> >>      2,603,501,247 instructions              #    0.50  insns per cycl=
e
> >>                                              #    1.48  stalled cycles
> >> per insn
> >>        484,357,498 branches                  #  283.455 M/sec
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/tools/perf/builtin-stat.c#n24
> >>
> >> The newer Intel CPU doesn't have the stalled-cycles-* events. But it
> >> seems power and older x86 CPU have the events.
> >
> > Oh, sigh. This test should really ignore lines like that. How much do
> > we care about these metrics? The RISC-V event parsing change:
> > https://lore.kernel.org/lkml/20240416061533.921723-1-irogers@google.com=
/
> > means that legacy hardware events will be uncommon and we need to
> > adapt the hard coded metrics in stat-shadow.c to json ones. Once they
> > are json metrics they will be in Default.
>
> It seems except the newer Intel CPU, all the other ARCHs support the two
> stalled-cycles-* events and the metric. For Intel, there are Topdown
> metrics. But it seems an important metrics for the other ARCHs.
>
> RISC-V
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/perf/riscv_pmu_sbi.c#n134
> Power
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/powerpc/perf/power9-pmu.c#n279
> Arm
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/perf/arm_pmuv3.c#n53
>
> So almost all json files have to be updated. I'm not sure if it's a
> practical way to fix the issue.

So I'd very much like to get rid of the hard coded metrics:
 - they don't use or respect event groups,
 - their ad hoc printing can introduce extra metric results
unexpectedly in output,
 - they fall outside of optimizations like Weilin's metric event grouping w=
ork.
I'm hoping the python json generation of metrics makes their removal practi=
cal:
https://lore.kernel.org/lkml/20240314055919.1979781-1-irogers@google.com/

That's a lot to get landed for this fix:
 - 40+ patches for python based json generation.
 - 10+ patches for parse events changes.
So I think a version that hard codes ignoring the hard coded metrics
is in order.

Thanks,
Ian

> Thanks,
> Kan
> >
> > Thanks,
> > Ian
> >
> >> Thanks,
> >> Kan
> >>
> >>>
> >>>  cleanup() {
> >>>    rm -f "${stat_output}"
> >
