Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7665518FC84
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743104174; cv=none; b=juihhJzYzOVwhUy1Oh8EE25VkRzvePR7j+UanVSQuYe1TuZbPXwpL92AF+18s83G+t2Rvp9yVR2QqS4nc4kUe2iqFVP0kTl+xoZsBqu6e76tS3a0HtGXT7NxvKWIckY3E4tX0lnUG0FWONFFL4el2k/Xlc+w6rxO3Spe8drIIrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743104174; c=relaxed/simple;
	bh=Bu9SBXLCsqxc/K2zhuGDke0dHkcDbp3VE+p2w+FdrN4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c6Q3eS+CszlXaCpufW/572wrruqq6LxqepIFWqFferpyIceeJhmgtp4XXvbsx87gCcE9HUIE52mUzdv7Fvav9xgGG8f4CwZ4d0zks+MFWMUl8Ym0LWhtQsLKAsmcp5TMe8f1idGyDp9KophG/VDjYOONQ9c/IChOdMIGC4kv4zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZIZ4kYhY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZIZ4kYhY"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2260c915749so21886585ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 12:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1743104171; x=1743708971; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jAY+Cg5HQZMci06K15j1dCXU1uO31X3ZHDkdY1vsxDU=;
        b=ZIZ4kYhYI4QcCSg+mLhGblZcnzlIsOr0ECh1RTLPVhuOD6LOu61dkphdl4i3py+AIO
         hJssVpAFVWqWrpT4pfuPQElg0SwHq1WFWyOfTdqOLDCf8MXQnTBHVOuVBP68/NO5d8E7
         RzENl40MST/c/PXuuh/XcvjcICaY0IB8vcczgvR2opKIjcPzovp8OV8kv2CfW+Qbkfn/
         rZq1nIMat4fntbyBSFej6uRpSH8JXl43ZSnAppQqSPVSkg6rTcMIPS0NCkRsLy67hx9x
         2TfbuNrUVHLwt+zxhrmGfD8LQ5lcSiS1MqabnyFD0pgNW27/KfqtThk5mLzRsxsrJypv
         5axw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743104171; x=1743708971;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAY+Cg5HQZMci06K15j1dCXU1uO31X3ZHDkdY1vsxDU=;
        b=Jxso9PoeAPU6z4zYpH7DJXiOW63Pf9WgRm5xzGCJXjX52GAS5rGBh6xK2DbiXQRmtj
         7T9rK5erJKUZqOjdET7x/qmUYkiu5NZQVOP6k2ljPLZOGQKrxFeTgJoV+KWl9VAAIc9d
         uBEpGHiO27alcnf+aNXTuFy3kw9dJoUUb22fhUFTwxQQzlTfSJ2NrMcRaktp/4QqqCYy
         O9mJrWZQNbHx+wBQ515yxrdFzahE7Ownqt7efGOMimdT2++5YgjlCl2U3tyJVljxbVxq
         1YdLVkMDo3owsWhYhRCvV2A9UVpl+PhNNLHyKZrtyTM8/htPs7/kHfDOdsprTdu7ALEA
         YaJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwS/6bhw2xCX1lvjWdO5IKLsHjXGl+lm+TFvojiRNrLCva1pAYZAiPctzN7oDczS4y8v8tTUNBGr9DSG3/4+ta@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/XZB5n+ZBN4B09vuIsJUtikgZK7V/jpXyTKMwnFogU768DIUU
	qGezNn6RaNbWvR2ZzvD7Yb2XA0mPDjaqaLab/00KShIPenS5gV3QgLpOTVSlL08=
X-Gm-Gg: ASbGncvAg/St+U5tAEk7dasfrjhpBAqqVJSgOASuLgyxztd+8l0SEINb6RRtReraZku
	V1s3QiKH0ki46DA8MlPVI52Psl59HlbHThrpWbVsZEcGFCMsVY02Cj+TQkN9kjEsf05vKzFkMs3
	aQ7DxXTTRaoqQUYyvJRDD09uL3MZSCB9RI+1D9zqUQiRmdukBuIKcOMJpW28tkx84zxFPGhZOP+
	Ey9FjM+TC0TN4TFetojVNlk7HenxxwTtE7CeVcOenZTiHaMWVhsEhRm/npk4OMqRKYln6eSWG//
	dqOHbC7pJvpi8823Mg5h28RFoxXHJgAdcDR7wUnJTp/GL/lagA60PeNs6g==
