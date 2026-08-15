Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B8C31F9A5
	for <linux-perf-users@vger.kernel.org>; Sat, 15 Aug 2026 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786814855; cv=none; b=de6TKXD/8VmOlIZG/gmqWg7A+grvbUKf0DnuoqFn/Dusx3It3GvSyQ9CzlgVEl3sA/qAn4i3QM16RPPW18hSQzmqhj4aVS+k8zG7DRzy/kxCxhRq+lOxBFkEOomQ4n5uANyNUbOmv9PIv1fO4uBwGhEbBueXASgdODVHY3B5n2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786814855; c=relaxed/simple;
	bh=BT5cfBMLz4ljJRS5Hk3JROHyAarInN3gTbVUQkbqnKM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mnk+LbsTIUJsBj7MnIvyR8xCyud4HMUhq4N1lvqtylpNGq8U6e0XqmXuf1aZVfUA44M0RPp02d6hHTHKSPIqq0qiryyObm23SpTbVHsMplGwvrWkalEbEXP3T0Wp6kmbMKloz1/0rmkFK+LDVAsxrVOpU1yE+k39STkqSEEa75Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vRaw3bRp; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vRaw3bRp"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbedc1899f7so1217072a12.2
        for <linux-perf-users@vger.kernel.org>; Sat, 15 Aug 2026 10:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786814852; x=1787419652; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zRir0jKcwf5JyTfl0WhTdOqzrrIy+7c+DcZ//dpq500=;
        b=vRaw3bRpPhKkfUQJJtKdS/tIYtHOtcc2MQ5aJG1ZbdGbH1OK001gFbMISol38jCGOT
         oqHuizhBEZNw2afisnv6DH02cmNcDW7jlxFpcjA5D0HLLEAonXOGzVS2DwbgnhWkh6BH
         HEvWRECHer4vD8KtVLu5eu8JcygyFhIiF7Qu7c0UVMJis72g3jbtNibeSWvzPgmpLYMD
         bDFHAACbz2cHAZfYixZbcwuOjOuS4UImDNHYKlwyT7C6f3xkHHVSrjFmFliR1DoTPHFx
         hHJH8119Nz+z0HLOgddGk8/Awm0FkFd1aWBbmSuLjFhPsTxELUtU3XMF/7wdw+z6wFYN
         XPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786814852; x=1787419652;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zRir0jKcwf5JyTfl0WhTdOqzrrIy+7c+DcZ//dpq500=;
        b=Zcu6paX0U1zMda62JIJi1rO3gLDLRUcINlptE/P+J7IfF4nxz/kobH5UijRm7NEwHz
         iT7JocVowdqjVLtp+m2B7jbLCrP57jfoinDckAkU535VvoBT98tvcDo6Q+kYsSypHa5+
         6eVpBlwn9JEufIW4o43JRxaqDoawVthQR04zwatEOOxDgP0ZDKSaq7hUcV4MagopUn+4
         kzzuKDrAA7Gjs92LNLM3MzT3IrfVFCqKoadVl3xuuLKLCoVxUTb0be9F+D/GW57CzY8S
         sCM4rGVzbgltye8vaom8aaklsyeppzNrDCila5WhlIsc7DwD+XZFGc9Gxpy3GwIiMTQj
         Xm0Q==
X-Forwarded-Encrypted: i=1; AHgh+RoQHW02OgwQcoGXSX2g8jmiWRiTrTwL+oIBocc/tFdt1IC+l5e9GEoqAu8azORQeLKs/RdLh/C1KXVOTxBihnNe@vger.kernel.org
X-Gm-Message-State: AOJu0YzjTMwf2RYVwrgT8Oh9WNLnphX7kgq1vZI77Q5SCKMha9s+PYXr
	rj3Y1zEtxcRvWL4zq+6DaJZdyvOmjq6bhkUvcgVfm31buJltNTndmsDDqLUc9MByfIyJyuClwj5
	J7smQ2lGKMw==
