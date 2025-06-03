Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3C41B85C5
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Jun 2025 23:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748993809; cv=none; b=eeKfNc7W2Sf+qvXu7RerOwoiytjHwqzTw0gq1mPfmLjMKBagR56Gg1/Z1kE3kUcRZZ6YtjrL6RWwj8AKB2oYKY3bt55Bb7RVc80IuEdpARvGQVvQPvS4nHp5M9eNc+QxRDoee7ZKRjWuFTAoO2e56SSdSHXTQTrCLvXWu+RHCRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748993809; c=relaxed/simple;
	bh=KOOTXxNZfFhrryc0eqoBUfl6o0n5COLoEk7HHsfPwXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZT3eVR/9zpo6J5em0h6nervgxODWGer1+C6xb3DMyYQcvXEiDB/9gk3sCwaYk9xIlvSAu5HVCdI5bvI7ltmeyeuj6LTWENz576AjCH/HI2otzYS0RwQ3TUqpVxQzYF6u5Ad+expvVHqS1hEF2RY6rlNlrj20rso6dKc2r2nQ4i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kz6ANSl4; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kz6ANSl4"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3dd745f8839so57345ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Jun 2025 16:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748993806; x=1749598606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxYf0g5vs/wlSFORXFumXiTP8TDS/kIyizwfD/bUBi8=;
        b=Kz6ANSl4nZn7UrvRhoM/Ko00eqJ3ZL+6S8qLK9Q8BIN729GKxZy+mLKL0kEKx3YW0W
         gEkXyzi8gNifs0P8XLzUTnkWBiufv0Lf+F7E21fAnt6ER8aYqU4+sEYQJYu+mygNWSrX
         5rKe4XEOEPWzyuWlBbgffeKgbMJGWu2/14njZGP5XfqPbyU3tMhkJ+6D3/o3u7zw5wDd
         uDaaZKS/Upx/0CjRSav4TEY/Y87jn0bHeb2vH0spjSJL2eRdxmk4LqIjJ4arVvi/O9Oh
         8e6OwL37kC+Gg7ehybgf9NoCPfPR4bSqaNWrW+TTSIGedLDett99jBpvjJ7gNyTq9+zZ
         IJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748993806; x=1749598606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxYf0g5vs/wlSFORXFumXiTP8TDS/kIyizwfD/bUBi8=;
        b=GVhd/POLI73OWh0yZOJUdL83sXb0h5tEZ8fFUIBln+BIztXws2jl93yq/6fHEzCDvG
         1Hk/8JtQuQmPj815JHAzPjqJGkhxweCjy7DEnkmF5YTVdgiEVSTYgcWPsTOEI+Umrii+
         nptYETq3S/REUch9aBRjWUQoQ+tTPJrposj/+ir5eI1KOWTlaDZEVT18DY0WVbaXoD/k
         6JuIc15XBccjUMp1dDg3aySFBB2bODlfxqJVHoM12uDV+CiHaU1aH9nwZJhCzI2e2qnX
         baY26UEtxJKUUF7VbxZOMecJGXP1dQU+UYQBz3KVIYIlIkMXSUX6uc4d+6oj7rAqfMAC
         CDNA==
X-Forwarded-Encrypted: i=1; AJvYcCVgc3OYDqWyahmrM9KPtOS2B0LOT9jemlEZtGSsCJsU1OsghN8ZjoH43R3u6mANG0CwT/iwHrl/g9wVLcbNfriB@vger.kernel.org
X-Gm-Message-State: AOJu0YyWjgWtPotT63BvlBBQfeERjw651gZqZwjrrgyzO5wvBm5OwFvu
	nONvM4JEZKy/gcxr7+zbE/Jyy9sAkRnCPywocJ/sVd3FiM7mJFHKzU6sJBhp3sVz8cGQOiKFw9U
	7hlHR2wUYak1fV8DjGNIDydNNeRpWCuzbATDFN3bq
