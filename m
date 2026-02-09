Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA643033F5;
	Mon,  9 Feb 2026 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770621925; cv=none; b=ogvRCpHgoNGW2r126fts2uNkWobNk5swjY4aq81kOwkHkTCi1w1dGhn57RzQh5c8+XwKZXpK/xE6FRgPYevzt8/Q2wMa3yHGFl1wilTDN3cNAIWaIGmsmgXP1LFlbyfBCr0VKqn4Ik70/gvLyds9UWJo2Q9AAl/GXnglzxDCUwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770621925; c=relaxed/simple;
	bh=pOowW5PnzCxMKpOIejbunNjOaFcRgVzkr360IxzFQNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DdhrXivrNQO44nU3jiTLhbIVVTlLaiF439xMnT1hOyCn+hxZnFM7LJyTGIyANkllDNgnIutN7bWxWXegY2y0iY80IOpBBgJ4y5lKRiVyjjNsRuhGy9G/BLto9NCrOqgYfkv7F08FqedK4UVWjmilT/Yo1B93T2WvEFS4YVE3OeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RR0KjdCM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RR0KjdCM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770621925; x=1802157925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pOowW5PnzCxMKpOIejbunNjOaFcRgVzkr360IxzFQNA=;
  b=RR0KjdCM7PONO6Xo7zZeBZpEjDIRoDXnJMfREL9AMki9/nchMjAUnx7O
   R/ilMfoeF0q7dHOUhGaymd0joQmCap+R/TgmvwAJ3u6iFitS54IapipIG
   BCkV0kpPE0Whxj99RzXZ4FdSlTczQM9oxdeaQxoY5/nhUjJfvudrzQS+1
   Xp7NF4ae8KwpALPKWJ92dfAhII8MGB2LjbH5Unw8XGVwQNJwRpFSIPCjo
   FBruxqP+KJ4DMsbdzuqMjrpJTpVw7wlQ5yj2tHpipuNZhydWdWlNhMg6b
   gCnAEsTnRrDTq5W+G8CoS4/omhqzAjx8MUOu7UGCCtrjPBRHtKtVGPrV+
   w==;
X-CSE-ConnectionGUID: iAvM8D+XRA6Jgb0VIpr0Qw==
X-CSE-MsgGUID: hIl9GUhtTga2skSE/jyb0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83098333"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="83098333"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:25:25 -0800
X-CSE-ConnectionGUID: 2np2GJv+RDipfh4rNN2qOw==
X-CSE-MsgGUID: kepqQK/bQtyYi/RX0HF5bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="241694628"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa001.fm.intel.com with ESMTP; 08 Feb 2026 23:25:20 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v6 07/22] x86/fpu/xstate: Add xsaves_nmi() helper
Date: Mon,  9 Feb 2026 15:20:32 +0800
Message-Id: <20260209072047.2180332-8-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
References: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Add xsaves_nmi() to save supported xsave states in NMI handler.

This function is similar to xsaves(), but should only be called within
a NMI handler. This function returns the actual register contents at
the moment the NMI occurs.

Currently the perf subsystem is the sole user of this helper. It uses
this function to snapshot SIMD (XMM/YMM/ZMM) and APX eGPRs registers
which would be added in subsequent patches.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/include/asm/fpu/xstate.h |  1 +
 arch/x86/kernel/fpu/xstate.c      | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 7a7dc9d56027..38fa8ff26559 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -110,6 +110,7 @@ int xfeature_size(int xfeature_nr);
 
 void xsaves(struct xregs_state *xsave, u64 mask);
 void xrstors(struct xregs_state *xsave, u64 mask);
+void xsaves_nmi(struct xregs_state *xsave, u64 mask);
 
 int xfd_enable_feature(u64 xfd_err);
 
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 48113c5193aa..33e9a4562943 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1475,6 +1475,29 @@ void xrstors(struct xregs_state *xstate, u64 mask)
 	WARN_ON_ONCE(err);
 }
 
+/**
+ * xsaves_nmi - Save selected components to a kernel xstate buffer in NMI
+ * @xstate:	Pointer to the buffer
+ * @mask:	Feature mask to select the components to save
+ *
+ * This function is similar to xsaves(), but should only be called within
+ * a NMI handler. This function returns the actual register contents at
+ * the moment the NMI occurs.
+ *
+ * Currently, the perf subsystem is the sole user of this helper. It uses
+ * the function to snapshot SIMD (XMM/YMM/ZMM) and APX eGPRs registers.
+ */
+void xsaves_nmi(struct xregs_state *xstate, u64 mask)
+{
+	int err;
+
+	if (!in_nmi())
+		return;
+
+	XSTATE_OP(XSAVES, xstate, (u32)mask, (u32)(mask >> 32), err);
+	WARN_ON_ONCE(err);
+}
+
 #if IS_ENABLED(CONFIG_KVM)
 void fpstate_clear_xstate_component(struct fpstate *fpstate, unsigned int xfeature)
 {
-- 
2.34.1

