Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA3E188000;
	Tue,  5 Aug 2025 00:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754354864; cv=none; b=XVJRz7cjtzby8cq/e5CfryVuO86C2wAhoOrNtIpZxrTz9enlTp0OLrn78+LnLLeiEhE8c9CG6rH4XlZlYUwsmAfwvhAc00fa/nA9ZUnfDtB6XFcf0q5tsMKG2wO1aZ+VVDByGeF9i+A0aIaHbSDqZ/2rPPpNOxDOWHLh8w3K+cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754354864; c=relaxed/simple;
	bh=IzdlHI5Ro6VDslLSUBRO1HRkoYye4pQ+c9AMu/X1eoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HIBI48oJAffttxCDD69D2ivum8bfF/6W1QHZ+tTkcsrY4l5u4OboIAtFSOteF046L0spxWZ7y0LsiEKA4bbzFWgfFrA/Vy6JW/gbKnsjmKXN0zWsmbbiCZ/dh0PXQQpLcIgAVHHJ9YnCHSRcSqnPuf/pfv/L+Bn68XJ2yVUmIjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X6Q9GBvA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X6Q9GBvA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754354864; x=1785890864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IzdlHI5Ro6VDslLSUBRO1HRkoYye4pQ+c9AMu/X1eoE=;
  b=X6Q9GBvARG6zrf2WGWYZgref1oG7vNm691W9pLSVn4RFU0BLBjTSHy5N
   ajc11UCi4vnQLjdU2eNDxo+AZJngGUVrxHumHx8XHtD6ShLOH7s95zKcw
   I+czBo+TkJ4mDekVANbB/slfFRsX097fqj6US83icNLzb4KHQJr2swb3/
   i7Y5bUlHMWJfzxiww7Q9u/AsW+srgDwILbro8aXYRhmdVvGl5gfRp4mzc
   KB/etzuNgdgAcFVw9YB/omJocUfxQhedA2noxlz+/XGwmyZxjXCRQ8wCY
   +9lHpnPUWaKVWc2NcnXKZ3uI0NnxDWaz3pa8zl4KakLWWK29Yh4EueGVR
   w==;
X-CSE-ConnectionGUID: CcHB35WCRRKM4jftXIPHng==
X-CSE-MsgGUID: 8OARCoAnSBalzzG3pTNXHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="56523847"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="56523847"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 17:47:43 -0700
X-CSE-ConnectionGUID: uYUfnBylQh+bf0nfd6TwJw==
X-CSE-MsgGUID: KkBycsUxThKNfurZMZYERw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="169605472"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa004.fm.intel.com with ESMTP; 04 Aug 2025 17:47:40 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 4/5] perf tools kvm: Use "cycles" to sample guest for "kvm record" on Intel
Date: Tue,  5 Aug 2025 08:46:32 +0800
Message-Id: <20250805004633.135904-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805004633.135904-1-dapeng1.mi@linux.intel.com>
References: <20250805004633.135904-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After KVM supports PEBS for guest on Intel platforms
(https://lore.kernel.org/all/20220411101946.20262-1-likexu@tencent.com/),
host loses the capability to sample guest with PEBS since all PEBS related
MSRs are switched to guest value after vm-entry, like IA32_DS_AREA MSR is
switched to guest GVA at vm-entry. This would lead to "perf kvm record"
fails to sample guest on Intel platforms since "cycles:P" event is used to
sample guest by default as below case shows.

sudo perf kvm record -a
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.787 MB perf.data.guest ]

So to ensure guest record can be sampled successfully, use "cycles"
instead of "cycles:P" to sample guest record by default on Intel
platforms. With this patch, the guest record can be sampled
successfully.

sudo perf kvm record -a
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.783 MB perf.data.guest (23 samples) ]

Reported-by: Kevin Tian <kevin.tian@intel.com>
Fixes: 634d36f82517 ("perf record: Just use "cycles:P" as the default event")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/arch/x86/util/kvm-stat.c | 46 +++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
index 424716518b75..cdb5f3e1b5be 100644
--- a/tools/perf/arch/x86/util/kvm-stat.c
+++ b/tools/perf/arch/x86/util/kvm-stat.c
@@ -3,9 +3,11 @@
 #include <string.h>
 #include "../../../util/kvm-stat.h"
 #include "../../../util/evsel.h"
+#include "../../../util/env.h"
 #include <asm/svm.h>
 #include <asm/vmx.h>
 #include <asm/kvm.h>
+#include <subcmd/parse-options.h>
 
 define_exit_reasons_table(vmx_exit_reasons, VMX_EXIT_REASONS);
 define_exit_reasons_table(svm_exit_reasons, SVM_EXIT_REASONS);
@@ -211,3 +213,47 @@ int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
 
 	return 0;
 }
+
+/*
+ * After KVM supports PEBS for guest on Intel platforms
+ * (https://lore.kernel.org/all/20220411101946.20262-1-likexu@tencent.com/),
+ * host loses the capability to sample guest with PEBS since all PEBS related
+ * MSRs are switched to guest value after vm-entry, like IA32_DS_AREA MSR is
+ * switched to guest GVA at vm-entry. This would lead to "perf kvm record"
+ * fails to sample guest on Intel platforms since "cycles:P" event is used to
+ * sample guest by default.
+ *
+ * So, to avoid this issue explicitly use "cycles" instead of "cycles:P" event
+ * by default to sample guest on Intel platforms.
+ */
+int kvm_add_default_arch_event(int *argc, const char **argv)
+{
+	const char **tmp;
+	bool event = false;
+	int i, j = *argc;
+
+	const struct option event_options[] = {
+		OPT_BOOLEAN('e', "event", &event, NULL),
+		OPT_END()
+	};
+
+	if (!x86__is_intel_cpu())
+		return 0;
+
+	tmp = calloc(j + 1, sizeof(char *));
+	if (!tmp)
+		return -EINVAL;
+
+	for (i = 0; i < j; i++)
+		tmp[i] = argv[i];
+
+	parse_options(j, tmp, event_options, NULL, PARSE_OPT_KEEP_UNKNOWN);
+	if (!event) {
+		argv[j++] = strdup("-e");
+		argv[j++] = strdup("cycles");
+		*argc += 2;
+	}
+
+	free(tmp);
+	return 0;
+}
-- 
2.34.1

