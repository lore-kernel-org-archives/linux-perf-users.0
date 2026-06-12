Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1377379C37
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781292553; cv=none; b=Fo7EOO8WPIymqdxVuBvlPdyuu42IZSNfJl5yQFST6pfABiH5ccgRmVqSUvAqJAmhF9YPRKcRKpgF3VUtNjgn5r7Uyls+SICMAgb+N8GcQjvV9zjDS0ndwlHmMJzJTXGD3YfhhDPdHdTYvHV2oAkS92LsH0tOVE1OODjSS57Rv2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781292553; c=relaxed/simple;
	bh=DlsneMygrkTUWs+1mVdQCE+qz199JpVjNUFhJE+VTWc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JmD/NC49f7sBKXNALu9HEZXVF5QDNAHrBgwp+vS97CLfY0MN72GRIf7n1pyianCjfqmDA72NpEz2nOeQHqkCcGyBlDqZSqxIhw6iQNQy2bHX5/E6bin3ePdkE4EGrG5A7cDCxwWrR2lKkuJrt9lVPYIPfujCMFtdKqR1fsDv4GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XK6AyxgY; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XK6AyxgY"
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-486db2bf46eso1550934b6e.3
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 12:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781292551; x=1781897351; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u60qdRNOCqKqcuRdaXAx140Po6M1Yopy4F2KxEGMp20=;
        b=XK6AyxgYQDT7PpNkyo5+ediW+X34wsvfIl69Dg9wvAKW0kSWpaMTWO+zTCzCA7B5Nz
         Yp90X1wEnz0uNbxz8K1ZGja+XA386GFvjrbae3f45gwbDXy29eacSeuhNQPTRAoNjste
         I7ujZm5fTA15yi7JQtLvDVuL1TXE2rNgJXDV7C+UcddBdcTFUFjNw3yZgPGUjqKz2Vos
         2x/siGDvHS5FWLZlUtSUpyLCdCOFhNifNlk38Yj9zzrlFCMsyT47q8cowoVQbkDYcHJd
         biYT0YZ8zdRe3+wPEutpXgJuZqQE+jP7+1p8Ouyd3k/aPV33Eb7zb0h+Y/8IVUma5ySy
         x7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781292551; x=1781897351;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u60qdRNOCqKqcuRdaXAx140Po6M1Yopy4F2KxEGMp20=;
        b=OH8c/83tV6ediNrX1J3yW6DzfrwF+Qv47yo7uL+1jHp6akamHD1tuxY9YkNQMVlGvG
         kgxSAieOzda7ljaP1ZHNotWYhcXzRFAU9dRiweTbosiq+BYCUZmzAmDDTqwAL/T6OwEv
         OkWCPeY7i+dK2GiiljrAU6tb8Ib1k3q6yJZZN2uOzPJys1w/SP60Z2CzJhCNgl2pNikh
         G3yfdq2nqw/bkvmSNJl0JuUajyePVOD9bkY6B2cc+DwRzmlQEkqJPyE9c6WmaQVcGatk
         Jy7TNU9uXVm+YWhL+WFTSSYwYhy95PyS7Fud9r77bbpmMeOuyT+V0c5kfVOpsXG4NC0s
         2ksw==
X-Forwarded-Encrypted: i=1; AFNElJ98l+/JKOf4TMSvVXH7RF8O+WGydHsEqP1lL87F2O4VJX8tjzFxS+EgHMbj/P8U4Wle12u1Fxvad/y9gkFF5smV@vger.kernel.org
X-Gm-Message-State: AOJu0YwRb3RNENi0YCw9/WeCe9QwWDvkAaSrsFne/f4goxE57Oj7wyKW
	5d097jK7mGmXHz1KxUBx7hi/6+rngd98uvdYORfI1o0ol638WpOCINvTAyvJqK6uvcFKQ2+aIQp
	odds2Q4BQlvJyljLbuCxORKzDDQ==
X-Received: from ilqh1.prod.google.com ([2002:a92:d841:0:b0:501:ee09:eb2e])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1913:b0:479:d25e:9065 with SMTP id 5614622812f47-4874193626fmr670168b6e.2.1781292550242;
 Fri, 12 Jun 2026 12:29:10 -0700 (PDT)
Date: Fri, 12 Jun 2026 19:28:48 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612192909.1153907-1-coltonlewis@google.com>
Subject: [PATCH v8 00/21] ARM64 PMU Partitioning
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mingwei Zhang <mizhang@google.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, 
	James Clark <james.clark@linaro.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

This series creates a new PMU scheme on ARM, a partitioned PMU that
allows reserving a subset of counters for more direct guest access,
significantly reducing overhead. More details, including performance
benchmarks, can be read in the v1 cover letter linked below.

An overview of what this series accomplishes was presented at KVM
Forum 2025. Slides [1] and video [2] are linked below.

The kernel command line parameter for the driver still exists, but now
only defines an upper limit of counters the guest might use rather
than taking those counters from the host permanently.

I would appreciate any discussion on whether that parameter should
still exist as it's an inconvenient enabling gate on the feature that
is no longer required. The question comes down to what, if any, guards
we want against a guest monopolizing all counters on a system.

v8:

* Rebase on top of v7.1-rc7.

* Implement Oliver Upton's accessor proposal to centralize PMU
  register access and simplify trap handlers. Instead of one singular
  accessor, implement as two because the read and write paths are
  always different anyway.

* Introduce the partitioning flag along with the
  kvm_pmu_is_partitioned predicate

* Don't use ifdef for partitioning predicates as that can be handled
  by has_vhe

* Clean up MDCR_EL2 handling by open-coding use_fgt and hpmn and
  unconditionally setting RES0 bits.

