Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298CE14534D;
	Wed, 29 May 2024 20:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717014515; cv=none; b=G4Le+g19btxA9nUIjk+nRz/CzIi+OJlr8ZEmAKw0zIfwN1EMpfDPu+tnKEkp8qS+xq3mW+UAXYHXd2oLQQT+tINRVj9h9C7GrKBcuV1dIhqQN/66pzbBxLC4c2KL1FaG2ZV71tjWd+naBXG7GLk2JcgbA4R3jzX5dAxSEHh4nzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717014515; c=relaxed/simple;
	bh=yxO+RouaVjt4hpv26MKV9LGR+GrQJeATy9q/u2t1Va0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bw4IAudmuTj/JNM/S/+PWGGC7pGakaDmfy6Zn7Qmzk+d5GKOC0MuGNX+oYy9lBp7IhtNcohyhttBAp7KQFHtdouPzYSR4NZLlMhUmuBnLRBfCpftth8j/e47zZ7BCurLQ5VzyUnGKSM97Z6orNzzEd6VbBy5mrikpQeOWFLFH6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AaoojB2+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AaoojB2+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717014513; x=1748550513;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yxO+RouaVjt4hpv26MKV9LGR+GrQJeATy9q/u2t1Va0=;
  b=AaoojB2+gPMU0wRUBM/aaK/jsXP2EG1H/L7um2Hgy2aGKjgLC1aqivQ+
   NUF2puYeraotqq3TQ6MrcIwVIBjbOopQshYWQDV4U0nzzAOylvzirqKqS
   FihRM+McEskVMdONdzKRtdUzbkqnlZ3fSHF12CxkIJIX5EF1poxO9TqDU
   zS2rcslI6Nz9NyTuiw4C5mB4yOgqW6md2K9slCRqk+zn2cunHyoXPIIFm
   a3SAZChf9/RdCTyX0vUz8DL46oySIAaJJPMujo0E7YSS6Gb9HmdgggUxk
   qdbJH6j5VSnrULNdi/gGYCdjbxme7EX0vDqXUtBEZ4RFJh+uLcEzugA7p
   Q==;
X-CSE-ConnectionGUID: rsIHlPHmQAC361o5WTfTFw==
X-CSE-MsgGUID: zUdlCGePRSGzdZZR/xsJzQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13574522"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13574522"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 13:28:32 -0700
X-CSE-ConnectionGUID: HbFkC3PJSHGq0tVkSLmGDg==
X-CSE-MsgGUID: Olioliv0Sy2umeEC2/k42w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35491261"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa007.fm.intel.com with ESMTP; 29 May 2024 13:28:32 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: X86 Kernel <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Ingo Molnar" <mingo@redhat.com>,
	"Borislav Petkov" <bp@alien8.de>,
	linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <andi.kleen@intel.com>,
	"Xin Li" <xin3.li@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 0/6] Add support for NMI source reporting
Date: Wed, 29 May 2024 13:33:19 -0700
Message-Id: <20240529203325.3039243-1-jacob.jun.pan@linux.intel.com>
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


[1] https://www.intel.com/content/www/us/en/content-details/779982/flexible-return-and-event-delivery-fred-specification.html
[2] https://lore.kernel.org/lkml/171011362209.2468526.15187874627966416701.tglx@xen13/

Thanks,

Jacob

Jacob Pan (6):
  x86/irq: Add enumeration of NMI source reporting CPU feature
  x86/irq: Extend NMI handler registration interface to include source
  x86/irq: Factor out common NMI handling code
  x86/irq: Process nmi sources in NMI handler
  perf/x86: Enable NMI source reporting for perfmon
  x86/irq: Enable NMI source on IPIs delivered as NMI

 arch/x86/Kconfig                         |  9 +++
 arch/x86/events/amd/ibs.c                |  2 +-
 arch/x86/events/core.c                   | 11 ++-
 arch/x86/events/intel/core.c             |  6 +-
 arch/x86/include/asm/apic.h              |  1 +
 arch/x86/include/asm/cpufeatures.h       |  1 +
 arch/x86/include/asm/disabled-features.h |  8 ++-
 arch/x86/include/asm/irq_vectors.h       | 31 ++++++++
 arch/x86/include/asm/nmi.h               |  4 +-
 arch/x86/kernel/apic/hw_nmi.c            |  5 +-
 arch/x86/kernel/apic/ipi.c               |  4 +-
 arch/x86/kernel/apic/local.h             | 18 +++--
 arch/x86/kernel/cpu/cpuid-deps.c         |  1 +
 arch/x86/kernel/cpu/mce/inject.c         |  4 +-
 arch/x86/kernel/cpu/mshyperv.c           |  2 +-
 arch/x86/kernel/kgdb.c                   |  6 +-
 arch/x86/kernel/nmi.c                    | 92 ++++++++++++++++++++----
 arch/x86/kernel/nmi_selftest.c           |  7 +-
 arch/x86/kernel/reboot.c                 |  4 +-
 arch/x86/kernel/smp.c                    |  4 +-
 arch/x86/kernel/traps.c                  |  4 +-
 arch/x86/platform/uv/uv_nmi.c            |  4 +-
 drivers/acpi/apei/ghes.c                 |  2 +-
 drivers/char/ipmi/ipmi_watchdog.c        |  2 +-
 drivers/edac/igen6_edac.c                |  2 +-
 drivers/watchdog/hpwdt.c                 |  6 +-
 26 files changed, 187 insertions(+), 53 deletions(-)

-- 
2.25.1

