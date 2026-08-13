Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04730390CB4
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 05:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786598674; cv=none; b=fNPXChFA+XAh+Zv5xbY6y70We5wH6yobzzNx+M9gtP0FmngdwU7WtUoCHB73cFkQ5CKbytmFNVMHeCpVla4MzIGUWa3tnMaEAD3vX3h21soWEUCOgumx146YwytuBV4WYDKVJGtZUCZZAMSkbH0opg71rEIZDBcTp+kt2qeyhRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786598674; c=relaxed/simple;
	bh=fUG/SkjmiMBvNkPUVbl9K005ftLXhnOEk72C7MegrPw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dz/OFwAIxdeNOf9yS0u/xE1pS0v6ifOrFmEpWUF3X+Sq5xNNJ57reXHAUEBa8k2WzDcO9ISihHgl9CHB04D3OBbEBfOiqZJxfverTye6G8kVAwsqGvukVy4ASS03VHgwUxUKzKcUxUvNenZmq0kawXftaYjMy8CLTDVyqW3DiuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bxalJ+mT; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bxalJ+mT"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84865f326efso431672b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 22:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786598662; x=1787203462; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TWsMFBensQDbYfWMzAcPvH6Sa8JYBw+s1a4q7hk79CU=;
        b=bxalJ+mTVc3Pz8zak6sM1JLe8lH6lAws8VMP9MULe53eUass7nQmuG/nNl2nyHQK/u
         1E92bHN5YlqzR1tip/d6JIimORxMlSRcnXOT47ZHLYCT8t/Rj6w62s77ulpLNPWBHp1e
         yMXVPG38Fb/o2yfqjry1WpNUSYnozIcmqu9KivasjgctkgSQua4kIMqLDOSymSUaQGfY
         fPdR7LZOG++42J+0osVZ071LbQJ0KL8lPA+oe23E0UuB6ZQv4PIZ53UEoLkK69D5MBC1
         fNoT0zP/MQB0/e4mXPrZvPHwKd5lX+b4fBMrY0lI0YrXgUSiU0gDwpFemWY6WLQu+nnu
         AHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786598662; x=1787203462;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TWsMFBensQDbYfWMzAcPvH6Sa8JYBw+s1a4q7hk79CU=;
        b=HHPUYTUPM3/0YJtXE6Ek8EDQhfu3f4rOAoBeIg/j35tqXc6Byz8qBjNg2XS4nxZ/Wm
         XPJ8fQ4yJYFJNBhONYQ8aX3eK3vsh/6kaTAbeGeAXTuxZPxZ9LmYAHNL5kv29l4KnP/e
         W5kxhi3zeXwAVMv9Fya9QjBQyGqODPeJVWm6ioaWfpHk0xS+wjhriD4K/jn/eFoMv9+H
         mnaLuyYWrBcoBx3bfKEIXTukT2lELFjkGGR6BOZsMCKWDBcS03MjmWME/qp7fCb7b/Yw
         iu3zQOTv5yXbE/ITo7bO/SNQO61WjEeYPsW/4wIPsnHPZ2JJQF3EVj04aENHR0K/HoXy
         QNbQ==
X-Forwarded-Encrypted: i=1; AHgh+RpduCTtj5EdGJnlj6AS0i22CkQWBm6bJMbaDYIeXu3f3GlZQlFcirEN6zzR2bqq0tFSJtZKI//TZXhO0xUnjPb4@vger.kernel.org
X-Gm-Message-State: AOJu0YyY2nSVjdvl/xExUXQsLzCayvdBBCg7w2X6PxrbpxtYwrPh+VXy
	CBr7JetP+IVik2a8oIXJTIlvnSobBpXIxi+y0gAqve73cFjErbHPBZOmqMH7uSJl8X8xBTOa3BO
	iSgkearE9dQ==
X-Received: from dlbts18-n2.prod.google.com ([2002:a05:7022:b052:20b0:140:f2bb:6f2b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:329d:b0:3c3:66c5:68cc
 with SMTP id adf61e73a8af0-3cc552c381amr4077224637.21.1786598661970; Wed, 12
 Aug 2026 22:24:21 -0700 (PDT)
Date: Wed, 12 Aug 2026 22:24:16 -0700
In-Reply-To: <20260813043533.2744442-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813043533.2744442-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813052419.2770841-1-irogers@google.com>
Subject: [PATCH v7 0/2] perf: Add Raspberry Pi AXI PMU driver
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
=======================
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
     context, ensuring spinlock acquisitions are PREEMPT_RT safe.

5. SoC Generation Support:
   - Patch 1 adds core driver support for Broadcom BCM2835-BCM2711.
   - Patch 2 expands support for Broadcom BCM2712 (Raspberry Pi 5).

Changes in v7
=======================
- Mathematically scrubbed Patch 1 to explicitly isolate ALL 'bcm2712'
  constants, comments, and logic strictly into Patch 2.
- Explicitly initialized 'vpu_disable_pending' to false during bus
  watcher allocation to prevent orphaned hardware disables from stale
  recycled pointers (Patch 1).
- Maintained the out-of-tree LTS backward compatibility block exactly
  to preserve simultaneous compilation against Raspberry Pi Foundation
  downstream kernels.

Ian Rogers (2):
  perf: Add Raspberry Pi BCM2835 AXI PMU driver
  perf: Add Raspberry Pi 5 (BCM2712) AXI PMU support

 drivers/perf/rpi_axi_pmu.c | 2285 ++++++++++++++++++++++++++++++++++++
 1 file changed, 2285 insertions(+)
 create mode 100644 drivers/perf/rpi_axi_pmu.c

-- 
2.47.0
