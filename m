Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E437440861;
	Tue, 11 Jun 2024 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124949; cv=none; b=VIaSMBXZaQPjW5KK2WXzTTgfaYUMcWgEjIoAeoWqUVySNmxkLKd6RUOamKr207nAfsTjNLG1Jsf7bnkyjcQ1JrW7YWOe4kCh+RG9AtWBTutHXU2EXr4UHTh9LR3S7A00NjO3OXxdSo9nEQkbawok9NlGeGmyV7Qf4gFpM4MWRgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124949; c=relaxed/simple;
	bh=5ERFtRjM8yegnkIXt+aiMFY0d7KS90qT1YmOd8VczYc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XdT2bisF6/fZClKbPQTzampvB6wQXLAx+Z99apq1kxaQQnSj8PfN/yQr4DtJyW60RVrJc8wV5he4f1l3MvbPFac0PajS/sMmMmvN0WbZqpD7LOzdTBjH8HTo8czVAgMeshtqTCVhpdgRQk6IHsD104g38Z/ZXQiFqeTRTjSmu3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bkSgyzZm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bkSgyzZm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718124947; x=1749660947;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5ERFtRjM8yegnkIXt+aiMFY0d7KS90qT1YmOd8VczYc=;
  b=bkSgyzZmCLrxnUi6bsaWV5SvI7U2DbjEmCVq5oYRsGu35Fh0EAZmhVYi
   CEAMbwR7jYNp4lsza/GN/SeMHx3xudvrMUbYVA3wo+3ZaMh6ixc9MHtmW
   h6R0CrY9cu79EWnbxHqHaYxp/sYpKufhf+jUR5HY6KHbtSEJiu+ajg5GH
   oKA/dXO/US84rpQEZn0iIcy6gDPo7Oiz9ucxX6GR5IOv8SwEg4LT8Kl6C
   XzHQKFdK6EHg/umiKlNy6TFoRbHt/Lb4JwOtOsKpIAtmdSIvpaiPhhB7R
   Zrtsm0EcFGBWRLfA5TstiJQ1QP6iZJ2dtfQ1WBv3CzZunk7C2BYHefkwq
   g==;
X-CSE-ConnectionGUID: Knj/QHz7Ts2gPKjN6D5YSA==
X-CSE-MsgGUID: 7UY5LepnT2KRh76YzbwOeA==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="15076535"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208,223";a="15076535"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 09:55:44 -0700
X-CSE-ConnectionGUID: RMHZ/v6RTYOQA3ifLydOEw==
X-CSE-MsgGUID: mwUi/uFsScip/MaHellHOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208,223";a="70299105"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by orviesa002.jf.intel.com with ESMTP; 11 Jun 2024 09:55:44 -0700
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
	"Xin Li" <xin3.li@intel.com>
Subject: 
Date: Tue, 11 Jun 2024 10:00:46 -0700
Message-Id: <20240611170046.156806-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From e52010df700cde894633c45c0b364847e63a9819 Mon Sep 17 00:00:00 2001
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Date: Tue, 11 Jun 2024 09:49:17 -0700
Subject: [PATCH v2 0/6] Add support for NMI source reporting

Hi Thomas and all,

(resend cover letter)

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
Change logs are in individual patches.

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
 arch/x86/include/asm/disabled-features.h |  8 +-
 arch/x86/include/asm/irq_vectors.h       | 38 +++++++++
 arch/x86/include/asm/nmi.h               |  4 +-
 arch/x86/kernel/apic/hw_nmi.c            |  5 +-
 arch/x86/kernel/apic/ipi.c               |  4 +-
 arch/x86/kernel/apic/local.h             | 18 +++--
 arch/x86/kernel/cpu/mce/inject.c         |  4 +-
 arch/x86/kernel/cpu/mshyperv.c           |  2 +-
 arch/x86/kernel/kgdb.c                   |  6 +-
 arch/x86/kernel/nmi.c                    | 99 +++++++++++++++++++++---
 arch/x86/kernel/nmi_selftest.c           |  7 +-
 arch/x86/kernel/reboot.c                 |  4 +-
 arch/x86/kernel/smp.c                    |  4 +-
 arch/x86/kernel/traps.c                  |  4 +-
 arch/x86/platform/uv/uv_nmi.c            |  4 +-
 drivers/acpi/apei/ghes.c                 |  2 +-
 drivers/char/ipmi/ipmi_watchdog.c        |  2 +-
 drivers/edac/igen6_edac.c                |  2 +-
 drivers/watchdog/hpwdt.c                 |  6 +-
 25 files changed, 200 insertions(+), 53 deletions(-)

-- 
2.25.1

