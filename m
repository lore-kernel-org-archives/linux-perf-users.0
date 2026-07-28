Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486233B6C03;
	Tue, 28 Jul 2026 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785262415; cv=none; b=fddXW9GWOZIvlm+Kh2X/XlMSpyRCaBKIzGMEv6Qz+fw2fWl4Fa8j2PFZ8oo9dVIoq6Xx3aOWEq73wrbzlWEcw8NdH4PGqYukPzflMpOZDLvhMI0bnX+2310UlfglW462vCa31kKAk24n5WvVwZKK6aM6/2OFoHuCbyCuSCflmaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785262415; c=relaxed/simple;
	bh=uEDFpyTGCtWjQ7BSOFPxtwvo+Egdx/esALKCN1qI44Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnArV0FBvWQFYClEFeWXHYwIa3ODCYLHCINhqieYUlj0kpUXfVIbP7YloshcCAwLJyIMPek7ZD79rpeMXphDUTX8xwCzHMu9J8yzIwH1zTzPyJlz4Vlv0bRKPP3ZOYMA3l//qQHqze+cVZTX2Ij2Jd+4efmVK5Euc3+I461e7i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGq/MDJV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGq/MDJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE4D1F000E9;
	Tue, 28 Jul 2026 18:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785262413;
	bh=qyjBQkDJ5TF+y/lBab9r/Z4gDcbuAerljMiJYPWSW68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FGq/MDJVFr9UsuGtsqZWtbmrptWDqfEcY3t5tbI39L0PrvfPj8JuS+UUL/4a4PDOp
	 lJInV+qjOHm0IsNxlVyFRbFODhxrfYfPyYxb3v8vYTjW5MXb4/5Dfcd39B2DCMqYP3
	 cLQ3R6E3xWO5PbWDu0Rl2IICRdu0WgyGE8KsmUkqW6EPKLwq44Cwx8YMch77XS91cS
	 H4jpg3AQnkVS9pfhnafuEy7KrDOIFpVkYGHZ6f8RAkezK1kJHnjNpIpJf+zSyMNnce
	 GiI0/MOQYXHvVK3bdrsPIzketSUz3tHPZX5pKhrlijJ01sdlnLVrhw3g55BKSuOdLi
	 vx9cdlMrR4GQA==
Date: Tue, 28 Jul 2026 11:13:31 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jiebin Sun <jiebin.sun@intel.com>
Cc: acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org,
	mark.rutland@arm.com, dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com, tianyou.li@intel.com,
	wangyang.guo@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/9] perf c2c: add a function view
Message-ID: <amjxS3hcWlvQHerx@google.com>
References: <20260717020530.1645123-1-jiebin.sun@intel.com>
 <20260724095842.995920-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260724095842.995920-1-jiebin.sun@intel.com>

