Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1465713666D;
	Thu, 13 Jun 2024 03:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718249804; cv=none; b=VdXHAqNXmzAcTBaEYN30iki6WfuckWTFdVrA/N49gbEM+fPaOstUXjv4TaknuLiEC+sYVkGjWRRHJKem4iGfAlMLcW7DJGdQCG7q26AFWywrhfzcuW9oiMNWPzYXUf0ym1QI84pPyf+HF8OsuT9UAjN025UIvdRdh8Lg2RmtAGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718249804; c=relaxed/simple;
	bh=JFZfvPynPzZ2TE0Vt2lqzId/TgulfeakQxZrwtr+l44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uInDL+4kvZlNlqo4wcrtWAxMPq8qbdlBpgAeguRh+dpR/JSHmrLoTDpRTajUkRmA8gVkjaIeilI15Jw55JecE7EAxx/mCDZD0QhOAY5A9AYYWAAdclQ1NgDLebg02JZXrCqew16cfGYOsepUa7yFxCA0s4qxaMPsX08GRMJOB8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ixWRxnm2; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixWRxnm2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718249803; x=1749785803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JFZfvPynPzZ2TE0Vt2lqzId/TgulfeakQxZrwtr+l44=;
  b=ixWRxnm2kaNCJS2HKNAAZ1KXL3K0D8/rRcBClcfyhP9jXNTs3q1ru0NW
   9/+rCx6YaDzrkPfyANC6gbSG6KEFD7S3fpFw+R+q1400p6Ez6/iyPNctM
   s70YwFF4mNww2bDK7IcKJQ6IymMXxm+dqYXtTv7CIKFl8P21ibz54zOjM
   ddrnTpUh0IkKCfgoa2gHWxslVdpOrspJBgVHCKKGQtk2K+z9W03cgg5/h
   5TUYagk7CUGnHITnb8krM2gd9YHJXeW1RhsMF+b895QRpZ4xEHbEEuPQu
   IZnuvqK0Dj3iuqIdbV1Nh38QAgEKvhpxl0Rk6t1BzcWD4tRDM1GRECTkz
   g==;
X-CSE-ConnectionGUID: Kq6diIcRTiiHp9TFbVdANA==
X-CSE-MsgGUID: My6/dnQ2TsW+gsP8PwtSzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="12046737"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="12046737"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 20:36:39 -0700
X-CSE-ConnectionGUID: 1rXSz66pSeqqJju3ZDKt6Q==
X-CSE-MsgGUID: 00C4zS9rSt6TRbttx+t4Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40100366"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa009.fm.intel.com with ESMTP; 12 Jun 2024 20:36:38 -0700
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
Subject: [RFC PATCH v13 8/9] perf Document: Add TPEBS to Documents
Date: Wed, 12 Jun 2024 23:36:28 -0400
Message-ID: <20240613033631.199800-9-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613033631.199800-1-weilin.wang@intel.com>
References: <20240613033631.199800-1-weilin.wang@intel.com>
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

