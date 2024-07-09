Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D033619B5A9;
	Tue,  9 Jul 2024 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535637; cv=none; b=Yq70+5c0QC2FySUSD1A4tcALY4BZvBzYBR5Ak0z8clKTND9/xjq/SBcurEW9aaUqXegvr97HkRbYI3JLSeLnNsP4PxuvPfEG7epCEibGDOb+8EV0mDYRFQEwwfYf5yBEkQHR0Q89Ai8waN87rhhQbAF1juzsIHYkvDlOR7Nc1k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535637; c=relaxed/simple;
	bh=VS9ni2VwrfAqr4zrobW6sHYolEB4aH9bWQ+fNO4ooj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tvk2l8FbwLxCsRCljfuyzDX5CTNeRp429rD2qXDNeXyO4GsW6amiyZ6B8mwsDvPbv40k+LrO/Oge+UmzZ8u5CRk8o7EVCR8pr6Yn4kS4gVBj9YRU6OdIbtEOcZVNgnRemV2Hr+KApTsQSM/qdl5QgEZMB7cSwPS/HvCG+C2CbJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DjMOPV5I; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DjMOPV5I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720535635; x=1752071635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VS9ni2VwrfAqr4zrobW6sHYolEB4aH9bWQ+fNO4ooj4=;
  b=DjMOPV5Ign/CRpfEvoEdMuMi7fuK538HxEuzR7rfFjfIoiyx5VEkNdhw
   1P40bBxOVt1wgiseO8mxOHzy3l2YTcegl3S5G3FKK/r8x/aCqGzVMUrcA
   qfukB8LqP6WwuuFJVgVGLU4Vh0IhQZgev2SFvfHmuSwpz1V4UYCCqRFZK
   EJiudZQls0sZcLw8wurf9gGeLJ6SltvqgWNLELTL4md6KndtXjRo5vBU7
   XImxR4JwMjxeBfitnOhvRHQphg5LFVvkpL4lVOtfZqB5x1G82Z6KZ1cjU
   bmSnXUmPibecffH2U5YPuyGvhuGN7JOmvBxG4b077eZMvwm2Bjp2hViXC
   A==;
X-CSE-ConnectionGUID: r2tbDogIRPOBCh/REyc7Zw==
X-CSE-MsgGUID: QazvpFSAQGCDm02TuSOIGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="35331346"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="35331346"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 07:33:53 -0700
X-CSE-ConnectionGUID: 9EyGfWPpTjmMZsmEwkf5Tg==
X-CSE-MsgGUID: 1hlm4s3TQ0ufMJc3hKIW/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="52272081"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa005.fm.intel.com with ESMTP; 09 Jul 2024 07:33:53 -0700
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
	Nikolay Borisov <nik.borisov@suse.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 02/11] x86/irq: Define NMI source vectors
Date: Tue,  9 Jul 2024 07:38:57 -0700
Message-Id: <20240709143906.1040477-3-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240709143906.1040477-1-jacob.jun.pan@linux.intel.com>
References: <20240709143906.1040477-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When NMI-source reporting is supported, each logical processor maintains
a 16-bit NMI-source bitmap. It is up to the system software to assign NMI
sources for their matching vector (bit position) in the bitmap.

Notice that NMI source vector is in a different namespace than the IDT
vectors. Though they share the same programming interface/field in the
NMI originator.

This initial allocation of the NMI sources are limited to local NMIs in
that there is no external device NMI usage yet.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/include/asm/irq_vectors.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 13aea8fc3d45..4f767c3940d6 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -105,6 +105,36 @@
 
 #define NR_VECTORS			 256
 
+/*
+ * NMI senders specify the NMI-source vector as an 8-bit integer in their
+ * vector field with NMI delivery mode. A local APIC receiving an NMI will
+ * set the corresponding bit in a 16-bit bitmask, which is accumulated until
+ * the NMI is delivered.
+ *
+ * When a sender didn't specify an NMI-source vector the source vector will
+ * be 0, which will result in bit 0 of the bitmask being set. For out of
+ * bounds vectors >= 16, bit 0 will also be set.
+ *
+ * When bit 0 is set, system software must invoke all registered NMI handlers
+ * as if NMI-source reporting feature is not enabled.
+ *
+ * Vector 2 is reserved for matching IDT NMI vector where it may be hardcoded
+ * by some external devices.
+ *
+ * The NMI-source vectors are sorted by descending priority with the exceptions
+ * of 0 and 2.
+ */
+#define NMI_SOURCE_VEC_UNKNOWN		0
+#define NMI_SOURCE_VEC_IPI_REBOOT	1	/* Crash reboot */
+#define NMI_SOURCE_VEC_IDT_NMI		2	/* Match IDT NMI vector 2 */
+#define NMI_SOURCE_VEC_IPI_SMP_STOP	3	/* Panic stop CPU */
+#define NMI_SOURCE_VEC_IPI_BT		4	/* CPU backtrace */
+#define NMI_SOURCE_VEC_PMI		5	/* PerfMon counters */
+#define NMI_SOURCE_VEC_IPI_KGDB		6	/* KGDB */
+#define NMI_SOURCE_VEC_IPI_MCE		7	/* MCE injection */
+#define NMI_SOURCE_VEC_IPI_TEST		8	/* For remote and local IPIs */
+#define NR_NMI_SOURCE_VECTORS		9
+
 #ifdef CONFIG_X86_LOCAL_APIC
 #define FIRST_SYSTEM_VECTOR		POSTED_MSI_NOTIFICATION_VECTOR
 #else
-- 
2.25.1

