Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C400C209F2C
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Nov 2024 19:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731441334; cv=none; b=uJC+E9yH8iZ2wTyn4dF3dUczzEvHKPWR3uUuWzQ+IoRBuhEbbje2dRQ2vh5ug17z1kh62M5jH6lXkgXXQWSl0AnK07XSleaO8pCr2gbZZB3bXQcHo+UbTYJt+InshiAsBmCUfTIMyIy0tpU+oYDnGILj92oePghUYYgmo4nsuSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731441334; c=relaxed/simple;
	bh=lMnszVlaml6MQok3Bjz9p2WYLuBOvU/GMqlpS2pnBC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHbg4UknaxkJqj4DXvHHJ3iq/IvcNkW+pu+fjyCK+DhDzOvUG802b0phAqVKsCnsNdUCyTP39NM/HjES8kkqOAY/NAmSq4xXNGQn3jOLmkEHDS2PjlEOKPbdkrQd0+PKl9CDHjGXhrY3m1Q8cNH0Z3u1SDvH8oMdlpeXeGT5vAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kYCs6k64; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kYCs6k64"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7206304f93aso5516183b3a.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Nov 2024 11:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731441332; x=1732046132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMnszVlaml6MQok3Bjz9p2WYLuBOvU/GMqlpS2pnBC4=;
        b=kYCs6k64wXuhqzFjzrmaXgOPH2Twv/ptvIwRfinvwq5HPZhnqfQWGjgIf7PEYqpEhM
         B7o0+sscE08Fenc9hkXcbvstnAptgxhdHZOsKPHRBxTv63JnfdUrOLgL6+yOblguLhFk
         IQfTDSH2rxWQ12LBdd+HwOySx4pbpNzw/ie/xKtBfVAMaGpBYNWm6DMRdh7gX6eomEV0
         6TejzIN4EKOfd3Ldl0dbbCKcWiVD6jYrq9P702MC7JC25bSyMPTSODhUNdHQ28ZhJ6WD
         7tJo+rxlEsSHlCxXY02Q3uNElWn0JrLud8yTHi1vBFUK8SWkfFN5fRx+kW5LnCksfjxJ
         CbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731441332; x=1732046132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMnszVlaml6MQok3Bjz9p2WYLuBOvU/GMqlpS2pnBC4=;
        b=ieltNa4aSYXj4PNKppbZv+nKz0fMJLFkGq/kN+kxfL7CBfHQLaEXL5JtzZjte7QyKI
         BjJmmCVjVXwote4Xdmmcu0tekW7oAS41fgvIVNZTP3txsAIbdFnFQs74k5HToyK+ZBxK
         QFqYYv8FrbtToD53MNckBAJpqGUmNU7MWFZZvJjG9B9e5Bq4aIj+hMAfM2dC3NfwTGG8
         HGobN8wycaH9mZbC6/My6AFScyaEKpph/5UY1snQwaHLkGtlzM7iJ7FdgIVp4kxCpwBf
         paIzhZ+ekMRNm9TblA/MZRQmCnkqJM/+6amvidV7Uwr4TexFoziR08laH/N3N5F/OGvZ
         WF8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMLTtaDBedzeJacoXLotjTgieuidXexwuQykUcru9qUXq54F4TuoDhE0qQIA1ZuTENVyJ8E13FkmBId55kktD9@vger.kernel.org
X-Gm-Message-State: AOJu0YxywIPKwlWz8BdXe/6sGlJ4h/A8+Uw7kbFVY7aPMwaWgRpH/EfP
	vj1cQuOH93KKp2rOxpngD6D8xKBGGO+staIMbz2iGObsG/ED2P74YbaA1HBmNC/6BtiCr7N9TSE
	L2UGvV5wNXMq3NIb5UMzy25IxA1YvRbmCspXnmA==
