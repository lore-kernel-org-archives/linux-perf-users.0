Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2C6238C3A
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Oct 2025 03:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759980584; cv=none; b=uo2i3/88p9QDVJXbmFdi9a4CdZ4rh2LiZsNwbaBH4I+57qPY60MChKpD4c9csKqnE4wDD1JVt1LekTMz350gjPsn2qEHh/XpNLSfVayBCM7qp/0g/w94uI7YcysqO44Ld7BJUrSsAaYsjvmrSsDj8c2GEqHEzuWMbAIycoGdJoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759980584; c=relaxed/simple;
	bh=QiIUdpJzLvVWvY1Zmn2ap/QqQJGM8PGQTOCIrjyiUC8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XS2JTxk28Fpf4GB7qCjNl+fAs+Z63vXPUqm8bt6RqRZm/hcLFBbD7UZpDQUjtlQxWetBI5ficxnss5EIpgqjcu1NGOVLOASnIGW1xB8dpl0ImjevkoU57wwsQhWGPUWQiA0l+glvYv5fq24bSKa88dvQZgTIhrKV+Qct74tHID4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QUS4yzDc; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QUS4yzDc"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-781001e3846so472856b3a.2
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Oct 2025 20:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759980582; x=1760585382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jnXMECOikkNGPVLHGk2/W+70TGvv+oQ3PJ6DV32z1EM=;
        b=QUS4yzDc8qyjy6eUMr3QBizPME0g5NTZnrtDKdY70R7lrXu2XUFNd76oOcPzyZSDVs
         gS7KQ+sCxjkSOL1Nzl2LA1wDhJs5UcX9IqFGd9gQIx/lxZ9gjUF3GjVQ8LGBFLfUsyR3
         95hB0/M0OQJveplysWhEw/JBNZxbYUhB9qCFqJXv4p+2Ou/iYKIvAYTKySu4lZtMLLnm
         kWgpMmadHQpdpkOS7snvK3W2jBTMqehCrySK9K67q+BaGG04/WaZq23XxlpCfQRCfhjw
         8Q4x7NiChllGhw5K8UhNXo6HwVRtlw47n0TC8C+ss6Laeay1Iq9cEe+jg3BEEMrgYvbh
         S0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759980582; x=1760585382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnXMECOikkNGPVLHGk2/W+70TGvv+oQ3PJ6DV32z1EM=;
        b=EfZGRO6IUx9R7dUPvu40cGonuEQeNj4jwQFL8Yu8LlWfsR08/bjI8LvNTke4hKB2xr
         CufQOmFD3zv48B3iqlC6CrXWjL8b2oLHHKhpTOA6d40KMoZk2KxIsdoe9oJtIAfUkebo
         d/UIxRc4c2n9bhyzaJflU913niY4ExiSkkMVSiqmgBbt08wgDHVGcoGojnehS0s2YluK
         Rjg6zItqTlSOhx/auOmwJ1FW0vGmBxBSDlULMkgmFncNq/BW4KgjKZXcqFQklVnsSFu4
         0t4G80iNn4MLwvORCJfKGjG9cNajmo6eWeHYHvO9YLskL6uIbv9DxGxt6S4SOBy0zvnK
         3YvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGMcOPGjBwzz2kT5JBoD9PJdzouSsAA9mBoK1KOEC3+duDjjYDoqhrssOrFk9V7ZXbpCAHAfi1bmP00y4PGLVV@vger.kernel.org
X-Gm-Message-State: AOJu0YxptCEc+XBlAuGahy9tkW+l3RyLwi9y2W9zq5D6Mz5EasQHGAJX
	bFmtyLHd4T0XBT6JxOh38JDU3e0csdKTikp2Ror0Ucc1tvguv9DHAXY+tiV5IW39aLQ=
X-Gm-Gg: ASbGncuJdlI01MxAVQ6HzZ0JgETnnp5izklvhi71BVpA/pzrKM3hGRhgMzVAWfUDNmN
	vcufD3DY32qN2PH1cUTaCzsl6ACslNfZk/tl3mQu7YSNWHpbfKd57aT2aihg/0hvC1bPsPdlh0k
	Qkjq/85ugRCqRUjgHLtBMlJ1HtX3QkpfJ7O122UTQE9RHR2IjUtBt2nkd30/sNC4M6wHBnOGLEK
	DX6pF1B9UaWO13meCqzrWDrqOMTwVlvUus9J5WtEXFYnUB/hRnA7gJBoN2xvMiFNDyVakNlPcUN
	xzSWnJNia+wNZnrXUdx8by57EiveWWIBgOH7SAmogb72YXAehks0/4P/5fEUYEdAiSch4PuYwYj
	DXncQzUsEOIaf1wwRIvdZu3Iob8Mq22fMfQS/pw1mfgr9Xeo6VaG3xw7NuT6xp3sbflo1hETH5C
	rqrbpjRl9z/TY=
X-Google-Smtp-Source: AGHT+IHbZEm5frc8fvTXu54yWtTCugs4CwZJHmN7TKBRMpR5Iwopkp0MBjhRhFZXa74I0jkchu8wVA==
X-Received: by 2002:a05:6a00:3cca:b0:77e:9ae8:c7d0 with SMTP id d2e1a72fcca58-79384f48886mr7305182b3a.1.1759980582231;
        Wed, 08 Oct 2025 20:29:42 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794d4b39400sm1271306b3a.15.2025.10.08.20.29.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Oct 2025 20:29:41 -0700 (PDT)
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
Subject: [PATCH v3 2/2] riscv: add HARDLOCKUP_DETECTOR_PERF support
Date: Thu,  9 Oct 2025 11:28:38 +0800
Message-Id: <20251009032838.63060-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20251009032838.63060-1-cuiyunhui@bytedance.com>
References: <20251009032838.63060-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the HARDLOCKUP_DETECTOR_PERF function based on RISC-V SSE.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/Kconfig           |  4 ++++
 drivers/perf/riscv_pmu_sbi.c | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index badbb2b366946..6a7b4d2517c4b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -186,6 +186,10 @@ config RISCV
 	select HAVE_PAGE_SIZE_4KB
 	select HAVE_PCI
 	select HAVE_PERF_EVENTS
+	select HAVE_PERF_EVENTS_NMI if RISCV_PMU_SBI_SSE
+	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
+	select WATCHDOG_PERF_ADJUST_PERIOD if HARDLOCKUP_DETECTOR_PERF && \
+	CPU_FREQ
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

