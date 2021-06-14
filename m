Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD355C2B9F4
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Jun 2021 21:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9241C61378
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Jun 2021 21:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbhFNVQQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Jun 2021 17:16:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:8972 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230081AbhFNVQQ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Jun 2021 17:16:16 -0400
IronPort-SDR: jYHdijB1pxm3717zC9F5Xs2MOugIatvU4FVzsK/E6D5ww/rjGf+KFf7N5gGVaKWZv1/pYkGZq0
 jsCt+bA4JfTg==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="204050250"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="204050250"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 14:14:12 -0700
IronPort-SDR: NFW8qtjUYqYWseSbnCoCikGqjRvUznLEb1OFBCCTBYwzAqw/46Q7e2lY1LGM+JdEg5vTgQ/hdt
 XXSys/Tg0YUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="487534730"
Received: from gupta-dev2.jf.intel.com (HELO gupta-dev2.localdomain) ([10.54.74.119])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jun 2021 14:14:11 -0700
Date:   Mon, 14 Jun 2021 14:14:25 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tony Luck <tony.luck@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Victor Ding <victording@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Anand K Mistry <amistry@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>, Joe Perches <joe@perches.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v2 3/3] x86/tsx: Clear CPUID bits when TSX always force aborts
Message-ID: <5209b3d72ffe5bd3cafdcc803f5b883f785329c3.1623704845.git-series.pawan.kumar.gupta@linux.intel.com>
References: <cover.b592910a3829c87c83cf5605718c415c80c0c4a9.1623704845.git-series.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.b592910a3829c87c83cf5605718c415c80c0c4a9.1623704845.git-series.pawan.kumar.gupta@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

As a result of TSX deprecation some processors always aborts TSX
transactions by default.

When TSX feature cannot be used it is better to hide it. Clear CPUID.RTM
and CPUID.HLE bits when TSX transactions always aborts.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Neelima Krishnan <neelima.krishnan@intel.com>
---
 arch/x86/kernel/cpu/cpu.h   |  2 ++
 arch/x86/kernel/cpu/intel.c |  4 +++-
 arch/x86/kernel/cpu/tsx.c   | 37 +++++++++++++++++++++++++++++++++++--
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index 67944128876d..95521302630d 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -48,6 +48,7 @@ extern const struct cpu_dev *const __x86_cpu_dev_start[],
 enum tsx_ctrl_states {
 	TSX_CTRL_ENABLE,
 	TSX_CTRL_DISABLE,
+	TSX_CTRL_RTM_ALWAYS_ABORT,
 	TSX_CTRL_NOT_SUPPORTED,
 };
 
@@ -56,6 +57,7 @@ extern __ro_after_init enum tsx_ctrl_states tsx_ctrl_state;
 extern void __init tsx_init(void);
 extern void tsx_enable(void);
 extern void tsx_disable(void);
+extern void tsx_clear_cpuid(void);
 #else
 static inline void tsx_init(void) { }
 #endif /* CONFIG_CPU_SUP_INTEL */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8adffc17fa8b..861e919eba9a 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -717,8 +717,10 @@ static void init_intel(struct cpuinfo_x86 *c)
 
 	if (tsx_ctrl_state == TSX_CTRL_ENABLE)
 		tsx_enable();
-	if (tsx_ctrl_state == TSX_CTRL_DISABLE)
+	else if (tsx_ctrl_state == TSX_CTRL_DISABLE)
 		tsx_disable();
+	else if (tsx_ctrl_state == TSX_CTRL_RTM_ALWAYS_ABORT)
+		tsx_clear_cpuid();
 
 	split_lock_init();
 	bus_lock_init();
diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
index e2ad30e474f8..fd258a383bfc 100644
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -2,7 +2,7 @@
 /*
  * Intel Transactional Synchronization Extensions (TSX) control.
  *
- * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2019-2021 Intel Corporation
  *
  * Author:
  *	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
@@ -84,13 +84,46 @@ static enum tsx_ctrl_states x86_get_tsx_auto_mode(void)
 	return TSX_CTRL_ENABLE;
 }
 
+void tsx_clear_cpuid(void)
+{
+	u64 msr;
+
+	/*
+	 * MSR_TFA_TSX_CPUID_CLEAR bit is only present when both CPUID bits
+	 * RTM_ALWAYS_ABORT and TSX_FORCE_ABORT are present.
+	 */
+	if (boot_cpu_has(X86_FEATURE_RTM_ALWAYS_ABORT) &&
+	    boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT)) {
+		rdmsrl(MSR_TSX_FORCE_ABORT, msr);
+		msr |= MSR_TFA_TSX_CPUID_CLEAR;
+		wrmsrl(MSR_TSX_FORCE_ABORT, msr);
+	}
+}
+
 void __init tsx_init(void)
 {
 	char arg[5] = {};
 	int ret;
 
-	if (!tsx_ctrl_is_supported())
+	/*
+	 * Hardware will always abort a TSX transaction if both CPUID bits
+	 * RTM_ALWAYS_ABORT and TSX_FORCE_ABORT are set.  In this case it is
+	 * better not to enumerate CPUID.RTM and CPUID.HLE bits. Clear them
+	 * here.
+	 */
+	if (boot_cpu_has(X86_FEATURE_RTM_ALWAYS_ABORT) &&
+	    boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT)) {
+		tsx_ctrl_state = TSX_CTRL_RTM_ALWAYS_ABORT;
+		tsx_clear_cpuid();
+		setup_clear_cpu_cap(X86_FEATURE_RTM);
+		setup_clear_cpu_cap(X86_FEATURE_HLE);
 		return;
+	}
+
+	if (!tsx_ctrl_is_supported()) {
+		tsx_ctrl_state = TSX_CTRL_NOT_SUPPORTED;
+		return;
+	}
 
 	ret = cmdline_find_option(boot_command_line, "tsx", arg, sizeof(arg));
 	if (ret >= 0) {
-- 
git-series 0.9.1

