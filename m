Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA5F342509
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 21:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929511; cv=none; b=a260knh+ARuEfcL5Vems2EUzqaETa+6WhBohYo8iLQ3UISjnqVLG2lRuCve0RNJDyoDNsfElZyLNxzlSWRs21abmr1q4Z3DA1f3dI6RycEdPceee+Zk3Gm34KoV17StZ8HpM7JcPgVxv1LJg6pBDZQ59NxFet3vQgqsBdnE20vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929511; c=relaxed/simple;
	bh=gaSAW0vbxuJ8Ztv+Ptyrd97pvIgNhbocUwZ87v8ZJro=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kz6qInv5Rw8WsWwWZuZeMIbRLmoE24NWbQHSSOyBn0ywD1I0tEvK8bo+fpjWz1YuothIwS+v3bz/NPBjoFdiWArxAo9oivIFaRDiHfJ0H3aI03+ENhF4FtiTlUhVGlvrx0WsNXHUFOBBR2/F6GcNMGQEnCyeKZ0IfgTXA4F55DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QzPmEEY2; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QzPmEEY2"
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-6967b799acdso8347562eaf.3
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 14:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777929508; x=1778534308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s5oN3WHDlvrpSTYnrxqaHijQGk2I8Xsq5SmkYySfX18=;
        b=QzPmEEY2h8u5ld+H1xesuXw4WOtrRmqfmZRNfYNTMrXLlKB7ws0Pu1aXfXWo6nsNCN
         h73pj2vPcKuRFnEgVPywte5+Mk3itd4F4Xx1Kkzt9R5OpOULPQeqkKyI8b07JeIjokv1
         26OJA8rY2x4OWjTOL1eFPeOa5BVNqGRu5G+uIyiQ6gsVAkT3RoUnVfESg+wKU0o8pPHv
         MFE11RQSIqIwzT402NFmU4nkojHvVidKV6OkywsnoIQB88Lywtby/RLdD2N0g1M4SIRN
         xUCl/frvqKNKVHa/YxPlr1/fVv4LgiN9z0u0WzvPowgh5gwxG/YhBHP77asL9RvocKKe
         cAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777929508; x=1778534308;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s5oN3WHDlvrpSTYnrxqaHijQGk2I8Xsq5SmkYySfX18=;
        b=Ss1GAZU48IwBTIidHd8EOjk06obU+Zu1vqwGGmhxPhv5q+3gwGoaxuIjY5FO0bTxSF
         3l7cUNyWQWyvSjThz7/NtE6u+TQ44EdOSK9me8TUcJxX/TrC/ozOAMEWDPv7KvyXza3U
         LVYeZFjoo9TAP22E5dzyxOvsCWMgNleQpNjvoZdOctrckY+3Sz4KXDI8oo+CPXj9DqNg
         3V9QqhVnt0zBMQ/QGCzbpW1qpEd/qCOsVc7hgFP30f3e7+N9PV3M8ZXdgs6beTp1xOKF
         J9/RRq40+JGNFRulOFIyWwq1NBtBx1FeAZxBi6TYfWemb7sXMfqgR3A9aAilQq0loNoD
         G/rw==
X-Forwarded-Encrypted: i=1; AFNElJ9iUeSrrSKy9JQkNqyW/nCrVC8H4N9wVt1zxBMgaRsKZoplVfW9TILd7vRq13z1D8CsaEKH04Bhrin0fYugWVb/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+77m5rMiMkiRCEzWjVDNvnW6aUH2d0BPB2FsVdKGHSNXR2tP/
	YlipgSprVDSlxEoul54gX7CnQyY5qUmf90+EgK/S7dIZB3JW+JUbMBIyDb4adC9/ocQ2Rl76vzf
	qgO6NJkCxUy4A5O5JXNxQloEHNg==
X-Received: from ilto4.prod.google.com ([2002:a05:6e02:924:b0:4fe:8e18:ccb3])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:2212:b0:694:a362:4b8f with SMTP id 006d021491bc7-696979bbc34mr5451589eaf.6.1777929507943;
 Mon, 04 May 2026 14:18:27 -0700 (PDT)
