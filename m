Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D14E41A900
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 08:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437514; cv=none; b=Ocvg3qhS4+JTMV9XUEd7rnfdqX/P4vbNFJPax6Z4zFl5Ji4nqanANQUeZzFcY+q5LLSb8kHArM/hzEW3ksCVyzU7d4GGoDUVA9hUs3vRHvcKOBx2ArwQtxDql143VvNWQeJnPSheUj9MmiP0Ao32mFJiv1+M7HROTf6HY+hCjY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437514; c=relaxed/simple;
	bh=T+IVSnX6EINKXEn0mOBww7kAlOYFW8L58VWaDzZloDs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AUjWT157US92qlD8/8IGB39FIqydzmKhRtmbFSnSvUlnIuAXQUXMIcXW6/rzTgeEebRm3KUgC6bN93BrLfqeDcR/izfQfgFjnowUne+3Qeq4oNFktj9dy7dylik+gC3+e0o2N6jKhJPdTtBCCmXDyk01ApdvyTUDIkBZDoBxwPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gdRILl6z; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gdRILl6z"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cec4226c70so54723565ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 01:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786437512; x=1787042312; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ixdeBYynArpsix+QJOhKjoMwqlLEZo89UtTQqf0yC/4=;
        b=gdRILl6z8Wad83fPCEGYweNNSW3bqEalRkotK4jATGNq12z1UdK6T4CG7hyR9VeRVB
         JYZjS21RfFlWgypDF0zd+UJbUA/FdSwOcjutfLyfbf4E12gAmcPRk/S9H76kncRv+34t
         8h9z4rBD9BlCgNik/ss/8JNTk+Cei6wEAs81j1udUxBGuJOy/soVtyrKXHGre8DA0dfR
         04ci5lvr0mZyNOkey+srO+stIrL47ZRdjrBy6oakxwTHYmdZIl/0pjHkkdqR8NZ/t0XQ
         N8wEAFh1phTQ46FNnjzPQ66OmK2J1x2JbWZy3avY08T6RILksa1GN0hAxB0haLDeBq4V
         JF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437512; x=1787042312;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ixdeBYynArpsix+QJOhKjoMwqlLEZo89UtTQqf0yC/4=;
        b=LVxeGrXNRcRz70aT3c0DT3qgJoP6V1Vb+YLGu5xSh0YoGqysdIjNwAEQphBCTavF9J
         v6bszdjuth5V2b2JW4fe67bk46+7U9w6iYw006Oh2SwqD3Uwdj5K6oAo+2L8fXhUIESl
         xjmHeGeq2fkyQukPnW6AdtHPw38h44H+oDlFKOMmdNZABjFO37IS/wNmmbKunP36uurU
         ZiWnPPVOYEeATtkJwga/Cxta6CzHHU97wKSsbwUl33vV/00J9NqPv2rPUdqEkSXAQQv4
         0cJuKun1/bRAn5xx7AymeC1dTimPiY8R+qj3CiIQ6XmMkLr/ReGykFYhiL44so2Ozp/y
         ZPgw==
X-Forwarded-Encrypted: i=1; AHgh+RrQmUPI/J2Mcc3rpqWo3W0pnCG34L4AlU4YWliXpP5vZbqdp1gVd88P89suyOHPD2H74UsjrO68/lV3wRP0IBuV@vger.kernel.org
X-Gm-Message-State: AOJu0YzHPyO/pQvdSYFmRORQeSWjbytxCH54g83MO4MU9caH/y1fs5mr
	SMynHqibnTiCVLSEQy8yNWoGu1XIyVgXhbNq4vNt1OzJ0pl6P/zZS/A0unPtX0/RWx3EjEAJERl
	v5m9g1DrKWg==
X-Received: from dldz13-n1.prod.google.com ([2002:a05:701b:418d:10b0:13c:e20a:efb6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:d83:b0:3c3:875d:704d
 with SMTP id adf61e73a8af0-3cc2baaa24emr2409791637.25.1786437511665; Tue, 11
 Aug 2026 01:38:31 -0700 (PDT)
Date: Tue, 11 Aug 2026 01:38:25 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260811083828.2057695-1-irogers@google.com>
Subject: [PATCH v1 0/2] perf: Add Raspberry Pi AXI PMU driver
From: Ian Rogers <irogers@google.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series adds an uncore Performance Monitoring Unit (PMU) driver
for Broadcom AXI system and VideoCore VPU performance monitors found on
Raspberry Pi SoCs (BCM2835 through BCM2712 / Raspberry Pi 1 through 5).

Motivation & Background
------------------------
Currently, Linux lacks a standard perf-API compatible driver for the
Broadcom AXI performance counter blocks on Raspberry Pi platforms. Prior
out-of-tree vendor solutions relied on custom debugfs nodes and ad-hoc
kthreads, preventing integration with standard Linux perf tooling (`perf stat`,
`perf list`, etc.).

This driver implements standard `struct pmu` hardware uncore callbacks
under `drivers/perf/`, exposing human-readable sysfs event aliases, unit
scaling (`Bytes`), and bus filtering directly to user space.

Key Architectural Improvements & Features
------------------------------------------
1. Standard Linux Perf Integration:
   - Exposes uncore AXI interconnect events via `/sys/bus/event_source/devices/rpi_axi_pmu/`.
   - Supports event sampling and hardware counter accumulation (`local64_add`),
     automatically managing 31-bit hardware counter wraparound across high-bandwidth
     interconnect transfers.

2. CPU Hotplug Support (`cpuhp`):
   - Registers dynamic CPU hotplug notifiers (`CPUHP_AP_ONLINE_DYN`).
   - Automatically migrates PMU context (`perf_pmu_migrate_context`) to an online
     CPU core when a designated CPU goes offline, avoiding stale uncore state.

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
-------------------
The driver has been validated on real hardware across multiple SoC generations:
- Raspberry Pi 400 (BCM2711): Validated System L2, ARM CPU, and VideoCore VPU
  firmware mailbox IPC performance counters.
- Raspberry Pi 5 (BCM2712): Validated live byte throughput across HVS display
  refresh cycles, Cortex-A76 DSU L3 interconnect memory traffic, and PCIe RP1
  Southbridge transfers.

Ian Rogers (2):
  perf: Add Raspberry Pi BCM2835 AXI PMU driver
  perf: Add Raspberry Pi 5 (BCM2712) AXI PMU support

 drivers/perf/Kconfig       |   10 +
 drivers/perf/Makefile      |    1 +
 drivers/perf/rpi_axi_pmu.c | 1948 ++++++++++++++++++++++++++++++++++++
 3 files changed, 1959 insertions(+)
 create mode 100644 drivers/perf/rpi_axi_pmu.c

-- 
2.55.0.679.g6767b8d81c-goog

