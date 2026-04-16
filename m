Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D6C1643B
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 03:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776309436; cv=pass; b=foiCUShr9KeZKdLCI3mvXTYCc+XPzv1PY0cghACwx87X81bgNmhLbMTdBm3Unn2SyoR13V6ynnr4vwS6dKMgbEIcuBOBAkTN+jGHo382uiBgaFIfqx7YMip6nsfCbx159kKEMr1ex9ExrvZMKF7vlW981MMqZTUxX99lKOf0rCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776309436; c=relaxed/simple;
	bh=hPOJ41NIT+LflW2Hc37pSLqJZz7WmqcM/ceQly8NxgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FdvV3aRDhyfLFDQ3zj8FYjvMYgSLf7E/QCiXVFa6SkJ28Ce1AxPVNJWXyCO5Nzd/maoc4EvRLTsfTMT+38br8KTPe7AbRac9QEQowWS56ORFy++kNe+G6fWp0iL1S8rdQJOgkTSTRU6ZL1U5nYbdAZNxaTCeZPq6mzrhlH0tfo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=niLkG6A7; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="niLkG6A7"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b2591757fbso22205ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Apr 2026 20:17:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776309434; cv=none;
        d=google.com; s=arc-20240605;
        b=hBh5PjttdEM+5ohL3G10BHW47ucpRLwaGFYrSlneJjEdk0ToB7d0hn3KLScn9BjYmf
         X4Au17hEYhzPSbciAQ1silt9icikjvG1aavYM+1yviNeTUjHuSkukKVvqyOKzfD22K75
         S6aVhl9HtD55DDNxr2g/io6hUwxPuZmvQSjyoPpcFS8U6m2xY8KXAWGhpxF9NbU88K5X
         1Xs4eP6ZKuiIGXB7vQ2vineK5gUoPzvsvzCowmopkwqeEI+3VpflESEzC1tc1CAkT6Gz
         s/GhEtaZAI/O49K7V89VIeTiwQnVX6ZNU8yOTd2mXVWA/HNgBSocGL0f1kSiGQR3bETv
         L+tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZHfgFB9onRo3V2QSTg78udusT0Um6YDRkQurQhNv8aA=;
        fh=PHqYg4oiq4Rh4X0EypmdP+f4jNiyh62hBE5kIQnarOg=;
        b=kT/gHmziEzYvTasXzLPPi6t4e7tZUGYHIiS27IY+N7O7CqPIRAniTZmNF4C83eMgC8
         nxiAkkyTLvuR9BV2Bi5nCDmFlIfoojUetbaaFr28QSPEQqn1WsHx2ImS4JvFF3uuJPUN
         PaGyXOnjElJzyMxhC5gxe3OSE+r6ukjkIk/CXjCXzMS6BKrk20kAhYCJyRtF97zJLx0k
         0ESn4lAKYc+0g5w6m5ZZKXDNwN5bXl1at5N2Nj0lS7qWD60mqdSGoqhrJMEGUOd2b0Hq
         GsrQQvVtx553HTa7cBcF5iQ5antgBANkREM5kUbcp9zsW7qWrDR8R49nEc7bxFHsGCoN
         Tzaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776309434; x=1776914234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHfgFB9onRo3V2QSTg78udusT0Um6YDRkQurQhNv8aA=;
        b=niLkG6A7sPFUmYE8xM3DGCVbHy8jwgvoU6BUeMqgafFXxOnLEnwO1n+JXW9FrWwhUR
         c6tiIf0megmRV3sFS5dmHKDg8zgG1yirt5275rVYM14VA+SfgOQEuIiynFFHX2lBoui+
         hFRqaSb9U7tOxU21TfrWhHBxcBsdF0Y6utd8TlOgubzP7RyXdJJMligBDLO8WAR6G6BJ
         T0DP9yk46pp/Nt+5YfKy1oE9Tv+U3hg4VydAbuJw1Xl4AoLSvIQ6jIBb+0G5IYpIZVSV
         3+VIOCL3nhzYrFIMTV8x+THJy6MzZ7Hp8v1FSblDM50z841q1aF9vJ2UW091neB4imnt
         gLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776309434; x=1776914234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZHfgFB9onRo3V2QSTg78udusT0Um6YDRkQurQhNv8aA=;
        b=lceh3J4qFWC6J814HvvNItINBq2EljWM4H5K9CCzrQnif05o7agga3WpBPaa1555QC
         T0Q16lO+UIGSF6nNwUZq6wu1kvNkVzY3QUauFTWo+KmXFdXGjkVlkt/urWBcvTAnLnrt
         5jku3BtUlwMEl2SPKwP6N3cbUE9cyXBnAsh7lKkAe7PolRpP8Lx1I33mrG0ynYzQG8lx
         5AVfCpREgol+0nrCThSE/7ZmHMvkFzfpaRF6qyT5fqI4Y9kEFObkRi6GJvfqs6BwlZzR
         aBNHuvT0C3/tF+rXtvxE9tGwAVaDCWiKqnB4xVHLXQsXGa3NW8Q1HHKRiSs+zzQ5OocZ
         E/Nw==
