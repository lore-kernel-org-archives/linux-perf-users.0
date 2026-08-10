Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086A83932C2;
	Mon, 10 Aug 2026 05:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786339225; cv=none; b=mPi6jP2frijK9O0e+5SjaXZWiHDPvJYyjlwft/rP5GV7IZ5A3g/KcjlEw6IqMA+s19C3jXjPQxeix9J6elUbJ+KkG0ea25YDPPUGOoazNXAPY4aDCkXNYYJKRhbhKvJNkEVSe2NmxxJayOR7/Sw7kpvr8XTGiVtDNbSiD9OG9kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786339225; c=relaxed/simple;
	bh=GyZJLwNV15Ksm8JEUz/wp17dzn8ceB4Cjm7yEbJWzo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dxMIpDZkMMaLzGX7XqB92/bw+KYFCR4ab4OGSl2oC4IlFltq9YmJNzFs7YntExZt4rbcpVv3RcHXE8Q5djHNJ4sPAMn043/eVUWoiTqGk+g/RvhzBApQ5B5yj2iNFLFjRLLkKl/BiXPGLDFaYBV2i5NdJUOBQB4XC0DHBaC+fWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gqwlGZiV; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gqwlGZiV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786339222; x=1817875222;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GyZJLwNV15Ksm8JEUz/wp17dzn8ceB4Cjm7yEbJWzo0=;
  b=gqwlGZiV1OcYOttn8I7sm0tJwIqh792/aPZbOHLE3bKQOC3KXlbXX+KY
   lm4BNvh8zttABvKzNAJ/WCIC+IafaRuhMb85yqRXkNBIqhA9qD62yxa8m
   +v97cAfes2YEqdVcxlWAGHk44ZxXzpcOpnW0aDMKtL/abmDWwLiWL3ojk
   9zPWHBG/yWmE3sWITQlPZK55w/CDO55jrQ/kJTGygLIOx69IDaPRXqwOD
   uKUT5OPvIff0Jw3t0DJVd+tIO5kBYlqEWr0rB5BrPU3KU0cRYkroqY75A
   9Jh1GhOFf6k72wffUKRJHepZ42E4KH8GTmKSbv9SXOsjd5nb+TA7wa5l+
   Q==;
X-CSE-ConnectionGUID: cMizxd9RRhauoaR/c1AfBQ==
X-CSE-MsgGUID: 7P7JwR/ZTW2jMP5dfPunww==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="86784972"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="86784972"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 22:20:21 -0700
X-CSE-ConnectionGUID: g9ZjxSJaRQyAd0lhxiKCiQ==
X-CSE-MsgGUID: wKEoQze5SiOGxJCPqrBhQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="262421440"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa008.jf.intel.com with ESMTP; 09 Aug 2026 22:20:16 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	mark.rutland@arm.com,
	dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com,
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>
Subject: [PATCH v8 0/9] perf c2c: add a function view
Date: Mon, 10 Aug 2026 13:26:38 +0800
Message-ID: <20260810052647.588867-1-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The perf c2c cacheline view identifies hot shared lines, but it can be
difficult to see which functions account for contention across those lines.
This series adds a function-oriented view that groups the existing data as:

  read-side function -> contending writer -> shared cacheline

Pressing TAB switches between the cacheline and function views. Existing
cacheline-view data and operations remain unchanged.

v1: https://lore.kernel.org/linux-perf-users/20260626070355.1556721-1-jiebin.sun@intel.com/
v2: https://lore.kernel.org/linux-perf-users/20260710084247.3576706-1-jiebin.sun@intel.com/
v3: https://lore.kernel.org/linux-perf-users/20260717020530.1645123-1-jiebin.sun@intel.com/
v4: https://lore.kernel.org/linux-perf-users/20260724095842.995920-1-jiebin.sun@intel.com/
v5: https://lore.kernel.org/linux-perf-users/20260730090521.2206375-1-jiebin.sun@intel.com/
v6: https://lore.kernel.org/linux-perf-users/20260803035220.172022-1-jiebin.sun@intel.com/
v7: https://lore.kernel.org/linux-perf-users/20260806074217.2846596-1-jiebin.sun@intel.com/

Changes since v7
================

  - Keep c2c-function.o in libperf-ui.a and drop the v7 tools/perf/Build
    change, as Namhyung suggested. builtin-c2c.c now passes the cacheline
    histograms, coalescing fields, symbol_full flag, and cacheline detail
    callback through struct c2c_function_view_args. The browser no longer
    references command-private state.

  - Move the shared c2c types and the two column-formatting callbacks into
    new util/c2c.h and util/c2c.c. Keep struct perf_c2c, the command
    instance, and perf_c2c__browse_cacheline() private to builtin-c2c.c.

  - Rebase onto perf-tools-next at bf10e6ee2ac3.

Changes since v6
================

  - Link c2c-function.o directly into perf under CONFIG_SLANG instead of
    including it in libperf-ui.a. The browser depends on state and callbacks
    provided by builtin-c2c.o, which is not linked into python/perf.so,
    while libperf-ui.a is linked under --whole-archive. This fixes the
    unresolved symbols seen when importing the Python module and keeps the
    TUI-only object out of NO_SLANG builds.

  - Rebase onto perf-tools-next at d74fb8c4c87f.

