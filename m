Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAD1383312;
	Mon,  3 Aug 2026 03:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785728736; cv=none; b=uyIO3icvSuT9pkGyDgLmK90EhmS7QoDWTRJ+GTwecOZpVhUkYKkb5TrsVeyduNO0KyBTuF0Zp2rlRp4suzrsCzJaNiAABivQBUQWAgWTCrKUFPRcFcvtHe/zT6KJsuA9j0xn+geD2N/en02slHuVZFvl1oG1M1Inv67l3GqxeEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785728736; c=relaxed/simple;
	bh=tQrEtRSMT4dO91vYVI56CXVFGEviUnFzsRkbRD7Osfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QC/uh6v8N/fmjPsyIMOansPc6FMwBQ/j+zOfgSYKKLvGSy34wMaOni7nRJoJtT8H9UIAYOHNFgOGf2OIxd0QuNikSv+UtIOdyxJjRFbNKu2XDTVVD2z1ZPEvcUjmD7Y5iM3u4e9SGycKZ+qeRfcUPsM00NeCZHNEvAz+mmAVoOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ka7A2su2; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ka7A2su2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785728733; x=1817264733;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tQrEtRSMT4dO91vYVI56CXVFGEviUnFzsRkbRD7Osfw=;
  b=ka7A2su2cI28TGEKDQjMfVGw0HbQsT2R0Z4DlXCLK2UcSGR0EnmxCt1g
   lQJnkF5Nh7tljTsEwujW8rV7DqWe4J7LfeNa0RoB0OJvFQOpZpL7jt3Cy
   kiHgqYQ7kL+VD8mmoCRsmIgXgEHdaUvKbTTHnKhlsIDAKO97pIuJERFjE
   XWHNPdlZQE38YYxp3fvSzs9mEobhp5i88aD03dOuAxjLOE8kdnNyxMX+7
   S+Atlgr3fjhqCkmv1+XmG35RFTClgbp+W8pxgaJ0LI6xv2Mg5RkdBx1YD
   hYMcIiyWYl8xCXDLcck45V9fAaCBBvTEZ4vhfYNaAAJxws1fLzgmnkj5p
   Q==;
X-CSE-ConnectionGUID: zKxR7w1VSemcM7pDMBE0zA==
X-CSE-MsgGUID: ughxdmTHRRSdjU7Bq+1iGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="86210135"
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="86210135"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2026 20:45:32 -0700
X-CSE-ConnectionGUID: oufhHvSARvC9JOdmAhygFQ==
X-CSE-MsgGUID: jtcsz4+0QWiPSOaU7b77Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="261719132"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa009.jf.intel.com with ESMTP; 02 Aug 2026 20:45:28 -0700
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
Subject: [PATCH v6 0/9] perf c2c: add a function view
Date: Mon,  3 Aug 2026 11:52:11 +0800
Message-ID: <20260803035220.172022-1-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a new "function view" to perf c2c report, on top of the
existing cacheline view. Existing cacheline-view data and operations remain
unchanged; TAB adds access to a complementary way to inspect the same
cache-to-cache (C2C) data.

v1: https://lore.kernel.org/linux-perf-users/20260626070355.1556721-1-jiebin.sun@intel.com/
v2: https://lore.kernel.org/linux-perf-users/20260710084247.3576706-1-jiebin.sun@intel.com/
v3: https://lore.kernel.org/linux-perf-users/20260717020530.1645123-1-jiebin.sun@intel.com/
v4: https://lore.kernel.org/linux-perf-users/20260724095842.995920-1-jiebin.sun@intel.com/
v5: https://lore.kernel.org/linux-perf-users/20260730090521.2206375-1-jiebin.sun@intel.com/

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
tools/perf/ui/browsers/c2c-function.c. Shared types and helpers used by
both views are factored out of builtin-c2c.c into c2c.h. The hierarchy is
constructed from the existing cacheline histograms into dedicated hists
and rendered with custom column formatters.

Testing: each commit builds individually; the full series builds with and
without SLANG support; perf test c2c passes (one permission-related skip);
cacheline --stdio output is byte-identical to the base commit; and the
perf-c2c man page builds.

Jiebin Sun (9):
  perf c2c: extract shared data structures into c2c.h
  perf c2c: add function view browser skeleton
  perf c2c: add column rendering for function view
  perf c2c: add HPP list parsing for function view columns
  perf c2c: add function view stats merge and memory management
  perf c2c: add function view hierarchy entry creation
  perf c2c: build and finalize the function view hierarchy
  perf c2c: add function view browser UI and cacheline detail
  perf c2c: document function view in perf-c2c man page

 tools/perf/Documentation/perf-c2c.txt |   71 +
 tools/perf/builtin-c2c.c              |  130 +-
 tools/perf/c2c.h                      |  155 +++
 tools/perf/ui/browsers/Build          |    1 +
 tools/perf/ui/browsers/c2c-function.c | 1783 +++++++++++++++++++++++++
 5 files changed, 2021 insertions(+), 119 deletions(-)
 create mode 100644 tools/perf/c2c.h
 create mode 100644 tools/perf/ui/browsers/c2c-function.c


base-commit: d04ef71492fad7230d474efe33d05f4c0563d409
-- 
2.52.0

