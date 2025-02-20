Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A665223
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Feb 2025 06:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740033467; cv=none; b=to3i8jeieqQCAuPoO15kYLc1/WaB6iBgFT8PN8e1SzSz/mlqXKs/Te7FxkPy85KIXEBM0mG0TQWrNnmj3wkHLgsCArH4Zh+BObmg6i0C4BdzjD67YkfWEYFDesIcnsAR7e8mskrVrQaryv5GM1qDydcIeDhbge3aYcrMpVj9T+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740033467; c=relaxed/simple;
	bh=kHWR+FAwu55WQPTkV50/Sw5fI2EHyGkXB9h3k4yH+qY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTVAicLDTr6ZbnPR2XaDpKQZVpt6A36tXqYsoJENVAjoQyyoqIPpCwVshuD4M0WlFPXm3HnENqfsjcg1Gr6Xd/GZHb7z6hcZVuDcJRBhArSATZWCfL/gNqt/Opl8XDP4Qn31EHFbN8KUjc17O0y9yrm8O1fKiSZOSvPKIQ6b8Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q9jIc7P5; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q9jIc7P5"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d18c325ee4so94145ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 22:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740033465; x=1740638265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IeeL54Wg+8SY9YQwsDbxhA4A1o9xmMXYnFjkeCtvIhc=;
        b=q9jIc7P5CKZBMl1mG5Ycpoxw1TGoEGuoJ/fV85Y4RlmWoxhbupEd/gzYiuOvXQsuew
         uJ1/332RFZerx/gx623XtHl946l88s3k9O3zue1IN0qV+30E9UTC0rQ1nOuvwmbB/Vga
         QapBssT4pOn1qaAGSNvpAGe5XZxN8tA4lbjZ+s9aGqtW1zOnOOtBPOZdjdu+jb+1K4Kh
         6QFCWLbSYpvUXqjNTm2me4klD5eELLJt+Rzpauu9jkEVrcJEzaxwDRYJoV4KZIpmEvlO
         x7r1/3I3M/Fn/RMHCalVb8KqgFzj1Zam9Iu2ZTXuI9dgFgZRsp+dX41AJnqdjJf4e8s3
         eurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740033465; x=1740638265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IeeL54Wg+8SY9YQwsDbxhA4A1o9xmMXYnFjkeCtvIhc=;
        b=Mfl+0xLba/Up+jgEjTSO7+Lmx1D6ihH2czdRP+O4UN6nNq1b9xC7Mk27afePphsdhf
         zcNBfbB57UOufywgCz7E5hhG7/VSFdKwWBkCtB0z3QlBAh4PvNt/5aejBKqQUz30RHCb
         8t+xby3TO3zc0d3QsjfjIWm7kwIfqE3LEcM1TwHrcc5qnf1mfvgBXPDYZBXBok0v5ukc
         kl0spcOuqIee3nXf/XSL2eQKcHifu1sbHdWrpluUcVgmSVdkPWnx/J0QwgayDNRg9puf
         kb/+Vj/TYwz60FldssIWqyCpaGhDHTjpBfWUJTRezIaPB3vx907ss+2EmKFQHrJfLT+A
         OhDA==
X-Gm-Message-State: AOJu0YwZfWg835IDOIERbrHhIohnbe+5vh4ravN9qW5Pij/Lz07+5C79
	BVgK/wX2Cc8+NbBDEl/9BMEriOo3UqA+ZjhliRskCk+TIfx/xnYBGHtop78yn3TWJrttfpTLiMm
	CJvZTVI90JgChgc12Q4UwSVjsGC87HBTNcxm7
X-Gm-Gg: ASbGncsZId7agAxI4T9vQ+2LQzfGa+2Ri0+aUVC56TDXN470RMeaaxsIAUvPvNriEo4
	BGvqX7//LYMNroyLZny3dqHSK4BInNH8TZIv0L9FpjNZB53iPHthCSWvlvZ9FiBgNMA/CiY+Rww
	==
X-Google-Smtp-Source: AGHT+IGJK+IG6ARaSmMbGupXEAsNP1x5CTdWiCCbzSUDKmeUnNJp5tXiHe4TpR5HVA2TVrayQ1F+lSq5OQOBPJGtVKA=
X-Received: by 2002:a05:6e02:1a4c:b0:3d1:7971:e6d5 with SMTP id
 e9e14a558f8ab-3d2c07e10d4mr2284815ab.0.1740033464583; Wed, 19 Feb 2025
 22:37:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z7Z5kv75BMML2A1q@google.com>
