Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D381DF982;
	Mon, 24 Feb 2025 20:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740428752; cv=none; b=A3auS/mhQD4/ObthknJVyUZ0nSoFE8tmxxVfbqKsk4cPog/VbvrnsIfaeC1agFASYtY0EYAYC25KZk8kq84FGjNYycBeXPP5Hbg6/Qk4Nx7eyyvHHo4XhBBmTMMyMvJ+/e7Qpqt837v42cIrPFzDAJfIc4JZqE7N6fKvpOU+3Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740428752; c=relaxed/simple;
	bh=w4pNywwb4ygLL2oNZMODmsolQRcIIc7lvBYr5AhWVDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HA4xyoa1JbpEBg4I1fxhtkuXwvmYSD3G40sedsd9pqMIkQUctLvn/KphcTCxQw0dsgPjIjIHRnsMje8VGzpLGPeeFx2M8HW23vx4ckaUaIXU/Fhw//CGMLwSACm7wO7WOtLVdIAO09BpFcaIy5LHeHqS6OXg3GB22s+4GW+RA2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brTdQTfz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brTdQTfz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB6DC4CED6;
	Mon, 24 Feb 2025 20:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740428751;
	bh=w4pNywwb4ygLL2oNZMODmsolQRcIIc7lvBYr5AhWVDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=brTdQTfzUMFpHWypeG89u7T0wGuCeY+yGqXD5o4xKSTk9ftwpSbBqmlmHRcNB5xwI
	 zvI2x/RRl6VJlS/PB4DeQCqLM1YYvhjoSue/gfBQnaCdF+6LN1+bAo8rZig/xGqWhn
	 7TUsl/q/SPbo8gSUUHua0gJHyt++Im1vbFYSQSNYwNXCM3psKfjzXKqk4d6tspYlhk
	 RdcEA7/9tV54gkZDS6IxRjUI6Lh80ODql6Q6PC3CbFSMrXq0qf605YquXF53gD+7ns
	 hf3UTm/0eNG1DXAyIYLbcjQopGfG6+F5rU8rFeSIgRn9DtYspOVHLWZvm7NVrSN37B
	 PVkBf5CRtigYg==
Date: Mon, 24 Feb 2025 21:25:48 +0100
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC] perf tools: About encodings of legacy event names
Message-ID: <Z7zVzKbQIdB6-bFn@x1>
References: <Z7Z5kv75BMML2A1q@google.com>
 <CAP-5=fVbti6efu6uA9a5os6xhnTuJ0egyesZsy0dmkiScwYFqQ@mail.gmail.com>
 <Z7yJ0Vpub6JeQyYo@x1>
 <CAP-5=fXSgpZaAgickZSWgjt-2iTWK7FFZc65_HG3QhrTg1mtBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXSgpZaAgickZSWgjt-2iTWK7FFZc65_HG3QhrTg1mtBw@mail.gmail.com>

