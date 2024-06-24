Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148831A2C0E;
	Mon, 24 Jun 2024 22:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267653; cv=none; b=RdeWouovBKcTmDWzq0gQyRV7dokF5cD9XyY42J2U5UnyRWhHIGT1lTGGo8fCsSm8Qel/GVklzFn0yJJdqOuZCnpxpFpz5X5Q8oaEAbX5RrAN2K1h/5xsDctKs5cqz3PxRb6Uvh8dJpfvDcpz9C9m072wCZ2rTMl2685jB7ocOAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267653; c=relaxed/simple;
	bh=JFZfvPynPzZ2TE0Vt2lqzId/TgulfeakQxZrwtr+l44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZT90DKzX2sEGMEwUSgZBxHAelVroJAZzwY8IWTCEV/WnUcbAYu5uRvJDYwwpNO8YInC6rqEPebI9IINSaq4Fz5S7ik2PkhX3DZaOPfLSbvfLRO2czqpiq+g2CaNccmKrR1eIVRKemrjEISLCZnobMkEAMltOJ+QXaaDimfrZF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I26157Gu; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I26157Gu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719267652; x=1750803652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JFZfvPynPzZ2TE0Vt2lqzId/TgulfeakQxZrwtr+l44=;
  b=I26157Gu+UlG/DAF8jK58DKJhJ2VWvWFDjhhU3JZ0fM+QuHXpkyDzsJu
   rrZCh6HfofW5aRiqZgTVSCMxsmQDE3YwT3e7CkbLk4jeoMwiaYUlwmcGh
   96WmDmvuAlL2uMQ6fv6m2EkKIoQiYM4ofysnGGrtToMtyWUYi4CbQz8pV
   qc1u3LfKfSFlPGmXz2J2pidcqzISTyRFvsBm/6lG8mbX9HBUMW1MUCGXg
   Hdwi0UjI7mimkzjFPQjjud4yIlRBLNpmnRo3N+CIsxlCmgTF4DmcCyioe
   Wnb0NWILTpAp3Iia64Iuqjux1YXaBy9vEAJkjxoB4kAsA27QY3ziWxsX3
   w==;
X-CSE-ConnectionGUID: 50MYMzaET9OtweGXnxVOlQ==
X-CSE-MsgGUID: 81vFxUFxQOaSK1d5YTuUTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="41681634"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="41681634"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 15:20:46 -0700
X-CSE-ConnectionGUID: M2XptfFWT1KgEFEkS/y5CA==
X-CSE-MsgGUID: zngh0iadQQ6PDnZjSpBn4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="48608236"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa004.jf.intel.com with ESMTP; 24 Jun 2024 15:20:46 -0700
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
Subject: [RFC PATCH v14 7/8] perf Document: Add TPEBS to Documents
Date: Mon, 24 Jun 2024 18:20:23 -0400
Message-ID: <20240624222026.229401-8-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240624222026.229401-1-weilin.wang@intel.com>
References: <20240624222026.229401-1-weilin.wang@intel.com>
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
index ae0aee86844f..98e5503552f5 100644
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
+	perf stat -M metric_name --enable-tpebs-recording ...
+
+
 
 [1] https://software.intel.com/en-us/top-down-microarchitecture-analysis-method-win
 [2] https://sites.google.com/site/analysismethods/yasin-pubs
-- 
2.43.0

