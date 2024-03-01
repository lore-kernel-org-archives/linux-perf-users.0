Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350825C9A
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311090; cv=none; b=YIAXNKkyO0gt+SLQfg0kFzo/9OtdVGx6lV6CLSfxwYFeorBknQV5LyFTxKhQpYAbH0fLUu2TkSEGf9v7Tz1ZFvXAwDrZVQ6GryO+BXoZ7xb8QvG2HXfwwLSSUiA1deI5lWUGN8PM5s99HOBJat6iUGheVg3cVnNwtWYxi9F9Bjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311090; c=relaxed/simple;
	bh=UwSLOztaU4xS23FC7UA8haLkrJtuX7Ui3gT2b4+tasc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ca7feOiu4/ntmxln2hX+Svht8Oe7CmOzs/z1owCC+Ktszt3OsXKd3RreCdAOZhPtEQ78w3H1me3K7SC9ofc6TfXTQmoYpuFp4yCMMKUweFSNXSiYHrnh7GYlrcWDq4ctluofqkuUL4sUslrwNw5Vimv4pAwkm0kG1VCdTGHl+SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0G4+89tU; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0G4+89tU"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36575bb8443so152015ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 08:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709311087; x=1709915887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgTvz/kj0/zZVy0gcjbfgQ3NGR++QmNhx15pxeEz/jk=;
        b=0G4+89tUNAysg7nwTkmMEAmPkrWtIGEDqxZIrg25jr61OZKxog2Cgk8YAM4mbkheDO
         B++eSWPboAjYBiu7rn9IAY0rf5A+mg42mT//SW1o/hXdPDLzyDKbaZ0ivSbjWiiVHuEq
         mWNSA2vZLzQMBDOriqOrL083w6plv1fHSLe1U9uIY5zVIXEPpsE74/jGoM10gj4EW86S
         ZEbgd9fKBPNGuHH56nB9PY6sp8BWL1NkH7PFgON4p2fJhF9qVnYD4uBBl6jrL/BNOaxM
         H7CmijAzrGgdVD0luuIIHWIc3mWYS9pswhtqfh/IuLPOvhy8jHU0FMUaA9EhXvMsVaXG
         7J+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709311087; x=1709915887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgTvz/kj0/zZVy0gcjbfgQ3NGR++QmNhx15pxeEz/jk=;
        b=tYuZ/UWwNEMhShzSrV9vOTkASQMGQFUsuywrwgUMJlrX28JAZ2LSWzGVPgiksh4h+4
         Yx/SY7jURicpxQa3AQzfNztxfZGhyxFnpa8u91Cd0g+Jj6hE/CdiSOA6gI/BX8qxPjuP
         uOVsPIGjJGLncwGo+OBF5I3KjlhqQtKr8KYW0IVatk5LFY8aGfdOs8411gvY1Ma8ujrF
         LKFSQTmXEqjORFZo3pRayQVZ5Z6MWPV9ndfN1f1lxKqhrRK66ZddTklloeAMaMe4Qrsz
         x3drZv2tmAgeTvXAzeJs/gchrx8mQIgfA+s7SRyg/Jxh2REcliX+cfDNMWdZ/X3zeB5E
         w5jA==
X-Forwarded-Encrypted: i=1; AJvYcCXQDkzccITzt3iedi+QMLNWcHRLFS1ESGWhawlFlLGj01e7l2s+qeyYX2SK+zRdtuTLUdTXWXIN2QKbjun5icPbXQ3hWNIdPIy9GXHvx7W1Bw==
X-Gm-Message-State: AOJu0YxMMITk+dKC6uEqtOA7u8++DUkhOszGycAMRDmrNT2hHS5NXaPW
	9q2h7MKokoBTEvSFKauvOPN8xGMJED2gMxdLhXsDUhU/JSPU2yFb+xdqbResl7HGlkr3a1cwr6J
	qbo6ON1ey/7SSB+AL++BGwPPmhQlYHKxq8BlJ
X-Google-Smtp-Source: AGHT+IHFzPNDrcWQ5C7GssuggT3T5a8jn8iP3fNfZwnsT+g0ek6x5sZAzufql54tuPzKeshAbHzhS1Hf3BQj/UDSsSE=
X-Received: by 2002:a92:c56a:0:b0:365:cc38:d9a5 with SMTP id
 b10-20020a92c56a000000b00365cc38d9a5mr196011ilj.15.1709311087098; Fri, 01 Mar
 2024 08:38:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com> <20240229001806.4158429-5-irogers@google.com>
 <7aa2d2a2-b8f9-478f-9699-7b717d38a8ab@linux.intel.com> <CAP-5=fWSidi1zjwn8Zr93dAQvRBtngKrkVwDxorTMmVSVc9FWg@mail.gmail.com>
 <e1e04f03-5d99-466d-a2d1-ce7fb15e8b8e@linux.intel.com>
