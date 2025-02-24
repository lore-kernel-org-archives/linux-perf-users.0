Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7577B221F0D
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Feb 2025 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418591; cv=none; b=CmccPJv8PdZZTgt4JCHae4OfW58WU/nWwWTVbtSEfhAe67Y2bQTCWNwGukiVlCbS0muydrkge8Tf24cqLHR4kiJo+xp9tD1TTVuSCqIjCY+52yebki2XDx89bQVG6O1rmqK84cYwqnGaSJstWAknFQudMvT/RW0QK1ICQYycjdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418591; c=relaxed/simple;
	bh=1jgMCayb2Acgc8H5neJdXnvWrz4pqesKGr2MwHRQ4XU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHMfhlZOiDCNWTwqx7zY+FdMtLK719LBNytMNE3ZIJaRXWW3o0DFFYOXnkbmGMlE7YNok/3fLB/3hL+noyjUUcDTWp2doPUyVVYeWRbKj+xoW8dGyqz/jfX+v3I6Qm40HALbaFkrdn9fU2F1uMGqCwIO3a+lmz5uOrczvTE3fdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CmpMHI12; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CmpMHI12"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2212222d4cdso1865ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Feb 2025 09:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740418589; x=1741023389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxZlE/YI+vRolUX5oKdR9nGssrVloDwZPWSqxE2sgPQ=;
        b=CmpMHI122302HWElJvYJUs8qltuD2cH0jTG0V+8mhdhJIVv8EE+P01CjKbn3vmlrDX
         WDgTuwpJF7e5pZYJw+sTRa0Ian0DdWxUf9CrVPAs35xXu/ogV+69N6LLltLhDU5qlVvw
         bnkEhEVna0Uh6T5o8XEXTQIE1CiwTkZNAE6BYzVGSFXN1/C1VCmLeOCkZmdPG+tts6SP
         h2V2EKfqv0Vo8uEVYhMmwlAM1pctU6ezGwcW4ysosFqak11+dVjU7ANMbojbglLdq71a
         U/38ooptER8i6ccoKPA1aAM/hNoa0+goPSSUin2HpxwOW3pbRK1VDH+j0UYWT9O8dcmx
         m3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740418589; x=1741023389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxZlE/YI+vRolUX5oKdR9nGssrVloDwZPWSqxE2sgPQ=;
        b=QCFEvdpBl8utItHI/MeiD5414x82/xdxKb3UePgl8IJN8AcAMIq4KtX7ZxKLatmAIf
         yzGTivbk1kZC8NBSLxMdMqMAkZPS24+DmKhelk0hWRWbTl6YmPY27A523ZZDMzJ7FXbz
         408MSKcXUH4Y9YOje/IWmnkBHnH0REFWMpM47+L01eLWig40SfpVZGRphVq0MvSisNop
         vGSCo3LPZMxBEDVYjHy5uIxuzHkllbTHBod8EnlTXqyz6M4iJuulPYcqxyj3RHx3LVce
         qFyQD8PUQRjnhFVVtQtE9w9XOIvYa7cMfVJ4ON23yAbS7Q1S2ypnrtswDQ12iL+DK3Bg
         jk3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEcBALH44MUh1OoSv2XErSFcY2OxqPlr3Q3eXLL4wI76RyB/n1HJ937Rw5teoKmyafycMQTeKoRJthKb2DDOZA@vger.kernel.org
X-Gm-Message-State: AOJu0YyX62HjFWliu9vkTqRNbxnZri+Ye/7WGVN33S0i+EyqzP5t+jCH
	i6Rc9suXF5iDlOgXc7euLSwKc2kO7tDbkfHLHY6VmcBNkabxdxugAGXYZyhaVhC8JrCV75g96l+
	cp6zxbQqHKlqLu0et5mu3zF/QWZTbbOHAIR+p
