Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0163B83FB
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 08:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895642; cv=none; b=WzUs6Qr9qPVrFYvwJ6EhwJm8uJ4EAGtlrWy+PLnzkX9/euLxG0XSg0xpXaYAqNGlxeTTGvedOySGFfXknAzdw+aVGCjdxVvQ0ulClxR/wg/pspLgtoAbVy+HCMhVwNjIx5Z5z+k47IvtFLyFYc+vkTJ9sIxVi7XgwOAQ3BkXiuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895642; c=relaxed/simple;
	bh=fLH2QKU5/UBhjVHk16EnhzlPvmFKkSlmlpirYLbRGZA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gJg+DvEWojrFFCOToeeaiYL1N0jLLWTjAWt7gUgKESGKCYZb0zIhynABW8kR7rlR0zYyF9XK9fgac6dVRaoRnwnSrVeMeoCoye6AtB7UH6Tm9IbnwW8bWVJS1Qva7hQ4yODCH0aHuE51VjD2pIxFYbmAMZZ1Ti1CIezsvZOAupc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nwhbKEcp; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nwhbKEcp"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782895638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r9s14zxC5RueySdUqmfR8l7je9r+KntR4fPObg88vbI=;
	b=nwhbKEcpL074b7XI2btKyL9bCyy0P6/LueoaR5oJ6+0OhK2qpEfwAELOGcnm/v9+tkIuyf
	+Ioxegg9tXSQSpQBvkn4MoO0FNtuN8+V25YsGKq+Jt4ZUQho4LwkbMCV6eQp8v98zZTber
	/Vv0PZl+KWYAQLD6y6uQUiLO/muwTvA=
From: Atish Patra <atish.patra@linux.dev>
Subject: [PATCH v8 00/22] Add Counter delegation ISA extension support
Date: Wed, 01 Jul 2026 01:46:48 -0700
Message-Id: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPnTRGoC/23QzWrDMAwH8FcpPs/Flj/TU99jjOHYSmNYk2JnZ
 qPk3ed0lObg419IPwndScYUMZPT4U4SlpjjPNVg3w7Ej266II2hZgIMJDNcUT9/Twumz4BfeHF
 LbacarBMwWN95T+rgLeEQfx7o+0fNY8zLnH4fOwrfqv8ccMOYMsIehZGSA6ecVjGPt3OKZc5x8
 kc/X8lmFHjOKca5bJ1RgDJqe2ekD71VvG8oYqeAaSqiKlraTgaDXAfVUORLAdZ8SZHbLUL5wVm
 LoucNRT8VzTSzTUVXBazqDWDQynXnKy7uJZidANAUTBVY72AIQmoucSes6/oHafZ/zf8BAAA=
To: Jiri Olsa <jolsa@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Namhyung Kim <namhyung@kernel.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Atish Patra <atish.patra@linux.dev>, Ian Rogers <irogers@google.com>, 
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Conor Dooley <conor@kernel.org>
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
Atish Patra (19):
      RISC-V: perf: fix resource cleanup on driver probe failure
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
      tools/perf: Add RISC-V CounterIDMask event field
      TEST(do-not-upstream): fake qemu-virt PMU events for cdeleg counter-mask testing
      TEST(do-not-upstream): fake qemu vendor JSON + mapfile entry for CounterIDMask path

Charlie Jenkins (1):
      RISC-V: perf: Skip PMU SBI extension when not implemented

Kaiwen Xue (2):
      RISC-V: Add Sxcsrind ISA extension CSR definitions
      RISC-V: Add Sscfg extension CSR definition

 .../devicetree/bindings/riscv/extensions.yaml      |   63 ++
 arch/riscv/include/asm/csr.h                       |   49 +
 arch/riscv/include/asm/csr_ind.h                   |   41 +
 arch/riscv/include/asm/hwcap.h                     |    7 +
 arch/riscv/include/asm/vendorid_list.h             |    6 +
 arch/riscv/kernel/cpufeature.c                     |   27 +
 drivers/perf/Kconfig                               |   14 +-
 drivers/perf/riscv_pmu_sbi.c                       | 1116 ++++++++++++++++----
 include/linux/perf/riscv_pmu.h                     |    5 +
 .../perf/pmu-events/arch/riscv/arch-standard.json  |   10 +
 tools/perf/pmu-events/arch/riscv/mapfile.csv       |    2 +
 .../pmu-events/arch/riscv/qemu/virt/events.json    |   26 +
 tools/perf/pmu-events/jevents.py                   |   10 +-
 13 files changed, 1167 insertions(+), 209 deletions(-)
---
base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
change-id: 20240715-counter_delegation-628a32f8c9cc

Best regards,
-- 
Atish Patra <atishp@meta.com>

