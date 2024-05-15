Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C661C3A1CA;
	Wed, 15 May 2024 05:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715751893; cv=none; b=d3olxUnWFUZDI5aKie9Jf7kfRVYTL30Ps9gUJWcgBb3F+RnpEYTOxxbMrDD8lLjUSE6oEFwC5R14aRcmtLyr8t4SDQSqpcwnzxvFu8QzaMAg0v+Lo0PvQeuZIKAd2sLyMgr8tW+7gaa712rbDxaI/zoqUQXcXpsX/Is0n2CfpTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715751893; c=relaxed/simple;
	bh=jBaOGMgRlul88F4Oy7rOAHPud4Cpy56rg7zMMdfLVmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCx3CmyLXP4C7l3oTHB4iC/RzYQiIm/XPC6/6KomvK+HALQnOhyZiLCQwohW9i1LiPt8/Wg4mde3Z6X+cjhdtZtxsZR1z4AkGCOq2vTPJsharfLg9HxklWuCiobzYmaiHGeAlsnbi42Zs/FwZyhaXcAliEmYe+RsK4Ptx6nlT3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FgjWU4jO; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FgjWU4jO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715751892; x=1747287892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jBaOGMgRlul88F4Oy7rOAHPud4Cpy56rg7zMMdfLVmM=;
  b=FgjWU4jO02xhn2EA1Vx2+QSpx3/o4XstxsmFx1ilt4CJ/kHbGPQKCcPC
   dpRISmVvRRAehB7NO/qClkIz1l/yMCyb5R//3irHt1L5mUxEqDJBOGb4B
   UNwyCeVCo6SAqOKOl7SAPi1IrDWPHu2FUOxtlwWGg1OiHfcUSw9Mix8GP
   CBR+2d5NvhqBjoP+btT/o9GLLTNFWYYFarySfVyD80DjkhtMWefTLYUqm
   vuvYl/FqsPdkxaJarmuYC7vwgw7PrVnCWOcba9NZUg2dj7A5kyAwCh0kH
   XXEZ5oiLM5XbSjn45Hqmj+nQ5iu/rjhjO3nTiBJdCWkKcoB21EqvVrq9J
   A==;
X-CSE-ConnectionGUID: 76zu0JzKQeG7u22ZXw8EwA==
X-CSE-MsgGUID: ow7vACKdSsKn8lTXna/6Ng==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="29298020"
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="29298020"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 22:44:50 -0700
X-CSE-ConnectionGUID: ev8azQe3QA6x29m6SAS+gQ==
X-CSE-MsgGUID: mvDrKDt2TUOd/MLJwLv+hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="35469197"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa003.fm.intel.com with ESMTP; 14 May 2024 22:44:49 -0700
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
Subject: [RFC PATCH v8 1/7] perf Document: Add TPEBS to Documents
Date: Wed, 15 May 2024 01:44:23 -0400
Message-ID: <20240515054443.2824147-2-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240515054443.2824147-1-weilin.wang@intel.com>
References: <20240515054443.2824147-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

TPEBS is a new feature in next generation of Intel PMU. It will be used in new
TMA releases. Adding related introduction to documents while adding new code to
support it in perf stat.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/Documentation/perf-list.txt |  1 +
 tools/perf/Documentation/topdown.txt   | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

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
index ae0aee86844f..e6c4424e8bf2 100644
--- a/tools/perf/Documentation/topdown.txt
+++ b/tools/perf/Documentation/topdown.txt
@@ -325,6 +325,24 @@ other four level 2 metrics by subtracting corresponding metrics as below.
     Fetch_Bandwidth = Frontend_Bound - Fetch_Latency
     Core_Bound = Backend_Bound - Memory_Bound
 
+TPEBS in TopDown
+================
+
+TPEBS is one of the features provided by the next generation of Intel PMU. The
+TPEBS feature adds a 16 bit retire latency field in the Basic Info group of the
+PEBS record. It records the Core cycles since the retirement of the previous
+instruction to the retirement of current instruction. Please refer to Section
+8.4.1 of "Intel® Architecture Instruction Set Extensions Programming Reference"
+for more details about this feature.
+
+In the most recent release of TMA, the metrics begin to use event retire_latency
+values in some of the metrics’ formulas on processors that support TPEBS feature.
+For previous generations that do not support TPEBS, the values are static and
+predefined per processor family by the hardware architects. Due to the diversity
+of workloads in execution environments, retire latency values measured at real
+time are more accurate. Therefore, new TMA metrics that use TPEBS will provide
+more accurate performance analysis results.
+
 
 [1] https://software.intel.com/en-us/top-down-microarchitecture-analysis-method-win
 [2] https://sites.google.com/site/analysismethods/yasin-pubs
-- 
2.43.0

