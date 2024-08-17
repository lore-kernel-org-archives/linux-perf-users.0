Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D184A21
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Aug 2024 01:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723858715; cv=none; b=SAvCFpqoubOz5OkuJ7q0vz4DfVUI2aS7FkhbvtPM7vk5pF/6CXeDcfpU8ufUtxstF6htxngacxC+vmMKSQFP+dzvSNLYCTiDfxReloqhyP71O6s0vA/c6X/DtyJvZonypPkRfV651Fk/sRjwj6I5eiaKT56P5/QaM9JnTz3Uz9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723858715; c=relaxed/simple;
	bh=YMndA6gm2WglsPJPIxoUSLLSTAyxiJ/tPDTjLgXpuqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Za3cffBg1+Xvh6jYri9cKxl/ZPj1TXrFW5JEGutaHCaXmrwE4wAA7QSnd5uXBzWsArY/RtQnnJMB1T4squHG2eg9UXIZjhcdip+TrLYHbTujJmQ0MRM01feO9EyGCPb0SW2JGTBRaYKlZMIUGekWpEatuoC3ZxiYdwnl7kLby7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yAWKmGNG; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yAWKmGNG"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53301d46c54so3503311e87.2
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 18:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723858710; x=1724463510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFe7AahprE6s2YtEoEg3v2lR7yjBv8hqbL/0X1aLqdo=;
        b=yAWKmGNGeL69IAOLx2D5wg5ZDfyo0scGl7lLdp0n2jPmX0OczVASh6J95ErbwrpFyz
         MljkdciqLRHQZC+bAGbt2ZiavN5GBJUkNlN0ADH8BI+3kdmMzf61aanwKayPUbc4PQBt
         3k1Ke9aTlOttd2Mc2+gbEUrSyxRboPUlwLrrpdbDZbTokcFm3CxuEkvM2QkpR0l30PKh
         huH6Rv3VXScRz0uksO8N3L71v+vtKy5xSAbbN1AWTKCjvJybHBxKH6AOn7Eua6NLY/b7
         rp6nQPOVsdIqHWyOq0TDEtuQSfrcdHBznwAkc8ZLfdalpmnOwAExktu8AwcF3I3mT+WX
         5+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723858710; x=1724463510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFe7AahprE6s2YtEoEg3v2lR7yjBv8hqbL/0X1aLqdo=;
        b=QVM8ipRQDS65oWA+G6/cmoxLOeeKwzXo43As4q3aj8l3pkmckWniAGSRRcrwjLY1pt
         CojDjV+jO1dsMwrGEA0qVMNg85UykyUAGvKZweArTJlP2DklqZibgRaaFi5/In2SoNJF
         sDnF+iG7d+Ii3YWlEaXviGxv0gdiHww3B6KSFw8Sc4OBLDcWSlArgD+L6quJBV99CEl8
         RFEsZ90WTfItUS4hZ2qxYmHEzpyobfDu7F54hKlYt1DP4owxMEYfP70NDvgUZ60psOB8
         n2Wxux3+B7/IE5mncEeb6RAPIJKprxSlA9xxVkR+gd/GB0bV9xcgiii5UYEwDBNkmISv
         /HJA==
X-Forwarded-Encrypted: i=1; AJvYcCUhLKQxkwstcVfCyk5Z/VDRxvc4ro/Qivz2LGHOK4D/6eOW08vBLLdT2l5JQJ/ogCjNt3M4Luc5uci74hS8n2opa6zO6A+58NcyqBrU6PvEuA==
X-Gm-Message-State: AOJu0Yw2ipPRyRR/T9Dr8hHTF1fX1LwQnRN8bB8cmAQx+RcqQftqReuE
	VsMDq0Lp8ixuUEggocBm1T0hwVXE5maHH+uMwpbne6FCp0hgHT/NKk1iR5uZEC/pcfsJt1HIdxF
	XlSoh7ZXDGqeFxSVZxhL8RhB+RvEHxJcRFdTmXw==