On Fri, Jul 24, 2026 at 05:58:33PM +0800, Jiebin Sun wrote:
> This series adds a new "function view" to perf c2c report, on top of the
> existing cacheline view. It does not change the cacheline view; it adds a
> second, complementary way to look at the same cache-to-cache (C2C) data.
> 
> v1: https://lore.kernel.org/linux-perf-users/20260626070355.1556721-1-jiebin.sun@intel.com/
> v2: https://lore.kernel.org/linux-perf-users/20260710084247.3576706-1-jiebin.sun@intel.com/
> v3: https://lore.kernel.org/linux-perf-users/20260717020530.1645123-1-jiebin.sun@intel.com/
> 
> Changes since v3
> ================
> 
> Reworked the function view into a true function-centric hierarchy, as
> discussed with Namhyung:
> 
>   - Level 1 is now the read-side function itself, aggregating all of its
>     code addresses into a single entry (v3 keyed level 1 on the code
>     address, which read like a "code-address view"). Suggested by
>     Namhyung.
> 
>   - Level 2 is the contending function that writes the shared lines
>     (causing the level-1 function's HITMs), aggregated across all the
>     cachelines it contends over and sorted by store count. Level 3 is
>     the specific cachelines. This lets a contending pair show its total
>     on one row, instead of repeating a writer under every cacheline and
>     leaving the reader to sum by hand.
> 
>   - Every level shows only functions and cachelines; code addresses and
>     offsets are no longer shown in the main view. They remain available
>     in the per-cacheline detail view ('d').
> 
>   - Lower-level entries are indented per hierarchy level, like the normal
>     perf report hierarchy view. Suggested by Namhyung.
> 
>   - Cachelines with no writing function, and functions left with no
>     contending writer, are pruned so the view shows only real contention.
> 
>   - Reorganized the series from 14 mechanical patches into 9 logically
>     self-contained ones (skeleton, column rendering, HPP parsing, stats
>     merge, entry creation, build/finalize, browser UI, doc).
> 
>   - Updated the perf-c2c man page example to the new layout.
> 
>   - Rebased onto the latest perf-tools-next.
> 
> Changes since v2
> ================
> 
>   - perf c2c: add a c2c_ prefix to the functions exported from
>     builtin-c2c.c (fmt_free() -> c2c_fmt_free(), fmt_equal() ->
>     c2c_fmt_equal()), so the shared symbols do not pollute the global
>     namespace. Suggested by Namhyung.
> 
> Changes since v1
> ================
> 
>   - Add the worked man-page example, as suggested by Namhyung.
> 
> What it does
> ============
> 
> In the perf c2c TUI, press TAB in the cacheline view to switch to the
> function view. It presents a 3-level hierarchy of the same data,
> organized around functions rather than cachelines:
> 
>   Level 1: the read-side function, sorted by Cycles % (estimated load
>            cycles: HITM, peer-snoop and other-load cycles -- on systems
>            whose default display mode is peer, such as Arm64, the
>            peer-snoop component dominates)
>   Level 2: the functions that write the shared lines, causing the
>            level-1 function's HITMs, sorted by store count
>   Level 3: the specific cachelines where the two functions contend
> 
> Every level shows functions and cachelines only; code addresses are not
> shown in the main view -- they remain available in the per-cacheline
> detail view ('d'). Each function aggregates all of its code addresses
> into a single entry, and a level-2 writer aggregates all of the
> cachelines it contends over, so a contending pair is a single row with
> its total shown.
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
> A level-1 function is expanded (press 'e') to reveal the functions that
> write the lines it reads, and one of those is expanded again to reveal
> the specific shared cachelines:
> 
>   Shared Data Functions Table     (18 entries, sorted on Cycles %)
>      Cycles    Store
>           %    count  Function / Contending function / Cacheline
>   ----------------------------------------------------------------------
>   -  16.54%      419  - [k] dequeue_pushable_task
>                  145    - [k] pull_rt_task
>                  145        0xff2d0082809da080
>                  139    - [k] enqueue_pushable_task
>                   70        0xff2d00a2071f9640
>                   69        0xff2d0082809da000
> 
> Here dequeue_pushable_task pays the read-side HITM penalty (16.54% of the
> estimated load cycles). It is contended by pull_rt_task and
> enqueue_pushable_task, which write the shared lines; enqueue_pushable_task
> contends over two cachelines but stays a single row with its total (139)
> shown, and the individual cachelines are underneath. This is the
> false-sharing chain that the cacheline view otherwise leaves to be
> reconstructed by hand.
> 
> Implementation
> ==============
> 
> The function view is a separate hist_browser in
> tools/perf/ui/browsers/c2c-function.c. Shared types and helpers used by
> both views are factored out of builtin-c2c.c into a new c2c.h. The
> hierarchy is constructed from the existing cacheline histograms into a
> dedicated set of hists and rendered with custom column formatters.
> 
> Testing
> =======
> 
>   - Each of the 9 commits builds individually and as a full series.
>   - perf c2c report --stdio (cacheline view) output is unchanged versus
>     the baseline.
>   - The function view was exercised on c2c recordings; the level-1
>     ordering and the level-2/3 sharing breakdown match the underlying
>     cacheline data.
> 
> Jiebin Sun (9):
>   perf c2c: extract shared data structures into c2c.h
>   perf c2c: add function view browser skeleton
>   perf c2c: add column rendering for function view
>   perf c2c: add HPP list parsing for function view columns
>   perf c2c: add function view stats merge and memory management
>   perf c2c: add function view hierarchy entry creation
>   perf c2c: build and finalize the function view hierarchy
>   perf c2c: add function view browser UI and cacheline detail
>   perf c2c: document function view in perf-c2c man page

Thanks for the update, I think it's almost ready to merge.  But can you
please address some sashiko review comments?

Thanks,
Namhyung

> 
>  tools/perf/Documentation/perf-c2c.txt |   46 +
>  tools/perf/builtin-c2c.c              |  132 +-
>  tools/perf/c2c.h                      |  154 +++
>  tools/perf/ui/browsers/Build          |    1 +
>  tools/perf/ui/browsers/c2c-function.c | 1789 +++++++++++++++++++++++++
>  5 files changed, 2002 insertions(+), 120 deletions(-)
>  create mode 100644 tools/perf/c2c.h
>  create mode 100644 tools/perf/ui/browsers/c2c-function.c
> 
> 
> base-commit: 87ec3437f37b9fe44c524ba967cb12e78de06f15
> -- 
> 2.52.0
> 
