Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090192;
	b=a45zHPG0wT0jG6xcMevt0EG6s1D9WgRUlflyKUBoTNXFCLRXh8i4GnMPM4p6roEJbUKZ
	 Cxkm5dNQ8SHJsybtTTjS+Jyj3X+UaFudYUsUdmwKIjpOVxf5HBAs+XV8sbhYG3kDv0bLa
	 4qBI7WRwCQM+C6thqJKK3UbNNbeir3x80SOKm3fH4jhIZNrhyYU0ENaHPan19NVQcVfCQ
	 BtYDd2/wRmgRVy70Kk7vHd925mJvJnB9oX7apIml0wYHoDUTdZBqgqnzYNNcNkhjtby5S
	 69wYg06UBIwCu+ke+m6Zbe57RnaL44cOsXpUHzAZHo8W9sE/V7Dxz6enAmZXikn11uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090192;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AcX7Wqr/NNBAMKWd7VnVp8UuB/cxD1Kkn3PfU1E+a6g=;
	b=AWR59gAsjRlpdnDHJvwuHJJSXPp3e83JkvgVt6mETRDK5h7HATn2N+drfwsGHuYmwtan
	 GsHl0yKl54L8XsBkEIJv70ere3NSfJcNto8XDPk6HQWX0+az4tg2ep9sOci9M/brksNpH
	 RYzva6VH0/i+7V47zCTApg0Fc2thsrzShp0wtxmn6MTaGjc1jpY7259GOq44ODUlL9+Kb
	 d8FZ0ggioEktZz+lhQVF52TQCJcIniR/xnpTlpmaSohepN3fgT/m58ojyVnLa++y5mYiy
	 zWJcGf1r219Jk2epuufeiVtJxSrxMxVMmCzgvb3UhQlkup3l7CWgzjbYMbMQYnAiuDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b="i/y7IcXf";
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40BB606A336
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 12:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D40BB606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=i/y7IcXf
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36dbde64409so3703189eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 04:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1795090191; x=1795694991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AcX7Wqr/NNBAMKWd7VnVp8UuB/cxD1Kkn3PfU1E+a6g=;
        b=i/y7IcXf0zwGemgiNsqbgyLlyIpCBg5BrC6MYRFbLe0zMMYdR8CPiUInf+YtUvRT9B
         aS4uZ8O9wweMkDuRslNIlBBlX82ZeDuEOtJCA9YrxpD3blREpKkin/J+UDO9DSEUPYex
         Cdk3dIpVaSuZRKs+RJDPkVA5U64JWxulVXNjSTwbfq7S56j9A7IFy3SI9jesgcJQg/9H
         vszmXt7E3onYqEHwJckgW8fgPKNcSdgQ2BVKtHfsAJRft3COEMgzzgfAOIxeb6ZBmkQU
         tyBVnCqpSyAO4MzmPBgjynxwWdvW54oY1zvkPBoyh5eVbJcy1eUWJR5yBmK3ktI5ZJE3
         09Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795090191; x=1795694991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AcX7Wqr/NNBAMKWd7VnVp8UuB/cxD1Kkn3PfU1E+a6g=;
        b=AbQRwENEC4bJzIwq7264zV32mqWb0eHrpqGV1i97U67xwrd9ShQ+tG+U4BraF2+fde
         IGG1GWBGKKSl2AuN8SMj9+G7WfScc5Gxt1Dczl9HBeFZ2qr4L67YMzMhXFadAap6Cn09
         pQrNL9l4sJykCx3EGC9mFZVsFuCM+BkyJUVXHligRVZxlk1QnTY6Y334bNVqK0rzebB7
         7+O/ETAh4HpynoRyyAnvUPABuDP826OhUG8X3qHcOZcMjx1JWSvWjZ9lC91dWhEZDHE6
         Fhzf8MvUoE8sAjQb7bjgJ74i8xPgujpM7hrwHis2kea8ZxJTTV/9up5qyWqRkeqnzf4R
         6YyQ==
X-Forwarded-Encrypted: i=1; AL+hErHLMARnxEiHrcmaZRhzFv/Q7gwUv+JXCKbnqZcDuXnYNUiCowHILXfFnfQxbPRsL1l29IM7j07wKCG2gFj6+uL7@vger.kernel.org
X-Gm-Message-State: APuU4Z/h6Vkk5AbJPRVRKOymZrDi6GoU1BFeu+Il98Im7o7TuPmnk7zy
	f1XSTBh4rLp0V9+su4CcBaujJAt6tQVKDKUuLeS08NUUeoQkZV41pbC+T3D+BvB2Mlg=
