Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37041132112;
	Tue,  9 Jul 2024 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535635; cv=none; b=aZHDKLlEMM1KOo6do5OBK2sfaaY+rpW4+w0UfLKsKypb1IKD1F+wi6D85Ju3AaDyy6gq9gsxcWagK9e6bqeQAQJlMGmG7YLquOU7s9bxJyW9z/1euBHcNDDLJXNEiAf03rnKdEONjwugVi32Q9jrgZtrO0xEFhglJTEctiRU8zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535635; c=relaxed/simple;
	bh=YMAW9z1NAbGBMEAVcZUKWXcSRN9YTD2CjyP/WP2bFGA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DaZ8+52iz1evLHSZ9o1dIhH03gsXOKibq4KoT64L7zDECTG5piSlvwyF9avLEZnBBVkgQYBL5BxEC02E/jfJ3FP/XLaUKATX/McYB7ykC/7rVm9akcthtZBGNIBdvCaR0MGUbgs8Z+0iyHbdhewyTRhw7uGEqaD8hL/sg0T/49A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RKKdF5JM; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RKKdF5JM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720535633; x=1752071633;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YMAW9z1NAbGBMEAVcZUKWXcSRN9YTD2CjyP/WP2bFGA=;
  b=RKKdF5JMJv7+fTAPoaDwdBsG8D4HUSrHzjZPVP3Ftr2kXEAA3BREuSzf
   tiVQ2dPsrviVNsjPL223bbq1KyCQ5dsNaUaXTVBiQ0zLwfenACzZRBOiS
   /751MPCEqn0zboHMhBV+J0kFbzv3t2/W9vTi5xus9dYY2GRECNTVntubf
   DTaVpUAymGyRtFPNfud01HGi1hg9fU1Q+1z9SDs6lv2+i/4GETCP0tkiZ
   Z/wqhJ+eJpZCsMXOwwPecx2x/L60Bw5C5Whfz2PDRrcVPnCGYxDgh2KJe
   TfIsI3634sdGsVTY5LZ9fR+Y3+zrJc6YdydTfMb40uFrXeoqHujHmT8ty
   g==;
X-CSE-ConnectionGUID: liv5bskGQXqb7Bfi3++Bog==
X-CSE-MsgGUID: WxAZ4+ZwSdepMP/E6xrwKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="35331325"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="35331325"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 07:33:52 -0700
X-CSE-ConnectionGUID: l06Vidm8Qp+kQb4OZdFJZw==
X-CSE-MsgGUID: ZPrNFHJPRFKcRJEMUrJNXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="52272043"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa005.fm.intel.com with ESMTP; 09 Jul 2024 07:33:51 -0700
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
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 00/11] Add support for NMI-source reporting
Date: Tue,  9 Jul 2024 07:38:55 -0700
Message-Id: <20240709143906.1040477-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Thomas and all,

Non-Maskable Interrupts (NMIs) are routed to the local Advanced Programmable
Interrupt Controller (APIC) using vector #2. Before the advent of the
Flexible Return and Event Delivery (FRED)[1], the vector information set by
the NMI initiator was disregarded or lost within the hardware, compelling
system software to poll every registered NMI handler to pinpoint the source
of the NMI[2]. This approach led to several issues:

1.	Inefficiency due to the CPU's time spent polling all handlers.
2.	Increased latency from the additional time taken to poll all handlers.
3.	The occurrence of unnecessary NMIs if they are triggered shortly
	after being processed by a different source.