X-Google-Smtp-Source: AGHT+IHdv5Y/2LjORAtY3flQrvtdD0G3wpHOlX1La92acZG9slSJQ0oo5c592B4ccXyRx3KLPyhzSHDRxOFBqM4UMyA=
X-Received: by 2002:a05:6512:6c8:b0:530:aba8:d37a with SMTP id
 2adb3069b0e04-5331c6e3a8amr2641096e87.37.1723858709943; Fri, 16 Aug 2024
 18:38:29 -0700 (PDT)
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
 <CAP-5=fVSVe=C5dHaOV22+YOZ_JCD0mDoByoubSFY3w4au5zwQg@mail.gmail.com>
 <6cbd2f1d-2aea-486c-a3cb-bb6eb08d8bdc@linaro.org> <CAP-5=fXX10Jra-LogXL0M3O5OU_YpBaA=7S54upENzJ86Y5Hvw@mail.gmail.com>
In-Reply-To: <CAP-5=fXX10Jra-LogXL0M3O5OU_YpBaA=7S54upENzJ86Y5Hvw@mail.gmail.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Fri, 16 Aug 2024 18:38:18 -0700
Message-ID: <CAHBxVyGz5Cjd_QH4AWWZ=cQnQ0KKCJeLcT+aKO5QUxpGegdRLw@mail.gmail.com>
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since v6.5
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>, Thorsten Leemhuis <regressions@leemhuis.info>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Linux perf Profiling <linux-perf-users@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, James Clark <james.clark@arm.com>, 
	"cc: Marc Zyngier" <maz@kernel.org>, Hector Martin <marcan@marcan.st>, Asahi Linux <asahi@lists.linux.dev>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 8:30=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Aug 16, 2024 at 2:23=E2=80=AFAM James Clark <james.clark@linaro.o=
