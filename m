Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794989657;
	b=rws8mdhgYd9P9weF7gXGNX+xgPw6VHvtC8QCrgWXkDhR1PUOxYq9wvDvH/4Lg8liQx08
	 DVobqVQWTpWaocm/ilDrAn2XS61vAPJvi8kqw/qq2JNoEiuxusXoipuHI34vRvJlhvduD
	 VHysTVy67UanQkU6beUGf5u+aXv6JGwIc5U/0EcrVl0SCSnxEVf9sxXwS+B7Q4SKGDn5o
	 xq/CQ9/koOeg3GRxrJxu2/I28z5s9yP2MEj5FQeoHpOr3BIsk6P78Vv97cZX65E9ItWU3
	 CK4r7LzGRlRlkg+0s5FI2ITip0ztU5UkqSLO5IRrn1hAgG96/pVmWfGL21wzWlEuQXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794989657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=M6p0MrJbihgz/aZk9vyBO68IX+8I6pof2cfx86gsggM=;
	b=3tVKux95+lokMI/6L1wmDCtgCme6CwW+EsJLwPVzMqE4JT0wBsG/KA6redikRlDbvVM8
	 6Poaam9Ydfn7kLQLiINNQjC69w+kUWcTA4KD/iy0mm/0RkEK1e4cJhhRGH0od/eRD8nPs
	 H93fKNKvqXFFcsDPMCmceQi1s4dVHQXt2aVu9S5jJUEw8CMpXCrlyrymHov+RLRl8ZgjS
	 3fG96C87xdYVBmiD/rZc4jKM4bkDcdH6PlV9t0Qhjv6W3CuG5xluMdWstibfGZj3yRnaE
	 jh3E76GxKwX7Iij+V8dwjntgZgSsd3XHzCMaddmgmgqvzN4ONc8zvGR9+T/nG3iHvnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b="Z5t/7YWk";
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401F3606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 401F3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Z5t/7YWk
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdb45e96d2bso491693a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 00:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794989656; x=1795594456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M6p0MrJbihgz/aZk9vyBO68IX+8I6pof2cfx86gsggM=;
        b=Z5t/7YWkaI8bEKrZGiwMKh/UA5yMGXR/Prny7rzJ5DbGjEAG9ymDoXMVuy7frEYHDn
         Yuc+MhlLxzDQnMIyl8Y5eeahgxdQZA7lq7whh0X/EC3BjaZa6xMtXiVfU/PAUJYXjNvt
         tuCrphGdrXtB5bKclZ6pQTcLI9o5lTvEZ7qdzyPUkRqHuAhgY+A+kahJkbwspit0/c4L
         wCJk2N3RlBskjYDgUzEX3Lvs4pJqhGHiWJfC96j794xrA5YR96EYJ04Ers9cy6+5ZOmn
         IPdBAFWHoapThr3Ym5MeTJ8jXwtZB4x0JRUKD/rBOlewRTIj3tqJ0biIiB1CDCou4NCV
         nUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794989656; x=1795594456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M6p0MrJbihgz/aZk9vyBO68IX+8I6pof2cfx86gsggM=;
        b=aA/Doirg1ZO1qWu10n0BWZoGxEpuqPBNyFX/Mfw+vcivlzCn5pDQJflXyCEkz6FbzE
         Awn95V05XCiOoAifd22W5F6qzC0oYRs8/uZLvoLkQvoEtWQwPJ5XBq7xmDABMqcf/1eO
         0slU4Yy0IAqY9tttKFv9M4B5FdW7Y84epABh1Wqd/6ZaNrvqvTPRHxLPhzUt2G9irF8+
         GgqO/8Qzu2R5PO0hz+0j/Q2/yXnZx7ukAD+2UX9SRtGLnLJyZIUcebdwUTGtFY1I60Ud
         4EufYSKwo9PP+YB1Nk/4tGNvSXMshSaGIJJV/FR0zv93njfZPwKytIXj0K1i/O8i4ccq
         eFVQ==
X-Forwarded-Encrypted: i=1; AL+hErEEZV4ch85yFTTQ0mvLhyegQKBTVrX5VLloJfoy8B7iXXZgmPtxNH6pql69CuaJCE9xE199Ewc0+CdJ/yaAajtP@vger.kernel.org
X-Gm-Message-State: APuU4Z8HLIELs0v9PdISggvCwijGRo956S5eJbVXcScgfAf/oMKDpN1I
	NfJt+/Pug7zOAOaK3x/VCvKx9KW57pEEcSfAM/lAgc/m8+AQ5wwvBlHcjX/Iqt9xOZs=
