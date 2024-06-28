Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D189A7FBD1;
	Fri, 28 Jun 2024 20:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719605618; cv=none; b=avXQcfR3Bv9nq5st+9DoLO9HaOmHgsAvWnSvPU+WkBaRuFd7YJS9K6Bhr93AJOZEzLfFNDIpCRcHODOsDu99UWF4PzrQ8zWOlQLtimAY8aIOHcYhQjcrvAG9fTn1E+4lOGH6pfY8+tpHH6RwhYQ5JMLnCoTlkwiM8Zp0jQad6Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719605618; c=relaxed/simple;
	bh=iBLQ6Tub7d00Y27yhd75nvfYjn+GuvWBLg/Pb8XSVR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XCnWcXJfMFMsWfJljbwgzdGGWwPlevxcsQLvqxXsnBs3+MLdekxhaD3wUb08DDyYCMYGrqc6guLlUgMpSpQfVTy+HAMghvHMmxkEJL/UdF1eOHIU8yVhEdvhsH+LcHUG6kCltAsA2L7JW0YOq2CC509mzPLJTkRqm+sQaI82aLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MX77Cogd; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MX77Cogd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719605616; x=1751141616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iBLQ6Tub7d00Y27yhd75nvfYjn+GuvWBLg/Pb8XSVR0=;
  b=MX77CogdRbkms6QbUJpGTbxEb1xPCAqRUH+hNiM4xwP8bMHCZJbnsBxi
   1ywiz+BispRG8LmtgQ4EFHo7gVyLdUVqxCKvMWd5/WqUiZ6vCfsq7K6mi
   W+x8wrCelmTr8hbi15jeCjD/x5/tpSNR/qY+nDU9ZHBgtj00gaDmy6u10
   sqs7wUNsVs2/SMWD/P1qMj06a7gJjJ31jDmgc9eCWxp0WO0R+CgqwfjsK
   4zyBqXr4wH82izsNCx2OdJ1JX3ff1VeZhnzu0XNkpeLaWFZAqPEveA4Vd
   RvEHnusa7BKBxwhCylhd2eUoTQc7RZ7laqT6OefTKf5wIePpHULZiBFzI
   g==;
X-CSE-ConnectionGUID: 3ZDx6P17RqiEO2G9tNvL4g==
X-CSE-MsgGUID: HrBjqJFGTNK40ZEXqKqHnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="12307036"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="12307036"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 13:13:34 -0700
X-CSE-ConnectionGUID: WtlFv8AERYupM5Vr+TkZfQ==
X-CSE-MsgGUID: oTSGtKNJTviDZdUtwsrVvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="49312600"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa005.fm.intel.com with ESMTP; 28 Jun 2024 13:13:34 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: X86 Kernel <x86@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Ingo Molnar" <mingo@redhat.com>,
	"Borislav Petkov" <bp@alien8.de>,
	"Xin Li" <xin3.li@intel.com>,
	linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Tony Luck <tony.luck@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	acme@kernel.org,
	kan.liang@linux.intel.com,
	Andi Kleen <andi.kleen@intel.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 09/11] x86/irq: Enable NMI source on IPIs delivered as NMI
Date: Fri, 28 Jun 2024 13:18:37 -0700
Message-Id: <20240628201839.673086-10-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240628201839.673086-1-jacob.jun.pan@linux.intel.com>
References: <20240628201839.673086-1-jacob.jun.pan@linux.intel.com>
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
index e4cd33bc4fef..4cedebdc1afb 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -133,6 +133,16 @@
 #define NMI_SOURCE_VEC_IPI_TEST		8	/* For remote and local IPIs */
 #define NR_NMI_SOURCE_VECTORS		9
 
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

