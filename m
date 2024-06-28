Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1E07BB0A;
	Fri, 28 Jun 2024 20:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719605616; cv=none; b=lnKpQX/+RlSXH7wzdwj1TAFMOMARrBXWnkGKuUyb+isqjSDCVcnKSwxSAOe1H3ugl1IEDK8Uqv50Iwf6ri9UQQx/RGFC+PEIgblLwihsDaKhCKvOIgU7UuWCStlzG3U9kacMJhLyNMrvrfszjO1FtWNJ4ZFWcAR8agt091h7NPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719605616; c=relaxed/simple;
	bh=yuoxYpHOPCsMY1n5YoaO/qlF5+k9GR3XpQihZGm7yfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t2lZLpdgV6wteru5lir7ELmDTwXfOCBfYqKYg2S6ukviXVX5l+BuzRX9H/Sb3dO4JJGarvuK8mWOMZ1ZO9xQFvf0jWL5vKnuH+YCLRwYB6LpACeuLphVMCtTpVuXtjEaewJN66GFQxCriFGVlEinUV0NPDep6gShEtz2zXtRUmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+DAM20o; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+DAM20o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719605615; x=1751141615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yuoxYpHOPCsMY1n5YoaO/qlF5+k9GR3XpQihZGm7yfE=;
  b=H+DAM20oAnH+gNddnOby/8GzwIwinQxES8AvR6P+FbRuHm+o9cqr13mv
   S6xZxDRvgomdhkcu43ZfwOePAQfkNihzPZBFvijAR2pUrMhnMpSIB7qhK
   zRkgOTOr7eqedju1i5XEiTJZ3DucEnpTMGARo8Lqvk32Q5yU9Ab+oQRyf
   jneUI+gEbLoQSoOff0KqgxGHo/nNsOS7tJeKx0GwMYTLGpD+B6TBVobXS
   m0rwurJ5yZGzOMsyjGywDKnFYy3eJXtvIpmIS4t7uLqESO1x/VrhcoQHp
   cWu7+hqy7J4G2REJAhwwKniz/IY+i8bTB5i28ch+TpLEzKSPpVdCC1SS/
   w==;
X-CSE-ConnectionGUID: zyUFs5eDQIegOrnkJdo3IA==
X-CSE-MsgGUID: 4HcS3odoQcmiwhz2P3KKFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="12307020"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="12307020"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 13:13:33 -0700
X-CSE-ConnectionGUID: mYQouYAZTdOcQJ6tL0/j0Q==
X-CSE-MsgGUID: Y8uVGEemTh+ExHNpAyl7VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="49312592"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa005.fm.intel.com with ESMTP; 28 Jun 2024 13:13:33 -0700
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
	Zeng Guang <guang.zeng@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 07/11] KVM: VMX: Handle NMI Source report in VM exit
Date: Fri, 28 Jun 2024 13:18:35 -0700
Message-Id: <20240628201839.673086-8-jacob.jun.pan@linux.intel.com>
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
 arch/x86/entry/entry_64_fred.S |  2 +-
 arch/x86/kvm/vmx/vmx.c         | 11 ++++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
index a02bc6f3d2e6..0d934a3fcaf8 100644
--- a/arch/x86/entry/entry_64_fred.S
+++ b/arch/x86/entry/entry_64_fred.S
@@ -92,7 +92,7 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
 	 * +--------+-----------------+
 	 */
 	push $0				/* Reserved, must be 0 */
-	push $0				/* Event data, 0 for IRQ/NMI */
+	push %rsi			/* Event data for IRQ/NMI */
 	push %rdi			/* fred_ss handed in by the caller */
 	push %rbp
 	pushf
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

