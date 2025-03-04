Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53E5137923;
	Tue,  4 Mar 2025 01:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741052369; cv=none; b=WJTatFzwgtTW2NckcKn3AcUnPFWF74JzoBG3LuP/Lw3PRvi3ltND0P5WzknAa2imYLWn1MTLgSuqgo6JLu6WkaEVRhtmaBW838cc1RVBmv70KYHBQ4wcO5AOgoRvDHvw7giIKsZKE8J5n+CaA4F8xKy47O5H4j4+0GJ0ncVAkME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741052369; c=relaxed/simple;
	bh=zrZv3vV9jJm1D8ekGuxLw32tz/A467tuDzGpCfD3QfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jlTCvEyG/h4DwXDK6QFQfd02kD7aVgnI6gDWF7K+l3qS0Y5S/JqSVTyo4/9pKa/6qWz6T76zbGJRh2YO5OGbtdUCJw2U8R9JmMi8zRrixuzKm72X4hNgu9cg1mXu2OnQMVJ/VgHrVu0EYMOsdxVG0r3z/AJE3sMdDrtjYuVPQCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XfYylDbT; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XfYylDbT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741052368; x=1772588368;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zrZv3vV9jJm1D8ekGuxLw32tz/A467tuDzGpCfD3QfM=;
  b=XfYylDbTMJLXIyAD36aMTPcbgwGJkUMrQOMtKQ0PrhQHYgPKQA9Q3ZVp
   zD7RsmFxX7ecwe0T5DsaHzcZ9HOX1Ij4SctIGFgSzVQ9X0Wft/DCJKMo5
   gCBfT2n+LysfmBDIy34EWkFPVO05BxzApFlxas2mksFu9HG/KvYGbRSx2
   O1kRVPfGQD95Qemv4F9cvWudMMFr9v12EC4XAlGt6L9AxMuDsXsCEts4C
   rFvzpdX54KfGjzEpHVLaiH0ig8hicF/zgwVtHlGFFSATqbJkpBS8uFT2o
   259DxZyIQOHdlhR1v8anvNRPhLfa3zmSAFwJpB0g1A0yXQuEgIhq/GKb4
   A==;
X-CSE-ConnectionGUID: jyknJCbnQL6zmhDAh5lv1g==
X-CSE-MsgGUID: JD9j/Rj8R+SfCLavwGDLWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41197903"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41197903"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 17:39:27 -0800
X-CSE-ConnectionGUID: 60ERKnysRbmJQYhbUH/5kQ==
X-CSE-MsgGUID: 7QtDB9adRY+zzZqgK0F4Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="123166323"
Received: from tfalcon-desk.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.221.194])
  by orviesa003.jf.intel.com with ESMTP; 03 Mar 2025 17:39:24 -0800
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
Subject: [PATCH v5] perf script: Fix output type for dynamically allocated core PMU's
Date: Mon,  3 Mar 2025 19:39:06 -0600
Message-ID: <20250304013906.1393102-1-thomas.falcon@intel.com>
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
v5: update based on Namhyung's feedback here
https://lore.kernel.org/lkml/Z8YcOidenzGofq7R@google.com/
---
 tools/perf/builtin-script.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index d797cec4f054..4d2764df48a0 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -385,6 +385,19 @@ static int evsel_script__fprintf(struct evsel_script *es, FILE *fp)
 		       st.st_size / 1024.0 / 1024.0, es->filename, es->samples);
 }
 
+static bool is_core_pmu_type(unsigned int type)
+{
+	struct perf_pmu *pmu = NULL;
+
+	if (perf_pmus__num_core_pmus() > 1) {
+		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+			if (pmu->type == type)
+				return true;
+		}
+	}
+	return type == PERF_TYPE_RAW;
+}
+
 static inline int output_type(unsigned int type)
 {
 	switch (type) {
@@ -395,6 +408,9 @@ static inline int output_type(unsigned int type)
 			return type;
 	}
 
+	if (is_core_pmu_type(type))
+		return PERF_TYPE_RAW;
+
 	return OUTPUT_TYPE_OTHER;
 }
 
-- 
2.48.1