X-Gm-Gg: ASbGncvLkW/e2EKeGK1qJN1FPakPKdohaxgfgEui/dwJnuQoTEmdjj7Jz8Aa7rW+0WK
	dDupWBpwP2b3NWHUtLCT5efBtgMZi5PXEOXsC+rJf4ZCwSQOZ/OvubcUmVxz7+p2bRHeUatXML7
	n2KPAxT4KivUVXfHNz98s1/bTEAvckktXjRpPtUyUgTXEhEUEHbaU7s87oMyYiAdAJwrYVbEbg
X-Google-Smtp-Source: AGHT+IEZmjjYfoH3l/ceReenGuq+Jr53qCGYocTPZpPCtJUvjb3YSNabs5SkeQGuUWyiVjQgExJozw3Bz/026HZYR9w=
X-Received: by 2002:a05:6e02:1645:b0:3db:854b:9f52 with SMTP id
 e9e14a558f8ab-3ddbf9812b0mr632475ab.7.1748993805896; Tue, 03 Jun 2025
 16:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416045117.876775-1-irogers@google.com> <CAP-5=fU3VW1MjHMiaPG+JirLCCunMC6bEWpsJ3h0E7bTDkh9cA@mail.gmail.com>
 <aD54ptuIFHcKPkRQ@google.com> <CAP-5=fWSfFa6ncV6JkKSN4ByQ9HR+2ff4+uzwpMO5n-GaNbwxQ@mail.gmail.com>
 <aD98NFhyTcEU_qim@google.com>
In-Reply-To: <aD98NFhyTcEU_qim@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Jun 2025 16:36:34 -0700
X-Gm-Features: AX0GCFt3pwJD8zHzPE28GoAVkadQ9gKiS_WxAt0gj5GzUTrVaj2-7jBil6pyPp8
Message-ID: <CAP-5=fW0LKk1UyJr=feQd6nbNZC-ZLtUde=qX=-c9nqvDoqu-A@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Prefer sysfs/JSON events also when no PMU is provided
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 3:50=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Mon, Jun 02, 2025 at 11:08:34PM -0700, Ian Rogers wrote:
> > On Mon, Jun 2, 2025 at 9:23=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Tue, May 27, 2025 at 01:50:32PM -0700, Ian Rogers wrote:
> > > > On Tue, Apr 15, 2025 at 9:51=E2=80=AFPM Ian Rogers <irogers@google.=
com> wrote:
> > > > >
> > > > > At the RISC-V summit the topic of avoiding event data being in th=
e
> > > > > RISC-V PMU kernel driver came up. There is a preference for sysfs=
/JSON
> > > > > events being the priority when no PMU is provided so that legacy
> > > > > events maybe supported via json. Originally Mark Rutland also
> > > > > expressed at LPC 2023 that doing this would resolve bugs on ARM A=
pple
> > > > > M? processors, but James Clark more recently tested this and beli=
eves
> > > > > the driver issues there may not have existed or have been resolve=
d. In
> > > > > any case, it is inconsistent that with a PMU event names avoid le=
gacy
> > > > > encodings, but when wildcarding PMUs (ie without a PMU with the e=
vent
> > > > > name) the legacy encodings have priority.
> > > > >
> > > > > The situation is further inconsistent as legacy events are case
> > > > > sensitive, so on Intel that provides a sysfs instructions event, =
the
> > > > > instructions event without a PMU and lowercase is legacy while wi=
th
> > > > > uppercase letters it matches with sysfs which is case insensitive=
. Are
> > > > > there legacy events with upper case letters? Yes there are, the c=
ache
> > > > > ones mix case freely:
> > > > >
> > > > > L1-dcache|l1-d|l1d|L1-data|L1-icache|l1-i|l1i|L1-instruction|LLC|=
L2|dTLB|d-tlb|Data-TLB|iTLB|i-tlb|Instruction-TLB|branch|branches|bpu|btb|b=
pc|node
> > > > >
> > > > > meaning LLC that means L2 (which is wrong) both match as part of =
a
> > > > > legacy cache name but llc and l2 would only match sysfs/json
> > > > > events. The whole thing just points at the ridiculous nature of l=
egacy
> > > > > events and why we'd want them to be preffered I don't know. Why s=
hould
> > > > > case of a letter or having a PMU prefix impact the encoding in th=
e
> > > > > perf_event_attr?
> > > > >
> > > > > The patch doing this work was reverted in a v6.10 release candida=
te
> > > > > as, even though the patch was posted for weeks and had been on
> > > > > linux-next for weeks without issue, Linus was in the habit of usi=
ng
> > > > > explicit legacy events with unsupported precision options on his
> > > > > Neoverse-N1. This machine has SLC PMU events for bus and CPU cycl=
es
> > > > > where ARM decided to call the events bus_cycles and cycles, the l=
atter
> > > > > being also a legacy event name. ARM haven't renamed the cycles ev=
ent
> > > > > to a more consistent cpu_cycles and avoided the problem. With the=
se
> > > > > changes the problematic event will now be skipped, a large warnin=
g
> > > > > produced, and perf record will continue for the other PMU events.=
 This