X-Google-Smtp-Source: AGHT+IG3jSHF5jFLlVLycbj1Jf3RB9Ho77/qkuBJy49ZMZVDs34odX6i7mszuOua7lZd9PrWcxgbeQ==
X-Received: by 2002:a17:90b:514b:b0:2ee:dd9b:e402 with SMTP id 98e67ed59e1d1-303a7d6a9a7mr8534491a91.12.1743104171302;
        Thu, 27 Mar 2025 12:36:11 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039f6b638csm2624220a91.44.2025.03.27.12.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 12:36:11 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v5 00/21] Add Counter delegation ISA extension support
Date: Thu, 27 Mar 2025 12:35:41 -0700
Message-Id: <20250327-counter_delegation-v5-0-1ee538468d1b@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI2o5WcC/23QwWoEIQwG4FdZPNfFRB3dPfU9SimOZnaEdlx0K
 i3LvHudLaWlePxD8iXkxgrlSIWdDzeWqcYS09KCfjgwP7vlQjyGlhkKVMKA5j69Lyvll0CvdHF
 ra+cDWidxsv7kPWuD10xT/LijT88tz7GsKX/ed1TYq98cghFCG2mP0igFCBx4E8t8fcyxphIXf
 /Tpje1GxZ85LQBU74yKXHA7OqN8GK2GsaPIPwqariKbMih7UsEQDEF3FPWroOi+pKr9Fqn95Kw
 lOcI/Zdu2LwUgSlt7AQAA
X-Change-ID: 20240715-counter_delegation-628a32f8c9cc
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atishp@atishpatra.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, weilin.wang@intel.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 Atish Patra <atishp@rivosinc.com>, Kaiwen Xue <kaiwenx@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

This series adds the counter delegation extension support. It is based on
very early PoC work done by Kevin Xue and mostly rewritten after that.
The counter delegation ISA extension(Smcdeleg/Ssccfg) actually depends
on multiple ISA extensions.

1. S[m|s]csrind : The indirect CSR extension[1] which defines additional
   5 ([M|S|VS]IREG2-[M|S|VS]IREG6) register to address size limitation of
   RISC-V CSR address space.
2. Smstateen: The stateen bit[60] controls the access to the registers
   indirectly via the above indirect registers.
3. Smcdeleg/Ssccfg: The counter delegation extensions[2]

The counter delegation extension allows Supervisor mode to program the
hpmevent and hpmcounters directly without needing the assistance from the
M-mode via SBI calls. This results in a faster perf profiling and very
few traps. This extension also introduces a scountinhibit CSR which allows
to stop/start any counter directly from the S-mode. As the counter
delegation extension potentially can have more than 100 CSRs, the specification
leverages the indirect CSR extension to save the precious CSR address range.

Due to the dependency of these extensions, the following extensions must be
enabled in qemu to use the counter delegation feature in S-mode.

"smstateen=true,sscofpmf=true,ssccfg=true,smcdeleg=true,smcsrind=true,sscsrind=true"
or Virt machine users can just "max" cpu instead.

When we access the counters directly in S-mode, we also need to solve the
following problems.

1. Event to counter mapping
2. Event encoding discovery

The RISC-V ISA doesn't define any standard either for event encoding or the
event to counter mapping rules. Until now, the SBI PMU implementation relies
on device tree binding[3] to discover the event to counter mapping in RISC-V
platform in the firmware. The SBI PMU specification[4] defines event encoding
for standard perf events as well. Thus, the kernel can query the appropriate
counter for an given event from the firmware.