X-Gm-Gg: ASbGnct1/s1WG+fvj39PSHfkPeON/AN0unLahTXy/cUZ0H7xB1acfMIOl09dE8i0UxX
	MJC/ns6fYGgxXgzohSbKRjcZ7Nu7PiVZ7qnYYOMNAEKJh7rtZjBHflhqoK6mpfefXrTRIjGiIqq
	f7fs8Rz6xty8XTZyAAPd4I4Xp/NJjv2XcIQpM=
X-Google-Smtp-Source: AGHT+IGUTyWjjj22xVOdOEvpHkyAv9set4OxYCdGxHJL2I9HOBZfXXLH0de/hvF+iOiszaBWVeAwpO0VoB2Ek5u76/w=
X-Received: by 2002:a17:903:32c8:b0:21f:3f5c:d24c with SMTP id
 d9443c01a7336-22307990990mr193055ad.0.1740418588277; Mon, 24 Feb 2025
 09:36:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z7Z5kv75BMML2A1q@google.com> <CAP-5=fVbti6efu6uA9a5os6xhnTuJ0egyesZsy0dmkiScwYFqQ@mail.gmail.com>
 <Z7yJ0Vpub6JeQyYo@x1>
In-Reply-To: <Z7yJ0Vpub6JeQyYo@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 24 Feb 2025 09:36:16 -0800
X-Gm-Features: AWEUYZkJuYam5g1aZSeG_i3MG6Pzg_PC07nNNcZKitCFuueo0qbW_XcvG6ebrfY
Message-ID: <CAP-5=fXSgpZaAgickZSWgjt-2iTWK7FFZc65_HG3QhrTg1mtBw@mail.gmail.com>
Subject: Re: [RFC] perf tools: About encodings of legacy event names
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 7:01=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Feb 19, 2025 at 10:37:33PM -0800, Ian Rogers wrote:
> > On Wed, Feb 19, 2025 at 4:38=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > > Ian and I have been discussing the behaviors of event encodings and i=
t's
> > > hard to find a point so far that we can agree on.  So I'd like to hea=
r
> > > your opinion to resolve this.  If you happen to have some time, you c=
an
> > > follow the thread here:
>
> > > https://lore.kernel.org/linux-perf-users/20250109222109.567031-5-irog=
ers@google.com/#r
>
> > > Basically there are some events that were defined in the perf ABI.
>
> > >   PERF_COUNT_HW_CPU_CYCLES, PERF_COUNT_HW_INSTRUCTIONS, ...
>
> > > So perf tools use those (legacy) encodings with the matching names li=
ke
> > > "cycles" (or "cpu-cycles"), "instructions", etc.
>
> > > On the another hand, it has wildcard matching for event names in PMUs=
 so
> > > that users can conveniently use events without specifying PMU names.
> > > For example, "event1" would expand to "pmuX/event1/", "pmuY/event1/",=
 etc
