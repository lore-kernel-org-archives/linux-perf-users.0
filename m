Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E963309F0C
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 03:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411713; cv=none; b=JNES9Xso52SQvs6izO0noWNosVa8OWxinbKp//ONGcMiCQhM7BbE5mPFPw0w72s38m7oU/dZD6MkfOZlgHwdDvRyz44wsibuxmHJJwms9rx1YLEWdHd09Z647/a0R4mNvrq6Dt0s/fzisO+394te8sl2B6iQ59pVhMOuW5QIAJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411713; c=relaxed/simple;
	bh=OsVZTQ1MyiSKr3/7iUE60rxwcYFEmk0jXWEJNuaWHSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MWGG+p1d7Ug1fNhKkQxAR9fRV27bPX7WLltTjkNI6BtmtXgvJ53Xp66Q9vT8aeXAEesSPVH01feOZo9BmDIwXxteknTCfWO8w0Zov7sUhdphfUCbIyVBaX6aw4r2wvcoAkHtGGRCHD+UljQKgBeAu7mcHbsy1My/2kdU+y7Gv3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Xx0hOixa; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Xx0hOixa"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b550a522a49so3989127a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 20:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760411711; x=1761016511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6P8xZEQeIO5H4AzeXprUKU3oEf9nN+exJfE8nbRaRqY=;
        b=Xx0hOixavcFeu6tPsgTydMQDUVjaGTL+jFou2oMet9/laxKUBHnzvZP/kKfzbK+OKX
         5z/B5S7TWtUnysMNccO2p1Y7TA+GbrfyOppkxdNhv2s/mHbH6RiR1aFDcIf9Gv3ZOq4Z
         GufDcxHH9e6Dna9WlgBHLM73h5uNLKqoVQtHS73q2LDqcXqsRspsvvfMXbTsVym6zEpT
         DXDECAHmsM+wv/CzIm4R1kEZYwGBfMySFqmMVjGdCM6ZK66Kh5VXy+xem78m+wKjG/Vo
         zvunj+ZEGI7vxq8cb3ll7luThcIdkTyArY3YGmcjpUcByVz69GycfkH5M9hilYAP6o6j
         +bzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760411711; x=1761016511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6P8xZEQeIO5H4AzeXprUKU3oEf9nN+exJfE8nbRaRqY=;
        b=vO+YG3hBPtiDRIQKxdZloNrQRRErk9VdWEChNUrEPglcguscMErw7BBrsqgMai++8A
         VDzg4fiZI5Wbpbbpp+uIayFRj4V+K3YvD4R6l4x1ba/E0ssZcC5Fk+CxglU84Xj5/kac
         sKfTTBxjJ8XMrUcHi8owYKQLUnqmj4hq/S84nosGfkuM0/qmpe1zjv2buOo/0/9y/SWm
         hCdLUyOyTEIVc4SIZ+zTOVE06K5Fdh6enQapFKH/f3yXQlumDcdWL0wshnAxcBthPFPe
         B2xlsGihJLvUPnIGWuNEYiT97BVesvTAMiUBryZlqCMhk5QdDE6Beu15hK1Eht2y6R9j
         +4Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWwaT1WJvpTULqs1efgXy2EfJPD8dVRV8HE+mtTdiGMryZ+0rAUHAht2/SxjBTu8oet/RCDK0mH6K4xAv+RQjHJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3xIot5ebUxdgBB/1xwCthO+vZ8Rnd1iCoDM4s51Hb5alWOhmr
	j9UDknlieHznUm5IK0HGk69sJZ4bRZXjW9uj4Ta4YwPcLRld61oCmN6kITSV9LSh2dA=
