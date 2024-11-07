Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6A4219C9F
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Nov 2024 21:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013237; cv=none; b=DxQ/x9wieatpXswB49NSPew2K2HbGpsG4g2ANk/i2oRswcNoKWj1CqWW0VCSO0c7nbWTQZuAthRPS4eWWxbAsZcksqEZCvUFckAgPDGPwGcRKvBjCVyjd1jyBrkjp5IfkifnWHNdOXqGKwOxt+P7AKVj6rtw35EJmbght0tXHkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013237; c=relaxed/simple;
	bh=keX7xGwX7MYGwxmIic0AuC3YTM8jpdrXYs/k0ngmQ7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKrER+wXKaehgnvFmtxMuG4wQqQ7Dp7KVHr6gjs49yq5yz3l4VPJhlLlBoUkUn7I4Xu4Bt7JVYsI7cJsM/xdKbI+utlo0JUuafmlXUecZYwrTSj7n6XAl1uoaYn3yGX05jeXC3i0pvsAmcoaMJ+C7RyyF3zFYKx4UpR/u4pQw84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D9wWnwdr; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D9wWnwdr"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a4e54d3cefso33455ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Nov 2024 13:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731013234; x=1731618034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lj1lqlbVhlvbu+/RLrnm6NE1xgAkiPfDRFpjRjmz9L4=;
        b=D9wWnwdrlgchzImBiLgo7C7VtuSruiVvl/37OA5dToS/1r6aCGhwWbk1NNmenzkBX/
         iX5ZRTiCCHeWoRdFu8YHpo/08xY3y5vb+XyGJSFqny0cwoKFDEU51IBh7WthJrJ1EBf6
         Q4NmUhSsE5nrjyMdM4My30q4kIGush9TzYNKjYU4/M1uSFhgf+LW0Vq/7HVdFMJZzFdZ
         MoYOOiwTNSZZDZFm+RIZ9qosOs/aOArGAmpdMqkJPvwDd+RnONPzkWtZwyGTGwkUP0QM
         M5DJPqaIpFppV4vtbsf9bxfjDhU1MMeh7Q1g2/bTstHTTBg5GwesqedcS9TLkjXjhSVC
         4RmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731013234; x=1731618034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lj1lqlbVhlvbu+/RLrnm6NE1xgAkiPfDRFpjRjmz9L4=;
        b=SQNgjy2+RnNvVMdgmJMzXmpb0VONqjItypGl/7aeXzFTakNusKIsWcEgsTDjchrZSH
         PdQisc/T4JFvuwG7FVkzCdttDZvPJgf7KisRDV40cVgD1G703l9aF81BC4d2M8flrWVp
         zpQZMYsR1IJ4OWntkiH24AAjbjznACq7WAzznQV+s/1MsEOo/rG6fZQIyZl9quQV7lhu
         CktivaCKQwrqDCReffel19nW2tOlQXmAeiBfYNqKH3EYnwVhulrE/QwtNG/XObKE0v2e
         GNaYnOdMY4dhhCbjcxG5v3hRL3bZ/qeQW4Zqp5qL4QrxiNRxYJQVDaNejtRWNyBYBKiu
         pDdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqmC8CBlftcw0uDruBtCj724Jd0K82IrSpfo7q+JcIOu0pIcaE08glutt6nTXgJGotJWR66Ij/6F3gy6Xr+Ep/@vger.kernel.org
X-Gm-Message-State: AOJu0YwMNMRBsoOP/PC3OYqzb11yXI70YE8OSH76u3ptbi//cz3GxrYy
	DR6Igikl2vcbROZUW88hhcXwCqqRwfZN6KrD/BYIrX82OMjPAq085Ju02GvXzjkw+b9yofeQ6oB
	fpkoTFBd37cvIHUIq9o+Cg6x8NYynpCX1ANOA
X-Gm-Gg: ASbGncviN7P4V4Y9Cn6u+pdADATeXo0Fzijb/eP1qgLtjoaaId5tvjzomTS4tQJwXC9
	08lmIdT+E+bJ6Cmr7ORFMgo7t2ZOK/Gps3MSSomLwO8Jz7dP+3/OPYT9entPK2NE=
X-Google-Smtp-Source: AGHT+IGcRcqI0PSnPZwOxHTQ71OLkPZYThs6foUL0urhNMxZhUyd24sgROdEEKecZaWcpsiOYicmW5+wfLmnUckgo3w=
X-Received: by 2002:a05:6e02:188b:b0:39b:b1f:5be1 with SMTP id
 e9e14a558f8ab-3a6e7a22f85mr6445275ab.1.1731013234215; Thu, 07 Nov 2024
 13:00:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com> <20240926175035.408668-10-irogers@google.com>
 <0d48bf82-5de2-4928-bd15-1c5abfd4f087@linux.intel.com> <CAP-5=fWGGQh_Kwr5mWPQv6RO=o8bk2mmShJ6MjR9i1v42e0Ziw@mail.gmail.com>
 <c48a6f46-5991-40dc-abac-f66f2706c84e@linux.intel.com>
In-Reply-To: <c48a6f46-5991-40dc-abac-f66f2706c84e@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 7 Nov 2024 13:00:23 -0800
Message-ID: <CAP-5=fWwts12ucSAXBHW7-Q+Asm1GUnT7tTPZ3_D5xhHMZ-8ig@mail.gmail.com>
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