On Mon, Feb 24, 2025 at 09:36:16AM -0800, Ian Rogers wrote:
> On Mon, Feb 24, 2025 at 7:01 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Wed, Feb 19, 2025 at 10:37:33PM -0800, Ian Rogers wrote:
> > > On Wed, Feb 19, 2025 at 4:38 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > Ian and I have been discussing the behaviors of event encodings and it's
> > > > hard to find a point so far that we can agree on.  So I'd like to hear
> > > > your opinion to resolve this.  If you happen to have some time, you can
> > > > follow the thread here:
> >
> > > > https://lore.kernel.org/linux-perf-users/20250109222109.567031-5-irogers@google.com/#r
> >
> > > > Basically there are some events that were defined in the perf ABI.
> >
> > > >   PERF_COUNT_HW_CPU_CYCLES, PERF_COUNT_HW_INSTRUCTIONS, ...
> >
> > > > So perf tools use those (legacy) encodings with the matching names like
> > > > "cycles" (or "cpu-cycles"), "instructions", etc.
> >
> > > > On the another hand, it has wildcard matching for event names in PMUs so
> > > > that users can conveniently use events without specifying PMU names.
> > > > For example, "event1" would expand to "pmuX/event1/", "pmuY/event1/", etc
> > > > as long as the PMUs have the event in sysfs or JSON.
> >
> > > > And there are platforms where "cycles" event is defined in a (core) PMU
> > > > (like "blah/cycles") and the event has a different behavior than the
> > > > legacy encoding.  Then it has to choose which encoding is better for the
> > > > given name.  But it's a general issue for the legacy event names.
> >
> > So we pick the "legacy" one, as always, and the one that is in a PMU
> > needs to have its pmu name specified, no?
> >
> > > >   Q. what should it do with "cycles"?
> > > >   -----------------------------------
> > > >   1. just use the legacy encoding (PERF_COUNT_HW_CPU_CYCLES).
> >
> > Right
> >
> > > >   2. expand to (possibly multiple) PMU events (like "cpu/cycles/") and
> > > >      use the encoding defined there.
> >
> > Nope
> >
> > > > I think the #1 is the current behavior.  The upside is it's simple and
> > > > intuitive.  But it's different than other names and can make confusion.
> > > > Users should use the full name ("cpu/cycles/") if they need sysfs one.
> >
> > Right
> >
> > > So the code keeps changing, for example, the removal of BPF events. I
> >
> > Humm, this seems like a different discussion.
> >
> > > think the important change and the thing that has brought us here is
> > > the addition of what Intel call hybrid and ARM call BIG.little. ARM
> >
> > Right, the support for hybrid systems brought lots of problems, most
> > people didn't have access to such systems and thus couldn't test
> > patches, so the attempt was to keep the existing code working as it had
> > been while allowing for the support for the new hybrid systems.
> >
> > As more people get access to hybrid systems we started noticing problems
> > and working on fixing it, you did a lot of work in this area, highly
> > appreciated.
> >
> > > have got architectural events and so the same event encoding on BIG
> > > and little cores. On x86 the e-core (atom) and p-cores have different
> > > event encodings. In the original hybrid work, pushed on for the launch
> > > of Alderlake and reviewed by Jiri and Arnaldo with no involvement from
> > > me, Intel wanted the event names to work transparently. So a cycles
> >
> > Without access to such systems, yes, see above.
> >
> > > event would be gathered on the e-core and p-core with a command line
> > > option to merge the legacy event cycles on both cores. To be specific
> > > the expected behavior of:
> > > $ perf (stat|record) -e cycles ...
> > > would be as if:
> > > $ perf (stat|record) -e cpu_atom/cycles/,cpu_core/cycles/ ...
> >
> > Yes, and if somebody wants to profile in just one of those core types,
> > just specify the "cpu_atom" or "cpu_core" to have it fully specified.
> >
> > > An unfortunate thing in the hybrid code was that it was hardcoded to
> > > PMU names of cpu_atom and cpu_core, but what to do for metrics? The
> >
> > Yeah, metrics IIRC came before hybrid systems.
> >
> > > original proposal was that metrics would have a PMU name and all names
> > > would be relative to that, but what about uncore events? What about
> > > metrics that refer to other metrics? A decision was made to not to
> > > have PMUs implicitly in metrics and the events in the metric would
> > > match those given to perf's -e command line. This also greatly
> > > simplifies testing events when creating a metric.
> >
> > > I set about rewriting the hybrid code not to use hard coded PMU names
> > > but to discover core PMUs at runtime. This was to make the metric and
> > > event parsing code as generic as possible, but this had an unintended
> > > consequence. ARM's core PMU had previously not been seen as handling
> > > legacy events like cycles, and appeared as an uncore PMU. When there
> >
> > > are both legacy and sysfs/json events then previously the legacy
> > > events had priority. This broke events like cycles on Apple M
> > > processors where the legacy events were broken and the sysfs ones not.
> > > Yes this is a driver bug, but everybody told me a change in behavior
> > > of the tool was needed to fix it, that fix was to make sysfs/json
> > > events have priority over legacy events. I prioritized fixing event
> > > parsing when a PMU was specified but given "cycles" means
> > > "cpu_atom/cycles/ and cpu_core/cycles/" for hybrid, why would the
> > > prioritization be different without a PMU specified?
> >
> > > I knew of this tech debt and separately RISC-V was also interested to
> > > have sysfs/json be the priority so that the legacy to config encoding
> > > could exist more in the perf tool than the PMU driver. I'm a SIG
> >
> > I saw them saying that supporting PERF_TYPE_HARDWARE counters was ok as
> > they didn't want to break the perf tooling workflow, no?
> 
> No. The request has always been that they don't want the PMU driver to
> do the PERF_TYPE_HARDWARE/PERF_COUNT_HW_* to PMU/config=??? mapping
> given the diversity of hardware and to keep the PMU driver simple.
> Here is Atish's feedback:
> https://lore.kernel.org/lkml/CAHBxVyH1q5CRW3emWTZu1oLZEfTWWVRH6B0OVggFxt-0NRzvwQ@mail.gmail.com/
> """
> If the overriding legacy with JSON is available, each future vendor
> may just provide the json file instead of modifying the driver.
> """