> > > > > solution was proposed by Arnaldo.
> > > > >
> > > > > v8: Change removing of failed to open events that are tracking so=
 that
> > > > >     the tracking moves to the next event. Make software events ab=
le to
> > > > >     specified with a PMU. Change the perf_api_probe to not load a=
ll
> > > > >     PMUs through scanning, specify a PMU when parsing events.
> > > > >
> > > > > v7: Expand cover letter, fix a missed core_ok check in the v6
> > > > >     rebase. Note, as with v6 there is an alternate series that
> > > > >     prioritizes legacy events but that is silly and I'd prefer we
> > > > >     didn't do it.
> > > > >
> > > > > v6: Rebase of v5 (dropping already merged patches):
> > > > >     https://lore.kernel.org/lkml/20250109222109.567031-1-irogers@=
google.com/
> > > > >     that unusually had an RFC posted for it:
> > > > >     https://lore.kernel.org/lkml/Z7Z5kv75BMML2A1q@google.com/
> > > > >     Note, this patch conflicts/contradicts:
> > > > >     https://lore.kernel.org/lkml/20250312211623.2495798-1-irogers=
@google.com/
> > > > >     that I posted so that we could either consistently prioritize
> > > > >     sysfs/json (these patches) or legacy events (the other
> > > > >     patches). That lack of event printing and encoding inconsiste=
ncy
> > > > >     is most prominent in the encoding of events like "instruction=
s"
> > > > >     which on hybrid are reported as "cpu_core/instructions/" but
> > > > >     "instructions" before these patches gets a legacy encoding wh=
ile
> > > > >     "cpu_core/instructions/" gets a sysfs/json encoding. These pa=
tches
> > > > >     make "instructions" always get a sysfs/json encoding while th=
e
> > > > >     alternate patches make it always get a legacy encoding.
> > > > >
> > > > > v5: Follow Namhyung's suggestion and ignore the case where comman=
d
> > > > >     line dummy events fail to open alongside other events that al=
l
> > > > >     fail to open. Note, the Tested-by tags are left on the series=
 as
> > > > >     v4 and v5 were changing an error case that doesn't occur in
> > > > >     testing but was manually tested by myself.
> > > > >
> > > > > v4: Rework the no events opening change from v3 to make it handle
> > > > >     multiple dummy events. Sadly an evlist isn't empty if it just
> > > > >     contains dummy events as the dummy event may be used with "pe=
rf
> > > > >     record -e dummy .." as a way to determine whether permission
> > > > >     issues exist. Other software events like cpu-clock would suff=
ice
> > > > >     for this, but the using dummy genie has left the bottle.
> > > > >
> > > > >     Another problem is that we appear to have an excessive number=
 of
> > > > >     dummy events added, for example, we can likely avoid a dummy =
event
> > > > >     and add sideband data to the original event. For auxtrace mor=
e
> > > > >     dummy events may be opened too. Anyway, this has led to the
> > > > >     approach taken in patch 3 where the number of dummy parsed ev=
ents
> > > > >     is computed. If the number of removed/failing-to-open non-dum=
my
> > > > >     events matches the number of non-dummy events then we want to
> > > > >     fail, but only if there are no parsed dummy events or if ther=
e was
> > > > >     one then it must have opened. The math here is hard to read, =
but
> > > > >     passes my manual testing.
> > > > >
> > > > > v3: Make no events opening for perf record a failure as suggested=
 by
