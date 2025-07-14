Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B85A246BBE
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 22:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533972; cv=none; b=OzTN+JIAEXqzb+QDqyWBOx8tHfRmYa4D0rIhg7vxISkOsRvZO2ppaq5DcVsJWfOy5mJpMmb9f0hnURaS22M38j8+vKROj1AUTdSN+7BGZ56VRovf6fA/uBMLGLxQXoDWfxFtyo3Nzf7jmBmhZ2C4z/GFavJbHN+MgvBKbkgj9wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533972; c=relaxed/simple;
	bh=mwEWYUb49kiYyzFjd73AenIm5V7+fVTN/TygHGRLTQc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mEbS1cVSueWb3wSzQQxm/9UnwB3kpHNESiWnmchQYD+hHWf0aalQFRksuBSeY2rafdyKioj2DTC2xbjZHEJiKMvH9yAO4j2x3Zc4/TAITY6dyBwL10HXnKeszfxJaPuFBr5Ke0aTIZvjF8DVG7LusUbvxG+yxtFPg10BurBa9XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fwIbDpJo; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fwIbDpJo"
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-40cfdde66b8so1505212b6e.1
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 15:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752533970; x=1753138770; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I/fxMTUCeZF4CZ7kst6++ES1PJGZgoz5VeCqTS2km0k=;
        b=fwIbDpJo5+2x9y0hjKD7yXjoh4GO5y7erNqzDw2wPgJUTQrLg0CeOXHaV/j9tumlvq
         G3Df83bjBN4yjR87Egt7ZcrWlgCIs0f43JJ6ktuSSeBc+ja00TERCeGz8xRvAydJ1h/p
         Zab+KICoiUtE6J1EnkqjoxjjnFEEQIl6h+Z9TIGwXEtgX+uKzwbPqdfs61TyTC97SJls
         5XzcDmO6qJ40iQGZPixgjSX0kBgjhUIQUmYyWgIcuKVqlzKIAQDf8shT5bx4klzbfoSP
         tql5HDggSJr+6qCzhf2iDXTYBTuhYKqZNoWyDkA9CMwbA6JSdi6DWzhoKnO1ZPWBVnLz
         UsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752533970; x=1753138770;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/fxMTUCeZF4CZ7kst6++ES1PJGZgoz5VeCqTS2km0k=;
        b=t9EVPqjMgpuntdgKGn0to9G8s1rrny2HCIrh8c4usnBYgOFj0ptW1ZE52XBn84mTtj
         XxGUhmNVrE3yC9rk2cObEjyRLQAu4xi6Y5GVcNWDz9XcoaB4nBfhGCR9ou8r5YvURkUn
         GM3jPkuh3BMM2Pqg1utKmSzfRrbAzJuuJdoCmpib6xdfUaZ6GDiDKjCefkfFMVs3I/xK
         /wde/AOEeomtZ43zqi8fZH3bh9aXeIFqe12RxOC0+6Nwm1zAgWR94khRe5FxdihzJAa1
         x5c3QuvNQFMTsOSBqn9BpfzM5ofwJtqODjue2xHV3nl7R9DE/f0+J5weJWTDJ/I+UG3m
         Esnw==
X-Forwarded-Encrypted: i=1; AJvYcCWyDPoHihlh6C4Fm/6TPvwDViM99QpApWp+20wi/gwr+BTZ71KxqSH6OoH8rTXC/B9k0TIQQeqRM9OusBWFHozJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyuM3jeFemk+enQ7WfYxtWtmiMqVwQwKcuVah2qZsBZbPiBSIUC
	2Wf5qGGwcnVy+lfZ+5zXc29um+HYmanlgmIkPDahds1ciW5kb92H4OHHzG3gfwCqroAHwcGJ0L3
	V1B/LnoKwvdPzjYszu9QzhG7Eaw==
X-Google-Smtp-Source: AGHT+IGHw0Ly0MiuefKQ04+OUmZEq578qloRdUwfTY7soEVZIiwrXeZ5MJnigSkxKeUiTfmWeKo1UFrGGTsjsgNFBg==
X-Received: from oibkd10.prod.google.com ([2002:a05:6808:470a:b0:40b:1afb:91ee])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1812:b0:404:2960:9b4d with SMTP id 5614622812f47-41511618b0amr8813197b6e.25.1752533970287;
 Mon, 14 Jul 2025 15:59:30 -0700 (PDT)
Date: Mon, 14 Jul 2025 22:58:54 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714225917.1396543-1-coltonlewis@google.com>
Subject: [PATCH v4 00/23] ARM64 PMU Partitioning
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

