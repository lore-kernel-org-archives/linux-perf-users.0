Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770F6C48BCF
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 21:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D802613EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 21:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhFIVQk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Jun 2021 17:16:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:18164 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhFIVQj (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Jun 2021 17:16:39 -0400
IronPort-SDR: KNTH3tA3sG1BRZK4qTCz6AENS9qBl4DFppFyPfTVujIDb1qkt2nCsROKA3NoUOM5y915a4a0/m
 TOmCkGtdpa1Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="192486163"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="192486163"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:14:32 -0700
IronPort-SDR: gmFssmlB2tZNL9dXdqT7llGbuE6WngKEc1A3weq4eg6wzWnWvfiFluDnNIn61swDt4V7g6dTFn
 xRWhh2datkZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="552808082"
Received: from gupta-dev2.jf.intel.com (HELO gupta-dev2.localdomain) ([10.54.74.119])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jun 2021 14:14:30 -0700
Date:   Wed, 9 Jun 2021 14:14:39 -0700
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
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 4/4] x86/tsx: Add cmdline tsx=fake to not clear CPUID bits
 RTM and HLE
Message-ID: <de6b97a567e273adff1f5268998692bad548aa10.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
References: <cover.2d906c322f72ec1420955136ebaa7a4c5073917c.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.2d906c322f72ec1420955136ebaa7a4c5073917c.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On CPUs that deprecated TSX, clearing the enumeration bits CPUID.RTM and
CPUID.HLE may not be desirable in some corner cases. Like a saved guest
would refuse to resume if it was saved before the microcode update
that deprecated TSX.

Add a cmdline option "tsx=fake" to not clear CPUID bits even when the
hardware always aborts TSX transactions.

Suggested-by: Tony Luck <tony.luck@intel.com>
Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Neelima Krishnan <neelima.krishnan@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 arch/x86/kernel/cpu/bugs.c                      | 5 +++--
 arch/x86/kernel/cpu/cpu.h                       | 1 +
 arch/x86/kernel/cpu/tsx.c                       | 7 +++++--
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb89dbdedc46..ced9e5596163 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5693,6 +5693,9 @@
 			auto	- Disable TSX if X86_BUG_TAA is present,
 				  otherwise enable TSX on the system.
 
+			fake	- Do not clear the CPUID bits RTM and HLE even
+				  when hardware always aborts TSX transactions.
+
 			Not specifying this option is equivalent to tsx=off.
 
 			See Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d41b70fe4918..46fcc392a339 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -316,8 +316,9 @@ static void __init taa_select_mitigation(void)
 		return;
 	}
 
-	/* TSX previously disabled by tsx=off */
-	if (!boot_cpu_has(X86_FEATURE_RTM)) {
+	/* TSX previously disabled by tsx=off or by microcode */
+	if (!boot_cpu_has(X86_FEATURE_RTM) ||
+	     boot_cpu_has(X86_FEATURE_RTM_ALWAYS_ABORT)) {
 		taa_mitigation = TAA_MITIGATION_TSX_DISABLED;
 		goto out;
 	}
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index 95521302630d..84a479866c4b 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -49,6 +49,7 @@ enum tsx_ctrl_states {
 	TSX_CTRL_ENABLE,
 	TSX_CTRL_DISABLE,
 	TSX_CTRL_RTM_ALWAYS_ABORT,
+	TSX_CTRL_FAKE,
 	TSX_CTRL_NOT_SUPPORTED,
 };
 
diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
index 5ed99811504c..2f8e50584297 100644
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -113,6 +113,8 @@ void __init tsx_init(void)
 			tsx_ctrl_state = TSX_CTRL_DISABLE;
 		} else if (!strcmp(arg, "auto")) {
 			tsx_ctrl_state = x86_get_tsx_auto_mode();
+		} else if (!strcmp(arg, "fake")) {
+			tsx_ctrl_state = TSX_CTRL_FAKE;
 		} else {
 			tsx_ctrl_state = TSX_CTRL_DISABLE;
 			pr_err("invalid option, defaulting to off\n");
@@ -131,9 +133,10 @@ void __init tsx_init(void)
 	 * Hardware will always abort a TSX transaction if both CPUID bits
 	 * RTM_ALWAYS_ABORT and TSX_FORCE_ABORT are enumerated.  In this case it
 	 * is better not to enumerate CPUID.RTM and CPUID.HLE bits. Clear them
-	 * here.
+	 * here, except when user requested not to clear via cmdline tsx=fake.
 	 */
-	if (boot_cpu_has(X86_FEATURE_RTM_ALWAYS_ABORT) &&
+	if (tsx_ctrl_state != TSX_CTRL_FAKE &&
+	    boot_cpu_has(X86_FEATURE_RTM_ALWAYS_ABORT) &&
 	    boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT)) {
 		tsx_ctrl_state = TSX_CTRL_RTM_ALWAYS_ABORT;
 		tsx_clear_cpuid();
-- 
git-series 0.9.1

