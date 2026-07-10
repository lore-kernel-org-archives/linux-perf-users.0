Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073063F20F4;
	Fri, 10 Jul 2026 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673023; cv=none; b=QbcFr2Mz5q2zE0/xXsPcOifEQ8ixRqgePVYp378xL08GLhAMa/MFIqAodsWA6ovGuYq7EG96MD/baMM8S2anzKSNZOXP8esKflJyXC+xRvfOU7cLEFfcRuVFPhj1Zmt8f7qi53CEQ/kyPlAoagyEok0FXyPSpsWhzo/HxQ3ts70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673023; c=relaxed/simple;
	bh=Mm/vrSGZHFmbT5s4VKo2mi6DurGi7q5CM4ASEQyOr9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLdGd7PDf67xGa74u7pp0yp12rrNJypxqQt8trsAj/JJAqk/bbtmsgCqtzAPykLfT57fOpoCFRuYOebB+/LomHN5LgO1WDUy86G8ftkL/zhVl4cKDWqQ5FM1jPBESxFOMJQ5bdvrHKNFs7a6U8O6zZayvKKUwvhE0+EHDWrTIqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bj7LXhrO; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bj7LXhrO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783673021; x=1815209021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mm/vrSGZHFmbT5s4VKo2mi6DurGi7q5CM4ASEQyOr9c=;
  b=Bj7LXhrOLaBuyo3B0Spx5OAeTbAsktyU8QmT+fh5xtbS/V3a1T1+bPk0
   ETELNE6zOBq5zhOEPufW0CnEHNbUdXCDGDO6BPeWEjCL9P1oJsnfeYu35
   NbOKJVy7jUp9N4opJ7kyu01LcqG8ZDMe/wP1gTlaMztDxYsMelwS3p5Sr
   OVGKmSco2TXjCUTM6z5FGg6Pdyzo/6Bsjw6H6Z0H8kEyrmmzTcG87A2xl
   lPt13DFfkdF6OsawLEadh22Fs9h685CC38ZT66V3ugza7WjG01BFpcf9t
   JeNZowF7d2WVz3v2bqI3mWUN24CD14zVQoq6JluulmSOzrxx2qkOfATNx
   g==;
X-CSE-ConnectionGUID: 461TuO4XT96jAB0FUlksPQ==
X-CSE-MsgGUID: nv2lZMwqQTSknlXZpt5UnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84390928"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84390928"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:43:40 -0700
X-CSE-ConnectionGUID: YB/7jqPwRoeBECB+LLRoGw==
X-CSE-MsgGUID: jQpiTLV4SHW3m1F3j/0Fag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258435503"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa003.jf.intel.com with ESMTP; 10 Jul 2026 01:43:36 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Tianyou Li <tianyou.li@intel.com>,
	Wangyang Guo <wangyang.guo@intel.com>
Subject: [PATCH v2 14/14] perf c2c: document function view in perf-c2c man page
Date: Fri, 10 Jul 2026 16:42:47 +0800
Message-ID: <20260710084247.3576706-15-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260710084247.3576706-1-jiebin.sun@intel.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
 <20260710084247.3576706-1-jiebin.sun@intel.com>
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

