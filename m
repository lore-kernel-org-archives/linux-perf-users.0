Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D876E19D8B5;
	Tue,  9 Jul 2024 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535642; cv=none; b=bU75+jVpaiZwezIBQnZ1YBS7uouiY3Y0RCVD4B3lI/2nnU5GXw9+qxsRYl5OHVSv8GUVS1O6cUf43q38gRkC47Qa5Khego2ZMdHAPIuE90WkvnRjqkSE1HWQUDyvf38GLN5dJLiMP3c7G9NZKmM4cKfFyZWVAEd4tq7j9nn1rHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535642; c=relaxed/simple;
	bh=7bjtdaFBJ2jzOfqirLp/q3lGk0kqaRFheeODQY+sV28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LWn/slDMW2oXNfjC734cOs4N4xMmIhS3KqP3EDKMZztib11aD21E/t4EWheHVMsC2v3bFZ+Zy4aVAx9K+VGWHhI0kc3QPGKONyZ7rzdrxh0cP+SuRlAnInJoEeMpZxJfLllP/HESMlPkr5OLpLpcuqHEktFFYo2K938PnQIeMog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAVyhhkr; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAVyhhkr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720535641; x=1752071641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7bjtdaFBJ2jzOfqirLp/q3lGk0kqaRFheeODQY+sV28=;
  b=VAVyhhkru9cC/2EEKElvc7mMav50aatUk90YNZXaCMfzWC+WiVORXnzl
   k+S9wxjd2Bq5FSvqaWDqd5pZ06U2EylnVZlpMPJFpfoRHPoYbO1Ctp5Hh
   8q0e4lYdzL/uaTlo07QE1mRC1zT0scZ2nRfgh0A4GBxGYnnhqC4J21Tt4
   zg+OwlW3Wd70tx/xstZiNpM6fvT0bIXrz5G8TafYoOgDQYxNMEZzeMa8t
   tRjcHsJvpoMp3XtIrTNjtlUqPyqZBIqOuwypxNgtFlZX1458EGRJ8OvGv
   2g3gj7nxxAtwxi7HlYtkNCFhfLO6xS1GgP1KgS569qZW1r+YcWpHjsn2H
   Q==;
X-CSE-ConnectionGUID: MMg6qS2JTN2RDK0CsEPedA==
X-CSE-MsgGUID: CTkIP8YzSvShX0Sf+yWmQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="35331450"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="35331450"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 07:33:58 -0700
X-CSE-ConnectionGUID: 3NplHUibSXatRqZf7acIIg==
X-CSE-MsgGUID: /pEXfiAETpajXM6lu5VbQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="52272154"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa005.fm.intel.com with ESMTP; 09 Jul 2024 07:33:58 -0700
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
Subject: [PATCH v4 10/11] x86/irq: Move __prepare_ICR to x86 common header
Date: Tue,  9 Jul 2024 07:39:05 -0700
Message-Id: <20240709143906.1040477-11-jacob.jun.pan@linux.intel.com>
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

To reuse __prepare_ICR() outside APIC local code, move it to the x86
common header. e.g. It can be used by the KVM PV IPI code.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/include/asm/apic.h  | 21 +++++++++++++++++++++
 arch/x86/kernel/apic/local.h | 22 ----------------------
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index d284eff7849c..6c98c51dc1b7 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -477,6 +477,27 @@ static __always_inline bool apic_id_valid(u32 apic_id)
 	return apic_id <= apic->max_apic_id;
 }
 
+static inline bool is_nmi_vector(int vector)
+{
+	return (vector & NMI_SOURCE_VEC_MASK) == NMI_VECTOR;
+}
+
+static inline unsigned int __prepare_ICR(unsigned int shortcut, int vector,
+					 unsigned int dest)
+{
+	unsigned int icr = shortcut | dest;
+
+	if (is_nmi_vector(vector)) {
+		icr |= APIC_DM_NMI;
+		if (cpu_feature_enabled(X86_FEATURE_NMI_SOURCE))
+			icr |= vector >> 16;
+	} else {
+		icr |= APIC_DM_FIXED | vector;
+	}
+
+	return icr;
+}
+
 #else /* CONFIG_X86_LOCAL_APIC */
 
 static inline u32 apic_read(u32 reg) { return 0; }
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index 60e90b7bf058..8b1fe152cd2d 100644
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -12,7 +12,6 @@
 
 #include <asm/irq_vectors.h>
 #include <asm/apic.h>
-#include <asm/nmi.h>
 
 /* X2APIC */
 void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest);
@@ -27,27 +26,6 @@ extern u32 x2apic_max_apicid;
 
 DECLARE_STATIC_KEY_FALSE(apic_use_ipi_shorthand);
 
-static inline bool is_nmi_vector(int vector)
-{
-	return (vector & NMI_SOURCE_VEC_MASK) == NMI_VECTOR;
-}
-
-static inline unsigned int __prepare_ICR(unsigned int shortcut, int vector,
-					 unsigned int dest)
-{
-	unsigned int icr = shortcut | dest;
-
-	if (is_nmi_vector(vector)) {
-		icr |= APIC_DM_NMI;
-		if (cpu_feature_enabled(X86_FEATURE_NMI_SOURCE))
-			icr |= vector >> 16;
-	} else {
-		icr |= APIC_DM_FIXED | vector;
-	}
-
-	return icr;
-}
-
 void default_init_apic_ldr(void);
 
 void apic_mem_wait_icr_idle(void);
-- 
2.25.1

