Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D22207A2E
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Nov 2024 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916921; cv=none; b=hWLHQ/JwxeFMzwIHnI4/ztU7EchutNlI4JrqQVlSqa6RCGJz8JsL18qZoHUJfJlSxyNLj+29JKdji70LOUqPOpOStObzTCdT28gfkLYi5YLIrFsJXKP/b1eBOmmS7ZuHmgR8e6KYzz7T3y0QRaRAKGuiHQCK1BxA45OU3B/P8oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916921; c=relaxed/simple;
	bh=X/z/fq3fM2vDFRaUyPgNlBTfT3p13Tlyf7O49OnaLzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eH3qJNwBA16Ei1CNMwwoTV8eDzuDA7fhee8xPBTcrkMnx5dyhSL1u1GU+KpFE70RWIF65Hu84D2ck5jmtCZwHvK/kDZdrSfeovQnlXJkca02Ex3WkmFIP5RFO7HN42MLu3S++NRN236x7PaDDPHmgrSVhvzpHhzw9jvOS61Wm70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hbFBv1a6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hbFBv1a6"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20ca03687fdso10805ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Nov 2024 10:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730916919; x=1731521719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2xLYmuySCzFVrJ3cUAOni0+7Dd9Fa47pe2AtilN+Ak=;
        b=hbFBv1a6ZNejTSAnUL3O4TH1ciA7bdGcYwSoRFCTjD83F3aQT4ib3PEDihfCsjukaG
         0gObQBGKNpN42/DHb33vFGqYKrdRFIEpRK7OOF41M/Q8qrnGUSeV/P3em0cKFamS0yQt
         V8m+J4Ca2e1egSbR4QK+W6vw+D6bW+ehgjGs2iK2PTLZKBaiagQkTLO01ygT+KHkapfu
         mpeRTVtD7M6QFh/nCbu1IiLL0NRFKMmKnpa/O0CKiecDqXKzQXWyUQiEl3nPnkVA9AW7
         QkTjHwuwlbF52KLpwxFt84ZiLaH6nYbn77kUOm0SE8XpOSlwD1zBO3C0/r1GBCWItocN
         +Cng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730916919; x=1731521719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2xLYmuySCzFVrJ3cUAOni0+7Dd9Fa47pe2AtilN+Ak=;
        b=C5+aDNhi4D8fCAO76n/PJNVwjeNn037EVZwT+Tp7UBfUyiIChhaKKIGZ4prh4iMVjY
         ZhJQo1ydTz/alubOELAPcZytSwhaQQc14kkddl+l3bANZTcXPk9lsHAcDyLJwO9CUsdn
         eRpotLvSqtEux4nmApOSObXbYketIVT1IhhhP8j4Sf9ve8P4/XEUjUpdHpPvlEdFp499
         HJr8tUyg2pc/T5RGtJOCLDcWK3AqW0FOOIjxA+Rge2lR5wyqj7VMnZUayzpv6v/LDGmS
         5JhdNp0S9wr0pE703pF+gAEaAQXnbE/PzaJXbBK9XPquS5ADuqUEHepQBmfctspy4DaM
         WBVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7G5pHz5xxJ6g5c5XPltUh/06KBYQUTb8oYfdprbRxODrFTeyRb8GkCHF/dj4BaLXcfsGRY1OWxAEKnpF3jX7F@vger.kernel.org
X-Gm-Message-State: AOJu0YxiQ2GuzOCGQl4qZo3JWWFS4r3wHyllZvEVy36buNsos9I+Jbln
	JpMZjrbE0olohJmHZlrmckOH9dAAkE0Ys/PgAID3j2jpMjf+0TYLPe3FKN77GV2c7vB2kJNfs6b
	uiMuIauz+p3ss1x1RKn4SXLX1gmFQ1/mItZoL
X-Gm-Gg: ASbGncte2thYcKeHirg2jkAlck1rSTeo78gC3gZ+XEpHfO7VkDPEyg2wO2kUdGc8i1n
	hw4NlbtMWmubdJ7+rOywZ1qoC77inrd3J5Zn8GxCMOKLEUqqkCNXJi1RAPTZEsXo=
X-Google-Smtp-Source: AGHT+IEgroDsp0onx0K7wietJn6JnANYvY4f2U8zLM51cmNpvxlAnM0RNe75sEdp5mOQBFO8L+V6+wouh+x1KMnrO/U=
X-Received: by 2002:a17:903:234a:b0:20c:675d:920f with SMTP id
 d9443c01a7336-21174a00513mr582095ad.25.1730916918975; Wed, 06 Nov 2024
 10:15:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com> <20240926175035.408668-7-irogers@google.com>
 <244b4c80-2ab2-4248-b930-22fea9ed6429@linux.intel.com>
In-Reply-To: <244b4c80-2ab2-4248-b930-22fea9ed6429@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 6 Nov 2024 10:15:07 -0800
Message-ID: <CAP-5=fW1dACyxesnjpMQLAgomnRH+nA1sVphbpLyCFN3A79xSQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/22] perf jevents: Add tsx metric group for Intel models
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

