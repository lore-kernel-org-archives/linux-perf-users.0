Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1120519D084;
	Tue,  9 Jul 2024 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535640; cv=none; b=uLSkt9Cs5oAQt60SjyTDa87XRCTotEbKU+MTvYvkGmitOGe52TPWFky3UDN0z7RH2k8HxY5dzv0U/g4kXX+oEp8dQiP08VhlhT+xzmpILGGm6wDPz7RUbP446fGpb1vo8nBsAFuJ3hZli0Db1wfRsBx+OHdJ7w0WIKNCD+jqJCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535640; c=relaxed/simple;
	bh=vA7B3YKz0iafDXCOMUYAdqoOvW1WFIzYPt/YBAHyEEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rINpVI9Q+IniXC2daJ3di2ZQh0JBVjfwZ6RhJDj9jrhxuQO8wpdgdvI0RIiljAlfdks+2rTNUmR+1+eJc9GP0QidLVnXSd06rDunyeaQe5xfVrEK4gIs/iPNkralhPCwOz/K9aSXov1j2tk98O7V0Az6ERk6OMoWIUw3bcEz6Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMBkgf66; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMBkgf66"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720535639; x=1752071639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vA7B3YKz0iafDXCOMUYAdqoOvW1WFIzYPt/YBAHyEEQ=;
  b=SMBkgf665kKqNbiSiZcrnjOG/bLuOm27tHQP5Mo2O1Pz1EyvZqWVKMER
   bmT0ZEoBtuJsaF7ulKQjxKfCINKhU5j427GnZdV9o1tMpprzuv0g6mtk0
   I5EvX2zblI1v7sym4TRsk3DUpYVGd8PLarDyZsT1HL4h1hqPnL3GEiQbx
   np+hX57qU7+tsTA/xK/oCIMFZnradl0ZhkPMtufFV38tVelhsMtg61Wgz
   qoA6xFV7ddTpG2JmNv1MQPBM06xnocQXknABuDs6kxGSyAxwR4UrVL6+N
   OHDh8FOiyKRI/9KG/y20arSQ1xvR1Kn4vtoyOSQB7KsCN0Bei4I5sTf4P
   Q==;
X-CSE-ConnectionGUID: ICZSvdCqR7imlKcehRXR+Q==
X-CSE-MsgGUID: VrCiNcF6SxmtqI1+dAH7SA==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="35331415"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="35331415"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 07:33:56 -0700
X-CSE-ConnectionGUID: 7VDwHScPRu+MrpWzXWFb8A==
X-CSE-MsgGUID: ojYjyeCpTwiWQ6jpgXg6kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="52272118"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa005.fm.intel.com with ESMTP; 09 Jul 2024 07:33:56 -0700
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
	Zeng Guang <guang.zeng@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 07/11] KVM: VMX: Handle NMI Source report in VM exit
Date: Tue,  9 Jul 2024 07:39:02 -0700
Message-Id: <20240709143906.1040477-8-jacob.jun.pan@linux.intel.com>
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

From: Zeng Guang <guang.zeng@intel.com>

If the "NMI exiting" VM-execution control is 1, the value of the 16-bit NMI
source vector is saved in the exit-qualification field in the VMCS when VM
exits occur on CPUs that support NMI source.

KVM that is aware of NMI-source reporting will push the bitmask of NMI source
vectors as the exceptoin event data field on the stack for then entry of FRED
exception. Subsequently, the host NMI exception handler is invoked which
will process NMI source information in the event data. This operation is
independent of vCPU FRED enabling status.

Signed-off-by: Zeng Guang <guang.zeng@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4e7b36081b76..6719c598fa5f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7331,10 +7331,15 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	if ((u16)vmx->exit_reason.basic == EXIT_REASON_EXCEPTION_NMI &&
 	    is_nmi(vmx_get_intr_info(vcpu))) {
 		kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
-		if (cpu_feature_enabled(X86_FEATURE_FRED))
-			fred_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR, 0);
-		else
+		if (cpu_feature_enabled(X86_FEATURE_FRED)) {
+			unsigned long edata = 0;
+
+			if (cpu_feature_enabled(X86_FEATURE_NMI_SOURCE))
+				edata = vmx_get_exit_qual(vcpu);
+			fred_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR, edata);
+		} else {
 			vmx_do_nmi_irqoff();
+		}
 		kvm_after_interrupt(vcpu);
 	}
 
-- 
2.25.1