* Use {read,write}_pmcrcntrn in context swaps

* Put operators on preceeding lines

* Rename hw_cntr_mask to hw_cntr_impl to clarify it tracks the number
  of counters implemented by hardware

* Use GENMASK_ULL in mask functions returning u64

* warn_once when host events are squeezed out by guest counter
  allocations.

* Address Sashiko AI Review findings:

  - Critical fixes for lazy PMU context swaps (ensuring guest state is
    loaded on transition to GUEST_OWNED), PMSELR_EL0 trapping to
    prevent stale selector index, and masking guest PMCR_EL0 writes to
    prevent host reset.

  - High priority fixes for lock safety (disabling IRQs when acquiring
    perf context lock), disabling guest counters on vCPU put,
    preserving VHE host profiling in MDCR_EL2, waking halted vCPUs on
    guest PMU interrupts, masking host configuration leaks, preemption
    safety in per-CPU accesses, emulating PMCR.N reads, and preventing
    data races in PMOVSSET_EL0 accesses.

  - Medium/Low fixes for user-access fallback safety, VM-wide state
    modification restrictions, selftests type safety, and cleanup of
    unused fields and typos.

v7:
https://lore.kernel.org/kvmarm/20260504211813.1804997-1-coltonlewis@google.com/

v6:
https://lore.kernel.org/kvmarm/20260209221414.2169465-1-coltonlewis@google.com/

v5:
https://lore.kernel.org/kvmarm/20251209205121.1871534-1-coltonlewis@google.com/

v4:
https://lore.kernel.org/kvmarm/20250714225917.1396543-1-coltonlewis@google.com/

v3:
https://lore.kernel.org/kvm/20250626200459.1153955-1-coltonlewis@google.com/

v2:
https://lore.kernel.org/kvm/20250620221326.1261128-1-coltonlewis@google.com/

v1:
https://lore.kernel.org/kvm/20250602192702.2125115-1-coltonlewis@google.com/

[1] https://gitlab.com/qemu-project/kvm-forum/-/raw/main/_attachments/2025/Optimizing__itvHkhc.pdf
[2] https://www.youtube.com/watch?v=YRzZ8jMIA6M&list=PLW3ep1uCIRfxwmllXTOA2txfDWN6vUOHp&index=9

Colton Lewis (20):
  arm64: cpufeature: Add cpucap for HPMN0
  KVM: arm64: Reorganize PMU functions
  perf: arm_pmuv3: Generalize counter bitmasks
  perf: arm_pmuv3: Check cntr_mask before using pmccntr
  perf: arm_pmuv3: Allocate counter indices from high to low
  perf: arm_pmuv3: Add method to partition the PMU
  KVM: arm64: Set up FGT for Partitioned PMU
  KVM: arm64: Add Partitioned PMU register trap handlers
  KVM: arm64: Set up MDCR_EL2 to handle a Partitioned PMU
  KVM: arm64: Context swap Partitioned PMU guest registers
  KVM: arm64: Enforce PMU event filter at vcpu_load()
  perf: Add perf_pmu_resched_update()
  KVM: arm64: Apply dynamic guest counter reservations
  KVM: arm64: Implement lazy PMU context swaps
  perf: arm_pmuv3: Handle IRQs for Partitioned PMU guest counters
  KVM: arm64: Detect overflows for the Partitioned PMU
  KVM: arm64: Add vCPU device attr to partition the PMU
  KVM: selftests: Add find_bit to KVM library
  KVM: arm64: selftests: Add test case for Partitioned PMU
  KVM: arm64: selftests: Relax testing for exceptions when partitioned

Marc Zyngier (1):
  KVM: arm64: Reorganize PMU includes

 arch/arm/include/asm/arm_pmuv3.h              |  18 +
 arch/arm64/include/asm/arm_pmuv3.h            |  12 +-
 arch/arm64/include/asm/kvm_host.h             |  17 +-
 arch/arm64/include/asm/kvm_types.h            |   6 +-
 arch/arm64/include/uapi/asm/kvm.h             |   2 +
 arch/arm64/kernel/cpufeature.c                |  10 +-
 arch/arm64/kvm/Makefile                       |   2 +-
 arch/arm64/kvm/arm.c                          |   2 +
 arch/arm64/kvm/config.c                       |  41 +-
 arch/arm64/kvm/debug.c                        |  30 +-
 arch/arm64/kvm/pmu-direct.c                   | 507 ++++++++++++
 arch/arm64/kvm/pmu-emul.c                     | 684 +----------------
 arch/arm64/kvm/pmu.c                          | 720 ++++++++++++++++++
 arch/arm64/kvm/sys_regs.c                     | 271 +++++--
 arch/arm64/tools/cpucaps                      |   1 +
 arch/arm64/tools/sysreg                       |   6 +-
 drivers/perf/arm_pmuv3.c                      | 136 +++-
 include/kvm/arm_pmu.h                         |  93 ++-
 include/linux/perf/arm_pmu.h                  |   8 +
 include/linux/perf/arm_pmuv3.h                |  14 +-
 include/linux/perf_event.h                    |   3 +
 kernel/events/core.c                          |  31 +-
 tools/include/perf/arm_pmuv3.h                |  12 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/arm64/vpmu_counter_access.c | 112 ++-
 tools/testing/selftests/kvm/lib/find_bit.c    |   2 +
 26 files changed, 1918 insertions(+), 823 deletions(-)
 create mode 100644 arch/arm64/kvm/pmu-direct.c
 create mode 100644 tools/testing/selftests/kvm/lib/find_bit.c


base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
-- 
2.54.0.1136.gdb2ca164c4-goog

