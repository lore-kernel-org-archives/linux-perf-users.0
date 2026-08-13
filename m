Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7964229BA
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 06:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603356; cv=none; b=m8ULR5Mn6k9JbM5y6GCaEOUHMuzSFw8JJRnKug3xQeshROtMCGQs/bw3LnBaGCh9ytF3d7ywjaStfK3vfNv0eewB+WN4qZnAq91zUD/dc1RjWF4TbGrOA6l91S0msIfuyIUN3JvQEQ9WcjdECwiW3prYH6b6IAILxyy4zcSGDMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603356; c=relaxed/simple;
	bh=xUtaHUary9iYhxzyqWpn4QRp0/aW560jaXkgKD5YXBU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mFuQG9qZ78k50v7S6s57XphXrDHD5PgFp3Qlb1IUjePVesZplZWsfVipO5rjGjXEwsH0odVkmU/+3dHCzEKJ0qwr2SRw9clswcDaVTU31VLX6npnp/CQF9EA9TMUJV7l6FSAfGH8mrNZy0h9N9tZXQ+69Y4wK8OcK/cGWdr5NfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oS1KcSGi; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oS1KcSGi"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e22137fb3so2613235a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 23:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786603352; x=1787208152; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gb9MsvAU21XMuxBAL1AnROv8wUcrBW21oBvrQrAmcYU=;
        b=oS1KcSGi3JRvhoJBrhOz1gDoxo4DrhUtxTPpDlrkNYUW1Plp9jOZ6yV1kStbLoIeEG
         LUL588QDNX0DfZPJWNFISAKJHK0GAwceWLeXzaQ4PYVh6//mLKtSxrXZ3AdLoM2+2xzZ
         1GJbTvRjZi2lOucrmMwmgf6q4f1+9djb/hw9T4mFrVZ5Ngts2jqOfiQWGX1BYUrqFQUz
         SV1RRlroUWGXJHkgScppaA9RI5cXHUOEwVIzu1Fhi7WhtqIxzDiYecnAZhUjDclgIF+q
         w8GHif55fRZevzUSM8gJCPvxTWolDTE5OwFqpcNwPNWpz+/G+v791sWv90gCgl1f+tl4
         3q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786603352; x=1787208152;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gb9MsvAU21XMuxBAL1AnROv8wUcrBW21oBvrQrAmcYU=;
        b=aKjL/kmT4yxdGY+7NvQBsZgNrV8G0KDYRZBwyGZsM4VpBENR+Wbw/xTYEvmjy1QPl1
         de9/Hr3r5bSKCYp8pySNJR21Ccjkspr4Ak+BgBUsgIyjpgOv3uuKVlpyenobVhOB9O02
         s5PdFn2srWQCmuvoNkeXahr+F9M6AQ4Y2QvzZ/QqL/NAsoov806DxiITIeX63kXCxPHT
         7UQEnfC5QwdzhIJx1m2w0g1FR+vCucPPcmeGXg1rcF3kV86+VqSt+ZveU1hSYtUrSzQD
         kkHy9WS2Rzz2s4xmGyjIJkQKsWa2zxobRJuTgbd1UBcR+m/Qu3dyghX3ymmBqIFG518z
         SIFQ==
X-Forwarded-Encrypted: i=1; AHgh+RqCvFydkViNu8RE3XfOg15bD3imWcPks+Id1xyRc2mpc038poWnpap5rBUefySxKTUznVRGPdptLAb+XQKYy1sc@vger.kernel.org
X-Gm-Message-State: AOJu0YzISwd9lIOXQ7jIZtxG4p+RHdxION1I9ZfbkntmTJMpDjCXf5EQ
	vYiHmXnPnNCgloP2OCkOcpSh0TC2WU+G/MifIwyN1MvIX8w+5ZQg6qOPoGHDp3JAIPFCQ+uJeGh
	nd7wdgPtLCA==
