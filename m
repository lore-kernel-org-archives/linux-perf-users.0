Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D7A3EDE43;
	Mon, 17 Aug 2026 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786959649; cv=none; b=eE9/34jJ2zlzRnB+d4CM1fN5Gu4RGkl2y2882qw4AMGxYjuDIxBMAONtgKf9j+uTs08ljE+jln/84n5AEh0xuzZjUahWaJwDbiZTVry9gfWk6YMxQqFrfe+TgYgPz380eSnxNs2zAHU6/I+flMDMVqqMKgud9o/Ja+PDXbz6QMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786959649; c=relaxed/simple;
	bh=2+EZDb9w/zV3Oiis8rORw9FJnmPd6QcP/OSohznCbmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sk1SGgB2baha6v9rQgsiaoT2e1bEe05e9c4ZQYigqwjfwj299HKc0dBytogSfYmVaj2J0yHtYJq1SSEZpFEcHloJyl6+MUvbW6eTGt+MTBMW8bOXJyzzLPA4wrCx2DKkCA3NQFCsQkItb4dYm+74PJLWjJIJj9Zvxxx/k+K77iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DjcWfa+I; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DjcWfa+I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786959647; x=1818495647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2+EZDb9w/zV3Oiis8rORw9FJnmPd6QcP/OSohznCbmk=;
  b=DjcWfa+IU5kVZWvNifELaK7NimO5Djhos2hEgYzQLlJPuhnaB5+r5P2w
   Kw5eQVByzVoJtXRTxhSqElMLNu8RQs3UQrnawOoA547buB5TlRWY9h2A9
   E9bFyKz4yOLXoO1DN7E9wvjfMKr6AEc1kS0mTLxSY8ngwfj3gke/ln0pm
   c3MQX7T4VW4FrJrpp9Je+CdWOQ2rRih2RH5l+30IM7KHHLcUK8T1y9ucS
   N2DZeJgOY/tI/16h6dHkmNkb0JVAGScJ27Y4iHCZOzOQnxdtpZaOoNGI/
   n2Xkzw7+QLnaSI1qY3GFSyjUTOVuaGOi9KKkfCDmbQ4VeowIdJ7epSdg8
   g==;
X-CSE-ConnectionGUID: jt5ZVyHRRCG0y5BGqgPx7Q==
X-CSE-MsgGUID: RxPeNWsWQhCkierTlm4f0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="98948239"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="98948239"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 02:40:45 -0700
X-CSE-ConnectionGUID: 32wKg5pnT4SsztPML/yskQ==
X-CSE-MsgGUID: OVDuCMi0RyusmikL+uy4cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="288337329"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa002.fm.intel.com with ESMTP; 17 Aug 2026 02:40:40 -0700
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
Subject: [PATCH v9 9/9] perf c2c: document function view in perf-c2c man page
Date: Mon, 17 Aug 2026 17:46:23 +0800
Message-ID: <20260817094623.3288456-10-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260817094623.3288456-1-jiebin.sun@intel.com>
References: <20260817094623.3288456-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the function view hierarchy (read-side function -> contending
writer function -> shared cachelines), the per-level indentation, and the
keys, with a worked example.

Document that reliable function attribution requires `iaddr` in
`--coalesce`, that the reader and writer may be the same function, and why
the coalesced function view cannot distinguish same-thread from
different-thread accesses in that case. Also document that verbose mode
includes code addresses in function rows.

Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Falcon <thomas.falcon@intel.com>
Reviewed-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
---
 tools/perf/Documentation/perf-c2c.txt | 71 +++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index e57a122b8719..8775889bc0a3 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -365,6 +365,77 @@ TUI OUTPUT
 The TUI output provides interactive interface to navigate
 through cachelines list and to display offset details.
 
+Pressing the 'TAB' key in the cacheline view switches to the function
+view.  The function view shows a three-level hierarchy of the symbolized
+entries retained in the cacheline view, organized around functions rather
+than cachelines.  Levels 1 and 2 normally show function names, while level 3
+shows cacheline addresses.  Lower levels are indented beneath their parents.
+Verbose mode also includes code addresses in function rows, and code addresses
+remain available in the per-cacheline detail view ('d').
+
+The function view requires `iaddr` in the cacheline coalescing fields.  If
+`--coalesce` omits it, TAB reports that the view is unavailable rather than
+attributing already-coalesced samples to an arbitrary function.
+
+  Level 1: the read-side function, sorted by Cycles % (estimated load
+           cycles: HITM, peer-snoop and other-load cycles)
+  Level 2: the functions sampled writing the shared lines read by the
+           level-1 function, sorted by store count.  This can be the same
+           function when it has both read and write samples
+  Level 3: the specific cachelines shared by the reader/writer pair
+
+The Cycles % value is the function's share of event-provided load
+latency/weight estimates from cacheline-detail entries retained in the
+current view.  It can include non-HITM and non-peer loads coalesced into
+entries that pass the C2C filter, so it is not a pure contention-cycle
+percentage.  The share is relative to the functions and entries retained
+for the current report and is not comparable across recordings or different
+`--coalesce` settings.
+
+The store count on a level-1 row is the number of sampled stores by writers
+shown in the function view into the cachelines that function reads, including
+stores from the same function.  It decomposes into the level-2 writer rows;
+each level-2 count in turn decomposes into that writer's stores on its level-3
+cachelines.  A level-3 count is therefore not the cacheline's total store
+count.  The level-1 value is not the number of stores made by the reader and
+is not additive across level-1 rows: two functions reading the same line each
+carry the stores into that line.
+
+Each function aggregates all of its code addresses into a single entry,
+and a level-2 writer aggregates all of its shared cachelines, so a
+reader/writer pair is a single row with its total shown -- there is no
+need to sum a writer's traffic across cachelines by hand.
+
+In the function view the 'd' key opens the detail view of the selected
+level-3 cacheline, 'e'/'+' expands or collapses the current entry, and 'TAB',
+'ESC', 'q' or Ctrl-C returns to the cacheline view.
+
+For example, with the first two read-side functions collapsed and
+dequeue_pushable_task expanded to show the functions writing the lines it
+reads -- two of which are further expanded to their individual cachelines:
+
+  Shared Data Functions Table     (19 entries, sorted on Cycles %)
+     Cycles    Store
+          %    count  Function / Contending function / Cacheline
+  ----------------------------------------------------------------------
+  +  35.67%      876  + [k] cpupri_set
+  +  24.31%      424  + [k] pull_rt_task
+  -  16.53%      555  - [k] dequeue_pushable_task
+                 145    - [k] pull_rt_task
+                 145        0xff2d0082809da080
+                 139    - [k] enqueue_pushable_task
+                  70        0xff2d00a2071f9640
+                  69        0xff2d0082809da000
+
+Here dequeue_pushable_task pays 16.53% of the estimated read-side load-cycle
+cost.  Its store count decomposes into its level-2 writers, and each writer's
+count decomposes into its level-3 cachelines: pull_rt_task's 145 stores fall
+on a single line, while enqueue_pushable_task's 139 stores split across two
+lines (70 and 69).  A writer can be the same function as the reader when it
+has both read and write samples; after cacheline coalescing and
+function-level grouping, the view cannot distinguish same-thread accesses
+from different threads running the same function.
+
 For details please refer to the help window by pressing '?' key.
 
 CREDITS
-- 
2.52.0

