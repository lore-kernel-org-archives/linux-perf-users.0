Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1461F941
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Feb 2025 23:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439701; cv=none; b=dPNgavU3MBMubSJzb6By5FZgfQK3h/Hv/rEjBV1ORyS1QOD4mLxnZTiq9Ww46hDyXwUB1MEw8CoFHhoMuIHUln1Ni22SHhplHMczxIh/aacM7SsCzbXY5sHC0dt65Kb/rr4oPWL/HNNoLtUCld/J8stHA0VI+aALLcl6ygqXKv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439701; c=relaxed/simple;
	bh=UDMiYbz4qQW9GEbcj0+ab6zhftwWPuae/OoFs6VwfSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5WIfH+ehRacAYBGmXxmjQ0KniBZT5oH7ol8tuwynUPPZcifOfrxDwDJ99A6lAsy2St8wPwl3wbi6QBlgqJNloyjLDxpp/9DC6jt145eM9aXLj3G2nk0ivK4S1NC9XIZaLeP5FV+lAYSzLrC4LQQsnxuYtW88pAUv5rRRTqeOfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dYf2EicW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dYf2EicW"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22117c396baso31335ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Feb 2025 15:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740439699; x=1741044499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqtlSo3+RM2vEBk3JOvQebOKTpRgBDM2rBr6SGwN0cc=;
        b=dYf2EicW6VutOrCZRpywBPbb1uSYr3wxxToo5AB9AH9jS3/PpwTzUoKcyGUDDV+MQm
         gwMIuU1MMDE57iGvTLg8r+9uqnZ/tXITH/8FARoU+R38ib9i0UpaBK/L3dqtiyj4jgNQ
         nhfTJv3lmhXuumPTnqyzNWmlTvIeV2DacFakRXoE/2e8ShsPJoPDAqw4q85zu7RtRF6O
         nmSp+sGBaJqxxMpGUmVnSQFzL/BO5xcNiD62kLv3VewFc0dZV2a1GRCCIEeZfFVzxRy3
         XkwjMurqtJcRNZ+eewANmu1Fz3Q9mc9kxQzsg1DG9ENF2g2WHlqX0/jx4BEKUIU4g1Ej
         zQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740439699; x=1741044499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqtlSo3+RM2vEBk3JOvQebOKTpRgBDM2rBr6SGwN0cc=;
        b=rYdh0B1IXDmar8cK4ARK9gOikw81gyuBqVZ055PwCFhROnIx4Tly+gWDGAqvCcKdBE
         5VFs8zJsd6IfnZq+mFDXKapAPauuvZrDL7pAjdCpg08+yqfidJwG/gPSjI3hipk/ZHrY
         Ur5VmULVyyunA+fiFnzS9S4gPGgE9bHNYVtmvuITOJjuL2R6EqnXaicsTbgP/QGabaze
         teYIXo4A/2NOQWYyJXPaDaJs6hAPjh0sXOyVugLBUVpxKw9ChPuiAurbWS37fvRJVOtS
         /EdCwz6++NcAbJ6HKhgdyknsfjtwcPNXSGcLEO07FaGb4dOD6ZPCx6S67jdwSWB6wFuN
         qBZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe93K+jND7p0E6CXHLi8HoHuyFYbhNqwQjDMve/tjkbZ5+zDEMAWnNUGd+CZj06n12Dh2QfVUCQo+dldiUJj++@vger.kernel.org
X-Gm-Message-State: AOJu0YwiXfzn+eYdKnCTn73joO4/yCHLObQTp4055TY9mOGXkFaBHblo
	L8wiWGLLdnxz5n0s10Ii6ctizhxiRnjr/XmP6SXcG3BMktMACY3Y2ix8qvggu0ilhfR1/4OJRE4
	qWRU2YSGc2SyCPkWlHEa855svQLFbfeeelaun
