Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EF445944
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973430; cv=none; b=nvx6a1NsIZLmtOTCQUuXcJZsTyX7s7b4SuXQrnp+e/kBEXuuRqvqvn2ImO3+eVAoWyXCmYqLM5y1I64w+3YXGZu5jDdaqDx7qCv6OdgPD2tkdYdz536vyGRIizjyr6psQ/UDLvntKkpgJk69/UGCvwVCNrJ7njQJ9yK0VZw23y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973430; c=relaxed/simple;
	bh=8klybuOjTZHZ/FbpxQbeoYlXPCecxwX52rCVffBpENY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SMKv8Aj1rU7STkCQmuW6ZdNwo163CAqwIBEJOSxK7qGHoFFME60UfBFy8GyR+HSgPNKvZmwmdDvXqlqequc2ds46oK7tevLtI73/g92o3a4crXdNSBLHb9dPBWnQje9sfCpnkE9+t/haEfbedMOL65IsM+w0ryaYNiZfo0x3Elw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G4rfta4O; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G4rfta4O"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b413f9999eso1184536a91.1
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973427; x=1715578227; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTsozWncuu3/k1xPpYFeOsw/JjW5F1S9IK8z9IeMfA0=;
        b=G4rfta4ONh2CtLL4vLaVYfDgyf+5kdq28t5Txc1Ngpkj1g/D/3k0Rtd2fEOeN4NlqD
         xVk2KqD3YLHfrsjBCHvuLvIfIqRV+t6QGFtKsC6aO0QaHSBhlBMTWj/aR8uVU7AciZlA
         VodTcY+AufX/rrdawriGcAJgD3MKygETfg3FDgDif9WAIPhYtnuHBfUYW7yca21qLyjA
         rRkJy/qhQPDLVWaOl3aTHcCDi9Qbv7NLSEmtAxixUoMQ7auH3Hqz21Kun+0TxIueQcmL
         mt05rOhCOM3EYFdIA4N4udeJg+2nNUMzsGY6mczwKRPEcib5Gdw8C6iQx6JbfVoxPRM5
         jqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973427; x=1715578227;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HTsozWncuu3/k1xPpYFeOsw/JjW5F1S9IK8z9IeMfA0=;
        b=Jtx0IdWG4Z1PkAAb1O2CxQC4PH2T+jeOy1q8Hacuj8ZflGoifdsVQj48L0T80EN5LE
         TS0wGGuBYW7cFD1EpGhZRp2h6h1T50YVmLM09QpO7ot9I0QV3SfiTkqCaAQzasSGPQDb
         XEoBaMqpslENsPy8sYyYuKlePRIsC0055T5W1Bv1faOIZ/NPgoJySGlah0u86VFtg389
         BJlAJ34zGEIfS655olpDhXS/GarJA4vK+8nYtf4HsfgqRXlzi5GedGCLqb/pq1cipbWX
         DOgjFsk1+7X4L2Hrv31Uy/iLvCp2Uhr9oSLb/abjv7B/AONMKdscEXu5wywGB7XKgW8T
         uIfw==
X-Forwarded-Encrypted: i=1; AJvYcCVNIEhtwjIoRLJyRtXWXUBZ8BhDhawb+LzZClM9eaLHqh4IhQFw8ODM/ORSAyYMu5OfBOUpJ/T1rBwLPh4jLZxZzipFf5q/cu6EAYdA9D9H8g==
X-Gm-Message-State: AOJu0YyoV3YDEeypE8GE1jNPX7UCycCpO+D4kjuozPYvIMFJzbL7rk8U
	XYdJykWpHngM7UA9cjw+Fv46rwYNbn65YH0rnr9iRLddscP61VzK7ZnrUdL4+g0oooT7w1G9HYo
	L6iwmyQ==
X-Google-Smtp-Source: AGHT+IEI8+8euR0WlnAdmtVWp76yu8WH7m4NaT/I67wDvpnu7xMO3AMRSIfUFM6Pkd0MEmWMMCmW96nfq7CO
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a17:90b:4016:b0:2ac:39d9:dd2e with SMTP id
 ie22-20020a17090b401600b002ac39d9dd2emr35978pjb.0.1714973426003; Sun, 05 May
 2024 22:30:26 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:29:25 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-1-mizhang@google.com>
Subject: [PATCH v2 00/54] Mediated Passthrough vPMU 2.0 for x86
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kan Liang <kan.liang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Cc: Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mingwei Zhang <mizhang@google.com>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, maobibo <maobibo@loongson.cn>, 
	Like Xu <like.xu.linux@gmail.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In this version, we added the mediated passthrough vPMU support for AMD.
This is 1st version that comes up with a full x86 support on the vPMU
new design.

