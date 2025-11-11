Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0645E341AC6
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762846541; cv=none; b=ml7tkqtvlBOKhvKhKnpW3kV/h9gg79ji5BJMQS/ZBZhGnvSRov7PMVdpMatZdfCzvLwqXb0MuCmvhoG2I+mqqknnB8kzJkq/sntCvqstAbQ0nHur8lOd9H7r9UpvIlc4Q05hpnE6pE++sRkgDj8ePMgO9x76CbTsVx5kc5nJK98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762846541; c=relaxed/simple;
	bh=TXw2u5rDDypAuPP/PEkhaT2sUClVbxjCMBkI2ULXV/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hOyKPm2Sy7Dckbof+1Xb8N55psbTZzS+M9CXT3Pt+DhvAUzrkoU4N64OpunlKbvGt7AQgq0TSABIFJo6E1suqa9n6B9/EK6KQgWeejnerR8q81i8oq7Fs4CsnSk4Me7+f/MmDI+kfsClbDoMHTc9UrLrvJJm5rMBIxzJAU9AYs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Nsk5NZQM; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Nsk5NZQM"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b62e7221351so3242092a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 23:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762846539; x=1763451339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOOlaVy/20CIon+tjXLAyji+6ZbQKD+NsElw/LVQ6M4=;
        b=Nsk5NZQMIAtTqaGJT8qrDL3svqUHfaFKEvwVZudVvrqD4K80BApHQIh5EKsi7W5fvp
         4DwJ5Szs4NEBylUTAWZ94ibBwQmtcKj7TeCU1dvQqcJkBf+GQjWQ3XZ9LRsmY1YiLT7h
         CftIzSr4fIqj1BVA+SRFWLSZN58aSu/geI65Oaz3+qCYMOWtjZOaBZu11nxBN6yXGcXp
         AKxrunIW/U1gDj/nwb9JHU0swb8XANRxn/ZK076YVwUDcL57l0eCMuGojlxjXdW/zabh
         /1jAB4rXiTU+bjogG7ZwyzET4+dK3fpDhO20RaKiw7jam9RxnwcJk3dnvZg2YrXAzGDX
         QkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762846539; x=1763451339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dOOlaVy/20CIon+tjXLAyji+6ZbQKD+NsElw/LVQ6M4=;
        b=o1QetZzXlobPNzZzT50PsC8gr0izzaa9vCE8c9KoTBmxbygxr8t6xCKV1NqIgV8bKh
         xml1mxpB54LydjqIOoxLTYMIrjSKbYN7trwBEkFdch5N6GQOzjI2ge7K9qOjiqDXz0V1
         f5X2e8QCIdT9xM0XdhHXhVYL7J9dZCGMKzgkcwrC3qIUs2zygixPKPzErM3eML60TVYx
         1c7IHH2pUzZfyocf3jMZwItob+s8dwhcBgMUnlov3hhcR8nEIXEmS5AHp4/p9IczdkPv
         PmPBAEkiPapvxUsCCBgcxzjvFq4lV09mCHd5+ioBG9izqfW3S8WY30Rc7oSCm6gDrbO+
         7YGg==
X-Forwarded-Encrypted: i=1; AJvYcCVkW3b/ZFJDGCuiBR6U37Ehuq5pFD9cFzOc4Bhnbijwebs/HNK1J/D++g5HtoMi0+HKOr6SE4TXO0FlO6eSGKs7@vger.kernel.org
X-Gm-Message-State: AOJu0YyCQ0VNKdJ8HUMmqqSMdieajraIVgJznKPoix8IU8u/xGCd/BnX
	WP++T/X8hJu4tZscyK9bweJ4Y7FN1RF4oTJncJavSrTXHkQg5JhdCqFrUQr+ycqWl/c=
X-Gm-Gg: ASbGnct4s2Z36w8U0Sih3wUKZq/QqssEgXBjnMV/6Pcoysr5TrH0kCpv3Aty4g6VUUd
	KMQk9jCTFoobtJfmZBy8s9WGALSjIiHl7XBG65jtWt6LUpNsWh7r+/ky1lZq+3sLl+/+wu3eq8h
	4jOU0V++upmFWQX4q+WgBP2HC3/Rw8dw3va0YGXmFfesZJiRwnXIl/3p3dbR20FNXpqnBJqZU1e
	u066X0HeS3SPX8qsNlVMBMs/RDRplnVt56nj4vCLmFHpxHQcgVKa7uLAtNu8GbcKU/my3ohrX1d
	shfZJBNpzIdHPnuTE53l4ru0e4cYEMWjpI0/ZPfLXQwX201UR8YtYogmE/ZhRjW62+RHZowM5/5
	LjhT8rx5/fjmHBmwmF8dxWxWL3xV/xG1afYP0A/eCLweT3QCkxzfbiJyZxJJHVisf60ALriurEe
	wlIy4H8p4tzdLR1eB6Uz0aZ9Z/dHYulWaNxHNnnC/ouA==
X-Google-Smtp-Source: AGHT+IEUw+72YJMnHDr6LbdwL+uWXqhzBDVKr1Hy8+90WDm/+ZatB8gHaR6Ah1I0Nw0KhXzjZnlq6Q==
X-Received: by 2002:a17:902:e545:b0:26a:8171:dafa with SMTP id d9443c01a7336-297e564cef9mr165530405ad.21.1762846539211;
        Mon, 10 Nov 2025 23:35:39 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c94abasm172928885ad.82.2025.11.10.23.35.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Nov 2025 23:35:38 -0800 (PST)
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
Subject: [PATCH v5 2/2] riscv: add HARDLOCKUP_DETECTOR_PERF support
Date: Tue, 11 Nov 2025 15:34:59 +0800
Message-Id: <20251111073459.44030-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20251111073459.44030-1-cuiyunhui@bytedance.com>
References: <20251111073459.44030-1-cuiyunhui@bytedance.com>
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
index fadec20b87a8e..74835cdc89ddf 100644
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

