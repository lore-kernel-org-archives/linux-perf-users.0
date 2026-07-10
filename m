Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3593F0765;
	Fri, 10 Jul 2026 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672955; cv=none; b=gFmnuoC3FWk+JPNsku0oYPdVxkUULYT+NPTe4pj8UFFeN7EDb6zs1xaTcFqd5ijgwvfS941cXzQPr4e1geReBXDhIlvNuvp7z721YyS9vNNbylio+yacsvdo6Wwnpp8uXr9lS+k8U31cDqE07zAVcu6wLYreVnpkVlJ60xroRHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672955; c=relaxed/simple;
	bh=9nlF6MGMuOJgMnecQlxQqHu4gqPgkJpl+xLqIOq9vKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvUFNuZt0cDlqc/1lAn27PqXgWrI+msHPdbDxPtmmiC1OXnFZCAWsi5Kp/AUm/cY7iPBZBkkCJuP/8zavWCLVdV+pbKg8KVBHHUVyr82+xsEIyYZmGhk4fpzekkPPYwz4P3B7a4Nl/FBa9/g4kB/lm2B5q4jqkL6kk7+96PXTBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDSBut16; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDSBut16"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783672954; x=1815208954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9nlF6MGMuOJgMnecQlxQqHu4gqPgkJpl+xLqIOq9vKM=;
  b=oDSBut16y+JUaGr4tyT8hTgUDsc8dVb4f/zXJdZt4rwg2kyHRGQzJ4pT
   gGJVqqG/dnw9QP4Qw+HjU+RL3vVDQjctVZ/jEBfWbQwHGLVKiOvCKTc6P
   cwFGmrDwPKR99FXCJPjNh/YYQ1LXmyIzKmgchXAn2jbRbnCzR7TxlWR4F
   CozFeZjGh03cLog9W/nGOidRXX/1t66/H4pou8a26mPeHgnJn7SwGy0rd
   t/EnkN5xiT0AxxFHLX0uGsGL+kXd79m3Kc7g11P9UhkB5eKoG5vYcTIto
   qmPa+qrgfL+GdGYTHEEpaYUSdK/4u62J3/Uzw57C3j/YF5ZsdtGJaLMwP
   g==;
X-CSE-ConnectionGUID: JKnLnxfHR2q7f5PHJ7A9rg==
X-CSE-MsgGUID: 1UhATA4bRB6h8xoBkUI4OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84390768"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84390768"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:42:33 -0700
X-CSE-ConnectionGUID: 13Z1twpFRj2E+6bo3oFf9w==
X-CSE-MsgGUID: OKz+NPd9RheMjZtrrrixfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258435307"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa003.jf.intel.com with ESMTP; 10 Jul 2026 01:42:31 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>
Subject: [PATCH v2 00/14] perf c2c: add a function view
Date: Fri, 10 Jul 2026 16:42:33 +0800
Message-ID: <20260710084247.3576706-1-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260626070355.1556721-1-jiebin.sun@intel.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a new "function view" to perf c2c report, on top of the
existing cacheline view. It does not change the cacheline view; it adds a
second, complementary way to look at the same cache-to-cache (C2C) data.

v1: https://lore.kernel.org/linux-perf-users/20260626070355.1556721-1-jiebin.sun@intel.com/

Changes since v1
================

  - Add the worked example (the cpupri_set/pull_rt_task walk-through) to
    the perf-c2c man page, as suggested by Namhyung.

  - Rebased onto the latest perf-tools-next.

  - perf c2c: cache the level-1 total-stores sum (new child_stores field)
    instead of walking the children on every comparison. total_stores_cmp()
    is called during collapse/sort, so the previous O(children) walk was an
    O(N*M log N) bottleneck on large profiles.

  - perf c2c: free the function-view sub-hists with
    hists__delete_all_entries() instead of hists__delete_entries(), so
    entries still in the input/collapsed trees are not leaked, matching the
    cleanup in builtin-c2c.c.

  - perf c2c: distinguish -ENOMEM from "unknown dimension" in
    get_function_format(), so an allocation failure is no longer
    misreported as an "Invalid c2c function-view field".

  - perf c2c: reword the iaddr_symbol_cmp() sort-order comment to drop the
    ambiguous ascending/descending wording.

