Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D4C253B47;
	Wed,  5 Mar 2025 18:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200518; cv=none; b=UOpLiQOxxyH78490sHPRSviNMTrpPRvae/IKOr31NDT0OWrz28WKrjDsLWnbgvcns9+5Xf4H+m9p0OIDVnT8GL2TKUOqVs6AWcG+nTbHvTZ5iBhaYzyrc5d610wDIIgK4Js1tGRguLJgfIw9+4z+ykbZhQLr+blwEXwQSfvIums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200518; c=relaxed/simple;
	bh=ALoap60e8eYMXnFhFD1lFNsNbtAEqlcl56Tb4plKg8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rzk6lCW86sdto8xlJwDfHTf+rQPL4XEYyzPPd0C5jtLw65qAB2FcWL51VFauj9fyvkqBCdZtJZyfvYVUJIye8qwC6HOT0kK84RVhbje9UAhJcGuCKhKZtw9j0cuVtxSB4VbVsmCT5OILdP8GP9eWz6AxZMICDe29daGRPWIvfrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=BmP3P1e4; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BmP3P1e4"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 525IlQXu3341787
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 5 Mar 2025 10:47:32 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 525IlQXu3341787
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741200453;
	bh=BGNQcMVK5hCto379/x9/4Vl9hYv+kX3k2clZaukpqgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BmP3P1e4aDgQqcgOw4u4a+ji4ldYKpt9g0IPLFOk0ErpRcDPjIa1yR//1JBSZAkhj
	 ivDSRHszWpIzuNWmBAM3Pn+N1WG0AV5ThxdGWt2NAUPzJ+MfN2xe63es6o98WQYYfH
	 pE9PQA8HCR65lqfwjU8EIev8NsSM/EtSKC1rIekkCXmnu1Ld8J5FrRSljL6JIz7sc2
	 dRcn88NJOA0Ia8I3MW5U5JIWIISr0qBYK/Lq3eUKFp1smi+Oih5E0HgA2F4uP4Zv6U
	 jKUci1zTW71J/YyYF0ldtsT4PVuDRmwelg6AvNqcOkoxN1OdTGLJPGKcp3cdzcZsjP
	 Rwf4xxiuHfitA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, yury.norov@gmail.com,
        akpm@linux-foundation.org, acme@kernel.org, namhyung@kernel.org,
        brgerst@gmail.com, andrew.cooper3@citrix.com, nik.borisov@suse.com,
        sraithal@amd.com, philip.li@intel.com
Subject: [PATCH v7 1/4] x86/cpufeatures: Add {required,disabled} feature configs
Date: Wed,  5 Mar 2025 10:47:21 -0800
Message-ID: <20250305184725.3341760-2-xin@zytor.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305184725.3341760-1-xin@zytor.com>
References: <20250305184725.3341760-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Required and disabled feature masks completely rely on build configs,
i.e., once a build config is fixed, so are the feature masks.  To
prepare for auto-generating a header with required and disabled feature
masks based on a build config, add feature Kconfig items:
  - X86_REQUIRED_FEATURE_x
  - X86_DISABLED_FEATURE_x
each of which may be set to "y" if and only if its preconditions from
current build config are met.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---

Change in v7:
* Collect reviewed-bys.

Changes in v6:
* Move changes to X86_CMPXCHG64 to a separate patch (Borislav Petkov).
* Keep X86_{CX8,CMOV} and define X86_REQUIRED_FEATURE_{CX8,CMOV} on top
  (Borislav Petkov).

Changes in v2:
* Keep the X86_{REQUIRED,DISABLED}_FEATURE_ prefixes solely in
  arch/x86/Kconfig.cpufeatures (Borislav Petkov).
* Explain how config option names X86_{REQUIRED,DISABLED}_FEATURE_<name>
  are formed (Borislav Petkov).
---
 arch/x86/Kconfig             |   2 +
 arch/x86/Kconfig.cpufeatures | 197 +++++++++++++++++++++++++++++++++++
 2 files changed, 199 insertions(+)
 create mode 100644 arch/x86/Kconfig.cpufeatures

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1e50da06ffc4..1b12725cac8c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -3130,4 +3130,6 @@ config HAVE_ATOMIC_IOMAP
 
 source "arch/x86/kvm/Kconfig"
 
+source "arch/x86/Kconfig.cpufeatures"
+
 source "arch/x86/Kconfig.assembler"
