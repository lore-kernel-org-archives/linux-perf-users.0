Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EF414D28C;
	Mon, 24 Feb 2025 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740409302; cv=none; b=Zn0GKYqbfWUPSn4mzE2bDUZCZsJxv9uCN49LADTLUnWbezS6bud79PYdu5kNC28Nf8FL/VjvkFQUNa9grVu1T/mTilJicwC2JuE4MqEzuGsoXtSVw9Mh9vpjhL1bdeHb/d8vaTI53o2sXxxw+wYJfqz5GXyLdEUY4CVSSiTm2Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740409302; c=relaxed/simple;
	bh=kZfxXSKbfyAXzNEbdcwVxFnTYOvDhPtYVSeh9olvFgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbzmYOU1nMqVIJ459kQMYq5dAHvfqofS06HC5KzDxZE2yTpEwhvwIfWDW9ULXdBiC1s6NklgiM9LNW82ZIu69kzcS673RaluA1GEYaieqjXhGknrPL8ULtnmr0uzqA5xMwAmLCRcohBzD6grY3kpcSMLmbUsiXstquIsQj2B5Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBog6lcM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBog6lcM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73EAC4CED6;
	Mon, 24 Feb 2025 15:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740409301;
	bh=kZfxXSKbfyAXzNEbdcwVxFnTYOvDhPtYVSeh9olvFgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBog6lcMNcByGWz34qd94ulK6tk2Je/XVh4RnUSWGNGRbeM1wCBGkuWszHBMX4SF6
	 WuNoNIBdW2lNzLJ4YlXjhgV5q9ApT3Dyrmlh+WeAc1X+fjvTozELFt2ikFkIsFvVMs
	 /yQCbTWSfqZs2ZH26lCcUKm1S0epowFzpFhEiUEjjspZv9H6beZXrxbVzI6cJTLdiN
	 yd5ZMjA2tRLx6AkWKwMNu4iIY/MYBbfF9bWegrF8Ncwf7EnAvGzeb/frvKjlcryejT
	 RYGrM5mJJG3s7QisP5Gly/boL5Pu8c15yZ9RMx+DFCI6ihbzOPgAgfiSHBSJ2+7hFa
	 GeTCI+ZoDKmvA==
Date: Mon, 24 Feb 2025 16:01:37 +0100
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
Message-ID: <Z7yJ0Vpub6JeQyYo@x1>
References: <Z7Z5kv75BMML2A1q@google.com>
 <CAP-5=fVbti6efu6uA9a5os6xhnTuJ0egyesZsy0dmkiScwYFqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVbti6efu6uA9a5os6xhnTuJ0egyesZsy0dmkiScwYFqQ@mail.gmail.com>

On Wed, Feb 19, 2025 at 10:37:33PM -0800, Ian Rogers wrote:
> On Wed, Feb 19, 2025 at 4:38 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > Ian and I have been discussing the behaviors of event encodings and it's
> > hard to find a point so far that we can agree on.  So I'd like to hear
> > your opinion to resolve this.  If you happen to have some time, you can
> > follow the thread here:

> > https://lore.kernel.org/linux-perf-users/20250109222109.567031-5-irogers@google.com/#r

> > Basically there are some events that were defined in the perf ABI.

> >   PERF_COUNT_HW_CPU_CYCLES, PERF_COUNT_HW_INSTRUCTIONS, ...

> > So perf tools use those (legacy) encodings with the matching names like
> > "cycles" (or "cpu-cycles"), "instructions", etc.

> > On the another hand, it has wildcard matching for event names in PMUs so
> > that users can conveniently use events without specifying PMU names.
> > For example, "event1" would expand to "pmuX/event1/", "pmuY/event1/", etc
> > as long as the PMUs have the event in sysfs or JSON.

> > And there are platforms where "cycles" event is defined in a (core) PMU
> > (like "blah/cycles") and the event has a different behavior than the
> > legacy encoding.  Then it has to choose which encoding is better for the
> > given name.  But it's a general issue for the legacy event names.

So we pick the "legacy" one, as always, and the one that is in a PMU
needs to have its pmu name specified, no?

> >   Q. what should it do with "cycles"?
> >   -----------------------------------
> >   1. just use the legacy encoding (PERF_COUNT_HW_CPU_CYCLES).

Right

> >   2. expand to (possibly multiple) PMU events (like "cpu/cycles/") and
> >      use the encoding defined there.

Nope

> > I think the #1 is the current behavior.  The upside is it's simple and
> > intuitive.  But it's different than other names and can make confusion.
> > Users should use the full name ("cpu/cycles/") if they need sysfs one.

Right
 
> So the code keeps changing, for example, the removal of BPF events. I

Humm, this seems like a different discussion.

