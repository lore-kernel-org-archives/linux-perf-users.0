Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E7346AA76;
	Tue,  4 Aug 2026 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863774; cv=none; b=QVilxGvngPJleryUwbtkVrC30malBO5Mh/KqhGQQAEWHHbePri7we0avbKvBvvjDktZ4ghb1berI2CDWnim8AuUaPAORNVyHWghVqBS3PGKV6uOEES23mjzm14C4JhmP8+BAgdkCSFSMct6RvTl8WvDrhEriMHBKjsft+3aMHdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863774; c=relaxed/simple;
	bh=+UhG3zAbCzryuhJl5ulcHn4rRXU7jh8zBKSUT7+NM0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ux1Sqixl9GsuCunvDqqXiSJlcHQjHGmyGmq0zplhV9mc/8i9VJHGIQ3vyGHDDWqcAEJW9HZOfMZiafj3CRka+eWkUUTgS+wC56GuFapBCoWMCvVzlB1II67BF4Rm9jegv4coBZo2wjpVBDjWMlGCHosQJLv8BcBYCLpvCXInD2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVsEqxER; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVsEqxER"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0582B1F000E9;
	Tue,  4 Aug 2026 17:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785863762;
	bh=7sNZpEQ0zMR1Ta0y6y9ln6xHRlY7xpsNchHx3GFDdME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gVsEqxERy5tKiimCIoGtPqXMpE+prx4NpFwbJVR8CX8wSUQn/rJYZMeaC1uVyJ2Xs
	 aDCbTSPk4RDUIuENyUIS6hsIagIEzNVWU7FcyNpRDsJ22B7qEYTNJgeXZVA/Fgqyl4
	 7TpniFDr1nPl3lJo5lqT8/GmTVAOUpmX7DUBYAZruGUvisliBBp34lUr37u9469Wl9
	 z8nScm4SMJAx3QcaanSm9zkLOIcJ0tNTBNhoD9ZD4uYJV7TH6E0H0bAS2W27pIhnhw
	 +Stqa+PeNevSRLakRAY3wGgk/dzQdthjAVetT5mD5nzjQNtF1JOztebu3F2Dcr9No/
	 cqf2WSnD/yJdg==
Date: Tue, 4 Aug 2026 10:15:59 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jiebin Sun <jiebin.sun@intel.com>
Cc: acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org,
	mark.rutland@arm.com, dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com, tianyou.li@intel.com,
	wangyang.guo@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/9] perf c2c: add a function view
Message-ID: <anIeT4yBy6WX2ky5@google.com>
References: <20260803035220.172022-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260803035220.172022-1-jiebin.sun@intel.com>

Hello,

On Mon, Aug 03, 2026 at 11:52:11AM +0800, Jiebin Sun wrote:
> This series adds a new "function view" to perf c2c report, on top of the
> existing cacheline view. Existing cacheline-view data and operations remain
> unchanged; TAB adds access to a complementary way to inspect the same
> cache-to-cache (C2C) data.
> 
> v1: https://lore.kernel.org/linux-perf-users/20260626070355.1556721-1-jiebin.sun@intel.com/
> v2: https://lore.kernel.org/linux-perf-users/20260710084247.3576706-1-jiebin.sun@intel.com/
> v3: https://lore.kernel.org/linux-perf-users/20260717020530.1645123-1-jiebin.sun@intel.com/
> v4: https://lore.kernel.org/linux-perf-users/20260724095842.995920-1-jiebin.sun@intel.com/
> v5: https://lore.kernel.org/linux-perf-users/20260730090521.2206375-1-jiebin.sun@intel.com/
> 
> Changes since v5
> ================
> 
>   - Give the function-view children their own references instead of
>     borrowing them, as suggested by Namhyung. They set ops and take refs
>     via map_symbol__copy() and thread__get(), so hist_entry__delete()
>     frees them; the custom child destructor and the
>     WARN_ON_ONCE(report_hierarchy) guard are gone.
> 
>   - Add NO_SLANG stubs for the two TUI entry points declared in c2c.h,
>     matching how util/hist.h declares its own.
> 
>   - Spell out in the symbol renderer why the length returned by
>     se_snprintf() cannot exceed the cell.
> 
>   - Rebase onto perf-tools-next at d04ef71492fa.
> 
> No intended change to the rendered output, cacheline-view data, existing
> cacheline operations, or --stdio output.

I'm about to merge the series.  But please consider a follow-up work to
add support for --stdio and add a test case.

Thanks,
Namhyung


