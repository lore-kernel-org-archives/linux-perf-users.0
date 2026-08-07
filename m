Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EDE37BE7D
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 08:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090161; cv=none; b=T2ohMevOhcvgONgoIoCUTAj3TRdTeKgz1Ez8uqyX/PjlxQENEcgk+BRhVzBrNIKBlYJROSCayImKeYInp7ktTzhVCtBOpAAzTgbATDTKrnEwyqq5exO6mZjBLSKG8N6RH2gFPJiP2XMHwoU2B7ayM9KN0aCIOLCfRkpJ5bFrHMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090161; c=relaxed/simple;
	bh=egY5H72Bk7GME6sWwT28x5SfpRLPIhWRrm3+ROn1hro=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XoR3dL7mpTOlrUR+zvq/Z8ZfDtKyQGKaKlxlBa7PG9KfHnPQbYTkoUGLuHjnDuLgjWyVzzjGU2Ga79rVHsAE/Lw/TvZ+WkN2aF3zx3wF6VtWjbwkZX/3q5TOSqfrIfdJydAFOwhffxvW2mnXOj3rWroWlodlfXIi8Ju60VySpi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qzogLCk1; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qzogLCk1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786090148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H5fvm4vsVH0OnFXrLGEU+AZpeN2gyJyWt/x56OcEQKs=;
	b=qzogLCk1/JDoJIRk5Mb61HFrjrwylQnJGFsW60hqQ2LCCmSHmM+MLxmyTSab0bSnC2/AF8
	X/lf7soQr77FVvyg4KV+MPfgFiRmiSiv7QBanSipg7HWz8CPcoKQ4kbl1Ht3npd8SGU5Hl
	Pc3FuiuC9LTiP2GUrmXFDLHa4y0f1Eo=
From: Atish Patra <atish.patra@linux.dev>
Subject: [PATCH v9 00/20] Add Counter delegation ISA extension support
Date: Fri, 07 Aug 2026 01:08:55 -0700
Message-Id: <20260807-counter_delegation-v9-0-58658104e487@meta.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJiSdWoC/23Q22rDMAwG4Fcpvp6LJZ+UXfU9xhiOrbSGNSlJF
 jZK3n1uR0kZvvyF9EnoKiYeM0/idXcVIy95ykNfQvOyE/EU+iPLnEoWqNAoD1bG4aufefxI/Mn
 HMJd26ZCCxo5iE6Mog5eRu/x9R9/eSz7laR7Gn/uOBW7VPw7BK2W9pr32xgCCBFnE6XQ5jHkZp
 tzHfRzO4mYs+JizCsDUzlhQKklt8Camliy0FUU/Keirii6KM9SY5BlcshXFbAqq6ksWc7tF29g
 FItYtVBT3UJxyiqqKKwqSbT1ycjY0hzPPYRP8k4BYFXwRVBuwS9o4MPxPoE3wCqoCFcE3qunI6
 eCMfRLWdf0FRnigzkECAAA=
To: Will Deacon <will@kernel.org>, Atish Patra <atish.patra@linux.dev>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Ian Rogers <irogers@google.com>, 
 Rob Herring <robh@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 James Clark <james.clark@linaro.org>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org
X-Migadu-Flow: FLOW_OUT

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
event.

This series introduces a RISC-V specific event field in "CounterIDMask" in
event_fields that describes a bitmask of counters supported for a specific eventi.
This is the similar approach for few other existing properties in the event_fields
which were used by single architecture as well. The counter constraint bitmap is
passed to the perf driver via newly introduced "counterid_mask" property set in "config2".

The platform vendor have these three ways to encode/use the platform specific
events.

1. Directly in driver with appropriate constraints (discouraged due to bloating
of the driver)
2. Encode in Json with with CounterIDMask field (preferred as it is contained
within platform specific json file)
3. Directly pass counterid_mask at while invoking perf
cpu/event=<code>,counterid_mask=<mask>/

The last two patches show cases these use cases and not intended for merging.

Solution to problem #2:

The event encoding can come from the json or commandline as well.

The Qemu patches are available in upstream now.

The Linux kernel patches can be found here:
https://github.com/atishp04/linux/tree/b4/counter_delegation_v8