X-Gm-Gg: AZFdTZcTiAvo9v/8Vmq/VOZONzp3aYricfVF0SMA2mR1JBA11a7WQ5efm6N1A19/Qhw
	Vg6C3Y1XJVQCm6p7kn+AcevchIbiOsOp/xvCAHuw1nX4/9q/UnTunBDN3oXTVYgenFmigQSqUml
	fGX4/TK98284C1YWJlfKxfVJlNjMCrSGvTsPjuhxbDAcPa8QNL9qmEUTI3KEX3U+eVjY0FaDvk9
	J8LFNQvAp7qhWvYMHBY7ngY/y9ESPuphIVBekTR/kf1CrvjPgfZttPGEYl50g98nobhl/Iulonj
	pd+mcjKTOfikFqclOEaVd+XNz0OYhlNQ2+/fYV2lxI0NT69mL8X8yp63HmMfICDwWhort7JrPo8
	dfnxeOvn31g28CSd2+lCYFZsbLewoWoPA2XvtoW9Sh05d4aO8lspAUWA44eeKPhWEuPh4RwHQx+
	1mtIn7eeoJRe8HjoytJMdqVKs7xSnILsExITyqZDXH5QCjA26UqWOiR0+zAiAL+Pb1nll9vKSOz
	vEWefmxPY/PqITEm60afsVkL/VHBYJdBXoJkqMq89ldv6UU4k07j0FKDjnNWa9bLCAjXcJsxFhX
	yon99oN4C9GJdJ9Qx1tr2U5p+W1ujcOUcqoXusG6B85x4din66boLXleS8zpPE9CAXb1aTu3ySi
	6yk6TCFw=
X-Received: by 2002:a17:90b:1809:b0:39e:6a7e:ee18 with SMTP id 98e67ed59e1d1-3b3d07ab0f8mr1937736a91.36.1794989655517;
        Wed, 18 Nov 2026 00:14:15 -0800 (PST)
Received: from FJ7FR2JRQ3.bytedance.net ([186.240.245.239])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d1acde50sm3254680a91.14.2026.11.18.00.14.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 00:14:15 -0800 (PST)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: linux-riscv@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	andrew.jones@linux.dev,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	atish.patra@linux.dev,
	anup@brainfault.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	yuanzhu@bytedance.com,
	cuiyunhui@bytedance.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	will@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: [RFC PATCH v1 4/5] perf: riscv: Add PDIS event and counter callbacks
Date: Wed, 18 Nov 2026 16:13:32 +0800
Message-ID: <20261118081327.10684-11-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261118081327.10684-7-zhangzhanpeng.jasper@bytedance.com>
References: <20261118081327.10684-7-zhangzhanpeng.jasper@bytedance.com>
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

Manage the independent PDIS counter as a CPU-wide, fixed-period perf
event. Track partial periods on read and stop, preserve the remaining
period across resumes and claim each observed delta once on nested
reads. COUNT and sticky OF cannot report multiple unobserved reloads,
so the event count is an estimate.

Quiesce PDIS at task boundaries to keep task metadata with its sample.
Keep the remaining interval across a switch. The model must cancel
in-flight selections when software inhibits PDIS and clears spdisctl.
Keep the PMU unregistered until overflow delivery is wired up.

Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 drivers/perf/riscv_pdis.c | 315 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 312 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/riscv_pdis.c b/drivers/perf/riscv_pdis.c
index b7671e5ad63e..9a8fe5e4ab82 100644
--- a/drivers/perf/riscv_pdis.c
+++ b/drivers/perf/riscv_pdis.c
@@ -1,11 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Experimental RV64 PDIS CSR-output PMU for an explicitly matching model. */
 
-#include <linux/bits.h>
+#include <linux/bitfield.h>
 #include <linux/cpu.h>
+#include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/of.h>
+#include <linux/perf_event.h>
 #include <linux/percpu.h>
 
 #include <asm/asm-extable.h>
@@ -24,15 +26,41 @@
 #define RISCV_PDIS_CSR_FILTER		0x5e4
 #define RISCV_PDIS_CSR_VSCTL		0x6d0
 #define RISCV_PDIS_STATEEN		BIT_ULL(55)
+#define RISCV_PDIS_CTL_SEL		GENMASK_ULL(2, 0)
 #define RISCV_PDIS_CTL_ACC		BIT_ULL(33)
