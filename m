Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793260231;
	b=CXpV1KbT7KusWgZh+Kj55urXK9mlDuymZajCsdNTKh2y0LwZ21gR7twXyJPlWCBe40mv
	 42gIKA2BvvY7djUARzfxTp+qn4SL5xy7nlcV12UkCvhR1IScqjJ15yRjNhqUaGhm9zKC/
	 RJB/RvJVxinqeO0THWj1wyYfA19EXTrxE0PO80oD1+G0L+KCsVOy0duKzPkXP9K55hQW1
	 TKQ4s3qjqdn8/HTOxmJhNB/u/TR18YS+aqzUjyJoMqR732WyvP5j+RAYR0WUwFS3fQc4V
	 iKZue6lo9g0u0R1iFB/eIKD7itSdeYgrH2bEXvAfkbeTTXFGfDoyHQXcquqOB6zEe5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793260231;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oepihVkZlK/qzYmwSGek/f6xpe+tahIK2SzRmS26BHM=;
	b=JS7UJnxCG28e6WeZq6AW/9042sUHvvFvkq8sWyU65hSvtL9smw6h0j2VebEwEeFuphFU
	 Owitl3HqzDzpO3b34+A3nIu3+AEq0yW0HmTQPPSpkAC1Kx/dhjgIqRVLHj04JI0+uLo1N
	 DdYxSLoQuVN/zaKbrqPib6cZPGuD9LMCmFeRqdzZxBMJcj/G5xuTM14pOCoCFXtTrYdVf
	 +5j1MpVltT5+GNyxO1J3JVM8eeT0p3daB2U+I2C2V4uPbwIhejCwi2nagTdELsYKT6yUO
	 qEs38FVS8SJ0nr1tFWiqmL5Zci8/Vlxce5LXqM71toN26wBFJPH7AF2rCFbhInysNNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=jz6BzEJm;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EC6606A338
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 07:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94EC6606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=jz6BzEJm
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e9f6a16aedso11806765ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 00:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793260230; x=1793865030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oepihVkZlK/qzYmwSGek/f6xpe+tahIK2SzRmS26BHM=;
        b=jz6BzEJmohQMGYzs4LlydOev8edMU0iNAlDKRwqDhgVfQz5X7APQbZgh1/ZfqPkCpF
         BxuIx3Fyb9lpq7XzBEemFlsPxAjvOiGeJzPUQWhDNwvW6CA01c8zw9gismLg5ZxNAyJC
         OTazykQsCZlEaxgl0NdQ++7YDNoYzeNZoGUL4jVOvv8tKy6jQ7KaVqactLjrUHfOzdCT
         fzhTYb657jWtvAmfNDB5PA4vdkC6sxnfcvLx3Qjud2nh5p5HzZAXpf0IrRZYpforERBM
         dqIK4MJT3JMv4obZN6XK4DVImNKc0eMyb/vTIr88L5qxO67hNZwtfq7qhtOwUxBHcY+9
         MOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793260230; x=1793865030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oepihVkZlK/qzYmwSGek/f6xpe+tahIK2SzRmS26BHM=;
        b=WGSAj3WrHoslyj9k9ckz7DM3b3XAaJoSJCT63fBDhhEBBGGTiAgcUIRXfMmSPlwyMk
         Jl+NT5Nv27L1OvNNZHLHEH6VoBc+SWMv6TN5FM50GwBfZOHIXqeKmmTwW+eo9MfAbZKN
         fF5iibEFRNWYOFPTBb2n2w5Ys4Kgvd9kwsdj0Mm6rOSJFa/DZI7Iqf+EBogU1K5Y+soQ
         DMm+rVs1GpI5qjfh/PsHJJWDpvpUvkJIsPl0QpIe8lWavJAcIAg1rjQDeeARGSeEFfcd
         ZxSenqyp/GQ4av6z0lTkIi+kENVimP3UcyUGq3NoiDhNLqMs7Ghht9JBx2wu02wdJhxU
         LhFg==
