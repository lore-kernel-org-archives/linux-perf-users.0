Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67E629D28F;
	Wed,  3 Dec 2025 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764745102; cv=none; b=IScpuFN/MKuAZle4V8dMZxUzxAKAvevSC5zfWe5bLWb3/JR2vrOStAjslet17BdIry0vHgng01uHk1kX7Wj20LRoE59LobAgGvUlN4BXEIne8KLI/hT7V5xRnXIAgJk/BhPLSz2HSr8Pkw1Qli72yRxmrVlxLlb8eDNKTk0doF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764745102; c=relaxed/simple;
	bh=x9ZgONUDtVCEjRBKBlKFNPl1U5MMoEuvT00xRdCh3hY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JS+Z3E2vwdZCFq4yrfSnHGgYy8HQ73/UOSA9piIEVeKKOicEhXfOMKw3F+OK/oymaxv197HpaX4GA+ZJqyB5d5sGg8cX+7E8IsqZXPeqJ15f4mBAjTI16EmYbEglypIrbqyiOV89CjAQAxwl2hMnQCvYyc2zfbE2w9uLu7u/5dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eblIBhu2; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eblIBhu2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764745101; x=1796281101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x9ZgONUDtVCEjRBKBlKFNPl1U5MMoEuvT00xRdCh3hY=;
  b=eblIBhu2Ie+/b10v2D92au3bPHac9PC5ty184zQJrNwokQOPCOcmWj4A
   5QlRtr0gG/IDbyU/M6rAZ7QOPEpF4rW12z7hHPaLFo9eso7HdLnSUqv0R
   fDF7Z0MNLmIPUpVUJTiBX3123mWIrwY5bj+bitkk/A4kWXdUIIiXcBUi+
   QnfcyZLOhzdNwFlzmmHCAGfWyEMXevtkATWbPyGd5s5+1njAVsVPXcxbd
   4BVkqr0uOxnfT2E0Dg+9XOhkUiLOyMOX7s54hs3Mw7EnWT8n/pfVoWNkJ
   XL5y+hUEJa5fjkXprzv7FyftNA0SGR8BAv8+EOp/6l8Y87f9en92aOyo+
   Q==;
X-CSE-ConnectionGUID: XiA6jZV1Qbyn9Kor3d3gpw==
X-CSE-MsgGUID: TOObFZtJSvadtg1wnFBE8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="84324778"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="84324778"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 22:58:21 -0800
X-CSE-ConnectionGUID: g3Oeze4KQlWJ+Y0l+vENIQ==
X-CSE-MsgGUID: cwFpJBJuTOGkVVA/pHwITQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="199003803"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa005.fm.intel.com with ESMTP; 02 Dec 2025 22:58:16 -0800
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
Subject: [Patch v5 04/19] x86/fpu/xstate: Add xsaves_nmi() helper
Date: Wed,  3 Dec 2025 14:54:45 +0800
Message-Id: <20251203065500.2597594-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
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
index 28e4fd65c9da..e3b8afed8b2c 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1474,6 +1474,29 @@ void xrstors(struct xregs_state *xstate, u64 mask)
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

