Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794699445;
	b=K7jjhACH4WpAR0B9ofLgUF/H6O2tvcW5+wlqgwW0KpoJuUKMNjQLf7fNOblPDpFCqZmA
	 bWTQ7sF/Otq/y4quSAqW8hqvthIiOL+yYvoO9zs2TzZPwh1pp8xhhlWQKNAnD9gj293B2
	 m1Kf5Veg4LX9B7YW2je+KWtlcYT1wjbn+uG0DbDL3LCiR+FSA54YFIajlPRjAQGc/8ezN
	 pvbCll5dCXCdSlXWuwAiVgWN93tzP2z7CbpzWdDxud5nH4hkb9DDetJQ8gVBsvBuM6jEJ
	 c1E50ZZA7G5qOhLtPSu2U5Kvia/ydQRRDujROE1w13471lBlDOZPSik9boea9IFgNTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794699445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NqFBf9Iq5XfpNzEQERkV/UyBTQGdOGc36+bRwxXe9UI=;
	b=iEU8gIIiTE2VmslOsKbVE+T+/M3W7/USFKWQDdBqtUmiQPrO0YiZeDP2aF08mve7zN0a
	 OKvMpw7oKhMCWKPETi6qzRfJyj31ndMzv9I1SwjOW5cBanDX+oo75aKqpVSsMkxwRfGDs
	 nQJquwJ/JYXl1jptNmmjDJEjGJf0uTGlscZrGt7slRZibR7WmVCTJiy55+izml5Ts6IUp
	 d7PQ/5Yxe6G0jZ7sCsLlOoqr0tmASfa1w2egc1dLR/wygMnFiGmS5OHyeAdaX+vP39Pte
	 u60Ewe+CFGmG8adrdu3vVHY+qC4Yg5XJy/9t7aHY7w+9uRow/I1SllB9wMMxQkUIuUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MmaHf8KU;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8947606A32C
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 23:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8947606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MmaHf8KU
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so835351a12.0
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 15:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794699444; x=1795304244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NqFBf9Iq5XfpNzEQERkV/UyBTQGdOGc36+bRwxXe9UI=;
        b=MmaHf8KUq5AIhEzi+DqfX5tHF5/BQAmuFYd5HbFZ35qCF8G1MD2b4r1HkiXs/wmbJk
         TLHjqASWGiYG5vIM481HsaBYGD6KCX0wRmO2PZFmxwbAAFGwBJUZOlsFRgD+BmXKlglD
         2LjOBCaTN/X3uEz5FAghenKgOewqdZpMmsrrVHC9aylgbiKxFYwQHWy9z3+BFrqsq6Hl
         2nfFVzVHG/wfObJARs0K9QOXTkfCWxAs8Lm4SqesVYWgoCpWofPUPASxXoNwxwjK3G4A
         P0g8Ol1fpGOunlJj/KW4yNPvV3TNbBFRkDPNyf5ht4NZQ6mgSqi19vjLAugL0PQKiMOM
         JB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794699444; x=1795304244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NqFBf9Iq5XfpNzEQERkV/UyBTQGdOGc36+bRwxXe9UI=;
        b=KARxj2prvwAfMbKxkD0OJC29zOniGyuc8v5na8oYGHFSdAdvSpbo1iOUwB5Zc1mVbQ
         NgXJPwVkb6tE3Jrre0GiPa1B76KuTSgKgw7EGr7ADKrsAdamw+1ZgiKnnf9bROvgPeQ2
         6Yn4D9c+iOEQgRYYjatEQWap8J5//+BKD5H/XEnS3oBaV+avgFYZTgiRQ1SJ1CM7fBUj
         blYj2zO0LLDlZTeplSieyJcIi/p3wRqpn1B6mV34Bj9IPiNc+cai/L8E0REikphtCh2O
         INrAMAX2QnHXLWZw3/s9gfdmDr0fIhb0rNxqdAauybTvSn5P39hwP5m9IYBi5y1lDW9Q
         ZZpQ==
X-Forwarded-Encrypted: i=1; AL+hErGUbHK/ylyOvTjOcGtZy3OnvjjFC/piiHhNDRnHJQBJoiFHSdyz36zZbJMzG2nHymjXbgtNyGuFfxtMgRBKaeGq@vger.kernel.org
X-Gm-Message-State: APuU4Z/gY9eYgcMtyeOXu46QrGGePJOkvK89XyEezj3nFZZE1Q+MYoUb
	ryPPiO8vkKATIHkbX6tbjlBr7fJW0ZP8KqMqSYt6S2KHNk0WW0mvGtr6