> > > > >     James Clark and Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>. Also,
> > > > >     rebase.
> > > > >
> > > > > v2: Rebase and add tested-by tags from James Clark, Leo Yan and A=
tish
> > > > >     Patra who have tested on RISC-V and ARM CPUs, including the
> > > > >     problem case from before.
> > > >
> > > > Ping. Thanks,
> > > > Ian
> > > >
> > > > > Ian Rogers (4):
> > > > >   perf record: Skip don't fail for events that don't open
> > > > >   perf parse-events: Reapply "Prefer sysfs/JSON hardware events o=
ver
> > > > >     legacy"
> > > > >   perf parse-events: Allow software events to be terms
> > > > >   perf perf_api_probe: Avoid scanning all PMUs, try software PMU =
first
> > >
> > > Sorry for the delay.  But I think we wanted to move to this instead:
> > >
> > > https://lore.kernel.org/linux-perf-users/20250312211623.2495798-1-iro=
gers@google.com/
> >
> > Hi Namhyung,
> >
> > The preference for sysfs/json over legacy was done as a bug fix and
> > because ARM (Mark Rutland) argued strongly that it was the most
> > sensible priority. Intel (Kan Liang) approved the change in priority.
> > RISC-V have wanted this behavior as it enables the migration of event
> > mappings from the driver to the tool. As the primary maintainer of the
> > event parsing and metric code I prefer the priority as legacy events
> > are weird, for example they aren't case insensitive in their naming.
> > For example, on Intel with legacy events as the priority cpu-cycles
> > would be a legacy event, but cpu-Cyles a sysfs one. On ARM cpu_cycles
> > would be a sysfs event, but cpu-cycles a legacy one. A minor character
> > difference and very different and imo surprising event encodings.
>
> Yeah, but it has worked like that for a long time.
>
> >
> > On your RFC thread Arnaldo and James said that legacy events somehow
> > enabled a form of drill down. As event parsing is mapping a name to a
> > perf_event_attr I completely don't see this as the mapping is opaque.
>
> Is it opaque?  (I'd say it standard event rather than legacy event.)  I
> think the mapping for the standard events are clearly defined.

Which standard events? Going through them (abbreviated to avoid repetition)=
:
 - PERF_COUNT_HW_CPU_CYCLES, ok.
 - PERF_COUNT_HW_INSTRUCTIONS, well does that include speculatively
executed instructions or not?
 - ...
 - PERF_COUNT_HW_STALLED_CYCLES_FRONTEND, what does this count on an
in order CPU?
 - ...

The hardware cache events are far worse as things like LLC mean the L2
cache, however, it is far more typical for this to mean L3 these days.
Standard and clearly defined, sorry absolutely not. They are a
minefield of well intentioned event name components waiting to explode
when a vendor inadvertently creates a combination that happens to
match a combination perf thinks is significant.

There was a similar attempt for raw events where you can go r123 for
the hex 123 event config, it was missed that rEAD is a valid hex raw
event as well as a useful event name. The event parsing now has a lot
of special handling to avoid exploding on this - and yes the priority
is that sysfs/json has priority over the raw event encoding.

> >
> > I strongly believe we need consistency. If `perf stat -e cycles .. `
> > prints cpu_core/cycles/ as the event name on a hybrid Intel, then
> > `perf stat -e cpu_core/cycles/ .. ` should have the same
> > perf_event_attr. Both patch series achieve this but this one does it
> > with consistency, and from what I see it, the support of 3 vendors.
>
> Right, it's not consistent.  Maybe we need a different uniq event name
> for extended (standard) events.  How about "cycles(cpu_core)"?  I guess
> we don't want to add a space between the PMU and event names to avoid
> potential user impact when they parse the output.

We could and it would very likely break tooling. The intent is that
cpu-cycles matches cpu_core/cpu-cycles/ and cpu_atom/cpu-cycles/ and
they are expected to all be the same event. Currently with the PMU
they are sysfs encoded but without a PMU they are legacy encoded but
printed (uniquified) as if they were with a PMU and sysfs encoded.
This is misleading.

Thanks,
Ian

> Thanks,
> Namhyung
>
