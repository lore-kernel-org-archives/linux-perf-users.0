Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC0843B6E2
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608196; cv=none; b=Pa2gwItjokPEmJFYUuxAKI3eR0ji/xMD9ger1RUMT88RbgFmfu4m7EkXJrVW4JzRw9zjC9H1aU4j+CjNbeKr0Scrx+XH+QDWe6mZhDnYMHPsUhJEBzWnnDLDQsGheFSUIGY7+HBkKx1Ov2nVz6C8kIY8OtX26XNdABv3AsaPWiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608196; c=relaxed/simple;
	bh=X81WrY4V3MgQCFMUv6BvP5J7Q2iluyhQv2PaSObpQYU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aaLS07MG6z8Q79owfUEdhs3ZZFABY+TjTE0wY5Ld0fkJ55G4W39/gAysBlrUp75FOJ4sYuBfOZLhtlEUA7pfarXBsV+Z5FEE+LgfytavJBV4XoFl+U5tW3YsW5YfoGe4DT87C68sgffCpY/Aq2FaMSHNXdjf16vrucWrcNEgNPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Awd73/Yg; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Awd73/Yg"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb6cf425e86so706147a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 01:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786608194; x=1787212994; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DgD/Qr6ThMB9P0bXoLiCRwMAEs2jUFNRi7uUt5JWbEM=;
        b=Awd73/YgMaTK4aEc9qKLtDjVj8ooONqifSwUzKZGE5REyJ55+ecQMsG5QL+w7v8Gmp
         IAvONTHeeGq2ANaSlPdMw7q/MZEC3NcpC85kHpp5C7dO7mH7Dt643fXJvcRx9kT1sKhN
         Quc0QMDwLVZp/GJestFum/kkIh6CscbNUS8ZUft/4WOJBS/BE4n7nxRJKaQxfEFZoR0V
         vhX0JJKEda5wiRBe5dCG3rrXZKn+WirIB/SRVWtGxvqcL5NrlgOmmQRqVUb5mdzeMr2P
         cWdNhYVBJBK582GlyGHg8VhgSc9HNo99huixzp4EWUmLI9p+5sra46VegqhAmxKb0k37
         BOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786608194; x=1787212994;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DgD/Qr6ThMB9P0bXoLiCRwMAEs2jUFNRi7uUt5JWbEM=;
        b=kp4WDjHxeSIqY66kr66p7AvzXsV+gTxzttAi7hRjXVnosEu9KiEDMv2y17Tnpwb6mY
         Oi6LBT18XVf0llJiyVh8oek7HZulUbe1Jf06iA4qi6t/CjrHFrHlWUzMziJrg0Nnp5DV
         hGRuuZTaLuHsAy1ywqb0ZzE4bcgzrCrZ2pDi5mNOR2f/GU748DkHotIu1L7FbvzHtS03
         u+3X7hX0mMLfF1BUK6SQUvbHYwSpLKDbAthBOxuE46XascCMxAoir6d+bmSS02qyFCLa
         Z06CnfiqCJ53VLDBRRVuvJVq+HgknM9bw3V6vFnlnP7TCnI9sDPFM8Ali9Zl6ZmBxrZO
         S63Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp35B+lHfNaVv3VrOgzNL0UREiN4X7xa8bAFvxWgVSwUlWtst5Z7o4HxJdDhLxsajye//jbQ9rMmTb1jHhaeTsV@vger.kernel.org
X-Gm-Message-State: AOJu0YwSW+9v6cAF2h+L67xO44NqMU7z5hCOOvVLu/VN61mjwlU8X4N5
	lD+xyXGtUfXxj4g4kONdws+w9BoJ50VBTjRIhIxmcYzePjPfEPWv3CY74naRkOFnm66Gvkt/9i6
	38n0dED+gvQ==
