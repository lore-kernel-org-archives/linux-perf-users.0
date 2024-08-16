Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181E51E52C
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822223; cv=none; b=eCitrc5BVNqnoyakxYcKdNXMMnO4adrQx9F1dLtZPSwIuNA4dGuX4T3QqKsHEW1zk7FgL9OdqjBpKXL+CWsQF6cIfviIdqPnZQpDm1axW70sWVjV/B1m2ckTtWM2ohAo/3yqQGvFJByDdoEL1Mk1KC372O4L4pLBaVaB/697uxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822223; c=relaxed/simple;
	bh=gB9HnUV5NMEDxVkjVUsTkoJsV/gDO+vD7EQNEPKN5MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZP4iEUBEkkxh367Inz98PzgbGjZTbDUJsy1Nz7X+Q0hWaVvU1xBtjtSkurh09PQOiZlhEAqt3OrqhMYFlYXZMDCIQ7sl5xB+DbEvy9arRbkF35BDYrGijm0Y4NEm2354Nbr64KDfrvjWSx5lFyroH9sN3nuTosYxyMnSTSqqHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gv38gdDg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gv38gdDg"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-202018541afso86005ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 08:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723822220; x=1724427020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKgfjg1tUz4vN5jn/O7AvpuIBEU5k1FZqbce4ICSkgw=;
        b=Gv38gdDgZePpDYo7lSApN1YES+EIk1UACCKjeh+QarcJFSS4FWSieHqugQIMPhaRTb
         AvLiRvdTPLJDD3X7gutlcNSpSkQCZA2D6VAYy8Ka8ryBf/F99JLZxPQM7qNfDlFKTZc7
         TmJ3ewr2FEjXA79ScJcr2SyFlzGSqiYKgCez1WAxuOjR011RAf5JrLHiMZ7xSvR0a0ed
         hozyzYIt0o3Q43Z7dwPO/09b0KAtYdZ3Moa8SWZPlVFNwpgcJ5ivkPyNs7vMQjsD0MHg
         2BRkh0D3HuLBOf1yxd0aS81ZmbuRlvoy2xbK+5Y/2JrBe7nDwDo7IM3wOEFHdRjWjqEU
         qJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723822220; x=1724427020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKgfjg1tUz4vN5jn/O7AvpuIBEU5k1FZqbce4ICSkgw=;
        b=dOhsv7vxyn2Cw4RwubTgVxMLOorpI4xDKHuj7TGJdiNVkDovx13eAOpzRgoK7irFpa
         ID0AGbhEheiCsaRUt/xMT9NzXDXwRTqv5DIOqeJHAGOgnNrs7cjwyIAtN5K9gbmHffND
         M76HFhUp0KESe58ZYJ19+7W9WaSs6QcZFwFJjJL06juGfVt4L/FQVLtn6/hWYlw8vOTn
         EldUh8J2kxfWmVsift7UZ70BlPoraQHxr6R6rxpXS7BKLrCQWMpc8iqPVjrHFhuLIF3L
         QSf47QM/iJm7lYzz6Oy9JTpfOlJBdy1O61G6DaO+BrKmXhhqsvh+mEOOUuKoeijrlguV
         xgFw==
X-Forwarded-Encrypted: i=1; AJvYcCUeVqMxHiJeut8oGTxsrYxCh0o2eeT8vZuyU4rlCVyg0+qNCfPMJf6YV8oyzgGoQI/izzADI2wIrR9s/Pydytf6Ho2xCg0DTCrM+xPE7jz/Bw==
X-Gm-Message-State: AOJu0Yyzq58osNrbqkyXnI4aVHp2iyzI4wYLL9WyEbFLZa3p80YNPkPA
	L5IRDxqXgyLp6G5bLix9qsnZAYEu6NPrMdA+3ph5d5SIdNl+vVsiXr45ZOTPNCjbnBEmbsof+Ar
	Ka9Leq7TgYMeyB1Gaq12+s45rLZwgGUJ69hjR
X-Google-Smtp-Source: AGHT+IEO/5CPJs/HMyACGlvsGf06eNylwVBaUC+6XgbHiiq+XwSZE997Ec0zaM2M8ghyJY86zfSun9As72o9WzDqHM8=
X-Received: by 2002:a17:902:e5c1:b0:1fd:d0c0:1a69 with SMTP id
 d9443c01a7336-2020851a119mr1182435ad.9.1723822219640; Fri, 16 Aug 2024
 08:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
 <ZV1AnNB2CSbAUFVg@archie.me> <a9c14dfd-3269-4758-9174-4710bef07088@leemhuis.info>
 <CAP-5=fXqx_k1miPTkcAmS3z2GBPt2KeDtP5fknmdDghZqxXPew@mail.gmail.com>
 <714ed350-0e6c-4922-bf65-36de48f62879@leemhuis.info> <0de3b572-f5f7-42e4-b410-d1e315943a3c@linaro.org>
 <CAP-5=fVSVe=C5dHaOV22+YOZ_JCD0mDoByoubSFY3w4au5zwQg@mail.gmail.com> <6cbd2f1d-2aea-486c-a3cb-bb6eb08d8bdc@linaro.org>