On Wed, Nov 6, 2024 at 9:53=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2024-09-26 1:50 p.m., Ian Rogers wrote:
> > Allow duplicated metric to be dropped from json files. Detect when TSX
> > is supported by a model by using the json events, use sysfs events at
> > runtime as hypervisors, etc. may disable TSX.
> >
> > Add CheckPmu to metric to determine if which PMUs have been associated
> > with the loaded events.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/pmu-events/intel_metrics.py | 52 +++++++++++++++++++++++++-
> >  1 file changed, 51 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-ev=
ents/intel_metrics.py
> > index f34b4230a4ee..58e243695f0a 100755
> > --- a/tools/perf/pmu-events/intel_metrics.py
> > +++ b/tools/perf/pmu-events/intel_metrics.py
> > @@ -1,12 +1,13 @@
> >  #!/usr/bin/env python3
> >  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > -from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
> > +from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEnco=
deMetric,
> >                      JsonEncodeMetricGroupDescriptions, LoadEvents, Met=
ric,
> >                      MetricGroup, MetricRef, Select)
> >  import argparse
> >  import json
> >  import math
> >  import os
> > +from typing import Optional
> >
> >  # Global command line arguments.
> >  _args =3D None
> > @@ -74,6 +75,54 @@ def Smi() -> MetricGroup:
> >      ], description =3D 'System Management Interrupt metrics')
> >
> >
> > +def Tsx() -> Optional[MetricGroup]:
> > +  pmu =3D "cpu_core" if CheckPmu("cpu_core") else "cpu"
> > +  cycles =3D Event('cycles')
>
> Isn't the pmu prefix required for cycles as well?

Makes sense.

> > +  cycles_in_tx =3D Event(f'{pmu}/cycles\-t/')
> > +  cycles_in_tx_cp =3D Event(f'{pmu}/cycles\-ct/')
> > +  try:
> > +    # Test if the tsx event is present in the json, prefer the
> > +    # sysfs version so that we can detect its presence at runtime.
> > +    transaction_start =3D Event("RTM_RETIRED.START")
> > +    transaction_start =3D Event(f'{pmu}/tx\-start/')
>
> What's the difference between this check and the later has_event() check?
>
> All the tsx related events are model-specific events. We should check
> them all before using it.

So if there is PMU in the Event name then the Event logic assumes you
are using sysfs and doesn't check the event exists in json. As you
say, I needed a way to detect does this model support TSX? I wanted to
avoid a model lookup table, so I used the existence of
RTM_RETIRED.START for a model as the way to determine if the model
supports TSX. Once we know we have a model supporting TSX then we use
the sysfs event name and has_event check, so that if the TSX and the
event have been disabled the metric doesn't fail parsing.

So, the first check is a compile time check of, "does this model have
TSX?". The "has_event" check is a runtime thing where we want to see
if the event exists in sysfs in case the TSX was disabled say in the
BIOS.

Thanks,
Ian

>
> Thanks,
> Kan
> > +  except:> +    return None
> > +
> > +  elision_start =3D None
> > +  try:
> > +    # Elision start isn't supported by all models, but we'll not
> > +    # generate the tsx_cycles_per_elision metric in that
> > +    # case. Again, prefer the sysfs encoding of the event.
> > +    elision_start =3D Event("HLE_RETIRED.START")
> > +    elision_start =3D Event(f'{pmu}/el\-start/')
> > +  except:
> > +    pass
> > +
> > +  return MetricGroup('transaction', [
> > +      Metric('tsx_transactional_cycles',
> > +             'Percentage of cycles within a transaction region.',
> > +             Select(cycles_in_tx / cycles, has_event(cycles_in_tx), 0)=
,
> > +             '100%'),
> > +      Metric('tsx_aborted_cycles', 'Percentage of cycles in aborted tr=
ansactions.',
> > +             Select(max(cycles_in_tx - cycles_in_tx_cp, 0) / cycles,
> > +                    has_event(cycles_in_tx),
> > +                    0),
> > +             '100%'),
> > +      Metric('tsx_cycles_per_transaction',
> > +             'Number of cycles within a transaction divided by the num=
ber of transactions.',
> > +             Select(cycles_in_tx / transaction_start,
> > +                    has_event(cycles_in_tx),
> > +                    0),
> > +             "cycles / transaction"),
> > +      Metric('tsx_cycles_per_elision',
> > +             'Number of cycles within a transaction divided by the num=
ber of elisions.',
> > +             Select(cycles_in_tx / elision_start,
> > +                    has_event(elision_start),
> > +                    0),
> > +             "cycles / elision") if elision_start else None,
> > +  ], description=3D"Breakdown of transactional memory statistics")
> > +
> > +
> >  def main() -> None:
> >    global _args
> >
> > @@ -100,6 +149,7 @@ def main() -> None:
> >        Idle(),
> >        Rapl(),
> >        Smi(),
> > +      Tsx(),
> >    ])
> >
> >
>
