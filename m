Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7267841E6A9;
	Fri, 24 Jul 2026 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886762; cv=none; b=NkC1yynGwjJ5TM56fCHCafqDS7zD4bRh33YIxtjleMsmzhLhzcAIRFLT4b9MDCeWlAJTRAlSROyAlNrL8tlgmbw1Le2aT6eT7DnYkwYoQQGntmvbZQN6UAD4EzC40+rLsm/5/gfjKuhm2SCWEbdlruGDY3r8PvoWzLxELIvdYNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886762; c=relaxed/simple;
	bh=JhRvw4trRB/hsRjHlEe9l1qdTLitpOQUUwyltcnKRrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOJmwD5lcp4PsbEZYLacgj3hM8VGM3eSvMyoh/iXAijJgKHD18bauBuj8cDS1Yh4WqoP6XC/IETG11jtknKCZYsWu1deeFDkGRaXGxteHVBTh0q9ZsYdOyxfSYNhAute56qRm5qVBJrxzQTOvM5Q4EXUeQw/wxImFuEHzeez5Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4cQQ6CD; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4cQQ6CD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784886761; x=1816422761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JhRvw4trRB/hsRjHlEe9l1qdTLitpOQUUwyltcnKRrI=;
  b=H4cQQ6CD01Jk5A2AlOQ/o9yDzMosTgmTVhJv/w2JsiR718zre13MDJ5z
   Z5gmzbfm3ui9T2Q1OxqlQPyPHrWneHfDLJuvUaCTyhCWC+S8onRStwa9f
   M+ON37hAT/nWSBdVoTgA3aXxSAXEtFMgQAPvUSu5/TKgTBYsBrUGnw+4r
   1TiKoSqIl/tqpAJTv3FY/jPtazaVed0riNZfZNc5DCcAZSWCnzkH5xcCz
   YPTQE9dUV2IX+LaKEUHltMp4pT332QIUickmyJXwZlCkk8t2mPOyzS5ez
   xSv2gYpL/2Aau6Sizykf4YTcbvau8pV26h1GTljpFI+QXU8nvp/MJwirB
   g==;
X-CSE-ConnectionGUID: 7PNqdPydROOa6oSl+dQlGA==
X-CSE-MsgGUID: z1740FZFS6O11w9c+q6JUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="95907671"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="95907671"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 02:52:39 -0700
X-CSE-ConnectionGUID: ht0HKdNWReiHZh7ZHEuDZA==
X-CSE-MsgGUID: NdEfaWWQR6eX53ifIy2nEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="256018502"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa008.fm.intel.com with ESMTP; 24 Jul 2026 02:52:34 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: Namhyung Kim <namhyung@kernel.org>,
	acme@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org
Cc: adrian.hunter@intel.com,
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
Subject: [PATCH v4 9/9] perf c2c: document function view in perf-c2c man page
Date: Fri, 24 Jul 2026 17:58:42 +0800
Message-ID: <20260724095842.995920-10-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260724095842.995920-1-jiebin.sun@intel.com>
References: <20260717020530.1645123-1-jiebin.sun@intel.com>
 <20260724095842.995920-1-jiebin.sun@intel.com>
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
 tools/perf/Documentation/perf-c2c.txt | 46 +++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index e57a122b8719..ff05eb20a800 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -365,6 +365,52 @@ TUI OUTPUT
 The TUI output provides interactive interface to navigate
 through cachelines list and to display offset details.
 
+Pressing the 'TAB' key in the cacheline view switches to the function
+view.  The function view shows a three-level hierarchy of the same data,
+organized around functions rather than cachelines.  Every level shows
+functions and cachelines only -- code addresses are not shown here; they
+remain available in the per-cacheline detail view ('d').
+
+  Level 1: the read-side function, sorted by Cycles % (estimated load
+           cycles: HITM, peer-snoop and other-load cycles -- on systems
+           whose default display mode is peer, such as Arm64, the
+           peer-snoop component dominates)
+  Level 2: the functions that write the shared lines, causing the
+           level-1 function's HITMs, sorted by store count
+  Level 3: the specific cachelines where the two functions contend
+
+Each function aggregates all of its code addresses into a single entry,
+and a level-2 writer aggregates all of the cachelines it contends over,
+so a contending pair is a single row with its total shown -- there is no
+need to sum a writer's traffic across cachelines by hand.
+
+In the function view the 'd' key opens the detail view of the selected
+cacheline, 'e'/'+' expands or collapses the current entry, and 'TAB',
+'ESC' or 'q' returns to the cacheline view.
+
+For example, expanding a level-1 function reveals the functions that write
+the lines it reads, and expanding one of those reveals the specific shared
+cachelines:
+
+  Shared Data Functions Table     (18 entries, sorted on Cycles %)
+     Cycles    Store
+          %    count  Function / Contending function / Cacheline
+  ----------------------------------------------------------------------
+  -  16.54%      419  - [k] dequeue_pushable_task
+                 145    - [k] pull_rt_task
+                 145        0xff2d0082809da080
+                 139    - [k] enqueue_pushable_task
+                  70        0xff2d00a2071f9640
+                  69        0xff2d0082809da000
+
+Here dequeue_pushable_task pays the read-side HITM penalty (16.54% of the
+estimated load cycles).  It is contended by pull_rt_task and
+enqueue_pushable_task, which write the shared lines; enqueue_pushable_task
+contends over two cachelines but stays a single row with its total (139)
+shown, and the individual cachelines are underneath.  This is the
+false-sharing chain that the cacheline view otherwise leaves to be
+reconstructed by hand.
+
 For details please refer to the help window by pressing '?' key.
 
 CREDITS
-- 
2.52.0

