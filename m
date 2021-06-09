Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C9EC48BD1
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 21:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3555613EE
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 21:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhFIVOZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Jun 2021 17:14:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:18022 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhFIVOZ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Jun 2021 17:14:25 -0400
IronPort-SDR: jylLqfOjak87JGI0G6Tgx0beHymWh+Ewjvyg99FWYe8MRtl78/vqztJ2OwtrZF82lGQOgAVWq/
 zzUTAG/qhUxg==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="192485920"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="192485920"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:12:29 -0700
IronPort-SDR: cjLUL8EoPePaY+f8THIdsxm7jG++GLJDyeFxYJEWij/IVSbLHi+TvkJe8sSS6kW+elSFK7cMPl
 dV477ODI9TSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="419416308"
Received: from gupta-dev2.jf.intel.com (HELO gupta-dev2.localdomain) ([10.54.74.119])
  by orsmga002.jf.intel.com with ESMTP; 09 Jun 2021 14:12:29 -0700
Date:   Wed, 9 Jun 2021 14:12:38 -0700
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
Subject: [PATCH 2/4] perf/x86/intel: Do not deploy workaround when TSX is
 deprecated
Message-ID: <4926973a8b0b2ed78217add01b5c459a92f0d511.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
References: <cover.2d906c322f72ec1420955136ebaa7a4c5073917c.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.2d906c322f72ec1420955136ebaa7a4c5073917c.1623272033.git-series.pawan.kumar.gupta@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Earlier workaround added by commit 400816f60c54 ("perf/x86/intel:
Implement support for TSX Force Abort") for perf counter interactions
[1] are not required on some client systems which received a microcode
update that deprecates TSX.

Bypass the perf workaround when such microcode is enumerated.

[1] Performance Monitoring Impact of Intel® Transactional Synchronization Extension Memory
    http://cdrdv2.intel.com/v1/dl/getContent/604224

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Neelima Krishnan <neelima.krishnan@intel.com>
---
 arch/x86/events/intel/core.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e28892270c58..b5953e1e59a2 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6016,10 +6016,24 @@ __init int intel_pmu_init(void)
 		intel_pmu_pebs_data_source_skl(pmem);
 
 		if (boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT)) {
-			x86_pmu.flags |= PMU_FL_TFA;
-			x86_pmu.get_event_constraints = tfa_get_event_constraints;
-			x86_pmu.enable_all = intel_tfa_pmu_enable_all;
-			x86_pmu.commit_scheduling = intel_tfa_commit_scheduling;
+			u64 msr;
+
+			rdmsrl(MSR_TSX_FORCE_ABORT, msr);
+			/* Systems that enumerate CPUID.RTM_ALWAYS_ABORT or
+			 * support MSR_TSX_FORCE_ABORT[SDV_ENABLE_RTM] bit have
+			 * TSX deprecated by default. TSX force abort hooks are
+			 * not required on these systems.
+			 *
+			 * Only deploy the workaround when older microcode is
+			 * detected.
+			 */
+			if (!boot_cpu_has(X86_FEATURE_RTM_ALWAYS_ABORT) &&
+			    !(msr & MSR_TFA_SDV_ENABLE_RTM)) {
+				x86_pmu.flags |= PMU_FL_TFA;
+				x86_pmu.get_event_constraints = tfa_get_event_constraints;
+				x86_pmu.enable_all = intel_tfa_pmu_enable_all;
+				x86_pmu.commit_scheduling = intel_tfa_commit_scheduling;
+			}
 		}
 
 		pr_cont("Skylake events, ");
-- 
git-series 0.9.1

