Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ACD4F215;
	Tue, 11 Jun 2024 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124600; cv=none; b=AWVAoh1GxuC42YCZPkE6+TnSzJMwpt0wM7rrxynMYbiJZt17T7ugh39ZItVuzO0HVjEYmttt3NrhRjw4m1Kd9Tep03im/jSvlrJN4rntlJFewjts7N24vMld0kel/OeLCYK3Zi5OJ/Z+dRZY3gXwN34g40YsHdaZSCn60C2kDOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124600; c=relaxed/simple;
	bh=g9KRIIibi6flSjPiJqsarRgmVLMT8q7i2OOXiR3xIJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LaYWRmDV9JNPxaWK7LANSZpnnDbbMfZ7bzgc3emAHH+iJD/ZkQHrU8bnHN1SRIABDyLaB6EJpre02d7cEiJrU5upi4mJRaAQ/p5AWf8zUuQu12quWlZM5PWaLTJt+fAdd3IFFILA5yxPnKPQyspWu/GZv9pQl2nz/kY89O/XnPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ACStpkba; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACStpkba"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718124599; x=1749660599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g9KRIIibi6flSjPiJqsarRgmVLMT8q7i2OOXiR3xIJw=;
  b=ACStpkbanr0T1B4Js3Dav+tPu8HcrBz8ySUChqi3E0d6SAIKsDCAHeZL
   1uq//tREoQFN7jX3jRr83Zws5GEtq/MMuz1dqhHIN0M7cLZ9IVj0fVdQw
   eO4fBDmXdsi9Dz2N773yfoWnFv5WamkvEFjIXoBygJ3U9VC11DlHkO+0v
   K+LO9Uk6Vbq2ByU6OrxxXCnDrMJvGl2Y5Z5U1mQfltX0M8SAw3Tu/sW4g
   OaMxJhjN1fFS+c0thbBCBiba3MKyvMSMwshLD7EmfeusUy+FOhcdFJGZ7
   WLXqUVotie2b2WzpJpg/JM8K+Q7HgNz2C2SeOu9+6O/npnQVj8prjuUba
   Q==;
X-CSE-ConnectionGUID: JZS8Gem1Qb2+am+CoCgFXg==
X-CSE-MsgGUID: CgEgTbiUQ52YagVBCDcn/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="40249655"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="40249655"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 09:49:58 -0700
X-CSE-ConnectionGUID: lWU/h40YSp2KdtLwhmY1Ow==
X-CSE-MsgGUID: HFKdOEOYRei4vaPRyp1z2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="40103309"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by orviesa008.jf.intel.com with ESMTP; 11 Jun 2024 09:49:58 -0700
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
Subject: [PATCH v2 4/6] x86/irq: Process nmi sources in NMI handler
Date: Tue, 11 Jun 2024 09:54:55 -0700
Message-Id: <20240611165457.156364-5-jacob.jun.pan@linux.intel.com>
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

With NMI source reporting enabled, NMI handler can prioritize the
handling of sources reported explicitly. If the source is unknown, then
resume the existing processing flow. i.e. invoke all NMI handlers.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

---
v2:
   - Disable NMI source reporting once garbage data is given in FRED
return stack. (HPA)
---
 arch/x86/kernel/nmi.c | 49 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 639a34e78bc9..2c391fd59c34 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -149,12 +149,61 @@ static inline int do_handle_nmi(struct nmiaction *a, struct pt_regs *regs, unsig
 	return thishandled;
 }
 
+static inline int nmi_handle_src(unsigned int type, struct pt_regs *regs)
+{
+	unsigned long source_bitmask;
+	struct nmiaction *a;
+	int handled = 0;
+	int vec = 1;
+
+	if (!cpu_feature_enabled(X86_FEATURE_NMI_SOURCE) || type != NMI_LOCAL)
+		return 0;
+
+	source_bitmask = fred_event_data(regs);
+	if (!source_bitmask) {
+		pr_warn_ratelimited("NMI without source information! Disable source reporting.\n");
+		setup_clear_cpu_cap(X86_FEATURE_NMI_SOURCE);
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
+		return 0;
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
+	}
+	rcu_read_unlock();
+	return handled;
+}
+
 static int nmi_handle(unsigned int type, struct pt_regs *regs)
 {
 	struct nmi_desc *desc = nmi_to_desc(type);
 	struct nmiaction *a;
 	int handled=0;
 
+	handled = nmi_handle_src(type, regs);
+	if (handled)
+		return handled;
+
 	rcu_read_lock();
 
 	/*
-- 
2.25.1