So, making users to figure out what is the best event to use for some
specific processor was one of the major reasons for perf to come about,
otherwise we would still be stuck with oprofile.

While it is clear that picking some "most important event and ratios of
events" is super difficult, that was one of the ideas that made perf to
come about.

I wasn´t the architect of this, Ingo and Thomas were, with Peter then
tryhing to make the kernel part sane.

I just tried to follow those principles while not getting in the way of
people wanting to have a common ground for observability in Linux.

Having all these JSON tables was in place was a major concession to that
original vision.

Changing things as we go, with all these changes in the hardware
landscape, some fleeting, some reinforced, is super difficult and leads
to all this pain in trying to provide a sane experience to people using
these tools.

I don't think we can have it super consistent.

It is super useful as is, or at least that what people say.

So we need to keep on improving it while not telling people used to its
workflows that they should re-learn the tool because at some point a
decision was not properly made.

> Because of the pain in landing the reverted patch then RISC-V has had
> to work with perf's behavior as it is, they need to ship products. I

you can present it like that, or you can say that they wanted the API to
be different but since it wasn't like they liked they had to comply.

Differently phrased he finally understood the value of the current API,
maybe.

> think things would have been simpler in their driver and the wider
> ecosystem if this hadn't been forced to happen.
 
> > > vice-chair for RISC-V and hope to push things forward for RISC-V when
> > > I can. Given that ARM had originally required the prioritization,
> > > Intel signed off on this (with a huge number of Intel test
> > > expectations updated as a consequence), RISC-V desiring consistency I
> > > thought there was a pretty broad consensus to move forward with having
> > > the same prioritization of legacy and sysfs/json events for event
> > > names without PMUs as those with it.
> >
> > > In doing this change I made:
> > > $ perf (stat|record) -e cycles ...
> > > behave like:
> > > $ perf (stat|record) -e */cycles/ ...
> > > This is the behavior with sysfs/json events (ie not legacy). For example:
> > > $ perf (stat|record) -e inst_retired.any ...
> > > in the event parsing code behaves like:
> > > $ perf (stat|record) -e */inst_retired.any/ ...
> > > That is every PMU advertising the event inst_retired.any (in the sysfs
> > > events directory or in json) will have it opened by the tool.
> >
> > > My intent was that "cycles" behaving like "*/cycles/" was that it
> > > would match the change already done for hybrid of "cycles" behaving
> > > like "cpu_atom/cycles/,cpu_core/cycles/". However, this change caused
> > > an issue on ARM Neoverse that Linus couldn't tolerate and so reverted
> > > the change. Specifically ARM Neoverse's L3 cache PMU advertises a
> > > "cycles" event and such an event will fail to open with perf record.
> >
> > > Specifying the PMU with the event avoids the wild card behavior and
> > > fixes the issue but it was put over strongly that "cycles" without a
> > > PMU should only ever mean CPU cycles. This missed hybrid/BIG.little
> > > type systems, but one could imagine in that case CPU means all core
> > > PMUs.
> >
> > > As with not wanting hybrid PMU names hard coded, I dislike special
> > > cases for events. Not least as there are an exciting plethora of
> >
> > Ok, but the desire for consistency clashes with how things have been for
> > a long time, tools expect, scripts, etc, so we seem to need the special
> > case for what has been called in these threads "legacy events".
 
> There is only one known issue of a problem for 1 event on 1 ARM model.
> If ARM renamed the event this wouldn't be an issue. The patch series
> works for this event but warns about it if you try to use it with perf
> record.

Well, maybe just the event name shouldn't be what determines if it
should be used in some cases? Maybe some other characteristic should be
probed for in each case?

Have to stop here, not enough bandwidth.

- Arnaldo
