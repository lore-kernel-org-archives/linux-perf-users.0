Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913E519D072;
	Tue,  9 Jul 2024 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535640; cv=none; b=ZdkSCgmjC35AKAXy2TroOUqWD5yRe3L4Er0QUNXFcIXJ1v+Xd+HHaPBDraCAkkkDRdT7lJoW0PyeS6xGzcemG80adMj6RaU/0BNe2DOLY80Y54y5+jtvRaqfWyFzkXqrw8e8mvSY14WY7BtVOhNJ2Qfay/Jcg8sFo6ZnH/SuR9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535640; c=relaxed/simple;
	bh=aTowzf5ehH/lfdlLYW5qIknCqAoR8e51pYI18fJUPF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V+dw7LQUXV2VCdr1mlE48R2cLHmxQFnOByOWrZkxMwRYAwybDwR/EwugfhaONCnsgoArYhpENCrfcRX+ZcuNNnuPallHlL1GcAHbSobaD22GiVxMgWI9wH7V/1SOqata57sBO2dcGJQ6DlEkVdRJmsIRbEF9yh3fF+0E3IJUpi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZ/TPngI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZ/TPngI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720535638; x=1752071638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aTowzf5ehH/lfdlLYW5qIknCqAoR8e51pYI18fJUPF8=;
  b=QZ/TPngIR5qcx8PG1D2OuOF+IjHaHQnp+DJ/LfCw8x9Wo9Q9BpHTunjX
   DICpbmg61RTD6GqjldvzYucF8OS5wI7qUlOzjA4U0PLqG76HktwjNBQuH
   wAeO2ahIcVrNPMBWgoRS35c/9gtAXR1q6iVQgemygL7RHcKakLXXYkY+e
   oiPCKf89391LflXX6AAhseUEanX1/MmMXqNnHNwcc7Csjsx4St9ZNLh5S
   g3Dtkux/rABWNAM2WDWahjSIrhQuvCCMK3DC2BqGyVW3t4PF7/u4J/mw8
   B75JPQ3GDt+HLuArE8x7bV8VsINOaMHJ+Tby9K7KMlcCdysw+RLHIIvN7
   g==;
X-CSE-ConnectionGUID: eOsbuDsTRdqs4j9+RiD0TQ==
X-CSE-MsgGUID: S8Rr+6G+S5iH7zTKJ+DNdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="35331402"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="35331402"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 07:33:56 -0700
X-CSE-ConnectionGUID: ojW9oLL1QO2vKM2ws2hRbw==
X-CSE-MsgGUID: zLlgkRVZQ/yCxuLJnCw+DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="52272108"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa005.fm.intel.com with ESMTP; 09 Jul 2024 07:33:55 -0700
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
Subject: [PATCH v4 06/11] KVM: VMX: Expand FRED kvm entry with event data
Date: Tue,  9 Jul 2024 07:39:01 -0700
Message-Id: <20240709143906.1040477-7-jacob.jun.pan@linux.intel.com>
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

According to FRED specification 10.6.2, VM exits triggered by events such as
NMI, #DB, and #PF will have their event data stored in the exit-qualification
field.

However, #DB and #PF are owned by the running guest, which is managed by KVM.
NMIs belong to the host, and the host NMI handler requires the event data
stored in the VMCS for NMI-induced VM exits.

This patch enhances the FRED KVM entry interface to include the event data
derived from the exit qualification. Currently, it is used exclusively for
NMI-source reporting

Signed-off-by: Zeng Guang <guang.zeng@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/entry/entry_64_fred.S | 2 +-
 arch/x86/include/asm/fred.h    | 8 ++++----
 arch/x86/kvm/vmx/vmx.c         | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

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
diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
index e86c7ba32435..15f5d2eabd1d 100644
--- a/arch/x86/include/asm/fred.h
+++ b/arch/x86/include/asm/fred.h
@@ -63,14 +63,14 @@ static __always_inline unsigned long fred_event_data(struct pt_regs *regs)
 
 void asm_fred_entrypoint_user(void);
 void asm_fred_entrypoint_kernel(void);
-void asm_fred_entry_from_kvm(struct fred_ss);
+void asm_fred_entry_from_kvm(struct fred_ss, unsigned long edata);
 
 __visible void fred_entry_from_user(struct pt_regs *regs);
 __visible void fred_entry_from_kernel(struct pt_regs *regs);
 __visible void __fred_entry_from_kvm(struct pt_regs *regs);
 
 /* Can be called from noinstr code, thus __always_inline */
-static __always_inline void fred_entry_from_kvm(unsigned int type, unsigned int vector)
+static __always_inline void fred_entry_from_kvm(unsigned int type, unsigned int vector, unsigned long edata)
 {
 	struct fred_ss ss = {
 		.ss     =__KERNEL_DS,
@@ -80,7 +80,7 @@ static __always_inline void fred_entry_from_kvm(unsigned int type, unsigned int
 		.lm     = 1,
 	};
 
-	asm_fred_entry_from_kvm(ss);
+	asm_fred_entry_from_kvm(ss, edata);
 }
 
 void cpu_init_fred_exceptions(void);
@@ -90,7 +90,7 @@ void fred_complete_exception_setup(void);
 static __always_inline unsigned long fred_event_data(struct pt_regs *regs) { return 0; }
 static inline void cpu_init_fred_exceptions(void) { }
 static inline void fred_complete_exception_setup(void) { }
-static __always_inline void fred_entry_from_kvm(unsigned int type, unsigned int vector) { }
+static __always_inline void fred_entry_from_kvm(unsigned int type, unsigned int vector, unsigned long edata) { }
 #endif /* CONFIG_X86_FRED */
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b3c83c06f826..4e7b36081b76 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7024,7 +7024,7 @@ static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu,
 
 	kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ);
 	if (cpu_feature_enabled(X86_FEATURE_FRED))
-		fred_entry_from_kvm(EVENT_TYPE_EXTINT, vector);
+		fred_entry_from_kvm(EVENT_TYPE_EXTINT, vector, 0);
 	else
 		vmx_do_interrupt_irqoff(gate_offset((gate_desc *)host_idt_base + vector));
 	kvm_after_interrupt(vcpu);
@@ -7332,7 +7332,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	    is_nmi(vmx_get_intr_info(vcpu))) {
 		kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
 		if (cpu_feature_enabled(X86_FEATURE_FRED))
-			fred_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR);
+			fred_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR, 0);
 		else
 			vmx_do_nmi_irqoff();
 		kvm_after_interrupt(vcpu);
-- 
2.25.1

