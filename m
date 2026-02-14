Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9134A18CC13
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Feb 2026 01:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771032428; cv=none; b=T6eKZy5SzObbzhLm1o6Pu40+0++uRQR+uWMUJAPpPGU5oxNRDDyG+jspJS5/P6X8/uy7ClFyWvblWL4DMiE82OQIGvWVkKCbpPZb5poZvDRRY+NClbbsemWIC0KoPg6KHmKFddb1i5r7BdA1DzTgPtTMxlDpEu20GeRUDMpS2iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771032428; c=relaxed/simple;
	bh=2t5N3FXJK+jxONHHD2OiC/FqtJtqZpNApYEKRxh3Fw4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=U/rsgDrZn1UWUEoeS6KsWrB482xIMZOW76UHxhW0C2HZNtlO6cedKWFRTw0zjJ612n+8NQToLGxqoAEAHAzvRXHJzmMg4DvuGWrakQGDz0IUDWYAZxPyx2Bve/YyL0BJ9Ma0PVQ/7cl2hlRSn+MlhgBXMbiNc0qMvs4JGwwBZK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tHNvI8xR; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tHNvI8xR"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c503d6be76fso4215143a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Feb 2026 17:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771032426; x=1771637226; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKhpZhRObYUhkhowIAV7Tkup63qCI6eIK5L/iRnu7eE=;
        b=tHNvI8xRnwleHV3i6s5dDYPmoS4UsWsJQQRg9RV9dsJLDOi62fYPANYg9h8zD48YMr
         y4zgOtUU7sTsAuUolTlA+bylJqetxp1g9fKVLB26AFBITvlYU6N7dfB0k0SkY85FSAeB
         lpU1QvveUi1ky8c0bEc0f3YgbJDekIYzhtOqQNMkp+sDgGRx/cPN4QmsJhCD2AWXL8it
         y0U9akzIvL5gqVo6LvMal04dL/14d9W73KocAg4icHkwW+/vINdKDSE7l9Md46U/qJhr
         JfhIlwxLZVIPkEXQdMl+em6rcqE85ryW8YRPDwZBnz9asrEwkoP/nHSmTgMy4AKE92FR
         kzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771032426; x=1771637226;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lKhpZhRObYUhkhowIAV7Tkup63qCI6eIK5L/iRnu7eE=;
        b=ZRqKq0FQK3hk4CgzzTpL60t5q5vMJcfQFnfrKtxKkXWw9GHFYvqS41pJjOmnQJV4js
         oCwtHSHAirRkxbfFD+s93Ka93IC3Jn+pNv9d5eKAn47PatfdlXTODcNO2SHOCs3XqBtW
         HNj89VIXTqAzeV21gyeO5ey6KkctV948Jhyi/W5AO29Ffv6L9OuNmuisltGSFioWx3hs
         Otgu1VzD7V75u/bI2Pef0sp8ThE+a5gw+0KU/Hxcn/5JzfKpQNxA++V1Ip13t5aMHAl+
         bw3zmnOTRscJ0oX9EynrPOWrZ6azr5x9sNYE75y6g63T8hAA7JSHJSsgKhCYAGF0F1/u
         hEVg==
X-Forwarded-Encrypted: i=1; AJvYcCUMvX1ISbSEXMMlip4ZrmM8TIZk0MTNAlz9s2MAHWOlchIoHo3ZbEbKKjSIFmAPafOpuH/EWV7BtEVIN8B1YH9T@vger.kernel.org
X-Gm-Message-State: AOJu0YzbCtQmdImuomustgyGKCKsVG57L4WOh+Q67Bz+ro028gEuo7Ay
	/tXDsbx3xJlREUNTK/EBn32+QPBoTfiSBmv2tUo53DbwbKmA3YSBNeat8GrCQ6y/nkkPvgVwit4
	Dgk1U0w==
