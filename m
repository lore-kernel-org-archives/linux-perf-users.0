Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D780518C2C;
	Mon,  6 Jul 2026 02:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303304; cv=none; b=XERwPGPwLkkb9IFgx0JuoMD/YMaYXVWwFrRMWJb13ZeiKzE3dVJYn3kBxRoeoRjjEeKj5gBxMCS+b6+TDdnWJ9zCavr8ntjZG5zPljTEBMco2U6LnVvCXoIVDCgHYmHm2lCdK8toR/H7lIVSHTYQFsDUfH9sNhEjNgmn9minhf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303304; c=relaxed/simple;
	bh=VfW7PvtvPvI+U4KGhAdfHFi9quVPDdJyE9fvh0ueUnE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YU536pjETg6yfnn7rxvvJPLo3Xbb4q4mUmBLyaguO7LGOkk5lUw114KrcQVWAvmf/Mxb5LhaB39a2wMBqpD9wIZlHLU7bA5dzEsL22mouFtEI3DzyfTvdw9DNjIdUFY8ic9dJGtaAw3OXnH6SOUF9jLJsk6u3fP8yGVm4O7tj3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hvuyXYP+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvuyXYP+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783303303; x=1814839303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VfW7PvtvPvI+U4KGhAdfHFi9quVPDdJyE9fvh0ueUnE=;
  b=hvuyXYP+euLwm6hrfH/QKoDX9YJVUzoy5pP/1lRu2lTzeQ3S5FGBKkUu
   4cvcnNRj7eHZrov4wDFOxZTvnVeqB5dP+PWpbDW4DOy7UrF0QvyzdR+a/
   O2Gs/zYzynxHHcXpW3B89Ah2B9pEoAPAOyTL7MbEpLv3QYbDEybzFX2to
   YQvlJrcSOOokYarlF7HJw3uVEwL98gFI42BsZa05eKRESo8dlt6+rNDl4
   M3VZdvzE55w5zR0OprvLvPKFzQ06PzQOB5cZ9d86cw5QU1PoZ9POFCII4
   il7H/3w8lwTyMUkX6587bh7K/BU69cyLHx4T2RE/H0D5vzhrD3Ep2k8jw
   g==;
X-CSE-ConnectionGUID: 1Pi7aBypQNawPmnXvTfb1w==
X-CSE-MsgGUID: Wv2wC350QrCGA35R/5Co1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83911614"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83911614"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 19:01:43 -0700
X-CSE-ConnectionGUID: kmRk0HsTRHi1jrgtxfqElQ==
X-CSE-MsgGUID: NuL8WEDWQ0CTj5TQl2Qqbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="247191290"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 05 Jul 2026 19:01:38 -0700
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
Subject: [Patch v9 07/24] x86/fpu/xstate: Add xsaves_nmi() helper
Date: Mon,  6 Jul 2026 09:54:22 +0800
Message-Id: <20260706015439.3040804-8-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
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
the NMI handler. This function returns the actual register contents at
the moment the NMI occurs.

Currently the perf subsystem is the sole user of this helper. It uses
this function to snapshot SIMD (XMM/YMM/ZMM) and APX eGPRs registers
which would be added in subsequent patches.

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
index a7b6524a9dea..d39c01546dee 100644
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
+ * the NMI handler. This function returns the actual register contents at
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