This series creates a new PMU scheme on ARM, a partitioned PMU that
allows reserving a subset of counters for more direct guest access,
significantly reducing overhead. More details, including performance
benchmarks, can be read in the v1 cover letter linked below.

v4:

* Apply Mark Brown's non-UNDEF FGT control commit to the PMU FGT
  controls and calculate those controls with the others in
  kvm_calculate_traps()

* Introduce lazy context swaps for guests that only turns on for
  guests that have enabled partitioning and accessed PMU registers.

* Rename pmu-part.c to pmu-direct.c because future features might
  achieve direct PMU access without partitioning.

* Better explain certain commits, such as why the untrapped registers
  are safe to untrap.

* Reduce the PMU include cleanup down to only what is still necessary
  and explain why.

v3:
https://lore.kernel.org/kvm/20250626200459.1153955-1-coltonlewis@google.com/

v2:
https://lore.kernel.org/kvm/20250620221326.1261128-1-coltonlewis@google.com/

v1:
https://lore.kernel.org/kvm/20250602192702.2125115-1-coltonlewis@google.com/

Colton Lewis (21):
  arm64: cpufeature: Add cpucap for HPMN0
  KVM: arm64: Reorganize PMU functions
  perf: arm_pmuv3: Introduce method to partition the PMU
  perf: arm_pmuv3: Generalize counter bitmasks
  perf: arm_pmuv3: Keep out of guest counter partition
  KVM: arm64: Account for partitioning in kvm_pmu_get_max_counters()
  KVM: arm64: Set up FGT for Partitioned PMU
  KVM: arm64: Writethrough trapped PMEVTYPER register
  KVM: arm64: Use physical PMSELR for PMXEVTYPER if partitioned
  KVM: arm64: Writethrough trapped PMOVS register
  KVM: arm64: Write fast path PMU register handlers
  KVM: arm64: Setup MDCR_EL2 to handle a partitioned PMU
  KVM: arm64: Account for partitioning in PMCR_EL0 access
  KVM: arm64: Context swap Partitioned PMU guest registers
  KVM: arm64: Enforce PMU event filter at vcpu_load()
  KVM: arm64: Extract enum debug_owner to enum vcpu_register_owner
  KVM: arm64: Implement lazy PMU context swaps
  perf: arm_pmuv3: Handle IRQs for Partitioned PMU guest counters
  KVM: arm64: Inject recorded guest interrupts
  KVM: arm64: Add ioctl to partition the PMU when supported
  KVM: arm64: selftests: Add test case for partitioned PMU

Marc Zyngier (1):
  KVM: arm64: Reorganize PMU includes

Mark Brown (1):
  KVM: arm64: Introduce non-UNDEF FGT control

 Documentation/virt/kvm/api.rst                |  21 +
 arch/arm/include/asm/arm_pmuv3.h              |  38 +
 arch/arm64/include/asm/arm_pmuv3.h            |  61 +-
 arch/arm64/include/asm/kvm_host.h             |  34 +-
 arch/arm64/include/asm/kvm_pmu.h              | 123 +++
 arch/arm64/include/asm/kvm_types.h            |   7 +-
 arch/arm64/kernel/cpufeature.c                |   8 +
 arch/arm64/kvm/Makefile                       |   2 +-
 arch/arm64/kvm/arm.c                          |  22 +
 arch/arm64/kvm/debug.c                        |  33 +-
 arch/arm64/kvm/hyp/include/hyp/debug-sr.h     |   6 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h       | 181 ++++-
 arch/arm64/kvm/pmu-direct.c                   | 395 ++++++++++
 arch/arm64/kvm/pmu-emul.c                     | 674 +---------------
 arch/arm64/kvm/pmu.c                          | 725 ++++++++++++++++++
 arch/arm64/kvm/sys_regs.c                     | 137 +++-
 arch/arm64/tools/cpucaps                      |   1 +
 arch/arm64/tools/sysreg                       |   6 +-
 drivers/perf/arm_pmuv3.c                      | 128 +++-
 include/linux/perf/arm_pmu.h                  |   1 +
 include/linux/perf/arm_pmuv3.h                |  14 +-
 include/uapi/linux/kvm.h                      |   4 +
 tools/include/uapi/linux/kvm.h                |   2 +
 .../selftests/kvm/arm64/vpmu_counter_access.c |  62 +-
 24 files changed, 1910 insertions(+), 775 deletions(-)
 create mode 100644 arch/arm64/kvm/pmu-direct.c


base-commit: 79150772457f4d45e38b842d786240c36bb1f97f
--
2.50.0.727.gbf7dc18ff4-goog