rg> wrote:
> >
> >
> >
> > On 15/08/2024 6:29 pm, Ian Rogers wrote:
> > > On Wed, Aug 14, 2024 at 9:28=E2=80=AFAM James Clark <james.clark@lina=
ro.org> wrote:
> > >> On 07/08/2024 9:54 am, Thorsten Leemhuis wrote:
> > >>> On 01.08.24 21:05, Ian Rogers wrote:
> > >>>> On Wed, Dec 6, 2023 at 4:09=E2=80=AFAM Linux regression tracking #=
update
> > >>>> (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
> > >>>>>
> > >>>>> [TLDR: This mail in primarily relevant for Linux kernel regressio=
n
> > >>>>> tracking. See link in footer if these mails annoy you.]
> > >>>>>
> > >>>>> On 22.11.23 00:43, Bagas Sanjaya wrote:
> > >>>>>> On Tue, Nov 21, 2023 at 09:08:48PM +0900, Hector Martin wrote:
> > >>>>>>> Perf broke on all Apple ARM64 systems (tested almost everything=
), and
> > >>>>>>> according to maz also on Juno (so, probably all big.LITTLE) sin=
ce v6.5.
> > >>>>>
> > >>>>> #regzbot fix: perf parse-events: Make legacy events lower priorit=
y than
> > >>>>> sysfs/JSON
> > >>>>> #regzbot ignore-activity
> > >>>>
> > >>>> Note, this is still broken.
> > >>>
> > >>> Hmmm, so all that became somewhat messy. Arnaldo, what's the way ou=
t of
> > >>> this? Or is this a "we are screwed one way or another and someone h=
as to
> > >>> bite the bullet" situation?
> > >>>
> > >>> Ciao, Thorsten
> > >>>
> > >>>> The patch changed the priority in the case
> > >>>> that you do something like:
> > >>>>
> > >>>> $ perf stat -e 'armv8_pmuv3_0/cycles/' benchmark
> > >>>>
> > >>>> but if you do:
> > >>>>
> > >>>> $ perf stat -e 'cycles' benchmark
> > >>>>
> > >>>> then the broken behavior will happen as legacy events have priorit=
y
> > >>>> over sysfs/json events in that case. To fix this you need to rever=
t:
> > >>>> 4f1b067359ac Revert "perf parse-events: Prefer sysfs/JSON hardware
> > >>>> events over legacy"
> > >>>>
> > >>>> This causes some testing issues resolved in this unmerged patch se=
ries:
> > >>>> https://lore.kernel.org/lkml/20240510053705.2462258-1-irogers@goog=
le.com/
> > >>>>
> > >>>> There is a bug as the arm_dsu PMU advertises an event called "cycl=
es"
> > >>>> and this PMU is present on Ampere systems. Reverting the commit ab=
ove
> > >>>> will cause an issue as the commit 7b100989b4f6 ("perf evlist: Remo=
ve
> > >>>> __evlist__add_default") to fix ARM's BIG.little systems (opening a
> > >>>> cycles event on all PMUs not just 1) will cause the arm_dsu event =
to
> > >>>> be opened by perf record and fail as the event won't support sampl=
ing.
> > >>>>
> > >>>> The patch https://lore.kernel.org/lkml/20240525152927.665498-1-iro=
gers@google.com/
> > >>>> fixes this by only opening the cycles event on core PMUs when choo=
sing
> > >>>> default events.
> > >>>>
> > >>>> Rather than take this patch the revert happened as Linus runs the
> > >>>> command "perf record -e cycles:pp" (ie using a specified event and=
 not
> > >>>> defaults) and considers it a regression in the perf tool that on a=
n
> > >>>> Ampere system to need to do "perf record -e
> > >>>> 'armv8_pmuv3_0/cycles/pp'". It was pointed out that not specifying=
 -e
> > >>>> will choose the cycles event correctly and with better precision t=
he
> > >>>> pp for systems that support it, but it was still considered a
> > >>>> regression in the perf tool so the revert was made to happen. Ther=
e is
> > >>>> a lack of perf testing coverage for ARM, in particular as they cho=
ose
> > >>>> to do everything in a different way to x86. The patch in question =
was
> > >>>> in the linux-next tree for weeks without issues.
> > >>>>
> > >>>> ARM/Ampere could fix this by renaming the event from cycles to
> > >>>> cpu_cycles, or by following Intel's convention that anything uncor=
e
> > >>>> uses the name clockticks rather than cycles. This could break peop=
le
> > >>>> who rely on an event called arm_dsu/cycles/ but I imagine such peo=
ple
> > >>>> are rare. There has been no progress I'm aware of on renaming the
> > >>>> event.
> > >>>>
> > >>>> Making perf not terminate on opening an event for perf record seem=
s
> > >>>> like the most likely workaround as that is at least something unde=
r
> > >>>> the tool maintainers control. ARM have discussed doing this on the
> > >>>> lists:
> > >>>> https://lore.kernel.org/lkml/f30f676e-a1d7-4d6b-94c1-3bdbd1448887@=
arm.com/
> > >>>> but since the revert in v6.10 no patches have appeared for the v6.=
11
> > >>>> merge window. Feature work like coresight improvements and ARMv9 a=
re
> > >>>> being actively pursued by ARM, but feature work won't resolve this
> > >>>> regression.
> > >>>>
> > >>
> > >> I got some hardware with the DSU PMU so I'm going to have a go at tr=
ying
> > >> to send some fixes for this. My initial idea was to try incorporate =
the
> > >> "not terminate on opening" change as discussed in the link directly
> > >> above. And then do the revert of the "revert of prefer sysfs/json".
> > >
> > > Thanks, I think this would be good. The biggest issue is that none of
> > > the record logic expects a file descriptor to be not opened, deleting
> > > unopened evsels from the evlist breaks all the indexing into the
> > > mmaps, etc. Tbh, you probably wouldn't do the code this way if was
> > > written afresh. Perhaps a hashmap would map from an evsel to ring
> > > buffer mmaps, etc. Trying to avoid having global state and benefittin=
g
> > > from encapsulation. I'd focus on just doing the expedient thing in th=
e
> > > changes, which probably just means making the record code tolerant of
> > > evsels that fail to open and not modifying the evlist due to the risk
> > > it breaks the indices.
> > >
> >
> > Thanks for the tips.
> >
> > > (To point out the obvious, this work wouldn't be necessary if arm_dsu
> > > event were renamed from "cycles" to "cpu_cycles" which would also mak=
e
> > > it more intention revealing alongside the arm_dsu's "bus_cycles" even=
t
> > > name).
> > >
> >
> > I understand but I can imagine the following conversation if we rename =
that:
> >
> >    User: "I updated my kernel and now my (non Perf) tool fails to open
> >           the DSU cycles event because it doesn't exist anymore"
> >
> >    Linus/maintainers: "Oh ok yes that was a userspace breaking change,
> >                       lets revert it"
> >
> > Just because Perf can handle 3 different names for cycles doesn't mean
> > other tools can.
>
> cycles was a bad event name, dsu is a terrible name for what is mainly
> the l3 cache, the risk that the two are combined get broken I'm fine
> with as neoverse users with uncore permissions are say much rarer than
> Apple M users. Having a cycles and a bus_cycles event is already
> ambiguous, they sound the same. Renaming cycles to cpu_cycles would be
> best.
>
> > >> FWIW I don't think Juno currently is broken if the kernel supports
> > >> extended type ID? I could have missed some output in this thread but=
 it
> > >> seems like it's mostly related to Apple M hardware. I'm also a bit
> > >> confused why the "supports extended type" check fails there, but may=
be
> > >> the v6.9 commit 25412c036 from Mark is missing?
> > >
> > > So I think your later emails clarify Arnaldo is probably missing:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/commit/drivers/perf/arm_pmu.c?h=3Dperf-tools-next&id=3D5c816728651ae425=
954542fed64d21d40cb75a9f
> > >
> > > Fwiw, the Apple M hardware issue came to me by way of Mark Rutland
> > > (iirc), this regression report, etc. My understanding is that Apple M
> > > has something like a v2 ARM PMU and the legacy events are encoded
> > > incorrectly in the driver for this. The regression in v6.5 happened
> >
> > I'm not sure about that. The M PMU events may be incomplete, but the tw=
o
> > that are there have a mapping that looks sane:
> >
> >    static const unsigned m1_pmu_perf_map[PERF_COUNT_HW_MAX] =3D {
> >         PERF_MAP_ALL_UNSUPPORTED,
> >         [PERF_COUNT_HW_CPU_CYCLES]      =3D M1_PMU_PERFCTR_CPU_CYCLES,
> >         [PERF_COUNT_HW_INSTRUCTIONS]    =3D M1_PMU_PERFCTR_INSTRUCTIONS=
,
> >         /* No idea about the rest yet */
> >    };
> >
> > And they map to the same named events:
> >
> >    static struct attribute *m1_pmu_event_attrs[] =3D {
> >         M1_PMU_EVENT_ATTR(cycles, M1_PMU_PERFCTR_CPU_CYCLES),
> >         M1_PMU_EVENT_ATTR(instructions, M1_PMU_PERFCTR_INSTRUCTIONS),
> >         NULL,
> >    };
> >
> > So in this case I can't see using legacy vs sysfs events making a
> > difference. Maybe there is some other case that was mentioned in a
> > previous thread that I missed though.
>
> No idea, iirc Mark Rutland requested not to use legacy events for Apple M=
.
>
> > > because ARM's core PMUs had previously been treated as uncore PMUs,
> > > meaning we wouldn't try to program legacy events on them. Fixing the
> > > handling of ARM's core PMUs broke Apple M due to the broken legacy
> > > event mappings. Why not fix the Apple M PMU driver? Well there was
> > > anyway a similar RISC-V issue reported by Atish Patra (iirc) where th=
e
> > > RISC-V PMU driver wants to delegate the mapping of legacy events to
> > > the perf tool so the driver needn't be aware of all and future RISC-V
> > > configurations. The fix discussed with Mark, Atish, etc. has been to
> > > swap the priority of legacy and sysfs/json events so that the latter
> > > has priority. We need the revert of the revert as currently we only d=
o
> > > this if a PMU is specified with an event, not for the general wildcar=
d
> > > PMUs case that most people use. There was huge fallout from flipping
> >
> > Yep makes sense to do the revert if RISC-V isn't going to support any
> > legacy events. Although from what I understand that would technically
> > only require JSON to be the highest priority? Because putting named
> > events in sysfs still requires kernel involvement so doesn't get you an=
y
> > further than supporting the legacy events?
>
> The sysfs and json event handling is interwoven, for example you can
> add to a sysfs event with json information. There are basically two
> approaches in the event parser, hardcoded legacy things and event
> names (optionally with PMU names). I'm trying to get rid of the
> hardcoded legacy things as they were fine when you had a single core
> type, but I want to have events everywhere - say instructions and
> cycles on a GPU so we can IPC on a GPU. For RISC-V as long as the
> legacy events are covered as names in json and json/sysfs has priority
> over legacy then things will be fine.
>

RISC-V does want to support legacy events as that's how users on other
architectures are used to
run perf. It would be weird if we don't support it.

Our initial reasoning behind relying on json for legacy events to
avoid vendor specific encodings for these
events in the driver. Unlike other ISAs, RISC-V ISA doesn't define an
event encoding for these legacy
events. As a result every platform vendor will have custom encoding.
Managing them in the driver is
cumbersome. Many thanks to Ian for posting the patches to reverse the
priority which works fine for RISC-V.

However, I understand that it is easier said than done and some use
cases are broken. We also discovered
there are few other use cases which still have the same problem even
if we solve the bigger problem via json parsing
for legacy events.

1. Any other user profiling application that invokes perf system calls
directly may also try to just legacy event attributes in
perf_event_attr.
Android simpleperf application also falls in this category. We need to
describe the platform specific encoding somewhere for these
applications.

2. Perf running inside guests may run on any hardware and can't be
tied to a platform specific json file. If we bind the legacy
events via json file, those users won't be able to use perf cycle or
instruction without the json file available.

I don't have any good solutions for the above said problems without
specifying the encoding in the driver itself.
Given all the problems around json parsing for legacy events, we are
thinking of biting the bullet and allowing platform vendors
to encode the legacy events in the driver itself similar to other
ISAs. We will try to keep the interface as scalable as possible.

Any suggestions ?

> > Seems like there is another reason to do the revert though as Mark
> > mentioned: That now directly specifying the PMU eg "-e
> > arm_cortex_a56/cycles/" opens a legacy event if the event matches one,
> > which is not the best thing to do. But the revert fixes this AFAIK, so
> > while having the priority JSON/legacy/sysfs might work for RISC-V it
> > wouldn't work for a platform that wants a slightly different sysfs even=
t
> > than legacy but with the same name. And the priority should be
> > JSON/sysfs/legacy.
>
> The priority for events with a PMU is the sysfs/json has a priority
> over legacy names, so I don't understand what you're saying here. Your
> example shouldn't be broken. The revert is for the case where no PMU
> is specified, where the priority is the opposite which is at best
> inconsistent.
>
> > > the priority particularly on Intel as all test expectations needed
> > > updating. I've sent out similar fixes that need incorporating when th=
e
> > > revert is reverted. Ideally tools/perf/tests/parse-events.c would be
> > > updated to cover ARM's PMUs that don't follow the normal pattern that
> > > the core PMU is called "cpu" (this would mean that we were testing
> > > event parsing on ARM was WAI wrt encoding priorities, BIG.little,
> > > etc).
> > >
> > >> I sent a small fix the other day to make perf stat default arguments
> > >> work on Juno, and didn't notice anything out of the ordinary:
> > >> https://lore.kernel.org/linux-perf-users/dac6ad1d-5aca-48b4-9dcb-ff7=
e54ca43f6@linaro.org/T/#t
> > >> I agree that change is quite narrow but it does incrementally improv=
e
> > >> things for the time being. It's possible that it would become redund=
ant
> > >> if I can just include Ian's change to use strings for Perf stat.
> > >
> > > I'd prefer we didn't merge this as we'd need to rebase:
> > > https://lore.kernel.org/lkml/20240510053705.2462258-4-irogers@google.=
com/
> > > and those changes would then delete the code introduced. I'm fine wit=
h
> > > adding the tests.
> > >
> > > There are more exotic heterogeneous core things upcoming, probably
> > > also from ARM, and the thought of duplicating the default attribute
> > > logic and event parsing constraints is just something I'd prefer not
> > > to have to do.
> > >
> >
> > Yep I don't have any strong feelings about this. Even if we don't merge
> > it it helped me understand the code and the issue a bit.
> >
> > I think one thing I assumed about your change was that there was some
> > dependency on these other changes. But the more I look at it I think
> > it's actually fine on it's own?
>
> Which change? If the change is trying to use "cycles" to open on all
> PMUs because it will be wild carded then it will run into the priority
> issue.
>
> > Using the cycles string actually works today, even on Apple M. The only
> > real remaining issue is softening the error for failure to open, but
> > that's _after_ doing the revert of the revert and is separate.
> >
> > I will re-test that one today with fresh eyes.
>
> Perhaps it is other legacy events, not cycles and instructions. There
> must have been a reason for this regression report but I don't have an
> Apple M CPU to test on.
>
> Thanks,
> Ian
