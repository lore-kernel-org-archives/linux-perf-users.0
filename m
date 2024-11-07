Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A52191F66
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Nov 2024 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730999558; cv=none; b=qeZNux3wMnnMHWZ21jEnGS9OMu+RFQB+qIe+AOUB9wfhon8aHAZEDigrCiGzxLiZmh6UPOoiziRLLIZtxTqZFJeYZct/gOVCUcjr7zWH0zAkpex9HPCIYRcSV9Vn5Mg8h0BM598j0H0e6OgjS/cYYjY/uIc7e5aVk9cZX7oGdx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730999558; c=relaxed/simple;
	bh=Fko8ahXBkH5aH664McIMR1mSzMhk8KH28E/TtmDGays=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBvsFzJcbWdk8UKRSrqWTxkylriEBKUkF2YstJb0dtM5RThYscK+jDxs0BwirTon8sd/mB3WkhUgSD6Nu00s3z1p3XaIylGWTA01+9XnYBrJnz2MRfV3qYWD5d+NRMFyuxt5afckRxpnfLvltb5OyaRP+k2Cn7hFXWMdPfS8mlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BKBcjveg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BKBcjveg"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20ca03687fdso203455ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Nov 2024 09:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730999556; x=1731604356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NWh57MfDRD05DzT/rzXr1TJz9IgYGlNmYb4EAOieGo=;
        b=BKBcjvegV0tVSapGX0HSXKi7K1H7eTQmbjUonKWhwBSZwp7p55yQUKK5Tt4W04mX9J
         KffkGsVvXpVlwAy2Al68gs6Vgm9/nWG5AZfUsuncK1oE/DMBh8p3DezYn46s/qswImVj
         6qeqm+A/c/lgwvEIHnLQ57a1+pyrxp7Wq48y+RC98iXwRQHASdlT2YBizjOsPm6qfS0j
         1f80fWYOGXq/HV5yuD1pwHfE2uxqPnIz+8ICGCIU2bHD6tUC7/dYDYRB89aVwcjEUp4c
         vnXpzg7uFsngKjkPco7rDZmF8HSa+HmTkoRBDtCEn7mtZXW61RQU6kVoo5het+dG9eeb
         +79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730999556; x=1731604356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NWh57MfDRD05DzT/rzXr1TJz9IgYGlNmYb4EAOieGo=;
        b=FqgvuUEbvZnHoVsjApluf/LxTNOcYwGBIdR159p5/ylpphPg7KYKPfAchwM12KnTue
         FHg84vTE1voFpYZwR55kiateun4uwSas+otND6a3Hsesp4/PXv5GAZSG71rhNH8asysg
         ip3mMxUD93hcHrW90qgEVcy9c6q3KZm6IJDwVWelDaIyWrivDFmkT/sxclVRbWWbdjFp
         QOO5useAFxJ43/rfjHk90MNGy0Ju6UHH/uvyyJG54cgJhKueq9WqljxnNf+0YdIshX0T
         kNL0nNabrft7xY7l+votU4tmvww29OKtCcDMXjQOM88T2uSmKCc595HJxYSTbsDFBN0P
         EMTA==
X-Forwarded-Encrypted: i=1; AJvYcCVjyQVy35i0+/U92wccVPN0ijWoZGlN3Pwoiat8SrUmDB6HLIEVruUEK7u8awnSUjeER2veFo7/bYcwHSJBB8hq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1XdRY0pevXSm9PDPFwzqYrxaX3Iqdbu6RZtIcC9esBn0H+Tam
	h1eK54Q0zBDNGL+krN2TlpQACIHzLuiRWxtkFQJc0fDeB5utPblUEsJCszjWEHK9Zc0d/19awvM
	zihjYJOz32BghVUtoDECJ5j2hRAK5m4PBdd3Q
X-Gm-Gg: ASbGnctTRsMjJnnZDXqgHuN9Uo70xD6DPTNVSeFmsW3Zo6xwRgKIXWQh8cuI9mqMxmA
	EhuBcdqusmd+TftPzxiJYP01zpshL/v69JXrg1PMSvYZpnyT1i8viQIoIapkc6/I=
X-Google-Smtp-Source: AGHT+IEpMNMu/yZ92qvLmOnuklE7ty5UbDfNsSGZQy8H1saraOvpqVzLvr+TkG5LQ9RC7i5mxNV+DpzJOwqrKT/v+OM=
X-Received: by 2002:a17:903:234a:b0:20c:675d:920f with SMTP id
 d9443c01a7336-21174a00513mr3732345ad.25.1730999555396; Thu, 07 Nov 2024
 09:12:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com> <20240926175035.408668-10-irogers@google.com>
 <0d48bf82-5de2-4928-bd15-1c5abfd4f087@linux.intel.com>