X-Forwarded-Encrypted: i=1; AKwUvBzcXComxdoRjDiSwkogWgMZXG9JRMJE+olsd6fE+4rGKYtpIoty9G32qlcaik4JbzGf4MOga3NxeIc9Ny6LxEkL@vger.kernel.org
X-Gm-Message-State: AFq9FYKVi7k5YoYbJ0wrLGCXV+L8Wzn35gCF3P9lVgKcESR6HNF34V29
	fqasMf6wD9BG05SDLnndMMXn4Qq2edBzPC/trQlStFUvmDBPI/5yycidIO6o55m0LBE=
X-Gm-Gg: AYBFou0SFuxc/TEkBB5TQBVTi907BbU8M0tcpdmI8vtmaSsRbWX8zoY7iq3TibHPr18
	veQByWgAgxG50zmdB8WOs1lgfLQ/m674qm2ESpCGYmWGzPTEi62/kasEXzYJhEBJT1rXMvirxCW
	KN8OVQz40gHdEogEuVbJzjEOS1VzngL6G8ijvyMtuZo8roDu1kPJalxoxdVlz8p6DpgBw+ko/QK
	uHUMnrdA7KOVu4cp7eRvGwJ/1RgSCMIqZWDK9mdxgi4rX28WtzYOFc7JBqJWbPKCH3eLRjEulCp
	ySBehjzos1xEwNDwYs8tQN7mC+JNmWBXYBTguYWL0gaML3cakyJxf3YThxEuoH/HKQHf7n3TzSU
	Ad8HKJZ+OcRKQX2EJobmpeCDoeiaZATYDwvhyTBYNhau7Sbd8z2JszpWlu3DvnNmbWwoBqo6YE5
	yjUpjOC6GOkocOfWsbgYtLU7a8QIOZ2h2S5hRZrmUSuoHRcQ/Xjri8/WNwggRd6qNLz+/z4ND5Q
	6tKXumIOWFnERY1Khu1IChhKBBXtBANeLxR8/b2P+uWSPRZZ2mRyju7KjSHLtJjbsZfBTKGe3p+
	CJW8aVuHVTTuRthuUCKrV2pJTRk3EI2MZImJi5kO0hwmkZgSCWY4DdlJ4XEEchowWdeL0lKEfGT
	lrlbDd6s=
X-Received: by 2002:a17:903:3c28:b0:2e9:3f26:5d83 with SMTP id d9443c01a7336-2eb004000b6mr42659455ad.12.1793260229799;
        Thu, 29 Oct 2026 00:50:29 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([186.240.245.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6bd60desm30598915ad.29.2026.10.29.00.50.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 00:50:29 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>,
	Conor Dooley <conor@kernel.org>,
	Anup Patel <anup.patel@oss.qualcomm.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Atish Patra <atish.patra@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	yuanzhu@bytedance.com,
	yang.yicong@picoheart.com,
	yang.susheng@zte.com.cn,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Subject: [PATCH v12 06/11] riscv: enable NMI-safe lockdep irqflags tracking
Date: Thu, 29 Oct 2026 15:48:48 +0800
Message-ID: <20261029074853.35467-7-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261029074853.35467-1-zhangzhanpeng.jasper@bytedance.com>
References: <20261029074853.35467-1-zhangzhanpeng.jasper@bytedance.com>
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
index 467a877445a..dea30784fc7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -228,6 +228,7 @@ config RISCV
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
+	select TRACE_IRQFLAGS_NMI_SUPPORT
 	select UACCESS_MEMCPY if !MMU
 	select VDSO_DATASTORE if MMU
 	select VDSO_GETRANDOM if MMU && 64BIT
diff --git a/arch/riscv/kernel/sbi_sse.c b/arch/riscv/kernel/sbi_sse.c
index 032fcc07abc..59e47a39589 100644
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