In-Reply-To: <6cbd2f1d-2aea-486c-a3cb-bb6eb08d8bdc@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 16 Aug 2024 08:30:07 -0700
Message-ID: <CAP-5=fXX10Jra-LogXL0M3O5OU_YpBaA=7S54upENzJ86Y5Hvw@mail.gmail.com>
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since v6.5
To: James Clark <james.clark@linaro.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Linux perf Profiling <linux-perf-users@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, James Clark <james.clark@arm.com>, 
	"cc: Marc Zyngier" <maz@kernel.org>, Hector Martin <marcan@marcan.st>, Asahi Linux <asahi@lists.linux.dev>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 2:23=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 15/08/2024 6:29 pm, Ian Rogers wrote:
> > On Wed, Aug 14, 2024 at 9:28=E2=80=AFAM James Clark <james.clark@linaro=
.org> wrote:
> >> On 07/08/2024 9:54 am, Thorsten Leemhuis wrote:
> >>> On 01.08.24 21:05, Ian Rogers wrote:
> >>>> On Wed, Dec 6, 2023 at 4:09=E2=80=AFAM Linux regression tracking #up=
date
> >>>> (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
> >>>>>
> >>>>> [TLDR: This mail in primarily relevant for Linux kernel regression
> >>>>> tracking. See link in footer if these mails annoy you.]
> >>>>>
> >>>>> On 22.11.23 00:43, Bagas Sanjaya wrote:
> >>>>>> On Tue, Nov 21, 2023 at 09:08:48PM +0900, Hector Martin wrote:
> >>>>>>> Perf broke on all Apple ARM64 systems (tested almost everything),=
 and
> >>>>>>> according to maz also on Juno (so, probably all big.LITTLE) since=
 v6.5.
> >>>>>
> >>>>> #regzbot fix: perf parse-events: Make legacy events lower priority =
than
> >>>>> sysfs/JSON
> >>>>> #regzbot ignore-activity
> >>>>
> >>>> Note, this is still broken.
> >>>
> >>> Hmmm, so all that became somewhat messy. Arnaldo, what's the way out =
of
> >>> this? Or is this a "we are screwed one way or another and someone has=
 to
> >>> bite the bullet" situation?
> >>>
> >>> Ciao, Thorsten
> >>>
> >>>> The patch changed the priority in the case
> >>>> that you do something like:
> >>>>
> >>>> $ perf stat -e 'armv8_pmuv3_0/cycles/' benchmark
> >>>>
> >>>> but if you do:
> >>>>
> >>>> $ perf stat -e 'cycles' benchmark
> >>>>
> >>>> then the broken behavior will happen as legacy events have priority
> >>>> over sysfs/json events in that case. To fix this you need to revert:
> >>>> 4f1b067359ac Revert "perf parse-events: Prefer sysfs/JSON hardware
> >>>> events over legacy"
> >>>>
> >>>> This causes some testing issues resolved in this unmerged patch seri=
es:
> >>>> https://lore.kernel.org/lkml/20240510053705.2462258-1-irogers@google=
.com/
> >>>>
> >>>> There is a bug as the arm_dsu PMU advertises an event called "cycles=
"
> >>>> and this PMU is present on Ampere systems. Reverting the commit abov=
e
> >>>> will cause an issue as the commit 7b100989b4f6 ("perf evlist: Remove
> >>>> __evlist__add_default") to fix ARM's BIG.little systems (opening a
> >>>> cycles event on all PMUs not just 1) will cause the arm_dsu event to
> >>>> be opened by perf record and fail as the event won't support samplin=
g.
> >>>>
> >>>> The patch https://lore.kernel.org/lkml/20240525152927.665498-1-iroge=
rs@google.com/
> >>>> fixes this by only opening the cycles event on core PMUs when choosi=
ng
> >>>> default events.
> >>>>
> >>>> Rather than take this patch the revert happened as Linus runs the
> >>>> command "perf record -e cycles:pp" (ie using a specified event and n=
ot
> >>>> defaults) and considers it a regression in the perf tool that on an
> >>>> Ampere system to need to do "perf record -e
> >>>> 'armv8_pmuv3_0/cycles/pp'". It was pointed out that not specifying -=
e
> >>>> will choose the cycles event correctly and with better precision the
> >>>> pp for systems that support it, but it was still considered a
> >>>> regression in the perf tool so the revert was made to happen. There =
is
> >>>> a lack of perf testing coverage for ARM, in particular as they choos=
e
> >>>> to do everything in a different way to x86. The patch in question wa=
s
> >>>> in the linux-next tree for weeks without issues.
> >>>>
> >>>> ARM/Ampere could fix this by renaming the event from cycles to
> >>>> cpu_cycles, or by following Intel's convention that anything uncore
> >>>> uses the name clockticks rather than cycles. This could break people
> >>>> who rely on an event called arm_dsu/cycles/ but I imagine such peopl=
e
> >>>> are rare. There has been no progress I'm aware of on renaming the
> >>>> event.
> >>>>
> >>>> Making perf not terminate on opening an event for perf record seems
> >>>> like the most likely workaround as that is at least something under
> >>>> the tool maintainers control. ARM have discussed doing this on the
> >>>> lists:
> >>>> https://lore.kernel.org/lkml/f30f676e-a1d7-4d6b-94c1-3bdbd1448887@ar=
m.com/
> >>>> but since the revert in v6.10 no patches have appeared for the v6.11
> >>>> merge window. Feature work like coresight improvements and ARMv9 are
> >>>> being actively pursued by ARM, but feature work won't resolve this
> >>>> regression.
> >>>>
> >>
> >> I got some hardware with the DSU PMU so I'm going to have a go at tryi=
ng
> >> to send some fixes for this. My initial idea was to try incorporate th=
e
> >> "not terminate on opening" change as discussed in the link directly
> >> above. And then do the revert of the "revert of prefer sysfs/json".
> >
> > Thanks, I think this would be good. The biggest issue is that none of
> > the record logic expects a file descriptor to be not opened, deleting
> > unopened evsels from the evlist breaks all the indexing into the
> > mmaps, etc. Tbh, you probably wouldn't do the code this way if was
> > written afresh. Perhaps a hashmap would map from an evsel to ring
> > buffer mmaps, etc. Trying to avoid having global state and benefitting
> > from encapsulation. I'd focus on just doing the expedient thing in the
> > changes, which probably just means making the record code tolerant of
> > evsels that fail to open and not modifying the evlist due to the risk
> > it breaks the indices.
> >
>
> Thanks for the tips.
>
> > (To point out the obvious, this work wouldn't be necessary if arm_dsu
> > event were renamed from "cycles" to "cpu_cycles" which would also make
> > it more intention revealing alongside the arm_dsu's "bus_cycles" event
> > name).
> >
>
> I understand but I can imagine the following conversation if we rename th=
at:
>
>    User: "I updated my kernel and now my (non Perf) tool fails to open
>           the DSU cycles event because it doesn't exist anymore"
>
>    Linus/maintainers: "Oh ok yes that was a userspace breaking change,
>                       lets revert it"
>
> Just because Perf can handle 3 different names for cycles doesn't mean
> other tools can.

cycles was a bad event name, dsu is a terrible name for what is mainly
the l3 cache, the risk that the two are combined get broken I'm fine
with as neoverse users with uncore permissions are say much rarer than
Apple M users. Having a cycles and a bus_cycles event is already
ambiguous, they sound the same. Renaming cycles to cpu_cycles would be
best.

> >> FWIW I don't think Juno currently is broken if the kernel supports
> >> extended type ID? I could have missed some output in this thread but i=
t
> >> seems like it's mostly related to Apple M hardware. I'm also a bit
> >> confused why the "supports extended type" check fails there, but maybe
> >> the v6.9 commit 25412c036 from Mark is missing?
> >
> > So I think your later emails clarify Arnaldo is probably missing:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/commit/drivers/perf/arm_pmu.c?h=3Dperf-tools-next&id=3D5c816728651ae42595=
4542fed64d21d40cb75a9f
> >
> > Fwiw, the Apple M hardware issue came to me by way of Mark Rutland
> > (iirc), this regression report, etc. My understanding is that Apple M
> > has something like a v2 ARM PMU and the legacy events are encoded
> > incorrectly in the driver for this. The regression in v6.5 happened
>
> I'm not sure about that. The M PMU events may be incomplete, but the two
> that are there have a mapping that looks sane:
>
>    static const unsigned m1_pmu_perf_map[PERF_COUNT_HW_MAX] =3D {
>         PERF_MAP_ALL_UNSUPPORTED,
>         [PERF_COUNT_HW_CPU_CYCLES]      =3D M1_PMU_PERFCTR_CPU_CYCLES,
>         [PERF_COUNT_HW_INSTRUCTIONS]    =3D M1_PMU_PERFCTR_INSTRUCTIONS,
>         /* No idea about the rest yet */
>    };
>
> And they map to the same named events:
>
>    static struct attribute *m1_pmu_event_attrs[] =3D {
>         M1_PMU_EVENT_ATTR(cycles, M1_PMU_PERFCTR_CPU_CYCLES),
>         M1_PMU_EVENT_ATTR(instructions, M1_PMU_PERFCTR_INSTRUCTIONS),
>         NULL,
>    };
>
> So in this case I can't see using legacy vs sysfs events making a
> difference. Maybe there is some other case that was mentioned in a
> previous thread that I missed though.

No idea, iirc Mark Rutland requested not to use legacy events for Apple M.

> > because ARM's core PMUs had previously been treated as uncore PMUs,
> > meaning we wouldn't try to program legacy events on them. Fixing the
> > handling of ARM's core PMUs broke Apple M due to the broken legacy
> > event mappings. Why not fix the Apple M PMU driver? Well there was
> > anyway a similar RISC-V issue reported by Atish Patra (iirc) where the
> > RISC-V PMU driver wants to delegate the mapping of legacy events to
> > the perf tool so the driver needn't be aware of all and future RISC-V
> > configurations. The fix discussed with Mark, Atish, etc. has been to
> > swap the priority of legacy and sysfs/json events so that the latter
> > has priority. We need the revert of the revert as currently we only do
> > this if a PMU is specified with an event, not for the general wildcard
> > PMUs case that most people use. There was huge fallout from flipping
>
> Yep makes sense to do the revert if RISC-V isn't going to support any
> legacy events. Although from what I understand that would technically
> only require JSON to be the highest priority? Because putting named
> events in sysfs still requires kernel involvement so doesn't get you any
> further than supporting the legacy events?

The sysfs and json event handling is interwoven, for example you can
add to a sysfs event with json information. There are basically two
approaches in the event parser, hardcoded legacy things and event
names (optionally with PMU names). I'm trying to get rid of the
hardcoded legacy things as they were fine when you had a single core
type, but I want to have events everywhere - say instructions and
cycles on a GPU so we can IPC on a GPU. For RISC-V as long as the
legacy events are covered as names in json and json/sysfs has priority
over legacy then things will be fine.

> Seems like there is another reason to do the revert though as Mark
> mentioned: That now directly specifying the PMU eg "-e
> arm_cortex_a56/cycles/" opens a legacy event if the event matches one,
> which is not the best thing to do. But the revert fixes this AFAIK, so
> while having the priority JSON/legacy/sysfs might work for RISC-V it
> wouldn't work for a platform that wants a slightly different sysfs event
> than legacy but with the same name. And the priority should be
> JSON/sysfs/legacy.

The priority for events with a PMU is the sysfs/json has a priority
over legacy names, so I don't understand what you're saying here. Your
example shouldn't be broken. The revert is for the case where no PMU
is specified, where the priority is the opposite which is at best
inconsistent.

> > the priority particularly on Intel as all test expectations needed
> > updating. I've sent out similar fixes that need incorporating when the
> > revert is reverted. Ideally tools/perf/tests/parse-events.c would be
> > updated to cover ARM's PMUs that don't follow the normal pattern that
> > the core PMU is called "cpu" (this would mean that we were testing
> > event parsing on ARM was WAI wrt encoding priorities, BIG.little,
> > etc).
> >
> >> I sent a small fix the other day to make perf stat default arguments
> >> work on Juno, and didn't notice anything out of the ordinary:
> >> https://lore.kernel.org/linux-perf-users/dac6ad1d-5aca-48b4-9dcb-ff7e5=
4ca43f6@linaro.org/T/#t
> >> I agree that change is quite narrow but it does incrementally improve
> >> things for the time being. It's possible that it would become redundan=
t
> >> if I can just include Ian's change to use strings for Perf stat.
> >
> > I'd prefer we didn't merge this as we'd need to rebase:
> > https://lore.kernel.org/lkml/20240510053705.2462258-4-irogers@google.co=
m/
> > and those changes would then delete the code introduced. I'm fine with
> > adding the tests.
> >
> > There are more exotic heterogeneous core things upcoming, probably
> > also from ARM, and the thought of duplicating the default attribute
> > logic and event parsing constraints is just something I'd prefer not
> > to have to do.
> >
>
> Yep I don't have any strong feelings about this. Even if we don't merge
> it it helped me understand the code and the issue a bit.
>
> I think one thing I assumed about your change was that there was some
> dependency on these other changes. But the more I look at it I think
> it's actually fine on it's own?

Which change? If the change is trying to use "cycles" to open on all
PMUs because it will be wild carded then it will run into the priority
issue.

> Using the cycles string actually works today, even on Apple M. The only
> real remaining issue is softening the error for failure to open, but
> that's _after_ doing the revert of the revert and is separate.
>
> I will re-test that one today with fresh eyes.

Perhaps it is other legacy events, not cycles and instructions. There
must have been a reason for this regression report but I don't have an
Apple M CPU to test on.

Thanks,
Ian
