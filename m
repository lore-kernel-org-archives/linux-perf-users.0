Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEE01C8FB7;
	Wed, 29 May 2024 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717014518; cv=none; b=GABv32gei74P0lXjrgEsRa1o2O8Vn1YkzeWRkW0nC1zVpJTMK2P4xF9YGqyzAGzBko68rNzZyO67qI7HqGctT87tpWj4V7FwZ08Q3N2P9JMRHKLa0ryxVAjChCqkh9Q4emv0Me1rZe/yU1nD9Semsh9Ga90b29xN7IOX4LHjQz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717014518; c=relaxed/simple;
	bh=OzDhCGOxOXfNQnK7LQxh+1TRrj9b9K7AgFE2duCxNjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eJzACIxtjNG1d6WcXqvdARl21B2qE729WebFfQ4nFjTd67JCqbEVeOGKPl8yMmmvvu16rzMs6Tby9/C190HTrbAwfXFfMgi5uLngJ6cEo/8uhsGvQrKaHca5zKpnOY3uylp+8K5+VoHRKmpgjIu1LK0G8OFFN+y1iI/80uT/CZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YyZMyHzf; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YyZMyHzf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717014517; x=1748550517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OzDhCGOxOXfNQnK7LQxh+1TRrj9b9K7AgFE2duCxNjs=;
  b=YyZMyHzfiX9Jh0HUAiNNOMnQmdP3IO9Xy/nJs5iBFZp7/DgnXdyfOQvX
   ++LMLIO7RLyO5kIWaQx97YqRBvpNBEDJr9tPxY4WPE+JJbVEoLUvdlG8S
   JrYgZbCewIMSAOuNF0HKJc38457LPe/evVhpl3zNULvZvVfckWehLkawV
   lhGE/exqCMkWczMmA5SgWLF4/Q4w0E7djQ19kXW4eUysEWVDhhEgvkvk/
   fV7KrCfmzpnuRktvHdy1aKEOB948IqKUI268lKD8Q4QtSuYJy4QVg8v5V
   23+3y3vMIrBZ/wMgut7+oBW+G8VOTZFqUqySp9s+VnciEf+bFTh33OgMz
   Q==;
X-CSE-ConnectionGUID: AdGIypunSa2mG82IbUnIUQ==
X-CSE-MsgGUID: Y2t8jaDaTTOLk/gW3w+U9w==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13574568"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13574568"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 13:28:35 -0700
X-CSE-ConnectionGUID: 3ztwErLcQl+m1YgkHjaImw==
X-CSE-MsgGUID: 5DX4HpxrRemJsikK5emZKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35491299"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa007.fm.intel.com with ESMTP; 29 May 2024 13:28:35 -0700
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
Subject: [PATCH 6/6] x86/irq: Enable NMI source on IPIs delivered as NMI
Date: Wed, 29 May 2024 13:33:25 -0700
Message-Id: <20240529203325.3039243-7-jacob.jun.pan@linux.intel.com>
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

Program designated NMI source vectors for all NMI delivered IPIs
such that their handlers can be selectively invoked.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/include/asm/irq_vectors.h | 10 ++++++++++
 arch/x86/kernel/apic/hw_nmi.c      |  3 ++-
 arch/x86/kernel/apic/ipi.c         |  4 ++--
 arch/x86/kernel/apic/local.h       | 18 ++++++++++++------
 arch/x86/kernel/cpu/mce/inject.c   |  2 +-
 arch/x86/kernel/kgdb.c             |  2 +-
 arch/x86/kernel/nmi_selftest.c     |  2 +-
 arch/x86/kernel/reboot.c           |  2 +-
 arch/x86/kernel/smp.c              |  2 +-
 9 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index b8388bc00cde..a13ce6e96542 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -126,6 +126,16 @@
 #define NMI_SOURCE_VEC_IPI_TEST		7	/* For remote and local IPIs*/
 #define NR_NMI_SOURCE_VECTORS		8
 
+/*
+ * When programming the local APIC, IDT NMI vector and NMI source vector
+ * are encoded in a single 32 bit variable. The top 16 bits contain
+ * the NMI source vector and the bottom 16 bits contain NMI_VECTOR (2)
+ * The top 16 bits are always zero when NMI source feature is not enabled
+ * or the caller does not use NMI source.
+ */
+#define NMI_VECTOR_WITH_SOURCE(src)	(NMI_VECTOR | (src << 16))
+#define NMI_SOURCE_VEC_MASK		GENMASK(15, 0)
+
 #ifdef CONFIG_X86_LOCAL_APIC
 #define FIRST_SYSTEM_VECTOR		POSTED_MSI_NOTIFICATION_VECTOR
 #else
diff --git a/arch/x86/kernel/apic/hw_nmi.c b/arch/x86/kernel/apic/hw_nmi.c
index 9f0125d3b8b0..f73ca95d961e 100644
--- a/arch/x86/kernel/apic/hw_nmi.c
+++ b/arch/x86/kernel/apic/hw_nmi.c
@@ -20,6 +20,7 @@
 #include <linux/nmi.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <asm/irq_vectors.h>
 
 #include "local.h"
 