+#define RISCV_PDIS_CTL_U		BIT_ULL(60)
+#define RISCV_PDIS_CTL_S		BIT_ULL(61)
+
+enum riscv_pdis_select {
+	RISCV_PDIS_SELECT_ALL,
+	RISCV_PDIS_SELECT_LOAD,
+	RISCV_PDIS_SELECT_STORE,
+	RISCV_PDIS_SELECT_LOAD_STORE,
+	RISCV_PDIS_SELECT_CONTROL,
+};
+
+#define RISCV_PDIS_SAMPLE_TYPES (PERF_SAMPLE_IP | PERF_SAMPLE_TID | \
+				 PERF_SAMPLE_TIME | PERF_SAMPLE_ID | \
+				 PERF_SAMPLE_STREAM_ID | PERF_SAMPLE_CPU | \
+				 PERF_SAMPLE_PERIOD | PERF_SAMPLE_IDENTIFIER)
+
+/* A policy limit for the experiment, not an architectural minimum period. */
+#define PDIS_MIN_PERIOD	4096
+
+/* prev_count holds the 32-bit position and the overflow accounting bit. */
+#define PDIS_OF_ACCOUNTED	BIT_ULL(32)
 
 struct pdis_cpu {
+	struct perf_event *event;
 	bool ready;
+	bool counter_valid;
+	bool switching;
 };
 
 static DEFINE_PER_CPU(struct pdis_cpu, pdis_cpu);
 static cpumask_t pdis_cpus;
 static bool pdis_test;
