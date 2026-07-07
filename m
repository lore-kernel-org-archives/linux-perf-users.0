Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2212DF719;
	Tue,  7 Jul 2026 00:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783384874; cv=none; b=pzB8ZAATHgMhAyTgvo7XYZp2hLHJ2eMZ7tGtSnOGUlLKmfVYo0fdkcNy26MwWNZv6Q5esTJCWqsxVu6Qa0pKHO2tmczbyWg1oXcdzl9pS13DHI4XlHShJM4iwHBZXZ8tKD9xGVAnD+nzZDfGFfDzUfs/O6Yy2s4IWVaJp6xSlpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783384874; c=relaxed/simple;
	bh=v0BCGdVydaBoTV3UHk+AWbitjZJJEJX2EQqTn7I9rcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqtM3KHttxJpujGmtupgPX1LnwhjfFwRblOOWnZp40tD0UWKbFU++F88lkqYmtBZNfjcEV27XcaQNsLMBc/TW4DO8vbti/czA2f6WUmGlIgLfx2/4NJLznJkjvtn1tegWlu7ozO1oTjHh2Da68/QwaMu3jVycdf2eFhBxH3GNaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfCENDXa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfCENDXa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0601F000E9;
	Tue,  7 Jul 2026 00:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783384872;
	bh=nmketAPUbIDMl1JeFEbngi32qQtn22lYiY3bU0EAe8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nfCENDXaxt7k6btB6TKIwHlWLOx+ASm7S8zWlvWG7I0inUksFF1s2ocrTQI7odzCp
	 RlzXa2WOFO0V1ZSJphlDY18QruJ0IpO0kLx1Qa7Fi1ISYQNEv7u8pFNSxU3JS9GvE7
	 cnmKLhqwKLmS2HcKSkCNHu7UDVTdgEH3E2scaM6jKg12Ozx1tNjjLSBH7iMb6tPDlZ
	 tq3mg21rCHCOKwKMN1Wnr+EeunZ6avrXMIsabtDlq86AajjHxW6mY4FHrADdJELKny
	 YrCBnd1Hc4W8zzndUv52XazEouc9P+zof1EA6ka/3T3mIcX617LkZseKgJGXNQ7V6A
	 8qUkYMuXL7ZFg==
Date: Mon, 6 Jul 2026 17:41:10 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jiebin Sun <jiebin.sun@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Tianyou Li <tianyou.li@intel.com>,
	Wangyang Guo <wangyang.guo@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] perf c2c: add a function view
Message-ID: <akxLJvJvkD022Trl@google.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260626070355.1556721-1-jiebin.sun@intel.com>

Hello,

On Fri, Jun 26, 2026 at 03:03:41PM +0800, Jiebin Sun wrote:
> This series adds a new "function view" to perf c2c report, on top of the
> existing cacheline view. It does not change the cacheline view; it adds a
> second, complementary way to look at the same cache-to-cache (C2C) data.

Thanks for working on this.

