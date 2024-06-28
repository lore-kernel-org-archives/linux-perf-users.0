Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04947A715;
	Fri, 28 Jun 2024 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719605616; cv=none; b=lNva8O8BUy4vOj+ZdqgxJV/koMHE+FMhjlCq/iAYxQZF/zpLTJppaV8yqE/ToHIKUZbfjiBjUr5BotSEW6mOyNhzsFfySJGIAnFImKBgOgr9sXZORbadldMEo35jNiO4r0D+7/2qUyHvemEAYRn7/1yTDeA7pKIf7hCUozWR8Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719605616; c=relaxed/simple;
	bh=e365/ZxkgEc9NqLkEwPGQtSfS583CvbekuFVDfTCoz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FHBrL+1Pu8dSN5JCJTvA/TREq9pGL+2XcLXKyhA2UICXMbt4uw15ZrOIM8qoy0iJCKLcBL+DaSbEc3Ejr9uPOmo2/+iTcWGbZh49XEITObFzh+5+KAV39IST4Oo1S64NilGT5ZlcdvVO8zxcaGcZHs7YaStSIgaMoGu1MWHrzjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n/JYYr6D; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n/JYYr6D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719605615; x=1751141615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e365/ZxkgEc9NqLkEwPGQtSfS583CvbekuFVDfTCoz4=;
  b=n/JYYr6DmnEE+eCtV9GgdDvzZbCnIlD18X14ffLsSHKuJFMuQGMjg4Q5
   QJbnIKjGlDcCorOQ40q2VafyU2ytLalg8nYg0Yr8jUT3rSuUh7DlaDZe4
   TkQmHTfKlCNPfnL4PqIbyluXER89b+CUZvLZl4CuiLAcit8EnageGpynp
   VhLpt8xr99LsrP8t8NQaHny0U5xQqDHeR/ZpqZW3H5E4hiHjBAe8AztKz
   didr1feFDn4uD5ejASVg27Y8AQlFwDT9gHPzvwzjtQmP8hlSheVq267+/
   w5focpiQ/kYrQdyniq5r30+czPy4h/X6ZeAi2tZLzmc38NYt5a1f8smeH
   A==;
X-CSE-ConnectionGUID: xuew7Y29SGWr7RhIkK4UAQ==
X-CSE-MsgGUID: Us8pPQfZSs2t/A3fSbeZYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="12307012"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="12307012"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 13:13:32 -0700
X-CSE-ConnectionGUID: u4+LddL8TdylEeYykAA3Lw==
X-CSE-MsgGUID: ZuerWa87TTCJFwC9HU/QTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="49312586"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa005.fm.intel.com with ESMTP; 28 Jun 2024 13:13:32 -0700
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
Subject: [PATCH v3 06/11] KVM: VMX: Expand FRED kvm entry with event data
Date: Fri, 28 Jun 2024 13:18:34 -0700
Message-Id: <20240628201839.673086-7-jacob.jun.pan@linux.intel.com>
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

For VM exits caused by events (NMI, #DB, and #PF) delivered by FRED, the
event data is saved in the exit-qualification field. (FRED spec. 10.6.2)

Expand FRED KVM entry interface to include the event data obtained from
the exit qualification.

Signed-off-by: Zeng Guang <guang.zeng@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/include/asm/fred.h | 8 ++++----
 arch/x86/kvm/vmx/vmx.c      | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

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