> > > as long as the PMUs have the event in sysfs or JSON.
>
> > > And there are platforms where "cycles" event is defined in a (core) P=
MU
> > > (like "blah/cycles") and the event has a different behavior than the
> > > legacy encoding.  Then it has to choose which encoding is better for =
the
> > > given name.  But it's a general issue for the legacy event names.
>
> So we pick the "legacy" one, as always, and the one that is in a PMU
> needs to have its pmu name specified, no?
>
> > >   Q. what should it do with "cycles"?
> > >   -----------------------------------
> > >   1. just use the legacy encoding (PERF_COUNT_HW_CPU_CYCLES).
>
> Right
>
> > >   2. expand to (possibly multiple) PMU events (like "cpu/cycles/") an=
d
> > >      use the encoding defined there.
>
> Nope
>
> > > I think the #1 is the current behavior.  The upside is it's simple an=
d
> > > intuitive.  But it's different than other names and can make confusio=
n.
> > > Users should use the full name ("cpu/cycles/") if they need sysfs one=
.
>
> Right
>
> > So the code keeps changing, for example, the removal of BPF events. I
>
> Humm, this seems like a different discussion.
>
> > think the important change and the thing that has brought us here is
> > the addition of what Intel call hybrid and ARM call BIG.little. ARM
>
> Right, the support for hybrid systems brought lots of problems, most
> people didn't have access to such systems and thus couldn't test
> patches, so the attempt was to keep the existing code working as it had
> been while allowing for the support for the new hybrid systems.
>
> As more people get access to hybrid systems we started noticing problems
> and working on fixing it, you did a lot of work in this area, highly
> appreciated.
>
> > have got architectural events and so the same event encoding on BIG
> > and little cores. On x86 the e-core (atom) and p-cores have different
> > event encodings. In the original hybrid work, pushed on for the launch
> > of Alderlake and reviewed by Jiri and Arnaldo with no involvement from
> > me, Intel wanted the event names to work transparently. So a cycles
>
> Without access to such systems, yes, see above.
>
> > event would be gathered on the e-core and p-core with a command line
> > option to merge the legacy event cycles on both cores. To be specific
> > the expected behavior of:
> > $ perf (stat|record) -e cycles ...
> > would be as if:
> > $ perf (stat|record) -e cpu_atom/cycles/,cpu_core/cycles/ ...
>
> Yes, and if somebody wants to profile in just one of those core types,
> just specify the "cpu_atom" or "cpu_core" to have it fully specified.
>
> > An unfortunate thing in the hybrid code was that it was hardcoded to
> > PMU names of cpu_atom and cpu_core, but what to do for metrics? The
>
> Yeah, metrics IIRC came before hybrid systems.
>
> > original proposal was that metrics would have a PMU name and all names
> > would be relative to that, but what about uncore events? What about
> > metrics that refer to other metrics? A decision was made to not to
> > have PMUs implicitly in metrics and the events in the metric would
> > match those given to perf's -e command line. This also greatly
> > simplifies testing events when creating a metric.
>
> > I set about rewriting the hybrid code not to use hard coded PMU names
> > but to discover core PMUs at runtime. This was to make the metric and
> > event parsing code as generic as possible, but this had an unintended
> > consequence. ARM's core PMU had previously not been seen as handling
> > legacy events like cycles, and appeared as an uncore PMU. When there
>
> > are both legacy and sysfs/json events then previously the legacy
> > events had priority. This broke events like cycles on Apple M
> > processors where the legacy events were broken and the sysfs ones not.
> > Yes this is a driver bug, but everybody told me a change in behavior
> > of the tool was needed to fix it, that fix was to make sysfs/json
> > events have priority over legacy events. I prioritized fixing event
> > parsing when a PMU was specified but given "cycles" means
> > "cpu_atom/cycles/ and cpu_core/cycles/" for hybrid, why would the
> > prioritization be different without a PMU specified?
>
> > I knew of this tech debt and separately RISC-V was also interested to
> > have sysfs/json be the priority so that the legacy to config encoding
> > could exist more in the perf tool than the PMU driver. I'm a SIG
>
> I saw them saying that supporting PERF_TYPE_HARDWARE counters was ok as
> they didn't want to break the perf tooling workflow, no?

No. The request has always been that they don't want the PMU driver to
do the PERF_TYPE_HARDWARE/PERF_COUNT_HW_* to PMU/config=3D??? mapping
given the diversity of hardware and to keep the PMU driver simple.
Here is Atish's feedback:
https://lore.kernel.org/lkml/CAHBxVyH1q5CRW3emWTZu1oLZEfTWWVRH6B0OVggFxt-0N=
RzvwQ@mail.gmail.com/
"""
If the overriding legacy with JSON is available, each future vendor
may just provide the json file instead of modifying the driver.
"""
Because of the pain in landing the reverted patch then RISC-V has had
to work with perf's behavior as it is, they need to ship products. I
think things would have been simpler in their driver and the wider
ecosystem if this hadn't been forced to happen.

