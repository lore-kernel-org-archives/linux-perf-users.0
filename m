Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77E214B064;
	Tue, 25 Jun 2024 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719312353; cv=none; b=oMRaOwTT4GEHPxLFOX5YtVtJ3u7h3RVP8hhSjPuaGApyc8EEp4AhMr6nCLahziG5LruwQjj3/dwhvWCAGA98AVU+2rzMV1n0l34amFG6SamyNqC3JO7HrQGNoPUDHupUg8v50ZtRtHFcLhtk3EIxAHL+C0B4BpjM378HzdPNrrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719312353; c=relaxed/simple;
	bh=VJPVCROmtOiH6sjFGzeDB78N5WlBrQkj9XvlsKi//L4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=alD6t0BJw8lJ1Fj2cBW8oaUQ+vaAgfjVoy8LTJEW4uUPfejhHa5VknCgkd1uxFZ+4NuBrKFYHK3BFCyL20mfBTLKqhCm661DaxOk9kyDR6OCu5xohLHWcLTnhkOQFofOeomv9HsKfOiDsvBsAThGVTYSPUQzBJXAHOaTCyFLLbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QCd8uB++; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QCd8uB++"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719312351; x=1750848351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VJPVCROmtOiH6sjFGzeDB78N5WlBrQkj9XvlsKi//L4=;
  b=QCd8uB++E70lTaUs28UfHkJPOodC5Qb+17i3UdukvH8E6bADB4BnpMHL
   dAzKegjPpVtRJHV7keXyHLFDCoyWDpZi197oanYvDUxP8+bVQFlbr+ZQq
   uE6l0xKTLhhhXZvFGRvYjKCoaNHnQZiv+QKCzyS7gxVWJnceyNM1cUbgO
   rW3bs1+mqJ8kR6F7RuWVa4awB+6SrwKkNLW3eipZefPQJffbAF0u+hz8R
   3UivFdt0HW2Ug3ZJKlzeDnAoUKbfJcU2ZfpEQi999YY3hsvrgCLjO5/Sa
   jlCBkNhX+++/TGS4f+hvg60JaFsBbl3w1783n5XF0L0dHJjC+7IBN/v2C
   Q==;
X-CSE-ConnectionGUID: 8If3fibVTgCZExxgCYrKcg==
X-CSE-MsgGUID: OCs1vZCZRuK8iWhS77Twrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="26944152"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="26944152"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 03:45:51 -0700
X-CSE-ConnectionGUID: t6mhsIm6TlirH7izwFEGMQ==
X-CSE-MsgGUID: h6zD50IlRFGH+gPHSEUuCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="43676519"
Received: from gcivario-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.246.48.191])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 03:45:48 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/2] perf intel-pt: Fix exclude_guest setting
Date: Tue, 25 Jun 2024 13:45:32 +0300
Message-Id: <20240625104532.11990-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625104532.11990-1-adrian.hunter@intel.com>
References: <20240625104532.11990-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

In the past, the exclude_guest setting has had no effect on Intel PT
tracing, but that may not be the case in the future.

Set the flag correctly based upon whether KVM is using Intel PT
"Host/Guest" mode, which is determined by the kvm_intel module
parameter pt_mode:

 pt_mode=0	System-wide mode : host and guest output to host buffer
 pt_mode=1	Host/Guest mode : host/guest output to host/guest
                buffers respectively

Fixes: 6e86bfdc4a60 ("perf intel-pt: Support decoding of guest kernel")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index c8fa15f280d2..4b710e875953 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -32,6 +32,7 @@
 #include "../../../util/tsc.h"
 #include <internal/lib.h> // page_size
 #include "../../../util/intel-pt.h"
+#include <api/fs/fs.h>
 
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
@@ -428,6 +429,16 @@ static int intel_pt_track_switches(struct evlist *evlist)
 }
 #endif
 
+static bool intel_pt_exclude_guest(void)
+{
+	int pt_mode;
+
+	if (sysfs__read_int("module/kvm_intel/parameters/pt_mode", &pt_mode))
+		pt_mode = 0;
+
+	return pt_mode == 1;
+}
+
 static void intel_pt_valid_str(char *str, size_t len, u64 valid)
 {
 	unsigned int val, last = 0, state = 1;
@@ -620,6 +631,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 			}
 			evsel->core.attr.freq = 0;
 			evsel->core.attr.sample_period = 1;
+			evsel->core.attr.exclude_guest = intel_pt_exclude_guest();
 			evsel->no_aux_samples = true;
 			evsel->needs_auxtrace_mmap = true;
 			intel_pt_evsel = evsel;
-- 
2.34.1

