Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ADB3716D;
	Tue,  9 Jul 2024 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535636; cv=none; b=JtJteceAGImpIZYp8fEONEunB4eZKbFq99/+gFE/c/Se7xSRVbtMIFa+mWYxVjNTQ+CXIcksrXslwRXliWITGalBxoUCpFw8sRYVsHVvgrgP7MVYJl9gb1tBcrBQU7Sj3uAmZDnlL8MHgAQ/ytQVeRR3hTSGYT1sNrP0FnYgx6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535636; c=relaxed/simple;
	bh=d8UHbC86D5le7EhTyKfMWZTXd5alVS+oeTMGdeu7JY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rOqVQZx//AB5YFswWsfho8g2eNuknn3JT5qMgb1l/ftDG5Ix0aJkOBpWw4Rj7iqcQGhptxcQOepHTnqTW7ChvCEMhtSVzZpLbgXUu5A+SEJjnO8oMz8awbyawyOcc/IzSjvZ78tdShWcAtlId80Si5mNuh75+MceYmt4FgUz5RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J8e+e+63; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J8e+e+63"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720535634; x=1752071634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d8UHbC86D5le7EhTyKfMWZTXd5alVS+oeTMGdeu7JY0=;
  b=J8e+e+63802cv+ytCvqlbGrGp6QroEnt85Lo/W6YW44xxgKbnM6KAjdu
   tQGW0uj9V9zRu+ZxyMB96AMydUWEPZ11IcimNW9xqPpt/XiFXoI089wcE
   7lTgT4Zv87X74HAiO1iA+z3iYQMd4U8oMixfY05hrhFfnq4dCY8Yq4zqN
   ZcTv0Wl9ISh3grv3J8mBzkZRcpCOBFbNwt3CrTtpOOMJ58s6ZkkcrmZ6B
   VQCJKcAXRBTEsWnua2aOKr7KdEJyjUdgSUdznntzSLEvO37U04BuvHaW7
   /oewiDy9ON+O2Uq2EZ9CO2BrbIvJNNhQX++rDwhwMaxlVwM0N5DsW08Vx
   A==;
X-CSE-ConnectionGUID: IY6cXwcrQGe5TB7KoR3Uwg==
X-CSE-MsgGUID: CL7g3HfDTA2NW+wywCy3Mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="35331337"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="35331337"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 07:33:52 -0700
X-CSE-ConnectionGUID: WjBxYSdeSr+l1uueDFXWhg==
X-CSE-MsgGUID: HdbKbu9yT+uxmYJRgU4guA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="52272060"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa005.fm.intel.com with ESMTP; 09 Jul 2024 07:33:52 -0700
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
Subject: [PATCH v4 01/11] x86/irq: Add enumeration of NMI source reporting CPU feature
Date: Tue,  9 Jul 2024 07:38:56 -0700
Message-Id: <20240709143906.1040477-2-jacob.jun.pan@linux.intel.com>
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
v3: Removed CONFIG_X86_NMI_SOURCE (Li Xin, HPA, Sohil)
v2: Removed NMI source from static CPU ID dependency table (HPA)
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/traps.c            | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

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