In-Reply-To: <0d48bf82-5de2-4928-bd15-1c5abfd4f087@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 7 Nov 2024 09:12:23 -0800
Message-ID: <CAP-5=fWGGQh_Kwr5mWPQv6RO=o8bk2mmShJ6MjR9i1v42e0Ziw@mail.gmail.com>
Subject: Re: [PATCH v4 09/22] perf jevents: Add ports metric group giving
 utilization on Intel
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 7:00=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2024-09-26 1:50 p.m., Ian Rogers wrote:
> > The ports metric group contains a metric for each port giving its
> > utilization as a ratio of cycles. The metrics are created by looking
> > for UOPS_DISPATCHED.PORT events.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/pmu-events/intel_metrics.py | 33 ++++++++++++++++++++++++--
> >  1 file changed, 31 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-ev=
ents/intel_metrics.py
> > index f4707e964f75..3ef4eb868580 100755
> > --- a/tools/perf/pmu-events/intel_metrics.py
> > +++ b/tools/perf/pmu-events/intel_metrics.py
> > @@ -1,12 +1,13 @@
> >  #!/usr/bin/env python3
> >  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> >  from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEnco=
deMetric,
> > -                    JsonEncodeMetricGroupDescriptions, LoadEvents, Met=
ric,
> > -                    MetricGroup, MetricRef, Select)
> > +                    JsonEncodeMetricGroupDescriptions, Literal, LoadEv=
ents,
> > +                    Metric, MetricGroup, MetricRef, Select)
> >  import argparse
> >  import json
> >  import math
> >  import os
> > +import re
> >  from typing import Optional
> >
> >  # Global command line arguments.
> > @@ -260,6 +261,33 @@ def IntelBr():
> >                       description=3D"breakdown of retired branch instru=
ctions")
> >
> >
> > +def IntelPorts() -> Optional[MetricGroup]:
> > +  pipeline_events =3D json.load(open(f"{_args.events_path}/x86/{_args.=
model}/pipeline.json"))
> > +
> > +  core_cycles =3D Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
> > +                      "CPU_CLK_UNHALTED.DISTRIBUTED",
> > +                      "cycles")
> > +  # Number of CPU cycles scaled for SMT.
> > +  smt_cycles =3D Select(core_cycles / 2, Literal("#smt_on"), core_cycl=
es)
> > +
> > +  metrics =3D []
> > +  for x in pipeline_events:
> > +    if "EventName" in x and re.search("^UOPS_DISPATCHED.PORT", x["Even=
tName"]):
> > +      name =3D x["EventName"]
> > +      port =3D re.search(r"(PORT_[0-9].*)", name).group(0).lower()
> > +      if name.endswith("_CORE"):
> > +        cyc =3D core_cycles
> > +      else:
> > +        cyc =3D smt_cycles
> > +      metrics.append(Metric(port, f"{port} utilization (higher is bett=
er)",
> > +                            d_ratio(Event(name), cyc), "100%"))
>
>
> The generated metric highly depends on the event name, which is very
> fragile. We will probably have the same event in a new generation, but
> with a different name. Long-term maintenance could be a problem.
> Is there an idea regarding how to sync the event names for new generation=
s?

I agree with the idea that it is fragile, it is also strangely robust
as you say, new generations will gain support if they follow the same
naming convention. We have tests that load bearing metrics exists on
our platforms so maybe the appropriate place to test for existence is
in Weilin's metrics test.


> Maybe we should improve the event generation script and do an automatic
> check to tell which metrics are missed. Then we may decide if updating
> the new event name, dropping the metric or adding a different metric.

So I'm not sure it is a bug to not have the metric, if it were we
could just throw rather than return None. We're going to run the
script for every model including old models like nehalem, so I've
generally kept it as None. I think doing future work on testing is
probably best. It would also indicate use of the metric if people
notice it missing (not that the script aims for that :-) ).

Thanks,
Ian

> Thanks,
> Kan
>
> > +  if len(metrics) =3D=3D 0:
> > +    return None
> > +
> > +  return MetricGroup("ports", metrics, "functional unit (port) utiliza=
tion -- "
> > +                     "fraction of cycles each port is utilized (higher=
 is better)")
> > +
> > +
> >  def IntelSwpf() -> Optional[MetricGroup]:
> >    ins =3D Event("instructions")
> >    try:
> > @@ -352,6 +380,7 @@ def main() -> None:
> >        Smi(),
> >        Tsx(),
> >        IntelBr(),
> > +      IntelPorts(),
> >        IntelSwpf(),
> >    ])
> >
>
