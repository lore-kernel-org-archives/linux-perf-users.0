Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC92173;
	Tue,  3 Jun 2025 04:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748924586; cv=none; b=kMNBzYpMoo9zZQump8bTDvf9Q5B/MyM9HMn3pqFYXoD66LqfBZQs8OO6RSfIJT3gs4ruTeBbcHM8EQ5At+QhVJTzWVE4hDyI6lekw4ZW+SmoPag1NnfN6JSVOXbFjGW6ii/uRniO7jzM/X//N47V/kq6Ii0t7d5MgvjhWabf2fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748924586; c=relaxed/simple;
	bh=fAIqxszTFaRSQwf9tqRraJopPW6o0lcu1sGqdzjJGLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7SaL1ZQQLre1T+JId66ZI4viqVwqqFe6MGTTmAwph5oQGjUQOSR1szGvqbQ3nHVFVaiqg7yHCAYmkzKDRgmJPbl37aJVLsgv7ZmOrNONcU4up70BbXG10Hjur+uIhlvEEIVmB8mxNrIGevRG0Gao5YrkIACQkfexne8rRbCu8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJFcCukn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJFcCukn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4358C4CEED;
	Tue,  3 Jun 2025 04:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748924584;
	bh=fAIqxszTFaRSQwf9tqRraJopPW6o0lcu1sGqdzjJGLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eJFcCuknik4v5REUzKqnTizBgpZbx97Fkb3RQvCBbm3jS/Vgs87/GXVkOS6q9A/yo
	 2L427cxLjnQ3zOAhYODyf7c9iP8uFYRZuZMG4vymqZQWTeWSoI2z9NpdYRCMpxVMzt
	 ZdguiuclP+5ZUHLayqeyO8bgS75m6wpinYUAjM7+ZE8vnsWX3kKdIjsmHsCgX3Lcpv
	 A2iygk15wHHW8QYRYxIzPhr5AcQCrLSvhqa3qSJ6dUEkA02X/lL7nM+kAbOTxFUvWf
	 g9qqwxzLXPDwIHiCxotV8yndYfymT0WpWreAFKRsEkQj2xTHQ9L/gWCoCht26BhFUK
	 2eZQh5NNZCi8w==
Date: Mon, 2 Jun 2025 21:23:02 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v8 0/4] Prefer sysfs/JSON events also when no PMU is
 provided
Message-ID: <aD54ptuIFHcKPkRQ@google.com>
References: <20250416045117.876775-1-irogers@google.com>
 <CAP-5=fU3VW1MjHMiaPG+JirLCCunMC6bEWpsJ3h0E7bTDkh9cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU3VW1MjHMiaPG+JirLCCunMC6bEWpsJ3h0E7bTDkh9cA@mail.gmail.com>

Hi Ian,