X-Forwarded-Encrypted: i=1; AFNElJ8IAmji3fuPBkyO6V1oRW+5ziFwWe8VMzeZzTaTOSWxvZRBjsMo2AYSwOkHQAGpWv14cHCq2wcblr6bfnxcZXqH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ICLLL1vGi30cwCrhxhTBva36tyhyV1LB9oTnOebw1WxklNcM
	WV3HS1IZXJYG9nWGaYdfXTmcsvPUcSvqr5fgbWf4Grc+p/Jx4aK7/3tvGshx3UznSO7m0138XBn
	ePDqJZkECZoJeHzi10vbpXShU/zny4zfp9w9GvlIjJzc/pR33RpsTnMOs
X-Gm-Gg: AeBDievaIdFa4aRUqNr4wJF3rCDWei/y9hV7RyNdALPQe4aDAldmW6C/0OZGVsLIyxR
	AtvSrUYzB0UgNshw0Q0F9yaFTrxKuobaaEjIrNevry0SbcM8I4POeQu+BZpaknqL00YQk8cGcvV
	3oJLErqIneZ01kmYk7EQkq9AL6Kf/xn/CYrd+dN/B31Zegm0wvjC0RGHoZbwVwao2xbgIjGr3JG
	LXOvk5rRxT9fk7Gjo02eTd+Ocedx6NfBU5QMAfQQbHj+A3EOSlJnbgFnMpDzOAeImYkP/9yW+xy
	HO72Wreq09se0n7ZnRSR3wx5/8cYxQ==
X-Received: by 2002:a17:902:da8f:b0:2b4:6130:f63d with SMTP id
 d9443c01a7336-2b5eb044a17mr1792505ad.0.1776309433765; Wed, 15 Apr 2026
 20:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413010920.546501-1-dapeng1.mi@linux.intel.com>
 <CAP-5=fW0Z0zXDjqR_tpJbT-0nbyXQO-Zcc+4Fpk=XejYX8uF4g@mail.gmail.com>
 <0ce093d8-3647-4879-9d65-acd52d4c0ab0@linux.intel.com> <CAP-5=fWj4PaadfdmkoNyOVnbNb9aAdhgxOr-CG+R8OLx2jFRCg@mail.gmail.com>
 <52a669dd-243c-4956-855e-ae76f6951ec4@linux.intel.com>
