Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CA3C48BE8
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Jun 2021 21:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 023BB613B3
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Jun 2021 21:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhFNVPQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Jun 2021 17:15:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:2518 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233920AbhFNVPP (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Jun 2021 17:15:15 -0400
IronPort-SDR: 5iKOeOInbQ0clek3iABH9gX0CEcONEOqfC6i9BIKHJnSO2UM7kDLikxn8LueVRP11ajRQrj7rL
 Mf603jxu/UDw==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="269730253"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="269730253"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 14:13:12 -0700
IronPort-SDR: DmraqQxVrM6qKfQ3/IqCruI5jVCfk8B2WKMZHiOn4omLGzsny3NoOOwXMeBE9AW+M49rrNiHxL
 BrOTQDtNiEAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="487534522"
Received: from gupta-dev2.jf.intel.com (HELO gupta-dev2.localdomain) ([10.54.74.119])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jun 2021 14:13:09 -0700
Date:   Mon, 14 Jun 2021 14:13:23 -0700
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
Subject: [PATCH v2 2/3] perf/x86/intel: Do not deploy workaround when TSX is
 deprecated
Message-ID: <e4d410f786946280ced02dd07c74e0a74f1d10cb.1623704845.git-series.pawan.kumar.gupta@linux.intel.com>
References: <cover.b592910a3829c87c83cf5605718c415c80c0c4a9.1623704845.git-series.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.b592910a3829c87c83cf5605718c415c80c0c4a9.1623704845.git-series.pawan.kumar.gupta@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Earlier workaround added by commit 400816f60c54 ("perf/x86/intel:
Implement support for TSX Force Abort") for perf counter interactions
[1] are not required on some client systems which received a microcode
update that deprecates TSX.

Bypass the perf workaround when such microcode is enumerated.

[1] Performance Monitoring Impact of Intel® Transactional Synchronization Extension Memory
    http://cdrdv2.intel.com/v1/dl/getContent/604224 (Document ID 604224)

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Neelima Krishnan <neelima.krishnan@intel.com>
---
 arch/x86/events/intel/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e28892270c58..b599a30fcc7d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6015,7 +6015,15 @@ __init int intel_pmu_init(void)
 		tsx_attr = hsw_tsx_events_attrs;
 		intel_pmu_pebs_data_source_skl(pmem);
 
-		if (boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT)) {
+		/* Processors with CPUID.RTM_ALWAYS_ABORT have TSX deprecated by
+		 * default. TSX force abort hooks are not required on these
+		 * systems.
+		 *
+		 * Only deploy the workaround when older microcode is detected
+		 * i.e. !X86_FEATURE_RTM_ALWAYS_ABORT.
+		 */
+		if (boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT) &&
+		   !boot_cpu_has(X86_FEATURE_RTM_ALWAYS_ABORT)) {
 			x86_pmu.flags |= PMU_FL_TFA;
 			x86_pmu.get_event_constraints = tfa_get_event_constraints;
 			x86_pmu.enable_all = intel_tfa_pmu_enable_all;
-- 
git-series 0.9.1

