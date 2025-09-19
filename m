Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CEE269D06;
	Fri, 19 Sep 2025 02:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248334; cv=none; b=Mg9dijBGwCI5HeffkbQkx5oJLFTTMTPjXh8uvn2qR0VlAAf3jrFdt77Vr9TUZPQJHpk6RJfgwl1C/c5cq0WRGyc6L01bOB9+zw/7zDaoWwRQNGu0pa3peVw0tTRItwxyG59z2xQ8x42cqt1HVT4L9HEF8k9Wrcog9Ecqp/xs25M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248334; c=relaxed/simple;
	bh=dx9SGPga2mFzGEm1E2rawUr6qE4VPONIHchyygbeaig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u9gPOnXZhLKNpl/MT5g/VN+D1C0CP87dLsH0kkS8R5giD5m6WS4mr8ng1f6gfMJxk6qyyWQdbAdaorzhnNfE7h/G1NGcp5Be4a5rmDFBhMfcUh5ghx7MpUVU2BhyerKOxrOdjLKUvNvKPExoR3J9YUQc2J0veXCPEw/t3vlp6v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PDPFc3lc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PDPFc3lc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758248333; x=1789784333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dx9SGPga2mFzGEm1E2rawUr6qE4VPONIHchyygbeaig=;
  b=PDPFc3lcoVahB1Oxl9/PZRLhFoKMsKYh7mIb6J56IUREI9S9bJiIXsYG
   6cupK6QC6YjxLZI3+FkxdoW4NFPyhDLG7h+pDxKDpHvl1uJqtSJyQGnIm
   mydPNvl1R3W6DjGVAODsz/pGrqArzTZTTQaB0CT/ZLKAqyp8Y7GX9AMAx
   gamTijba17C4CCuNBPUALihnSDJl1DYojx32sULkEO/4oZHWBL9EvKoW1
   Y+z1zlUlNaYGdlSCULLkhgSAq6vgWNHaSHPGlLxu2CRP2hnCYAgjBIyC8
   wqlgS6JuDGKX7digQcnGU98V5nPqGxREHQWU4jOWkt90QD7gCoQdMDNW8
   g==;
X-CSE-ConnectionGUID: wfqrobmKT5uedEtLutQTCQ==
X-CSE-MsgGUID: Ne7LacA5Q3GUYcMEgIuQMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="64229157"
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="64229157"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 19:18:53 -0700
X-CSE-ConnectionGUID: 9YSoNgCJSCyHe5+07ovB0A==
X-CSE-MsgGUID: IVNoqzH5TLOMsMANEnHjNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="175535629"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 18 Sep 2025 19:18:49 -0700
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
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: [Patch v3 5/6] perf tools kvm: Use "cycles" to sample guest for "kvm record" on Intel
Date: Fri, 19 Sep 2025 10:16:58 +0800
Message-Id: <20250919021659.1263351-6-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919021659.1263351-1-dapeng1.mi@linux.intel.com>
References: <20250919021659.1263351-1-dapeng1.mi@linux.intel.com>
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
Fixes: cf8e55fe50df ("KVM: x86/pmu: Expose CPUIDs feature bits PDCM, DS, DTES64")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/x86/util/kvm-stat.c | 51 +++++++++++++++++++++++++++++
 tools/perf/builtin-kvm.c            | 10 ------
 tools/perf/util/kvm-stat.h          | 10 ++++++
 3 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
index 424716518b75..bff36f9345ea 100644
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
@@ -211,3 +213,52 @@ int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
 
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
+	int ret = 0, i, j = *argc;
+
+	const struct option event_options[] = {
+		OPT_BOOLEAN('e', "event", &event, NULL),
+		OPT_BOOLEAN(0, "pfm-events", &event, NULL),
+		OPT_END()
+	};
+
+	if (!x86__is_intel_cpu())
+		return 0;
+
+	tmp = calloc(j + 1, sizeof(char *));
+	if (!tmp)
+		return -ENOMEM;
+
+	for (i = 0; i < j; i++)
+		tmp[i] = argv[i];
+
+	parse_options(j, tmp, event_options, NULL, PARSE_OPT_KEEP_UNKNOWN);
+	if (!event) {
+		argv[j++] = STRDUP_FAIL_EXIT("-e");
+		argv[j++] = STRDUP_FAIL_EXIT("cycles");
+		*argc += 2;
+	}
+
+	free(tmp);
+	return 0;
+
+EXIT:
+	free(tmp);
+	return ret;
+}
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index d297a7b2c088..c0d62add4996 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1636,16 +1636,6 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
 	return ret;
 }
 
-#define STRDUP_FAIL_EXIT(s)		\
-	({	char *_p;		\
-		_p = strdup(s);		\
-		if (!_p) {		\
-			ret = -ENOMEM;	\
-			goto EXIT;	\
-		}			\
-		_p;			\
-	})
-
 int __weak setup_kvm_events_tp(struct perf_kvm_stat *kvm __maybe_unused)
 {
 	return 0;
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 4249542544bb..53db3d56108b 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -190,5 +190,15 @@ static inline struct kvm_info *kvm_info__new(void)
 #define kvm_info__zput(ki) do { } while (0)
 #endif /* HAVE_KVM_STAT_SUPPORT */
 
+#define STRDUP_FAIL_EXIT(s)		\
+	({	char *_p;		\
+		_p = strdup(s);		\
+		if (!_p) {		\
+			ret = -ENOMEM;	\
+			goto EXIT;	\
+		}			\
+		_p;			\
+	})
+
 extern int kvm_add_default_arch_event(int *argc, const char **argv);
 #endif /* __PERF_KVM_STAT_H */
-- 
2.34.1