> think the important change and the thing that has brought us here is
> the addition of what Intel call hybrid and ARM call BIG.little. ARM

Right, the support for hybrid systems brought lots of problems, most
people didn't have access to such systems and thus couldn't test
patches, so the attempt was to keep the existing code working as it had
been while allowing for the support for the new hybrid systems.

As more people get access to hybrid systems we started noticing problems
and working on fixing it, you did a lot of work in this area, highly
appreciated.

> have got architectural events and so the same event encoding on BIG
> and little cores. On x86 the e-core (atom) and p-cores have different
> event encodings. In the original hybrid work, pushed on for the launch
> of Alderlake and reviewed by Jiri and Arnaldo with no involvement from
> me, Intel wanted the event names to work transparently. So a cycles

Without access to such systems, yes, see above.

> event would be gathered on the e-core and p-core with a command line
> option to merge the legacy event cycles on both cores. To be specific
> the expected behavior of:
> $ perf (stat|record) -e cycles ...
> would be as if:
> $ perf (stat|record) -e cpu_atom/cycles/,cpu_core/cycles/ ...

Yes, and if somebody wants to profile in just one of those core types,
just specify the "cpu_atom" or "cpu_core" to have it fully specified.
 
> An unfortunate thing in the hybrid code was that it was hardcoded to
> PMU names of cpu_atom and cpu_core, but what to do for metrics? The

Yeah, metrics IIRC came before hybrid systems.

> original proposal was that metrics would have a PMU name and all names
> would be relative to that, but what about uncore events? What about
> metrics that refer to other metrics? A decision was made to not to
> have PMUs implicitly in metrics and the events in the metric would
> match those given to perf's -e command line. This also greatly
> simplifies testing events when creating a metric.

> I set about rewriting the hybrid code not to use hard coded PMU names
> but to discover core PMUs at runtime. This was to make the metric and
> event parsing code as generic as possible, but this had an unintended
> consequence. ARM's core PMU had previously not been seen as handling
> legacy events like cycles, and appeared as an uncore PMU. When there

> are both legacy and sysfs/json events then previously the legacy
> events had priority. This broke events like cycles on Apple M
> processors where the legacy events were broken and the sysfs ones not.
> Yes this is a driver bug, but everybody told me a change in behavior
> of the tool was needed to fix it, that fix was to make sysfs/json
> events have priority over legacy events. I prioritized fixing event
> parsing when a PMU was specified but given "cycles" means
> "cpu_atom/cycles/ and cpu_core/cycles/" for hybrid, why would the
> prioritization be different without a PMU specified?
 
> I knew of this tech debt and separately RISC-V was also interested to
> have sysfs/json be the priority so that the legacy to config encoding
> could exist more in the perf tool than the PMU driver. I'm a SIG

I saw them saying that supporting PERF_TYPE_HARDWARE counters was ok as
they didn't want to break the perf tooling workflow, no?

> vice-chair for RISC-V and hope to push things forward for RISC-V when
> I can. Given that ARM had originally required the prioritization,
> Intel signed off on this (with a huge number of Intel test
> expectations updated as a consequence), RISC-V desiring consistency I
> thought there was a pretty broad consensus to move forward with having
> the same prioritization of legacy and sysfs/json events for event
> names without PMUs as those with it.
 
> In doing this change I made:
> $ perf (stat|record) -e cycles ...
> behave like:
> $ perf (stat|record) -e */cycles/ ...
> This is the behavior with sysfs/json events (ie not legacy). For example:
> $ perf (stat|record) -e inst_retired.any ...
> in the event parsing code behaves like:
> $ perf (stat|record) -e */inst_retired.any/ ...
> That is every PMU advertising the event inst_retired.any (in the sysfs
> events directory or in json) will have it opened by the tool.
 
> My intent was that "cycles" behaving like "*/cycles/" was that it
> would match the change already done for hybrid of "cycles" behaving
> like "cpu_atom/cycles/,cpu_core/cycles/". However, this change caused
> an issue on ARM Neoverse that Linus couldn't tolerate and so reverted
> the change. Specifically ARM Neoverse's L3 cache PMU advertises a
> "cycles" event and such an event will fail to open with perf record.

> Specifying the PMU with the event avoids the wild card behavior and
> fixes the issue but it was put over strongly that "cycles" without a
> PMU should only ever mean CPU cycles. This missed hybrid/BIG.little
> type systems, but one could imagine in that case CPU means all core
> PMUs.
 
> As with not wanting hybrid PMU names hard coded, I dislike special
> cases for events. Not least as there are an exciting plethora of

Ok, but the desire for consistency clashes with how things have been for
a long time, tools expect, scripts, etc, so we seem to need the special
case for what has been called in these threads "legacy events".

