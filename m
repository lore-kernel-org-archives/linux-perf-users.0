Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7719944366;
	Tue, 11 Jun 2024 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124599; cv=none; b=GgKhU2+vLlnF6IoTcpFxvBQKLJdfa/GKd3QorCKOdbMPruxUhQHaajqou/zUaBneelbrVOWWJkHnfqFXH5Ugz6C3bTDkGdfYXJo7dz/6Ii1eIVgh3kPz/elGpdK0wvOgPGgc09MTwaDxtnLMRKKCp/mfM/rhaY9vYY8RW54x968=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124599; c=relaxed/simple;
	bh=HNox1emeC2Q0I7wPCD9sdTztt+r5s8hf6WB0DNGMFy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OQ9BilrjPWCo87hKynghVhgyKwQkCSwMMKuyWUrNBQoSWAnOwhU2kK7DznkUivQsNDCwXxCnI6bb2LzjX9AX0fUJv2ff8z1iL+CN/MM2uV6vfN6tt90rmS5iYlbKrCJ/uldk6zNaz2NAsOch5H7eUyrDr7n0NoAmUamsKAUAzPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BfmHAZDl; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BfmHAZDl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718124598; x=1749660598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HNox1emeC2Q0I7wPCD9sdTztt+r5s8hf6WB0DNGMFy0=;
  b=BfmHAZDlxI6qmVr6PtY/dcEY5g84bABIJfu5e5wnxpfCUWOExWvhoR1h
   EJFykaRd3mdgYaVWps8mwbLP85hTOmb75yrMysfdal8suMyx9Vqwl5BrR
   4lx/hY2my3DDRSwNJiV0dTAAycd+9PYLpedPwDeuT6m9FfQ0d1umO5O41
   Z3ESILXlhHHMAWL8VJxn82pZ3Y25u8Sgwtgu/jtNf1MT4qlrxfe5QInNp
   /je6m4YcRUNLXb9TjO8aS/7CEqZGO3i8RiynFUnGj5g7KXmjBP7MMt1A+
   2W7dNVr+Bj+d4rKo5V3fMoqLTwIVWisEsy22vgs7vHfgHI6lO2kOx2Im2
   g==;
X-CSE-ConnectionGUID: Jc9fWml3ScGxiQbRcmF8BA==
X-CSE-MsgGUID: wLo35MSPR5S3Ra/r68gK5g==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="40249625"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="40249625"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 09:49:57 -0700
X-CSE-ConnectionGUID: YnCDOfRNS4208s3OZZjK6g==
X-CSE-MsgGUID: Ve1/eBHCTzCU9E41uxp6Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="40103299"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by orviesa008.jf.intel.com with ESMTP; 11 Jun 2024 09:49:57 -0700
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
Subject: [PATCH v2 1/6] x86/irq: Add enumeration of NMI source reporting CPU feature
Date: Tue, 11 Jun 2024 09:54:52 -0700
Message-Id: <20240611165457.156364-2-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240611165457.156364-1-jacob.jun.pan@linux.intel.com>
References: <20240611165457.156364-1-jacob.jun.pan@linux.intel.com>
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
v2: Removed NMI source from static CPU ID dependency table (HPA)
---
 arch/x86/Kconfig                         | 9 +++++++++
 arch/x86/include/asm/cpufeatures.h       | 1 +
 arch/x86/include/asm/disabled-features.h | 8 +++++++-
 arch/x86/kernel/traps.c                  | 4 +++-
 4 files changed, 20 insertions(+), 2 deletions(-)

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