X-Google-Smtp-Source: AGHT+IHEnIexfhNozK2RzQDOieRFZPyHUAevCcJp6nhApvWfAcD4T1PqBiIVot/PKPs3DPN+rWmxoN454jU9yLYi1d4=
X-Received: by 2002:a05:6a00:a09:b0:71e:4930:1620 with SMTP id
 d2e1a72fcca58-7241327880dmr23051428b3a.3.1731441331842; Tue, 12 Nov 2024
 11:55:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026121758.143259-1-irogers@google.com> <CAP-5=fXf9HtqKZyvfXNbKLTB-dL_Ax5Hd0_Gn1J-y0T1SE9wLQ@mail.gmail.com>
 <78eb729c-7594-460f-9d79-97fb683d8b5e@linaro.org> <CAHBxVyFXWpczMmWJbpWoLUjQ4nfNC2_h1yZqSd7kSr6N8Rvm5Q@mail.gmail.com>
 <d9bfd75a-003a-4f65-abba-b8bcaad13682@linaro.org> <CAP-5=fUHjxL5QbsyQQU-3EYiVhiO6wt=F5MfSfDcAffKP7WWAg@mail.gmail.com>
 <ccac5d65-b01f-4624-97cd-e350ce6de840@linaro.org> <CAP-5=fXK4NmdY_uTYWSsS+TgnpYK8y_wgm_W_rnqUYQ0BrPZFg@mail.gmail.com>
In-Reply-To: <CAP-5=fXK4NmdY_uTYWSsS+TgnpYK8y_wgm_W_rnqUYQ0BrPZFg@mail.gmail.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Tue, 12 Nov 2024 11:55:21 -0800
Message-ID: <CAHBxVyFQsBSiYrSmhnP9ov=3yt8D1fQ8reuEZCNhwWyxBEd+PA@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Prefer sysfs/JSON events also when no PMU is provided
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
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

On Tue, Nov 12, 2024 at 9:23=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Tue, Nov 12, 2024 at 6:22=E2=80=AFAM James Clark <james.clark@linaro.o=
rg> wrote:
> >
> > On 11/11/2024 5:19 pm, Ian Rogers wrote:
> > > On Mon, Nov 11, 2024 at 2:45=E2=80=AFAM James Clark <james.clark@lina=
ro.org> wrote:
> > >>
> > >> On 08/11/2024 6:37 pm, Atish Kumar Patra wrote:
> > >>> On Fri, Nov 8, 2024 at 4:16=E2=80=AFAM James Clark <james.clark@lin=
aro.org> wrote:
> > >>>>
> > >>>>
> > >>>>
> > >>>> On 07/11/2024 18:51, Ian Rogers wrote:
> > >>>>> On Sat, Oct 26, 2024 at 5:18=E2=80=AFAM Ian Rogers <irogers@googl=
e.com> wrote:
> > >>>>>>
> > >>>>>> At the RISC-V summit the topic of avoiding event data being in t=
he
> > >>>>>> RISC-V PMU kernel driver came up. There is a preference for sysf=
s/JSON
> > >>>>>> events being the priority when no PMU is provided so that legacy
> > >>>>>> events maybe supported via json. Originally Mark Rutland also
> > >>>>>> expressed at LPC 2023 that doing this would resolve bugs on ARM =
Apple
> > >>>>>> M? processors, but James Clark more recently tested this and bel=
ieves
> > >>>>>> the driver issues there may not have existed or have been resolv=
ed. In
> > >>>>>> any case, it is inconsistent that with a PMU event names avoid l=
egacy
> > >>>>>> encodings, but when wildcarding PMUs (ie without a PMU with the =
event
> > >>>>>> name) the legacy encodings have priority.
> > >>>>>>
> > >>>>>> The patch doing this work was reverted in a v6.10 release candid=
ate
> > >>>>>> as, even though the patch was posted for weeks and had been on
> > >>>>>> linux-next for weeks without issue, Linus was in the habit of us=
ing
> > >>>>>> explicit legacy events with unsupported precision options on his
> > >>>>>> Neoverse-N1. This machine has SLC PMU events for bus and CPU cyc=
les
> > >>>>>> where ARM decided to call the events bus_cycles and cycles, the =
latter
> > >>>>>> being also a legacy event name. ARM haven't renamed the cycles e=
vent
> > >>>>>> to a more consistent cpu_cycles and avoided the problem. With th=
ese
> > >>>>>> changes the problematic event will now be skipped, a large warni=
ng
> > >>>>>> produced, and perf record will continue for the other PMU events=
. This
> > >>>>>> solution was proposed by Arnaldo.
> > >>>>>>
> > >>>>>> Two minor changes have been added to help with the error message=
 and
