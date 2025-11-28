Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9EF302CDF
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Nov 2025 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764321630; cv=none; b=I98HYQ0EF4lJmcDT+ZU5rFU0We925kpY/a0OvFCHQ7BPtpnurf6TaXkaA7TE6ifPTyds1KntEoH7EurWn/+PpSWMzsyfDKvzXWF+kHV3ky5f2zTUwGZYsbNWNmNirjV+kiN91k8swB4cqTmRhlFXNiC2C4EH1gFH8ofI6Xrf8BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764321630; c=relaxed/simple;
	bh=G7Xo/yzaueyFoLDAt9go4elbgIC3olotTTDL7n8bxWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asC/PLHju3Q82L8vce7DrkgHPTcvEE5GMeTC26cvZGbDwgZWPoUtRyHmCvU91Oef5nPtmM34cIbwUglabR73zwwAp5RCj4MvfM2lVgkns4U9LDXTkYfggDx/xyR7u4vvV54tAaJRuEe4Pegr3qvseIejfN22qtzVIwT3oE6PSq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UsH1yqCd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UsH1yqCd"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-297e13bf404so315435ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Nov 2025 01:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764321628; x=1764926428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIbgpF0tUKF/S0uPv/Rwx0akddl4gBUjTHR+/b5Z31A=;
        b=UsH1yqCdpbJv4uuf703/8aUF9oqDVHa5tOPeec4Foh7zHewevXQ0RetQpd8K2mnh7h
         qGz5cVTVlMzYDCxb5KZDN2i4LD7BaLGMEAvSw3AordHW73Jwo5n9qz6DkDlllyNqxmkJ
         PAxxqFVrMammf4FDX3xQPVHNu1AmIYVNb1+UYY94+RjKKv358Cm/tsPl7+P0liNNzBdx
         RPSB5vZOQ2S2SlmsbhlGD5Keh5LcjnEZdAmGaHt2oCzfrtf0TqpneKX+KrAdFzmDLCMJ
         vw/+puJ3TmpKFkphcsvYE/nmJSb7g5MM6jzyLpmgdzHrJhOfxc9RmswXerMYAzLgV9tX
         bJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764321628; x=1764926428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tIbgpF0tUKF/S0uPv/Rwx0akddl4gBUjTHR+/b5Z31A=;
        b=ZFXk2PxykdZAvx8yIHBkulu/XBJDsGXyRQ/VTk0ipTN5kE8Dn90vod1Pko2jXzQMNF
         UKm/sJ0cJcqkhyZeSJUbu/1SJHyvBnEjeaysnlXMFGJPgY9t8K1qpwUHBviHhGb5aWGi
         xjivnvwzsdXPpE+MautzL01jXb24rpw0jOjbS0xcDTPHOoIZtceCn1comfPjxlM6Tn47
         w3l+VAd7H0BAX7MLtXQvOKaGFVqPY7bld14NVSMMOy6RUjUCFwV4DL8P/7n7Dg8aLFER
         FbiV8ERZF1rsNNXC90LjJDzf/tJlYzHrjhcPH5tZGtn3r4YsPwtx4A4vbwtW3KQZBNUg
         nugQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVWpEsU1fG24R12YOk/maAjEVMVB5zNGnzfkjmG4xV7fIPb2+UeA5tO1f1ISh2RDAEqIVob1p/UKwVHiUdCSqk@vger.kernel.org
X-Gm-Message-State: AOJu0YxZSPe8/F+jjYBzoFYibmaL9cD80trFD2b53gB9GdVPaGNWFU7U
	qYEpU6C5cjYSyO0TOKzPShIwdwLQQxbHx0aJnjG9YjdTlkWxLNTQiPFn7RidzKB0is7c1vhCd7v
	s149KaR5/AHQNkClx1J6nCtcTW/be6Ufk/mKimfAe
X-Gm-Gg: ASbGncuWugLn0E/n+W2VA3yqVQ++RkGWk3uPFxNXI0+zV1A7vUZXzhAwVMqDQL+8lkB
	gvL4eYrwmosrlo95GQCJ7z4QDbCAIm93AhNm5kRIcarCK0zmaKqHewvduZraGWopv/v4oQebIWH
	i7JQd7cXFztUyd3g/T9aJq2faaF/WNfzfh8+54xzKmSZFgrhiNL9ydbEtElNpm9Bk4BN1WrnkMn
	D00fjrl6frvl/GjuD990EnZrH7ctMWsbXR+4UyQwxUVhkaZYPqYRuJ+CyymKgx2p7K7/E8U
X-Google-Smtp-Source: AGHT+IFjIpcDDysu2XdOOKed0y5TZqtGEkbvlmZ0yj/BWZ+8PLklpwkrJ1cnF1Vbv3G6ELoj4RdsPNRgxj3ksgbyFxs=
X-Received: by 2002:a17:902:d4c6:b0:297:fe6f:a26e with SMTP id
 d9443c01a7336-29bc92a22b1mr3365395ad.14.1764321627501; Fri, 28 Nov 2025
 01:20:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com> <20251113032040.1994090-16-irogers@google.com>
 <095bbbb8-4a65-4888-aa7d-39ea09a52b84@amd.com>