> > vice-chair for RISC-V and hope to push things forward for RISC-V when
> > I can. Given that ARM had originally required the prioritization,
> > Intel signed off on this (with a huge number of Intel test
> > expectations updated as a consequence), RISC-V desiring consistency I
> > thought there was a pretty broad consensus to move forward with having
> > the same prioritization of legacy and sysfs/json events for event
> > names without PMUs as those with it.
>
> > In doing this change I made:
> > $ perf (stat|record) -e cycles ...
> > behave like:
> > $ perf (stat|record) -e */cycles/ ...
> > This is the behavior with sysfs/json events (ie not legacy). For exampl=
e:
> > $ perf (stat|record) -e inst_retired.any ...
> > in the event parsing code behaves like:
> > $ perf (stat|record) -e */inst_retired.any/ ...
> > That is every PMU advertising the event inst_retired.any (in the sysfs
> > events directory or in json) will have it opened by the tool.
>
> > My intent was that "cycles" behaving like "*/cycles/" was that it
> > would match the change already done for hybrid of "cycles" behaving
> > like "cpu_atom/cycles/,cpu_core/cycles/". However, this change caused
> > an issue on ARM Neoverse that Linus couldn't tolerate and so reverted
> > the change. Specifically ARM Neoverse's L3 cache PMU advertises a
> > "cycles" event and such an event will fail to open with perf record.
>
> > Specifying the PMU with the event avoids the wild card behavior and
> > fixes the issue but it was put over strongly that "cycles" without a
> > PMU should only ever mean CPU cycles. This missed hybrid/BIG.little
> > type systems, but one could imagine in that case CPU means all core
> > PMUs.
>
> > As with not wanting hybrid PMU names hard coded, I dislike special
> > cases for events. Not least as there are an exciting plethora of
>
> Ok, but the desire for consistency clashes with how things have been for
> a long time, tools expect, scripts, etc, so we seem to need the special
> case for what has been called in these threads "legacy events".

There is only one known issue of a problem for 1 event on 1 ARM model.
If ARM renamed the event this wouldn't be an issue. The patch series
works for this event but warns about it if you try to use it with perf
record.

> > legacy names inside the perf tool particularly for legacy cache
> > events. Similarly ARM core PMUs will advertise a "cpu_cycles" event,
> > while "cycles" and "cpu-cycles" are both legacy names. It seems less
> > than obvious that using a hyphen or an underscore would change the PMU
> > wildcard behavior of an event name. That is the legacy "cpu-cycles"
> > event would wild card only with core PMUs while sysfs "cpu_cycles"
> > event would wild card with all PMUs.
>
> > Anyway, the proposals to move forward on this were:
>
> > 1) from me, ARM should rename their cycles event on their L3 cache
> > PMU. They have a bus_cycles event on this PMU and so cpu_cycles would
> > seem like a less ambiguous name. Leo wasn't keen on this in case it
> > broke something depending on the event name. We've recently been
> > talking of renaming swathes of ARM's PMUs, and moving things around in
> > sysfs, so I don't feel renaming 1 event is massive but I feel such a
> > change should be coming from ARM.
>
>
> > 2) from Arnaldo, with perf record make it so that when events fail to
> > open it is just warned about. This has been added to the patch series.
>
> In verbose mode, IIRC. If the user wants some "cycles" event and it is
> not included in the tool output then, as with other cases, using -v to
> see if some extra debug message can clarify seems the usual workflow.

So this has never made sense to me. To be specific, if I do:
$ perf record -e data_read -a true
then data_read is an uncore_imc_free_running event that doesn't
support sampling. With the change you say then rather than a warning
and failure, as currently happens, you are proposing that the command
exits and doesn't warn. This is an extension of the only warn if
verbose and ignore failing cycles event you mention. The problem is
that there are scripts that look for the failure message, I think it
is also surprising for users.

Why do I know scripts check the output? perf's own tests started
breaking because we weren't exiting when events failed to open. We
routinely grep the perf output in those tests, I'm not aware of a
specific case with perf record but given we do it with perf stat, then
it doesn't seem unreasonable. For example, looking for "Access to
performance monitoring and observability operations is limited." in
the perf stat warning output:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/shell/stat_all_pmu.sh?h=3Dperf-tools-next#n31
but I mean it is routine as we rely on values like "<not supported>"
being in the output, although I'd say more tests infer this from the
exit code of the perf command being tested. Fwiw, it is common in
Google's testing to not just expect an exit code but also a specific
error message.

