Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8E925E459;
	Mon, 12 May 2025 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042790; cv=none; b=Ey1xfb6R3XextgsaUYRXexwxxaNaFg49H4QRXhY2KERzZh+bA6kESX1yCJfecdqJTXbTv9HWPFqvH+j+6blXyuv7jTSuG/wV5QvGUZ49RWpswKnXpF0flF6jvFl2ewh7k3gIYvrDhmk4OeDbSLfLbfTlrag5YzbleJTbbaYfrfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042790; c=relaxed/simple;
	bh=+JPZFrLeHan5qO0lHyWxoXHqqYbfROkWGRmWraQxI0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPGIYBD7iFOXJaWR48ihHtZudNDnhW1rGQXXYv7sJ8OpQqp+ap5ESdhM9vS/41J3Je9Cz/hEkdwCax4MRPCRiruInJ2RBcXn+vZ1ZN65PdR26oZH43lu4o4swyJRdl7J4x/bGf+lDUV/DmQRB5cHrU5DJ1RyaWEL5rx7nholsII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HKSfHYnF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HKSfHYnF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747042789; x=1778578789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+JPZFrLeHan5qO0lHyWxoXHqqYbfROkWGRmWraQxI0Q=;
  b=HKSfHYnFqDgsmu71xkI1iYwlzXJJoLiaaRWLHe3kVo0nhN4XTwkGkxqr
   fxK8kxr4LY3c9AaHno0MqUW7Q9NA/TYg86HNr4F51yiSNHtg56OpaLgR7
   +6XHJCaAC7Oip/1EMRvSyegFY2QIWu6GUaoKdfcRN40TVsORf0vHDZyCd
   4Bi89Q9CCVY8e7HRsVutZPhAy19GSW3S2bVffu2TeLdfR7fS7L3yMMklS
   wdlzz5aI7p58XUT/NrA77GBp1E6oiOlIhb5lGGHgRTJiUe1D+w2VhEafJ
   ibuIU8sjcGazC+HWwDgqW5krG0FmDmB9xNiNPegLkCWKEZB7ITypDM+vF
   Q==;
X-CSE-ConnectionGUID: 86Y+fkgQRkK7QDxYBl1C5w==
X-CSE-MsgGUID: 88JXl+zYS46iQUXCJQyIeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="36457530"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="36457530"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 02:39:49 -0700
X-CSE-ConnectionGUID: VXHpmoIzSQqzjl2rhyMMww==
X-CSE-MsgGUID: xgyaBwUDTE2oZdfVzNJKeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="142214304"
Received: from bvivekan-mobl1.gar.corp.intel.com (HELO localhost.localdomain) ([10.245.245.139])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 02:39:46 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/3] perf intel-pt: Do not default to recording all switch events
Date: Mon, 12 May 2025 12:39:31 +0300
Message-ID: <20250512093932.79854-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250512093932.79854-1-adrian.hunter@intel.com>
References: <20250512093932.79854-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

On systems with many CPUs, recording extra context switch events can be
excessive and unnecessary. Add perf config intel-pt.all-switch-events=false
to control the behaviour.

Example:

 # perf config intel-pt.all-switch-events=false
 # perf record -eintel_pt//u uname
 Linux
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.082 MB perf.data ]
 # perf script -D | grep PERF_RECORD_SWITCH | awk '{print $5}' | uniq -c
       5 PERF_RECORD_SWITCH
 # perf config intel-pt.all-switch-events=true
 # perf record -eintel_pt//u uname
 Linux
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.102 MB perf.data ]
 # perf script -D | grep PERF_RECORD_SWITCH | awk '{print $5}' | uniq -c
     180 PERF_RECORD_SWITCH_CPU_WIDE

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-config.txt |  4 ++++
 tools/perf/arch/x86/util/intel-pt.c      | 16 +++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 36ebebc875ea..c6f335659667 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -708,6 +708,10 @@ intel-pt.*::
 		the maximum is exceeded there will be a "Never-ending loop"
 		error. The default is 100000.
 
+	intel-pt.all-switch-events::
+		If the user has permission to do so, always record all context
+		switch events on all CPUs.
+
 auxtrace.*::
 
 	auxtrace.dumpdir::
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 8f235d8b67b6..add33cb5d1da 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -19,6 +19,7 @@
 #include "../../../util/evlist.h"
 #include "../../../util/evsel.h"
 #include "../../../util/evsel_config.h"
+#include "../../../util/config.h"
 #include "../../../util/cpumap.h"
 #include "../../../util/mmap.h"
 #include <subcmd/parse-options.h>
@@ -52,6 +53,7 @@ struct intel_pt_recording {
 	struct perf_pmu			*intel_pt_pmu;
 	int				have_sched_switch;
 	struct evlist		*evlist;
+	bool				all_switch_events;
 	bool				snapshot_mode;
 	bool				snapshot_init_done;
 	size_t				snapshot_size;
@@ -794,7 +796,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 			bool cpu_wide = !target__none(&opts->target) &&
 					!target__has_task(&opts->target);
 
-			if (!cpu_wide && perf_can_record_cpu_wide()) {
+			if (ptr->all_switch_events && !cpu_wide && perf_can_record_cpu_wide()) {
 				struct evsel *switch_evsel;
 
 				switch_evsel = evlist__add_dummy_on_all_cpus(evlist);
@@ -1178,6 +1180,16 @@ static u64 intel_pt_reference(struct auxtrace_record *itr __maybe_unused)
 	return rdtsc();
 }
 
+static int intel_pt_perf_config(const char *var, const char *value, void *data)
+{
+	struct intel_pt_recording *ptr = data;
+
+	if (!strcmp(var, "intel-pt.all-switch-events"))
+		ptr->all_switch_events = perf_config_bool(var, value);
+
+	return 0;
+}
+
 struct auxtrace_record *intel_pt_recording_init(int *err)
 {
 	struct perf_pmu *intel_pt_pmu = perf_pmus__find(INTEL_PT_PMU_NAME);
@@ -1197,6 +1209,8 @@ struct auxtrace_record *intel_pt_recording_init(int *err)
 		return NULL;
 	}
 
+	perf_config(intel_pt_perf_config, ptr);
+
 	ptr->intel_pt_pmu = intel_pt_pmu;
 	ptr->itr.recording_options = intel_pt_recording_options;
 	ptr->itr.info_priv_size = intel_pt_info_priv_size;
-- 
2.45.2