However, the kernel doesn't need any firmware interaction for hardware
counters if counter delegation is available in the hardware. Thus, the driver
needs to discover the above mappings/encodings by itself without any assistance
from firmware.

Solution to Problem #1:
This patch series solves the above problem #1 by extending the perf tool in a
way so that event json file can specify the counter constraints of each event
and that can be passed to the driver to choose the best counter for a given
event. The perf stat metric series[5] from Weilin already extend the perf tool
to parse "Counter" property to specify the hardware counter restriction.
As that series was not revised in a while, I have rebased it and included in
this series. I can only include the necessary parts from that patch required
for this series if required.

This series extends that support by converting comma separated string to a
bitmap. The counter constraint bitmap is passed to the perf driver via
newly introduced "counterid_mask" property set in "config2".
However, it results in the following event string which has repeated information
about the counters both in list and bitmask format. I am not sure how I can pass
the list information to the driver directly. That's why I added a
counterid_mask property.

Additionaly, the PATCH5 in [5] parses the bitmask information from the
string and puts it into the metric group structure. We can just convert it in
python easily and pass it to the metric group instead. The PATCH19 does exactly
that and sets the counterid_mask property.

@Weilin @Ian : Please let me know if there is a better way to solve the problem I
described.

Due to the new counterid_mask property, the layout in empty-pmu-events.c got
changed which is patched in PATCH 21 based on existing script.

Possible solutions to Problem #2:

1. Extend the PMU DT parsing support to kernel as well. However, that requires
additional support in ACPI based system. It also needs more infrastructure in
the virtualization as well.

2. Rename perf legacy events to riscv specific names. This will require users to
use perf differently than other ISAs which is not ideal.

3. Define a architecture specific override function for legacy events. Earlier
RFC version did that but it is not preferred as arch specific behavior in perf
tool has other ramifications on the tests.

4. Ian graciously helped and sent a generic fix[6] for #3 that prefers json
over legacy encoding. Unfortunately, it had some regressions and the discussions
are ongoing if it is a viable solution.

5. Specify the encodings in the driver. There were earlier concerns of managing
these in the driver as these encodings are vendor specific in absence of an ISA
guidelines. However, we also need to support counter virtualization and legacy
event users (without perf tool) as described in [7]. That's why, this series
adapts this solution similar to other ISAs. The vendors can define their pmu
event encoding and event to counter mapping in the driver.

Note: This solution is still compatible with solution #4 by Ian. It gives vendors
flexibility to define legacy event encoding in either the driver or json file
if Ian's series [6] is merged. If we can get rid of the legacy events in the
future, we can just rely on the json encodings. I have not added a json file for
qemu as I have not included Ian's patches in this series. But I have verified them
with a virt machine specific json file.

The Qemu patches are available in upstream now.

The Linux kernel patches can be found here:
https://github.com/atishp04/linux/tree/b4/counter_delegation_v4

[1] https://github.com/riscv/riscv-indirect-csr-access
[2] https://github.com/riscv/riscv-smcdeleg-ssccfg
[3] https://www.kernel.org/doc/Documentation/devicetree/bindings/perf/riscv%2Cpmu.yaml
[4] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/ext-pmu.adoc
[5] https://lore.kernel.org/lkml/20240412210756.309828-1-weilin.wang@intel.com/
[6] https://lore.kernel.org/lkml/20250109222109.567031-1-irogers@google.com/
[7] https://lore.kernel.org/lkml/20241026121758.143259-1-irogers@google.com/T/#m653a6b98919a365a361a698032502bd26af9f6ba

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
Changes in v5:
- Fixed dt_binding_check errors.
- Added the ISA extension dependancy for counter delegation extensions. 
- Replaced the boolean variables with static key conditional check required at boot time.
- Miscellaneous minor code restructuring. 
- Link to v4: https://lore.kernel.org/r/20250205-counter_delegation-v4-0-835cfa88e3b1@rivosinc.com

Changes in v4:
- Added ISA dependencies as per dt schema instead of description.
- Fixed few compilation issues due to patch reordering in v3.
- Link to v3: https://lore.kernel.org/r/20250127-counter_delegation-v3-0-64894d7e16d5@rivosinc.com