In-Reply-To: <Z7Z5kv75BMML2A1q@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Feb 2025 22:37:33 -0800
X-Gm-Features: AWEUYZl7-5z3UM6NcWigRnKT-YxDy8p9qOqrdfzjjTwuRvb0vhlAQNrmBPlZT-E
Message-ID: <CAP-5=fVbti6efu6uA9a5os6xhnTuJ0egyesZsy0dmkiScwYFqQ@mail.gmail.com>
Subject: Re: [RFC] perf tools: About encodings of legacy event names
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 4:38=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> Ian and I have been discussing the behaviors of event encodings and it's
> hard to find a point so far that we can agree on.  So I'd like to hear
> your opinion to resolve this.  If you happen to have some time, you can
> follow the thread here:
>
> https://lore.kernel.org/linux-perf-users/20250109222109.567031-5-irogers@=
google.com/#r
>
> Basically there are some events that were defined in the perf ABI.
>
>   PERF_COUNT_HW_CPU_CYCLES, PERF_COUNT_HW_INSTRUCTIONS, ...
>
> So perf tools use those (legacy) encodings with the matching names like
> "cycles" (or "cpu-cycles"), "instructions", etc.
>
> On the another hand, it has wildcard matching for event names in PMUs so
> that users can conveniently use events without specifying PMU names.
> For example, "event1" would expand to "pmuX/event1/", "pmuY/event1/", etc
> as long as the PMUs have the event in sysfs or JSON.
>
> And there are platforms where "cycles" event is defined in a (core) PMU
> (like "blah/cycles") and the event has a different behavior than the
> legacy encoding.  Then it has to choose which encoding is better for the
> given name.  But it's a general issue for the legacy event names.
>
>   Q. what should it do with "cycles"?
>   -----------------------------------
>   1. just use the legacy encoding (PERF_COUNT_HW_CPU_CYCLES).
>
>   2. expand to (possibly multiple) PMU events (like "cpu/cycles/") and
>      use the encoding defined there.
>
> I think the #1 is the current behavior.  The upside is it's simple and
> intuitive.  But it's different than other names and can make confusion.
> Users should use the full name ("cpu/cycles/") if they need sysfs one.

So the code keeps changing, for example, the removal of BPF events. I
think the important change and the thing that has brought us here is
the addition of what Intel call hybrid and ARM call BIG.little. ARM
have got architectural events and so the same event encoding on BIG
and little cores. On x86 the e-core (atom) and p-cores have different
event encodings. In the original hybrid work, pushed on for the launch
of Alderlake and reviewed by Jiri and Arnaldo with no involvement from
me, Intel wanted the event names to work transparently. So a cycles
event would be gathered on the e-core and p-core with a command line
option to merge the legacy event cycles on both cores. To be specific
the expected behavior of:
$ perf (stat|record) -e cycles ...
would be as if:
$ perf (stat|record) -e cpu_atom/cycles/,cpu_core/cycles/ ...

An unfortunate thing in the hybrid code was that it was hardcoded to
PMU names of cpu_atom and cpu_core, but what to do for metrics? The
original proposal was that metrics would have a PMU name and all names
would be relative to that, but what about uncore events? What about
metrics that refer to other metrics? A decision was made to not to
have PMUs implicitly in metrics and the events in the metric would
match those given to perf's -e command line. This also greatly
simplifies testing events when creating a metric.

I set about rewriting the hybrid code not to use hard coded PMU names
but to discover core PMUs at runtime. This was to make the metric and
event parsing code as generic as possible, but this had an unintended
consequence. ARM's core PMU had previously not been seen as handling
legacy events like cycles, and appeared as an uncore PMU. When there
are both legacy and sysfs/json events then previously the legacy
events had priority. This broke events like cycles on Apple M
processors where the legacy events were broken and the sysfs ones not.
Yes this is a driver bug, but everybody told me a change in behavior
of the tool was needed to fix it, that fix was to make sysfs/json
events have priority over legacy events. I prioritized fixing event
parsing when a PMU was specified but given "cycles" means
"cpu_atom/cycles/ and cpu_core/cycles/" for hybrid, why would the
prioritization be different without a PMU specified?

I knew of this tech debt and separately RISC-V was also interested to
have sysfs/json be the priority so that the legacy to config encoding
could exist more in the perf tool than the PMU driver. I'm a SIG
vice-chair for RISC-V and hope to push things forward for RISC-V when
I can. Given that ARM had originally required the prioritization,
Intel signed off on this (with a huge number of Intel test
expectations updated as a consequence), RISC-V desiring consistency I
thought there was a pretty broad consensus to move forward with having
the same prioritization of legacy and sysfs/json events for event
names without PMUs as those with it.

In doing this change I made:
$ perf (stat|record) -e cycles ...
behave like:
$ perf (stat|record) -e */cycles/ ...
This is the behavior with sysfs/json events (ie not legacy). For example:
$ perf (stat|record) -e inst_retired.any ...
in the event parsing code behaves like:
$ perf (stat|record) -e */inst_retired.any/ ...
That is every PMU advertising the event inst_retired.any (in the sysfs
events directory or in json) will have it opened by the tool.

