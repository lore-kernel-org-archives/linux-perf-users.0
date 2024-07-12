Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D7F40870;
	Fri, 12 Jul 2024 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720811390; cv=none; b=LvBb93MgInI9rB0MF1JwQtrxU9CVbvlOQurDoK7PsqKGhRzWy1Q/ru/MYJMtmJe2NyQ3o7Hc2Lbk99kYAgTb9kLUuAqKXznr82eTc4zmn/qOSlcoMg4JJ8qvONDYKSEOkX63pTyE7txjYCBNSzGD9FizzQKbEhm2nws9acpnxKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720811390; c=relaxed/simple;
	bh=tyUd4y28OguMWyV/boph8Ima1IPUt4X/+btxrq6wjQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lk0Ig9+z+bZfX1YNJNE4twHEp1ZbatVY0tOlrCGBF5grytwe/rEy7B2Haz1AG+RTocbDp0BMpI2Vyi5PrmiwgV+VYo5M7jg6kLXt+Q5scxWYx3eu/ijBAodv1oufTY+ZJ5SDZ9LhiCb+n5XfoMYY9FBe3NAHfYuTFLprqf/sJjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dKdt3yuW; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dKdt3yuW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720811389; x=1752347389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tyUd4y28OguMWyV/boph8Ima1IPUt4X/+btxrq6wjQU=;
  b=dKdt3yuWaU94FfUKxYQXJC5hY3efRZcCi52b2t6+Q59z/txG23ZI+wce
   gIeS9L5EoSWEkSx+1TVXRpF3qQ6yVGsIcpMqJXHxV+tW6xR23Mi+ES0pe
   SCX5wydt9gGnTMZI7QpqpSRfGwXltWiYzgrNNPLxo4etu3kv6ajigoqtA
   e8covRrNWL7yNdImLWVEVog9o+ZDoLOfrLu6hiPWPceOCXmjcvnTDkmTJ
   PcwyJhJwYubYmNu+W5m5fwQIu3jOWmoFzHZ03aMn/xgGrSQGbZbWW+/ZO
   km/KIFnORjsdjf5fM8vRZLZ7Lhlo/25OeWIogcauoTuipE/9GSpoeusYG
   Q==;
X-CSE-ConnectionGUID: T1n1YzNnQSmlUMlS+4cL0Q==
X-CSE-MsgGUID: OmVqbGlyRCupItfGSAN2sA==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="43683043"
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="43683043"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 12:09:43 -0700
X-CSE-ConnectionGUID: EPbCksdJTBumBSBetWQV5Q==
X-CSE-MsgGUID: CtRc0VQTQJ2Wklng/3k0+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="54187448"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa004.jf.intel.com with ESMTP; 12 Jul 2024 12:09:43 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v17 7/8] perf Document: Add TPEBS to Documents
Date: Fri, 12 Jul 2024 15:09:29 -0400
Message-ID: <20240712190932.417531-8-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712190932.417531-1-weilin.wang@intel.com>
References: <20240712190932.417531-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

TPEBS is a new feature Intel PMU from Granite Rapids microarchitecture. It will
be used in new TMA releases. Adding related introduction to documents while
adding new code to support it in perf stat.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/Documentation/perf-list.txt |  1 +
 tools/perf/Documentation/topdown.txt   | 30 ++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 6bf2468f59d3..dea005410ec0 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -72,6 +72,7 @@ counted. The following modifiers exist:
  W - group is weak and will fallback to non-group if not schedulable,
  e - group or event are exclusive and do not share the PMU
  b - use BPF aggregration (see perf stat --bpf-counters)
+ R - retire latency value of the event
 
 The 'p' modifier can be used for specifying how precise the instruction
 address should be. The 'p' modifier can be specified multiple times:
diff --git a/tools/perf/Documentation/topdown.txt b/tools/perf/Documentation/topdown.txt
index ae0aee86844f..5c17fff694ee 100644
--- a/tools/perf/Documentation/topdown.txt
+++ b/tools/perf/Documentation/topdown.txt
@@ -325,6 +325,36 @@ other four level 2 metrics by subtracting corresponding metrics as below.
     Fetch_Bandwidth = Frontend_Bound - Fetch_Latency
     Core_Bound = Backend_Bound - Memory_Bound
 
+TPEBS in TopDown
+================
+
+TPEBS (Timed PEBS) is one of the new Intel PMU features provided since Granite
+Rapids microarchitecture. The TPEBS feature adds a 16 bit retire_latency field
+in the Basic Info group of the PEBS record. It records the Core cycles since the
+retirement of the previous instruction to the retirement of current instruction.
+Please refer to Section 8.4.1 of "Intel® Architecture Instruction Set Extensions
+Programming Reference" for more details about this feature. Because this feature
+extends PEBS record, sampling with weight option is required to get the
+retire_latency value.
+
+	perf record -e event_name -W ...
+
+In the most recent release of TMA, the metrics begin to use event retire_latency
+values in some of the metrics’ formulas on processors that support TPEBS feature.
+For previous generations that do not support TPEBS, the values are static and
+predefined per processor family by the hardware architects. Due to the diversity
+of workloads in execution environments, retire_latency values measured at real
+time are more accurate. Therefore, new TMA metrics that use TPEBS will provide
+more accurate performance analysis results.
+
+To support TPEBS in TMA metrics, a new modifier :R on event is added. Perf would
+capture retire_latency value of required events(event with :R in metric formula)
+with perf record. The retire_latency value would be used in metric calculation.
+Currently, this feature is supported through perf stat
+
+	perf stat -M metric_name --record-tpebs ...
+
+
 
 [1] https://software.intel.com/en-us/top-down-microarchitecture-analysis-method-win
 [2] https://sites.google.com/site/analysismethods/yasin-pubs
-- 
2.43.0