Date: Mon,  4 May 2026 21:17:53 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504211813.1804997-1-coltonlewis@google.com>
Subject: [PATCH v7 00/20] ARM64 PMU Partitioning
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

After a few false starts, meeting with Will Deacon and Mark Rutland to
discuss implementation ideas, and a few more false starts, I finally
have an implementation of dynamic counter reservation that works
without disrupting host perf too much. Now the host only loses access
to the guest counters when a vCPU resides on the CPU.

The key was creating perf_pmu_resched_update, which behaves exactly
like perf_pmu_resched except it takes a callback to call in between
when the perf events are scheduled out and when they are scheduled
back in. That allows us to update the PMU's available counters when we
know they are not currently in use without needing to expose private
perf core functions and triple check they are not being called in a
way that violates existing assumptions.

Because this introduces a possibility of perf reschedule during vCPU
load, I've optimized to only do that operation if there are host
events occupying the intended guest counters at the time of the load.

The kernel command line parameter for the driver still exists, but now
only defines an upper limit of counters the guest might use rather
than taking those counters from the host permanently.

v7:

* Implement dynamic counter reservation as described above. One side
  effect is the PMUv3 driver now needs much fewer changes to enforce
  the boundary.

* Move register accesses out of fast path for non-FGT hardware. The
  performance impact was negligible and this moves bloat out of the
  fast path and allows a more reliable design with more code sharing.

* Make PMCCNTR a special case in the context swap again because trying
  to access it with PMXEVCNTR is undefined.

* Fix a bug where kvm_pmu_guest_counter_mask was using & instead of |.

* Re-expose the dedicated instruction counter to the host since it was
  decided the guest will not own it.

* Change the global armv8pmu_reserved_host_counters to
  armv8pmu_is_partitoned because it was only used in boolean checks.

* Fix typo in vcpu attribute commit so the spelling of the flag in the
  commit message matches the code.

* Rebase to v7.0-rc7

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

Colton Lewis (19):
  arm64: cpufeature: Add cpucap for HPMN0
  KVM: arm64: Reorganize PMU functions
  perf: arm_pmuv3: Generalize counter bitmasks
  perf: arm_pmuv3: Check cntr_mask before using pmccntr
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
 arch/arm64/kernel/cpufeature.c                |   8 +
 arch/arm64/kvm/Makefile                       |   2 +-
 arch/arm64/kvm/arm.c                          |   2 +
 arch/arm64/kvm/config.c                       |  41 +-
 arch/arm64/kvm/debug.c                        |  31 +-
 arch/arm64/kvm/pmu-direct.c                   | 494 ++++++++++++
 arch/arm64/kvm/pmu-emul.c                     | 674 +----------------
 arch/arm64/kvm/pmu.c                          | 701 ++++++++++++++++++
 arch/arm64/kvm/sys_regs.c                     | 250 ++++++-
 arch/arm64/tools/cpucaps                      |   1 +
 arch/arm64/tools/sysreg                       |   6 +-
 drivers/perf/arm_pmuv3.c                      | 111 ++-
 include/kvm/arm_pmu.h                         | 110 +++
 include/linux/perf/arm_pmu.h                  |   3 +
 include/linux/perf/arm_pmuv3.h                |  14 +-
 include/linux/perf_event.h                    |   3 +
 kernel/events/core.c                          |  28 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/arm64/vpmu_counter_access.c | 112 ++-
 tools/testing/selftests/kvm/lib/find_bit.c    |   1 +
 25 files changed, 1861 insertions(+), 787 deletions(-)
 create mode 100644 arch/arm64/kvm/pmu-direct.c
 create mode 100644 tools/testing/selftests/kvm/lib/find_bit.c


base-commit: 591cd656a1bf5ea94a222af5ef2ee76df029c1d2
--
2.54.0.545.g6539524ca2-goog
