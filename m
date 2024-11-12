Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A1420F5AF
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Nov 2024 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432216; cv=none; b=pio2bl3NI+pk3y1Itp/GGIY2uBXguN7XXe6b8gW810pmgQnm/fWr23LPy2gO7/h0wXSxTDWR7ISBniesf1BAy2ZCx12n9h9ie0CMXdD3VGvSKwVWo3liuuMnCTmE55t52NYCtrWF/W9hF+ThW9USfKNyErMDF6gMjaAo8rOnb5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432216; c=relaxed/simple;
	bh=leyq+6vgk1UjG9aHNXbxL0+kXhYp9C6ucz2ff0rydRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbLuCtxGFOC2uSSzLuk0PKLEz6MuwLiC/g8CZBwGfOqtgzOX3jo29vqIX7Ex98baLHlIKV5WsdimQ9IBR5beQ1dHiRoggwBur6Nabux4MgAmzgoRv1HdrYWgJ+Mj/OuUwIOC0JgE6i9QUWYHQdh3CY2vUusN7hAv63764GJISh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2uUeEg7R; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2uUeEg7R"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so149305ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Nov 2024 09:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731432212; x=1732037012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leyq+6vgk1UjG9aHNXbxL0+kXhYp9C6ucz2ff0rydRs=;
        b=2uUeEg7R/HKsvlTHssI5j9QeqP35yMk0Vd+DgsmaUZ6dhaJ5YDgNBlIiF/plAmkN/s
         CF1Pf/8DCt93F9+AnT8hNsU0WfgXpoSzdXmdxlbPRSSn0znOZwB48WjcVYN3dGjugh7L
         j1Q6BTQdFztsjhBWVMjRWJLE8gkRBWHgOBB+CPas4aNk2ertaJT6GdMlku3nxxAvux2F
         XaFuHbPNQlMVH0U86lZGBO4PRTchoymVwQLnlVz/dh7DTM2tQZVY/481LseDZzIOxQDQ
         BeyGvI4GPHvxSUpnAJLS4XGP3wEGxI+ewGHHHeE4ZBfF+Hp3qgcLjW6Wdd7ObxQ7uDQ/
         V2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731432212; x=1732037012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leyq+6vgk1UjG9aHNXbxL0+kXhYp9C6ucz2ff0rydRs=;
        b=ebMr3yYBMw90lJsEJYuHPaQKs6DwT4Nm6w3XNkn9xmcFY11OW3R94kbDy53LMGAf/6
         ccGmAgbFp7lolos5fmjiLK12kznVnFaNWIsMVXljRWeegq4YRbasnZnW2TXLiCK0O1nf
         Squ5JHfM0L7zQ2k6PgJm8VJ9DlFAGBjo6Io5ELIwVs7KCt5MP1kiWJN/AY165+mUq49z
         6AQQ+w+ANQRiuswK9hjyz56mjnSLYOmAh34ioArjrVsmYRi2ueVO5aQ89EPMI9OdsYuN
         gUD6RVxpmEL0zbo57iCLiDgD5k69DLZQw6Xl8e9CYHJ8jXDOjj2rd7jM7qQkv8Uq9h14
         dh2g==
X-Forwarded-Encrypted: i=1; AJvYcCUhuvoqIx71O0yMR5CwBhuhXeEYtdp2bGjyCdqDmTNFQntHdTGDN9OFnF/1GkUkHG7GiPf7XPqqxX85/mlopSC2@vger.kernel.org
X-Gm-Message-State: AOJu0YxsrFXY1pW4NVaBKJ0WuDsHwO6Dxo/vplO4LioqBO1FYbsD2R3x
	RhI9wK3FI4OzO50T/uSZSUJLFghOf3TmRpboMz5GQ/Cgyesm/z2IyYDEGhM0i1+q67YFEqFPsTE
	+ZZSu3nIyc/PBPZkWSBUnZVVaNIg0Z0Ig30G5
X-Gm-Gg: ASbGncskCpV7Lgh6nD/uc+owcNKuUri+/ej6snmHeywBkPGNXwdcwD0S2T0BcHPpH/z
	1kQcT99leF5lKYqZ3jJItGfmzyL4J3FqlEXkFzSFoTRDuT2P4m7IeSU9YiarCSlo=
