Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC3419F464;
	Wed,  5 Mar 2025 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192783; cv=none; b=GpwsEKJ2f8SlGh/Qit/8CJ66RLlQ8/KwkjI5nZBeSUIurxbYAUTd8wck8nHDjYfzMqwuAIliuTr9tfP83dC8Lw74qiy8zaYyUmZps3SUOt+mFLtoJxFXrQ5PZIYtiGNBE9r4dR4nQySGi1okdx6R1sjrWeReqAsNNiwhn4yvGWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192783; c=relaxed/simple;
	bh=efGm+CDj3LTdh3alC0Ckg9zTZdQqJT1m6V4O4rKRtjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ehAuIxmPvsE3uyx4YXZD9Zu0Zpwm4lEULcpTQlEjd9UzxxrBxM3ZvfI9NVi9bz4M6/FfjMP14CvOGEpbZapmpKxMYa/M/CzK2wz1wfnIYz82wCPxa3D9F6mIug4hXWlUs0vsvenkboiloG267nec4uF0X4kIlYjuKz5FZKjQ4ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MDwAySty; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDwAySty"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741192782; x=1772728782;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=efGm+CDj3LTdh3alC0Ckg9zTZdQqJT1m6V4O4rKRtjM=;
  b=MDwAyStytZR/pu6vPH7I/HQPWrMZ9MfvZRDW8+0CwrTM/6qgC++9Lqlh
   QCFQhzaDYyYn0pVdWmR3Vvk+LvUtFZ2kApn0oH0sRjYr1/ZB7FIbAsfKh
   igbCR/i2hCMsADcRPfT3okdDzO/LjYa0YGFA2KJnbiYETbXiH6p2vG9H5
   6pJ/mzaUiJJYj183ZAfrcOFFhSA9lH8Zudga4qyWy3bg8aFpcxZx2C6ws
   AHdU/rgVcVFIIWc1nDm/jWarTEFUvRxdvD2OhcnhHK+wxqsH7PStUO3Bj
   BMsrBzXwdprHDNHXYpmSkvI6Bg8AxqqnhNcbriBxWAfhP1YiZNcbwWYIV
   g==;
X-CSE-ConnectionGUID: H08mWiDxToStllL4udwpKg==
X-CSE-MsgGUID: i5GkMpPDRD25LOx3JXGTJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="45821660"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="45821660"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 08:39:40 -0800
X-CSE-ConnectionGUID: IGB1P7FESDi+JSbZoysNvw==
X-CSE-MsgGUID: 1eAEE1b/QWaqNRUn2JTvxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119251836"
Received: from tfalcon-desk.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.222.229])
  by orviesa007.jf.intel.com with ESMTP; 05 Mar 2025 08:39:39 -0800
From: Thomas Falcon <thomas.falcon@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Thomas Falcon <thomas.falcon@intel.com>,
	Kan Liang <kan.liang@intel.com>
Subject: [PATCH v6] perf script: Fix output type for dynamically allocated core PMU's
Date: Wed,  5 Mar 2025 10:39:35 -0600
Message-ID: <20250305163935.1605312-1-thomas.falcon@intel.com>
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
Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
v2: restrict pmu lookup to platforms with more than one core pmu
v3: only scan core pmu list
v4: rebase on top of Arnaldo's patch
v5: update based on Namhyung's feedback here
https://lore.kernel.org/lkml/Z8YcOidenzGofq7R@google.com/
v6: update based on Ian's feedback here
https://lore.kernel.org/linux-perf-users/CAP-5=fVwrG5ZViysO7qKYUw0326WFfa7nOzwe70drYfHq=AXhA@mail.gmail.com/
---

 tools/perf/builtin-script.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index d797cec4f054..253c4ca395e1 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -400,10 +400,20 @@ static inline int output_type(unsigned int type)
 
 static inline int evsel__output_type(struct evsel *evsel)
 {
-	if (evsel->script_output_type == OUTPUT_TYPE_UNSET)
-		evsel->script_output_type = output_type(evsel->core.attr.type);
+	int type = evsel->script_output_type;
 
-	return evsel->script_output_type;
+	if (type == OUTPUT_TYPE_UNSET) {
+		type = output_type(evsel->core.attr.type);
+		if (type == OUTPUT_TYPE_OTHER) {
+			struct perf_pmu *pmu = evsel__find_pmu(evsel);
+
+			if (pmu && pmu->is_core)
+				type = PERF_TYPE_RAW;
+		}
+		evsel->script_output_type = type;
+	}
+
+	return type;
 }
 
 static bool output_set_by_user(void)
-- 
2.48.1

