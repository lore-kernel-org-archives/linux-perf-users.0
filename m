Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5ED206513
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Nov 2024 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730914964; cv=none; b=MxKRt1OHCKLvYwSJe60Q2wRK8IxEHgfc2RhtoFjhUOSvHIfHHrfCPfrYumW9UOwTLJu+BnDGHnz0p0eeVit4J91fcX3wnJwmMYOc3uHyJKeJEINRPULRHI+gWKbi/fv2s+Z77e4SaXxrhuNkT9jnsq6GVHfPWgkcdYWh4ztF6e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730914964; c=relaxed/simple;
	bh=JAmKdDLHO4WiWe7FnOBRvYONuKfK7l3hiQuYOmDf1lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVKxueodlWIvAGHJXvP8nmlT/KMLp+oarQM0AfvnWO26Z8jMG30tpVniJdT43dZLZl9iQ0mCNYVp7Gy2HLWTCFrnAiwMwFTv+kAg8dtIutlwS+u9dNXIc9UPBwrHtkgOjwe2550HeMsQvsr8ujxSbe0bNKKL12brHFGKQUp60eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lhsGJ+0e; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lhsGJ+0e"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460a8d1a9b7so290471cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Nov 2024 09:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730914962; x=1731519762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNGfeMaG13NKGiTObAwhgRE0i2OSgvJ6Y8wK5hMh0P0=;
        b=lhsGJ+0eU/DQ7Vb40AH/EFg44L9iufNfUK23H5EDzEKzE5WWLxL4TkgQST0o8+5SYN
         03T+frZjaGspzJCzP0jr6d25R65NPrUdimYYyfsF731vlFEC3fb4955seDtstGakgjTy
         pR3Qg4VMLr8U6VRqwHb5MxIz8QKDdwTgcSYhJLX0mxKQwL8Uip+NdaOTrGjVUoT37rjT
         2GSBEJJD6EZoZg2Yq8mNO92Kohg7ah3BHy9AMGeaZOGspvkTNCFb4vA0hMhtOB0X+95i
         av1hDdxOhWkYRtagjF3WdpnJngCDxHsti0UDei43qdAWbO/8vKQFAOj2Jc+uU5ihpEEx
         LICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730914962; x=1731519762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNGfeMaG13NKGiTObAwhgRE0i2OSgvJ6Y8wK5hMh0P0=;
        b=nRqOgQqmyYwLog8SZuvTe7e4K8T1gUNCra8I3FDJzp8KYiHfDFpy23BahOY1vpJ+lQ
         aDohYQJ3SAhwxVgQ5NKNOrYkdKbIl9UQmyW1vuzYv+m+nICeKfD+9Lgx1oNoUCRZ1Dlq
         I32IvJdDeEoNA30qfzY975LXtQ5bE7ZuVe0uPESTzjrRRxjq7qMpTB2JEt0vsdco5SgJ
         9BQBLSRhIR+3eBUrRKtEEro6JAQhVykpwgHVwFz3duvMrx3+pOVQx4LzT1x7fEt+f6kR
         iou2JUphLCi4X3CljCynQoOG25D1AVfINJWx8wYureHfS6+/FkqHRXdGl1R74WMUp/r5
         Bjcg==
X-Forwarded-Encrypted: i=1; AJvYcCVvS+n8CHl/MDsddcKlax1aYc63mQmMs4WAb58/wuSGT/dSR9WC4ioPC+fBCyCsqKjlFtaNKYnEK837uPwQQ0bX@vger.kernel.org
X-Gm-Message-State: AOJu0YxJW/Fo25IUPw06Zi7qqyBJU+Xfb30QUjpje3l5GX6K8tPSNJug
	3xu68JhKLiLLm9uwLXFG2T/RRDtNovM4ADySNbw/W59UOPiZ4evMYcNHI/Qe66oKiqCToKW3Pft
	tESTMl4y4qrnnXhBtP9v+blTR7eHhoxqZK/n+
X-Gm-Gg: ASbGncva0oMUAzZOmAi4eZwD5hePTLlVtHdL4oqdB8eM2WLIa5LAuTRY0OVpvPrsCxX
	ObKLE2ooxsXaNpRSwXcxBk7vstZxilrMk+HLQ/Cb1ir1uvRkT7E2tK80sDUrfpkQ=
X-Google-Smtp-Source: AGHT+IHlUkkiiszqoJZfXqyK3JEKKtBjWrWTgKuDK+Z6e3C+Sp3IAEUfWZWK4X8dK+PdlN0B1hUNKfspjl/vPAPNTYw=
X-Received: by 2002:ac8:584c:0:b0:461:70cc:3799 with SMTP id
 d75a77b69052e-462fa610b20mr600411cf.21.1730914961971; Wed, 06 Nov 2024
 09:42:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com> <20240926175035.408668-4-irogers@google.com>
 <30c22df5-9815-4a73-9a12-165d9045a667@linux.intel.com>
In-Reply-To: <30c22df5-9815-4a73-9a12-165d9045a667@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 6 Nov 2024 09:42:30 -0800
Message-ID: <CAP-5=fXvH+=OQJM9uK9eOFrFfvy3tMVE00uejWxHeCuur4ZuUg@mail.gmail.com>
Subject: Re: [PATCH v4 03/22] perf jevents: Add smi metric group for Intel models
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

On Wed, Nov 6, 2024 at 9:32=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2024-09-26 1:50 p.m., Ian Rogers wrote:
> > Allow duplicated metric to be dropped from json files.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/pmu-events/intel_metrics.py | 21 ++++++++++++++++++++-
> >  1 file changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-ev=
ents/intel_metrics.py
> > index f875eb844c78..f34b4230a4ee 100755
> > --- a/tools/perf/pmu-events/intel_metrics.py
> > +++ b/tools/perf/pmu-events/intel_metrics.py
> > @@ -2,7 +2,7 @@
> >  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> >  from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
> >                      JsonEncodeMetricGroupDescriptions, LoadEvents, Met=
ric,
> > -                    MetricGroup, Select)
> > +                    MetricGroup, MetricRef, Select)
> >  import argparse
> >  import json
> >  import math
> > @@ -56,6 +56,24 @@ def Rapl() -> MetricGroup:
> >                       description=3D"Running Average Power Limit (RAPL)=
 power consumption estimates")
> >
> >
> > +def Smi() -> MetricGroup:
> > +    aperf =3D Event('msr/aperf/')
> > +    cycles =3D Event('cycles')
> > +    smi_num =3D Event('msr/smi/')
> > +    smi_cycles =3D Select(Select((aperf - cycles) / aperf, smi_num > 0=
, 0),
> > +                        has_event(aperf),
> > +                        0)
> > +    return MetricGroup('smi', [
> > +        Metric('smi_num', 'Number of SMI interrupts.',
> > +               Select(smi_num, has_event(smi_num), 0), 'SMI#'),
> > +        # Note, the smi_cycles "Event" is really a reference to the me=
tric.
> > +        Metric('smi_cycles',
> > +               'Percentage of cycles spent in System Management Interr=
upts. '
> > +               'Requires /sys/devices/cpu/freeze_on_smi to be 1.',
>
> It seems not work for hybrid?

Thanks. The code is a migration of existing metrics that exist for hybrid:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json?h=3Dperf-tools=
-next#n74
I still lack an easy way to test on hybrid, but I think fixing that
case can be follow on work.

Thanks,
Ian
