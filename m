Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292A2345CD3;
	Mon, 22 Dec 2025 22:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766444244; cv=none; b=m9wo6tJUmColPfP6c6lWIatz22lBZneyBXRNDZq6yfgm/0pYBQFgNAOJ0R7K2IgAbEJmUnwFk++ZGDlC9rF2HOesLb2aWshLmDrnpexbz+OR9cCtDVesBd0NCxE4XcxswKc+cXnVf5Vv95MxXBbhXMDin9lewNfZ8RdWej9aekg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766444244; c=relaxed/simple;
	bh=nBxcP0Cs+IHqyq8I0nTXUde+P6s3p8weEe8ou6YYua4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfjrQbxt2dQcJJuLHDUIXzLLaJIgboWCJutGvyUTdNapE5sSeVfLTpNkxIi3J293rKQ1IdcCuyyyog4TBxeFjFbae9JIEUJ0eOYHKKGmirIjFOLCex2tZWJM6pOIW8QGp5JzjjtJhdi61BHdxmwxSAlYKim/klwfumq+sZiLKkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5ycFld2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5ycFld2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B71C116D0;
	Mon, 22 Dec 2025 22:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766444243;
	bh=nBxcP0Cs+IHqyq8I0nTXUde+P6s3p8weEe8ou6YYua4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h5ycFld22DyjHw+QZwuOSt3nPtStPEW9Jao/iOTBE8xDUekDxezLhStp31p3E1vsn
	 iIaTW9E+oPDp7PuyujwVPdyojWg/Z1J0kA/FT5ecZR0Zul7Zl3tzTl9hJL8JJm3NY1
	 lKymfppMlVEb/4H2+Opov8jjrpXuNtCgdi5o/aaZk6omptzyxM5fQ6QZEXY/Fu4kQU
	 4VLaUaGfqJ76JjjJVVJZPu7gzkNl4ceTIZOljVAYqjUqyr8Vj/bEm0Kwv63WHaeGpt
	 0kI2NYezByPnPBONHQBAblnMvKsjpGgqHPXkm836leMbkoAHYYQcVfPfdig3h3D4g5
	 75/9n3UaNIWnw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 07/11] tools headers: Sync x86 headers with kernel sources
Date: Mon, 22 Dec 2025 14:57:12 -0800
Message-ID: <20251222225716.3565649-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
In-Reply-To: <20251222225716.3565649-1-namhyung@kernel.org>
References: <20251222225716.3565649-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up changes from:

  54de197c9a5e8f52 ("Merge tag 'x86_sgx_for_6.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
  679fcce0028bf101 ("Merge tag 'kvm-x86-svm-6.19' of https://github.com/kvm-x86/linux into HEAD")
  3767def18f4cc394 ("x86/cpufeatures: Add support for L3 Smart Data Cache Injection Allocation Enforcement")
  f6106d41ec84e552 ("x86/bugs: Use an x86 feature to track the MMIO Stale Data mitigation")
  7baadd463e147fdc ("x86/cpufeatures: Enumerate the LASS feature bits")
  47955b58cf9b97fe ("x86/cpufeatures: Correct LKGS feature flag description")
  5d0316e25defee47 ("x86/cpufeatures: Add X86_FEATURE_X2AVIC_EXT")
  6ffdb49101f02313 ("x86/cpufeatures: Add X86_FEATURE_SGX_EUPDATESVN feature flag")
  4793f990ea152330 ("KVM: x86: Advertise EferLmsleUnsupported to userspace")
  bb5f13df3c455110 ("perf/x86/intel: Add counter group support for arch-PEBS")
  52448a0a739002ec ("perf/x86/intel: Setup PEBS data configuration and enable legacy groups")
  d21954c8a0ffbc94 ("perf/x86/intel: Process arch-PEBS records or record fragments")
  bffeb2fd0b9c99d8 ("x86/microcode/intel: Enable staging when available")
  740144bc6bde9d44 ("x86/microcode/intel: Establish staging control logic")

This should address these tools/perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
    diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h

Please see tools/include/README.kernel-copies.

Cc: x86@kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/arch/x86/include/asm/cpufeatures.h | 11 +++++++++
 tools/arch/x86/include/asm/msr-index.h   | 30 ++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index ccc01ad6ff7c990d..c3b53beb130078ca 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -314,6 +314,7 @@
 #define X86_FEATURE_SM4			(12*32+ 2) /* SM4 instructions */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* "avx_vnni" AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* "avx512_bf16" AVX512 BFLOAT16 instructions */
+#define X86_FEATURE_LASS		(12*32+ 6) /* "lass" Linear Address Space Separation */
 #define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* CMPccXADD instructions */
 #define X86_FEATURE_ARCH_PERFMON_EXT	(12*32+ 8) /* Intel Architectural PerfMon Extension */
 #define X86_FEATURE_FZRM		(12*32+10) /* Fast zero-length REP MOVSB */
@@ -338,6 +339,7 @@
 #define X86_FEATURE_AMD_STIBP		(13*32+15) /* Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_AMD_STIBP_ALWAYS_ON	(13*32+17) /* Single Thread Indirect Branch Predictors always-on preferred */
 #define X86_FEATURE_AMD_IBRS_SAME_MODE	(13*32+19) /* Indirect Branch Restricted Speculation same mode protection*/
+#define X86_FEATURE_EFER_LMSLE_MBZ	(13*32+20) /* EFER.LMSLE must be zero */
 #define X86_FEATURE_AMD_PPIN		(13*32+23) /* "amd_ppin" Protected Processor Inventory Number */
 #define X86_FEATURE_AMD_SSBD		(13*32+24) /* Speculative Store Bypass Disable */
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* "virt_ssbd" Virtualized Speculative Store Bypass Disable */
@@ -502,6 +504,15 @@
 #define X86_FEATURE_IBPB_EXIT_TO_USER	(21*32+14) /* Use IBPB on exit-to-userspace, see VMSCAPE bug */
 #define X86_FEATURE_ABMC		(21*32+15) /* Assignable Bandwidth Monitoring Counters */
 #define X86_FEATURE_MSR_IMM		(21*32+16) /* MSR immediate form instructions */
+#define X86_FEATURE_SGX_EUPDATESVN	(21*32+17) /* Support for ENCLS[EUPDATESVN] instruction */
+
+#define X86_FEATURE_SDCIAE		(21*32+18) /* L3 Smart Data Cache Injection Allocation Enforcement */
+#define X86_FEATURE_CLEAR_CPU_BUF_VM_MMIO (21*32+19) /*
+						      * Clear CPU buffers before VM-Enter if the vCPU
+						      * can access host MMIO (ignored for all intents
+						      * and purposes if CLEAR_CPU_BUF_VM is set).
+						      */
+#define X86_FEATURE_X2AVIC_EXT		(21*32+20) /* AMD SVM x2AVIC support for 4k vCPUs */
 
 /*
  * BUG word(s)
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 9e1720d73244f686..3d0a0950d20a1609 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -166,6 +166,10 @@
 						 * Processor MMIO stale data
 						 * vulnerabilities.
 						 */
+#define ARCH_CAP_MCU_ENUM		BIT(16) /*
+						 * Indicates the presence of microcode update
+						 * feature enumeration and status information.
+						 */
 #define ARCH_CAP_FB_CLEAR		BIT(17)	/*
 						 * VERW clears CPU fill buffer
 						 * even on MDS_NO CPUs.
@@ -327,6 +331,26 @@
 					 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE | \
 					 PERF_CAP_PEBS_TIMING_INFO)
 