My intent was that "cycles" behaving like "*/cycles/" was that it
would match the change already done for hybrid of "cycles" behaving
like "cpu_atom/cycles/,cpu_core/cycles/". However, this change caused
an issue on ARM Neoverse that Linus couldn't tolerate and so reverted
the change. Specifically ARM Neoverse's L3 cache PMU advertises a
"cycles" event and such an event will fail to open with perf record.
Specifying the PMU with the event avoids the wild card behavior and
fixes the issue but it was put over strongly that "cycles" without a
PMU should only ever mean CPU cycles. This missed hybrid/BIG.little
type systems, but one could imagine in that case CPU means all core
PMUs.

As with not wanting hybrid PMU names hard coded, I dislike special
cases for events. Not least as there are an exciting plethora of
legacy names inside the perf tool particularly for legacy cache
events. Similarly ARM core PMUs will advertise a "cpu_cycles" event,
while "cycles" and "cpu-cycles" are both legacy names. It seems less
than obvious that using a hyphen or an underscore would change the PMU
wildcard behavior of an event name. That is the legacy "cpu-cycles"
event would wild card only with core PMUs while sysfs "cpu_cycles"
event would wild card with all PMUs.

Anyway, the proposals to move forward on this were:
1) from me, ARM should rename their cycles event on their L3 cache
PMU. They have a bus_cycles event on this PMU and so cpu_cycles would
seem like a less ambiguous name. Leo wasn't keen on this in case it
broke something depending on the event name. We've recently been
talking of renaming swathes of ARM's PMUs, and moving things around in
sysfs, so I don't feel renaming 1 event is massive but I feel such a
change should be coming from ARM.
2) from Arnaldo, with perf record make it so that when events fail to
open it is just warned about. This has been added to the patch series.
It turns out that if no events open it breaks perf's own tests so the
patch series warns when events fail to open and fails if the eventual
evlist is empty or only contains dummy events.
3) my interpretation of what Linus and Namhyung are asking for, make
certain events special so "cycles" only ever means the cycles on core
PMUs. The definition of special seems to be that all legacy names are
special, although Linus never explicitly said this he just mentioned
cycles - in fact I pushed him on what he meant and he responded by
blocking my email. This is a change in the wild carding behavior of
the event lookup, but Namhyung has also said that without a PMU the
legacy event encodings should be used. An issue here is that we wanted
to avoid legacy encodings as they previously broke Apple M, another
issue is that RISC-V want to avoid legacy encodings so that the
mappings can live in the perf tool.

> The #2 can make the parsing code simpler and the behavior consistent.
> Also it can override the (possibly broken) behavior of the legacy event
> on some platforms.  No way (and reason?) to use the legacy encodings.
>
> Also Ian says `perf list` shows "cpu-cycles" and "cpu/cpu-cycles/"
> together which assumes they are the same.  But using #1 can result in a
> different behavior respectively.  Probably better to make it consistent.

I could note that previously the event parsing and event printing code
lived in the same file. It is odd to me that "cpu-cycles" should mean
legacy and "cpu/cpu-cycles/" (that has a sysfs event on Intel) uses
the sysfs/json encoding. A separate change I'm working on is making it
so that tracepoints can appear in metrics. Currently the colon in a
tracepoint is treated as an event modifier in the metrics code thereby
breaking the events. Rather than re-invent modifier parsing for events
in metrics it seems to make sense to just parse events individually.
It would make sense that the logic in metrics to deduplicate events in
metrics like:
"MetricName": "cache_hit_percent",
"MetricExpr": "100 * cache_hits/(cache_hits + cache_misses)",
where the cache_hits event is duplicated, would work off of the
perf_event_attr rather than the event name as currently happens. Using
different encodings would defeat this - although you are unlikely to
use different event names within the same metric, we do try to
optimize and share metric formulas as much as possible. I think across
perf's history the PMU has been treated as an optional prefix meaning
(1) wild carding is normally expected and (2) event encodings
shouldn't vary because of how the wild carding happens (the optional
thing would be a required thing if it changes behavior, for example on
Apple M CPUs to work around the PMU driver issue).

> I tried to summarize the issues concisely but may miss some issues.  I
> hope Ian can fill it up in case I missed something important.
>
> Can you please share your opinion about what would be the best behavior?

I'd very much appreciate guidance. This issue matters to me for
consistency, cleanliness, tech debt,.. but is strategic for RISC-V.
The series Namhyung linked to has the tags:
Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: James Clark <james.clark@linaro.org>
Tested-by: Leo Yan <leo.yan@arm.com>
Tested-by: Atish Patra <atishp@rivosinc.com>
It is reapplying a patch that lived on linux-next for weeks/months and
that should presumably mean that PowerPC and S390 are happy with it,
as they are very good at reporting issues when things have gone awry.
It carries a patch implementing Arnaldo's suggestion to make perf
record failing to open a warning rather than fatal. It is unusual that
patches in the perf tool have this level of review and this high
number of tags.

Thanks,
Ian
