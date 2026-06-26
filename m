Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A382F7F0E;
	Fri, 26 Jun 2026 07:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782457393; cv=none; b=YQy9d6pIP8qBx6G7g55qm5fUt11w3b//At6P8V9IILpEN9im3XYygGSvGPk0x8A5jTNxiZoUMJKhQJyoia2CAv/1tDER0uV3pUaODadVOH+gFpl+Zpt32RvXpI5vr79bfF+i+Pjo6hRnM77YMl7VhJ+yMZzE0nyYqVOZntXHu2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782457393; c=relaxed/simple;
	bh=oTyss8XBiikabJWgMNoRtel3jHZ8ucQHeFMOearjVyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ciTATCg6LdJaDNkd8moWDlqoibwy7uhi5RA8asusp1fNtfN8lK4zrpwNBnAyfNhG0f/p7D4OWoNRxQfUWf0Sea2To51ptLQAxoGT9g7wKpNDvB4nbeSYxFR7MI/lYdrLxxTkzd3ieqN7GQgRheFHoFHRbcaNnOgUs3xa5WTRbvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=El8AT3xo; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="El8AT3xo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782457392; x=1813993392;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oTyss8XBiikabJWgMNoRtel3jHZ8ucQHeFMOearjVyo=;
  b=El8AT3xoUaUq3p5igXoi32YR0rCZYRowSNsIvJaBTFcRT40IrlPNAx16
   5MvelH3mYr8rqLN3viagW43tHWuidzuIq487JAeopAu6yXe5i+iDb25zA
   BEqS7f9LJYWWdyZkL40IEqUSj/RnDxoWX0X2MGElkprHCJUx9HYa8aCxP
   3FzLiI8ODPnkzzbBFGhXVj8/qjS6eNMomEB95ciX5DglzeNJGJBYtTV4q
   W2+OJCDawDXpqX19vBoMW/SubSyIs34kKul16THl39DQ6eW2KEHaV0y64
   DqFimZd3FmZNK/jlj9VRFPFWGUFenChDkklzddNjXU1AlCWYI8zpE1/S/
   Q==;
X-CSE-ConnectionGUID: TuZhHzgrQxSwU14CNZRrkQ==
X-CSE-MsgGUID: 3cV3qMvoTFKodlDdhPCHow==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="94397322"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="94397322"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 00:03:11 -0700
X-CSE-ConnectionGUID: j7LsI7k8SxWC5FVknaehBQ==
X-CSE-MsgGUID: s2UzX83XTF+s1rTKlgdB7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="247893397"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa007.fm.intel.com with ESMTP; 26 Jun 2026 00:03:07 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Tianyou Li <tianyou.li@intel.com>,
	Wangyang Guo <wangyang.guo@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>
Subject: [PATCH 00/14] perf c2c: add a function view
Date: Fri, 26 Jun 2026 15:03:41 +0800
Message-ID: <20260626070355.1556721-1-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
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

Motivation
==========

The existing perf c2c report is organized by cacheline: it lists the most
contended cachelines and the symbols touching each one. That answers
"which cachelines are hot", but two common follow-up questions are harder
to answer directly:

  - Which functions are contending with each other?
  - For a given function, which other functions does it share cachelines
    with, and over which specific cachelines?

The function view reorganizes the same data around functions to answer
these directly, which is useful when chasing false sharing and cross-core
contention at the source-function level.

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

 tools/perf/Documentation/perf-c2c.txt |   15 +
 tools/perf/builtin-c2c.c              |  128 +-
 tools/perf/c2c.h                      |  140 +++
 tools/perf/ui/browsers/Build          |    1 +
 tools/perf/ui/browsers/c2c-function.c | 1547 +++++++++++++++++++++++++
 5 files changed, 1713 insertions(+), 118 deletions(-)
 create mode 100644 tools/perf/c2c.h
 create mode 100644 tools/perf/ui/browsers/c2c-function.c

base-commit: 40db90ac9f66c8246c1746c56d397283d161655c
--
2.52.0