In-Reply-To: <52a669dd-243c-4956-855e-ae76f6951ec4@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 15 Apr 2026 20:17:02 -0700
X-Gm-Features: AQROBzACODNjKA9m0SNHSj6qxYnrp60gBvkpdMRfIhsR0lIAb_iaAEFMhfqbEJE
Message-ID: <CAP-5=fWSQ1m1q0Umq=HqYZmrzqxTkJDjjNHj-839Mu1kQzaC2Q@mail.gmail.com>
Subject: Re: [PATCH] perf tests: Add auto counter reload (ACR) sampling test
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Falcon Thomas <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zide Chen <zide.chen@intel.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 8:06=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 4/16/2026 1:13 AM, Ian Rogers wrote:
> > On Wed, Apr 15, 2026 at 2:19=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.in=
tel.com> wrote:
> >>
> >> On 4/13/2026 9:30 AM, Ian Rogers wrote:
> >>> On Sun, Apr 12, 2026 at 6:14=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.i=
ntel.com> wrote:
> >>>> Add auto counter reload sampling test to verify that the intended ev=
ent
> >>>> records can be captured and the self-reloaded events won't generate =
any
> >>>> records.
> >>>>
> >>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >>>> ---
> >>>>  tools/perf/tests/shell/record.sh | 42 +++++++++++++++++++++++++++++=
+++
> >>>>  1 file changed, 42 insertions(+)
> >>>>
> >>>> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/she=
ll/record.sh
> >>>> index 7cb81cf3444a..1068843282f5 100755
> >>>> --- a/tools/perf/tests/shell/record.sh
> >>>> +++ b/tools/perf/tests/shell/record.sh
> >>>> @@ -402,6 +402,47 @@ test_callgraph() {
> >>>>    echo "Callgraph test [Success]"
> >>>>  }
> >>>>
> >>>> +test_acr_sampling() {
> >>>> +  events=3D"{instructions/period=3D20000,acr_mask=3D0x2/u,cycles/pe=
riod=3D40000,acr_mask=3D0x3/u}"
> >>>> +  pebs_events=3D"{instructions/period=3D20000,acr_mask=3D0x2/pu,cyc=
les/period=3D40000,acr_mask=3D0x3/u}"
> >>>> +  echo "Auto counter reload sampling test"
> >>>> +  if ! perf record -o "${perfdata}" -e "${events}" ${testprog} 2> /=
dev/null
> >>>> +  then
> >>>> +    echo "Auto counter reload sampling [Skipped not supported]"
> >>>> +    return
> >>>> +  fi
> >>>> +  if ! perf script -i "${perfdata}" | grep -q "period=3D20000,acr_m=
ask=3D0x2"
> >>>> +  then
> >>>> +    echo "Auto counter reload sampling [Failed missing instructions=
 event]"
> >>>> +    err=3D1
> >>>> +    return
> >>>> +  fi
> >>>> +  if perf script -i "${perfdata}" | grep -q "period=3D40000,acr_mas=
k=3D0x3"
> >>>> +  then
> >>>> +    echo "Auto counter reload sampling [Failed cycles event shouldn=
't be sampled]"
> >>>> +    err=3D1
> >>>> +    return
> >>>> +  fi
> >>>> +  if ! perf record -o "${perfdata}" -e "${pebs_events}" ${testprog}=
 2> /dev/null
> >>>> +  then
> >>>> +    echo "Auto counter reload PEBS sampling [Skipped not supported]=
"
> >>>> +    return
> >>>> +  fi
> >>>> +  if ! perf script -i "${perfdata}" | grep -q "period=3D20000,acr_m=
ask=3D0x2"
> >>>> +  then
> >>>> +    echo "Auto counter reload PEBS sampling [Failed missing instruc=
tions event]"
> >>>> +    err=3D1
> >>>> +    return
> >>>> +  fi
> >>>> +  if perf script -i "${perfdata}" | grep -q "period=3D40000,acr_mas=
k=3D0x3"
> >>>> +  then
> >>>> +    echo "Auto counter reload PEBS sampling [Failed cycles event sh=
ouldn't be sampled]"
> >>>> +    err=3D1
> >>>> +    return
> >>>> +  fi
> >>>> +  echo "Auto counter reload sampling [Success]"
> >>> Thanks Dapeng! Could we also test ratio-to-prev as well as just the
> >>> plain acr_mask?
> >> Ian, it could be hard to validate ratio-to-prev option in this test. O=
n
> >> platforms which don't support ACR, perf would automatically fallback t=
he
> >> ACR sampling to normal sampling, this would lead to false positives on
> >> checking the existence of records from cycles event. I didn't find a g=
ood
> >> way to figure out this fallback.
> >>
> >> Since we already have independent test case to validate the ratio_to_p=
rev
> >> parsing. It may be unnecessary to add ratio-to-prev validation in this=
 ACR