> > >>>>>> to work around issues occurring with "perf stat metrics (shadow =
stat)
> > >>>>>> test".
> > >>>>>>
> > >>>>>> The patches have only been tested on my x86 non-hybrid laptop.
> > >>>>>
> > >>>>> Hi Atish and James,
> > >>>>>
> > >>>>> Could I get your tags for this series?
> > >>>>>
> > >>>
> > >>> Hi Ian,
> > >>> Thanks for your patches. It definitely helps to have a clean slate
> > >>> implementation
> > >>> for the perf tool. However, I have some open questions about other =
use cases
> > >>> that we discussed during the RVI Summit.
> > >>>
> > >>>>> The patches were originally motivated by wanting to make the beha=
vior
> > >>>>> of events parsed like "cycles" match that of "cpu/cycles/", the P=
MU is
> > >>>>> wildcarded to "cpu" in the first case. This was divergent because=
 of
> > >>>>> ARM we switched from preferring legacy (type =3D PERF_TYPE_HARDWA=
RE,
> > >>>>> config =3D PERF_COUNT_HW_CPU_CYCLES) to sysfs/json (type=3D<core =
PMU's
> > >>>>> type>, config=3D<encoding from event>) when a PMU name was given.=
 This
> > >>>>> aligns with RISC-V wanting to use json encodings to avoid complex=
ity
> > >>>>> in the PMU driver.
> > >>>>>
> > >>>>
> > >>>> I couldn't find the thread, but I remember fairly recently it was
> > >>>> mentioned that RISC-V would be supporting the legacy events after =
all,
> > >>>> maybe it was a comment from Atish? I'm not sure if that changes th=
e
> > >>>> requirements for this or not?
> > >>>>
> > >>>> I still can't really imagine how tooling would work if every tool =
has to
> > >>>> maintain the mappings of basic events like instructions and branch=
es.
> > >>>> For example all the perf_event_open tests in ltp use the legacy ev=
ents.
> > >>>>
> > >>>
> > >>> No it has not changed. While this series helps to avoid clunky vend=
or
> > >>> specific encodings
> > >>> in the driver for perf tool, I am still unsure how we will manage
> > >>> other applications
> > >>> (directly passing legacy events through perf_event_open or
> > >>> perf_evlist__open) will work.
> > >>>
> > >>> I have only anecdotal data about folks relying perf legacy events
> > >>> directly to profile
> > >>> their application. All of them use mostly cycle/instruction events =
though.
> > >>> Are there any users who use other legacy events directly without pe=
rf tool ?
> > >>>
> > >>> If not, we may have only cycle/instruction mapping in the driver an=
d
> > >>> rely on json for everything else.
> > >>> The other use case is virtualization. I have been playing with thes=
e
> > >>> patches to find a clean solution to
> > >>> enable all the use cases. If you have any other ideas, please let m=
e know.
> > >>>
> > >>
> > >> Yeah I would expect it's mostly cycles and instructions. I searched =
a
> > >> bit for PERF_COUNT_HW_BRANCH_MISSES and only found tool/developer ty=
pe
> > >> usages, which I suppose we could expect to have to handle the mappin=
gs
> > >> like perf. Although it's not the easiest thing to search for and
> > >> obviously that only includes open source.
> > >>
> > >> Usages do exist though, there are people posting on stack overflow u=
sing
> > >> it, and other various bug tracker listings. So you would expect thos=
e
> > >> same users to have to use raw event codes and some switch statement =
to
> > >> pick the right one for their hardware, or use Perf.
> > >
> > > I don't have any magic to solve this. My thoughts:
> > >
> > > 1) I thought legacy events were just going to hang around forever,
> > > although the name hinting they'd kind of been deprecated. At LPC '23
> > > Atish and Mark Rutland originally asked for the sysfs/json to be the
> > > preference. I thought Kan was going to push back given the upheaval,
> > > especially updating every test expectation. It went through but we're
> > > in this weird state where wildcard events are encoded using legacy an=
d
> > > PMU specifying events aren't. What this series hopes to solve.
> > >
> > > 2) I think it is important that perf tool be a reference
> > > implementation where others can look (strace, etc.) to base their
> > > implementation. Moving perf to sysfs/json is 1 step closer to legacy
> > > event deprecation. Please yell if deprecation isn't what is wanted as
> > > personally other than cleanliness I don't mind. If we do decide not t=
o
> > > have sysfs/json be the priority then I think it sensible to revert th=
e
> > > changes making it the priority for events that specify a PMU. I'd lik=
e
> > > some level of consistency.
> >
> > Personally this change feels like it's encouraging fragmentation, the
> > cleanest would be if RISC-V supports the legacy events like the other
> > platforms. It's not a huge set of events anyway, and then existing
> > software continues to work in addition to Perf continuing to work.
>
> So I try to be agnostic on the issue but we got to this point because
> of events being broken on ARM Apple chips. I fixed an issue where the
> ARM core PMU appeared as an uncore PMU as ARM's PMU naming differs
> from everyone else's. That fix made it so we used legacy events for
> the ARM core PMU, the PMU driver didn't handle this correctly (at the
> time) on ARM Apple Linux breaking perf over multiple Linux releases
> affecting a number of users.
>
> Having a pool of standard events isn't on the face of it a crazy idea,
> I'll try to remember things that have come up:
>
> 1) instructions and cycles seem like fairly easy events to agree upon.
> However, we also have cpu-cycles that means cycles. With legacy events
> the hyphen is often used as a PMU separator. Now what does the cpu
> mean here? On ARM you also have cpu_cycles as a sysfs event, ie an
> underscore and not a hyphen:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
tree/drivers/perf/arm_pmuv3.c?h=3Dperf-tools-next#n192
> What does 'cpu' mean when ARM has no core PMU called 'cpu' and in
> heterogeneous systems there are multiple notions of 'cpu' for the core
> PMU.
> What's my point? Just trying to make a minimal 2 event set of common
> events with the way things currently parse leads to ambiguity.
>
> 2) missing/ambiguous legacy events. Beyond instructions and cycles
> there are cache references, cache misses, branch instructions, branch
> misses, bus cycles, stalled cycles frontend, stalled cycles backend
> and reference CPU cycles. This set of events captures an out-of-order
> machine with a single bus, but even then there's ambiguity over
> whether the events include speculatively executed instructions or not.
> What's my point? Using these events leads to unpredictable counts in
> software. With a sysfs/json event there is a description but none was
> ever given about what these legacy events should do, or do if you have
> a system with >1 bus, counts for speculatively executed instructions,
> isn't out-of-order, etc.
>
> 3) "legacy cache" events never really took off. The legacy cache event
> names encoded data around speculation and appeared less ambiguous, a
> good source for all the names supported by perf is here:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
tree/tools/perf/util/evsel.c?h=3Dperf-tools-next#n734
> but choices were made like prefetch is the same as a speculative read
> in the encoding. Vendors no doubt agree and disagree on this. LLC and
> L2 are synonyms, but today LLC generally means L3 and often an
> entirely separate PMU.
> What's my point? The code tried to do a smarter less ambiguous thing
> than PERF_TYPE_HARDWARE with PERF_TYPE_HW_CACHE but again it was
> flawed, carried too many architectural assumptions and without the
> drivers adopting it neither did users.
>
> 4) PMU drivers mapping issues and the aforementioned ARM Apple Linux
> breakage, RISC-V wanting to keep mappings out of a more simplistic
> driver.
>
> So I wasn't there for all of this, but I think this is what led to the
> legacy events effectively becoming deprecated.
>
> > If we're still thinking that RISC-V will support the legacy events
> > anyway in the future, then it weakens the argument to change this and
> > risk any breakages that fall out of it.
>
> Agreed, that's why I keep saying I'm only doing this because ARM and
> RISC-V want it. What I want is that for things like the encoding of