X-Gm-Gg: ASbGnctJP0H8ya5CfCoYxC4J03a0YfwULuh3s6TLKBTlYD3WqEpCw/EInuq+IDZQdeo
	M8r355IE3tOnG7bn/y5YtmkGGunS+Y4EyoGIZ7nzgo0AQrrZkmI9skSR6hg0NjFV5ruI2BrVpY8
	ggNMOTs04lQ8YyX8U92ZgjNy/1759qp02tCK2aDRseZ/IB/pShgP7/Abi9RroSxhNF2lNKkeCpQ
	BaXvn3fdVEJtcdMOyQWUTchpnb3C/HYkx9sIYwDK1xzCFf7avQaE5+Ar2BFJGKhHiLRoRlu/Ccr
	SrYUmDRqlfT15xj7wP2JS4yYmhCdLfXI57zURHzXPhaQRL4Ms0n/qX6xA1620GpUpIEjmwZZxqx
	kreeTEiVEk4e+eL7pcJHhD3wUdiGrDBQt3bVGcdh9308k1rNOTnNVQasCiujLi1QWWuG0r0PfVp
	tW/Oq7tJK1SJqMF4IY/krm0itFVc4=
X-Google-Smtp-Source: AGHT+IEnhbhgD5wvfXgKIYQpP+Lfyce302o3Owp60kynW6BbE9VY04c0yKjSZIvlB5ornO/n4cUtAg==
X-Received: by 2002:a17:902:ef07:b0:269:82a5:fa19 with SMTP id d9443c01a7336-290272e3adcmr281603745ad.45.1760411710696;
        Mon, 13 Oct 2025 20:15:10 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f3de4asm148315845ad.92.2025.10.13.20.15.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Oct 2025 20:15:10 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: akpm@linux-foundation.org,
	alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	catalin.marinas@arm.com,
	cuiyunhui@bytedance.com,
	dianders@chromium.org,
	johannes@sipsolutions.net,
	lihuafei1@huawei.com,
	mark.rutland@arm.com,
	masahiroy@kernel.org,
	maz@kernel.org,
	mingo@kernel.org,
	nicolas.schier@linux.dev,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	suzuki.poulose@arm.com,
	thorsten.blum@linux.dev,
	wangjinchao600@gmail.com,
	will@kernel.org,
	yangyicong@hisilicon.com,
	zhanjie9@hisilicon.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Paul Walmsley <pjw@kernel.org>
Subject: [PATCH v4 2/2] riscv: add HARDLOCKUP_DETECTOR_PERF support
Date: Tue, 14 Oct 2025 11:14:25 +0800
Message-Id: <20251014031425.93284-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20251014031425.93284-1-cuiyunhui@bytedance.com>
References: <20251014031425.93284-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the HARDLOCKUP_DETECTOR_PERF function based on RISC-V SSE.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Paul Walmsley <pjw@kernel.org>
---
 arch/riscv/Kconfig           |  3 +++
 drivers/perf/riscv_pmu_sbi.c | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index badbb2b366946..0ae3291b303f9 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -186,6 +186,9 @@ config RISCV
 	select HAVE_PAGE_SIZE_4KB
 	select HAVE_PCI
 	select HAVE_PERF_EVENTS
+	select HAVE_PERF_EVENTS_NMI if RISCV_PMU_SBI_SSE
+	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
+	select WATCHDOG_PERF_ADJUST_PERIOD if HARDLOCKUP_DETECTOR_PERF && CPU_FREQ
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index c852f64a50221..0c7c5924687c9 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -22,6 +22,7 @@
 #include <linux/sched/clock.h>
 #include <linux/soc/andes/irq.h>
 #include <linux/workqueue.h>
+#include <linux/nmi.h>
 
 #include <asm/errata_list.h>
 #include <asm/sbi.h>
@@ -1192,6 +1193,13 @@ static int pmu_sbi_setup_sse(struct riscv_pmu *pmu)
 }
 #endif
 
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
+bool arch_perf_nmi_is_available(void)
+{
+	return IS_ENABLED(CONFIG_RISCV_PMU_SBI_SSE);
+}
+#endif
+
 static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
 {
 	struct riscv_pmu *pmu = hlist_entry_safe(node, struct riscv_pmu, node);
@@ -1618,6 +1626,8 @@ static int __init pmu_sbi_devinit(void)
 	/* Notify legacy implementation that SBI pmu is available*/
 	riscv_pmu_legacy_skip_init();
 
+	lockup_detector_retry_init();
+
 	return ret;
 }
 device_initcall(pmu_sbi_devinit)
-- 
2.39.5