Major changes:
 - AMD support integration. Supporting guest PerfMon v1 and v2.
 - Ensure !exclude_guest events only exist prior to mediate passthrough
   vPMU loaded. [sean]
 - Update PMU MSR interception according to exposed counters and pmu
   version. [mingwei reported pmu_counters_test fails]
 - Enforce RDPMC interception unless all counters exposed to guest. This
   removes a hack in RFCv1 where we pass through RDPMC and zero
   unexposed counters. [jim/sean]
 - Combine the PMU context switch for both AMD and Intel.
 - Because of RDPMC interception, update PMU context switch code by
   removing the "zeroing out" logic when restoring the guest context.
   [jim/sean: intercept rdpmc]

Minor changes:
 - Flip enable_passthrough_pmu to false and change to a vendor param.
 - Remove "Intercept full-width GP counter MSRs by checking with perf
   capabilities".
 - Remove the write to pmc patch.
 - Move host_perf_cap as an independent variable, will update after
   https://lore.kernel.org/all/20240423221521.2923759-1-seanjc@google.com/

TODOs:
 - Simplify enabling code for mediated passthrough vPMU.
 - Further optimization on PMU context switch.

On-going discussions:
 - Final name of mediated passthrough vPMU.
 - PMU context switch optimizations.

Testing:
 - Testcases:
   - selftest: pmu_counters_test
   - selftest: pmu_event_filter_test
   - kvm-unit-tests: pmu
   - qemu based ubuntu 20.04 (guest kernel: 5.10 and 6.7.9)
 - Platforms:
   - genoa
   - skylake
   - icelake
   - sapphirerapids
   - emeraldrapids

Ongoing Issues:
 - AMD platform [milan]:
  - ./pmu_event_filter_test error:
    - test_amd_deny_list: Branch instructions retired = 44 (expected 42)
    - test_without_filter: Branch instructions retired = 44 (expected 42)
    - test_member_allow_list: Branch instructions retired = 44 (expected 42)
    - test_not_member_deny_list: Branch instructions retired = 44 (expected 42)
 - Intel platform [skylake]:
  - kvm-unit-tests/pmu fails with two errors:
    - FAIL: Intel: TSX cycles: gp cntr-3 with a value of 0
    - FAIL: Intel: full-width writes: TSX cycles: gp cntr-3 with a value of 0

Installation guidance:
 - echo 0 > /proc/sys/kernel/nmi_watchdog
 - modprobe kvm_{amd,intel} enable_passthrough_pmu=Y 2>/dev/null

v1: https://lore.kernel.org/all/20240126085444.324918-1-xiong.y.zhang@linux.intel.com/


Dapeng Mi (3):
  x86/msr: Introduce MSR_CORE_PERF_GLOBAL_STATUS_SET
  KVM: x86/pmu: Introduce macro PMU_CAP_PERF_METRICS
  KVM: x86/pmu: Add intel_passthrough_pmu_msrs() to pass-through PMU
    MSRs

Kan Liang (3):
  perf: Support get/put passthrough PMU interfaces
  perf: Add generic exclude_guest support
  perf/x86/intel: Support PERF_PMU_CAP_PASSTHROUGH_VPMU

Manali Shukla (1):
  KVM: x86/pmu/svm: Wire up PMU filtering functionality for passthrough
    PMU

Mingwei Zhang (24):
  perf: core/x86: Forbid PMI handler when guest own PMU
  perf: core/x86: Plumb passthrough PMU capability from x86_pmu to
    x86_pmu_cap
  KVM: x86/pmu: Introduce enable_passthrough_pmu module parameter
  KVM: x86/pmu: Plumb through pass-through PMU to vcpu for Intel CPUs
  KVM: x86/pmu: Add a helper to check if passthrough PMU is enabled
  KVM: x86/pmu: Add host_perf_cap and initialize it in
    kvm_x86_vendor_init()
  KVM: x86/pmu: Allow RDPMC pass through when all counters exposed to
    guest
  KVM: x86/pmu: Introduce PMU operator to check if rdpmc passthrough
    allowed
  KVM: x86/pmu: Create a function prototype to disable MSR interception
  KVM: x86/pmu: Avoid legacy vPMU code when accessing global_ctrl in
    passthrough vPMU
  KVM: x86/pmu: Exclude PMU MSRs in vmx_get_passthrough_msr_slot()
  KVM: x86/pmu: Add counter MSR and selector MSR index into struct
    kvm_pmc
  KVM: x86/pmu: Introduce PMU operation prototypes for save/restore PMU
    context
  KVM: x86/pmu: Implement the save/restore of PMU state for Intel CPU
  KVM: x86/pmu: Make check_pmu_event_filter() an exported function
  KVM: x86/pmu: Allow writing to event selector for GP counters if event
    is allowed
  KVM: x86/pmu: Allow writing to fixed counter selector if counter is
    exposed
  KVM: x86/pmu: Exclude existing vLBR logic from the passthrough PMU
  KVM: x86/pmu: Introduce PMU operator to increment counter
  KVM: x86/pmu: Introduce PMU operator for setting counter overflow
  KVM: x86/pmu: Implement emulated counter increment for passthrough PMU
  KVM: x86/pmu: Update pmc_{read,write}_counter() to disconnect perf API
  KVM: x86/pmu: Disconnect counter reprogram logic from passthrough PMU
  KVM: nVMX: Add nested virtualization support for passthrough PMU