[1] https://github.com/riscv/riscv-indirect-csr-access
[2] https://github.com/riscv/riscv-smcdeleg-ssccfg
[3] https://www.kernel.org/doc/Documentation/devicetree/bindings/perf/riscv%2Cpmu.yaml
[4] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/ext-pmu.adoc
[5] https://lore.kernel.org/qemu-devel/20260625-marchid-v2-1-3821c351028b@gmail.com/

To: Paul Walmsley <pjw@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
To: Atish Patra <atish.patra@linux.dev>
To: Anup Patel <anup@brainfault.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
To: Ian Rogers <irogers@google.com>
To: James Clark <james.clark@linaro.org>
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org

Signed-off-by: Atish Patra <atishp@meta.com>

Changes in v9:
- Rebased on top of riscv-next with queued patches. I have still included these patches
  because riscv-next has to be updated because of the PATCH 5 which needs the helper
  macros. This series includes the other semnatic fixes pointed out by paul in v8. 
- Few more renaming/refactoring pointed by Sashiko and other reviewers.
- Added RB/TB tags.
-  Fix a panic tearing down the fixed CY/IR counters on Ssccfg hardware
   without Smcntrpmf (Reported by Yicong Yang)
- Only log "No default PMU events found" when neither event map is present.
  (Reported by sashiko-bot)
- Set sbi_v3_available inside the sbi_probe_extension() block; it could be
  set on a delegation-only system with no SBI PMU. (Yicong Yang)
- Reject attr.config2 above bit 31; it is counterid_mask, config2:0-31, and
  was silently truncated to "no constraint". (sashiko-bot)
- Drop the test only patches as most of the patches have TB tags now.
- Link to v8: https://lore.kernel.org/r/20260701-counter_delegation-v8-0-7909f863a645@meta.com

Changes in v8:
- Fixed few more issues reported by Sashiko. Remaining sashiko reviews are moot.
- Added support for Qemu ARCH ID 0x42 introduced by the qemu patch[5]
- Link to v7: https://lore.kernel.org/r/20260622-counter_delegation-v7-0-0ba2fd34614e@meta.com

Changes in v7:
- Fixed various issues pointed by Sashiko.
- Rebased on top of v7.1
- Added a separate patch to fix various memory leak issues in probe error path
- Link to v6: https://lore.kernel.org/r/20260608-counter_delegation-v6-0-285b72ed65a9@meta.com

Changes in v6:
- Reverted the file name changes as suggested by Will. Now pmu-sbi.c will continue
  to support both counter delegation and SBI PMU with different function prefixes.
- No longer depends up old upstream patch for reusing the Counter property to
  encode event to counter mapping property. It directly uses additional field in
  json event fields similar to other architectures.
- Added few test patches (not intended for upstreaming) to show case different
  possibilities of providing mapping/event encodings.
- Fixed review comments and miscellenous minor typos/fixes on v5
- Rebased on top of v7.1-rc6

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
      RISC-V: perf: fix resource cleanup on driver probe failure
      RISC-V: Add Smcsrind and Sscsrind ISA extension definition and parsing
      dt-bindings: riscv: add Smcsrind and Sscsrind ISA extension descriptions
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
      tools/perf: Add RISC-V CounterIDMask event field

Charlie Jenkins (1):
      RISC-V: perf: Skip PMU SBI extension when not implemented

Kaiwen Xue (2):
      RISC-V: Add Smcsrind and Sscsrind ISA extension CSR definitions
      RISC-V: Add Ssccfg extension CSR definition

 .../devicetree/bindings/riscv/extensions.yaml      |   63 ++
 arch/riscv/include/asm/csr.h                       |   49 +
 arch/riscv/include/asm/csr_indirect.h              |   50 +
 arch/riscv/include/asm/hwcap.h                     |    7 +
 arch/riscv/include/asm/vendorid_list.h             |    6 +
 arch/riscv/kernel/cpufeature.c                     |   27 +
 drivers/perf/Kconfig                               |   14 +-
 drivers/perf/riscv_pmu_sbi.c                       | 1155 ++++++++++++++++----
 include/linux/perf/riscv_pmu.h                     |    5 +
 .../perf/pmu-events/arch/riscv/arch-standard.json  |   10 +
 tools/perf/pmu-events/jevents.py                   |   10 +-
 11 files changed, 1182 insertions(+), 214 deletions(-)
---
base-commit: ff492e321c47df9e87251b44c1003b165142280e
change-id: 20240715-counter_delegation-628a32f8c9cc

Best regards,
-- 
Atish Patra <atishp@meta.com>