X-Gm-Gg: ASbGncul8IdPuccRdXgymYGC0okR6tMHysr3+ztemCj5BJktcSPVhrRjY687HdUQhNt
	VF0ii4ANOKc8PDXzTXXgiyduDqWaWbotKLxxhnxXFRaFfhbiIBT/qnVDKTNmL0nr3yRYSEV4kLs
	hbcJucUQ06nO0UOmQPYh6N5Vz1xq/+In3c
X-Google-Smtp-Source: AGHT+IGhOVgZj8JBCkZvntzKtpLpEOd5r8cse93N8V1vb/etSzYfbb91Ox/MM0wFE3fH3JXO5h7ett4XqqnNUFDejc0=
X-Received: by 2002:a17:902:c402:b0:216:5e53:d055 with SMTP id
 d9443c01a7336-22307a3f2d4mr1411405ad.9.1740439698469; Mon, 24 Feb 2025
 15:28:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z7Z5kv75BMML2A1q@google.com> <CAP-5=fVbti6efu6uA9a5os6xhnTuJ0egyesZsy0dmkiScwYFqQ@mail.gmail.com>
 <Z7yJ0Vpub6JeQyYo@x1> <CAP-5=fXSgpZaAgickZSWgjt-2iTWK7FFZc65_HG3QhrTg1mtBw@mail.gmail.com>
 <Z7zVzKbQIdB6-bFn@x1> <CAP-5=fU3YSCiHygnOt6MN7i2mJBOwm202tXSefBHaPR3JmptkA@mail.gmail.com>
In-Reply-To: <CAP-5=fU3YSCiHygnOt6MN7i2mJBOwm202tXSefBHaPR3JmptkA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 24 Feb 2025 15:28:07 -0800
X-Gm-Features: AWEUYZnUqeiKDpZwXpFyPObmrQolRNhx_ADtoUPNTreye08noZjHU-gzVDZnswM
Message-ID: <CAP-5=fX+8rGtq4w6gaH7SMsYEwgJ0xbsmR48BF3g=vQtRu0aRg@mail.gmail.com>
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

On Mon, Feb 24, 2025 at 1:34=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Feb 24, 2025 at 12:25=E2=80=AFPM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Mon, Feb 24, 2025 at 09:36:16AM -0800, Ian Rogers wrote:
> > > On Mon, Feb 24, 2025 at 7:01=E2=80=AFAM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Wed, Feb 19, 2025 at 10:37:33PM -0800, Ian Rogers wrote:
> > > > > On Wed, Feb 19, 2025 at 4:38=E2=80=AFPM Namhyung Kim <namhyung@ke=
rnel.org> wrote:
> > > > > > Ian and I have been discussing the behaviors of event encodings=
 and it's
> > > > > > hard to find a point so far that we can agree on.  So I'd like =
to hear
> > > > > > your opinion to resolve this.  If you happen to have some time,=
 you can
