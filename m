Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E089D74BF8;
	Fri, 28 Jun 2024 20:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719605619; cv=none; b=ERzBOg/vO4RqjjIdWO1jjNJ+z6S6ZCGA73qdMia2rBbG6qm42CcA12hcJQjAYVLiw8bdNiNeUHtJG/b85l4chvkdu/RO2Vw73ar705AgZfSnZJJ1QqKa7kw/+r6488sXKQ6gEAxCJEdvNBPQB0OQXkJyJ5OEDzbDACtVmD052JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719605619; c=relaxed/simple;
	bh=iAjlVieiVBJ15AGePcImtybP1kgz5SWH/5azyTpBD0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h+qAtXpnJ1ryZEZH9uHSvnY3JQWdpqELynD41Bg7vUCHkcsYtvgrfTF9O77tvCaEEtWvAlRNrextYjYm0NCK0sbnKKjZRlVhyUcAcz3WO+vTN2Rbrfw63xCkK1A9QrAXJ1zz0yVqW35vkT9FYytFq0KvSXyLeeOdAco33Ox9saE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cvqN3qjv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cvqN3qjv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719605617; x=1751141617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iAjlVieiVBJ15AGePcImtybP1kgz5SWH/5azyTpBD0Q=;
  b=cvqN3qjvdn9NLX346mjbvPtHJpY9+iKPBJMMu+WqvN2am0PI1FpTKgSI
   lHqdAvudZ0KY858kwihYp+A520JBQLajT90ZSNmgDY7sVcogZPYIh8ngd
   AJw4l891G3fnT0qii4WQ0QMfuPx7Srj7W1y9SW3PlzK1hs1l434cBXUfj
   vNM3LtNT+yr9jZEHDyYiBWQeWUiu6oD+yd1TDyJ6l2mMGLfuH72UIgTdC
   aYdaoQr5ykcp/G+1CZkAJQ6rY3moSnPKcLayVChgbgjvyNIjdKlE79Ick
   yZVPrLRyWAswGSgk3Le23aR8+FNRzF1HDbwLjdYirufeLvYFRrUS8nnWl
   g==;
X-CSE-ConnectionGUID: Q2fNbaJyQGyVoU6sZG6AAA==
X-CSE-MsgGUID: BTk9avQbRMaSpwyt8bWZAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="12307044"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="12307044"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 13:13:35 -0700
X-CSE-ConnectionGUID: 6q9W8JQzSsaIIDTaR9oT4g==
X-CSE-MsgGUID: gYTdfIE0TTyv//kaTVserw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="49312605"
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
Subject: [PATCH v3 10/11] x86/irq: Move __prepare_ICR to x86 common header
Date: Fri, 28 Jun 2024 13:18:38 -0700
Message-Id: <20240628201839.673086-11-jacob.jun.pan@linux.intel.com>
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

To reuse __prepare_ICR() outside APIC local code, move it to the x86
common header. e.g. It can be used by the KVM PV IPI code.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/include/asm/apic.h  | 21 +++++++++++++++++++++
 arch/x86/kernel/apic/local.h | 22 ----------------------
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index bcf8d17240c8..7fb4c3dae569 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -476,6 +476,27 @@ static __always_inline bool apic_id_valid(u32 apic_id)
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