In-Reply-To: <e1e04f03-5d99-466d-a2d1-ce7fb15e8b8e@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 1 Mar 2024 08:37:53 -0800
Message-ID: <CAP-5=fVBPT9itsyruLeChu=90xnvuxT7PSBtBkWi5LiDNAm2iw@mail.gmail.com>
Subject: Re: [PATCH v1 04/20] perf jevents: Add tsx metric group for Intel models
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 6:52=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2024-02-29 8:01 p.m., Ian Rogers wrote:
> > On Thu, Feb 29, 2024 at 1:15=E2=80=AFPM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> >>
> >>
> >>
> >> On 2024-02-28 7:17 p.m., Ian Rogers wrote:
> >>> Allow duplicated metric to be dropped from json files.
> >>>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>  tools/perf/pmu-events/intel_metrics.py | 51 ++++++++++++++++++++++++=
++
> >>>  1 file changed, 51 insertions(+)
> >>>
> >>> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-=
events/intel_metrics.py
> >>> index 20c25d142f24..1096accea2aa 100755
> >>> --- a/tools/perf/pmu-events/intel_metrics.py
> >>> +++ b/tools/perf/pmu-events/intel_metrics.py
> >>> @@ -7,6 +7,7 @@ import argparse
> >>>  import json
> >>>  import math
> >>>  import os
> >>> +from typing import Optional
> >>>
> >>>  parser =3D argparse.ArgumentParser(description=3D"Intel perf json ge=
nerator")
> >>>  parser.add_argument("-metricgroups", help=3D"Generate metricgroups d=
ata", action=3D'store_true')
> >>> @@ -77,10 +78,60 @@ def Smi() -> MetricGroup:
> >>>      ])
> >>>
> >>>
> >>> +def Tsx() -> Optional[MetricGroup]:
> >>> +    if args.model not in [
> >>> +        'alderlake',
> >>> +        'cascadelakex',
> >>> +        'icelake',
> >>> +        'icelakex',
> >>> +        'rocketlake',
> >>> +        'sapphirerapids',
> >>> +        'skylake',
> >>> +        'skylakex',
> >>> +        'tigerlake',> +    ]:
> >>
> >> Can we get ride of the model list? Otherwise, we have to keep updating
> >> the list.
> >
> > Do we expect the list to update? :-)
>
> Yes, at least for the meteorlake and graniterapids. They should be the
> same as alderlake and sapphirerapids. I'm not sure about the future
> platforms.
>
> Maybe we can have a if args.model in list here to include all the
> non-hybrid models which doesn't support TSX. I think the list should not
> be changed shortly.
>
> > The issue is the events are in
> > sysfs and not the json. If we added the tsx events to json then this
> > list wouldn't be necessary, but it also would mean the events would be
> > present in "perf list" even when TSX is disabled.
>
> I think there may an alternative way, to check the RTM events, e.g.,
> RTM_RETIRED.START event. We only need to generate the metrics for the
> platform which supports the RTM_RETIRED.START event.
>
>
> >
> >>> +        return None
> >>> +> +    pmu =3D "cpu_core" if args.model =3D=3D "alderlake" else "cpu=
"
> >>
> >> Is it possible to change the check to the existence of the "cpu" PMU
> >> here? has_pmu("cpu") ? "cpu" : "cpu_core"
> >
> > The "Unit" on "cpu" events in json always just blank. On hybrid it is
> > either "cpu_core" or "cpu_atom", so I can make this something like:
> >
> > pmu =3D "cpu_core" if metrics.HasPmu("cpu_core") else "cpu"
> >
> > which would be a build time test.
>
> Yes, I think using the "Unit" is good enough.
>
> >
> >
> >>> +    cycles =3D Event('cycles')
> >>> +    cycles_in_tx =3D Event(f'{pmu}/cycles\-t/')
> >>> +    transaction_start =3D Event(f'{pmu}/tx\-start/')
> >>> +    cycles_in_tx_cp =3D Event(f'{pmu}/cycles\-ct/')
> >>> +    metrics =3D [
> >>> +        Metric('tsx_transactional_cycles',
> >>> +                      'Percentage of cycles within a transaction reg=
ion.',
> >>> +                      Select(cycles_in_tx / cycles, has_event(cycles=
_in_tx), 0),
> >>> +                      '100%'),
> >>> +        Metric('tsx_aborted_cycles', 'Percentage of cycles in aborte=
d transactions.',
> >>> +                      Select(max(cycles_in_tx - cycles_in_tx_cp, 0) =
/ cycles,
> >>> +                                    has_event(cycles_in_tx),
> >>> +                                    0),
> >>> +                      '100%'),
> >>> +        Metric('tsx_cycles_per_transaction',
> >>> +                      'Number of cycles within a transaction divided=
 by the number of transactions.',
> >>> +                      Select(cycles_in_tx / transaction_start,
> >>> +                                    has_event(cycles_in_tx),
> >>> +                                    0),
> >>> +                      "cycles / transaction"),
> >>> +    ]
> >>> +    if args.model !=3D 'sapphirerapids':
> >>
> >> Add the "tsx_cycles_per_elision" metric only if
> >> has_event(f'{pmu}/el\-start/')?
> >
> > It's a sysfs event, so this wouldn't work :-(
>
> The below is the definition of el-start in the kernel.
> EVENT_ATTR_STR(el-start,        el_start,       "event=3D0xc8,umask=3D0x1=
");
>
> The corresponding event in the event list should be HLE_RETIRED.START
>       "EventCode": "0xC8",
>       "UMask": "0x01",
>       "EventName": "HLE_RETIRED.START",
>
> I think we may check the HLE_RETIRED.START instead. If the
> HLE_RETIRED.START doesn't exist, I don't see a reason why the
> tsx_cycles_per_elision should be supported.
>
> Again, in the virtualization world, it's possible that the
> HLE_RETIRED.START exists in the event list but el_start isn't available
> in the sysfs. I think it has to be specially handle in the test as well.

So we keep the has_event test on the sysfs event to handle the
virtualization and disabled case. We use  HLE_RETIRED.START to detect
whether the model supports TSX. Should the event be the sysfs or json
version? i.e.

        "MetricExpr": "(cycles\\-t / el\\-start if
has_event(el\\-start) else 0)",

or

        "MetricExpr": "(cycles\\-t / HLE_RETIRED.START if
has_event(el\\-start) else 0)",