> > > > > > follow the thread here:
> > > >
> > > > > > https://lore.kernel.org/linux-perf-users/20250109222109.567031-=
5-irogers@google.com/#r
> > > >
> > > > > > Basically there are some events that were defined in the perf A=
BI.
> > > >
> > > > > >   PERF_COUNT_HW_CPU_CYCLES, PERF_COUNT_HW_INSTRUCTIONS, ...
> > > >
> > > > > > So perf tools use those (legacy) encodings with the matching na=
mes like
> > > > > > "cycles" (or "cpu-cycles"), "instructions", etc.
> > > >
> > > > > > On the another hand, it has wildcard matching for event names i=
n PMUs so
> > > > > > that users can conveniently use events without specifying PMU n=
ames.
> > > > > > For example, "event1" would expand to "pmuX/event1/", "pmuY/eve=
nt1/", etc
> > > > > > as long as the PMUs have the event in sysfs or JSON.
> > > >
> > > > > > And there are platforms where "cycles" event is defined in a (c=
ore) PMU
> > > > > > (like "blah/cycles") and the event has a different behavior tha=
n the
> > > > > > legacy encoding.  Then it has to choose which encoding is bette=
r for the
> > > > > > given name.  But it's a general issue for the legacy event name=
s.
> > > >
> > > > So we pick the "legacy" one, as always, and the one that is in a PM=
U
> > > > needs to have its pmu name specified, no?
> > > >
> > > > > >   Q. what should it do with "cycles"?
> > > > > >   -----------------------------------
> > > > > >   1. just use the legacy encoding (PERF_COUNT_HW_CPU_CYCLES).
> > > >
> > > > Right
> > > >
> > > > > >   2. expand to (possibly multiple) PMU events (like "cpu/cycles=
/") and
> > > > > >      use the encoding defined there.
> > > >
> > > > Nope
> > > >
> > > > > > I think the #1 is the current behavior.  The upside is it's sim=
ple and
> > > > > > intuitive.  But it's different than other names and can make co=
nfusion.
> > > > > > Users should use the full name ("cpu/cycles/") if they need sys=
fs one.
> > > >
> > > > Right
> > > >
> > > > > So the code keeps changing, for example, the removal of BPF event=
s. I
> > > >
> > > > Humm, this seems like a different discussion.
> > > >
> > > > > think the important change and the thing that has brought us here=
 is
> > > > > the addition of what Intel call hybrid and ARM call BIG.little. A=
RM
> > > >
> > > > Right, the support for hybrid systems brought lots of problems, mos=
t
> > > > people didn't have access to such systems and thus couldn't test
> > > > patches, so the attempt was to keep the existing code working as it=
 had
> > > > been while allowing for the support for the new hybrid systems.
> > > >
> > > > As more people get access to hybrid systems we started noticing pro=
blems
> > > > and working on fixing it, you did a lot of work in this area, highl=
y
> > > > appreciated.
> > > >
> > > > > have got architectural events and so the same event encoding on B=
IG
> > > > > and little cores. On x86 the e-core (atom) and p-cores have diffe=
rent
> > > > > event encodings. In the original hybrid work, pushed on for the l=
aunch
> > > > > of Alderlake and reviewed by Jiri and Arnaldo with no involvement=
 from
> > > > > me, Intel wanted the event names to work transparently. So a cycl=
es
> > > >
> > > > Without access to such systems, yes, see above.
> > > >
> > > > > event would be gathered on the e-core and p-core with a command l=
ine
> > > > > option to merge the legacy event cycles on both cores. To be spec=
ific
> > > > > the expected behavior of:
> > > > > $ perf (stat|record) -e cycles ...
> > > > > would be as if:
> > > > > $ perf (stat|record) -e cpu_atom/cycles/,cpu_core/cycles/ ...
> > > >
> > > > Yes, and if somebody wants to profile in just one of those core typ=
es,
> > > > just specify the "cpu_atom" or "cpu_core" to have it fully specifie=
d.
> > > >
> > > > > An unfortunate thing in the hybrid code was that it was hardcoded=
 to
> > > > > PMU names of cpu_atom and cpu_core, but what to do for metrics? T=
he
> > > >
> > > > Yeah, metrics IIRC came before hybrid systems.
> > > >
> > > > > original proposal was that metrics would have a PMU name and all =
names
> > > > > would be relative to that, but what about uncore events? What abo=
ut
> > > > > metrics that refer to other metrics? A decision was made to not t=
o
> > > > > have PMUs implicitly in metrics and the events in the metric woul=
d
> > > > > match those given to perf's -e command line. This also greatly
> > > > > simplifies testing events when creating a metric.
> > > >
> > > > > I set about rewriting the hybrid code not to use hard coded PMU n=
ames
> > > > > but to discover core PMUs at runtime. This was to make the metric=
 and
> > > > > event parsing code as generic as possible, but this had an uninte=
nded
> > > > > consequence. ARM's core PMU had previously not been seen as handl=
ing
> > > > > legacy events like cycles, and appeared as an uncore PMU. When th=
ere
> > > >
> > > > > are both legacy and sysfs/json events then previously the legacy
> > > > > events had priority. This broke events like cycles on Apple M
> > > > > processors where the legacy events were broken and the sysfs ones=
 not.
> > > > > Yes this is a driver bug, but everybody told me a change in behav=
ior
> > > > > of the tool was needed to fix it, that fix was to make sysfs/json
> > > > > events have priority over legacy events. I prioritized fixing eve=
nt
> > > > > parsing when a PMU was specified but given "cycles" means
> > > > > "cpu_atom/cycles/ and cpu_core/cycles/" for hybrid, why would the
> > > > > prioritization be different without a PMU specified?
> > > >
> > > > > I knew of this tech debt and separately RISC-V was also intereste=
d to
> > > > > have sysfs/json be the priority so that the legacy to config enco=
ding
> > > > > could exist more in the perf tool than the PMU driver. I'm a SIG
> > > >
> > > > I saw them saying that supporting PERF_TYPE_HARDWARE counters was o=
k as
> > > > they didn't want to break the perf tooling workflow, no?
> > >
> > > No. The request has always been that they don't want the PMU driver t=
o
> > > do the PERF_TYPE_HARDWARE/PERF_COUNT_HW_* to PMU/config=3D??? mapping
> > > given the diversity of hardware and to keep the PMU driver simple.
> > > Here is Atish's feedback:
> > > https://lore.kernel.org/lkml/CAHBxVyH1q5CRW3emWTZu1oLZEfTWWVRH6B0OVgg=
Fxt-0NRzvwQ@mail.gmail.com/
> > > """
> > > If the overriding legacy with JSON is available, each future vendor
> > > may just provide the json file instead of modifying the driver.
> > > """
> >
> > So, making users to figure out what is the best event to use for some
> > specific processor was one of the major reasons for perf to come about,
> > otherwise we would still be stuck with oprofile.
>
> Tbh, I think OProfile's major issue was a lack of active development.
> There were arguments that perf was going to be more integrated into
> the kernel, but there are no arch events, for example, in
> arch/arm64/events. Perf provided new energy for something started as a
> student project, it was and is good for having done that.
>
> > While it is clear that picking some "most important event and ratios of
> > events" is super difficult, that was one of the ideas that made perf to
> > come about.
> >
> > I wasn=C2=B4t the architect of this, Ingo and Thomas were, with Peter t=
hen
> > tryhing to make the kernel part sane.
> >
> > I just tried to follow those principles while not getting in the way of
> > people wanting to have a common ground for observability in Linux.
> >
> > Having all these JSON tables was in place was a major concession to tha=
t
> > original vision.

Fwiw, I believe the original vision was seen as being flawed - at
least that's what's come up in discussions I've had and Google has a
policy to avoid legacy events. Specifically, a legacy event like
instructions or branch-misses what could go wrong? Well does the
instructions count contain speculatively executed instructions or not?
Similarly for branch-misses. Cache misses, can they be speculative or
not? The idea that there can be a counter and it gives just one value
across vendors and models just doesn't exist in practice. On ARM in
their json you'll see INST_RETIRED and INST_SPEC to deal with this,
the exact behavior of the event can be seen in its description. What
about the legacy instructions event? Well there's no description but
it happens that it is mapped onto the retired instruction count, as it
is for Intel. So the PMUs are trying for some consistency but you are
crossing your fingers. If a PMU lacked a retired instruction count
then why not use the speculative instruction count?

If you look at the events for perf stat -ddd, on the well supported
Intel (Skylake) and AMD (Turin):
Supported on both:
instructions, cycles, branches, branch-misses, L1-dcache-loads,
L1-dcache-load-misses, L1-icache-load-misses, dTLB-loads,
dTLB-load-misses, iTLB-loads, iTLB-load-misses.
Supported only on Intel:
LLC-loads, LLC-load-misses - presumably LLC means L2, so the event
name is misleading
Supported only on AMD:
stalled-cycles-frontend, stalled-cycles-backed, L1-icache-loads,
L1-dcache-prefetches
Supported on neither:
L1-dcache-prefetch-misses

For metrics we added the "Default" metric group to deal with this
diversity. I think "Default" also makes sense for events as:
1) it is more intention revealing to have a json event with a
description rather than legacy event,
2) we can avoid events like branches and branch-misses that cause
multiplexing on Intel p-cores when gathered with TopdownL1  (another
surprise is this combination hides the multiplexing percentages),
3) legacy events just don't really make sense when we're asking for
something (by default) like L1-dcache-prefetch-misses and no PMUs
support it,
4) we can optionally set precision on events. People seem to be wildly
ignorant of what precision architectures support, such as Linus
copying cycles:ppp from Intel to ARM and expecting the ppps to
actually mean something. Arguably it would be a service if perf failed
if a precision greater than the PMU's max_precise is given - that's
not practical given how precision works for AMD.