> > It turns out that if no events open it breaks perf's own tests so the
> > patch series warns when events fail to open and fails if the eventual
> > evlist is empty or only contains dummy events.
>
> Do you have a link to this thread?

It is in the cover letter:
```
v4: Rework the no events opening change from v3 to make it handle
    multiple dummy events. Sadly an evlist isn't empty if it just
    contains dummy events as the dummy event may be used with "perf
    record -e dummy .." as a way to determine whether permission
    issues exist. Other software events like cpu-clock would suffice
    for this, but the using dummy genie has left the bottle.

    Another problem is that we appear to have an excessive number of
    dummy events added, for example, we can likely avoid a dummy event
    and add sideband data to the original event. For auxtrace more
    dummy events may be opened too. Anyway, this has led to the
    approach taken in patch 3 where the number of dummy parsed events
    is computed. If the number of removed/failing-to-open non-dummy
    events matches the number of non-dummy events then we want to
    fail, but only if there are no parsed dummy events or if there was
    one then it must have opened. The math here is hard to read, but
    passes my manual testing.
```
James reported the issue:
https://lore.kernel.org/lkml/823e66dc-9ff4-4168-be54-2e800aef0b28@linaro.or=
g/
There was a discussion on the implementation here:
https://lore.kernel.org/lkml/20250107180854.770470-4-irogers@google.com/

> > 3) my interpretation of what Linus and Namhyung are asking for, make
> > certain events special so "cycles" only ever means the cycles on core
> > PMUs. The definition of special seems to be that all legacy names are
> > special, although Linus never explicitly said this he just mentioned
>
> I think that is fair to say, to try and make the events that most people
> use as they worked in the past, i.e. no surprise for people not
> interested in metrics, hybrid systems, and lots of other features in
> perf that most people seldomly, if at all, use.

I think this is what the series achieves:
1) encoding is consistent cycles =3D=3D cpu/cycles/ - which I think has to
be a goal for basic sanity;
2) the wildcard matching is consistent cpu_cycles will match on every
PMU, cpu-cycles will match on every PMU, the behavior of hybrid is
consistent with uncore, etc.;
3) "most people" is open to interpretation, I think this series fixes
problems making "most people" happier. Specifically:
3.1) fixes a latent bug on ARM Apple-M CPUs due to broken legacy
mappings, the whole reason the priority was flipped due to a broken
PMU,
3.2) addresses RISC-V's issues,
3.3) allows ARM's neoverse not to fail for `perf record -e cycles ...`
but warns about the PMU event inconsistency.
The series also continues the push to make perf generic, avoid having
special "hey if it is this do magic" type things,  and so on.