> 
> Changes since v4
> ================
> 
>   - Rebase onto perf-tools-next at 0d40fedcd1b9.
> 
>   - Require `iaddr` in --coalesce before entering the function view;
>     without it, coalesced samples cannot be reliably attributed.
> 
>   - Reuse each source cacheline's existing index as the level-3 identity,
>     so same-address sources no longer merge and 'd' finds the original
>     entry, without adding fields to the shared C2C structures.
> 
>   - Keep same-function reader/writer pairs, which the coalesced view cannot
>     reliably tell apart from cross-thread contention.
> 
>   - Robustness and cleanup: build the hierarchy only from filtered
>     cachelines with a lightweight entry allocator; explicit
>     mem_info__new() handling; a local bound in the symbol renderer; a
>     NULL-map guard; deterministic tie-breaks; function-view-local row
>     recounting; Ctrl-C as an exit key; and expanded man-page docs.
> 
> Changes since v3
> ================
> 
> Reworked the function view into a true function-centric hierarchy, as
> discussed with Namhyung:
> 
>   - Level 1 is the read-side function itself, aggregating all of its code
>     addresses into one entry and sorting by Cycles %.
> 
>   - Level 2 is the contending function that writes the shared lines,
>     aggregated across cachelines and sorted by store count. Level 3 is the
>     specific cachelines.
> 
>   - Dedicated code-address and offset columns were removed from the main
>     view. Verbose function formatting can still include a representative
>     code address, and full code-address information remains available in
>     the per-cacheline detail view ('d').
> 
>   - Lower-level entries are indented like the normal perf report hierarchy
>     view, and entries with no contending writer are pruned.
> 
>   - Reorganized the series from 14 mechanical patches into 9 logically
>     self-contained patches.
> 
> Changes since v2
> ================
> 
>   - Prefix helpers exported from builtin-c2c.c with c2c_, as suggested by
>     Namhyung.
> 
> Changes since v1
> ================
> 
>   - Add a worked man-page example, as suggested by Namhyung.
> 
> In the perf c2c TUI, press TAB in the cacheline view to switch to the
> function view. It presents a three-level hierarchy:
> 
>   Level 1: read-side function, sorted by Cycles %
>   Level 2: functions writing the shared lines, sorted by store count
>   Level 3: cachelines where the two functions contend
> 
> For example, with dequeue_pushable_task expanded to its level-2 writers and
> two of those writers expanded to their level-3 cachelines:
> 
>   Shared Data Functions Table     (19 entries, sorted on Cycles %)
>      Cycles    Store
>           %    count  Function / Contending function / Cacheline
>   ----------------------------------------------------------------------
>   +  35.67%      876  + [k] cpupri_set
>   +  24.31%      424  + [k] pull_rt_task
>   -  16.53%      555  - [k] dequeue_pushable_task
>                  145    - [k] pull_rt_task
>                  145        0xff2d0082809da080
>                  139    - [k] enqueue_pushable_task
>                   70        0xff2d00a2071f9640
>                   69        0xff2d0082809da000
> 
> A level-1 store count decomposes into its level-2 writers, and each writer's
> count decomposes into its level-3 cachelines (here 145 = 145, 139 = 70 + 69).
> 
> Keys in the function view:
> 
>   TAB/ESC/q/Ctrl-C   return to the cacheline view
>   d                  show details for the selected level-3 cacheline
>   e / +              expand / collapse the selected entry
>   ?                  help
> 
> The function view is a separate hist_browser in
> tools/perf/ui/browsers/c2c-function.c. Shared types and helpers used by
> both views are factored out of builtin-c2c.c into c2c.h. The hierarchy is
> constructed from the existing cacheline histograms into dedicated hists
> and rendered with custom column formatters.
> 
> Testing: each commit builds individually; the full series builds with and
> without SLANG support; perf test c2c passes (one permission-related skip);
> cacheline --stdio output is byte-identical to the base commit; and the
> perf-c2c man page builds.
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
> 
>  tools/perf/Documentation/perf-c2c.txt |   71 +
>  tools/perf/builtin-c2c.c              |  130 +-
>  tools/perf/c2c.h                      |  155 +++
>  tools/perf/ui/browsers/Build          |    1 +
>  tools/perf/ui/browsers/c2c-function.c | 1783 +++++++++++++++++++++++++
>  5 files changed, 2021 insertions(+), 119 deletions(-)
>  create mode 100644 tools/perf/c2c.h
>  create mode 100644 tools/perf/ui/browsers/c2c-function.c
> 
> 
> base-commit: d04ef71492fad7230d474efe33d05f4c0563d409
> -- 
> 2.52.0
> 
