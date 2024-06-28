Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4AD78C7A;
	Fri, 28 Jun 2024 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719605615; cv=none; b=n2jLam3u4G7KoBRVh64641uU13s760KQxR+n98ZglO8+ZCjsVpuOIUw2x3zi8L+wvX26o96lidCmY07WCbeXLxWAaG7qe6+Q8tuw0LXH79ICbpkeYSDNFUtS6+5PNBN2JdKAElcS1YLG8oxnMDcYEuxTRPxoY+4YtpvBPCPmrsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719605615; c=relaxed/simple;
	bh=omPgNj4vn9rg/7X/W1rrU+ad7KQp3WxkvLYbjpheWIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mIPP5FaJzY2Utl8pBxL7mxwXMDvGHy9FCZXk3ZDRx0b+PhirAoyeM7C+orTJxrYDMK3ptzcYvOjjRMBLTsD8avZ7jgaKJKJOhOl8w8nvhUX9BGjsj71TxVUiX80pq16wFTmu0wRsDfeMVXzth447WbaZ4tfhbiTP2zFxzx70KD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=irsGS1E3; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="irsGS1E3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719605614; x=1751141614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=omPgNj4vn9rg/7X/W1rrU+ad7KQp3WxkvLYbjpheWIs=;
  b=irsGS1E3CLde5XKt0hk+puaezehDY2aqzIuySKFfqU82eA/o2mFrvy/M
   XrpkKAkDxoC1mOFN1bEhupcFNZlRxfuBGxu3zdiDBx+wjb81dBtPtrH6X
   bIiCVrIbe0miJLbMt0XPx0SCmldCtuG0TyFN6SO6GPZ1aqJAmvWCL1hjK
   K5B/LKOUf3+YDDMrHRiYZr+yq90Wbj8UaFaT2Qp6Ury+WhQQm5pqDfXqU
   cjvz8K3oubFXH/uyzH4TqFCCs1CQJS1PidcEFO+O3rKgzXpRhy9TaLtUl
   plmmR/NG3xPh/X1d0WefxTdNQEvagwq1LqcR5zf0KsNEWbh+5KsHlTl/S
   A==;
X-CSE-ConnectionGUID: jlo54/F8RZa6RgKBE2ZprA==
X-CSE-MsgGUID: aHSYvlKnR0GEvDwmPuRQ8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="12307004"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="12307004"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 13:13:32 -0700
X-CSE-ConnectionGUID: ouM+YWGZQ6yE25ZvcJpS7w==
X-CSE-MsgGUID: /uQ/kxEpSLWzi4duddorBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="49312583"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa005.fm.intel.com with ESMTP; 28 Jun 2024 13:13:32 -0700
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
Subject: [PATCH v3 05/11] x86/irq: Process nmi sources in NMI handler
Date: Fri, 28 Jun 2024 13:18:33 -0700
Message-Id: <20240628201839.673086-6-jacob.jun.pan@linux.intel.com>
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

With NMI source reporting enabled, NMI handler can prioritize the
handling of sources reported explicitly. If the source is unknown, then
resume the existing processing flow. i.e. invoke all NMI handlers.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

---
v3:
   - Use a static flag to disable NMIs in case of HW failure
   - Optimize the case when unknown NMIs are mixed with known NMIs(HPA)
v2:
   - Disable NMI source reporting once garbage data is given in FRED
return stack. (HPA)
---
 arch/x86/kernel/nmi.c | 73 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 639a34e78bc9..c3a10af7f26b 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -149,23 +149,90 @@ static inline int do_handle_nmi(struct nmiaction *a, struct pt_regs *regs, unsig
 	return thishandled;
 }
 
+static int nmi_handle_src(unsigned int type, struct pt_regs *regs, unsigned long *handled_mask)
+{
+	static bool nmi_source_disabled;
+	bool has_unknown_src = false;
+	unsigned long source_bitmask;
+	struct nmiaction *a;
+	int handled = 0;
+	int vec = 1;
+
+	if (!cpu_feature_enabled(X86_FEATURE_NMI_SOURCE) ||
+	    type != NMI_LOCAL || nmi_source_disabled)
+		return 0;
+
+	source_bitmask = fred_event_data(regs);
+	if (!source_bitmask) {
+		pr_warn("NMI received without source information! Disable source reporting.\n");
+		nmi_source_disabled = true;
+		return 0;
+	}
+
+	/*
+	 * Per NMI source specification, there is no guarantee that a valid
+	 * NMI vector is always delivered, even when the source specified
+	 * one. It is software's responsibility to check all available NMI
+	 * sources when bit 0 is set in the NMI source bitmap. i.e. we have
+	 * to call every handler as if we have no NMI source.
+	 * On the other hand, if we do get non-zero vectors, we know exactly
+	 * what the sources are. So we only call the handlers with the bit set.
+	 */
+	if (source_bitmask & BIT(NMI_SOURCE_VEC_UNKNOWN)) {
+		pr_warn_ratelimited("NMI received with unknown source\n");
+		has_unknown_src = true;
+	}
+
+	rcu_read_lock();
+	/* Bit 0 is for unknown NMI sources, skip it. */
+	for_each_set_bit_from(vec, &source_bitmask, NR_NMI_SOURCE_VECTORS) {
+		a = rcu_dereference(nmiaction_src_table[vec]);
+		if (!a) {
+			pr_warn_ratelimited("NMI received %d no handler", vec);
+			continue;
+		}
+		handled += do_handle_nmi(a, regs, type);
+		/*
+		 * Needs polling if unknown source bit is set, handled_mask is
+		 * used to tell the polling code which NMIs can be skipped.
+		 */
+		if (has_unknown_src)
+			*handled_mask |= BIT(vec);
+	}
+	rcu_read_unlock();
+
+	return handled;
+}
+
 static int nmi_handle(unsigned int type, struct pt_regs *regs)
 {
 	struct nmi_desc *desc = nmi_to_desc(type);
+	unsigned long handled_mask = 0;
 	struct nmiaction *a;
 	int handled=0;
 
-	rcu_read_lock();
+	/*
+	 * Check if the NMI source handling is complete, otherwise polling is
+	 * still required. handled_mask is non-zero if NMI source handling is
+	 * partial due to unknown NMI sources.
+	 */
+	handled = nmi_handle_src(type, regs, &handled_mask);
+	if (handled && !handled_mask)
+		return handled;
 
+	rcu_read_lock();
 	/*
 	 * NMIs are edge-triggered, which means if you have enough
 	 * of them concurrently, you can lose some because only one
 	 * can be latched at any given time.  Walk the whole list
 	 * to handle those situations.
 	 */
-	list_for_each_entry_rcu(a, &desc->head, list)
+	list_for_each_entry_rcu(a, &desc->head, list) {
+		/* Skip NMIs handled earlier with source info */
+		if (BIT(a->source_vec) & handled_mask)
+			continue;
 		handled += do_handle_nmi(a, regs, type);
-
+	}
 	rcu_read_unlock();
 
 	/* return total number of NMI events handled */
-- 
2.25.1

