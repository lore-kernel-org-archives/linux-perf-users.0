Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0601F346A15
	for <linux-perf-users@vger.kernel.org>; Wed, 27 Aug 2025 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289441; cv=none; b=lrEE30i+YyiMSEihpzP9oYNq0DUeMgS6E6EExDIZKI3yqLNSMda6zq8KAtk04xqVOdhTX7sVOLKgy6U+kywE04ZgA5KqBdthsJ72HI9MaJ2zUCgZzhNLf4fdkyFm1AB8vjxMwT2XDvrwlKH4cKPE0Uu3ChpJoMwnI0n3RakfT1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289441; c=relaxed/simple;
	bh=ob1mm/QZIvYurNgvoNKtvTajPGjDoJT+DigHtqvCg5Q=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iy5uT5StYNV/7+30vBOvU/FtPPil7/+ZWz02AeyH8s0K45+YBy5GsNx8vnJVE9dykQhB7Hjg0Qi3iBFDAMLg4ZxJMelmRFvyZkKYETevyYln32yURntB6P82d7TxvZQBkEp6E8sFzpb5uBXwGNGEbu96CHza3CvD3lY77wKxqv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EnSH9XQv; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EnSH9XQv"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so657696b3a.1
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Aug 2025 03:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756289439; x=1756894239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JM7gSlpkCi+0kyKyklIFOqWTnKhlvxmA1qdlwzNde30=;
        b=EnSH9XQv1YMXQhBFHrLfMGiqI4mEKdKdB2aK7vuZKSXuXARtQT7rpozk7vMehNT3dw
         XH+6zuUNxpUWFVe/K7OA4TnJpKwjqgSXuyhHXyLs/0geC3Ten9Y+BKQTq3Oh56kMODS4
         vp0lU37WyqKWdV+0uNhKhpU0voBOS6ex1188NKesv3U1Z18fmyE07TdZd4NK89T/Odic
         ZYKEqP2NaEzc4axYmwifp9bEAMo9K9E1CvojpXBvEo8apgqBveW284aD2CtCnuzSOdhK
         G3TSnReuYAQv9g1Oq0BxIY8JfbZbTWDwcYoGrVv6gSXZPfr8yvQZgXVCoXKuc5EzUXdd
         QETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756289439; x=1756894239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JM7gSlpkCi+0kyKyklIFOqWTnKhlvxmA1qdlwzNde30=;
        b=tIq2uWv3VYQjJUAd2a/lbyUuaYsApbAW2u//QsZ5VCIcAY9ONzDJHl70yI0880Wmz1
         wtVW7fVOTQqiCzUpOB41NM6sap0MbFR1ugM9FpCAOwnN13rX0KlqZoCnrYLQZ+croz+O
         uxdckf40aWWo98mX1sLiiuDlVqctw/RN4VoLhcRjzlgtrt78LXxTnn/bPB3WyLg2wn5u
         ts5OaYcd3SK+lVXsuqyq1qMJk512IqAK1+S9hp7p63VSZYPgC0RBxcibHImj9OIH6Uer
         wm/oW110EVq8MuqOdN4J/OR98Upn32eCGLmbkPUKCsfe+sDjYQRqptYEms9zvLpby0PY
         he6g==
X-Forwarded-Encrypted: i=1; AJvYcCVlty1I3l8RNtuscJygXnEeoirKchsFtg4sJqHrA2PP+7cH+3Fhz2U7P1FgOodd2ersF7HPj2er9DWks1ryDEqJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzgNOAtoamQEGJntEsYr0+wjb6J+MTrIQODGz1LdxI5d6diL+FD
	SCJF1grsyV43T5v3wkHQiFkb/3gjPYHPl6S38K/+oipbT9VfhtfhC5HsUuRMKFY9psQ=
