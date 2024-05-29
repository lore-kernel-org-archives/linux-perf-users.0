Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6A31C68B4;
	Wed, 29 May 2024 20:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717014516; cv=none; b=bZLX9mNgaV2gNzx0VjxuQpdZ0CG1aiOPfAgMwApAe8WT85Vhc6YOi2+E/b3urhcgqzZYMbGAql73iUD65Gy6kKaqwHlhpGXtWSvIml1bsaYfSs5b/pmWuJHrsZeR+ovndAQflzqfbXa4RWIQFr8tQqvaLJT9kxo6MKhWsNh3kJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717014516; c=relaxed/simple;
	bh=dSqou1KOvj6VEChE+4XJ6rK/xivwkSVK7t0PEao7PtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N8+NvCpBXr2Yqx3P9VQ00EJLpgcbKS8iFi1PgUGtOe/xOV8TeAaSNKiOIoWWLBuBPKCj0i3jukE4xcrHrk9PuWeFLSYBaQN+H9szSipE3tjTB53TtXQ0FmIasC8k9G8GhgAcaNKgcihIplVvEoHoRwZIBLDDCh2z4Pp/C851wFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WvmBMDnE; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WvmBMDnE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717014515; x=1748550515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dSqou1KOvj6VEChE+4XJ6rK/xivwkSVK7t0PEao7PtQ=;
  b=WvmBMDnExqAbG9WrhC/lfNvA7d9xkqVCnkfd6r4qj8pHhyv8GiuIRKoA
   fqh003oC3x0tdCnOHMO3ep107qalpo38TS9xMij6I7q1/b3+cOoq86GcL
   8mhu0y6EVtC0mNCF89cSFs39Okf/SR2PwEO3dFQrSwoQKGPG6+87yPPeF
   QCKhNMzpoVriLer8reyeNpFlp51oB2gp5HelAKyTje7atXk27faK8vc+e
   htgeZPUZySWvqqfweE3JJlSL/8o1VhYtXKY6eFuTEzkKPU+0Y6qxnvrzr
   B/jEn3cXYMzQw5OgpmkAgAZz3tUgu2QXxBvMHBynnSnhbcs3gwhHb70es
   w==;
X-CSE-ConnectionGUID: fsgGmAEdQSiUq9r1flJNJQ==
X-CSE-MsgGUID: bM9p2GDxT1+OEM6sZoyNaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13574527"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13574527"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 13:28:32 -0700
X-CSE-ConnectionGUID: CoBr3p4CRT2E4CYboQLtWA==
X-CSE-MsgGUID: Ln1ZCyiKTjO2S3SDc3NfrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35491264"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa007.fm.intel.com with ESMTP; 29 May 2024 13:28:32 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: X86 Kernel <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Ingo Molnar" <mingo@redhat.com>,
	"Borislav Petkov" <bp@alien8.de>,
	linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <andi.kleen@intel.com>,
	"Xin Li" <xin3.li@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 1/6] x86/irq: Add enumeration of NMI source reporting CPU feature
Date: Wed, 29 May 2024 13:33:20 -0700
Message-Id: <20240529203325.3039243-2-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240529203325.3039243-1-jacob.jun.pan@linux.intel.com>
References: <20240529203325.3039243-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lack of a mechanism to pinpoint the origins of Non-Maskable Interrupts
(NMIs) necessitates that the NMI vector 2 handler consults each NMI source
handler individually. This approach leads to inefficiencies, delays, and
the occurrence of unnecessary NMIs, thereby also constraining the potential
applications of NMIs.

A new CPU feature, known as NMI source reporting, has been introduced as
part of the Flexible Return and Event Delivery (FRED) spec. This feature
enables the NMI vector 2 handler to directly obtain information about the
NMI source from the FRED event data.