Anyway, the idea that legacy events should make a comeback, this is
best achieved, as ARM do, by having standard json events with standard
names. Losing descriptions and adding ambiguity with kernel tables is
a step backward imo.

Thanks,
Ian

> > Changing things as we go, with all these changes in the hardware
> > landscape, some fleeting, some reinforced, is super difficult and leads
> > to all this pain in trying to provide a sane experience to people using
> > these tools.
> >
> > I don't think we can have it super consistent.
> >
> > It is super useful as is, or at least that what people say.
> >
> > So we need to keep on improving it while not telling people used to its
> > workflows that they should re-learn the tool because at some point a
> > decision was not properly made.
>
> So yes, but no. If you are used to perf on a pentium core 2 and then
> move to a hybrid alderlake system there has to be some notion of what
> cycles means on each core type. We had to change the tool to support
> this. ARM dealt with this long before Intel hybrid ever did, but they
> did so with no legacy event support just sysfs/json. Of course the
> wildcard behavior means that all the PMUs that supply an event will
> have it selected and people have been happy with this a long time.
> We used to have BPF events but no longer. It seemed like a fruitful
> thing, it became obsolete and was removed.
> We have legacy encodings where LLC means L2:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
tree/tools/perf/util/evsel.c?h=3Dperf-tools-next#n801
> Fine at the time, now seems silly. LLC seems like a reasonable PMU
> name, but event parsing will trip over it in the clumsy way it does
> with raw events and "read" (raw event of 0xEAD). Event parsing used to
> broken for events like "llc-llc" now you can have that as an event
> now.
>
> Anyway, I dislike that you are arguing that I am trying to tell people
> to change their way of using the tool, it implies the patch series
> breaks something. If you feel this then you should provide an example.
> Yes Linus had a problem with the cycles event on Neoverse and now
> that, as you suggested, is lowered to be a warning. The original patch
> landed for weeks on linux-next without complaint. I am not asking
> people to "re-lean the tool", I am trying to fix things and make order
> out of something less than that.
>
> > > Because of the pain in landing the reverted patch then RISC-V has had
> > > to work with perf's behavior as it is, they need to ship products. I
> >
> > you can present it like that, or you can say that they wanted the API t=
o
> > be different but since it wasn't like they liked they had to comply.
> >
> > Differently phrased he finally understood the value of the current API,
> > maybe.
>
> So Atish spoke to us at LPC 2023:
> https://lpc.events/event/17/
> Mark Rutland also spoke to me at that time explaining how unhappy he
> was that ARM Apple-M was broken. I combined both issues in our
> discussions.
> Atish has also spoken to Namhyung and myself face-to-face during the
> RISC-V conference.
> These issues were discussed verbally before I wrote patches, before
> Atish made assumptions, and I think we both believe the proposals were
> and are reasonable.
>
> So let me completely disagree with your rephrasing. It is rude to
> imply that Atish and myself somehow are trying to push an agenda of
> changing and breaking an API. What has always been done is an attempt
> at pragmatism, such as cleaning up the hard coded issues with the
> original hybrid support, fixing Apple-M, ..
>
> > > think things would have been simpler in their driver and the wider
> > > ecosystem if this hadn't been forced to happen.
> >
> > > > > vice-chair for RISC-V and hope to push things forward for RISC-V =
when
> > > > > I can. Given that ARM had originally required the prioritization,
> > > > > Intel signed off on this (with a huge number of Intel test
> > > > > expectations updated as a consequence), RISC-V desiring consisten=
cy I
> > > > > thought there was a pretty broad consensus to move forward with h=
aving
> > > > > the same prioritization of legacy and sysfs/json events for event
> > > > > names without PMUs as those with it.
> > > >
> > > > > In doing this change I made:
> > > > > $ perf (stat|record) -e cycles ...
> > > > > behave like:
> > > > > $ perf (stat|record) -e */cycles/ ...
> > > > > This is the behavior with sysfs/json events (ie not legacy). For =
example:
> > > > > $ perf (stat|record) -e inst_retired.any ...
> > > > > in the event parsing code behaves like:
> > > > > $ perf (stat|record) -e */inst_retired.any/ ...
> > > > > That is every PMU advertising the event inst_retired.any (in the =
sysfs
> > > > > events directory or in json) will have it opened by the tool.
> > > >
> > > > > My intent was that "cycles" behaving like "*/cycles/" was that it
> > > > > would match the change already done for hybrid of "cycles" behavi=
ng
> > > > > like "cpu_atom/cycles/,cpu_core/cycles/". However, this change ca=
used
> > > > > an issue on ARM Neoverse that Linus couldn't tolerate and so reve=
rted
> > > > > the change. Specifically ARM Neoverse's L3 cache PMU advertises a
> > > > > "cycles" event and such an event will fail to open with perf reco=
rd.
> > > >
> > > > > Specifying the PMU with the event avoids the wild card behavior a=
nd
> > > > > fixes the issue but it was put over strongly that "cycles" withou=
t a
> > > > > PMU should only ever mean CPU cycles. This missed hybrid/BIG.litt=
le
> > > > > type systems, but one could imagine in that case CPU means all co=
re
> > > > > PMUs.
> > > >
> > > > > As with not wanting hybrid PMU names hard coded, I dislike specia=
l
> > > > > cases for events. Not least as there are an exciting plethora of
> > > >
> > > > Ok, but the desire for consistency clashes with how things have bee=
n for
> > > > a long time, tools expect, scripts, etc, so we seem to need the spe=
cial
> > > > case for what has been called in these threads "legacy events".
> >
> > > There is only one known issue of a problem for 1 event on 1 ARM model=
.
> > > If ARM renamed the event this wouldn't be an issue. The patch series
> > > works for this event but warns about it if you try to use it with per=
f
> > > record.
> >
> > Well, maybe just the event name shouldn't be what determines if it
> > should be used in some cases? Maybe some other characteristic should be
> > probed for in each case?
>
> Do you want to explain this? We have events, without a PMU all events
> wildcard on every PMU. This is existing and long standing behavior.
> Uncore PMUs rely on it. Core PMUs with say a json event like
> inst_retired.any rely on it.
> You want a magic list of events that only work on core PMUs? Fine,
> what is it? I hate the idea as why does cpu_cycles mean something
> different than cpu-cycles, but if that is the only way to land the
> series then let's do it. You had been arguing for lowering the failure
> to just being a warning and not doing this. I do not understand where
> you stand. My stance is hopefully clear with the patch series. If you
> and Namhyung are worried that Linus seeing a warning message is a
> blocker the easiest fix is to rename 1 ARM uncore event. We could hide
> warnings and move them to verbose, imo that's gross. We can have a
> magic list of events, similarly imo gross but at least it unblocks
> this.
>
> > Have to stop here, not enough bandwidth.
>
> Thanks for making some time on this,
> Ian