To tackle these challenges, Intel introduced NMI source reporting as a part
of the FRED specification (detailed in Chapter 9). This CPU feature ensures
that while all NMI sources are still aggregated into NMI vector (#2) for
delivery, the source of the NMI is now conveyed through FRED event data
(a 16-bit bitmap on the stack). This allows for the selective dispatch
of the NMI source handler based on the bitmap, eliminating the need to
invoke all NMI source handlers indiscriminately.

In line with the hardware architecture, various interrupt sources can
generate NMIs by encoding an NMI delivery mode. However, this patchset
activates only the local NMI sources that are currently utilized by the
Linux kernel, which includes:

1.	Performance monitoring.
2.	Inter-Processor Interrupts (IPIs) for functions like CPU backtrace,
	machine check, Kernel GNU Debugger (KGDB), reboot, panic stop, and
	self-test.

Other NMI sources will continue to be handled as previously when the NMI
source is not utilized or remains unidentified.

Next steps:
1. KVM support
2. Optimization to reuse IDT NMI vector 2 as NMI source for "known" source.
Link:https://lore.kernel.org/lkml/746fecd5-4c79-42f9-919e-912ec415e73f@zytor.com/


[1] https://www.intel.com/content/www/us/en/content-details/779982/flexible-return-and-event-delivery-fred-specification.html
[2] https://lore.kernel.org/lkml/171011362209.2468526.15187874627966416701.tglx@xen13/


Thanks,

Jacob

---
V4:
	- Mostly coding style, comments, and naming changes (Li Xin, Nikolay, Kan)
V3:
	- Added KVM VMX patches to handle NMI exits (Sean)
	- Clean up in KVM for code reuse in PV IPI (patch 10 and 11)
	- Misc fixes based on reviews from HPA, Li Xin, and Sohil
	
Change logs are in individual patches.

Thanks,

Jacob

Jacob Pan (9):
  x86/irq: Add enumeration of NMI source reporting CPU feature
  x86/irq: Define NMI source vectors
  x86/irq: Extend NMI handler registration interface to include source
  x86/irq: Factor out common NMI handling code
  x86/irq: Process nmi sources in NMI handler
  perf/x86: Enable NMI source reporting for perfmon
  x86/irq: Enable NMI source on IPIs delivered as NMI
  x86/irq: Move __prepare_ICR to x86 common header
  KVM: X86: Use common code for PV IPIs in linux guest

Zeng Guang (2):
  KVM: VMX: Expand FRED kvm entry with event data
  KVM: VMX: Handle NMI Source report in VM exit

 arch/x86/entry/entry_64_fred.S     |   2 +-
 arch/x86/events/amd/ibs.c          |   2 +-
 arch/x86/events/core.c             |   7 +-
 arch/x86/events/intel/core.c       |   6 +-
 arch/x86/include/asm/apic.h        |  23 ++++++
 arch/x86/include/asm/cpufeatures.h |   1 +
 arch/x86/include/asm/fred.h        |   8 +-
 arch/x86/include/asm/irq_vectors.h |  40 +++++++++
 arch/x86/include/asm/nmi.h         |   4 +-
 arch/x86/kernel/apic/hw_nmi.c      |   5 +-
 arch/x86/kernel/apic/ipi.c         |   4 +-
 arch/x86/kernel/apic/local.h       |  16 ----
 arch/x86/kernel/cpu/mce/inject.c   |   4 +-
 arch/x86/kernel/cpu/mshyperv.c     |   2 +-
 arch/x86/kernel/kgdb.c             |   6 +-
 arch/x86/kernel/kvm.c              |  10 +--
 arch/x86/kernel/nmi.c              | 127 ++++++++++++++++++++++++++---
 arch/x86/kernel/nmi_selftest.c     |   7 +-
 arch/x86/kernel/reboot.c           |   4 +-
 arch/x86/kernel/smp.c              |   4 +-
 arch/x86/kernel/traps.c            |   4 +-
 arch/x86/kvm/vmx/vmx.c             |  13 ++-
 arch/x86/platform/uv/uv_nmi.c      |   4 +-
 drivers/acpi/apei/ghes.c           |   2 +-
 drivers/char/ipmi/ipmi_watchdog.c  |   2 +-
 drivers/edac/igen6_edac.c          |   2 +-
 drivers/watchdog/hpwdt.c           |   6 +-
 27 files changed, 237 insertions(+), 78 deletions(-)

-- 
2.25.1