Changes in v3:
- Fixed the dtb binding check failures.
- Inlcuded the fix reported by Rajnesh Kanwal for guest counter overflow.
- Rearranged the overflow handling more efficiently for better modularity.
- Link to v2: https://lore.kernel.org/r/20250114-counter_delegation-v2-0-8ba74cdb851b@rivosinc.com

Changes in v2:
- Dropped architecture specific overrides for event encoding.
- Dropped hwprobe bits.
- Added a vendor specific event encoding table to support vendor specific event
  encoding and counter mapping.
- Fixed few bugs and cleanup.
- Link to v1: https://lore.kernel.org/r/20240217005738.3744121-1-atishp@rivosinc.com

---
Atish Patra (17):
      RISC-V: Add Sxcsrind ISA extension definition and parsing
      dt-bindings: riscv: add Sxcsrind ISA extension description
      RISC-V: Define indirect CSR access helpers
      RISC-V: Add Smcntrpmf extension parsing
      dt-bindings: riscv: add Smcntrpmf ISA extension description
      RISC-V: Add Ssccfg/Smcdeleg ISA extension definition and parsing
      dt-bindings: riscv: add Counter delegation ISA extensions description
      RISC-V: perf: Restructure the SBI PMU code
      RISC-V: perf: Modify the counter discovery mechanism
      RISC-V: perf: Add a mechanism to defined legacy event encoding
      RISC-V: perf: Implement supervisor counter delegation support
      RISC-V: perf: Use config2/vendor table for event to counter mapping
      RISC-V: perf: Add legacy event encodings via sysfs
      RISC-V: perf: Add Qemu virt machine events
      tools/perf: Support event code for arch standard events
      tools/perf: Pass the Counter constraint values in the pmu events
      Sync empty-pmu-events.c with autogenerated one

Charlie Jenkins (1):
      RISC-V: perf: Skip PMU SBI extension when not implemented

Kaiwen Xue (2):
      RISC-V: Add Sxcsrind ISA extension CSR definitions
      RISC-V: Add Sscfg extension CSR definition

Weilin Wang (1):
      perf pmu-events: Add functions in jevent.py to parse counter and event info for hardware aware grouping

 .../devicetree/bindings/riscv/extensions.yaml      |  67 ++
 MAINTAINERS                                        |   4 +-
 arch/riscv/include/asm/csr.h                       |  57 ++
 arch/riscv/include/asm/csr_ind.h                   |  42 +
 arch/riscv/include/asm/hwcap.h                     |   8 +
 arch/riscv/include/asm/kvm_vcpu_pmu.h              |   4 +-
 arch/riscv/include/asm/kvm_vcpu_sbi.h              |   2 +-
 arch/riscv/include/asm/vendorid_list.h             |   4 +
 arch/riscv/kernel/cpufeature.c                     |  27 +
 arch/riscv/kvm/Makefile                            |   4 +-
 arch/riscv/kvm/vcpu_sbi.c                          |   2 +-
 drivers/perf/Kconfig                               |  16 +-
 drivers/perf/Makefile                              |   4 +-
 drivers/perf/{riscv_pmu.c => riscv_pmu_common.c}   |   0
 drivers/perf/{riscv_pmu_sbi.c => riscv_pmu_dev.c}  | 982 +++++++++++++++++----
 include/linux/perf/riscv_pmu.h                     |  26 +-
 .../perf/pmu-events/arch/riscv/arch-standard.json  |  10 +
 tools/perf/pmu-events/empty-pmu-events.c           | 299 ++++---
 tools/perf/pmu-events/jevents.py                   | 218 ++++-
 tools/perf/pmu-events/pmu-events.h                 |  32 +-
 20 files changed, 1490 insertions(+), 318 deletions(-)
---
base-commit: 74e48c9286409128a3dccd0efd4b83b3f9ef95fd
change-id: 20240715-counter_delegation-628a32f8c9cc
--
Regards,
Atish patra