X-Received: from dlbpy7.prod.google.com ([2002:a05:7022:e987:b0:13b:92c7:dcf7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f92:b0:3cc:9618:f51a
 with SMTP id adf61e73a8af0-3cc9619062cmr2665890637.8.1786814852070; Sat, 15
 Aug 2026 10:27:32 -0700 (PDT)
Date: Sat, 15 Aug 2026 10:27:09 -0700
In-Reply-To: <20260815082048.4043217-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260815082048.4043217-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260815172712.50119-1-irogers@google.com>
Subject: [PATCH v13 0/3] perf: Add Raspberry Pi AXI PMU driver
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, florian.fainelli@broadcom.com, 
	linux-perf-users@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	pbrobinson@gmail.com
Content-Type: text/plain; charset="UTF-8"

Motivation & Background
==============================
Currently, Linux lacks a standard perf-API compatible driver for the
Broadcom AXI performance counter blocks on Raspberry Pi platforms. Prior
out-of-tree vendor solutions relied on custom debugfs nodes and ad-hoc
kthreads, preventing integration with standard Linux perf tooling (`perf stat`,
`perf list`, etc.).

This driver implements standard `struct pmu` hardware uncore callbacks
under `drivers/perf/`, exposing human-readable sysfs event aliases, unit
scaling (`Bytes`), and bus filtering directly to user space.

Key Architectural Improvements & Features
==============================
1. Standard Linux Perf Integration:
   - Exposes uncore AXI interconnect events via `/sys/bus/event_source/devices/rpi_axi_pmu/`.
   - Supports event sampling and hardware counter accumulation (`local64_add`),
     automatically managing 31-bit hardware counter wraparound across high-bandwidth
     interconnect transfers.

2. CPU Hotplug Support (`cpuhp`):
   - Registers dynamic CPU hotplug notifiers (`CPUHP_AP_ONLINE_DYN`).
   - Automatically migrates PMU context (`perf_pmu_migrate_context`) to an online
     CPU core when a designated CPU goes offline, safely guarding memory teardown boundaries.

3. Hybrid Memory-Mapped & Mailbox Work Queue Architecture:
   - System Monitor (MMIO): Performs fast atomic-safe memory reads (~15ns)
     directly mapped over ARM physical memory space (`MON_SYSTEM`).
   - VPU Monitor (Mailbox IPC): For Broadcom BCM2835-BCM2711 platforms (RPi 1-4),
     VideoCore VPU monitor IPC calls are offloaded to process context via a dedicated
     workqueue (`vpu_work`) and serialized under `vpu_mutex`. This avoids atomic
     sleeps or blocking in timer/interrupt context.

4. SoC Generation Support:
   - Patch 1 documents device bindings for Broadcom.
   - Patch 2 adds core driver support for Broadcom BCM2835-BCM2711 (RPi 1-4).
   - Patch 3 expands support for Broadcom BCM2712 (Raspberry Pi 5), adding PCIe RP1
     Southbridge links, HEVC decoder, HVS display engine, and Cortex-A76 DSU L3
     interconnect monitoring dynamically via native MMIO readouts.

Hardware Validation
==============================
The driver has been rigorously validated on real hardware:
- Raspberry Pi 400 (BCM2711): Validated System L2, ARM CPU, and VideoCore
  VPU firmware mailbox IPC performance counters organically spanning
  multi-slice multiplexing boundaries.
- Raspberry Pi 5 (BCM2712): Validated live byte throughput across HVS
  display refresh cycles, Cortex-A76 DSU L3 interconnect memory traffic,
  and PCIe RP1 Southbridge transfers independently configuring `bcm2712_`
  filters.

Changes since v12
==============================
- Schema Enforcement: Added an `allOf` / `if` block to
  `brcm,bcm2835-axiperf.yaml` to mandate the `firmware` property when
  compiling dtbs against older silicon (`brcm,bcm2835-axiperf` and
  `brcm,bcm2711-axiperf`). Validated the documentation example to
  securely meet this constraint.
- Sysfs Arrays: Rehydrated the missing dynamic PMU Sysfs string
  definitions (`PMU_EVENT_ATTR_STRING`) and memory pointers for the
  BCM2712 CPU L2 and Master ID filtered events, ensuring they are
  cleanly exported to Userspace.
- Whitespace formatting: Purged excess consecutive vertical blank
  lines inadvertently dropped into the sysfs definitions across
  boundaries in Patch 2 and Patch 3.
- Documentation nits: Rectified and clarified a misleading comment
  regarding synchronous reads for the BCM2712 VPU explicitly isolated
  from native runtime monitoring.

Ian Rogers (3):
  dt-bindings: perf: Add Broadcom Raspberry Pi AXI PMU definition
  perf: Add Raspberry Pi BCM2835 AXI PMU driver
  perf: Add Raspberry Pi 5 (BCM2712) AXI PMU support

 .../bindings/perf/brcm,bcm2835-axiperf.yaml   |   77 +
 drivers/perf/rpi_axi_pmu.c                    | 2903 +++++++++++++++++
 2 files changed, 2980 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
 create mode 100644 drivers/perf/rpi_axi_pmu.c

-- 
2.55.0.691.gc56d675ccc-goog

