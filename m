Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7031C8FBC;
	Wed, 29 May 2024 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717014518; cv=none; b=KhsfS7BPfisu6jaKWdpWt2aYsvSzA+lkwEbpcM+A9ydTRZJBE/dUmuycTJtPpXIfs1bJZtgzibHWSsZaPOSuhbXlDomjVyNcRbccdgjCxaVfecfMtf98RuJhyiO6KvFqC2VCPH/BQNyOPWVLdC2MmTEA4e43rtbO3v4rtSJgsPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717014518; c=relaxed/simple;
	bh=TSM1haBCr0WSs8yC/z+/tCZvjsQB/xQTffI8AknEb/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D+wX5Y15TwI3kvejGZWNNxojJYwG+RT0S4rCo+WkP/XzR+IF6lMwjyUPALhq/zSWzX6Fr/egL1kLwzz6XlKYR68EZlTpzkWjF3Wbf3Mjd0Kdzwl1fOS4n44FDhq9Z9waiNw9MpjwnsBB3ugBFZqfNVIJ1BFGexA6cjBeHmluPao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZqDmzgsG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZqDmzgsG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717014517; x=1748550517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TSM1haBCr0WSs8yC/z+/tCZvjsQB/xQTffI8AknEb/o=;
  b=ZqDmzgsG3tUOTiyRHIP6Ce/dla8LiEKyRSrGUVrSmGjkg27v7o0uSSkd
   kJc3B8wlMQu/+qnKyiRdWJ/s5Lz/gwVGQkFC6LraC1B5pZiYeFFaPri7u
   BYzARMq0Z+vSo1k2xQUsuamFSgJ7Ay/tquk3xwQIr0JIUVs0VdAUrFRDa
   YO1YoKQDo80xRqI4uEX+Z6IbQrWpYeqfOLGz1YReyDGily0eYQL97j4Lt
   3Mm+8oN+Pc24rTzsTjmuwCxzG0HNFApHAONVlE5nUqfCwKiVkotQOpUlX
   Q/ptYo5pnMqb+sc63FcXS25lpdTq57T8fNjy6nFmmng9WslTdD+zgFBaA
   Q==;
X-CSE-ConnectionGUID: 5sktuyZMQ6meP3vn84A3Cg==
X-CSE-MsgGUID: KJQ1xXqqSzadOichZXvkIQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13574554"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13574554"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 13:28:35 -0700
X-CSE-ConnectionGUID: OsUWBup4TiazNZmPXxdMvw==
X-CSE-MsgGUID: XkoolWFiR/q4uGx6lFpkYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35491284"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa007.fm.intel.com with ESMTP; 29 May 2024 13:28:34 -0700
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
Subject: [PATCH 4/6] x86/irq: Process nmi sources in NMI handler
Date: Wed, 29 May 2024 13:33:23 -0700
Message-Id: <20240529203325.3039243-5-jacob.jun.pan@linux.intel.com>
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

With NMI source reporting enabled, NMI handler can prioritize the
handling of sources reported explicitly. If the source is unknown, then
resume the existing processing flow. i.e. invoke all NMI handlers.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/kernel/nmi.c | 48 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index e2122ec9313c..32c285722734 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -149,12 +149,60 @@ static inline int do_handle_nmi(struct nmiaction *a, struct pt_regs *regs, unsig
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
+		pr_warn_ratelimited("NMI received without source information!\n");
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

