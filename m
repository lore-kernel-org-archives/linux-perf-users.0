Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B046919DF63;
	Tue,  9 Jul 2024 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535643; cv=none; b=BNcaT/f4v3+FWtX0W0gCKSpchajHXX8t988FChBT2ZuQPj1YKfdrGK/GsAwG+rVClOe3HShfnIVHQMEQLCC1w65pSveDJgOQ5MF4nesOzX9CAynXMYfFTSAxpzaAMckitNCdAxmW4ssHqISOE/98lpHGJ06KCQcKR4djh8PW/CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535643; c=relaxed/simple;
	bh=Tp959kLWh7E8+Ab1i/2oDdDjkEuJ0nDV0QTzBULHnwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sl2zPm1GrtiE/y6rYfwDaFdG6qPkN40Gz5pcg8SRsHViLRuNd39ODrAYu449m+QULu113blUl8tRnEUvM2x9aKEaLYG08C/fAvk559LStSzAPS5V0D/XGRncgtE+zkhD6Vyow65xLzjUvFaPJ6o88+TY2F7mZ+Tdhn4MprBk3Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OlMBkMT9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OlMBkMT9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720535641; x=1752071641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tp959kLWh7E8+Ab1i/2oDdDjkEuJ0nDV0QTzBULHnwo=;
  b=OlMBkMT9oVT04CwwqMsRwolzsA3MUJSvcBeqm5hJjj7VTFG/A4Kp2yoE
   lb6Dlam3IiBwoYNbtDOuylvGjHDmOf+dDNzvIw+FhaZnuKdFEMgcvDfLU
   xaOf8yXdRGO2LxWI10Hj6vtofORoK7uPV0Kf8Q5xMgoQhtnLDAgm6rcH2
   o/ejDQ7BwdRZttp5BgWi5A7tzYqSHeQzv2JZdWGa9d9wCFjFGRxWdEOPa
   AcXowZ75Wudy2Y7x6FWXt3EFYHjS95NcAZqdTBHiehKUA6XAROSZ6or5C
   K534YHkQqklJO+PMYQQF5uxZLPZqCVtXec287zGiEZj2d31hHHO0L8ZGD
   w==;
X-CSE-ConnectionGUID: i3/WR36mRlmQFrYtGydv9Q==
X-CSE-MsgGUID: oEpdJVPTSJeUb/zQWJFE1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="35331459"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="35331459"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 07:33:59 -0700
X-CSE-ConnectionGUID: P7PL283ZR9CV8AX/OCk/JQ==
X-CSE-MsgGUID: lnhgi5THQXmMN29WzGQJGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="52272160"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa005.fm.intel.com with ESMTP; 09 Jul 2024 07:33:59 -0700
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
Subject: [PATCH v4 11/11] KVM: X86: Use common code for PV IPIs in linux guest
Date: Tue,  9 Jul 2024 07:39:06 -0700
Message-Id: <20240709143906.1040477-12-jacob.jun.pan@linux.intel.com>
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

The paravirtual APIC hooks in KVM, some of which are used for sending PV
IPIs, can reuse common code for ICR preparation. This shared code also
encompasses NMI-source reporting when in effect.

Originally-by: Zeng Guang <guang.zeng@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
v4: Refine comments, no functional change.
---
 arch/x86/kernel/kvm.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 263f8aed4e2c..a45d60aa0302 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -516,15 +516,7 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
 
 	local_irq_save(flags);
 
-	switch (vector) {
-	default:
-		icr = APIC_DM_FIXED | vector;
-		break;
-	case NMI_VECTOR:
-		icr = APIC_DM_NMI;
-		break;
-	}
-
+	icr = __prepare_ICR(0, vector, 0);
 	for_each_cpu(cpu, mask) {
 		apic_id = per_cpu(x86_cpu_to_apicid, cpu);
 		if (!ipi_bitmap) {
-- 
2.25.1

