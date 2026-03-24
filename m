Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4585C30B51D;
	Tue, 24 Mar 2026 00:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313190; cv=none; b=NiV/cwQijsSd7i9ER29RLYQS7y8GFX/z/Zx57KMd9epTWlWZpOGEdUYetQcaAZoRCQuRACP53oEtRoI8zxhn33sqPPP+P2smQVRC+Z/6SAZ0LzuHE2u7WSy+eHNH6PU2P/1lg2KdX94WIgUpMAKbrn6oALDjoeWMbinxrhplLlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313190; c=relaxed/simple;
	bh=6xvz8ppUyFqbHOKlRedXt1nvKmP3kmo26rzwqLv2/Dw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=esuCd4w7ZhhExvVLGGNeWKMcrzdeAAWIqHTaahG7IOYAilXOsS2CUUGYmf63lMkW77a3z/RjId/0xapH8oYBmSiF0t5WDYta/BcI2gz0FRBl55NcdJvf2SnPOxK5Pb3DgmXPRksidQ58FQ0gB+I0+MMtnKXkDuvBeIrnvp0wEno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4aSEHJY; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4aSEHJY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774313189; x=1805849189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6xvz8ppUyFqbHOKlRedXt1nvKmP3kmo26rzwqLv2/Dw=;
  b=H4aSEHJYpJfU7ssi/KTU//kVvllkPMM29mf/MswRdrU0/ap39IY41pCr
   LIHueKDPydnZnK30PfaNFEH9y1w3bOsgSEnmwAh8dUnD3Y9+Pl3wgpJdb
   Jrv+ssVNIKDvhLHiHWyysEr4pUYPl4ep32xyV8HLVnFUhJAuFBJqM7LMr
   /nJf8dQa3s4AZkrmeXqbnvwuzxwQc1tzcJFmSo6iOWxukQH3GEgZwKhZR
   neWC+YY0JBlTs1wqehxN8KCz9SGtWw+ReQC9DAqvk27Ogk4pUGGNWgPOc
   APg2KAkGMEm0kyXCzyMQvEx8AN4zQiPLtBtzEUHcsXmb9DmtTkiqAxkWP
   A==;
X-CSE-ConnectionGUID: mvtxNKphSZemYDE9GHCzKQ==
X-CSE-MsgGUID: v++RZfC7SHaJ1RWvXuYXxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86397085"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86397085"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 17:46:29 -0700
X-CSE-ConnectionGUID: SN+qMK9CQ2+8D1HxRucQ5A==
X-CSE-MsgGUID: ufJXQwtSRLKdsSddOR1LRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="221322720"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 23 Mar 2026 17:46:24 -0700
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
Subject: [Patch v7 08/24] x86/fpu/xstate: Add xsaves_nmi() helper
Date: Tue, 24 Mar 2026 08:41:02 +0800
Message-Id: <20260324004118.3772171-9-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
References: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
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
index 76153dfb58c9..39e5f9e79a4c 100644
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