diff --git a/arch/x86/Kconfig.cpufeatures b/arch/x86/Kconfig.cpufeatures
new file mode 100644
index 000000000000..5dcc49d928c5
--- /dev/null
+++ b/arch/x86/Kconfig.cpufeatures
@@ -0,0 +1,197 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# x86 feature bits (see arch/x86/include/asm/cpufeatures.h) that are
+# either REQUIRED to be enabled, or DISABLED (always ignored) for this
+# particular compile-time configuration.  The tests for these features
+# are turned into compile-time constants via the generated
+# <asm/featuremasks.h>.
+#
+# The naming of these variables *must* match asm/cpufeatures.h, e.g.,
+#     X86_FEATURE_ALWAYS <==> X86_REQUIRED_FEATURE_ALWAYS
+#     X86_FEATURE_FRED   <==> X86_DISABLED_FEATURE_FRED
+#
+# And these REQUIRED and DISABLED config options are manipulated in an
+# AWK script as the following example:
+#
+#                          +----------------------+
+#                          |    X86_FRED = y ?    |
+#                          +----------------------+
+#                              /             \
+#                           Y /               \ N
+#  +-------------------------------------+   +-------------------------------+
+#  | X86_DISABLED_FEATURE_FRED undefined |   | X86_DISABLED_FEATURE_FRED = y |
+#  +-------------------------------------+   +-------------------------------+
+#                                                        |
+#                                                        |
+#     +-------------------------------------------+      |
+#     | X86_FEATURE_FRED: feature word 12, bit 17 | ---->|
+#     +-------------------------------------------+      |
+#                                                        |
+#                                                        |
+#                                     +-------------------------------+
+#                                     | set bit 17 of DISABLED_MASK12 |
+#                                     +-------------------------------+
+#
+
+config X86_REQUIRED_FEATURE_ALWAYS
+	def_bool y
+
+config X86_REQUIRED_FEATURE_NOPL
+	def_bool y
+	depends on X86_64 || X86_P6_NOP
+
+config X86_REQUIRED_FEATURE_CX8
+	def_bool y
+	depends on X86_CX8
+
+# this should be set for all -march=.. options where the compiler
+# generates cmov.
+config X86_REQUIRED_FEATURE_CMOV
+	def_bool y
+	depends on X86_CMOV
+
+# this should be set for all -march= options where the compiler
+# generates movbe.
+config X86_REQUIRED_FEATURE_MOVBE
+	def_bool y
+	depends on MATOM
+
+config X86_REQUIRED_FEATURE_CPUID
+	def_bool y
+	depends on X86_64
+
+config X86_REQUIRED_FEATURE_UP
+	def_bool y
+	depends on !SMP
+
+config X86_REQUIRED_FEATURE_FPU
+	def_bool y
+	depends on !MATH_EMULATION
+
+config X86_REQUIRED_FEATURE_PAE
+	def_bool y
+	depends on X86_64 || X86_PAE
+
+config X86_REQUIRED_FEATURE_PSE
+	def_bool y
+	depends on X86_64 && !PARAVIRT_XXL
+
+config X86_REQUIRED_FEATURE_PGE
+	def_bool y
+	depends on X86_64 && !PARAVIRT_XXL
+
+config X86_REQUIRED_FEATURE_MSR
+	def_bool y
+	depends on X86_64
+
+config X86_REQUIRED_FEATURE_FXSR
+	def_bool y
+	depends on X86_64
+
+config X86_REQUIRED_FEATURE_XMM
+	def_bool y
+	depends on X86_64
+
+config X86_REQUIRED_FEATURE_XMM2
+	def_bool y
+	depends on X86_64
+
+config X86_REQUIRED_FEATURE_LM
+	def_bool y
+	depends on X86_64
+
+config X86_DISABLED_FEATURE_UMIP
+	def_bool y
+	depends on !X86_UMIP
+
+config X86_DISABLED_FEATURE_VME
+	def_bool y
+	depends on X86_64
+
+config X86_DISABLED_FEATURE_K6_MTRR
+	def_bool y
+	depends on X86_64
+
+config X86_DISABLED_FEATURE_CYRIX_ARR
+	def_bool y
+	depends on X86_64
+
+config X86_DISABLED_FEATURE_CENTAUR_MCR
+	def_bool y
+	depends on X86_64
+
+config X86_DISABLED_FEATURE_PCID
+	def_bool y
+	depends on !X86_64
+
+config X86_DISABLED_FEATURE_PKU
+	def_bool y
+	depends on !X86_INTEL_MEMORY_PROTECTION_KEYS
+
+config X86_DISABLED_FEATURE_OSPKE
+	def_bool y
+	depends on !X86_INTEL_MEMORY_PROTECTION_KEYS
+
+config X86_DISABLED_FEATURE_LA57
+	def_bool y
+	depends on !X86_5LEVEL
+
+config X86_DISABLED_FEATURE_PTI
+	def_bool y
+	depends on !MITIGATION_PAGE_TABLE_ISOLATION
+
+config X86_DISABLED_FEATURE_RETPOLINE
+	def_bool y
+	depends on !MITIGATION_RETPOLINE
+
+config X86_DISABLED_FEATURE_RETPOLINE_LFENCE
+	def_bool y
+	depends on !MITIGATION_RETPOLINE
+
+config X86_DISABLED_FEATURE_RETHUNK
+	def_bool y
+	depends on !MITIGATION_RETHUNK
+
+config X86_DISABLED_FEATURE_UNRET
+	def_bool y
+	depends on !MITIGATION_UNRET_ENTRY
+
+config X86_DISABLED_FEATURE_CALL_DEPTH
+	def_bool y
+	depends on !MITIGATION_CALL_DEPTH_TRACKING
+
+config X86_DISABLED_FEATURE_LAM
+	def_bool y
+	depends on !ADDRESS_MASKING
+
+config X86_DISABLED_FEATURE_ENQCMD
+	def_bool y
+	depends on !INTEL_IOMMU_SVM
+
+config X86_DISABLED_FEATURE_SGX
+	def_bool y
+	depends on !X86_SGX
+
+config X86_DISABLED_FEATURE_XENPV
+	def_bool y
+	depends on !XEN_PV
+
+config X86_DISABLED_FEATURE_TDX_GUEST
+	def_bool y
+	depends on !INTEL_TDX_GUEST
+
+config X86_DISABLED_FEATURE_USER_SHSTK
+	def_bool y
+	depends on !X86_USER_SHADOW_STACK
+
+config X86_DISABLED_FEATURE_IBT
+	def_bool y
+	depends on !X86_KERNEL_IBT
+
+config X86_DISABLED_FEATURE_FRED
+	def_bool y
+	depends on !X86_FRED
+
+config X86_DISABLED_FEATURE_SEV_SNP
+	def_bool y
+	depends on !KVM_AMD_SEV
-- 
2.48.1