> 
> Motivation
> ==========
> 
> The existing perf c2c report is organized by cacheline: it lists the most
> contended cachelines and the symbols touching each one. That answers
> "which cachelines are hot", but two common follow-up questions are harder
> to answer directly:
> 
>   - Which functions are contending with each other?
>   - For a given function, which other functions does it share cachelines
>     with, and over which specific cachelines?
> 
> The function view reorganizes the same data around functions to answer
> these directly, which is useful when chasing false sharing and cross-core
> contention at the source-function level.
> 
> What it does
> ============
> 
> In the perf c2c TUI, press TAB in the cacheline view to switch to the
> function view. It presents a 3-level hierarchy:
> 
>   Level 1: primary functions, sorted by Cycles % (estimated load cycles:
>            HITM, peer-snoop and other-load cycles -- on systems whose
>            default display mode is peer, such as Arm64, the peer-snoop
>            component dominates)
>   Level 2: other functions that share cachelines with the level-1 function
>   Level 3: the specific shared cachelines for each function pair
> 
> Keys in the function view:
>   TAB/ESC/q   return to the cacheline view
>   d           show cacheline details for the selected entry
>   e / +       expand / collapse the selected entry
>   ?           help
> 
> The cacheline view and the --stdio output are unchanged.
> 
> Example
> =======
> 
> A level-1 function is expanded (press 'e') to reveal the functions it
> shares cachelines with, and one of those is expanded again to reveal the
> specific shared cachelines:
> 
>   Shared Data Functions Table   (27 entries, sorted on Cycles %)
>    Cycles  Store
>         %  count  Code address        Symbol           Cacheline
>   ----------------------------------------------------------------------
>   - 39.03%   541  - 0xffffffffa2fc5b08  - [k] cpupri_set
>              450  - 0xffffffffa2fa28a5  - [k] pull_rt_task
>              450                                      0xff2d0082809da080
> 
> Reading the three levels:
> 
>   - Level 1: cpupri_set is the top contended function, accounting for
>     39.03% of the estimated load cycles. The table is sorted by this
>     Cycles % column.
>   - Level 2: expanding cpupri_set (press 'e') lists the functions it
>     shares cachelines with, sorted by store count. Here pull_rt_task is
>     the contending function, with 450 stores into the shared data.
>   - Level 3: expanding pull_rt_task lists the specific cachelines the two
>     functions contend over -- in this case the single cacheline at
>     0xff2d0082809da080.
> 
> The view reads top-down as "cpupri_set is hottest; it shares data with
> pull_rt_task; the contention is on cacheline ...da080" -- the false-
> sharing chain that the cacheline view otherwise makes you reconstruct by
> hand.

It'd be great if you can add this to the documentation.

> 
> Implementation
> ==============
> 
> The function view is built as a separate hist_browser in
> tools/perf/ui/browsers/c2c-function.c. Shared types and helpers used by
> both views are factored out of builtin-c2c.c into a new c2c.h. The
> hierarchy is constructed from the existing cacheline histograms into a
> dedicated set of hists, keyed by (symbol, instruction address), and
> rendered with custom column formatters.
> 
> The series is split into 14 small, self-contained patches so each step
> can be reviewed and builds on its own.

Some high level comments.

It seems perf c2c adds more and more functionality similar to regular
perf report like hierarchy view.  Any chance it can share the code?  We
have `perf mem report` as well, which deals with similar kind of data.

Also data type profiling would give more meaningful data once DWARF is
available.  It'd be nice if c2c could support the type analysis or c2c
could be implemented on top of `perf mem report` which already supports
the data type profiling.

Thanks,
Namhyung

> 
> Testing
> =======
> 
>   - Each of the 14 commits builds individually and as a full series.
>   - perf c2c report --stdio (cacheline view) output is unchanged versus
>     the baseline: identical trace-event totals, shared-cacheline counts,
>     and HITM tallies.
>   - The function view was exercised on c2c recordings; the level-1
>     ordering and the level-2/3 sharing breakdown match the underlying
>     cacheline data.
> 
> Jiebin Sun (14):
>   perf c2c: extract shared data structures into c2c.h
>   perf c2c: add function view browser skeleton
>   perf c2c: add function view type definitions and helpers
>   perf c2c: add column format infrastructure for function view
>   perf c2c: add column entry functions for function view
>   perf c2c: add comparison functions for function view sorting
>   perf c2c: add dimension definitions and format creation
>   perf c2c: add HPP list parsing for function view histograms
>   perf c2c: add stats merging and memory management helpers
>   perf c2c: add hierarchy entry creation and lookup functions
>   perf c2c: add function view hierarchy builder
>   perf c2c: add function view browser UI
>   perf c2c: add TAB key to switch to function view
>   perf c2c: document function view in perf-c2c man page
> 
>  tools/perf/Documentation/perf-c2c.txt |   15 +
>  tools/perf/builtin-c2c.c              |  128 +-
>  tools/perf/c2c.h                      |  140 +++
>  tools/perf/ui/browsers/Build          |    1 +
>  tools/perf/ui/browsers/c2c-function.c | 1547 +++++++++++++++++++++++++
>  5 files changed, 1713 insertions(+), 118 deletions(-)
>  create mode 100644 tools/perf/c2c.h
>  create mode 100644 tools/perf/ui/browsers/c2c-function.c
> 
> base-commit: 40db90ac9f66c8246c1746c56d397283d161655c
> --
> 2.52.0