On Thu, Nov 7, 2024 at 11:36=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
> On 2024-11-07 12:12 p.m., Ian Rogers wrote:
> > On Thu, Nov 7, 2024 at 7:00=E2=80=AFAM Liang, Kan <kan.liang@linux.inte=
l.com> wrote:
> >>
> >>
> >> On 2024-09-26 1:50 p.m., Ian Rogers wrote:
> >>> The ports metric group contains a metric for each port giving its
> >>> utilization as a ratio of cycles. The metrics are created by looking
> >>> for UOPS_DISPATCHED.PORT events.
> >>>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>  tools/perf/pmu-events/intel_metrics.py | 33 ++++++++++++++++++++++++=
--
> >>>  1 file changed, 31 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-=
events/intel_metrics.py
> >>> index f4707e964f75..3ef4eb868580 100755
> >>> --- a/tools/perf/pmu-events/intel_metrics.py
> >>> +++ b/tools/perf/pmu-events/intel_metrics.py
> >>> @@ -1,12 +1,13 @@
> >>>  #!/usr/bin/env python3
> >>>  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> >>>  from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEn=
codeMetric,
> >>> -                    JsonEncodeMetricGroupDescriptions, LoadEvents, M=
etric,
> >>> -                    MetricGroup, MetricRef, Select)
> >>> +                    JsonEncodeMetricGroupDescriptions, Literal, Load=
Events,
> >>> +                    Metric, MetricGroup, MetricRef, Select)
> >>>  import argparse
> >>>  import json
> >>>  import math
> >>>  import os
> >>> +import re
> >>>  from typing import Optional
> >>>
> >>>  # Global command line arguments.
> >>> @@ -260,6 +261,33 @@ def IntelBr():
> >>>                       description=3D"breakdown of retired branch inst=
ructions")
> >>>
> >>>
> >>> +def IntelPorts() -> Optional[MetricGroup]:
> >>> +  pipeline_events =3D json.load(open(f"{_args.events_path}/x86/{_arg=
s.model}/pipeline.json"))
> >>> +
> >>> +  core_cycles =3D Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
> >>> +                      "CPU_CLK_UNHALTED.DISTRIBUTED",
> >>> +                      "cycles")
> >>> +  # Number of CPU cycles scaled for SMT.
> >>> +  smt_cycles =3D Select(core_cycles / 2, Literal("#smt_on"), core_cy=
cles)
> >>> +
> >>> +  metrics =3D []
> >>> +  for x in pipeline_events:
> >>> +    if "EventName" in x and re.search("^UOPS_DISPATCHED.PORT", x["Ev=
entName"]):
> >>> +      name =3D x["EventName"]
> >>> +      port =3D re.search(r"(PORT_[0-9].*)", name).group(0).lower()
> >>> +      if name.endswith("_CORE"):
> >>> +        cyc =3D core_cycles
> >>> +      else:
> >>> +        cyc =3D smt_cycles
> >>> +      metrics.append(Metric(port, f"{port} utilization (higher is be=
tter)",
> >>> +                            d_ratio(Event(name), cyc), "100%"))
> >>
> >> The generated metric highly depends on the event name, which is very
> >> fragile. We will probably have the same event in a new generation, but
> >> with a different name. Long-term maintenance could be a problem.
> >> Is there an idea regarding how to sync the event names for new generat=
ions?
> > I agree with the idea that it is fragile, it is also strangely robust
> > as you say, new generations will gain support if they follow the same
> > naming convention. We have tests that load bearing metrics exists on
> > our platforms so maybe the appropriate place to test for existence is
> > in Weilin's metrics test.
> >
> >
> >> Maybe we should improve the event generation script and do an automati=
c
> >> check to tell which metrics are missed. Then we may decide if updating
> >> the new event name, dropping the metric or adding a different metric.
> > So I'm not sure it is a bug to not have the metric, if it were we
> > could just throw rather than return None. We're going to run the
> > script for every model including old models like nehalem, so I've
> > generally kept it as None. I think doing future work on testing is
> > probably best. It would also indicate use of the metric if people
> > notice it missing (not that the script aims for that =F0=9F=99=82 ).
>
> The maintenance is still a concern, even if we have a way to test it
> out. There is already an "official" metric published in GitHub, which is
> maintained by Intel. To be honest, I don't think there is more energy to
> maintain these "non-official" metrics.
>
> I don't think it should be a bug without these metrics. So it's very
> likely that the issue will not be addressed right away. If we cannot
> keep these metrics updated for the future platforms, I couldn't find a
> reason to have them.

So I think there are a few things:
1) I'd like there to be a non-json infrastructure for events that can
handle multiple models. Some failings of json are its inability to
validate events, long lines, lack of comments, metric expression
strings that aren't inherently sound, etc.  I'd like to make it so we
can have json metrics for everything, ie remove the hardcoded metrics
that play badly with event sharing, etc. Doing this by updating every
json would be tedious and excessively noisy.
2) There are "official" metrics from Intel and I've worked for the
establishment of that. That doesn't mean every Intel metric is in the
official metrics. Servers are better served than client machines. Core
TMA metrics are well served but uncore less so.
3) Are perf metrics perfect with some kind of warranty? Well no, as
your reviews in this thread have shown SMI cost on hybrid is likely
broken. We don't intentionally try to have broken metrics and fix them
asap when they come up. GPLv2 has an explicit "no warranty" section.
Now Intel have experimental and non-experimental events, we update the
comments of metrics using those to highlight that the underlying
events are experimental:
https://github.com/googleprodkernel/linux-perf/blob/google_tools_master/too=
ls/perf/pmu-events/metric.py#L598
If there are bugs in the metrics then open source, sharing and fixing
benefits everyone.
4) Am I looking for energy from Intel to maintain these metrics? No.
I'm trying to stop carrying the patches just inside of Google's tree.

Thanks,
Ian