X-Received: from pfbls2.prod.google.com ([2002:a05:6a00:7402:b0:7ee:f5f6:a02f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:138c:b0:81f:829d:6f77
 with SMTP id d2e1a72fcca58-824d965c356mr992803b3a.67.1771032425651; Fri, 13
 Feb 2026 17:27:05 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Feb 2026 17:26:46 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260214012702.2368778-1-seanjc@google.com>
Subject: [PATCH v3 00/16] KVM: x86/tdx: Have TDX handle VMXON during bringup
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"

Assuming I didn't break anything between v2 and v3, I think this is ready to
rip.  Given the scope of the KVM changes, and that they extend outside of x86,
my preference is to take this through the KVM tree.  But a stable topic branch
in tip would work too, though I think we'd want it sooner than later so that
it can be used as a base. 

Chao, I deliberately omitted your Tested-by, as I shuffled things around enough
while splitting up the main patch that I'm not 100% positive I didn't regress
anything relative to v2.


The idea here is to extract _only_ VMXON+VMXOFF and EFER.SVME toggling.  AFAIK
there's no second user of SVM, i.e. no equivalent to TDX, but I wanted to keep
things as symmetrical as possible.

TDX isn't a hypervisor, and isn't trying to be a hypervisor. Specifically, TDX
should _never_ have it's own VMCSes (that are visible to the host; the
TDX-Module has it's own VMCSes to do SEAMCALL/SEAMRET), and so there is simply
no reason to move that functionality out of KVM.

With that out of the way, dealing with VMXON/VMXOFF and EFER.SVME is a fairly
simple refcounting game.

v3:
 - https://lore.kernel.org/all/20251206011054.494190-1-seanjc@google.com
 - Split up the move from KVM => virt into smaller patches. [Dan]
 - Collect reviews. [Dan, Chao, Dave]
 - Update sample dmesg output and hotplug angle in docs. [Chao]
 - Add comments in kvm_arch_shutdown() to try and explain the madness. [Dave]
 - Add a largely superfluous smp_wmb() in kvm_arch_shutdown() to provide a
   convienent location for documenting the flow. [Dave]
 - Disable preemption in x86_virt_{get,put}_ref() so that changes in how
   KVM and/or TDX use the APIs doesn't result in bugs. [Xu]
 - Add a patch to drop the bogus "IRQs must be disabled" rule in
   tdx_cpu_enable().
 - Tag more TDX helpers as __init. [Chao]
 - Don't treat loading kvm-intel.ko with tdx=1 as fatal if the system doesn't
   have a TDX-Module available. [Chao]

v2:
 - Initialize the TDX-Module via subsys initcall instead of during
   tdx_init(). [Rick]
 - Isolate the __init and __ro_after_init changes. [Rick]
 - Use ida_is_empty() instead of manually tracking HKID usage. [Dan]
 - Don't do weird things with the refcounts when virt_rebooting is
   true. [Chao]
 - Drop unnecessary setting of virt_rebooting in KVM code. [Chao]
 - Rework things to have less X86_FEATURE_FOO code. [Rick]
 - Consolidate the CPU hotplug callbacks. [Chao]

v1 (RFC):
 - https://lore.kernel.org/all/20251010220403.987927-1-seanjc@google.com

Chao Gao (1):
  x86/virt/tdx: KVM: Consolidate TDX CPU hotplug handling

Sean Christopherson (15):
  KVM: x86: Move kvm_rebooting to x86
  KVM: VMX: Move architectural "vmcs" and "vmcs_hdr" structures to
    public vmx.h
  KVM: x86: Move "kvm_rebooting" to kernel as "virt_rebooting"
  KVM: VMX: Unconditionally allocate root VMCSes during boot CPU bringup
  x86/virt: Force-clear X86_FEATURE_VMX if configuring root VMCS fails
  KVM: VMX: Move core VMXON enablement to kernel
  KVM: SVM: Move core EFER.SVME enablement to kernel
  KVM: x86: Move bulk of emergency virtualizaton logic to virt subsystem
  x86/virt: Add refcounting of VMX/SVM usage to support multiple
    in-kernel users
  x86/virt/tdx: Drop the outdated requirement that TDX be enabled in IRQ
    context
  KVM: x86/tdx: Do VMXON and TDX-Module initialization during subsys
    init
  x86/virt/tdx: Tag a pile of functions as __init, and globals as
    __ro_after_init
  x86/virt/tdx: Use ida_is_empty() to detect if any TDs may be running
  KVM: Bury kvm_{en,dis}able_virtualization() in kvm_main.c once more
  KVM: TDX: Fold tdx_bringup() into tdx_hardware_setup()

 Documentation/arch/x86/tdx.rst              |  36 +-
 arch/x86/events/intel/pt.c                  |   1 -
 arch/x86/include/asm/kvm_host.h             |   3 +-
 arch/x86/include/asm/reboot.h               |  11 -
 arch/x86/include/asm/tdx.h                  |   4 -
 arch/x86/include/asm/virt.h                 |  26 ++
 arch/x86/include/asm/vmx.h                  |  11 +
 arch/x86/kernel/cpu/common.c                |   2 +
 arch/x86/kernel/crash.c                     |   3 +-
 arch/x86/kernel/reboot.c                    |  63 +---
 arch/x86/kernel/smp.c                       |   5 +-
 arch/x86/kvm/svm/svm.c                      |  34 +-
 arch/x86/kvm/svm/vmenter.S                  |  10 +-
 arch/x86/kvm/vmx/main.c                     |  19 +-
 arch/x86/kvm/vmx/tdx.c                      | 210 ++----------
 arch/x86/kvm/vmx/tdx.h                      |   8 +-
 arch/x86/kvm/vmx/vmcs.h                     |  11 -
 arch/x86/kvm/vmx/vmenter.S                  |   2 +-
 arch/x86/kvm/vmx/vmx.c                      | 138 +-------
 arch/x86/kvm/x86.c                          |  29 +-
 arch/x86/virt/Makefile                      |   2 +
 arch/x86/virt/hw.c                          | 359 ++++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.c                 | 321 +++++++++--------
 arch/x86/virt/vmx/tdx/tdx.h                 |   8 -
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c |  10 +-
 include/linux/kvm_host.h                    |  16 +-
 virt/kvm/kvm_main.c                         |  31 +-
 27 files changed, 717 insertions(+), 656 deletions(-)
 create mode 100644 arch/x86/include/asm/virt.h
 create mode 100644 arch/x86/virt/hw.c


base-commit: 183bb0ce8c77b0fd1fb25874112bc8751a461e49
-- 
2.53.0.310.g728cabbaf7-goog