Changes since v5
================

  - Give the function-view children their own references instead of
    borrowing them, as suggested by Namhyung. They set ops and take refs
    via map_symbol__copy() and thread__get(), so hist_entry__delete()
    frees them; the custom child destructor and the
    WARN_ON_ONCE(report_hierarchy) guard are gone.

  - Add NO_SLANG stubs for the two TUI entry points declared in c2c.h,
    matching how util/hist.h declares its own.

  - Spell out in the symbol renderer why the length returned by
    se_snprintf() cannot exceed the cell.

  - Rebase onto perf-tools-next at d04ef71492fa.

No intended change to the rendered output, cacheline-view data, existing
cacheline operations, or --stdio output.

Changes since v4
================

  - Rebase onto perf-tools-next at 0d40fedcd1b9.

  - Require `iaddr` in --coalesce before entering the function view;
    without it, coalesced samples cannot be reliably attributed.

  - Reuse each source cacheline's existing index as the level-3 identity,
    so same-address sources no longer merge and 'd' finds the original
    entry, without adding fields to the shared C2C structures.

  - Keep same-function reader/writer pairs, which the coalesced view cannot
    reliably tell apart from cross-thread contention.

  - Robustness and cleanup: build the hierarchy only from filtered
    cachelines with a lightweight entry allocator; explicit
    mem_info__new() handling; a local bound in the symbol renderer; a
    NULL-map guard; deterministic tie-breaks; function-view-local row
    recounting; Ctrl-C as an exit key; and expanded man-page docs.

Changes since v3
================

Reworked the function view into a true function-centric hierarchy, as
discussed with Namhyung:

  - Level 1 is the read-side function itself, aggregating all of its code
    addresses into one entry and sorting by Cycles %.

  - Level 2 is the contending function that writes the shared lines,
    aggregated across cachelines and sorted by store count. Level 3 is the
    specific cachelines.

  - Dedicated code-address and offset columns were removed from the main
    view. Verbose function formatting can still include a representative
    code address, and full code-address information remains available in
    the per-cacheline detail view ('d').

  - Lower-level entries are indented like the normal perf report hierarchy
    view, and entries with no contending writer are pruned.

  - Reorganized the series from 14 mechanical patches into 9 logically
    self-contained patches.

Changes since v2
================

  - Prefix helpers exported from builtin-c2c.c with c2c_, as suggested by
    Namhyung.

Changes since v1
================

  - Add a worked man-page example, as suggested by Namhyung.

In the perf c2c TUI, press TAB in the cacheline view to switch to the
function view. It presents a three-level hierarchy:

  Level 1: read-side function, sorted by Cycles %
  Level 2: functions writing the shared lines, sorted by store count
  Level 3: cachelines where the two functions contend

For example, with dequeue_pushable_task expanded to its level-2 writers and
two of those writers expanded to their level-3 cachelines:

  Shared Data Functions Table     (19 entries, sorted on Cycles %)
     Cycles    Store
          %    count  Function / Contending function / Cacheline
  ----------------------------------------------------------------------
  +  35.67%      876  + [k] cpupri_set
  +  24.31%      424  + [k] pull_rt_task
  -  16.53%      555  - [k] dequeue_pushable_task
                 145    - [k] pull_rt_task
                 145        0xff2d0082809da080
                 139    - [k] enqueue_pushable_task
                  70        0xff2d00a2071f9640
                  69        0xff2d0082809da000

A level-1 store count decomposes into its level-2 writers, and each writer's
count decomposes into its level-3 cachelines (here 145 = 145, 139 = 70 + 69).

Keys in the function view:

  TAB/ESC/q/Ctrl-C   return to the cacheline view
  d                  show details for the selected level-3 cacheline
  e / +              expand / collapse the selected entry
  ?                  help

The function view is a separate hist_browser in
tools/perf/ui/browsers/c2c-function.c. Shared types and declarations used
by both views are factored out of builtin-c2c.c into util/c2c.h. The
hierarchy is constructed from the existing cacheline histograms into
dedicated hists and rendered with custom column formatters.

Testing: every commit builds with and without SLANG support. In both
configurations python/perf.so has no unresolved symbols, the Python module
imports successfully, and the full series passes `perf test c2c` and
`perf test 'import perf'`. The cacheline-view --stdio output is
byte-identical to the base commit. c2c-function.o remains in libperf-ui.a
without references to command-private symbols. Stdio support and automated
function-view coverage remain a separate follow-up.

Jiebin Sun (9):
  perf c2c: extract shared data structures into util/c2c.h
  perf c2c: add function view browser skeleton
  perf c2c: add column rendering for function view
  perf c2c: add HPP list parsing for function view columns
  perf c2c: add function view stats merge and memory management
  perf c2c: add function view hierarchy entry creation
  perf c2c: build and finalize the function view hierarchy
  perf c2c: add function view browser UI and cacheline detail
  perf c2c: document function view in perf-c2c man page

 tools/perf/Documentation/perf-c2c.txt |   71 +
 tools/perf/builtin-c2c.c              |  115 +-
 tools/perf/ui/browsers/Build          |    1 +
 tools/perf/ui/browsers/c2c-function.c | 1791 +++++++++++++++++++++++++
 tools/perf/util/Build                 |    1 +
 tools/perf/util/c2c.c                 |   21 +
 tools/perf/util/c2c.h                 |  131 ++
 7 files changed, 2029 insertions(+), 102 deletions(-)
 create mode 100644 tools/perf/ui/browsers/c2c-function.c
 create mode 100644 tools/perf/util/c2c.c
 create mode 100644 tools/perf/util/c2c.h


base-commit: bf10e6ee2ac3034c9068e03eed418fd16961984e
-- 
2.52.0