I think I favor the former for some consistency with the has_event.

Using HLE_RETIRED.START means the set of TSX models goes from:
        'alderlake',
        'cascadelakex',
        'icelake',
        'icelakex',
        'rocketlake',
        'sapphirerapids',
        'skylake',
        'skylakex',
        'tigerlake',

To:
   broadwell
   broadwellde
   broadwellx
   cascadelakex
   haswell
   haswellx
   icelake
   rocketlake
   skylake
   skylakex

Using RTM_RETIRED.START it goes to:
   broadwell
   broadwellde
   broadwellx
   cascadelakex
   emeraldrapids
   graniterapids
   haswell
   haswellx
   icelake
   icelakex
   rocketlake
   sapphirerapids
   skylake
   skylakex
   tigerlake

So I'm not sure it is working equivalently to what we have today,
which may be good or bad. Here is what I think the code should look
like:

def Tsx() -> Optional[MetricGroup]:
  pmu =3D "cpu_core" if CheckPmu("cpu_core") else "cpu"
  cycles =3D Event('cycles')
  cycles_in_tx =3D Event(f'{pmu}/cycles\-t/')
  cycles_in_tx_cp =3D Event(f'{pmu}/cycles\-ct/')
  try:
    # Test if the tsx event is present in the json, prefer the
    # sysfs version so that we can detect its presence at runtime.
    transaction_start =3D Event("RTM_RETIRED.START")
    transaction_start =3D Event(f'{pmu}/tx\-start/')
  except:
    return None

  elision_start =3D None
  try:
    # Elision start isn't supported by all models, but we'll not
    # generate the tsx_cycles_per_elision metric in that
    # case. Again, prefer the sysfs encoding of the event.
    elision_start =3D Event("HLE_RETIRED.START")
    elision_start =3D Event(f'{pmu}/el\-start/')
  except:
    pass

  return MetricGroup('transaction', [
      Metric('tsx_transactional_cycles',
             'Percentage of cycles within a transaction region.',
             Select(cycles_in_tx / cycles, has_event(cycles_in_tx), 0),
             '100%'),
      Metric('tsx_aborted_cycles', 'Percentage of cycles in aborted
transactions.',
             Select(max(cycles_in_tx - cycles_in_tx_cp, 0) / cycles,
                    has_event(cycles_in_tx),
                    0),
             '100%'),
      Metric('tsx_cycles_per_transaction',
             'Number of cycles within a transaction divided by the
number of transactions.',
             Select(cycles_in_tx / transaction_start,
                    has_event(cycles_in_tx),
                    0),
             "cycles / transaction"),
      Metric('tsx_cycles_per_elision',
             'Number of cycles within a transaction divided by the
number of elisions.',
             Select(cycles_in_tx / elision_start,
                    has_event(elision_start),
                    0),
             "cycles / elision") if elision_start else None,
  ], description=3D"Breakdown of transactional memory statistics")

Wdyt?

Thanks,
Ian

> Thanks,
> Kan
>
> >
> > Thanks,
> > Ian
> >
> >> Thanks,
> >> Kan
> >>
> >>> +        elision_start =3D Event(f'{pmu}/el\-start/')
> >>> +        metrics +=3D [
> >>> +            Metric('tsx_cycles_per_elision',
> >>> +                          'Number of cycles within a transaction div=
ided by the number of elisions.',
> >>> +                          Select(cycles_in_tx / elision_start,
> >>> +                                        has_event(elision_start),
> >>> +                                        0),
> >>> +                          "cycles / elision"),
> >>> +        ]
> >>> +    return MetricGroup('transaction', metrics)
> >>> +
> >>> +
> >>>  all_metrics =3D MetricGroup("", [
> >>>      Idle(),
> >>>      Rapl(),
> >>>      Smi(),
> >>> +    Tsx(),
> >>>  ])
> >>>
> >>>  if args.metricgroups:
> >