> >> test.
> > So the ratio_to_prev test covers parsing the ratio-to-prev option (it
> > only has `perf record` commands) and ensures it is acted upon, but it
> > doesn't check the option's functional behavior - what the output is.
> > This test makes sure the acr_mask option is functional and so would be
> > complemented by ratio-to-prev testing somethig like:
> > ```
> >   rtp_events=3D"{instructions,cycles/period=3D40000,ratio-to-prev=3D0.5=
/u}"
> >
> >   # Test ratio-to-prev
> >   if ! perf record -o "${perfdata}" -e "${rtp_events}" ${testprog} 2> /=
dev/null
> >   then
> >     echo "Auto counter reload ratio-to-prev sampling [Failed record
> > ratio-to-prev]"
> >     err=3D1
> >     return
> >   fi
> >   if ! perf script -i "${perfdata}" | grep -q "instructions"
> >   then
> >     echo "Auto counter reload ratio-to-prev sampling [Failed missing
> > instructions event]"
> >     err=3D1
> >     return
> >   fi
> >   if perf script -i "${perfdata}" | grep -q "cycles"
> >   then
> >     echo "Auto counter reload ratio-to-prev sampling [Failed cycles
> > event shouldn't be sampled]"
> >     err=3D1
> >     return
> >   fi
> > ```
> > The first thing your test does is to make sure the acr_mask is
> > supported, so I'm not sure how the fall back can happen?
> > We could additionally check for
> > `/sys/bus/event_source/devices/cpu*/format/acr_mask`.
>
> Yes, that's initially what I intended to do, but it would cause false
> positives on some hybrid platform, like PTL which only supports ACR on E-=
core.
>
> ```
>
> $ grep . /sys/bus/event_source/devices/cpu_core/format/*
> /sys/bus/event_source/devices/cpu_core/format/cmask:config:24-31
> /sys/bus/event_source/devices/cpu_core/format/edge:config:18
> /sys/bus/event_source/devices/cpu_core/format/eq:config:36
> /sys/bus/event_source/devices/cpu_core/format/event:config:0-7
> /sys/bus/event_source/devices/cpu_core/format/frontend:config1:0-23
> /sys/bus/event_source/devices/cpu_core/format/inv:config:23
> /sys/bus/event_source/devices/cpu_core/format/ldlat:config1:0-15
> /sys/bus/event_source/devices/cpu_core/format/metrics_clear:config1:0
> /sys/bus/event_source/devices/cpu_core/format/offcore_rsp:config1:0-63
> /sys/bus/event_source/devices/cpu_core/format/pc:config:19
> /sys/bus/event_source/devices/cpu_core/format/umask:config:8-15,40-47
>
> $ grep . /sys/bus/event_source/devices/cpu_atom/format/*
> /sys/bus/event_source/devices/cpu_atom/format/acr_mask:config2:0-63
> /sys/bus/event_source/devices/cpu_atom/format/cmask:config:24-31
> /sys/bus/event_source/devices/cpu_atom/format/edge:config:18
> /sys/bus/event_source/devices/cpu_atom/format/eq:config:36
> /sys/bus/event_source/devices/cpu_atom/format/event:config:0-7
> /sys/bus/event_source/devices/cpu_atom/format/inv:config:23
> /sys/bus/event_source/devices/cpu_atom/format/ldlat:config1:0-15
> /sys/bus/event_source/devices/cpu_atom/format/offcore_rsp:config1:0-63
> /sys/bus/event_source/devices/cpu_atom/format/pc:config:19
> /sys/bus/event_source/devices/cpu_atom/format/snoop_rsp:config1:0-63
> /sys/bus/event_source/devices/cpu_atom/format/umask:config:8-15,40-47
>
> ```
>
> So strictly speaking, we need to check if it's a hybrid platform first an=
d
> then check if the exact P-core/E-core supports ACR, then run the above AC=
R
> tests. It seems a little bit over-complicated and I'm not sure if it's
> accepted to add so much Intel specific check in the record.sh.
>
> How's your idea on this? Thanks.

Potentially auto counter reload and ratio to prev are generic
concepts, it just happens that we only have Intel e-core
implementations :-) Matching against cpu* already misses ARM core
PMUs. I'm always happy for as much testing as possible. The last code
coverage number I have for Linux v6.17 is 38.6% of lines under
tools/perf. Since then, I've added quite a bit of testing for commands
like `perf top`. Perhaps we now cover over 50% of the lines of code.

Thanks,
Ian

> >
> > Thanks,
> > Ian
> >
> >>> Thanks,
> >>> Ian
> >>>
> >>>> +}
> >>>> +
> >>>>  test_ratio_to_prev() {
> >>>>    echo "ratio-to-prev test"
> >>>>    if ! perf record -o /dev/null -e "{instructions, cycles/period=3D=
100000,ratio-to-prev=3D0.5/}" \
> >>>> @@ -457,6 +498,7 @@ test_leader_sampling
> >>>>  test_topdown_leader_sampling
> >>>>  test_precise_max
> >>>>  test_callgraph
> >>>> +test_acr_sampling
> >>>>  test_ratio_to_prev
> >>>>
> >>>>  # restore the default value
> >>>>
> >>>> base-commit: 4e03d6494f9504f8af46ba68a2a8b6877c196789
> >>>> --
> >>>> 2.34.1
> >>>>
