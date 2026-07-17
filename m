Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C1832B10B;
	Fri, 17 Jul 2026 02:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784253985; cv=none; b=pojqDdIXC0vDB2wI2qwWG0gWcTgG4gY7tVJy0w6xsjR9T5+CmGg72P4grIw+85bo0AWiLWyXjOEt5zMvM7glfBbAflhJZsFI5TZiGeo3NujzIccSLNpyPQ/VPRjo1ZcpgOChnXzLciqq3ukwsCdC9sMBUepWd7LDDpVuGlK/Dh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784253985; c=relaxed/simple;
	bh=Mm/vrSGZHFmbT5s4VKo2mi6DurGi7q5CM4ASEQyOr9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvK6ZXDbqO2MUw/dGLybsTazfGkouMOYiC65wxtioZl0BqdDfhRN4W9CZsEDQhb1yNLY8hqYXn9zEmAsvym64aMoPlO74K/jTmIa/ZGpi6AzOzKEH7MVv+RR1TFinD925I1hzvhd3oQNHxzUrNZfTfsG7ClXjaDbyp/dF8mpX6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OeaUhLrm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OeaUhLrm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784253985; x=1815789985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mm/vrSGZHFmbT5s4VKo2mi6DurGi7q5CM4ASEQyOr9c=;
  b=OeaUhLrmBjPN6Ikrd/fpWq2hqbhCal913Jg3C505oRfm80SeAT0xcPZh
   hTeKOWmiGcxAJ3XhSv1x2H8bIA+lV7YHImKkdhYvtzDYXepMksZvTu8yc
   Ct505y22ugZ9ZRE6XuGOI3OhKwaA9YbR1l+6dd3gfnGSk3GngdTJgijyG
   ELBNm6qVuukIffaDxG9NytbIWsIqHDGy7ci7/4FQfEssY8M4596LA9PcU
   1jZmSxT1jegv6IMrZ2/iczkXLg9ve5k9yde0frU8vqYlu5NROO8+QGLtf
   AkQLKeZ6X4fzcZVaWQMpapzK7PDAhSg8VgVhts6gDbJ9tcM7w5siTAeIK
   Q==;
X-CSE-ConnectionGUID: SR2rQ5r/RQu3PBWWMPr9rQ==
X-CSE-MsgGUID: yssBE7DSQLGPnMwAY1bttw==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="107720112"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="107720112"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 19:06:25 -0700
X-CSE-ConnectionGUID: FwVKMJqUS0i2tUOs5CVMQA==
X-CSE-MsgGUID: UrPZgMYCSs2ylDsg1ydbQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="279952893"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa002.fm.intel.com with ESMTP; 16 Jul 2026 19:06:20 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: namhyung@kernel.org,
	acme@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>
Subject: [PATCH v3 14/14] perf c2c: document function view in perf-c2c man page
Date: Fri, 17 Jul 2026 10:05:30 +0800
Message-ID: <20260717020530.1645123-15-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260717020530.1645123-1-jiebin.sun@intel.com>
References: <20260710084247.3576706-1-jiebin.sun@intel.com>
 <20260717020530.1645123-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the three-level function-view hierarchy (primary function,
sharing functions, shared cachelines) and the TAB/ESC/d/e key
bindings that drive it.

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
 tools/perf/Documentation/perf-c2c.txt | 33 +++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index e57a122b8719..43a3f195048a 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -365,6 +365,39 @@ TUI OUTPUT
 The TUI output provides interactive interface to navigate
 through cachelines list and to display offset details.
 
+Pressing the 'TAB' key in the cacheline view switches to the function
+view.  The function view shows a three-level hierarchy of the same data,
+organized around functions rather than cachelines:
+
+  Level 1: primary functions, sorted by Cycles % (estimated load cycles:
+           HITM, peer-snoop and other-load cycles -- on systems whose
+           default display mode is peer, such as Arm64, the peer-snoop
+           component dominates)
+  Level 2: other functions that share cachelines with the level-1 function
+  Level 3: the specific shared cachelines for each function pair
+
+In the function view the 'd' key opens the detail view of the selected
+cacheline, 'e'/'+' expands or collapses the current entry, and 'TAB',
+'ESC' or 'q' returns to the cacheline view.
+
+For example, expanding a level-1 function reveals the functions it shares
+cachelines with, and expanding one of those reveals the specific shared
+cachelines:
+
+  Shared Data Functions Table   (27 entries, sorted on Cycles %)
+   Cycles  Store
+        %  count  Code address        Symbol           Cacheline
+  ----------------------------------------------------------------------
+  - 39.03%   541  - 0xffffffffa2fc5b08  - [k] cpupri_set
+             450  - 0xffffffffa2fa28a5  - [k] pull_rt_task
+             450                                      0xff2d0082809da080
+
+Here cpupri_set is the most contended function (39.03% of the estimated
+load cycles); it shares data with pull_rt_task (450 stores into the shared
+data); and the contention is on the single cacheline 0xff2d0082809da080.
+This is the false-sharing chain that the cacheline view otherwise leaves
+to be reconstructed by hand.
+
 For details please refer to the help window by pressing '?' key.
 
 CREDITS
-- 
2.52.0

