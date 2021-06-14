Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8C0C48BE8
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Jun 2021 21:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EEF0613AC
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Jun 2021 21:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbhFNVON (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Jun 2021 17:14:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:48826 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230081AbhFNVON (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Jun 2021 17:14:13 -0400
IronPort-SDR: y8FGsDgLVd7QHJfyO3XxwDaq2yRWhHdsqvGCHVw2J6t/ReyDNsUcprSE6XxUfT5MHSVeoODT9a
 rwzerIkzudCQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="185573933"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="185573933"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 14:12:09 -0700
IronPort-SDR: FyPmzqLr9XfZCM6bpRVuOMJ5+WX3qvFnyjED0JLtLXKsMFYkWQYlWDm+hoqlyJbtwjpXfJ05ue
 Bqbco+ebJS7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="487534264"
Received: from gupta-dev2.jf.intel.com (HELO gupta-dev2.localdomain) ([10.54.74.119])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jun 2021 14:12:08 -0700
Date:   Mon, 14 Jun 2021 14:12:22 -0700
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
Subject: [PATCH v2 1/3] x86/msr: Define new bits in TSX_FORCE_ABORT MSR
Message-ID: <9add61915b4a4eedad74fbd869107863a28b428e.1623704845.git-series.pawan.kumar.gupta@linux.intel.com>
References: <cover.b592910a3829c87c83cf5605718c415c80c0c4a9.1623704845.git-series.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.b592910a3829c87c83cf5605718c415c80c0c4a9.1623704845.git-series.pawan.kumar.gupta@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Intel client processors that support IA32_TSX_FORCE_ABORT MSR related to
perf counter interaction [1] received a microcode update that deprecates
Transactional Synchronization Extension (TSX) feature. MSR
IA32_TSX_FORCE_ABORT bit FORCE_ABORT_RTM now defaults to 1, writes to
this bit are ignored. A new bit TSX_CPUID_CLEAR clears the TSX related
CPUID bits.

Below is the summary of changes to IA32_TSX_FORCE_ABORT MSR:

  Bit 0: FORCE_ABORT_RTM (legacy bit, new default=1) Status bit that
  indicates if RTM transactions are always aborted. This bit is
  essentially !SDV_ENABLE_RTM(Bit 2). Writes to this bit are ignored.

  Bit 1: TSX_CPUID_CLEAR (new bit, default=0) When set, CPUID.HLE = 0
  and CPUID.RTM = 0.

  Bit 2: SDV_ENABLE_RTM (new bit, default=0) When clear, XBEGIN will
  always abort with EAX code 0. When set, XBEGIN will not be forced to
  abort (but will always abort in SGX enclaves). This bit is intended to
  be used on developer systems. If this bit is set transactional
  atomicity correctness is not certain.

Performance monitoring counter 3 is usable in all cases, regardless of
the value of above bits.

A new CPUID bit CPUID.RTM_ALWAYS_ABORT (CPUID 7.EDX[11]) is added to
indicate the status of always abort behavior.

Define these new CPUID and MSR bits.

[1] Performance Monitoring Impact of Intel® Transactional Synchronization Extension Memory
    http://cdrdv2.intel.com/v1/dl/getContent/604224 (Document ID 604224)

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Neelima Krishnan <neelima.krishnan@intel.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/include/asm/msr-index.h   | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index ac37830ae941..21c1855b5c14 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -378,6 +378,7 @@
 #define X86_FEATURE_AVX512_VP2INTERSECT (18*32+ 8) /* AVX-512 Intersect for D/Q */
 #define X86_FEATURE_SRBDS_CTRL		(18*32+ 9) /* "" SRBDS mitigation MSR available */
 #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
+#define X86_FEATURE_RTM_ALWAYS_ABORT	(18*32+11) /* "" RTM transaction always aborts */
 #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
 #define X86_FEATURE_SERIALIZE		(18*32+14) /* SERIALIZE instruction */
 #define X86_FEATURE_HYBRID_CPU		(18*32+15) /* "" This part has CPUs of more than one type */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 211ba3375ee9..a7c413432b33 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -772,6 +772,10 @@
 
 #define MSR_TFA_RTM_FORCE_ABORT_BIT	0
 #define MSR_TFA_RTM_FORCE_ABORT		BIT_ULL(MSR_TFA_RTM_FORCE_ABORT_BIT)
+#define MSR_TFA_TSX_CPUID_CLEAR_BIT	1
+#define MSR_TFA_TSX_CPUID_CLEAR		BIT_ULL(MSR_TFA_TSX_CPUID_CLEAR_BIT)
+#define MSR_TFA_SDV_ENABLE_RTM_BIT	2
+#define MSR_TFA_SDV_ENABLE_RTM		BIT_ULL(MSR_TFA_SDV_ENABLE_RTM_BIT)
 
 /* P4/Xeon+ specific */
 #define MSR_IA32_MCG_EAX		0x00000180
-- 
git-series 0.9.1