In the beginning, we wanted it for the RISC-V ecosystem because we had
an opportunity to start
from a clean slate and attempt a better implementation. However, the
burden of supporting the existing
existing users who try to run their preferred way of profiling
applications by using
legacy events (especially cycle/instructions) are forcing us to follow
the convention (have the encodings specified in the driver as well.
) unfortunately.

However, we can add the encodings under a Kconfig which can be
disabled or removed in the future if we get
to a point where there are no legacy users.

> "cpu-cycles" and "cpu/cpu-cycles/" when there is only 1 PMU providing
> such an event called "cpu" the perf_event_attr encodings should match,
> we don't have this today but did prior to changing the priority to fix
> the ARM Apple Linux issue.
>
> I think for what Atish is asking for perhaps the best route is to add
> vendor standard events like ARM has. Anything done in Linux won't
> carry over to other operating systems you can be trying to virtualize.
> This doesn't to me feel like a problem we should be trying to solve
> either in the kernel/driver or the tool, well I've not heard an idea
> how we can.
>

Apart from the non-Linux guests using SBI PMU events, the host
hypervisor(also running Linux) may need
event mapping available in the driver for the following reasons even
for guests running Linux.

1. The guest Linux is not running the updated perf tool with the
correct json file
2. VMM wants to fake the unique identifiers (vendorid, archid, implid)
for migration or some
other reasons.