@@ -33,7 +34,7 @@ u64 hw_nmi_get_sample_period(int watchdog_thresh)
 #ifdef arch_trigger_cpumask_backtrace
 static void nmi_raise_cpu_backtrace(cpumask_t *mask)
 {
-	__apic_send_IPI_mask(mask, NMI_VECTOR);
+	__apic_send_IPI_mask(mask, NMI_VECTOR_WITH_SOURCE(NMI_SOURCE_VEC_IPI_BT));
 }
 
 void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 5da693d633b7..9d2b18e58758 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -157,7 +157,7 @@ static void __default_send_IPI_shortcut(unsigned int shortcut, int vector)
 	 * issues where otherwise the system hangs when the panic CPU tries
 	 * to stop the others before launching the kdump kernel.
 	 */
-	if (unlikely(vector == NMI_VECTOR))
+	if (unlikely(is_nmi_vector(vector)))
 		apic_mem_wait_icr_idle_timeout();
 	else
 		apic_mem_wait_icr_idle();
@@ -174,7 +174,7 @@ void __default_send_IPI_dest_field(unsigned int dest_mask, int vector,
 				   unsigned int dest_mode)
 {
 	/* See comment in __default_send_IPI_shortcut() */
-	if (unlikely(vector == NMI_VECTOR))
+	if (unlikely(is_nmi_vector(vector)))
 		apic_mem_wait_icr_idle_timeout();
 	else
 		apic_mem_wait_icr_idle();
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index 842fe28496be..60e90b7bf058 100644
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -12,6 +12,7 @@
 
 #include <asm/irq_vectors.h>
 #include <asm/apic.h>
+#include <asm/nmi.h>
 
 /* X2APIC */
 void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest);
@@ -26,19 +27,24 @@ extern u32 x2apic_max_apicid;
 
 DECLARE_STATIC_KEY_FALSE(apic_use_ipi_shorthand);
 
+static inline bool is_nmi_vector(int vector)
+{
+	return (vector & NMI_SOURCE_VEC_MASK) == NMI_VECTOR;
+}
+
 static inline unsigned int __prepare_ICR(unsigned int shortcut, int vector,
 					 unsigned int dest)
 {
 	unsigned int icr = shortcut | dest;
 
-	switch (vector) {
-	default:
-		icr |= APIC_DM_FIXED | vector;
-		break;
-	case NMI_VECTOR:
+	if (is_nmi_vector(vector)) {
 		icr |= APIC_DM_NMI;
-		break;
+		if (cpu_feature_enabled(X86_FEATURE_NMI_SOURCE))
+			icr |= vector >> 16;
+	} else {
+		icr |= APIC_DM_FIXED | vector;
 	}
+
 	return icr;
 }
 
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 365a03f11d06..07bc6c29bd83 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -270,7 +270,7 @@ static void __maybe_unused raise_mce(struct mce *m)
 					mce_irq_ipi, NULL, 0);
 				preempt_enable();
 			} else if (m->inject_flags & MCJ_NMI_BROADCAST)
-				__apic_send_IPI_mask(mce_inject_cpumask, NMI_VECTOR);
+				__apic_send_IPI_mask(mce_inject_cpumask, NMI_VECTOR_WITH_SOURCE(NMI_SOURCE_VEC_IPI_MCE));
 		}
 		start = jiffies;
 		while (!cpumask_empty(mce_inject_cpumask)) {
diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index d167eb23cf13..02198cf9fe21 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -416,7 +416,7 @@ static void kgdb_disable_hw_debug(struct pt_regs *regs)
  */
 void kgdb_roundup_cpus(void)
 {
-	apic_send_IPI_allbutself(NMI_VECTOR);
+	apic_send_IPI_allbutself(NMI_VECTOR_WITH_SOURCE(NMI_SOURCE_VEC_IPI_KGDB));
 }
 #endif
 
diff --git a/arch/x86/kernel/nmi_selftest.c b/arch/x86/kernel/nmi_selftest.c
index f014c8a66b0c..5aa122d3368c 100644
--- a/arch/x86/kernel/nmi_selftest.c
+++ b/arch/x86/kernel/nmi_selftest.c
@@ -76,7 +76,7 @@ static void __init test_nmi_ipi(struct cpumask *mask)
 	/* sync above data before sending NMI */
 	wmb();
 
-	__apic_send_IPI_mask(mask, NMI_VECTOR);
+	__apic_send_IPI_mask(mask, NMI_VECTOR_WITH_SOURCE(NMI_SOURCE_VEC_IPI_TEST));
 
 	/* Don't wait longer than a second */
 	timeout = USEC_PER_SEC;
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index acc19c1d3b4f..fb63bc0d6a0f 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -918,7 +918,7 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 	 */
 	wmb();
 
-	apic_send_IPI_allbutself(NMI_VECTOR);
+	apic_send_IPI_allbutself(NMI_VECTOR_WITH_SOURCE(NMI_SOURCE_VEC_IPI_REBOOT));
 
 	/* Kick CPUs looping in NMI context. */
 	WRITE_ONCE(crash_ipi_issued, 1);
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index f27469e40141..b79e78762a73 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -217,7 +217,7 @@ static void native_stop_other_cpus(int wait)
 			pr_emerg("Shutting down cpus with NMI\n");
 
 			for_each_cpu(cpu, &cpus_stop_mask)
-				__apic_send_IPI(cpu, NMI_VECTOR);
+				__apic_send_IPI(cpu, NMI_VECTOR_WITH_SOURCE(NMI_SOURCE_VEC_IPI_SMP_STOP));
 		}
 		/*
 		 * Don't wait longer than 10 ms if the caller didn't
-- 
2.25.1