+static struct pmu pdis_pmu;
 
 static int __init pdis_test_setup(char *str)
 {
@@ -82,6 +110,7 @@ void riscv_pdis_cpu_starting(void)
 	unsigned int cpu = smp_processor_id();
 
 	pcpu->ready = false;
+	pcpu->counter_valid = false;
 	cpumask_clear_cpu(cpu, &pdis_cpus);
 	if (!pdis_test || IS_ENABLED(CONFIG_KVM) ||
 	    !riscv_cpu_has_extension_unlikely(cpu, RISCV_ISA_EXT_SSPDIS) ||
@@ -119,19 +148,299 @@ void riscv_pdis_cpu_starting(void)
 	cpumask_set_cpu(cpu, &pdis_cpus);
 }
 
+static void pdis_clear_accounted(struct perf_event *event)
+{
+	local64_t *prev_count;
+	s64 prev;
+
+	if (!event)
+		return;
+	prev_count = &event->hw.prev_count;
+	prev = local64_read(prev_count);
+	while (prev & PDIS_OF_ACCOUNTED) {
+		if (local64_try_cmpxchg(prev_count, &prev, (u32)prev))
+			break;
+	}
+}
+
 static void pdis_quiesce(void)
 {
 	csr_set(CSR_SCOUNTINHIBIT, RISCV_PDIS_COUNTER_BIT);
 	/* The test-model contract requires this to cancel in-flight selections. */
 	csr_write(RISCV_PDIS_CSR_CTL, 0);
+	pdis_clear_accounted(this_cpu_ptr(&pdis_cpu)->event);
 }
 
-void riscv_pdis_cpu_dying(void)
+static int pdis_check_period(struct perf_event *event, u64 period)
+{
+	return period >= PDIS_MIN_PERIOD && period <= U32_MAX ? 0 : -EINVAL;
+}
+
+static int pdis_event_init(struct perf_event *event)
+{
+	struct perf_event *sibling;
+	u64 mode;
+	int ret;
+
+	if (event->attr.type != pdis_pmu.type)
+		return -ENOENT;
+	if (event->cpu < 0 || event->attach_state & PERF_ATTACH_TASK ||
+	    event->attr.inherit || event->attr.freq || event->attr.exclusive ||
+	    event->attr.aux_output ||
+	    !is_sampling_event(event))
+		return -EOPNOTSUPP;
+	if (!cpumask_test_cpu(event->cpu, &pdis_cpus))
+		return -ENODEV;
+	if (event->attr.config > RISCV_PDIS_SELECT_CONTROL ||
+	    event->attr.config1 || event->attr.config2)
+		return -EINVAL;
+	/* Discovery requires host-only execution; an explicit H is optional. */
+	if (event->attr.sample_type & ~RISCV_PDIS_SAMPLE_TYPES ||
+	    event->attr.exclude_host ||
+	    event->attr.exclude_idle || event->attr.precise_ip ||
+	    event->attr.exclude_user == event->attr.exclude_kernel)
+		return -EOPNOTSUPP;
+	if (event->group_leader != event && event->group_leader->pmu == event->pmu)
+		return -EINVAL;
+	for_each_sibling_event(sibling, event->group_leader) {
+		if (sibling != event && sibling->pmu == event->pmu)
+			return -EINVAL;
+	}
+	ret = pdis_check_period(event, event->attr.sample_period);
+	if (ret)
+		return ret;
+	mode = event->attr.exclude_kernel ? RISCV_PDIS_CTL_U : RISCV_PDIS_CTL_S;
+	event->hw.config = FIELD_PREP(RISCV_PDIS_CTL_SEL, event->attr.config) | mode;
+	event->hw.idx = -1;
+	event->attach_state |= PERF_ATTACH_SCHED_CB;
+	return 0;
+}
+
+/* COUNT is frozen by the caller; OF is sticky until acknowledged. */
+static void pdis_event_update(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	u64 period = hwc->last_period;
+	s64 prev = local64_read(&hwc->prev_count);
+	s64 delta, next, step;
+	u32 progress;
+
+	do {
+		u32 count = csr_read(RISCV_PDIS_CSR_COUNTER);
+		bool pending = csr_read(CSR_SCOUNTOVF) & RISCV_PDIS_COUNTER_BIT;
+		bool accounted = prev & PDIS_OF_ACCOUNTED;
+
+		progress = count + (u32)period;
+		/* COUNT may have overflowed without reloading yet. */
+		if (progress >= period)
+			return;
+
+		/* OF can reveal one wrap; multiple unseen wraps cannot be recovered. */
+		step = (s64)progress - (u32)prev;
+		delta = step;
+		if (step < 0 || (pending && !accounted))
+			delta += period;
+		next = progress;
+		if (accounted || pending || step < 0)
+			next |= PDIS_OF_ACCOUNTED;
+	} while (!local64_try_cmpxchg(&hwc->prev_count, &prev, next));
+
+	local64_add(delta, &event->count);
+	/* Apply the position change without overwriting a nested update. */
+	local64_sub(step, &hwc->period_left);
+}
+
+static void pdis_update_and_quiesce(struct perf_event *event)
+{
+	csr_set(CSR_SCOUNTINHIBIT, RISCV_PDIS_COUNTER_BIT);
+	pdis_event_update(event);
+	pdis_quiesce();
+}
+
+static int pdis_program(struct perf_event *event, bool reload)
+{
+	struct pdis_cpu *pcpu = this_cpu_ptr(&pdis_cpu);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 period = hwc->sample_period;
+	u64 left = local64_read(&hwc->period_left);
+	u64 counter = 0;
+	unsigned long actual;
+
+	pdis_quiesce();
+	if (reload) {
+		u32 initval = -(u32)period;
+		u32 count;
+
+		if (!left || left > period)
+			left = period;
+		count = -(u32)left;
+		counter = (u64)initval << 32 | count;
+		csr_write(RISCV_PDIS_CSR_COUNTER, counter);
+	}
+	csr_write(RISCV_PDIS_CSR_CTL, hwc->config);
+	actual = csr_read(RISCV_PDIS_CSR_CTL);
+	if ((actual & ~RISCV_PDIS_CTL_ACC) != hwc->config ||
+	    (reload && csr_read(RISCV_PDIS_CSR_COUNTER) != counter)) {
+		pcpu->counter_valid = false;
+		pdis_quiesce();
+		return -EOPNOTSUPP;
+	}
+	if (reload) {
+		hwc->last_period = period;
+		local64_set(&hwc->prev_count, period - left);
+		local64_set(&hwc->period_left, left);
+		pcpu->counter_valid = true;
+	}
+	return 0;
+}
+
+static void pdis_enable(struct perf_event *event)
+{
+	struct pdis_cpu *pcpu = this_cpu_ptr(&pdis_cpu);
+
+	event->hw.state = 0;
+	if (!pcpu->switching)
+		csr_clear(CSR_SCOUNTINHIBIT, RISCV_PDIS_COUNTER_BIT);
+	perf_event_update_userpage(event);
+}
+
+static void pdis_start(struct perf_event *event, int flags)
 {
 	struct pdis_cpu *pcpu = this_cpu_ptr(&pdis_cpu);
+	bool reload = (flags & PERF_EF_RELOAD) || !pcpu->counter_valid;
 
-	if (pcpu->ready)
+	if (!pcpu->ready || pcpu->event != event ||
+	    !(event->hw.state & PERF_HES_STOPPED))
+		return;
+	if (!pdis_program(event, reload))
+		pdis_enable(event);
+}
+
+static void pdis_stop(struct perf_event *event, int flags)
+{
+	struct pdis_cpu *pcpu = this_cpu_ptr(&pdis_cpu);
+
+	if (event->hw.state & PERF_HES_STOPPED)
+		return;
+	/* Save progress even on a stop for throttling. */
+	if (pcpu->ready && pcpu->counter_valid)
+		pdis_update_and_quiesce(event);
+	event->hw.state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	perf_event_update_userpage(event);
+}
+
+static int pdis_add(struct perf_event *event, int flags)
+{
+	struct pdis_cpu *pcpu = this_cpu_ptr(&pdis_cpu);
+	int ret;
+
+	if (!pcpu->ready)
+		return -ENODEV;
+	if (pcpu->event)
+		return -EAGAIN;
+	ret = pdis_program(event, true);
+	if (ret)
+		return ret;
+	pcpu->event = event;
+	event->hw.state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	perf_sched_cb_inc(event->pmu);
+	if (flags & PERF_EF_START) {
+		pdis_enable(event);
+	} else {
 		pdis_quiesce();
+		perf_event_update_userpage(event);
+	}
+	return 0;
+}
+
+static void pdis_del(struct perf_event *event, int flags)
+{
+	struct pdis_cpu *pcpu = this_cpu_ptr(&pdis_cpu);
+
+	pdis_stop(event, PERF_EF_UPDATE);
+	pcpu->event = NULL;
+	pcpu->counter_valid = false;
+	perf_sched_cb_dec(event->pmu);
+}
+
+static void pdis_read(struct perf_event *event)
+{
+	struct pdis_cpu *pcpu = this_cpu_ptr(&pdis_cpu);
+	unsigned long inhibit;
+
+	if (!pcpu->ready || !pcpu->counter_valid || pcpu->event != event ||
+	    (event->hw.state & PERF_HES_STOPPED))
+		return;
+	inhibit = csr_read_set(CSR_SCOUNTINHIBIT, RISCV_PDIS_COUNTER_BIT);
+	pdis_event_update(event);
+	if (!(inhibit & RISCV_PDIS_COUNTER_BIT))
+		csr_clear(CSR_SCOUNTINHIBIT, RISCV_PDIS_COUNTER_BIT);
+}
+
+/* Drop pending selections before changing the task used for sample metadata. */
+static void pdis_sched_task(struct perf_event_pmu_context *ctx,
+			   struct task_struct *task, bool sched_in)
+{
+	struct pdis_cpu *pcpu = this_cpu_ptr(&pdis_cpu);
+	struct perf_event *event = pcpu->event;
+
+	pcpu->switching = !sched_in;
+	if (!pcpu->ready || !event || (event->hw.state & PERF_HES_STOPPED))
+		return;
+	if (!sched_in) {
+		pdis_update_and_quiesce(event);
+		return;
+	}
+
+	/* Restore selection without resetting the counter. */
+	if (pdis_program(event, false))
+		pdis_stop(event, PERF_EF_UPDATE);
+	else
+		csr_clear(CSR_SCOUNTINHIBIT, RISCV_PDIS_COUNTER_BIT);
+}
+
+void riscv_pdis_cpu_dying(void)
+{
+	struct pdis_cpu *pcpu = this_cpu_ptr(&pdis_cpu);
+
+	if (pcpu->ready) {
+		if (pcpu->event)
+			pdis_stop(pcpu->event, PERF_EF_UPDATE);
+		else
+			pdis_quiesce();
+	}
 	pcpu->ready = false;
 	cpumask_clear_cpu(smp_processor_id(), &pdis_cpus);
 }
+
+PMU_FORMAT_ATTR(select, "config:0-2");
+static struct attribute *pdis_format_attrs[] = { &format_attr_select.attr, NULL };
+static const struct attribute_group pdis_format_group = {
+	.name = "format",
+	.attrs = pdis_format_attrs,
+};
+
+static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&pdis_cpus));
+}
+static DEVICE_ATTR_RO(cpumask);
+static struct attribute *pdis_attrs[] = { &dev_attr_cpumask.attr, NULL };
+static const struct attribute_group pdis_group = { .attrs = pdis_attrs };
+static const struct attribute_group *pdis_groups[] = {
+	&pdis_format_group, &pdis_group, NULL,
+};
+
+static struct pmu pdis_pmu = {
+	.task_ctx_nr = perf_invalid_context,
+	.capabilities = PERF_PMU_CAP_NO_NMI,
+	.attr_groups = pdis_groups,
+	.event_init = pdis_event_init,
+	.add = pdis_add,
+	.del = pdis_del,
+	.start = pdis_start,
+	.stop = pdis_stop,
+	.read = pdis_read,
+	.check_period = pdis_check_period,
+	.sched_task = pdis_sched_task,
+};
-- 
2.50.1 (Apple Git-155)

