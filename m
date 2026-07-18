Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510A2231C91;
	Sat, 18 Jul 2026 04:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784350711; cv=none; b=YC/BzYciOuGRubqjmgves22W6vVnV3x8A79jJle5H0hCvntmlD3U1dLHphJgJfbdXOz8K6Z+/qKOv2Xwz/lO3Pe1MEDAURZZBqwJ9/rby9xGy9g7DQM28eSOKYujmGwo+nJOMKvfE2SwnVl/Txfp1SlRGCCtAVcu5/lK14SrZQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784350711; c=relaxed/simple;
	bh=NsyfsI8jqYmyYFduLaMlSdkDYbvzpsIObOSiUvfL/Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJps0Py461RIjDuKIz25jszvhhgnIeABOyW+ghL8mw3UckCnv0Mm3vNadP7lNJJHhfiKaJXx3b+jQKEN+Z6K4S5CU2Aa3CHoW8EvCYT+gvT736MFTL2rAzb2T1pvbaLDx0GHlywtp/t53TTdsP5kYJh3Q5c3MRiDDy2RbmH140g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3jqMdoK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3jqMdoK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FCE1F000E9;
	Sat, 18 Jul 2026 04:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784350710;
	bh=ET2+fc947Tu+uL6cfp+TEnoUMgo7QJOB5FbVepwLTXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L3jqMdoKj4O0hJXqtnvex4ghMJqlIeGEC7isl7/8Xxp1zqftiRFYgAEXkdRIS6ptz
	 VlF0sRg5fg/lYp20EX3S1n7Qnux+HeuwA6LgrbWEpnSq1V3KuRFZ8irYD7jb4dy9up
	 GYQQ3fhefE4wrT7+Yw0ydED2B1jD1gMcXyZZmJTMyUUs8J9kz+eEmgLUYnSGIAcJ7k
	 gYtysnoyDux3QvAfMxzgxxR+L5mfblLIboQuKnYa8kZYLnLlK5p0FiVHXgtn29AN2D
	 soAsN9VZx6DOruaNzf8lyeBRqwoqAxoqqphZl0VAvIYtlA7CWqtMSWHIb6A+wBVa/e
	 NJLvJ3ZJJbKPA==
Date: Fri, 17 Jul 2026 21:58:28 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jiebin Sun <jiebin.sun@intel.com>
Cc: acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, tianyou.li@intel.com,
	wangyang.guo@intel.com, dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/14] perf c2c: add a function view
Message-ID: <alsH9PFMljK5eUEJ@z2>
References: <20260710084247.3576706-1-jiebin.sun@intel.com>
 <20260717020530.1645123-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260717020530.1645123-1-jiebin.sun@intel.com>

On Fri, Jul 17, 2026 at 10:05:16AM +0800, Jiebin Sun wrote:
> This series adds a new "function view" to perf c2c report, on top of the
> existing cacheline view. It does not change the cacheline view; it adds a
> second, complementary way to look at the same cache-to-cache (C2C) data.
> 
> v1: https://lore.kernel.org/linux-perf-users/20260626070355.1556721-1-jiebin.sun@intel.com/
> v2: https://lore.kernel.org/linux-perf-users/20260710084247.3576706-1-jiebin.sun@intel.com/
> 
> Changes since v2
> ================
> 
>   - perf c2c: add a c2c_ prefix to the functions exported from
>     builtin-c2c.c for the function view, so the shared symbols do not
>     pollute the global namespace: fmt_free() -> c2c_fmt_free() and
>     fmt_equal() -> c2c_fmt_equal(). Suggested by Namhyung.
> 
>   - perf c2c: free the two top-level function-view hists with
>     hists__delete_all_entries() as well, so entries left in the
>     input/collapsed trees are not leaked.
> 
>   - perf c2c: drop a redundant reset_dimensions() call, free the
>     registered formats on a mid-parse failure in the function-view HPP
>     list parser, and add a missing newline to a pr_err() message.
> 
>   - Rebased onto the latest perf-tools-next.
> 
> Changes since v1
> ================
> 
>   - Add the worked example (the cpupri_set/pull_rt_task walk-through) to
>     the perf-c2c man page, as suggested by Namhyung.
> 
>   - Rebased onto the latest perf-tools-next.
> 
>   - perf c2c: cache the level-1 total-stores sum (new child_stores field)
>     instead of walking the children on every comparison. total_stores_cmp()
>     is called during collapse/sort, so the previous O(children) walk was an
>     O(N*M log N) bottleneck on large profiles.
> 
>   - perf c2c: free the function-view sub-hists with
>     hists__delete_all_entries() instead of hists__delete_entries(), so
>     entries still in the input/collapsed trees are not leaked, matching the
>     cleanup in builtin-c2c.c.
> 
>   - perf c2c: distinguish -ENOMEM from "unknown dimension" in
>     get_function_format(), so an allocation failure is no longer
>     misreported as an "Invalid c2c function-view field".
> 
>   - perf c2c: reword the iaddr_symbol_cmp() sort-order comment to drop the
>     ambiguous ascending/descending wording.
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

I think it's more like "code-address" view rather than "function" view.
How about organizing the output something like below?

  L1:  function
  L2:  cache line
  L3:  shared functions

or

  L1:  function
  L2:  code address
  L3:  cache line
  L4:  shared functions

A function can have multiple entries with different code addresses and
cache lines.  They can be grouped together for better analysis.

Also, I think you'd better to indent output for lower level entries to
clearly separate entries from others like in the normal perf report
hierarchy view.  Something like this.

  Shared Data Functions Table   (27 entries, sorted on Cycles %)
   Cycles  Store
        %  count  Code address        Symbol           Cacheline
  ----------------------------------------------------------------------
  - 39.03%   541  - 0xffffffffa2fc5b08  - [k] cpupri_set
             450  - 0xffffffffa2fa28a5    - [k] pull_rt_task            <<<-- here
             450                                      0xff2d0082809da080
	     ...                        + [k] other_func

Thanks,
Namhyung

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
>  tools/perf/Documentation/perf-c2c.txt |   33 +
>  tools/perf/builtin-c2c.c              |  132 +--
>  tools/perf/c2c.h                      |  148 +++
>  tools/perf/ui/browsers/Build          |    1 +
>  tools/perf/ui/browsers/c2c-function.c | 1562 +++++++++++++++++++++++++
>  5 files changed, 1756 insertions(+), 120 deletions(-)
>  create mode 100644 tools/perf/c2c.h
>  create mode 100644 tools/perf/ui/browsers/c2c-function.c
> 
> 
> base-commit: 3f7909fa921e38b7aba8566b03ca5e0754a8fa8b
> -- 
> 2.52.0
> 
