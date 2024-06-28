Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6644E80638;
	Fri, 28 Jun 2024 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719605618; cv=none; b=ORnLtgyT6ryffNkaeYsJ39AuveQpd5jHzxoaNDNvZLH/gLFKrxBeL5zGRv4RPf5gkemYVIx7osgohVLDFGeW5iuWP4e0DWybPeO2yz/BrY5I5nqtUKzhy1AiQrYaEA2+v6nsZ3MRwuzCeMWgzES/6eLLTtCF+i/pulJD97GVsD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719605618; c=relaxed/simple;
	bh=WEND0SnbQ03sZmnljkaqCtshaHDVSO6eWIe8ww7rBb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rd0M772+69T8kDW8JlVR5HZ3qp9l9j86hYCAgLHu8Vl8+KPeautVRO+gKcPr144k13FYc1NbPxrwgyvcuXeU/C1iR6euKTKxm+CqkILvWWwVEV3tegGaGLm9qk780tceYBTcHnkDZU82LPEnOnn/A2AEDNqqxap09JPCwdJRGeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DM22hg+Z; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DM22hg+Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719605617; x=1751141617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WEND0SnbQ03sZmnljkaqCtshaHDVSO6eWIe8ww7rBb4=;
  b=DM22hg+ZLkc/5wsg62FcJ8WSDLh4aYt8KNo2sKS2tF16ZJeJikfyxhuT
   4BOnaluDiJCwnI7ElqfuSarTycXM47bQNIxGU0jvpBrYMkXpBmDK5Uf27
   B8ve3PkSGuUFFPf/y537oZroqon66K5bMrBAKcxDNgx/PhZXLCMTFOW0s
   ZYGlIcpvqxhE9e2z7H9oXbH4/eauHt3pDkBw8slIAPhK6aNfeOGH7wK72
   9cE/PK6B0hO5XeMUdS930QeMcqC3kT3/JHgcDo4jPBrUbCPIFfIYJ9Pnm
   EGfNk+N8dL1ydMF1L/uRyZGbQ/7xPG3L9Ror1Lq5LUJEvNoZbVFm1VYL5
   A==;
X-CSE-ConnectionGUID: FgSFohjgTP2f4pNbXuqkAw==
X-CSE-MsgGUID: IytP9Ts7QCSz3LYWrOb75g==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="12307052"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="12307052"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 13:13:35 -0700
X-CSE-ConnectionGUID: c7dr9gDMTX2z11wPmeakXQ==
X-CSE-MsgGUID: qt1jX1cSSeCKD9iqlQseGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="49312608"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa005.fm.intel.com with ESMTP; 28 Jun 2024 13:13:35 -0700
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
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Zeng Guang <guang.zeng@intel.com>
Subject: [PATCH v3 11/11] KVM: X86: Use common code for PV IPIs in linux guest
Date: Fri, 28 Jun 2024 13:18:39 -0700
Message-Id: <20240628201839.673086-12-jacob.jun.pan@linux.intel.com>
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

Paravirtual apic hooks to enable PV IPIs for KVM if the "send IPI"
hypercall is available. Reuse common code for ICR preparation which
covers NMI-source reporting if in effect.

Originally-by: Zeng Guang <guang.zeng@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
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