> legacy names inside the perf tool particularly for legacy cache
> events. Similarly ARM core PMUs will advertise a "cpu_cycles" event,
> while "cycles" and "cpu-cycles" are both legacy names. It seems less
> than obvious that using a hyphen or an underscore would change the PMU
> wildcard behavior of an event name. That is the legacy "cpu-cycles"
> event would wild card only with core PMUs while sysfs "cpu_cycles"
> event would wild card with all PMUs.
 
> Anyway, the proposals to move forward on this were:

> 1) from me, ARM should rename their cycles event on their L3 cache
> PMU. They have a bus_cycles event on this PMU and so cpu_cycles would
> seem like a less ambiguous name. Leo wasn't keen on this in case it
> broke something depending on the event name. We've recently been
> talking of renaming swathes of ARM's PMUs, and moving things around in
> sysfs, so I don't feel renaming 1 event is massive but I feel such a
> change should be coming from ARM.


> 2) from Arnaldo, with perf record make it so that when events fail to
> open it is just warned about. This has been added to the patch series.

In verbose mode, IIRC. If the user wants some "cycles" event and it is
not included in the tool output then, as with other cases, using -v to
see if some extra debug message can clarify seems the usual workflow.

> It turns out that if no events open it breaks perf's own tests so the
> patch series warns when events fail to open and fails if the eventual
> evlist is empty or only contains dummy events.

Do you have a link to this thread?

> 3) my interpretation of what Linus and Namhyung are asking for, make
> certain events special so "cycles" only ever means the cycles on core
> PMUs. The definition of special seems to be that all legacy names are
> special, although Linus never explicitly said this he just mentioned

I think that is fair to say, to try and make the events that most people
use as they worked in the past, i.e. no surprise for people not
interested in metrics, hybrid systems, and lots of other features in
perf that most people seldomly, if at all, use.

- Arnaldo

> cycles - in fact I pushed him on what he meant and he responded by
> blocking my email. This is a change in the wild carding behavior of
> the event lookup, but Namhyung has also said that without a PMU the
> legacy event encodings should be used. An issue here is that we wanted
> to avoid legacy encodings as they previously broke Apple M, another
> issue is that RISC-V want to avoid legacy encodings so that the
> mappings can live in the perf tool.
 
> > The #2 can make the parsing code simpler and the behavior consistent.
> > Also it can override the (possibly broken) behavior of the legacy event
> > on some platforms.  No way (and reason?) to use the legacy encodings.

> > Also Ian says `perf list` shows "cpu-cycles" and "cpu/cpu-cycles/"
> > together which assumes they are the same.  But using #1 can result in a
> > different behavior respectively.  Probably better to make it consistent.
 
> I could note that previously the event parsing and event printing code
> lived in the same file. It is odd to me that "cpu-cycles" should mean
> legacy and "cpu/cpu-cycles/" (that has a sysfs event on Intel) uses
> the sysfs/json encoding. A separate change I'm working on is making it
> so that tracepoints can appear in metrics. Currently the colon in a
> tracepoint is treated as an event modifier in the metrics code thereby
> breaking the events. Rather than re-invent modifier parsing for events
> in metrics it seems to make sense to just parse events individually.
> It would make sense that the logic in metrics to deduplicate events in
> metrics like:
> "MetricName": "cache_hit_percent",
> "MetricExpr": "100 * cache_hits/(cache_hits + cache_misses)",
> where the cache_hits event is duplicated, would work off of the
> perf_event_attr rather than the event name as currently happens. Using
> different encodings would defeat this - although you are unlikely to
> use different event names within the same metric, we do try to
> optimize and share metric formulas as much as possible. I think across
> perf's history the PMU has been treated as an optional prefix meaning
> (1) wild carding is normally expected and (2) event encodings
> shouldn't vary because of how the wild carding happens (the optional
> thing would be a required thing if it changes behavior, for example on
> Apple M CPUs to work around the PMU driver issue).
> 
> > I tried to summarize the issues concisely but may miss some issues.  I
> > hope Ian can fill it up in case I missed something important.
> >
> > Can you please share your opinion about what would be the best behavior?
> 
> I'd very much appreciate guidance. This issue matters to me for
> consistency, cleanliness, tech debt,.. but is strategic for RISC-V.
> The series Namhyung linked to has the tags:
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> Tested-by: James Clark <james.clark@linaro.org>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Atish Patra <atishp@rivosinc.com>
> It is reapplying a patch that lived on linux-next for weeks/months and
> that should presumably mean that PowerPC and S390 are happy with it,
> as they are very good at reporting issues when things have gone awry.
> It carries a patch implementing Arnaldo's suggestion to make perf
> record failing to open a warning rather than fatal. It is unusual that
> patches in the perf tool have this level of review and this high
> number of tags.
> 
> Thanks,
> Ian