X-Google-Smtp-Source: AGHT+IGJQTSPwvZKGBmCN6XdpRqgiH6fZY5Pi/ulS5YQfcxye8fuG1fUwJo4D+8OmrvH1/JlFXM3pPuRCA3FBiMgZlU=
X-Received: by 2002:a05:6e02:1745:b0:3a6:f215:c5aa with SMTP id
 e9e14a558f8ab-3a70c14638bmr5107395ab.14.1731432212171; Tue, 12 Nov 2024
 09:23:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026121758.143259-1-irogers@google.com> <CAP-5=fXf9HtqKZyvfXNbKLTB-dL_Ax5Hd0_Gn1J-y0T1SE9wLQ@mail.gmail.com>
 <78eb729c-7594-460f-9d79-97fb683d8b5e@linaro.org> <CAHBxVyFXWpczMmWJbpWoLUjQ4nfNC2_h1yZqSd7kSr6N8Rvm5Q@mail.gmail.com>
 <d9bfd75a-003a-4f65-abba-b8bcaad13682@linaro.org> <CAP-5=fUHjxL5QbsyQQU-3EYiVhiO6wt=F5MfSfDcAffKP7WWAg@mail.gmail.com>
 <ccac5d65-b01f-4624-97cd-e350ce6de840@linaro.org>
In-Reply-To: <ccac5d65-b01f-4624-97cd-e350ce6de840@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 Nov 2024 09:23:20 -0800
Message-ID: <CAP-5=fXK4NmdY_uTYWSsS+TgnpYK8y_wgm_W_rnqUYQ0BrPZFg@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Prefer sysfs/JSON events also when no PMU is provided
To: James Clark <james.clark@linaro.org>
Cc: Atish Kumar Patra <atishp@rivosinc.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ben Gainey <ben.gainey@arm.com>, 
	Junhao He <hejunhao3@huawei.com>, linux-riscv@lists.infradead.org, beeman@rivosinc.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 6:22=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> On 11/11/2024 5:19 pm, Ian Rogers wrote:
> > On Mon, Nov 11, 2024 at 2:45=E2=80=AFAM James Clark <james.clark@linaro=
.org> wrote:
> >>
> >> On 08/11/2024 6:37 pm, Atish Kumar Patra wrote:
> >>> On Fri, Nov 8, 2024 at 4:16=E2=80=AFAM James Clark <james.clark@linar=
o.org> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 07/11/2024 18:51, Ian Rogers wrote:
> >>>>> On Sat, Oct 26, 2024 at 5:18=E2=80=AFAM Ian Rogers <irogers@google.=
com> wrote:
> >>>>>>
> >>>>>> At the RISC-V summit the topic of avoiding event data being in the
> >>>>>> RISC-V PMU kernel driver came up. There is a preference for sysfs/=
JSON
> >>>>>> events being the priority when no PMU is provided so that legacy
> >>>>>> events maybe supported via json. Originally Mark Rutland also
> >>>>>> expressed at LPC 2023 that doing this would resolve bugs on ARM Ap=
ple
> >>>>>> M? processors, but James Clark more recently tested this and belie=
ves
> >>>>>> the driver issues there may not have existed or have been resolved=
. In
> >>>>>> any case, it is inconsistent that with a PMU event names avoid leg=
acy
> >>>>>> encodings, but when wildcarding PMUs (ie without a PMU with the ev=
ent
> >>>>>> name) the legacy encodings have priority.
> >>>>>>
> >>>>>> The patch doing this work was reverted in a v6.10 release candidat=
e
> >>>>>> as, even though the patch was posted for weeks and had been on
> >>>>>> linux-next for weeks without issue, Linus was in the habit of usin=
g
> >>>>>> explicit legacy events with unsupported precision options on his
> >>>>>> Neoverse-N1. This machine has SLC PMU events for bus and CPU cycle=
s
> >>>>>> where ARM decided to call the events bus_cycles and cycles, the la=
tter
> >>>>>> being also a legacy event name. ARM haven't renamed the cycles eve=
nt
> >>>>>> to a more consistent cpu_cycles and avoided the problem. With thes=
e
> >>>>>> changes the problematic event will now be skipped, a large warning
> >>>>>> produced, and perf record will continue for the other PMU events. =
This
> >>>>>> solution was proposed by Arnaldo.
> >>>>>>
> >>>>>> Two minor changes have been added to help with the error message a=
nd
> >>>>>> to work around issues occurring with "perf stat metrics (shadow st=
at)
> >>>>>> test".
> >>>>>>
> >>>>>> The patches have only been tested on my x86 non-hybrid laptop.
> >>>>>
> >>>>> Hi Atish and James,
> >>>>>
> >>>>> Could I get your tags for this series?
> >>>>>
> >>>
> >>> Hi Ian,
> >>> Thanks for your patches. It definitely helps to have a clean slate
> >>> implementation
> >>> for the perf tool. However, I have some open questions about other us=
e cases
> >>> that we discussed during the RVI Summit.
> >>>
> >>>>> The patches were originally motivated by wanting to make the behavi=
or
> >>>>> of events parsed like "cycles" match that of "cpu/cycles/", the PMU=
 is