X-Received: from dlbcm34.prod.google.com ([2002:a05:7022:68a2:b0:13f:c741:a50b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1602:b0:3b4:8f18:33a
 with SMTP id adf61e73a8af0-3cc54f4d129mr5116115637.1.1786603351538; Wed, 12
 Aug 2026 23:42:31 -0700 (PDT)
Date: Wed, 12 Aug 2026 23:42:26 -0700
In-Reply-To: <20260813052419.2770841-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813052419.2770841-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813064228.2799872-1-irogers@google.com>
Subject: [PATCH v8 0/2] perf: Add Raspberry Pi AXI PMU driver
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
=======================
Currently, Linux lacks a standard perf-API compatible driver for the
Broadcom AXI performance counter blocks on Raspberry Pi platforms. Prior
out-of-tree vendor solutions relied on custom debugfs nodes and ad-hoc
kthreads, preventing integration with standard Linux perf tooling.

This driver implements standard `struct pmu` hardware uncore callbacks
under `drivers/perf/`, exposing human-readable sysfs event aliases, unit
scaling (`Bytes`), and bus filtering directly to user space.

Key Architectural Improvements & Features
=========================================
1. Standard Linux Perf Integration:
   - Exposes uncore AXI interconnect events via sysfs boundaries.
   - Supports event sampling and hardware counter accumulation,
     automatically managing 31-bit hardware counter wraparound.

2. CPU Hotplug Support (`cpuhp`):
   - Registers dynamic CPU hotplug notifiers (`CPUHP_AP_ONLINE_DYN`).
   - Automatically migrates PMU context to an online CPU core when a
     designated CPU goes offline, avoiding stale uncore state.

3. Hybrid Memory-Mapped & Mailbox Work Queue Architecture:
   - System Monitor (MMIO): Performs fast atomic-safe memory reads
     directly mapped over ARM physical memory space.
   - VPU Monitor (Mailbox IPC): For Broadcom BCM2835-BCM2711 platforms,
     VideoCore VPU monitor IPC calls are offloaded to process context via
     a dedicated workqueue (`vpu_work`) and serialized.

4. PREEMPT_RT & Safety Hardening:
   - Uses HRTIMER_MODE_REL_SOFT for timer callbacks to execute in softirq
     context, avoiding local hard interrupt nesting priority deadlocks.

5. SoC Generation Support:
   - Patch 1 adds core driver support for Broadcom BCM2835-BCM2711.
   - Patch 2 expands support for Broadcom BCM2712 (Raspberry Pi 5).

Changes in v8
=============
- Fully transitioned locking architecture from 'spinlock_t' globally to
  'raw_spinlock_t' to mathematically guarantee fastpath safety against
  "scheduling while atomic" crashes during PREEMPT_RT deployment where
  the perf core unconditionally disables hard IRQs prior to PMU callbacks.
- Re-architected 'RPI_AXI_PMU_TIMER_INTERVAL' significantly downward from
  2000ms natively to 100ms. This acts as a structural baseline compromise
  that prevents excessive VideoCore Mailbox IPC context-switch wakeovers
  on older Pi 1/2 boards, while safely minimizing uncollected residuals
  causing 0-byte dropouts during time multiplexing/undersubscribed traces.
- Enforced strict 100-column sysfs string macro breakages globally.
- Added proper .scale and .unit bytes aliases across all AXI transaction
  events.
- Fixed a fatal use-after-free initialization race condition catching cases
  where cpuhp_state instances were registered prior to the PMU backend,
  which allowed concurrent CPU hotplug migrations to panic aggressively
  against unregistered core structures.

Ian Rogers (2):
  perf: Add Raspberry Pi BCM2835 AXI PMU driver
  perf: Add Raspberry Pi 5 (BCM2712) AXI PMU support

 drivers/perf/rpi_axi_pmu.c | 2884 ++++++++++++++++++++++++++++++++++++
 1 file changed, 2884 insertions(+)
 create mode 100644 drivers/perf/rpi_axi_pmu.c

-- 
2.47.0