In-Reply-To: <095bbbb8-4a65-4888-aa7d-39ea09a52b84@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 28 Nov 2025 01:20:14 -0800
X-Gm-Features: AWmQ_bkF8fGP4vbJl9oIkm3QM99ggKmIQ8q-CrsbRUgd4IKPd74d6mAfz0IBWrE
Message-ID: <CAP-5=fW6er5djFROP-SQ64uiN545wfHoyZazugya1h8JXXyvvQ@mail.gmail.com>
Subject: Re: [PATCH v8 15/52] perf jevents: Add RAPL event metric for AMD zen models
To: Sandipan Das <sandipan.das@amd.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ingo Molnar <mingo@redhat.com>, James Clark <james.clark@linaro.org>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 9:05=E2=80=AFPM Sandipan Das <sandipan.das@amd.com>=
 wrote:
>
> On 11/13/2025 8:50 AM, Ian Rogers wrote:
> > Add power per second metrics based on RAPL.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/pmu-events/amd_metrics.py | 31 +++++++++++++++++++++++++---
> >  1 file changed, 28 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-even=
ts/amd_metrics.py
> > index bc91d9c120fa..b6cdeb4f09fe 100755
> > --- a/tools/perf/pmu-events/amd_metrics.py
> > +++ b/tools/perf/pmu-events/amd_metrics.py
> > @@ -1,13 +1,36 @@
> >  #!/usr/bin/env python3
> >  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> >  import argparse
> > +import math
> >  import os
> > -from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescription=
s, LoadEvents,
> > -                    MetricGroup)
> > +from metric import (d_ratio, has_event, Event, JsonEncodeMetric, JsonE=
ncodeMetricGroupDescriptions,
> > +                    LoadEvents, Metric, MetricGroup, Select)
> >
> >  # Global command line arguments.
> >  _args =3D None
> >
> > +interval_sec =3D Event("duration_time")
> > +
> > +
> > +def Rapl() -> MetricGroup:
> > +    """Processor socket power consumption estimate.
> > +
> > +    Use events from the running average power limit (RAPL) driver.
> > +    """
> > +    # Watts =3D joules/second
> > +    # Currently only energy-pkg is supported by AMD:
> > +    # https://lore.kernel.org/lkml/20220105185659.643355-1-eranian@goo=
gle.com/
> > +    pkg =3D Event("power/energy\\-pkg/")
> > +    cond_pkg =3D Select(pkg, has_event(pkg), math.nan)
> > +    scale =3D 2.3283064365386962890625e-10
>
> It is unlikely that the scale factor will change, but would it still be s=
afer to read
> it from /sys/bus/event_source/devices/power/events/energy-pkg.scale?

Thanks Sandipan, I agree with the feedback but this isn't something
the metrics currently support. I'll keep it in mind.

Wrt, the other feedback, I'm wondering if we can get this series
landed and drop for now the patches that you have commented on? I'll
move them to a follow up series. That'd make the AMD patches here
something like:

Keep: [PATCH v8 15/52] perf jevents: Add RAPL event metric for AMD zen mode=
ls
Keep: [PATCH v8 16/52] perf jevents: Add idle metric for AMD zen models
Keep: [PATCH v8 17/52] perf jevents: Add upc metric for uops per cycle for =
AMD
Keep: [PATCH v8 18/52] perf jevents: Add br metric group for branch
statistics on AMD
Drop: [PATCH v8 19/52] perf jevents: Add software prefetch (swpf)
metric group for AMD
Drop: [PATCH v8 20/52] perf jevents: Add hardware prefetch (hwpf)
metric group for AMD
Keep: [PATCH v8 21/52] perf jevents: Add itlb metric group for AMD
Keep: [PATCH v8 22/52] perf jevents: Add dtlb metric group for AMD
Drop (or perhaps keep and followup with miss latency): [PATCH v8
23/52] perf jevents: Add uncore l3 metric group for AMD
Keep: [PATCH v8 24/52] perf jevents: Add load store breakdown metrics
ldst for AMD
Drop: [PATCH v8 25/52] perf jevents: Add ILP metrics for AMD
Keep: [PATCH v8 26/52] perf jevents: Add context switch metrics for AMD
Keep: [PATCH v8 27/52] perf jevents: Add uop cache hit/miss rates for AMD

Is it okay to use your reviewed-by tag on the kept patches? If I keep
patch 23 for uncore l3, with a follow up on miss latency, then are you
okay with that?

Thanks!
Ian


> > +    metrics =3D [
> > +        Metric("lpm_cpu_power_pkg", "",
> > +               d_ratio(cond_pkg * scale, interval_sec), "Watts"),
> > +    ]
> > +
> > +    return MetricGroup("lpm_cpu_power", metrics,
> > +                       description=3D"Processor socket power consumpti=
on estimates")
> > +
> >
> >  def main() -> None:
> >      global _args
> > @@ -33,7 +56,9 @@ def main() -> None:
> >      directory =3D f"{_args.events_path}/x86/{_args.model}/"
> >      LoadEvents(directory)
> >
> > -    all_metrics =3D MetricGroup("", [])
> > +    all_metrics =3D MetricGroup("", [
> > +        Rapl(),
> > +    ])
> >
> >      if _args.metricgroups:
> >          print(JsonEncodeMetricGroupDescriptions(all_metrics))
>