> >>>>> wildcarded to "cpu" in the first case. This was divergent because o=
f
> >>>>> ARM we switched from preferring legacy (type =3D PERF_TYPE_HARDWARE=
,
> >>>>> config =3D PERF_COUNT_HW_CPU_CYCLES) to sysfs/json (type=3D<core PM=
U's
> >>>>> type>, config=3D<encoding from event>) when a PMU name was given. T=
his
> >>>>> aligns with RISC-V wanting to use json encodings to avoid complexit=
y
> >>>>> in the PMU driver.
> >>>>>
> >>>>
> >>>> I couldn't find the thread, but I remember fairly recently it was
> >>>> mentioned that RISC-V would be supporting the legacy events after al=
l,
> >>>> maybe it was a comment from Atish? I'm not sure if that changes the
> >>>> requirements for this or not?
> >>>>
> >>>> I still can't really imagine how tooling would work if every tool ha=
s to
> >>>> maintain the mappings of basic events like instructions and branches=
.
> >>>> For example all the perf_event_open tests in ltp use the legacy even=
ts.
> >>>>
> >>>
> >>> No it has not changed. While this series helps to avoid clunky vendor
> >>> specific encodings
> >>> in the driver for perf tool, I am still unsure how we will manage
> >>> other applications
> >>> (directly passing legacy events through perf_event_open or
> >>> perf_evlist__open) will work.
> >>>
> >>> I have only anecdotal data about folks relying perf legacy events
> >>> directly to profile
> >>> their application. All of them use mostly cycle/instruction events th=
ough.
> >>> Are there any users who use other legacy events directly without perf=
 tool ?
> >>>
> >>> If not, we may have only cycle/instruction mapping in the driver and
> >>> rely on json for everything else.
> >>> The other use case is virtualization. I have been playing with these
> >>> patches to find a clean solution to
> >>> enable all the use cases. If you have any other ideas, please let me =
know.
> >>>
> >>
> >> Yeah I would expect it's mostly cycles and instructions. I searched a
> >> bit for PERF_COUNT_HW_BRANCH_MISSES and only found tool/developer type
> >> usages, which I suppose we could expect to have to handle the mappings
> >> like perf. Although it's not the easiest thing to search for and
> >> obviously that only includes open source.
> >>
> >> Usages do exist though, there are people posting on stack overflow usi=
ng
> >> it, and other various bug tracker listings. So you would expect those
> >> same users to have to use raw event codes and some switch statement to
> >> pick the right one for their hardware, or use Perf.
> >
> > I don't have any magic to solve this. My thoughts:
> >
> > 1) I thought legacy events were just going to hang around forever,
> > although the name hinting they'd kind of been deprecated. At LPC '23
> > Atish and Mark Rutland originally asked for the sysfs/json to be the
> > preference. I thought Kan was going to push back given the upheaval,
> > especially updating every test expectation. It went through but we're
> > in this weird state where wildcard events are encoded using legacy and
> > PMU specifying events aren't. What this series hopes to solve.
> >
> > 2) I think it is important that perf tool be a reference
> > implementation where others can look (strace, etc.) to base their
> > implementation. Moving perf to sysfs/json is 1 step closer to legacy
> > event deprecation. Please yell if deprecation isn't what is wanted as
> > personally other than cleanliness I don't mind. If we do decide not to
> > have sysfs/json be the priority then I think it sensible to revert the
> > changes making it the priority for events that specify a PMU. I'd like
> > some level of consistency.
>
> Personally this change feels like it's encouraging fragmentation, the
> cleanest would be if RISC-V supports the legacy events like the other
> platforms. It's not a huge set of events anyway, and then existing
> software continues to work in addition to Perf continuing to work.

So I try to be agnostic on the issue but we got to this point because
of events being broken on ARM Apple chips. I fixed an issue where the
ARM core PMU appeared as an uncore PMU as ARM's PMU naming differs
from everyone else's. That fix made it so we used legacy events for
the ARM core PMU, the PMU driver didn't handle this correctly (at the
time) on ARM Apple Linux breaking perf over multiple Linux releases
affecting a number of users.

Having a pool of standard events isn't on the face of it a crazy idea,
I'll try to remember things that have come up:

