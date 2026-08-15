Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BCE29898F
	for <linux-perf-users@vger.kernel.org>; Sat, 15 Aug 2026 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786782054; cv=none; b=Yg+mTvrjdDuqlvtapFIyktxvJhovAyRhfPF6pZ4sAzEf3fiEb6dKUoMxH3KO8wxMhpcaA5pW36LPwf8CY1aM4deDlM9NQjAH2KZZd3EGXnKurZOWLGqJhF7BbQPyjZqgharmuMfmLsv82LrlxG+EaR4kDfFI4wIb3+ByKZbh1lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786782054; c=relaxed/simple;
	bh=joZPwUMBZq1OY427gZuemf1gCy+iSzbkz3Hq1yQr0Gk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lr//I1xJ1uyBqfDfEBRWrDXelFZvUmim/GoCzGU3SIh5ga4tr88xEMbdBHlTj1/wWJmACzEPv+A6cUNRMI952zE35oxo6Xzppuq+/dvNPweWCb3wVwDc2QcFzp+Ois3rnOY9y1jDMdvpiWkn+1tGZOT9tL65QcSxeY23KJMBHIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jFudVHjw; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jFudVHjw"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cca3673560so28269895ad.1
        for <linux-perf-users@vger.kernel.org>; Sat, 15 Aug 2026 01:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786782052; x=1787386852; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OdsGJg3/bnI8gejy/gpQo+aRW64eJvTmzTGE3VoGfbc=;
        b=jFudVHjwBNZtFcgJ9WQ8RrN/lQuo4UFG4q6g2bw8jOK64DN4Kho3YtdDzwn/TGbZks
         L5cMBqrAOfqbyzPULxkgESPOfd5Ln88GWBfI/QLFurv/PJ+5ulQykUrsb+VrSRbasC0P
         CviiqTZe14ZaWzg3oqtTdVtZaYAcp6wuasKKS9ikK22UzGC0TTf/vSWz9oEhlllM+ybT
         iVPLLWo529gZCwtS+SZdgYC4FoR4yod3YRE7mOXBki0Q5l9Yo9r27aWcvGZkfB9lClQI
         /DZfeNzAn/WXpoXf7747GWROjlVH6mjP/WgDmUN63XluunUCivoNqglG+U+Ux3rnbDhh
         9a9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786782052; x=1787386852;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OdsGJg3/bnI8gejy/gpQo+aRW64eJvTmzTGE3VoGfbc=;
        b=YSCNadh5/xfEn3FalVDCGb+rZNORPHW8zYQSzLTnVeLkvmiWNoptQzCQqfF5HUjDFf
         HvkUHwRAigq9FOFjL5eGY6A+o0iLCfobBliaoEQJ0Ve2qF2PZ4BABc5L0/mlQxBXzOH1
         DaXeCRwhTpHhCUERuc3VlKbrZX+9BZcbr9/7+ZuE+UthRPLsy99NucfGlpM0u531TSOp
         8O4kz8yukuJE68vljF2LIrMF1hiu4TVWPyDaD5uqLBH/fLtt1PxZzB+37cPgy2JqcgYf
         zp1QXY03kU/UWF/UWWd8+gQP4rgC+gPTnXj8SgKE/CwmGw03WGKWHw3PLjjG6A6OzPat
         anGw==
X-Forwarded-Encrypted: i=1; AHgh+RpCFvv2blmHjrejhuvCWX92HF37SR5p5UFCS1AyS3PdwHTJajLvY/Im0W7w7Kyc3++mPVJ5HZr+h1t7ZJDBDEvG@vger.kernel.org
X-Gm-Message-State: AOJu0YxOhSy1YW4cuDWCwg0wOlwujEqZb8BNSeYZt1FdN1TsNdmkmPmm
	MNnRc95S6Q2+P2AMgcZ6O47Ck9bcsoMQ9DDdOQnZP9CA0HP4NPU3SuzI46dlqrXA3fd4GYanFW1
	khEHZYyENLg==
X-Received: from dybmx7.prod.google.com ([2002:a05:7300:d407:b0:315:3174:2b9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:26c7:b0:2ba:6518:a6d4
 with SMTP id d9443c01a7336-2d3b0cb5ceemr140411845ad.20.1786782051879; Sat, 15
 Aug 2026 01:20:51 -0700 (PDT)
Date: Sat, 15 Aug 2026 01:20:45 -0700
In-Reply-To: <cover.1691900000.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1691900000.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260815082048.4043217-1-irogers@google.com>
Subject: [PATCH v12 0/3] perf: Add Raspberry Pi AXI PMU driver
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

Changes since v11
==============================
- Decoupled sysfs attribute groups into distinct bcm2835
  (`rpi_axi_pmu_bcm2835_attr_groups`) and BCM2712
  (`rpi_axi_pmu_bcm2712_attr_groups`) arrays dynamically assigned
  during probe based on `.chip`. This officially completely
  eradicates the runtime penalty of scraping string prefixes in
  `.is_visible`.
- Discovered and mitigated a CPU hotplug TOCTOU race vulnerability
  during `rpi_axi_pmu__init` initialization boundaries by introducing
  precise `cpus_read_lock()` atomic block wrapping around the pmu
  registration logic.
- Resolved transient probe dependencies by returning -EPROBE_DEFER
  natively when the mailbox firmware surface has not yet booted,
  preventing silent MMIO fallback.
- Addressed multiple stylistic and naming feedback nits (renamed
  variables using 'pitch' to 'stride', replaced invalid leading
  underscores in function prototypes, and formally introduced the
  MODULE_AUTHOR tag).
- Maintained strict patch separation between BCM2835 Mailbox proxy
  interfaces and BCM2712 native MMIO hardware extensions to streamline
  architectural review parsing.

Ian Rogers (3):
  dt-bindings: perf: Add Broadcom Raspberry Pi AXI PMU definition
  perf: Add Raspberry Pi BCM2835 AXI PMU driver
  perf: Add Raspberry Pi 5 (BCM2712) AXI PMU support

 .../bindings/perf/brcm,bcm2835-axiperf.yaml   |   64 +
 drivers/perf/rpi_axi_pmu.c                    | 2890 +++++++++++++++++
 2 files changed, 2954 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
 create mode 100644 drivers/perf/rpi_axi_pmu.c

-- 
2.55.0.691.gc56d675ccc-goog

