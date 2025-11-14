Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8916226056D
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 03:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763091194; cv=none; b=ojOouMJwg9mhqapecz1YyHYJiczsgqrj9kWFP+fuBJ3yZ3RB8SDhGbGPUZXhcincRon5Vb1MyAmnjPDxNTYwDy+dpab3TiO5PdVHTbpTxD2Nfh4kLruxsloqQhGL/zI06Tbr5xjYy7T/UthgKIWY+XH1UoNgcOpF0wiDywGk8Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763091194; c=relaxed/simple;
	bh=MEktD7Q4lr4BzIQfNar3Unfhcxo9clcZUzcd+NqIv1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IMG1SpZhbjyBpzkzg1YARIIofu57dohCsQgvxS5QIeLtHiJvKBgiwK91zco0F+NNPvgOlaWLBBwKjgC4zRna8lFV9OdaSRaCTvOuz3cIE+G2nCvn6cuB4HEvr3tbbijeMt7Y+84JMln6v15ns+tE+bg/IP4iQ7FCd7ff7wj6G8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XFxhFgfW; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XFxhFgfW"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-297d4a56f97so14960815ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 19:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1763091192; x=1763695992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwoYW3TpVbjpnbuDSYglQbGQzGJdKy4yKIu8+Puv/Yk=;
        b=XFxhFgfWOMISEOkzt1hh+/qg8Dtms8qdfA5+6D3ZRiR12aE2diTYHpjV7Lg8+XI+42
         BCGdtIW17X24ZwXvuIpggXzZOGr8uNzeAILLleYOP4ztjrTCxdv4upwaepjDSxlaW0KF
         Z/ackthbYRXdQZNli+YPYWOBtzKFcwkMqP5yFlxb4AWB3EGYu95nB85FJxss8tnbJC4G
         ur5vlLe18pRGhGgy1cRyOFvzSEXSsxeC5tk65/eD96z8OG2yIfaPmABKK2dHDkr+aszd
         uTHrcI2nXxcMxJHegzENpPHPYHOOZUCYBAlltmSqtZ4YhfZSGD6ec+fK6JJc0KQDj2hY
         t15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763091192; x=1763695992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RwoYW3TpVbjpnbuDSYglQbGQzGJdKy4yKIu8+Puv/Yk=;
        b=W04tTxwlWQRHKO+Vw0L6XUmb0ulUEpxysqjIcEV68yvlCkm2Fm0A5we4tKQZe6TrRZ
         tB2PP30v69TF+b71z2pxVXCrgkdznp7z5qzkapUXRIvZGk77y/y+I07k+FapFpOikoKT
         2LsPHlfNjm0XHbvTLnYDmRKI/TPxd8ZXvI3gTJEzjkhUIFg54F9Z3WNVxKvBqitbu1Hf
         noIpF3RruJ6KQO8fzII+NMJAw/v/aiSHBsUrkm+EDSKnFNaE4iHYNtbfn6hiXpUWCdUE
         nH2QfegQLF1SWkLvynTCVn5DLUK8S8qvnqwQWNXKbHAGSlc9SoyN8fePJ9aNErzSSTN7
         QfhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD+DXsm59/467XHdilppGbtr6E2lMXZdpuLrODPUD8v2NEaUheN0InUiZwDfc8OJRh96awENO3VZKmn7c+vV4g@vger.kernel.org
X-Gm-Message-State: AOJu0YzuFkqWl5spVgTfeOmSttybP1xMQlchaVBZX0tH+l1iTQBChTaJ
	ym2cqBKoAdTpLnj58uivJufRAvRLWKPNotALR9a5VTDIs/R5EDZmBaGfJyUQ/muDw7M=
X-Gm-Gg: ASbGncvYMxtIL8jE56hj+fMOFVZeqPvMBnbxnQUXAGS7AfBTD9jdxVQesw8GSUmgJg4
	MJ0IbVVYWOx6JPwdRPE1XFGmcy74d3emUYsfJlxfkH2+oH1mAPJyLRKEgY/Un1lkJFA1FZaXg7O
	gNO55Mu+VQhmTQ4/zQOqzhJggz7jffA8SGgxs2ADBwgPPSOKyhnW7fcSrxYvcFeJO5daEsy/DqG
	+3RDM0blObbjOqUiDLRchIDcZ7hIs6/LXHfAODY1K/7cepavEEuuK7UkABY9gCToMIE2k18jL6L
	/HEi/iyggseZ2KNKyqENjRntLZT8oPcjnUcB3YdFLY8eoKDr57ODjcCTThVN4qkfssSwcC3stW4
	x+uTt+uUQ/XJNbtV6vl2RYFLiGWhwAGwVmdmHoAxsJaTSIrEI4GyPLQRuEIRnR/TMOCDg7cUIEX
	/G02eZyHLu9pNyDFdGfF0+SLF936L+xw==
X-Google-Smtp-Source: AGHT+IHfXjnRp3cTFGa+8Qanqxwy10UGsb/fLvaOOKkhNjGlyR2g6kaDXFitMh3x5rYeK43UijaMTw==
X-Received: by 2002:a17:903:247:b0:252:a80c:3cc5 with SMTP id d9443c01a7336-2986a6beeb4mr15742395ad.22.1763091191709;
        Thu, 13 Nov 2025 19:33:11 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0bf0sm40334405ad.71.2025.11.13.19.33.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Nov 2025 19:33:11 -0800 (PST)
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
Subject: [PATCH v6 2/2] riscv: add HARDLOCKUP_DETECTOR_PERF support
Date: Fri, 14 Nov 2025 11:32:43 +0800
Message-Id: <20251114033243.76509-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20251114033243.76509-1-cuiyunhui@bytedance.com>
References: <20251114033243.76509-1-cuiyunhui@bytedance.com>
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
index fadec20b87a8e..46ccd33732fa8 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -186,6 +186,9 @@ config RISCV
 	select HAVE_PAGE_SIZE_4KB
 	select HAVE_PCI
 	select HAVE_PERF_EVENTS
+	select HAVE_PERF_EVENTS_NMI if RISCV_PMU_SBI_SSE
+	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
+	select WATCHDOG_PERF_ADJUST_PERIOD if HARDLOCKUP_DETECTOR_PERF
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

