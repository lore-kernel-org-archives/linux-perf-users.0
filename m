Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD7D1917C7;
	Fri, 13 Dec 2024 21:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734126865; cv=none; b=qmptuzgRnYfrseCJvMlPyG2TXGzAK5Ek2xpscGJms3xEAnn3/nMn3RnBpi5CT12F9cFBSNNUc6DK4Tln0OAlZSdgAH+aYniD1Ul0fYcVvIwp0rn11B+v40wY4Sfk0RXrRihwZBsBEPaa8B4xvY6flCqTBTLJUVdztcSI7rm2O4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734126865; c=relaxed/simple;
	bh=IguZmxeB+5sRbxSSNN7lLV+iorfglNnB8i3GQDbaXWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g2bGictiW5hFYwgjOb2N22AHZg+O4PLGW7schzZsLKbZ6T+50pO2rhsdUZK/93B3fxLglyCrIWtwdEUgnEQtYnU5QUzLtFtrNGneR+2PeXRcS0wAWragNiSeuEtFu0/5Q9fXr3RLDMsE5ViSEt24FSQjDnxBHu8GfN3dgGtf9hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WH6rMcmi; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WH6rMcmi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734126864; x=1765662864;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IguZmxeB+5sRbxSSNN7lLV+iorfglNnB8i3GQDbaXWY=;
  b=WH6rMcmiIe+hXN57TGMy7DOmARNuLOqILG2FBqE/B8a3dWvntfViobZD
   Xwe2CdBEz/LaUZNdIZ+p0qKXWG526q3b0ptJ235bGxGHVJ83n3TTykwB2
   lyusK3XvE7g8ln0LadUGZwbNGgAXBvFR5ia5PsMMHirrufOqOT1ETeBmT
   eBMM3XCqhd+7LzoFh4TPtR+dBW5ZYwsMtPRTmDKzPMY7s2YYpOh2alJ/G
   0Wo+z4SjEf+wn+rLUGFdYWrC/PvJ4SbccpB10kqFIZe7R7ktWw3iNPXBa
   qCVP9gHu87EeMXXtizbaAfZGOdJGNvjQyj97loOzpTz8W/mD3CXl+qWy6
   w==;
X-CSE-ConnectionGUID: 5BTtnKWTRuClF05UgTed6Q==
X-CSE-MsgGUID: sm93y+3sSn6vJMpGmVw5XQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="45281659"
X-IronPort-AV: E=Sophos;i="6.12,232,1728975600"; 
   d="scan'208";a="45281659"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 13:54:23 -0800
X-CSE-ConnectionGUID: j0ljZYx4Tt2wozB2NMgpAg==
X-CSE-MsgGUID: n6kvB9UsSVOfmUJnFjO9VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,232,1728975600"; 
   d="scan'208";a="96704530"
Received: from tfalcon-desk.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.223.114])
  by orviesa006.jf.intel.com with ESMTP; 13 Dec 2024 13:54:22 -0800
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
Subject: [PATCH v3] perf script: Fix output type for dynamically allocated core PMU's
Date: Fri, 13 Dec 2024 15:54:21 -0600
Message-ID: <20241213215421.661139-1-thomas.falcon@intel.com>
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
v3: only scan core pmu list
---
 tools/perf/builtin-script.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 9e47905f75a6..685232883f9c 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -384,6 +384,19 @@ static int evsel_script__fprintf(struct evsel_script *es, FILE *fp)
 		       st.st_size / 1024.0 / 1024.0, es->filename, es->samples);
 }
 
+static bool output_type_many_core_pmus(unsigned int type)
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
 static inline int output_type(unsigned int type)
 {
 	switch (type) {
@@ -394,6 +407,9 @@ static inline int output_type(unsigned int type)
 			return type;
 	}
 
+	if (output_type_many_core_pmus(type))
+		return PERF_TYPE_RAW;
+
 	return OUTPUT_TYPE_OTHER;
 }
 
-- 
2.47.1

