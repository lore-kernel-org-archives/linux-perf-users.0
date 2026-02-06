Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F67303A1A;
	Fri,  6 Feb 2026 22:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770416021; cv=none; b=tGQfS8iOTv9usOBwFGY7tMUuP/uo+PoebeSagP6GOSmcudbHGTlGkBofumXTkDvhfWzB19pcXZC5RidGo2uSCwbZJnTgw6V575OicUraQ2Wj/x0o0dCKXCEJdl8A7I9ICVO1rVA/lJxD84M5Ljf4+Onf7IaQLrS81N2ZETk3wXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770416021; c=relaxed/simple;
	bh=M19xwhQO/96t1ks9C85jkg/3Lu7l6HsRTkSysNlo29I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irrc4bxhjXJC9CnIIL5KvDCxGZc4LkMP0XvNzfvR8PfMu1XpoIt5bZ9Heil3upUVvTMp8TKeDk5zGYuDsDWyfAMpOtDGSqkZ8aNwgfE6dO5Xym/eLGMdlj2ERBxmqtD9qOz1e3DYXGMhccKFpvKOzqURVibDnjN9I4CmgEwekQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhCeDE8a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhCeDE8a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B0BC116C6;
	Fri,  6 Feb 2026 22:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770416021;
	bh=M19xwhQO/96t1ks9C85jkg/3Lu7l6HsRTkSysNlo29I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OhCeDE8aZL9qQeVpLNwlgRvxG7ozAD2XQFyAhvLs3ynjPFDQ7SzF/5RZAanc9shmt
	 B4pl02cMIqa6wPJr3Zi9IH7Q3xklXW4gqcnVgFHmogIXDJ0fwOAg6FiuiZs7laBjYG
	 1YVYXCdCxU5Nba2bPKJsc/04GtVz5XjK5gZqDRIwUzAZVMqdkv+0mW62zyvCSuEGpX
	 kJ8++Rp78+FQY0d7D/hzSVwKhUigoZxk1Zegcp//p6XADbqcnoELyQvCvr9vWDXaUZ
	 XrBoli0Cb7GPB72BzGtHpzGG2a1W/5OYwP2tm47VFQpNkm4dpdQ3XmJR2sGdpVz/71
	 2W/4s9+qb4Zvw==
Date: Fri, 6 Feb 2026 19:13:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Andres Freund <andres@anarazel.de>
Subject: Re: [PATCH v7 0/6] perf stat affinity changes
Message-ID: <aYZnkYqWXnKpHd3h@x1>
References: <20260203225129.4077140-1-irogers@google.com>
 <aYZeuP5NlZ4gFacx@x1>
 <CAP-5=fVKn5HSxKPDBrmVXchRu9HAL3Nb7ikKptKejHMOxR-yMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVKn5HSxKPDBrmVXchRu9HAL3Nb7ikKptKejHMOxR-yMg@mail.gmail.com>

On Fri, Feb 06, 2026 at 02:01:37PM -0800, Ian Rogers wrote:
> On Fri, Feb 6, 2026 at 1:35 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > On Tue, Feb 03, 2026 at 02:51:23PM -0800, Ian Rogers wrote:
> > > Change how affinities work with evlist__for_each_cpu. Move the
> > > affinity code into the iterator to simplify setting it up. Detect when
> > > affinities will and won't be profitable, for example a tool event and
> > > a regular perf event (or read group) may face less delay from a single
> > > IPI for the event read than from a call to sched_setaffinity. Add a
> > >  --no-affinity flag to perf stat to allow affinities to be disabled.
> > >
> > > v7: Revert "perf tool_pmu: More accurately set the cpus for tool
> > >     events" that caused issues with user specified CPUs (Andres Freund
> > >     <andres@anarazel.de>). Fix a null test is prepare_metric so that
> > >     missing events can't trigger segfaults (Andres Freund). Make the
> > >     CPU map propagation improve the CPU maps for tool events that only
> > >     read on index 0, this allows later setting when
> > >     evlist__create_maps is called with the correct user CPUs. Rebase
> > >     previous non-merged affinity changes that hadn't been picked up
> > >     yet.
> >
> > Not applying to tmp.perf-tools-next, can you please check?
> 
> Will send a rebase on tmp.perf-tools-next shortly.

Thanks!

> Could I interest you in some second servings of build improvements
> while you wait? :-)
> https://lore.kernel.org/lkml/20260203164323.3447826-1-irogers@google.com/

Applied it locally for testing,

- Arnaldo
 
> Thanks,
> Ian
> 
> > - Arnaldo
> >
> > > v6: Drop merged tool event change. Move TPEBS fix into its own patch
> > >     1st.
> > > https://lore.kernel.org/lkml/20260108212652.768875-1-irogers@google.com/
> > >
> > > v5: Drop merged changes. Move tool event reading to first
> > >     patch. Change --no-affinity flag to --affinity/--no-affinity flag.
> > > https://lore.kernel.org/lkml/20251118211326.1840989-1-irogers@google.com/
> > >     On v5 there was discussion with Andi Kleen who points out that
> > >     affinities will work better with real time priorities but using
> > >     this requires privileges.
> > >
> > > v4: Rebase. Add patch to reduce scope of walltime_nsec_stats now that
> > >     the legacy metric code is no more. Minor tweak to the ru_stats
> > >     clean up.
> > > https://lore.kernel.org/lkml/20251113180517.44096-1-irogers@google.com/
> > >
> > > v3: Add affinity clean ups and read tool events last.
> > > https://lore.kernel.org/lkml/20251106071241.141234-1-irogers@google.com/
> > >
> > > v2: Fixed an aggregation index issue:
> > > https://lore.kernel.org/lkml/20251104234148.3103176-2-irogers@google.com/
> > >
> > > v1:
> > > https://lore.kernel.org/lkml/20251104053449.1208800-1-irogers@google.com/
> > >
> > > Ian Rogers (6):
> > >   Revert "perf tool_pmu: More accurately set the cpus for tool events"
> > >   perf stat-shadow: In prepare_metric fix guard on reading NULL
> > >     perf_stat_evsel
> > >   perf evlist: Special map propagation for tool events that read on 1
> > >     CPU
> > >   perf evlist: Missing TPEBS close in evlist__close
> > >   perf evlist: Reduce affinity use and move into iterator, fix no
> > >     affinity
> > >   perf stat: Add no-affinity flag
> > >
> > >  tools/lib/perf/evlist.c                 |  36 +++++-
> > >  tools/lib/perf/include/internal/evsel.h |   2 +
> > >  tools/perf/Documentation/perf-stat.txt  |   4 +
> > >  tools/perf/builtin-stat.c               | 114 ++++++++---------
> > >  tools/perf/util/evlist.c                | 156 +++++++++++++++---------
> > >  tools/perf/util/evlist.h                |  27 ++--
> > >  tools/perf/util/parse-events.c          |  10 +-
> > >  tools/perf/util/pmu.c                   |  23 ++++
> > >  tools/perf/util/pmu.h                   |   3 +
> > >  tools/perf/util/stat-shadow.c           |   7 +-
> > >  tools/perf/util/tool_pmu.c              |  19 ---
> > >  tools/perf/util/tool_pmu.h              |   1 -
> > >  12 files changed, 237 insertions(+), 165 deletions(-)
> > >
> > > --
> > > 2.53.0.rc2.204.g2597b5adb4-goog