+/* Arch PEBS */
+#define MSR_IA32_PEBS_BASE		0x000003f4
+#define MSR_IA32_PEBS_INDEX		0x000003f5
+#define ARCH_PEBS_OFFSET_MASK		0x7fffff
+#define ARCH_PEBS_INDEX_WR_SHIFT	4
+
+#define ARCH_PEBS_RELOAD		0xffffffff
+#define ARCH_PEBS_CNTR_ALLOW		BIT_ULL(35)
+#define ARCH_PEBS_CNTR_GP		BIT_ULL(36)
+#define ARCH_PEBS_CNTR_FIXED		BIT_ULL(37)
+#define ARCH_PEBS_CNTR_METRICS		BIT_ULL(38)
+#define ARCH_PEBS_LBR_SHIFT		40
+#define ARCH_PEBS_LBR			(0x3ull << ARCH_PEBS_LBR_SHIFT)
+#define ARCH_PEBS_VECR_XMM		BIT_ULL(49)
+#define ARCH_PEBS_GPR			BIT_ULL(61)
+#define ARCH_PEBS_AUX			BIT_ULL(62)
+#define ARCH_PEBS_EN			BIT_ULL(63)
+#define ARCH_PEBS_CNTR_MASK		(ARCH_PEBS_CNTR_GP | ARCH_PEBS_CNTR_FIXED | \
+					 ARCH_PEBS_CNTR_METRICS)
+
 #define MSR_IA32_RTIT_CTL		0x00000570
 #define RTIT_CTL_TRACEEN		BIT(0)
 #define RTIT_CTL_CYCLEACC		BIT(1)
@@ -929,6 +953,10 @@
 #define MSR_IA32_APICBASE_BASE		(0xfffff<<12)
 
 #define MSR_IA32_UCODE_WRITE		0x00000079
+
+#define MSR_IA32_MCU_ENUMERATION	0x0000007b
+#define MCU_STAGING			BIT(4)
+
 #define MSR_IA32_UCODE_REV		0x0000008b
 
 /* Intel SGX Launch Enclave Public Key Hash MSRs */
@@ -1226,6 +1254,8 @@
 #define MSR_IA32_VMX_VMFUNC             0x00000491
 #define MSR_IA32_VMX_PROCBASED_CTLS3	0x00000492
 
+#define MSR_IA32_MCU_STAGING_MBOX_ADDR	0x000007a5
+
 /* Resctrl MSRs: */
 /* - Intel: */
 #define MSR_IA32_L3_QOS_CFG		0xc81
-- 
2.52.0.351.gbe84eed79e-goog

