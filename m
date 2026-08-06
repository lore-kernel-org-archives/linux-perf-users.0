Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733AB34B669;
	Thu,  6 Aug 2026 07:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786001736; cv=none; b=pmKEzOkbSRK8KlttbHXItJj8GjY8TmOaz8Q8VhXqtUndrZhjR+GTMHjaSfW9m/B2LGSW07V/eI796dDXaG4dm1dmr87BQbumgfD60/khW42WVe8uAgCEd4pN1/C9qnr/bTWJ0ViNNnnUj4PGJQ+GiLFTzrgVoWr24E9Fx+JLwfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786001736; c=relaxed/simple;
	bh=Vp09duoivpM+8gjUzsBztbz2nIzsHqV5ppcHVVZZEA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GZwK2JyuDaQQjW9XgWMcznCOemCK2SSGKdVtCjkxF2Po9M5nnNpuxB+fVJBgx+dPTo9aWvs1zcdh+y7gjn/ShW2PMyzfbpLy8xWq/RLnkeZc6ErvP0Rb2fdINXBuvgojPsf0l5XSkbfUQpSO3npnF5amS6pyrCExRm8NErOmC4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IjVaIN5J; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IjVaIN5J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786001735; x=1817537735;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Vp09duoivpM+8gjUzsBztbz2nIzsHqV5ppcHVVZZEA4=;
  b=IjVaIN5JtkjbFsTsQZVWQK4oyna7pQV4RMwnm5rE5JXJEBTfKMd5mzdO
   W3i5LpkDmT4I/5+kuYiyNlszqj7ep2tdJWsMFRU8Us6mu8ldNGq5/aW7s
   itbezD1ZAEHhjkI0YO90y0CyzHucvB7sWbf4lXlp53TgVJ6SeMu2qe29q
   hX69zTY++8o0qoDgOxNQZaKoMlypfNSlZMA+tQ9GmmqC3gyKD3VqgywpS
   NXVOd3gUdpO7FC/WjPWEN6VHztEM+HEONsE20V7I2Dg5f4b44xY6oXnux
   PZBkKY2zZxjBu60l+vsSS5fjc37tff5axV+7Wa81ONqwhsaXEu3i/wnnL
   w==;
X-CSE-ConnectionGUID: knPKc0rNTrCE1sUSFPuN/A==
X-CSE-MsgGUID: 6PqheidMQyaU4phK+5PTqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86440453"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="86440453"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 00:35:34 -0700
X-CSE-ConnectionGUID: x1Qib+B5So2MLMW/7xWxYQ==
X-CSE-MsgGUID: OiUzMYytTMCwNAnZS+0Stw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="300245417"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa001.jf.intel.com with ESMTP; 06 Aug 2026 00:35:31 -0700
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/9] perf c2c: add a function view
Date: Thu,  6 Aug 2026 15:42:08 +0800
Message-ID: <20260806074217.2846596-1-jiebin.sun@intel.com>
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
v6: https://lore.kernel.org/linux-perf-users/20260803035220.172022-1-jiebin.sun@intel.com/

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
by both views are factored out of builtin-c2c.c into c2c.h. The hierarchy
is constructed from the existing cacheline histograms into dedicated hists
and rendered with custom column formatters.

Testing: every commit was clean-built and passed `perf test -v 'import
perf'`. The full series builds with and without SLANG support; the existing
stdio-only `perf test c2c` and the Python import test pass in both
configurations; `ldd -r` reports no unresolved symbols in the Python
extension from either build; and c2c-function.o is no longer included in
libperf-ui.a. Stdio support and automated function-view coverage remain a
separate follow-up.

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

 tools/perf/Build                      |    1 +
 tools/perf/Documentation/perf-c2c.txt |   71 +
 tools/perf/builtin-c2c.c              |  130 +-
 tools/perf/c2c.h                      |  155 +++
 tools/perf/ui/browsers/c2c-function.c | 1783 +++++++++++++++++++++++++
 5 files changed, 2021 insertions(+), 119 deletions(-)
 create mode 100644 tools/perf/c2c.h
 create mode 100644 tools/perf/ui/browsers/c2c-function.c


base-commit: d74fb8c4c87f10fd147114133f786a10f7e58d8a
-- 
2.52.0
