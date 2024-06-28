Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A32077106;
	Fri, 28 Jun 2024 20:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719605613; cv=none; b=tEHznX8DVlj95uS30+n2xUN29xB99YT42KRhzZKxARsEYl52OioOBH5XYA5q0Fx1jDX0vwu8z3uAriSmSgWqjubj/V8myzf1gMtJ+vsGW+Am19g2fibWfb3XRQT8YRBEtQ/4rmZZZFNk+1gLgvwBuLxlZik8NIxNbKNWvFfiHeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719605613; c=relaxed/simple;
	bh=YaLGreArR0RfUK3ts8KhEHnwYeH8rZjXGYjiewXAyI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XcITi3oxi4L+fe6QwbQR2ZERWfKl1o4Y3mKcP5YEmiTLldxVyoINLVTOFtTNJ4jDOHUPSbBzA4JBSTNNjheF97PhywrukUmCJ89sNSWBuekTu6878mHsDYktCZ89sebHj6LG5NVwrvAGJxqPgEkvcB6zcGjmdWZlbQ21z8npLUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KGZNAk50; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KGZNAk50"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719605612; x=1751141612;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YaLGreArR0RfUK3ts8KhEHnwYeH8rZjXGYjiewXAyI0=;
  b=KGZNAk50MNc0WEUHYUdqNVFHWQBaA4y2UITAMulpODXB5atL7m81dCWr
   RoRR2sCrl7L8z/v+yMXAlAQ3lyhRNiB1mi1BreSfxEATnnqPNWHl75QWq
   kDN/OieGuQMkVBLmksIHAzzXhKNRtAF30g/TY8kONnmEgjU3KMZWQ0+Cj
   vfUkn/HvDmop8gAbi0Qz8pLFDKJnwS3lcPkAMEs3TnakBWVUpQrkJmd1n
   BJz4G5pThsQhLWj9fBNUuT35sCJSWEYSYqToAn0jyst29j1cRrVP8dGTJ
   4YIlnqJQYGIbvPgQFgSufKL+G+CWySblqCJtmSetJ69ijsflfsbnDxEbk
   w==;
X-CSE-ConnectionGUID: WDFWqHaBSq+aE0SBwiEjNw==
X-CSE-MsgGUID: /itxHHwQTzms2+QfgMgY8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="12306980"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="12306980"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 13:13:30 -0700
X-CSE-ConnectionGUID: LZg2+07AQCiVFmAwWpxnvg==
X-CSE-MsgGUID: 4Bg6rPtFRECb+JtZ7Ls3Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="49312566"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa005.fm.intel.com with ESMTP; 28 Jun 2024 13:13:30 -0700
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
Subject: [PATCH v3 02/11] x86/irq: Define NMI source vectors
Date: Fri, 28 Jun 2024 13:18:30 -0700
Message-Id: <20240628201839.673086-3-jacob.jun.pan@linux.intel.com>
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
 arch/x86/include/asm/irq_vectors.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 13aea8fc3d45..e4cd33bc4fef 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -105,6 +105,34 @@
 
 #define NR_VECTORS			 256
 
+/*
+ * The NMI senders specify the NMI source vector as an 8bit integer in their
+ * vector field with NMI delivery mode. A local APIC receiving an NMI will
+ * set the corresponding bit in a 16bit bitmask, which is accumulated until
+ * the NMI is delivered.
+ * When a sender didn't specify an NMI source vector the source vector will
+ * be 0, which will result in bit 0 of the bitmask being set. For out of
+ * bounds vectors >= 16 bit 0 will also be set.
+ * When bit 0 is set, system software must invoke all registered NMI handlers
+ * as if NMI source feature is not enabled.
+ *
+ * Vector 2 is reserved for matching IDT NMI vector where it may be hardcoded
+ * by some external devices.
+ *
+ * The NMI source vectors are sorted by descending priority with the exceptions
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

