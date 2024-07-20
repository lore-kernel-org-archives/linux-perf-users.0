Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BAE2CCA3;
	Sat, 20 Jul 2024 06:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721456476; cv=none; b=m3qHr3B5kz3bWh+2dNbTY1sLhCpfoBytreYoXcgzh/vHIkIYrlNSbXuqrlMs44DMcDXsIBcie5kGDDK5LVrafeYenk6gKcgJ2E3BAbtFF02teVKzTljCOzXOKeuDZ2ClzXA0tJ8kCw1+G2zPGg8s/qeU4OeajOGeG1rLGAdT5qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721456476; c=relaxed/simple;
	bh=tyUd4y28OguMWyV/boph8Ima1IPUt4X/+btxrq6wjQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcVbORJVBP5p2VIHOTZ0XfoT8DW1UGmiQuGG2wgZPwepF6AVifIA8Ns9NSXAuRVCw4H8K1dNgybGYrGNKfzvPtL/hAm7a0qGlhy38QrMRDMzVSNvwnLJnujZpELB+sWIYnjjfBHknwssU49EfdKaXpFGlghb+g/OyCUVNIcdjpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H++6x6Db; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H++6x6Db"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721456475; x=1752992475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tyUd4y28OguMWyV/boph8Ima1IPUt4X/+btxrq6wjQU=;
  b=H++6x6DbU+9pTq3TfZAtA3OralcGZptfcobuJy+/LVj7WPzk4InDIfdV
   JBzTe3qkHJdrlPkLG2VuA5FZoVLDEU4m4wjQu2Le0JjVrvwM++oNvTC0m
   4t84SDFLrXC73sX8SDVxhUofnRqMoEUE0kHRR/8hkZHVRZK0Hrf18qRPc
   N+Aa1oTfPCZmus6QLcAFS6+VjC92vLfM/odQqbqTFuW24pCxcULplr1VC
   1QkTMYud+Hqe1cQRpKQE0hWpvxzKEAqUoz/au25b6Xh6GssussxC+6lei
   Wq5+4Xy7XnJ/1Bj65iLIDPhBA5ccXJG0ByKOtd0lBmGWSrR0t90/FcAj4
   g==;
X-CSE-ConnectionGUID: zPdMr1f4RE2q8tlJTzCh7w==
X-CSE-MsgGUID: XJX34GiFT6W6h3V/ZmUMgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="12630504"
X-IronPort-AV: E=Sophos;i="6.09,222,1716274800"; 
   d="scan'208";a="12630504"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 23:21:14 -0700
X-CSE-ConnectionGUID: uB/Pf8FESbiLOYQM3cgy/w==
X-CSE-MsgGUID: rvjQgAXGTTasZcLUB2fKbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,222,1716274800"; 
   d="scan'208";a="51403602"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa010.fm.intel.com with ESMTP; 19 Jul 2024 23:21:13 -0700
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
Subject: [RFC PATCH v18 7/8] perf Document: Add TPEBS to Documents
Date: Sat, 20 Jul 2024 02:21:00 -0400
Message-ID: <20240720062102.444578-8-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240720062102.444578-1-weilin.wang@intel.com>
References: <20240720062102.444578-1-weilin.wang@intel.com>
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