1) instructions and cycles seem like fairly easy events to agree upon.
However, we also have cpu-cycles that means cycles. With legacy events
the hyphen is often used as a PMU separator. Now what does the cpu
mean here? On ARM you also have cpu_cycles as a sysfs event, ie an
underscore and not a hyphen:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/drivers/perf/arm_pmuv3.c?h=3Dperf-tools-next#n192
What does 'cpu' mean when ARM has no core PMU called 'cpu' and in
heterogeneous systems there are multiple notions of 'cpu' for the core
PMU.
What's my point? Just trying to make a minimal 2 event set of common
events with the way things currently parse leads to ambiguity.

2) missing/ambiguous legacy events. Beyond instructions and cycles
there are cache references, cache misses, branch instructions, branch
misses, bus cycles, stalled cycles frontend, stalled cycles backend
and reference CPU cycles. This set of events captures an out-of-order
machine with a single bus, but even then there's ambiguity over
whether the events include speculatively executed instructions or not.
What's my point? Using these events leads to unpredictable counts in
software. With a sysfs/json event there is a description but none was
ever given about what these legacy events should do, or do if you have
a system with >1 bus, counts for speculatively executed instructions,
isn't out-of-order, etc.

3) "legacy cache" events never really took off. The legacy cache event
names encoded data around speculation and appeared less ambiguous, a
good source for all the names supported by perf is here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/evsel.c?h=3Dperf-tools-next#n734
but choices were made like prefetch is the same as a speculative read
in the encoding. Vendors no doubt agree and disagree on this. LLC and
L2 are synonyms, but today LLC generally means L3 and often an
entirely separate PMU.
What's my point? The code tried to do a smarter less ambiguous thing
than PERF_TYPE_HARDWARE with PERF_TYPE_HW_CACHE but again it was
flawed, carried too many architectural assumptions and without the
drivers adopting it neither did users.

4) PMU drivers mapping issues and the aforementioned ARM Apple Linux
breakage, RISC-V wanting to keep mappings out of a more simplistic
driver.

So I wasn't there for all of this, but I think this is what led to the
legacy events effectively becoming deprecated.

> If we're still thinking that RISC-V will support the legacy events
> anyway in the future, then it weakens the argument to change this and
> risk any breakages that fall out of it.

Agreed, that's why I keep saying I'm only doing this because ARM and
RISC-V want it. What I want is that for things like the encoding of
"cpu-cycles" and "cpu/cpu-cycles/" when there is only 1 PMU providing
such an event called "cpu" the perf_event_attr encodings should match,
we don't have this today but did prior to changing the priority to fix
the ARM Apple Linux issue.

I think for what Atish is asking for perhaps the best route is to add
vendor standard events like ARM has. Anything done in Linux won't
carry over to other operating systems you can be trying to virtualize.
This doesn't to me feel like a problem we should be trying to solve
either in the kernel/driver or the tool, well I've not heard an idea
how we can.

> I'm also not sure whether they really are legacy or just a common base
> set of events. Since the extended type thing was added even the legacy
> events support hybrid, so it's not like they expired from lack of
> features. Even if we claim they're legacy, is that really ever going to
> make them go away?

So for heterogeneous chips ARM first did BIG.little over ten years
ago. More recently Intel did hybrid and it wasn't until Intel added
hybrid support for legacy events that the idea of this worked. As you
know, ARM''s support came later. Does software outside of the perf
tool know to encode information in the extended type information in
legacy events? I doubt it. For example, libpfm4 has only recently been
adding support for heterogeneous CPUs.

So yes there are legacy events and they are a common pool of events
which is convenient for developers, however, this approach quickly
showed shortcomings and often lacked proper vendor support. My company
advocates developers against using common events, which admittedly is
more work for the developer, because we've had multiple issues over
the years primarily due to baked in assumptions.

Thanks,
Ian

> Although I admit nobody has come out with a definitive use case that
> doesn't use either the cycles or instructions events, so maybe its all fi=
ne.
>
> >
> > 3) I'd like event parsing to be a library that is as easy to link
> > against as libbpf (i.e. not a viral license). Event parsing is really
> > just mapping an event name to 1 or more perf_event_attr. The PMU
> > abstraction is tied into the event parsing, but this has only been
> > more true recently. The evsel/evlist is tied into event parsing but
> > that feels separable. As most json isn't distributed under a viral
> > license this feels achievable, then I suspect most tools can use this
> > library rather than have to reinvent a wheel.
> >
> > Still looking for tags :-)
> >
> > Thanks,
> > Ian
>
