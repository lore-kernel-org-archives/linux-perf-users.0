Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A6E19D884;
	Tue,  9 Jul 2024 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535641; cv=none; b=FVeFGhXNpCuigAGkxIozgA9fneQyseutbjtFScSDjnB/fWkUo8AxAytsef/Cxfp1BEhuKo0fOwe2Aqpu0b4wgZ4eVmeOvcn5Vs0DAimlY2FPXSylpWisle0VbcrZbYEHhsuUb4GImf98wW/MigEs7X8ZLsO0BRkvamzrnOOUAtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535641; c=relaxed/simple;
	bh=fVwWPGOIyZnF65lF0GxG2vfceQ7LArmQ2GaF8OPDWsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cuaojkQ/loYqUsaINyY9VinPGa0sWDoY0PVZIj/ypHZ/1yZstcvLx3j9hdyubUY+OOGcuon2q91f/9J2m0+4gvyM2YwlXKN9dwFuS9Fn8T0zI2GiR1OYIaZG0ZL7+nzRbK4/8HeTqbR1seiZpAglNScfhDCguj6kjho3rgg1USc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vw3cHEOG; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vw3cHEOG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720535640; x=1752071640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fVwWPGOIyZnF65lF0GxG2vfceQ7LArmQ2GaF8OPDWsU=;
  b=Vw3cHEOGZhwvy6xZ81nElYTCseUsRYRF7lHX6xW502YN1jrIqqIPdqFb
   /FqoaUfslPMtAL4LXVRbDsSZzeVn/o0v2ihAiYtRRFJORCinkkQnQ4xVs
   Zb1xG5cfHaXgZ7Q3QAOJ4uTJRLNZvosfz4I0+XnxBS9IewdLJSKjhLhca
   5AXFBHYwXpmaSyq1WPDtMf1EhkvNeE7RaY9qoPr/5J9OFrqu3rBn/Yw3n
   DT1Ihdl5Q8dsweB9U0sVDAaYDRkVynZNDG/ojkbsghEnKbhIFtmiAKsxL
   EGk1IQaWb5vo3tvtM1ZAV24FH7znd5OaF1HDRSC1cBo0Ckbf6glymlX7i
   A==;
X-CSE-ConnectionGUID: BblrbjtNSGS4aCJukKj1xQ==
X-CSE-MsgGUID: YEyjB88TSRSug88STuA5qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="35331426"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="35331426"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 07:33:57 -0700
X-CSE-ConnectionGUID: eTkbNUk+SVWHCd8PCtA2BA==
X-CSE-MsgGUID: OuI6WRNUQ3WSV94NRskYxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="52272134"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa005.fm.intel.com with ESMTP; 09 Jul 2024 07:33:57 -0700
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
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Zeng Guang <guang.zeng@intel.com>
Subject: [PATCH v4 08/11] perf/x86: Enable NMI source reporting for perfmon
Date: Tue,  9 Jul 2024 07:39:03 -0700
Message-Id: <20240709143906.1040477-9-jacob.jun.pan@linux.intel.com>
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

Program the designated NMI source vector into the performance monitoring
interrupt (PMI) of the local vector table. PMI handler will be directly
invoked when its NMI is generated. This avoids the latency of calling all
NMI handlers blindly.

Co-developed-by: Zeng Guang <guang.zeng@intel.com>
Signed-off-by: Zeng Guang <guang.zeng@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

---
v4: Use a macro for programming PVTPC unconditionally (Kan)
v3: Program NMI source vector in PVTPC unconditionally (HPA)
v2: Fix a compile error apic_perfmon_ctr is undefined in i386 config
---
 arch/x86/events/core.c       | 4 ++--
 arch/x86/events/intel/core.c | 6 +++---
 arch/x86/include/asm/apic.h  | 2 ++
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 1ef2201e48ac..e69c52f9d662 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1680,7 +1680,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 	 * This generic handler doesn't seem to have any issues where the
 	 * unmasking occurs so it was left at the top.
 	 */
-	apic_write(APIC_LVTPC, APIC_DM_NMI);
+	apic_write(APIC_LVTPC, APIC_PERF_NMI);
 
 	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
 		if (!test_bit(idx, cpuc->active_mask))
@@ -1723,7 +1723,7 @@ void perf_events_lapic_init(void)
 	/*
 	 * Always use NMI for PMU
 	 */
-	apic_write(APIC_LVTPC, APIC_DM_NMI);
+	apic_write(APIC_LVTPC, APIC_PERF_NMI);
 }
 
 static int
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 38c1b1f1deaa..e7e114616e24 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3093,7 +3093,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	 * NMI handler.
 	 */
 	if (!late_ack && !mid_ack)
-		apic_write(APIC_LVTPC, APIC_DM_NMI);
+		apic_write(APIC_LVTPC, APIC_PERF_NMI);
 	intel_bts_disable_local();
 	cpuc->enabled = 0;
 	__intel_pmu_disable_all(true);
@@ -3130,7 +3130,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 
 done:
 	if (mid_ack)
-		apic_write(APIC_LVTPC, APIC_DM_NMI);
+		apic_write(APIC_LVTPC, APIC_PERF_NMI);
 	/* Only restore PMU state when it's active. See x86_pmu_disable(). */
 	cpuc->enabled = pmu_enabled;
 	if (pmu_enabled)
@@ -3143,7 +3143,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	 * Haswell CPUs.
 	 */
 	if (late_ack)
-		apic_write(APIC_LVTPC, APIC_DM_NMI);
+		apic_write(APIC_LVTPC, APIC_PERF_NMI);
 	return handled;
 }
 
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 9327eb00e96d..d284eff7849c 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -30,6 +30,8 @@
 #define APIC_EXTNMI_ALL		1
 #define APIC_EXTNMI_NONE	2
 
+#define APIC_PERF_NMI		(APIC_DM_NMI | NMI_SOURCE_VEC_PMI)
+
 /*
  * Define the default level of output to be very little
  * This can be turned up by using apic=verbose for more
-- 
2.25.1