The functionality of NMI source reporting is tied to the FRED. Although it
is enumerated by a unique CPUID feature bit, it cannot be turned off
independently once FRED is activated.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/Kconfig                         | 9 +++++++++
 arch/x86/include/asm/cpufeatures.h       | 1 +
 arch/x86/include/asm/disabled-features.h | 8 +++++++-
 arch/x86/kernel/cpu/cpuid-deps.c         | 1 +
 arch/x86/kernel/traps.c                  | 4 +++-
 5 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1d7122a1883e..b8b15f20b94e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -511,12 +511,21 @@ config X86_CPU_RESCTRL
 config X86_FRED
 	bool "Flexible Return and Event Delivery"
 	depends on X86_64
+	select X86_NMI_SOURCE
 	help
 	  When enabled, try to use Flexible Return and Event Delivery
 	  instead of the legacy SYSCALL/SYSENTER/IDT architecture for
 	  ring transitions and exception/interrupt handling if the
 	  system supports it.
 
+config X86_NMI_SOURCE
+	def_bool n
+	help
+	  Once enabled, information on NMI originator/source can be provided
+	  via FRED event data. This makes NMI processing more efficient in that
+	  NMI handler does not need to check for every possible source at
+	  runtime when NMI is delivered.
+
 config X86_BIGSMP
 	bool "Support for big SMP systems with more than 8 CPUs"
 	depends on SMP && X86_32
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 3c7434329661..ec78d361e685 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -327,6 +327,7 @@
 #define X86_FEATURE_FRED		(12*32+17) /* Flexible Return and Event Delivery */
 #define X86_FEATURE_LKGS		(12*32+18) /* "" Load "kernel" (userspace) GS */
 #define X86_FEATURE_WRMSRNS		(12*32+19) /* "" Non-serializing WRMSR */
+#define X86_FEATURE_NMI_SOURCE		(12*32+20) /* NMI source reporting */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
 #define X86_FEATURE_AVX_IFMA            (12*32+23) /* "" Support for VPMADD52[H,L]UQ */
 #define X86_FEATURE_LAM			(12*32+26) /* Linear Address Masking */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index c492bdc97b05..3856c4737d65 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -123,6 +123,12 @@
 # define DISABLE_FRED	(1 << (X86_FEATURE_FRED & 31))
 #endif
 
+#ifdef CONFIG_X86_NMI_SOURCE
+# define DISABLE_NMI_SOURCE	0
+#else
+# define DISABLE_NMI_SOURCE	(1 << (X86_FEATURE_NMI_SOURCE & 31))
+#endif
+
 #ifdef CONFIG_KVM_AMD_SEV
 #define DISABLE_SEV_SNP		0
 #else
@@ -145,7 +151,7 @@
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
 			 DISABLE_CALL_DEPTH_TRACKING|DISABLE_USER_SHSTK)
-#define DISABLED_MASK12	(DISABLE_FRED|DISABLE_LAM)
+#define DISABLED_MASK12	(DISABLE_FRED|DISABLE_LAM|DISABLE_NMI_SOURCE)
 #define DISABLED_MASK13	0
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index b7d9f530ae16..3f1a1a1961fa 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -84,6 +84,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_FRED,			X86_FEATURE_LKGS      },
 	{ X86_FEATURE_FRED,			X86_FEATURE_WRMSRNS   },
+	{ X86_FEATURE_FRED,			X86_FEATURE_NMI_SOURCE},
 	{}
 };
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4fa0b17e5043..465f04e4a79f 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1427,8 +1427,10 @@ early_param("fred", fred_setup);
 
 void __init trap_init(void)
 {
-	if (cpu_feature_enabled(X86_FEATURE_FRED) && !enable_fred)
+	if (cpu_feature_enabled(X86_FEATURE_FRED) && !enable_fred) {
 		setup_clear_cpu_cap(X86_FEATURE_FRED);
+		setup_clear_cpu_cap(X86_FEATURE_NMI_SOURCE);
+	}
 
 	/* Init cpu_entry_area before IST entries are set up */
 	setup_cpu_entry_areas();
-- 
2.25.1