The problem with "no surprise" was that we've moved past a world of
just 1 core PMU. A decision was made to make legacy events wildcard,
and without my input Jiri Olsa and yourself reviewed and merged those
changes. Fixing those changes to not be hardcoded to cpu_atom/cpu_core
(arguably something that should never have been allowed to be merged
in the 1st place given its obviously non-generic nature) broke ARM
Apple-M and we made legacy events lower priority than sysfs/json to
fix this as multiple people strongly requested (their proposal was
just to revert 6 or more Linux releases worth of perf tool changes
including adding Intel topdown metric support that I'd written). The
move away from just a core PMU will continue as systems have greater
heterogeneity and you are likely already spending more money on
accelerators like GPUs than on your core PMU - something I keep
pushing the perf tool to support, for example with hwmon and drm
PMUs/events. Even 15 years ago this trend was clear.

I think making it so that events fail to open and requiring a "-v"
flag is surprising - "-v" is far too spammy for regular users. I think
the perf_event_attr encoding of cpu-cycles not matching
cpu/cpu-cycles/ is surprising. I think inst_retired.any matching
events on all PMUs, but cycles only matching core PMUs (how should a
user even know what these are?) is surprising.

The series is trying to make "most people" happy with "no surprise"
for them unless their hardware vendor happens to name an event on an
uncore PMU to match a legacy event - there is only 1 known instance of
this. There is a 4 character fix for that, specifically the cycles
event should be "cpu_cycles" for consistency with the "bus_cycles"
event, as cycles could imply either. The line of code where this 4
character change is necessary is here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/perf/arm_dsu_pmu.c#n177
Given we live in a world where ARM PMU names mean we don't see core
PMUs in perf list (very surprising behavior imo) the work to fix that
will be a lot more invasive than a 1 event name change on an uncore
PMU.

Thanks,
Ian

> - Arnaldo
>
> > cycles - in fact I pushed him on what he meant and he responded by
> > blocking my email. This is a change in the wild carding behavior of
> > the event lookup, but Namhyung has also said that without a PMU the
> > legacy event encodings should be used. An issue here is that we wanted
> > to avoid legacy encodings as they previously broke Apple M, another
> > issue is that RISC-V want to avoid legacy encodings so that the
> > mappings can live in the perf tool.
>
> > > The #2 can make the parsing code simpler and the behavior consistent.
> > > Also it can override the (possibly broken) behavior of the legacy eve=
nt
> > > on some platforms.  No way (and reason?) to use the legacy encodings.
>
> > > Also Ian says `perf list` shows "cpu-cycles" and "cpu/cpu-cycles/"
> > > together which assumes they are the same.  But using #1 can result in=
 a
> > > different behavior respectively.  Probably better to make it consiste=
nt.
>
> > I could note that previously the event parsing and event printing code
> > lived in the same file. It is odd to me that "cpu-cycles" should mean
> > legacy and "cpu/cpu-cycles/" (that has a sysfs event on Intel) uses
> > the sysfs/json encoding. A separate change I'm working on is making it
> > so that tracepoints can appear in metrics. Currently the colon in a
> > tracepoint is treated as an event modifier in the metrics code thereby
> > breaking the events. Rather than re-invent modifier parsing for events
> > in metrics it seems to make sense to just parse events individually.
> > It would make sense that the logic in metrics to deduplicate events in
> > metrics like:
> > "MetricName": "cache_hit_percent",
> > "MetricExpr": "100 * cache_hits/(cache_hits + cache_misses)",
> > where the cache_hits event is duplicated, would work off of the
> > perf_event_attr rather than the event name as currently happens. Using
> > different encodings would defeat this - although you are unlikely to
> > use different event names within the same metric, we do try to
> > optimize and share metric formulas as much as possible. I think across
> > perf's history the PMU has been treated as an optional prefix meaning
> > (1) wild carding is normally expected and (2) event encodings
> > shouldn't vary because of how the wild carding happens (the optional
> > thing would be a required thing if it changes behavior, for example on
> > Apple M CPUs to work around the PMU driver issue).
> >
> > > I tried to summarize the issues concisely but may miss some issues.  =
I
> > > hope Ian can fill it up in case I missed something important.
> > >
> > > Can you please share your opinion about what would be the best behavi=
or?
> >
> > I'd very much appreciate guidance. This issue matters to me for
> > consistency, cleanliness, tech debt,.. but is strategic for RISC-V.
> > The series Namhyung linked to has the tags:
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > Tested-by: James Clark <james.clark@linaro.org>
> > Tested-by: Leo Yan <leo.yan@arm.com>
> > Tested-by: Atish Patra <atishp@rivosinc.com>
> > It is reapplying a patch that lived on linux-next for weeks/months and
> > that should presumably mean that PowerPC and S390 are happy with it,
> > as they are very good at reporting issues when things have gone awry.
> > It carries a patch implementing Arnaldo's suggestion to make perf
> > record failing to open a warning rather than fatal. It is unusual that
> > patches in the perf tool have this level of review and this high
> > number of tags.
> >
> > Thanks,
> > Ian