Both these use cases are probably corner cases at best. That's why, I
am inclined to keep the encoding
in the driver to begin with with the hope we won't need to serve these
use cases in the future.

The driver will use the raw events coming from json as a preferred
method for all the events anyways. In that case,
the hypervisor doesn't have to do anything apart from filtering. In
absence of it, the events are encoded as legacy
(HARDWARE or HARDWARE_CACHE) and the hypervisor will try its best to
map those to a platform specific encoding.

> > I'm also not sure whether they really are legacy or just a common base
> > set of events. Since the extended type thing was added even the legacy
> > events support hybrid, so it's not like they expired from lack of
> > features. Even if we claim they're legacy, is that really ever going to
> > make them go away?
>
> So for heterogeneous chips ARM first did BIG.little over ten years
> ago. More recently Intel did hybrid and it wasn't until Intel added
> hybrid support for legacy events that the idea of this worked. As you
> know, ARM''s support came later. Does software outside of the perf
> tool know to encode information in the extended type information in
> legacy events? I doubt it. For example, libpfm4 has only recently been
> adding support for heterogeneous CPUs.
>
> So yes there are legacy events and they are a common pool of events
> which is convenient for developers, however, this approach quickly
> showed shortcomings and often lacked proper vendor support. My company
> advocates developers against using common events, which admittedly is
> more work for the developer, because we've had multiple issues over
> the years primarily due to baked in assumptions.
>
> Thanks,
> Ian
>
> > Although I admit nobody has come out with a definitive use case that
> > doesn't use either the cycles or instructions events, so maybe its all =
fine.
> >
> > >
> > > 3) I'd like event parsing to be a library that is as easy to link
> > > against as libbpf (i.e. not a viral license). Event parsing is really
> > > just mapping an event name to 1 or more perf_event_attr. The PMU
> > > abstraction is tied into the event parsing, but this has only been
> > > more true recently. The evsel/evlist is tied into event parsing but
> > > that feels separable. As most json isn't distributed under a viral
> > > license this feels achievable, then I suspect most tools can use this
> > > library rather than have to reinvent a wheel.
> > >
> > > Still looking for tags :-)
> > >
> > > Thanks,
> > > Ian
> >