What it does
============

In the perf c2c TUI, press TAB in the cacheline view to switch to the
function view. It presents a 3-level hierarchy:

  Level 1: primary functions, sorted by Cycles % (estimated load cycles:
           HITM, peer-snoop and other-load cycles -- on systems whose
           default display mode is peer, such as Arm64, the peer-snoop
           component dominates)
  Level 2: other functions that share cachelines with the level-1 function
  Level 3: the specific shared cachelines for each function pair

Keys in the function view:
  TAB/ESC/q   return to the cacheline view
  d           show cacheline details for the selected entry
  e / +       expand / collapse the selected entry
  ?           help

The cacheline view and the --stdio output are unchanged.

Example
=======

A level-1 function is expanded (press 'e') to reveal the functions it
shares cachelines with, and one of those is expanded again to reveal the
specific shared cachelines:

  Shared Data Functions Table   (27 entries, sorted on Cycles %)
   Cycles  Store
        %  count  Code address        Symbol           Cacheline
  ----------------------------------------------------------------------
  - 39.03%   541  - 0xffffffffa2fc5b08  - [k] cpupri_set
             450  - 0xffffffffa2fa28a5  - [k] pull_rt_task
             450                                      0xff2d0082809da080

Reading the three levels:

  - Level 1: cpupri_set is the top contended function, accounting for
    39.03% of the estimated load cycles. The table is sorted by this
    Cycles % column.
  - Level 2: expanding cpupri_set (press 'e') lists the functions it
    shares cachelines with, sorted by store count. Here pull_rt_task is
    the contending function, with 450 stores into the shared data.
  - Level 3: expanding pull_rt_task lists the specific cachelines the two
    functions contend over -- in this case the single cacheline at
    0xff2d0082809da080.

The view reads top-down as "cpupri_set is hottest; it shares data with
pull_rt_task; the contention is on cacheline ...da080" -- the false-
sharing chain that the cacheline view otherwise makes you reconstruct by
hand.

Implementation
==============

The function view is built as a separate hist_browser in
tools/perf/ui/browsers/c2c-function.c. Shared types and helpers used by
both views are factored out of builtin-c2c.c into a new c2c.h. The
hierarchy is constructed from the existing cacheline histograms into a
dedicated set of hists, keyed by (symbol, instruction address), and
rendered with custom column formatters.

The series is split into 14 small, self-contained patches so each step
can be reviewed and builds on its own.

Testing
=======

  - Each of the 14 commits builds individually and as a full series.
  - perf c2c report --stdio (cacheline view) output is unchanged versus
    the baseline: identical trace-event totals, shared-cacheline counts,
    and HITM tallies.
  - The function view was exercised on c2c recordings; the level-1
    ordering and the level-2/3 sharing breakdown match the underlying
    cacheline data.

Jiebin Sun (14):
  perf c2c: extract shared data structures into c2c.h
  perf c2c: add function view browser skeleton
  perf c2c: add function view type definitions and helpers
  perf c2c: add column format infrastructure for function view
  perf c2c: add column entry functions for function view
  perf c2c: add comparison functions for function view sorting
  perf c2c: add dimension definitions and format creation
  perf c2c: add HPP list parsing for function view histograms
  perf c2c: add stats merging and memory management helpers
  perf c2c: add hierarchy entry creation and lookup functions
  perf c2c: add function view hierarchy builder
  perf c2c: add function view browser UI
  perf c2c: add TAB key to switch to function view
  perf c2c: document function view in perf-c2c man page

 tools/perf/Documentation/perf-c2c.txt |   33 +
 tools/perf/builtin-c2c.c              |  128 +-
 tools/perf/c2c.h                      |  148 +++
 tools/perf/ui/browsers/Build          |    1 +
 tools/perf/ui/browsers/c2c-function.c | 1563 +++++++++++++++++++++++++
 5 files changed, 1755 insertions(+), 118 deletions(-)
 create mode 100644 tools/perf/c2c.h
 create mode 100644 tools/perf/ui/browsers/c2c-function.c

base-commit: 8c5f60344b07f839267c0c835962e2206143be85
--
2.52.0
