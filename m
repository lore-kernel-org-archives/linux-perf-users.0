Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CCC3D75AD;
	Mon, 17 Aug 2026 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786959616; cv=none; b=G2bbxOaQKIgfy2Ds8wIwjrtNI5laKqYI/r7p0I3YrXR2fWCho1TI6u7vxBPX2PTrStcCuTPKoIgEABtqlakdxxk/H2WSdz+ieLBrSbR9qqP93bu+xFMhm8t4sXeJFkRGGNnQkiuu0pzFTE2QoZZOFz0465hYaW6JW7Su81pzzPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786959616; c=relaxed/simple;
	bh=gnZ4HRcbx1c5kxg3DZ6r/IiIZanHQKcc6Jcad+KyKq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R+i48JtM9iUPRRT5Tv8TOjbAEIfF3slEEx00fBx3dJjsrPcEo3SQ8fhrnJOZwOJJnHn5SdKaJU+bnFG+JBQzl+3Y332avI3pLxMhqLenhPYWWAgm99CY3EScLDCNIISg5hhX+8WZGTkmbiwIM3es0K3H7zsNysMCSJwte3rDGhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bJ/hehgG; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bJ/hehgG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786959612; x=1818495612;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gnZ4HRcbx1c5kxg3DZ6r/IiIZanHQKcc6Jcad+KyKq0=;
  b=bJ/hehgGeJrMjcgn2XWydXXu/QDQYQGOFQ7rlsyah2yUjbJI2NmM1T6c
   7ca+wyuT3RpUIOU1DUJkboYMLZ9UHrU85j9xEkZKUeaHpshleqQy0N7Qg
   VHO0KpqcOtvFPOnWaG42tlUBd1RdTelMUqUhiGSgjbEnR0yFtdIdDtXWt
   0gcXnR8JbaWxDGA70uXV5ECzh6YuYQvCyXO67MOyavn9YkkFNEq9hCuDS
   SLw4wRNg0L7h7g1RPzF9HmbSphl0ho/UPQmDHdI0HNHS09GzVgUxboxjC
   lY6P5eDVnVwZ9zDrxL0TCoedTfZ2awl6hqS/JL4DV+f7aWqJtezRmvDDW
   g==;
X-CSE-ConnectionGUID: f2g98KhlQO6zlXRj8EUSnw==
X-CSE-MsgGUID: lRevXThfRgirhk/qmnFdGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="98948108"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="98948108"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 02:40:08 -0700
X-CSE-ConnectionGUID: QQ1ZHEiORN24vxjNbMNFMw==
X-CSE-MsgGUID: /fO4ObedStuARXoOl4JHvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="288337129"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa002.fm.intel.com with ESMTP; 17 Aug 2026 02:40:03 -0700
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
	jiebin.sun@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/9] perf c2c: add a function view
Date: Mon, 17 Aug 2026 17:46:14 +0800
Message-ID: <20260817094623.3288456-1-jiebin.sun@intel.com>
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
v8: https://lore.kernel.org/linux-perf-users/20260810052647.588867-1-jiebin.sun@intel.com/

Changes since v8
================

  - Rebase onto perf-tools-next at 6ae6fb96ccd4.

  - Move the function-view hierarchy construction, aggregation, sorting,
    and column formatting to util/c2c-function.c, as suggested by Namhyung.
    Keep only the TUI browser, key handling, and cacheline detail action in
    ui/browsers/c2c-function.c.

  - Make the common model validate inputs before replacing existing state
    and keep its entries callchain-free during construction and teardown,
    independent of the caller's current callchain setting.

  - Simplify three rbtree node-to-entry conversions by using rb_entry()
    directly with the nested hist_entry rb_node, as suggested by Namhyung.

  - Clarify that Cycles % uses the surviving level-1 entries after pruning.
    No functional change.

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

The common function-view model is in tools/perf/util/c2c-function.c. It
constructs the hierarchy from the existing cacheline histograms into
dedicated hists and provides the custom column formatters. The TUI front
end remains in tools/perf/ui/browsers/c2c-function.c.

Testing: every commit builds with and without SLANG support. In both
configurations python/perf.so has no unresolved symbols, the Python module
imports successfully, and the full series passes `perf test c2c` and
`perf test 'import perf'`. The cacheline-view --stdio output is
byte-identical to the base commit. A TUI smoke test entered the function
view and expanded its first level-1 entry; the rendered output was
identical to the existing reference screen after trimming trailing spaces.

Jiebin Sun (9):
  perf c2c: extract shared data structures into util/c2c.h
  perf c2c: add function view model skeleton
  perf c2c: add column rendering for function view
  perf c2c: add HPP list parsing for function view columns
  perf c2c: add function view stats merge and memory management
  perf c2c: add function view hierarchy entry creation
  perf c2c: build and finalize the function view hierarchy
  perf c2c: add function view browser UI and cacheline detail
  perf c2c: document function view in perf-c2c man page

 tools/perf/Documentation/perf-c2c.txt |   71 ++
 tools/perf/builtin-c2c.c              |  115 +-
 tools/perf/ui/browsers/Build          |    1 +
 tools/perf/ui/browsers/c2c-function.c |  209 ++++
 tools/perf/util/Build                 |    2 +
 tools/perf/util/c2c-function.c        | 1642 +++++++++++++++++++++++++
 tools/perf/util/c2c.c                 |   21 +
 tools/perf/util/c2c.h                 |  135 ++
 8 files changed, 2094 insertions(+), 102 deletions(-)
 create mode 100644 tools/perf/ui/browsers/c2c-function.c
 create mode 100644 tools/perf/util/c2c-function.c
 create mode 100644 tools/perf/util/c2c.c
 create mode 100644 tools/perf/util/c2c.h

-- 
2.52.0
