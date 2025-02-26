Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018C71DE2A9;
	Wed, 26 Feb 2025 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589252; cv=none; b=LH7Bx7C+KHGI3nC2tD7fLWP7gwp/FAY5YQc3NgGdY8q8kDlstItWP3oDEr+GkB28BWmwVuEYeIqvBIOmgl4aJ/8RpdYOTuC6ICrz+E8MWittLczerHFoHh8i+iQW/5q0CCXZtONsvFt4PkYN/YRcBX+3RPYqxA3tTD3jzkdxXvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589252; c=relaxed/simple;
	bh=MdqkHWUEtv7tjnvc1shi+RAak0dflbv0rf/oThbljPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D7w5U+iHgEUv+/v3IhtZb9DMq44yovMUz0GVmXQsj1tNgeyxyzaHG+j6Qq9HJa9WCYJQB8CutzRMqh0km1z0OYtt7wBRjND2X6O7R87vo9gxY/NlgFkeBjcj86cvdDF5yWxcBMZFX8q3OvX/rLCZAE+qTuXbaP8XxPPvAuP5gJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=miRfNZe+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="miRfNZe+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740589250; x=1772125250;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MdqkHWUEtv7tjnvc1shi+RAak0dflbv0rf/oThbljPQ=;
  b=miRfNZe+9jnrZ3kYF0xVwFDYmwXu7UCnX1h5zSor/s5sOwyolXFV0Spp
   AD6AKuNHah0o9IK1Fqps/bxb52hC7qZNL6jQdkImn8POLVBx7Ja8wZ8dx
   CmrDyESDCkXzqZ4Y81Gvz1sVC5D24WHXjGKZ8kapoO6tZMEAFPouyXsif
   NKD7qH2UABlXuDTdudSvRKlx9T/e1y7RbLYWP4SirwNqk0sJ5adSfzMPB
   mK5DHIgiqVvEFT49mKPsxPJ0fwg9TJVJaOK0U8c3pnoNKK0qvPTpUE15c
   kcDJexJkK8IIzKSmFikAJztnWhVaE05FyUMW5s+Qs3HeDrFQelHCP2y4N
   w==;
X-CSE-ConnectionGUID: b8vKBc5aTUqGBqTbMy0d7w==
X-CSE-MsgGUID: +amB/NTSSHG9rf7UVEzldg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41577104"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="41577104"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 09:00:49 -0800
X-CSE-ConnectionGUID: GekzjP7zTV2iLQdCigxZcw==
X-CSE-MsgGUID: SjUIbYiwSgatyjlq00pQKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="121751950"
Received: from tfalcon-desk.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.220.27])
  by orviesa004.jf.intel.com with ESMTP; 26 Feb 2025 09:00:47 -0800
From: Thomas Falcon <thomas.falcon@intel.com>
To: linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Thomas Falcon <thomas.falcon@intel.com>,
	Kan Liang <kan.liang@intel.com>
Subject: [PATCH v4] perf script: Fix output type for dynamically allocated core PMU's
Date: Wed, 26 Feb 2025 11:00:43 -0600
Message-ID: <20250226170043.762219-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch was originally posted here:

https://lore.kernel.org/all/20241213215421.661139-1-thomas.falcon@intel.com/

I have rebased on top of Arnaldo's patch here:

https://lore.kernel.org/all/Z2XCi3PgstSrV0SE@x1/

The original commit message:
"
perf script output may show different fields on different core PMU's
that exist on heterogeneous platforms. For example,

perf record -e "{cpu_core/mem-loads-aux/,cpu_core/event=0xcd,\
umask=0x01,ldlat=3,name=MEM_UOPS_RETIRED.LOAD_LATENCY/}:upp"\
-c10000 -W -d -a -- sleep 1

perf script:

chromium-browse   46572 [002] 544966.882384:      10000 	cpu_core/MEM_UOPS_RETIRED.LOAD_LATENCY/: 7ffdf1391b0c     10268100142 \
 |OP LOAD|LVL L1 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK    N/A    5   7    0   7fad7c47425d [unknown] (/usr/lib64/libglib-2.0.so.0.8000.3)

perf record -e cpu_atom/event=0xd0,umask=0x05,ldlat=3,\
name=MEM_UOPS_RETIRED.LOAD_LATENCY/upp -c10000 -W -d -a -- sleep 1

perf script:

gnome-control-c  534224 [023] 544951.816227:      10000 cpu_atom/MEM_UOPS_RETIRED.LOAD_LATENCY/:   7f0aaaa0aae0  [unknown] (/usr/lib64/libglib-2.0.so.0.8000.3)

Some fields, such as data_src, are not included by default.

The cause is that while one PMU may be assigned a type such as
PERF_TYPE_RAW, other core PMU's are dynamically allocated at boot time.
If this value does not match an existing PERF_TYPE_X value,
output_type(perf_event_attr.type) will return OUTPUT_TYPE_OTHER.

Instead search for a core PMU with a matching perf_event_attr type
and, if one is found, return PERF_TYPE_RAW to match output of other
core PMU's.
"

Suggested-by: Kan Liang <kan.liang@intel.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
v2: restrict pmu lookup to platforms with more than one core pmu
v3: only scan core pmu list
v4: rebase on top of Arnaldo's patch
---
 tools/perf/builtin-script.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index d797cec4f054..abc860d01420 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -398,10 +398,28 @@ static inline int output_type(unsigned int type)
 	return OUTPUT_TYPE_OTHER;
 }
 
+static bool output_type_check_core_pmus(unsigned int type)
+{
+	struct perf_pmu *pmu = NULL;
+
+	if (perf_pmus__num_core_pmus() > 1) {
+		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+			if (pmu->type == type)
+				return true;
+		}
+	}
+	return false;
+}
+
 static inline int evsel__output_type(struct evsel *evsel)
 {
-	if (evsel->script_output_type == OUTPUT_TYPE_UNSET)
-		evsel->script_output_type = output_type(evsel->core.attr.type);
+	if (evsel->script_output_type == OUTPUT_TYPE_UNSET) {
+		if (output_type(evsel->core.attr.type) == OUTPUT_TYPE_OTHER &&
+		    output_type_check_core_pmus(evsel->core.attr.type))
+			evsel->script_output_type = PERF_TYPE_RAW;
+		else
+			evsel->script_output_type = output_type(evsel->core.attr.type);
+	}
 
 	return evsel->script_output_type;
 }
-- 
2.48.1