On Tue, May 27, 2025 at 01:50:32PM -0700, Ian Rogers wrote:
> On Tue, Apr 15, 2025 at 9:51 PM Ian Rogers <irogers@google.com> wrote:
> >
> > At the RISC-V summit the topic of avoiding event data being in the
> > RISC-V PMU kernel driver came up. There is a preference for sysfs/JSON
> > events being the priority when no PMU is provided so that legacy
> > events maybe supported via json. Originally Mark Rutland also
> > expressed at LPC 2023 that doing this would resolve bugs on ARM Apple
> > M? processors, but James Clark more recently tested this and believes
> > the driver issues there may not have existed or have been resolved. In
> > any case, it is inconsistent that with a PMU event names avoid legacy
> > encodings, but when wildcarding PMUs (ie without a PMU with the event
> > name) the legacy encodings have priority.
> >
> > The situation is further inconsistent as legacy events are case
> > sensitive, so on Intel that provides a sysfs instructions event, the
> > instructions event without a PMU and lowercase is legacy while with
> > uppercase letters it matches with sysfs which is case insensitive. Are
> > there legacy events with upper case letters? Yes there are, the cache
> > ones mix case freely:
> >
> > L1-dcache|l1-d|l1d|L1-data|L1-icache|l1-i|l1i|L1-instruction|LLC|L2|dTLB|d-tlb|Data-TLB|iTLB|i-tlb|Instruction-TLB|branch|branches|bpu|btb|bpc|node
> >
> > meaning LLC that means L2 (which is wrong) both match as part of a
> > legacy cache name but llc and l2 would only match sysfs/json
> > events. The whole thing just points at the ridiculous nature of legacy
> > events and why we'd want them to be preffered I don't know. Why should
> > case of a letter or having a PMU prefix impact the encoding in the
> > perf_event_attr?
> >
> > The patch doing this work was reverted in a v6.10 release candidate
> > as, even though the patch was posted for weeks and had been on
> > linux-next for weeks without issue, Linus was in the habit of using
> > explicit legacy events with unsupported precision options on his
> > Neoverse-N1. This machine has SLC PMU events for bus and CPU cycles
> > where ARM decided to call the events bus_cycles and cycles, the latter
> > being also a legacy event name. ARM haven't renamed the cycles event
> > to a more consistent cpu_cycles and avoided the problem. With these
> > changes the problematic event will now be skipped, a large warning
> > produced, and perf record will continue for the other PMU events. This
> > solution was proposed by Arnaldo.
> >
> > v8: Change removing of failed to open events that are tracking so that
> >     the tracking moves to the next event. Make software events able to
> >     specified with a PMU. Change the perf_api_probe to not load all
> >     PMUs through scanning, specify a PMU when parsing events.
> >
> > v7: Expand cover letter, fix a missed core_ok check in the v6
> >     rebase. Note, as with v6 there is an alternate series that
> >     prioritizes legacy events but that is silly and I'd prefer we
> >     didn't do it.
> >
> > v6: Rebase of v5 (dropping already merged patches):
> >     https://lore.kernel.org/lkml/20250109222109.567031-1-irogers@google.com/
> >     that unusually had an RFC posted for it:
> >     https://lore.kernel.org/lkml/Z7Z5kv75BMML2A1q@google.com/
> >     Note, this patch conflicts/contradicts:
> >     https://lore.kernel.org/lkml/20250312211623.2495798-1-irogers@google.com/
> >     that I posted so that we could either consistently prioritize
> >     sysfs/json (these patches) or legacy events (the other
> >     patches). That lack of event printing and encoding inconsistency
> >     is most prominent in the encoding of events like "instructions"
> >     which on hybrid are reported as "cpu_core/instructions/" but
> >     "instructions" before these patches gets a legacy encoding while
> >     "cpu_core/instructions/" gets a sysfs/json encoding. These patches
> >     make "instructions" always get a sysfs/json encoding while the
> >     alternate patches make it always get a legacy encoding.
> >
> > v5: Follow Namhyung's suggestion and ignore the case where command
> >     line dummy events fail to open alongside other events that all
> >     fail to open. Note, the Tested-by tags are left on the series as
> >     v4 and v5 were changing an error case that doesn't occur in
> >     testing but was manually tested by myself.
> >
> > v4: Rework the no events opening change from v3 to make it handle
> >     multiple dummy events. Sadly an evlist isn't empty if it just
> >     contains dummy events as the dummy event may be used with "perf
> >     record -e dummy .." as a way to determine whether permission
> >     issues exist. Other software events like cpu-clock would suffice
> >     for this, but the using dummy genie has left the bottle.
> >
> >     Another problem is that we appear to have an excessive number of
> >     dummy events added, for example, we can likely avoid a dummy event
> >     and add sideband data to the original event. For auxtrace more
> >     dummy events may be opened too. Anyway, this has led to the
> >     approach taken in patch 3 where the number of dummy parsed events
> >     is computed. If the number of removed/failing-to-open non-dummy
> >     events matches the number of non-dummy events then we want to
> >     fail, but only if there are no parsed dummy events or if there was
> >     one then it must have opened. The math here is hard to read, but
> >     passes my manual testing.
> >
> > v3: Make no events opening for perf record a failure as suggested by
> >     James Clark and Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>. Also,
> >     rebase.
> >
> > v2: Rebase and add tested-by tags from James Clark, Leo Yan and Atish
> >     Patra who have tested on RISC-V and ARM CPUs, including the
> >     problem case from before.
> 
> Ping. Thanks,
> Ian
> 
> > Ian Rogers (4):
> >   perf record: Skip don't fail for events that don't open
> >   perf parse-events: Reapply "Prefer sysfs/JSON hardware events over
> >     legacy"
> >   perf parse-events: Allow software events to be terms
> >   perf perf_api_probe: Avoid scanning all PMUs, try software PMU first

Sorry for the delay.  But I think we wanted to move to this instead:

https://lore.kernel.org/linux-perf-users/20250312211623.2495798-1-irogers@google.com/

Thanks,
Namhyung

> >
> >  tools/perf/builtin-record.c      | 63 +++++++++++++++++++---
> >  tools/perf/util/parse-events.c   | 47 +++++++++++++----
> >  tools/perf/util/parse-events.h   |  3 +-
> >  tools/perf/util/parse-events.l   | 90 ++++++++++++++++++--------------
> >  tools/perf/util/parse-events.y   | 85 ++++++++++++++++++++++--------
> >  tools/perf/util/perf_api_probe.c | 27 +++++++---
> >  tools/perf/util/pmu.c            |  9 ++--
> >  7 files changed, 235 insertions(+), 89 deletions(-)
> >
> > --
> > 2.49.0.777.g153de2bbd5-goog
> >