X-Gm-Gg: ASbGncuoERZB57xnHM+mevTpZLcHWZBSMjasK24HN6UxM/Nqt/HyUWrOr7tEsEMQRLA
	fstcZRiH5RbucPE3icvu7ree7B1xk1IDtjwjwYOi+j+O1rv3FiEXRMQ5fCKrKdNvKuNt/b87xTn
	PUq45SnRv9WEym71opZj5feqPU/RLXc0t92Sy5dPfYMtxqGHrNBET7RcT2daJ93hDJ0odUuTixa
	CihDCNkhyMurVx22vFUMFKtsNkcvNxQRF6jxjWEZC+qPo6x5CL8e4XerdT1+msRO/uXj99dF4Mu
	VpvlG5/t8qOP6VIaUAN1Kbg9okrsr1Ry1kvKBB9J76Kb6Jbba4acUp/k5JF5iRLkSDABXSgmeqd
	9NYnq7YgFRwM68X8a64BpHR28NqaGSxD17/CPD37Ot1ZmtgjRhHiiRg9QOYMVzRQ=
X-Google-Smtp-Source: AGHT+IGdtKUBscgA9xYMmV3962XLu6gCj63wXPK/4bKpP1nVTjXzqxHi4UVk2L8ckDMtXKsc3B7ldA==
X-Received: by 2002:aa7:88c2:0:b0:771:e341:ce68 with SMTP id d2e1a72fcca58-771fc292e89mr6337778b3a.5.1756289439091;
        Wed, 27 Aug 2025 03:10:39 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm12813462b3a.79.2025.08.27.03.10.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 Aug 2025 03:10:38 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	atish.patra@linux.dev,
	anup@brainfault.org,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	catalin.marinas@arm.com,
	masahiroy@kernel.org,
	suzuki.poulose@arm.com,
	cuiyunhui@bytedance.com,
	maz@kernel.org,
	zhanjie9@hisilicon.com,
	yangyicong@hisilicon.com,
	dianders@chromium.org,
	mingo@kernel.org,
	lihuafei1@huawei.com,
	akpm@linux-foundation.org,
	jpoimboe@kernel.org,
	rppt@kernel.org,
	kees@kernel.org,
	thomas.weissschuh@linutronix.de
Subject: [PATCH 2/2] riscv: add HARDLOCKUP_DETECTOR_PERF support
Date: Wed, 27 Aug 2025 18:09:59 +0800
Message-Id: <20250827100959.83023-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250827100959.83023-1-cuiyunhui@bytedance.com>
References: <20250827100959.83023-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reuse watchdog_hld.c to enable HARDLOCKUP_DETECTOR_PERF and
add Kconfig selections for RISC-V.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/Kconfig           | 3 +++
 drivers/perf/riscv_pmu_sbi.c | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 451eb23d86c96..214b1ead5781a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -184,6 +184,9 @@ config RISCV
 	select HAVE_PAGE_SIZE_4KB
 	select HAVE_PCI
 	select HAVE_PERF_EVENTS
+	select PERF_EVENTS
+	select HAVE_PERF_EVENTS_NMI if RISCV_SSE && RISCV_PMU_SSE
+	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 8c1ac7985df6c..c5423a046d016 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -22,6 +22,7 @@
 #include <linux/sched/clock.h>
 #include <linux/soc/andes/irq.h>
 #include <linux/workqueue.h>
+#include <linux/nmi.h>
 
 #include <asm/errata_list.h>
 #include <asm/sbi.h>
@@ -1102,6 +1103,11 @@ static int pmu_sbi_setup_sse(struct riscv_pmu *pmu)
 }
 #endif
 
+bool arch_pmu_irq_is_nmi(void)
+{
+	return IS_ENABLED(CONFIG_RISCV_PMU_SSE);
+}
+
 static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
 {
 	struct riscv_pmu *pmu = hlist_entry_safe(node, struct riscv_pmu, node);
@@ -1525,6 +1531,8 @@ static int __init pmu_sbi_devinit(void)
 	/* Notify legacy implementation that SBI pmu is available*/
 	riscv_pmu_legacy_skip_init();
 
+	lockup_detector_retry_init();
+
 	return ret;
 }
 device_initcall(pmu_sbi_devinit)
-- 
2.39.5

