Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79972E973C;
	Thu, 25 Sep 2025 06:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780869; cv=none; b=kSmYKda3ofznsPhKYGFLUjW/IZxDlL0UYDJG7wCsQyGa9kaxxlwhlBCxhWpMnjKUiOkBBLXqzpeDywhzmo7DC1AELCRReKmasqsm8ZEgtUxqoQkeqGSO24n7iMI7Daxj2aNcUCeVEwiYqlurA7tTSE90eFeyyK84enxGmZ6Iq8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780869; c=relaxed/simple;
	bh=cpxKMx4Q3J2QdqdC+hLIMz96Ajbq6qVwb/HHg/CByZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q/39gjccyJqGNaOwyZeXFovB0pGPTeIhVSQ3wej+diM4SmmlH572IfoG17dv0XYgq9GwAk5QfUGBX9mkWC9H8H8Wdrugj75hvyFGrz9IGxhan5XB5RlYpCPB2mEAcYWyTbPWiS2e98KCo2HpcZ/RXme0uXSJJHSYYUyeciFnlq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JpPyEggz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JpPyEggz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758780868; x=1790316868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cpxKMx4Q3J2QdqdC+hLIMz96Ajbq6qVwb/HHg/CByZA=;
  b=JpPyEggzPcpohcj0Xp/NW6cp1SbIk8EverViDzhXKxOpT332v2b51s+U
   R2ys2QIzpnwZPmjbNI9Fq4KlvdfTbfCvDu212YX+6vYkecuOZfzY0h29O
   LE7CNgnOs1PDHbQl37Ht9jXmNzb2j0Hw5gC4jyblFDh5Ua10MbEx2UnKC
   1nAqOH39vCdMGpYEh7x06UF7Gh+DPsfzy4nRPV0bIJTuOW4N1wzFjnNZG
   YqQ9fVItt6ErW4ieRUPxJ902VqpmePxj5TyK4OgcS2Qze5x3Xr2wYJiFz
   AhE0WqRpTBEmo++sQ6zoPcScKw3526mrQ4B8xg+rTmn9/vTusbzWZiNmu
   A==;
X-CSE-ConnectionGUID: XWNiA+BqQtarq9TxIQzXFQ==
X-CSE-MsgGUID: XaRbgxGiTHiEQG2wJDvvaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61139508"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="61139508"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 23:14:27 -0700
X-CSE-ConnectionGUID: J55nO6LzSoycCFTFybM0xw==
X-CSE-MsgGUID: WzWjZ7EgScypkt0vUmp+wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="181528306"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa004.jf.intel.com with ESMTP; 24 Sep 2025 23:14:22 -0700
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
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v4 03/17] x86/fpu/xstate: Add xsaves_nmi
Date: Thu, 25 Sep 2025 14:11:59 +0800
Message-Id: <20250925061213.178796-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925061213.178796-1-dapeng1.mi@linux.intel.com>
References: <20250925061213.178796-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

There is a hardware feature (Intel PEBS XMMs group), which can handle
XSAVE "snapshots" from random code running. This just provides another
XSAVE data source at a random time.

Add an interface to retrieve the actual register contents when the NMI
hit. The interface is different from the other interfaces of FPU. The
other mechanisms that deal with xstate try to get something coherent.
But this interface is *in*coherent. There's no telling what was in the
registers when a NMI hits. It writes whatever was in the registers when
the NMI hit. It's the invoker's responsibility to make sure the contents
are properly filtered before exposing them to the end user.

The support of the supervisor state components is required. The
compacted storage format is preferred. So the XSAVES is used.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/include/asm/fpu/xstate.h |  1 +
 arch/x86/kernel/fpu/xstate.c      | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

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
index 12ed75c1b567..1ef62a137769 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1474,6 +1474,36 @@ void xrstors(struct xregs_state *xstate, u64 mask)
 	WARN_ON_ONCE(err);
 }
 
+/**
+ * xsaves_nmi - Save selected components to a kernel xstate buffer in NMI
+ * @xstate:	Pointer to the buffer
+ * @mask:	Feature mask to select the components to save
+ *
+ * The @xstate buffer must be 64 byte aligned.
+ *
+ * Caution: The interface is different from the other interfaces of FPU.
+ * The other mechanisms that deal with xstate try to get something coherent.
+ * But this interface is *in*coherent. There's no telling what was in the
+ * registers when a NMI hits. It writes whatever was in the registers when
+ * the NMI hit.
+ * The only user for the interface is perf_event. There is already a
+ * hardware feature (See Intel PEBS XMMs group), which can handle XSAVE
+ * "snapshots" from random code running. This just provides another XSAVE
+ * data source at a random time.
+ * This function can only be invoked in an NMI. It returns the *ACTUAL*
+ * register contents when the NMI hit.
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