X-Received: from dlbpy9.prod.google.com ([2002:a05:7022:e989:b0:13d:311a:396b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3ca7:b0:3c3:b226:f165
 with SMTP id adf61e73a8af0-3cc553a59a7mr5906268637.35.1786608193966; Thu, 13
 Aug 2026 01:03:13 -0700 (PDT)
Date: Thu, 13 Aug 2026 01:03:07 -0700
In-Reply-To: <cover.1691900000.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1691900000.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <cover.1691900000.git.irogers@google.com>
Subject: [PATCH v10 0/2] perf: Add Raspberry Pi AXI PMU driver
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mark.rutland@arm.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20260813080307.qnUuB-qX2ytxIKTn2jaei_1s4wkYhYplFE1IFmQBA7k@z>

This patch series adds an uncore Performance Monitoring Unit (PMU) driver
for Broadcom AXI system and VideoCore VPU performance monitors found on
Raspberry Pi SoCs (BCM2835 through BCM2712 / Raspberry Pi 1 through 5).

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
     directly mapped over ARM physical memory space (`MON__SYSTEM`).
   - VPU Monitor (Mailbox IPC): For Broadcom BCM2835-BCM2711 platforms (RPi 1-4),
     VideoCore VPU monitor IPC calls are offloaded to process context via a dedicated
     workqueue (`vpu_work`) and serialized under `vpu_mutex`. This avoids atomic
     sleeps or blocking in timer/interrupt context.

4. SoC Generation Support:
   - Patch 1 adds core driver support for Broadcom BCM2835-BCM2711 (RPi 1-4).
   - Patch 2 expands support for Broadcom BCM2712 (Raspberry Pi 5), adding PCIe RP1
     Southbridge links, HEVC decoder, HVS display engine, and Cortex-A76 DSU L3
     interconnect monitoring.

Hardware Validation
==============================
The driver has been rigorously validated on real hardware:
- Raspberry Pi 400 (BCM2711): Validated System L2, ARM CPU, and VideoCore VPU
  firmware mailbox IPC performance counters organically spanning multi-slice multiplexing boundaries.
- Raspberry Pi 5 (BCM2712): Validated live byte throughput across HVS display
  refresh cycles, Cortex-A76 DSU L3 interconnect memory traffic, and PCIe RP1
  Southbridge transfers independently configuring `bcm2712_` filters.

Changes in v10 (Addressing upstream integration feedback)
==============================
- Removed the unused `num_started` state tracking variable from `struct rpi_axi_hw_events`
  and its associated start/stop increments, cleanly addressing a reviewer's note on dead code.
- Replaced `flush_work()` with `cancel_work_sync()` in the `rpi_axi_pmu__exit` 
  and initialization error paths, rigorously ensuring no asynchronous VPU worker
  threads continue executing after PMU subsystem termination.
- Inverted PMU and CPU hotplug initialization sequence in `probe()` 
  to cleanly eliminate a theoretical `devm_kzalloc` memory UAF race.
- Embedded a robust boolean initialization guard physically into the 
  hotplug event handler, definitively securing offline context callbacks
  from concurrent access panics during concurrent failures.
- Architecturally radically simplified BCM2712 sysfs generation loops 
  by switching to an explicit inverse `bcm2712_` whitelist. This 
  mathematically prevents ghost suffix parameters (`.unit` and `.scale`) 
  from orphaned legacy VPU transactions bleeding into userspace dynamically.
- Explicitly appended documentation notes organically defending the inclusion 
  of the `#if LINUX_VERSION_CODE` legacy shim surrounding `hrtimer_setup` 
  for seamlessly preserving downstream compatibility with Raspberry Pi LTS
  kernel deployments natively.

Ian Rogers (2):
  perf: Add Raspberry Pi BCM2835 AXI PMU driver
  perf: Add Raspberry Pi 5 (BCM2712) AXI PMU support

 drivers/perf/Kconfig       |   10 +
 drivers/perf/Makefile      |    1 +
 drivers/perf/rpi_axi_pmu.c | 2877 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 2888 insertions(+)
 create mode 100644 drivers/perf/rpi_axi_pmu.c

-- 
2.41.0
