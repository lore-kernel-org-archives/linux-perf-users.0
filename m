Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7E319CD1A;
	Tue,  9 Jul 2024 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535639; cv=none; b=rYy897h5iWqKSZfP4VAYG7sBILCtkClUmb+VIi7DFPiJZcOd1l4aRUP8FqyH//N3Xhh3BR7TC82BjFn/loms6VEB2D9HdLEg4pXjs04F0ZKE6RafWrhRrcR7nSUbsYUY1h/qzT//PqwJ2fSDjpoMt586Y4RK/WHN0scGzJ7o4Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535639; c=relaxed/simple;
	bh=iaJOBgXkMYqcjVwDy7NXFZoZ4Ju5ZpTja3j/JLXPjU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rUuNQz+uHkFrM2dV991Avl2/t4VxXmiYVN+YpxLyq/xq3+Kuzut5zGsYX4XMdklMb0tUMsiEQMrBITPvmRdXIHAgeo7a9HniAx81DZZ2tPdZGa+oGBPZ59wFCR52hMlZ9hHli7XxgGB8u046sL02s8JAQneXOW2QDZwALWNr5qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FBFSK/bx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBFSK/bx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720535638; x=1752071638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iaJOBgXkMYqcjVwDy7NXFZoZ4Ju5ZpTja3j/JLXPjU4=;
  b=FBFSK/bxw6ZCaGOfldw4pxfOV2ajMZtQMyX7l0dORCOt9iOQvTxRhX0f
   PQvmLSaVQlvdnKgg7iiDfBTFvUva+q9dgTuFTZ35WqUDAeCgQ6UlWz2PR
   yQ+KYPxTyAVhAl0+qyD5HQI7XYK+gvxMr5+1xMTUtbvcX3Lah6FC8qbN/
   rwBCUf8o7foMYNMR7NrxlLnlQ0clEvCA+p6fUxoFz3MELn1ZQm2sYLUUL
   r/5Vnxcdslm9OBbE8/OIYwtnaH4ilRz+48Q08atHKzBdo75L1UYxwr0/i
   pNaLjfb8/PbxSq61Hs3CPXsW8y2uM4MaSjxrm5el7Zx2lR4PnIh57+VRG
   g==;
X-CSE-ConnectionGUID: Yqc/3mHXTx2La2hoLhPO5Q==
X-CSE-MsgGUID: CeRM5W9LRBGtlD/n+zhD2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="35331388"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="35331388"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 07:33:55 -0700
X-CSE-ConnectionGUID: V10aiNfrSaGuCPhre1xxew==
X-CSE-MsgGUID: ZGSbm3xXTEi6F4ztQpQ2Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="52272100"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa005.fm.intel.com with ESMTP; 09 Jul 2024 07:33:55 -0700
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
Subject: [PATCH v4 05/11] x86/irq: Process nmi sources in NMI handler
Date: Tue,  9 Jul 2024 07:39:00 -0700
Message-Id: <20240709143906.1040477-6-jacob.jun.pan@linux.intel.com>
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

When NMI-source reporting is enabled, the vector 2 NMI handler can
prioritize the handling of explicitly reported sources. If the source
is unknown, it will continue with the existing processing flow, meaning
all NMI handlers will be invoked.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

---
v4:
   - Coding style changes (Li Xin)
   - Renamed handled_mask to partial_bitmap (Nikolay)
v3:
   - Use a static flag to disable NMIs in case of HW failure
   - Optimize the case when unknown NMIs are mixed with known NMIs(HPA)
v2:
   - Disable NMI source reporting once garbage data is given in FRED
return stack. (HPA)

process nmi

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/kernel/nmi.c | 83 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index b96667eed106..edb169289a1d 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -149,12 +149,89 @@ static inline int do_handle_nmi(struct nmiaction *a, struct pt_regs *regs, unsig
 	return thishandled;
 }
 
+static int nmi_handle_src(unsigned int type, struct pt_regs *regs, unsigned long *partial_bitmap)
+{
+	static bool nmi_source_disabled;
+	bool has_unknown_src = false;
+	unsigned long source_bitmap;
+	struct nmiaction *a;
+	int handled = 0;
+	int vec;
+
+	if (!cpu_feature_enabled(X86_FEATURE_NMI_SOURCE) || type != NMI_LOCAL || nmi_source_disabled)
+		return 0;
+
+	source_bitmap = fred_event_data(regs);
+	if (unlikely(!source_bitmap)) {
+		pr_warn("Buggy hardware! Disable NMI-source handling.\n");
+		nmi_source_disabled = true;
+		return 0;
+	}
+
+	/*
+	 * There is no guarantee that a valid NMI-source vector is always
+	 * delivered, even when the originator specified one. It is software's
+	 * responsibility to check all available NMI sources when bit 0 is set
+	 * in the NMI-source reporting bitmap. I.e. we have to call every
+	 * handler as if there is no NMI-source reporting feature enabled.
+	 *
+	 * In this case, handlers for the known NMI sources will be called
+	 * first, followed by the remaining handlers, which are called
+	 * during the subsequent polling code.
+	 *
+	 * Conversely, if non-zero vectors appear in the source bitmap, we
+	 * can precisely identify the sources. Therefore, we only invoke the
+	 * handlers for which the corresponding bits are set.
+	 */
+	if (unlikely(source_bitmap & BIT(NMI_SOURCE_VEC_UNKNOWN))) {
+		pr_warn_ratelimited("NMI received with unknown sources\n");
+		has_unknown_src = true;
+	}
+
+	rcu_read_lock();
+
+	/* Bit 0 is for unknown NMI sources, skip it. */
+	vec = 1;
+	for_each_set_bit_from(vec, &source_bitmap, NR_NMI_SOURCE_VECTORS) {
+		a = rcu_dereference(nmiaction_src_table[vec]);
+		if (!a) {
+			pr_warn_ratelimited("NMI-source vector %d has no handler!", vec);
+			continue;
+		}
+
+		handled += do_handle_nmi(a, regs, type);
+
+		/*
+		 * Needs polling if the unknown source bit is set.
+		 * partial_bitmap is used to tell the polling code which
+		 * NMIs have already been handled based on explicit source
+		 * thus can be skipped.
+		 */
+		if (has_unknown_src)
+			*partial_bitmap |= BIT(vec);
+	}
+
+	rcu_read_unlock();
+
+	return handled;
+}
+
 static int nmi_handle(unsigned int type, struct pt_regs *regs)
 {
 	struct nmi_desc *desc = nmi_to_desc(type);
+	unsigned long partial_bitmap = 0;
 	struct nmiaction *a;
 	int handled=0;
 
+	/*
+	 * Check if the NMI source handling is complete, otherwise polling is
+	 * still required. partial_bitmap is non-zero if NMI source handling is
+	 * partial due to unknown NMI sources.
+	 */
+	handled = nmi_handle_src(type, regs, &partial_bitmap);
+	if (handled && !partial_bitmap)
+		return handled;
+
 	rcu_read_lock();
 
 	/*
@@ -163,8 +240,12 @@ static int nmi_handle(unsigned int type, struct pt_regs *regs)
 	 * can be latched at any given time.  Walk the whole list
 	 * to handle those situations.
 	 */
-	list_for_each_entry_rcu(a, &desc->head, list)
+	list_for_each_entry_rcu(a, &desc->head, list) {
+		/* Skip NMIs handled earlier with source info */
+		if (BIT(a->source_vec) & partial_bitmap)
+			continue;
 		handled += do_handle_nmi(a, regs, type);
+	}
 
 	rcu_read_unlock();
 
-- 
2.25.1