Sandipan Das (11):
  KVM: x86/pmu: Do not mask LVTPC when handling a PMI on AMD platforms
  x86/msr: Define PerfCntrGlobalStatusSet register
  KVM: x86/pmu: Always set global enable bits in passthrough mode
  perf/x86/amd/core: Set passthrough capability for host
  KVM: x86/pmu/svm: Set passthrough capability for vcpus
  KVM: x86/pmu/svm: Set enable_passthrough_pmu module parameter
  KVM: x86/pmu/svm: Allow RDPMC pass through when all counters exposed
    to guest
  KVM: x86/pmu/svm: Implement callback to disable MSR interception
  KVM: x86/pmu/svm: Set GuestOnly bit and clear HostOnly bit when guest
    write to event selectors
  KVM: x86/pmu/svm: Add registers to direct access list
  KVM: x86/pmu/svm: Implement handlers to save and restore context

Sean Christopherson (2):
  KVM: x86/pmu: Set enable bits for GP counters in PERF_GLOBAL_CTRL at
    "RESET"
  KVM: x86: Snapshot if a vCPU's vendor model is AMD vs. Intel
    compatible

Xiong Zhang (10):
  perf: core/x86: Register a new vector for KVM GUEST PMI
  KVM: x86: Extract x86_set_kvm_irq_handler() function
  KVM: x86/pmu: Register guest pmi handler for emulated PMU
  perf: x86: Add x86 function to switch PMI handler
  KVM: x86/pmu: Manage MSR interception for IA32_PERF_GLOBAL_CTRL
  KVM: x86/pmu: Switch IA32_PERF_GLOBAL_CTRL at VM boundary
  KVM: x86/pmu: Switch PMI handler at KVM context switch boundary
  KVM: x86/pmu: Grab x86 core PMU for passthrough PMU VM
  KVM: x86/pmu: Call perf_guest_enter() at PMU context switch
  KVM: x86/pmu: Add support for PMU context switch at VM-exit/enter

 arch/x86/events/amd/core.c               |   3 +
 arch/x86/events/core.c                   |  41 ++++-
 arch/x86/events/intel/core.c             |   6 +
 arch/x86/events/perf_event.h             |   1 +
 arch/x86/include/asm/hardirq.h           |   1 +
 arch/x86/include/asm/idtentry.h          |   1 +
 arch/x86/include/asm/irq.h               |   2 +-
 arch/x86/include/asm/irq_vectors.h       |   5 +-
 arch/x86/include/asm/kvm-x86-pmu-ops.h   |   6 +
 arch/x86/include/asm/kvm_host.h          |  10 ++
 arch/x86/include/asm/msr-index.h         |   2 +
 arch/x86/include/asm/perf_event.h        |   4 +
 arch/x86/include/asm/vmx.h               |   1 +
 arch/x86/kernel/idt.c                    |   1 +
 arch/x86/kernel/irq.c                    |  36 ++++-
 arch/x86/kvm/cpuid.c                     |   4 +
 arch/x86/kvm/cpuid.h                     |  10 ++
 arch/x86/kvm/lapic.c                     |   3 +-
 arch/x86/kvm/mmu/mmu.c                   |   2 +-
 arch/x86/kvm/pmu.c                       | 168 ++++++++++++++++++-
 arch/x86/kvm/pmu.h                       |  47 ++++++
 arch/x86/kvm/svm/pmu.c                   | 112 ++++++++++++-
 arch/x86/kvm/svm/svm.c                   |  23 +++
 arch/x86/kvm/svm/svm.h                   |   2 +-
 arch/x86/kvm/vmx/capabilities.h          |   1 +
 arch/x86/kvm/vmx/nested.c                |  52 ++++++
 arch/x86/kvm/vmx/pmu_intel.c             | 192 ++++++++++++++++++++--
 arch/x86/kvm/vmx/vmx.c                   | 197 +++++++++++++++++++----
 arch/x86/kvm/vmx/vmx.h                   |   3 +-
 arch/x86/kvm/x86.c                       |  47 +++++-
 arch/x86/kvm/x86.h                       |   1 +
 include/linux/perf_event.h               |  18 +++
 kernel/events/core.c                     | 176 ++++++++++++++++++++
 tools/arch/x86/include/asm/irq_vectors.h |   3 +-
 34 files changed, 1120 insertions(+), 61 deletions(-)


base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