X-Gm-Gg: AZFdTZcfi3Iqy21LliwcB44cxjGgVu9zwGm7MfehUWkVVrKjnLbORb5zuV4PxEPqIh8
	dB/JjWLvUq4SD3Hgg7U0LtrXbBGSrSivmj9oquYpcp4nxyfyw2GrKe4xJQBuuZyqK/lkozgAXpL
	amm27qr1dRRrjMrMQ/5cSY3x+MjQ4Km1VERTn0shYkKLcaSHS6Y3W8rrzBbFXpYCDNx7Jpt3EiT
	LHZi6UgveWOFNy0StIzPTlhdcis8uSi9c3Qy2kUIMzuinHSmxr8dL3iv9DPYkniJcy+OoY0svbZ
	RXT6Y7x1MAxFv83F+n0Tc/eKyk8dI8v3AWvR/+J5rL3QvSjjRypTPQn2GYkjWZFcpC7hIbnn79Z
	wM8aG7/2zUckxLfudPkCAgyIlVeYyHqq5zlL0PCldlzVC/A9lMWX+W7O5AH2eAFG03oG+LkLRHu
	/lwCniaT9Thqx7K/DXPs0JBAnIThpc61NSL0bsNPclK0p6J6aghBKSmsF37RbY6R3XRss9ipN7U
	vRX3zPeiQtlM4arUvoubuk4n0sNY7VBpFyF0ryaAd0HlbIM+MEqcehTbYiuCmMwTrvQAiyYWpR0
	lhDAe0MuBXHKnd6bECyYmrJspLjtYo9+qaGRQgyAt8FPpubSYaOm8iqQJF3nDeT3jkbAUQFKCCk
	mBFhyrrU=
X-Received: by 2002:a05:7300:8288:b0:384:6487:b155 with SMTP id 5a478bee46e88-3846487bba9mr1500897eec.29.1795090190796;
        Thu, 19 Nov 2026 04:09:50 -0800 (PST)
Received: from FJ7FR2JRQ3.bytedance.net ([186.240.245.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a7bc05cfsm17604650eec.26.2026.11.19.04.09.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Nov 2026 04:09:50 -0800 (PST)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	himanshu.chauhan@oss.qualcomm.com,
	conor@kernel.org,
	anup.patel@oss.qualcomm.com
Cc: clement.leger@linux.dev,
	cuiyunhui@bytedance.com,
	atish.patra@linux.dev,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	will@kernel.org,
	tglx@kernel.org,
	corbet@lwn.net,
	rdunlap@infradead.org,
	shuah@kernel.org,
	yuanzhu@bytedance.com,
	yang.susheng@zte.com.cn,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhangzhanpeng.jasper@bytedance.com
Subject: [PATCH v13 06/11] riscv: enable NMI-safe lockdep irqflags tracking
Date: Thu, 19 Nov 2026 20:08:30 +0800
Message-ID: <20261119120824.13969-19-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261119120824.13969-13-zhangzhanpeng.jasper@bytedance.com>
References: <20261119120824.13969-13-zhangzhanpeng.jasper@bytedance.com>
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

An SSE handler runs with interrupts masked, but can interrupt code whose
lockdep hardirq state is enabled. Bare nmi_enter()/nmi_exit() do not
update that state. Consequently, lockdep_assert_irqs_disabled() in the
perf overflow path can report a warning despite interrupts being masked.

Select TRACE_IRQFLAGS_NMI_SUPPORT so lockdep can update its hardirq state
inside an NMI. Pair this with irqentry_nmi_enter()/irqentry_nmi_exit() in
the SSE wrapper: these helpers save the previous tracked state, mark
interrupts disabled on entry and restore the tracked state on exit.
Selecting the configuration option alone does not perform those updates.
This follows the entry helpers used by the other RISC-V NMI-like traps.

Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 arch/riscv/Kconfig          | 1 +
 arch/riscv/kernel/sbi_sse.c | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d2db8f40c616..5501c02a07eb 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -225,6 +225,7 @@ config RISCV
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
+	select TRACE_IRQFLAGS_NMI_SUPPORT
 	select UACCESS_MEMCPY if !MMU
 	select VDSO_DATASTORE if MMU
 	select VDSO_GETRANDOM if MMU && 64BIT
diff --git a/arch/riscv/kernel/sbi_sse.c b/arch/riscv/kernel/sbi_sse.c
index 032fcc07abcf..59e47a39589d 100644
--- a/arch/riscv/kernel/sbi_sse.c
+++ b/arch/riscv/kernel/sbi_sse.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2025 Rivos Inc.
  */
-#include <linux/nmi.h>
+#include <linux/entry-common.h>
 #include <linux/sched.h>
 #include <linux/scs.h>
 #include <linux/bitfield.h>
@@ -36,9 +36,10 @@ void noinstr do_sse(struct sse_event_arch_data *arch_evt,
 {
 	struct riscv_sse_interrupted_context context = { regs, hstatus };
 	struct riscv_sse_interrupted_context *previous;
+	irqentry_state_t state;
 	struct sbiret sret;
 
-	nmi_enter();
+	state = irqentry_nmi_enter(regs);
 	instrumentation_begin();
 
 	/* Retrieve missing GPRs from SBI */
@@ -84,7 +85,7 @@ void noinstr do_sse(struct sse_event_arch_data *arch_evt,
 
 out:
 	instrumentation_end();
-	nmi_exit();
+	irqentry_nmi_exit(regs, state);
 }
 
 static void *alloc_to_stack_pointer(void *alloc)
-- 
2.50.1 (Apple Git-155)

