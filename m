Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFC1278761
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790124; cv=none; b=K9KubKZsHZJOjAS+/G7D943BvvhnCiUSRMbZ4CbjUes1UfDJrZcLBHpNR/UWGoBKML9CJVhiNqDYJe39xpqNrXPh+kIKdnllOZf1Bw9+CGBS6cWUEvj70s4uLvscWpjjpEO/WpLKUP8ci8I5Mv7xTI4X0W1+/oomorTTenLeWHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790124; c=relaxed/simple;
	bh=rfT/UnolT2+BKHZylLOfQE/YMmzeQ4dYHqdSX/rrlS4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vEd0Z03xqnVpPFWDz5v8Kisqu6w54H4yoos3SwFnExYiSoWKFcrVroYmGVUKkFkL0/CgfF9sIQqSmFbN0f10frgfb7gW44IBMkkkrEo0AtKpgZNuHPvIwbKpu8B33g2ewKubavwF4A7wpNqMK1qSzrUdXIv7RYH5uOLRUt6W4Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RpkcPUG6; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RpkcPUG6"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso755733b3a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 01:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758790122; x=1759394922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Ub+joKWJDAfsvLrnMb0mGFn8U6flakDwqgSsOBFKpo=;
        b=RpkcPUG6t0yNyFnUytqgxLmzHVC03pRmJ/vSNCJYoQET1G6g+d53uTN3kKT8WmFYIf
         ZBJC4E2SIfaTdNms3twzjbtBx5BTjxtZUlVlJkyScT0pPGri61rDlvzXSg6HqDZj+hB1
         HiIClQZXiZzYEW2hu+P91Ncqsbn1q3SpJMAYAWEc67bml/UXW1MBxWeKF/ReZ3JMywtD
         sP9oWVNFEahEEqA+/12mzuPUldym8AKYqvtWj7dgLJF1CufwzrtAJ13bu9KDqOv9M21h
         w683IAfMSGN/T99F2SIjjytqGSdAKJSBZ0mMG4WtQxIbsFoOSmDpiLRCZwuD3F4foFVe
         FMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758790122; x=1759394922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Ub+joKWJDAfsvLrnMb0mGFn8U6flakDwqgSsOBFKpo=;
        b=Uhj0qY5WMAcJWJYJQfPMXZvutnQO0Ua/EEoVLCj2xMOKEWsQIOd/RwYk927PzE6dcP
         4R11hBEkRc94BYowFgU17cBtIaVLDdRyurSfCNSp9NkN9XXdyqjMp6x6ySMoUklMLQDz
         RPp72g6b0qV8k5KBVosye6JSqZ7bd4JfBeNFZTSncmlYVlECVFO9MxjQ5lxKz964aI1Q
         Ago1vUXH7vNDNjudM9WXweoDRd1YOD8+nILRmXTBRB6INK2HKYCvCFQQVKompmdmB1uK
         eJrfHChtliYKL11IAN2OiHBbzutQ8KBpMMW4laLZeGP37b/xCFMPVwJ0jw+KLTJHHIhk
         jCnA==
X-Forwarded-Encrypted: i=1; AJvYcCUpKq9wlwYnH15xvNyrf+krVv0EhZc3kMZsmMstYsvdo0leTGTeUhb8lY9qj5gddPcQaD8pS0BWnOjZvX55765i@vger.kernel.org
X-Gm-Message-State: AOJu0YwuBnhXlRE5k0iHySVoOP3393McpmtCAnuaDNQuVT2UA4z9Z5K9
	6eO0jGl2Jz8AoVOyenwHNvhfl/CAZtkJK5fv/KzHoJ2Ec/bIa3BG1jhQKLsG9jbGoYA=
X-Gm-Gg: ASbGnctJM0YaFomE5BSkGYKTXdhtLfcTo9pb+1PWs+FlU+sm1eaFkQ6fhHodeYNNrQg
	cTrl0LToDpD4XnCsfoyGC0JbQixKMTkYfcPaTBUVTDlnAZoafC120NTeojhX+rJt2JEhO8PX0Iz
	IJLF8oHE9C1A7lF7MMA+BDxYmQhE5vjUSmJZItk+d4ti8qFshq7/HEQE20ME/fTQ/es7sX4c/kb
	Jjw6/uHDYub/XdbjpK+fFQrlH8+ParpDfV6jb0Ni6A3NHK6uHY5WURNZHrVa90u5B7quoLbIOSd
	muuKc4Xui8noKO3+ncJ1nKfDTKQNGw4pzY5t0PU68Ej0ts6/YkLhL96kLTlU5lA1jm3bRQxZhf8
	VrXhBdcch0v4AqSt3QJ75k86t7kn/90fMlwqRm/0ZKfedxNq6gjLUU12/nCJH
X-Google-Smtp-Source: AGHT+IEGSkHjuRa7OGjamv0g/2mmAckOVuB2U/CUDAe2j089bjTc0cZKoTa5Cf1LNp+M5twG0RcAdQ==
X-Received: by 2002:a05:6a20:a127:b0:220:10e5:825d with SMTP id adf61e73a8af0-2e7bfc1d570mr3624129637.8.1758790121907;
        Thu, 25 Sep 2025 01:48:41 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023ec6aasm1321867b3a.46.2025.09.25.01.48.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Sep 2025 01:48:41 -0700 (PDT)
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
Subject: [PATCH v2 2/2] riscv: add HARDLOCKUP_DETECTOR_PERF support
Date: Thu, 25 Sep 2025 16:48:06 +0800
Message-Id: <20250925084806.89715-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250925084806.89715-1-cuiyunhui@bytedance.com>
References: <20250925084806.89715-1-cuiyunhui@bytedance.com>
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
 arch/riscv/Kconfig           |  3 +++
 drivers/perf/riscv_pmu_sbi.c | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index badbb2b366946..bb4e8c5a18717 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -186,6 +186,9 @@ config RISCV
 	select HAVE_PAGE_SIZE_4KB
 	select HAVE_PCI
 	select HAVE_PERF_EVENTS
+	select PERF_EVENTS
+	select HAVE_PERF_EVENTS_NMI if RISCV_PMU_SBI_SSE
+	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
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

