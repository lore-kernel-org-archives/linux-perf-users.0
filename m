Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1E951C4A;
	Fri, 13 Dec 2024 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120674; cv=none; b=Lg40aGkFUtcHu+iEYb4udsi3SN9exaDZw2mephyoTwk4FN5DdrumAk7rwbiJlEZdl2hQUIEEfD5ZXLFWArWI2yJcZgSc6QyAKkVkHV6n99g/MVRt6wtHG/LGbNLUTSIkEKBSj5rARzQc6+Q7DunIYhJtX1MVirb+BQAoexRCJ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120674; c=relaxed/simple;
	bh=RdfBH9CgYtewdakDMNkp1oZYS1G9Ms+PgnDA1aP7iws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AD7mJcUXS5RRTEare/n1eq6cDBkB0CGB8ulwx5GyfC7MY/Aax7FyAhf5r//d4JlwL/pEb+4kIMAzHRGThq8MNJ/sSaBj1K3EAKsM5MWMbGputYRABrXVCVcM2HZBKGqvuzA96Q13UlyEm5nnHRkqsY+d3an1h14AZdOT7pOnsrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hlLKAtD3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hlLKAtD3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734120671; x=1765656671;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RdfBH9CgYtewdakDMNkp1oZYS1G9Ms+PgnDA1aP7iws=;
  b=hlLKAtD3FUMmvzvD0xAgzbgNdZV+UMIoKBF1/sWE5XdApfZnQ3NbvxUa
   nXWvUw5nxVTCJay3EvXDgeuvQhdMrt7sq4zkA9ApxVNUxf/p5USMgi6+R
   MKH0S2tOzDEuHNUXX3oEPjy6N4OWP+CI/UfpQsdsAHWvtQhst7TDagVit
   Ym/gdSL7MD60itRm98zGX3wDa+Rugti1Jaa0LNNOUwuc3BFgvcR+d7ZfZ
   X22VHO/3nfF/SFbKO4wSiI8wTIAbS6337PtotvIvXY/TFr2havD/0Gvum
   dj3H3yrwwBsAldabk9dCvnlj6Hb9Twrh7ywjF7TA8hYb8MbeMxALxoqWF
   w==;
X-CSE-ConnectionGUID: W3deHpskR3aa+tqY/YrONw==
X-CSE-MsgGUID: uXkizGaHQKOgw2GbIt/AiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="38518210"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="38518210"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 12:11:11 -0800
X-CSE-ConnectionGUID: y5fdv+teR0C5C7FpI0Ypow==
X-CSE-MsgGUID: yhZkC3QwSoSEdy+MeOsm1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,232,1728975600"; 
   d="scan'208";a="96507188"
Received: from tfalcon-desk.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.223.114])
  by fmviesa007.fm.intel.com with ESMTP; 13 Dec 2024 12:11:09 -0800
From: Thomas Falcon <thomas.falcon@intel.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: ravi.bangoria@amd.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: [PATCH v2] perf script: Fix output type for dynamically allocated core PMU's
Date: Fri, 13 Dec 2024 14:11:09 -0600
Message-ID: <20241213201109.630658-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Suggested-by: Kan Liang <kan.liang@intel.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
v2: restrict pmu lookup to platforms with more than one core pmu
---
 tools/perf/builtin-script.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 9e47905f75a6..459794c737ce 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -384,6 +384,18 @@ static int evsel_script__fprintf(struct evsel_script *es, FILE *fp)
 		       st.st_size / 1024.0 / 1024.0, es->filename, es->samples);
 }
 
+static bool output_type_many_core_pmus(unsigned int type)
+{
+	struct perf_pmu *pmu;
+
+	if (perf_pmus__num_core_pmus() > 1) {
+		pmu = perf_pmus__find_by_type(type);
+		if (pmu && pmu->is_core)
+			return true;
+	}
+	return false;
+}
+
 static inline int output_type(unsigned int type)
 {
 	switch (type) {
@@ -394,6 +406,9 @@ static inline int output_type(unsigned int type)
 			return type;
 	}
 
+	if (output_type_many_core_pmus(type))
+		return PERF_TYPE_RAW;
+
 	return OUTPUT_TYPE_OTHER;
 }
 
-- 
2.47.1