X-Gm-Gg: AYBFou0y80JPzPyfQUFZL3mwPUAG49TSIYY4gzoL1oLcKiFRlhEEdqXnHyyoLJRPJeo
	fvZwrvCr5Oy7YOxknFvA3kYYvVKG73SfLS36eJD4ypwEnjr2pNtnr1UEmwl/xSo/JYgoql7elvX
	bWHaOfS+ONca1jRFRtofq+rZDjiPgrsNyZm0uSXN8r8fPXh+uzlYPbdtNaYWFcj/j8/qlfT0lgY
	pxslm75Bf7y7hUpIt+iW2CLlcgv7y+BKB//s/rub6R9cO8o3SOniRQh5ojqzgSgrJsrFlE0DH2T
	WwVXL9xQIAfrlafDz/jnQfOxDSzU7/+uNhOVo0PMqr8jMgwLBNWcv/eWxn1Z+Z3g8HcSc0TBjKv
	ylbB7Oeuzf/P77SBZc5XRd881Q2ESwGfrv3q5pCK8ubfdZP7ivyawbCuPXP6VlY4zn7wn8OZ6LC
	0V4L6RnDBKO5sHGhs494GNakptyoDefCjNcHdy3b0zShF/2sCWBXcSwxlAuR+Rl8IgXJXgN/FRw
	6ttZR5gQPeM21N9LLT7VGHp7PDtuGm11gWkRYdIQv791kR3T8c16WAAF2fvKAkvrOgU0snxJI/K
	JqnhAZ8x21h1YCqLW4KV+87CRSJfmm+EPN8PyTnSbTzDnUtN134muDiTFE1OJUPAbWGtkqasjeZ
	hhjb5/6f9eKOkrzA7m4U0dSu92GIhb8nyWV0kf2L9LEDCZ1af4UPEMihv4bKMso2z7EYpH+xlL3
	4IUQ==
X-Received: by 2002:a05:6a00:94dc:b0:886:a52a:316f with SMTP id d2e1a72fcca58-8beb2e7e862mr5911125b3a.4.1794699444046;
        Sat, 14 Nov 2026 15:37:24 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2d0f473sm2306372b3a.53.2026.11.14.15.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:37:22 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Radu Rendec <radu@rendec.net>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org
Subject: [PATCH v2 0/4] irqchip/ath79-misc: probe as a platform driver
Date: Sat, 14 Nov 2026 15:37:14 -0800
Message-ID: <20261114233718.86520-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MISC interrupt controller of the Atheros/Qualcomm ath79 SoCs is
cascaded from a CPU interrupt, and all of its users are platform
devices. It is still initialized from IRQCHIP_DECLARE, before the early
initcalls, only because the MIPS perf code asks for the performance
counter overflow interrupt, which goes through it, from an
early_initcall.

Patch 1 makes the MIPS perf code look up that interrupt when the first
event is created, which is when it is requested. Patch 2 makes the ath79
MISC driver create the mapping at that point. Patch 3 then converts the
driver to IRQCHIP_PLATFORM_DRIVER with device-managed resources, which
also fixes the leak of the register mapping on its error path. Patch 4
adds COMPILE_TEST coverage, which a platform driver makes possible.

Patch 3 depends on patch 1: without it, perf would ask for the interrupt
before the controller has probed and would lose its overflow interrupt.
Patch 1 touches only arch/mips, so the series could go through the MIPS
tree with an ack for the irqchip patches, or through irqchip with an ack
for patch 1.

The other users of get_c0_perfcount_int() (generic/GIC, Malta, Lantiq,
Ralink) return an interrupt that is set up at boot, so calling it later
does not change anything for them. The perf boot message no longer
prints the interrupt, which is not known at that point.

Tested on a TP-Link Archer C7 v2 (QCA9558), with the device tree from
the pending series that adds it: the MISC controller probes as a
platform device, its users (UART, GPIO, watchdog) probe with nothing
left deferred, and perf record gets its samples from the overflow
interrupt on MISC 5. Each patch builds with W=1 (mips, clang), and
with patch 4 the driver also builds with W=1 for arm64, x86_64 and a
non-ath79 MIPS kernel (Lantiq). The v2 change has only been build
tested: no QCA956x or TP9343 board was available.

Changes in v2:
- Patch 3: keep the MIPS timer interrupt enabled in the MISC controller
  when probing. plat_time_init() enables it on QCA956x and TP9343, and
  the driver now probes after it, so clearing every enable bit left
  those SoCs without jiffies. Reported by the review of v1.
- Rebased on next-20261112.

v1: https://lore.kernel.org/all/20261112224445.213324-1-rosenp@gmail.com/

An AI coding assistant (Claude Code, Claude Opus 5.5) was used to write
the patches, test them on the router over its serial console, and draft
the commit messages and this cover letter.

Rosen Penev (4):
  MIPS: perf: look up the PMU interrupt when it is requested
  irqchip/ath79-misc: map the performance counter interrupt on demand
  irqchip/ath79-misc: convert to a platform driver
  irqchip/ath79-misc: allow COMPILE_TEST builds

 arch/mips/kernel/perf_event_mipsxx.c |  30 ++++---
 drivers/irqchip/Kconfig              |  14 ++++
 drivers/irqchip/Makefile             |   2 +-
 drivers/irqchip/irq-ath79-misc.c     | 120 +++++++++++++++------------
 4 files changed, 98 insertions(+), 68 deletions(-)


base-commit: 6d582d78fad9d828e575ca0cdcff8ea47a77220b
-- 
2.56.1

