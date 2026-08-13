Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A01351C2E
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786606252; cv=none; b=KNBbGTCFO86hX191FGk7/srziVVWGI38XGkbYHtiJ2UyPoACyLZXspK5ghmbur3+KaNIzlQAmhmSelgWy1bKwnITVYbMTRnfsoVhx9td2fvJQXEHTrgtfv5bmNHRxlHZDZvMuNxOZP/3fn7/dswiw9sbJON3yKA9WTTYFOGunsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786606252; c=relaxed/simple;
	bh=oYzuOF1nti0ufCuBf1VsBRIdrv+WOAInCHk045FKsUE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rgtRqiRY93x/nr06GuIdTSfWMnVrC68rf3Tpyd35Uxu/yl0hSjSs8m/ceFLe/9Bc3nKp0oGi+/ufQCooDIx/CCYSNJKgaXgCnDKnPxCa4boxRl75UnyZCuyZ6JdNxNXsUKO4Xly7JqMhBy3ZONyLEgZdGBUZgrS/a2I0bbDqNyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fihWQSrp; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fihWQSrp"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so2173183a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 00:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786606250; x=1787211050; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c55HlxdAuLgeE4D6zJzLV99h/PLClnRkIxVnHbAj8Zc=;
        b=fihWQSrpNk56rLGBLWnhBkHeYAVUirolUvnL/wNn99wB22KW6oC7RB2NCharo0FtaA
         OqDJ+QU7wrZUNU4/zgcVCIzOnkpyKMUxMvj1eFA1h6JlYw9yz1OJgRejxIRS8Gv08pcD
         aw/kiLWwMle174H9hEW/7bEjZQaf/SFDbZzf7xQp0pvv1FlNT0QCRtZK2AK0cUk6oCma
         RJiWLpf7MEgdzR2mkZTLl7GJkpvwpTho2l0AMLOMrcZcvTZmu+OAi/yEF9xT9GSKWFut
         7Rd/69we7vebRS8QxJHUUQytRECzKy0J2Oebp87mAiL/wqR8dEIbtwb7vTFyTG6DFKP2
         Y3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786606250; x=1787211050;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c55HlxdAuLgeE4D6zJzLV99h/PLClnRkIxVnHbAj8Zc=;
        b=hk5Z38+Twckg0M7zddkqsKDFpxybwpnGDT3lJdYyNcTKpon2q0AS69ZoKS5tI8IMfi
         SzVaspGoGhhdIYyLzijNNFXoHTKFB3wcd5Et8w/GMrmbpF7jjIEjjdLMRyF4E1v/qIrD
         dp/UhlnPfvteyobQr21T/dpBdSpULBSOy1q1RwILZTkg02/QgwhSHTjtn5KaGsFIC/UH
         x07uiwPKKfuVH4EmogUCM++WqiLuPS5jOFj15VD+NAW1fKvdMj/RkvHa+3ADeaiOFK4g
         I4C4gKPfcYwom3HxdSlTY5OMZxNI7lo0iTby+6aeX9SwmECI7yyrychFpIw6aO3rySpL
         WjWw==
X-Forwarded-Encrypted: i=1; AHgh+RqYrh4Uos2mYxn2DnxT3HbHLqY2ywhAF/B/pHcPUmwpe6eq+KtU0unIQyz/XzUBFpD5spbvIUSgXPAyIPR8tfE2@vger.kernel.org
X-Gm-Message-State: AOJu0YxaEKan7XwSeGS/UN65a7Y18/dL4zGQInd10YBpWre9K8Q6mGsg
	RB8XvLPEeekv1Wbg6hZBtaU/EbJ30yvdsPSZASVDv1err/tccxgUjVEKs0CYUqLAnjUoL7nJWtd
	yR3oGuhKNeQ==
X-Received: from dlb8.prod.google.com ([2002:a05:7022:608:b0:141:3f8:cbe2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5288:b0:38e:ad9d:1151
 with SMTP id 98e67ed59e1d1-3931dfd01b0mr4679263a91.4.1786606250339; Thu, 13
 Aug 2026 00:30:50 -0700 (PDT)
Date: Thu, 13 Aug 2026 00:30:43 -0700
In-Reply-To: <20260813064228.2799872-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813064228.2799872-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <cover.1691900000.git.irogers@google.com>
Subject: [PATCH v9 0/2] perf: Add Raspberry Pi AXI PMU driver
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mark.rutland@arm.com, u.kleine-koenig@baylibre.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

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

Changes in v9 (Addressing upstream integration feedback)
==============================
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
