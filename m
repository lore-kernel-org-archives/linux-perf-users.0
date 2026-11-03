Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674930;
	b=fX3Pw50HRDzC4Ed6rgEzaCh3KRLJo7mH1DRIp1Fhz5NSt1R57dIj2CutCAIi7c3kJ+St
	 nTPD3KFYUbCRmVIEOhbGFi2eeiAjrisPfP+zl+vrT7VwFRSa56YhvpLO6dZaqJ0Kn4wHT
	 3qD9cRuwHzIKYyYtewZY885VVmdmQ6/4vrIQVOKOFHa1dYPUPHJZ+8xgzZKKs3oaOi8pJ
	 DFQE4UlZnimsj51gjyX5zWswk7OHt2S2AstxopN+SsRWNCpbY7kghclM4wBAi74xOgBGe
	 SSB+9k1TZMymt0Y1caqjuSujHMrsHSYCD77xZYwVNNbtYqcYq1ijLvLszOJmF1goOPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=uC9kxl4fA44IIapyYI2sde21YezfCtM8PjKPIO7jPX8=;
	b=xd7KjpNS8I+s9iVk6LyCpBKU7wp51TY96r/fhmrvNJgE5SzEb4yYSh1fYHH2Vwk5Vq73
	 yrdNAgTkTf1ChLd7iG0J987SV3W/XX2BRO52KcVP6ymptFMW9LHfUjbWtAaUUPzJmMeiL
	 pHuqgniaYtWJbHpGPsZa6+1wrm/AxHUwenEND6xJVYn2VNKAcEFdY4yzFQlaCtS41GUvl
	 U8vpX87bIj+Lie3oOcIxyTL1IdGcu5FgcozjVRd9Eu/cdQIbJZCtMUW3IKE0wU3xoP25y
	 TQnhzHg9p9YV92v1xYmSV5Y6moVIXsdQkbDv8E3nhT9O+LoERdOxilCyyKzPrLn0TIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VbX6XzaF;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA13606D80C
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 03:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDA13606D80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VbX6XzaF
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b0a28a720aso36114137b3.2
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 19:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793674929; x=1794279729; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uC9kxl4fA44IIapyYI2sde21YezfCtM8PjKPIO7jPX8=;
        b=VbX6XzaFGBB0utCkrKHnieSfSDm0rrCUWitu7ZZwVWa2WWmPykiTlDqbyStZea1RkL
         4MlRyQQB9da7OHH91GD5eSGbiym1ioCE2nGkpc5a4z9oFQnI4Fb0VKnRE4FO1Cb9A9yC
         YzJK3e4GzTlGGTJV7U9SEWWxrSpQMJUnD1Lu4XSIdgHskxgfjzsiYFOaVD/734qOLq0O
         nQOM5dU/r8RuQWd/s0i2O13Sr+/oX1oaOUQqPfEwq/IOOGoS15U9WXYW6bQF3opMOBLg
         IzzDzjF7VCPqjeJibbpbqlmXRh/lSJN3RllmH0YsEwMqn3mPjCbYq6Ty6p3ZWbPSwkda
         siXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793674929; x=1794279729;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uC9kxl4fA44IIapyYI2sde21YezfCtM8PjKPIO7jPX8=;
        b=eTCZGNiJojAwOjgWihzMKgfEKdEzBEq1Ltgg0JnqTdaPNbir9O7GtAk1kbuPLCHb70
         Khh3CwRGJJqJ21TJCglfIW3Ik/TjnaLk0qp1VRX0s6a/Jekz1+dctZKZ3B8N/nsX9xBk
         KIJ8i1d17RrujmLxew8tf4tkSaPBmgt/+sNecnWijGene00S0Q9pWYEx6/SHOpYtZ9wO
         OSGlw2v2kupnydFg//0XAwtJQVNUh23W3q8kmdnfAvbWaItjlBwGROxgEUAoP3VmplpU
         cbkXaVsNXsRKfiD5XOGpoW1J22LDwlYZscfb7+vYWiRb89fZA0DBVaEUj6qInWl2gdKe
         FbJQ==
X-Forwarded-Encrypted: i=1; AKwUvBxlfGromZoUZbRUuj3qpH7hsHuXIlPL+kgucF5AnHUu+9vmaTX056vzR85CtYFyEH0bPWZuKOg2sDrC5hNPLo4Z@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZwGfbg68OMmqCNUmkJe0YUSROklju0mTC8Un4Wz3vFfXum7fa
	Ulaowoun2anyDTpXS+uM/4o5DPB16vlltxTpm1H2gImQbAbUBPtcMX5o2Ad3J0af
X-Gm-Gg: AYBFou1X+pdpRDJwXM9MDOyqUXDqixqMLHJ0KtgayWIMni+1ESwuweHIIaJNzZfm4vp
	8iOK6V9FtSbfy/Bzw2Cy23GvVM0mc+XqoqATWlJqLNOQo05Cqv41XuoNdnhd5dU4KZ3kjoIh34d
	Ap+xCChnWOX3F8H4GuTBjuvD0nEg5DhC5HjHQcxXLzH6Eey6Dp9c7OeqGv0zlf42Af+NyBuWf6d
	Polbe1b3slTg/TQgJlWj6qC4H4ZmBpVGatY8WvFhXFPN7xT9z5QaGbXB3hwYA7ncd8hNXaVhT2w
	rPFT2G1GwFoKDujGysWMHuDQb62bovB/y5lkD7B5nFJTGleBph5zxsZZ/d6HbWN8CP0+0fzE8dP
	AOOB8lkWibvLZp82GVuwd8BiKmO2klXSt9mSKmynF/GC1fPgWQpZZeDzdO1KaZ1cHa83+9U3Gvo
	xWgHn+d8uNTsv/l4xiMctUq0TenvTnYVBr6k0vvFV3fPUtMp+zC72t/7Tx82jqrBjk9efFFWPKh
	k1cYmZfOqYojxRyob3NhmqXYHWhIxFa1M8F2RxGEMKmE1pZHxejsFOMzYTmgRj3fQALAGNW5P37
	keHaTxvKe3VfeQ+WOnXIBKgszA1qIvTT2hBalF3HAXMJN5sR10N8BS91drXWOEwSXfI8fXSCt2G
	MTNHqn/UM2Q==
X-Received: by 2002:a05:690c:9216:b0:8b0:dfd0:5693 with SMTP id 00721157ae682-8b2b67266afmr75608607b3.36.1793674928767;
        Mon, 02 Nov 2026 19:02:08 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b714cfc1sm64795607b3.20.2026.11.02.19.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 19:02:07 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 02 Nov 2026 22:02:00 -0500
Subject: [PATCH v4 5/7] alpha/perf: implement ProfileMe sampling
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-alpha-profileme-v4-5-61e00f5e1da8@gmail.com>
References: <20261102-alpha-profileme-v4-0-61e00f5e1da8@gmail.com>
In-Reply-To: <20261102-alpha-profileme-v4-0-61e00f5e1da8@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=20652; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=LcyS+R97AYBNckpmA47TtPqKZ8GNow1+ur+fu6/YMzQ=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLJe+i0+56/G8fqs8IYsiStl9XVXN/30ul9RNG//+1mM3
 /b/u7rKreMjC4MYF8NMMUWWuPWKLLPadiz1OS39C2YOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MwQydIziIXJ6DBqZxcWlqUW6aQVFDnn5JYklmfl5xXr5Bal5BekFemmZaSUZGflFxalAI/TyUkt
 MXR3djAwNTCwdLcycLBxNTZydnQyd3BwdnV2djCzNTQycLR1NXC3NGbg4BWCuabjByDClVdH4ou
 J+i9ICtW33k++V3mCqOrjqkvROjcvPbl9aUKjEyNDtU7V1u8SyB+dijIu1N/9Y6b/spkJvg/Ge2
 VNmbbNencIFAA==
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

The 21264 (EV67 and later) and 21364 have two performance counting modes,
and the driver only uses Aggregate mode. Its samples report the PC at
which the counter interrupt was taken, which lands a variable number of
instructions after the one that overflowed the counter. On an EV7 a
16-instruction user loop shows up at only 4 PCs, anywhere from 15
instructions before to 12 after the real one.

In ProfileMe mode, the instruction that overflows PCTR0 opens a window
during which PCTR1 counts, and when it closes PALcode delivers the
interrupt with that instruction's PC latched in PMPC.

Select ProfileMe with the new profileme config bit or with precise_ip,
since PMPC has no skid. PCTR_CTL[SL0] selects the mode for both
counters, so a ProfileMe event is scheduled alone and perf core
multiplexes it with other hardware events. The event type chooses the
SL1 setting, which decides what PCTR0 samples on and what PCTR1 counts
in the window:

  event          PCTR0         PCTR1
  instructions   instructions  cycles
  bcache-misses  instructions  Bcache misses
  cycles         cycles        inum retire delay
  mbox-replay    cycles        Mbox replay traps

Every interrupt rearms both counters, since PCTR0 stops when the window
closes. The instruction count is corrected by the overcount I_STAT
reports. The sample is attributed to PMPC. The interrupt can be taken
in a different mode than the profiled instruction: in an unaligned
access test on EV7 that was true of three quarters of the samples. When
the modes match, the PC is set in the interrupt's frame for the overflow
call and restored afterwards, so perf's mode, register and stack
sampling all see the same frame. When they differ the registers are not
available: a kernel instruction whose interrupt is taken after the
return to user mode has no kernel state left, and a user instruction's
frame may not be built yet, as the interrupt is often taken on the first
instruction of the entry code. Those samples use a per-CPU frame holding
only the PC, and a user instruction's sample reports no registers or
user stack. PALmode PMPCs are physical addresses, so those samples keep
the interrupted PC.

PCTR0 is left stopped just past overflow at the end of every window,
which the EV67 PALcode restrictions 32 and 38 warn about: a disabled
counter near overflow keeps signaling it and blocks all other
interrupts, and a disabled counter only clears its overflow state when
written twice. So the counters are written twice when rearmed, and are
moved away from overflow when a ProfileMe event is stopped or removed
or a stray interrupt arrives for one that is gone. Without this,
sampling every 10000 instructions wedged an EV7 in 7 of 16 runs, with
no console output, until the service processor reset it. With it, 66
runs passed.

Rewriting a counter does not cancel its pending interrupt: wrperfmon has
no way to, and PALcode clears the request only when delivering it. An
interrupt that was pending when a ProfileMe event was stopped is
ignored. One still pending when perf multiplexes in an event of the
other mode on PCTR0 is taken as that event's overflow, which costs one
false sample and adds a bogus period to the count.

Three behaviors differ from Aggregate mode. perf record's default event
is cycles:P, so it now records a ProfileMe profile. In ProfileMe mode
PCTR0 counts valid fetched instructions rather than retired ones, so the
instructions count includes the wrong path, squashed NOPs, and both
halves of each CMOV: on an EV7 loop with a randomly mispredicted branch
it is about twice the Aggregate count. And instructions killed on a
wrong path are sampled at their own PC, as ProfileMe defines them.

Suggested-by: Magnus Lindholm <linmag7@gmail.com>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/include/asm/wrperfmon.h |  12 ++
 arch/alpha/kernel/perf_event.c     | 285 +++++++++++++++++++++++++++++++++++--
 2 files changed, 286 insertions(+), 11 deletions(-)

diff --git a/arch/alpha/include/asm/wrperfmon.h b/arch/alpha/include/asm/wrperfmon.h
index 1fa9bc813263..7fbbfd74926a 100644
--- a/arch/alpha/include/asm/wrperfmon.h
+++ b/arch/alpha/include/asm/wrperfmon.h
@@ -92,5 +92,17 @@
 #define EV67_PCTR_CYCLES_UNDEF (1UL<<2)
 #define EV67_PCTR_INSTR_BCACHEMISS (2UL<<2)
 #define EV67_PCTR_CYCLES_MBOX (3UL<<2)
+/* In ProfileMe mode, SL1 = 1 makes PCTR1 count the inum retire delay. */
+#define EV67_PCTR_CYCLES_RETIRE_DELAY (1UL<<2)
+/* Set in both SL settings where PCTR0 counts cycles. */
+#define EV67_PCTR_PCTR0_CYCLES (1UL<<2)
+
+/* ProfileMe status, from the EV67/EV68 Hardware Reference Manuals. */
+#define EV67_I_STAT_OVR_SHIFT 30
+#define EV67_I_STAT_OVR_MASK 0x7UL
+
+/* PMPC bits 63:2 hold the profiled PC. Bit 0 set means a PALmode address. */
+#define EV67_PMPC_PAL (1UL<<0)
+#define EV67_PMPC_PC_MASK (~3UL)
 
 #endif
diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index ecec78c355cd..29577a493e55 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -16,6 +16,7 @@
 #include <linux/kdebug.h>
 #include <linux/mutex.h>
 #include <linux/init.h>
+#include <linux/sched/task_stack.h>
 
 #include <asm/hwrpb.h>
 #include <linux/atomic.h>
@@ -30,6 +31,13 @@
 #define MAX_HWEVENTS 3
 #define PMC_NO_INDEX -1
 
+/* Layout of attr.config for PERF_TYPE_RAW events; see format/ in sysfs. */
+#define ALPHA_PERF_CONFIG_EVENT		0xffULL
+#define ALPHA_PERF_CONFIG_PROFILEME	BIT_ULL(8)
+
+/* hw_perf_event.flags */
+#define ALPHA_PERF_FLAG_PROFILEME	0x1
+
 /* For tracking PMCs and the hw events they monitor on each CPU. */
 struct cpu_hw_events {
 	int			enabled;
@@ -145,6 +153,19 @@ static const struct ev67_mapping_t ev67_mapping[] = {
 };
 
 
+/*
+ * In ProfileMe mode PCTR0 selects the profiled instruction and PCTR1 counts
+ * during its window. PCTR0 counts instructions or cycles, and each choice
+ * pairs with two PCTR1 inputs, so each event type picks one SL1 setting.
+ * Indexed by enum ev67_pmc_event_type.
+ */
+static const unsigned long ev67_profileme_sl1[] = {
+	[EV67_CYCLES]		= EV67_PCTR_CYCLES_RETIRE_DELAY, /* PCTR1: retire delay */
+	[EV67_INSTRUCTIONS]	= EV67_PCTR_INSTR_CYCLES,	/* PCTR1: cycles */
+	[EV67_BCACHEMISS]	= EV67_PCTR_INSTR_BCACHEMISS,	/* PCTR1: Bcache misses */
+	[EV67_MBOXREPLAY]	= EV67_PCTR_CYCLES_MBOX,	/* PCTR1: Mbox replays */
+};
+
 /*
  * Check that a group of events can be simultaneously scheduled on to the
  * EV67 PMU.  Also allocate counter indices and config.
@@ -152,9 +173,21 @@ static const struct ev67_mapping_t ev67_mapping[] = {
 static int ev67_check_constraints(struct perf_event **event,
 				unsigned long *evtype, int n_ev)
 {
-	int idx0;
+	int idx0, j;
 	unsigned long config;
 
+	/* A ProfileMe event uses both counters, so it must be alone. */
+	for (j = 0; j < n_ev; j++) {
+		if (!(event[j]->hw.flags & ALPHA_PERF_FLAG_PROFILEME))
+			continue;
+		if (n_ev != 1)
+			return -1;
+		event[0]->hw.idx = 0;
+		event[0]->hw.config_base = EV67_PCTR_MODE_PROFILEME |
+					   ev67_profileme_sl1[evtype[0]];
+		return 0;
+	}
+
 	idx0 = ev67_mapping[evtype[0]-1].idx;
 	config = ev67_mapping[evtype[0]-1].config;
 	if (n_ev == 1)
@@ -213,9 +246,11 @@ static int ev67_raw_event_valid(u64 config)
 
 
 PMU_FORMAT_ATTR(event, "config:0-7");
+PMU_FORMAT_ATTR(profileme, "config:8");
 
 static struct attribute *ev67_format_attrs[] = {
 	&format_attr_event.attr,
+	&format_attr_profileme.attr,
 	NULL,
 };
 
@@ -276,6 +311,31 @@ static inline void alpha_write_pmc(int idx, unsigned long val)
 	wrperfmon(PERFMON_CMD_WRITE, val);
 }
 
+/* Write PCTR0 and clear PCTR1 in one call, as ProfileMe mode requires. */
+static inline void alpha_write_pmc_profileme(unsigned long val)
+{
+	val &= alpha_pmu->pmc_count_mask[0];
+	val <<= alpha_pmu->pmc_count_shift[0];
+	val |= EV67_PCTR_0 | EV67_PCTR_1;
+	/*
+	 * PCTR0 stops when a ProfileMe window closes, and a stopped counter
+	 * only clears its overflow state when written twice (EV67 HRM, PALcode
+	 * restriction 38). A counter left signaling overflow blocks all
+	 * other interrupts (restriction 32).
+	 */
+	wrperfmon(PERFMON_CMD_WRITE, val);
+	wrperfmon(PERFMON_CMD_WRITE, val);
+}
+
+/* The counters an event occupies, for PERFMON_CMD_ENABLE and DISABLE. */
+static inline unsigned long alpha_event_idx_mask(struct hw_perf_event *hwc,
+						 int idx)
+{
+	if (hwc->flags & ALPHA_PERF_FLAG_PROFILEME)
+		return EV67_PCTR_0 | EV67_PCTR_1;
+	return 1UL<<idx;
+}
+
 static inline unsigned long alpha_read_pmc(int idx)
 {
 	unsigned long val;
@@ -286,6 +346,23 @@ static inline unsigned long alpha_read_pmc(int idx)
 	return val;
 }
 
+/*
+ * Move a stopped ProfileMe counter away from overflow. See
+ * alpha_write_pmc_profileme() for why. The caller has read the count, so
+ * prev_count can be rebased on the value written.
+ *
+ * A pending PMI stays pending: PALcode clears it only when delivering it.
+ */
+static void alpha_perf_event_park(struct hw_perf_event *hwc)
+{
+	long left = local64_read(&hwc->period_left);
+
+	left = clamp(left, alpha_pmu->pmc_left[0],
+		     (long)alpha_pmu->pmc_max_period[0]);
+	local64_set(&hwc->prev_count, (unsigned long)(-left));
+	alpha_write_pmc_profileme((unsigned long)(-left));
+}
+
 /* Set a new period to sample over */
 static int alpha_perf_event_set_period(struct perf_event *event,
 				struct hw_perf_event *hwc, int idx)
@@ -320,7 +397,10 @@ static int alpha_perf_event_set_period(struct perf_event *event,
 
 	local64_set(&hwc->prev_count, (unsigned long)(-left));
 
-	alpha_write_pmc(idx, (unsigned long)(-left));
+	if (hwc->flags & ALPHA_PERF_FLAG_PROFILEME)
+		alpha_write_pmc_profileme((unsigned long)(-left));
+	else
+		alpha_write_pmc(idx, (unsigned long)(-left));
 
 	perf_event_update_userpage(event);
 
@@ -459,7 +539,8 @@ static void maybe_change_configuration(struct cpu_hw_events *cpuc)
 		if (!(hwc->state & PERF_HES_STOPPED)) {
 			/* The counter is live, so hwc->prev_count will go stale. */
 			hwc->state &= ~PERF_HES_UPTODATE;
-			cpuc->idx_mask |= (1<<cpuc->current_idx[j]);
+			cpuc->idx_mask |= alpha_event_idx_mask(hwc,
+							cpuc->current_idx[j]);
 		}
 	}
 	cpuc->config = cpuc->event[0]->hw.config_base;
@@ -551,7 +632,10 @@ static void alpha_pmu_del(struct perf_event *event, int flags)
 			alpha_perf_event_update(event, hwc, idx, 0);
 			perf_event_update_userpage(event);
 
-			cpuc->idx_mask &= ~(1UL<<idx);
+			if (hwc->flags & ALPHA_PERF_FLAG_PROFILEME)
+				alpha_perf_event_park(hwc);
+
+			cpuc->idx_mask &= ~alpha_event_idx_mask(hwc, idx);
 			cpuc->n_events--;
 			break;
 		}
@@ -576,17 +660,22 @@ static void alpha_pmu_stop(struct perf_event *event, int flags)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	if (!(hwc->state & PERF_HES_STOPPED)) {
-		cpuc->idx_mask &= ~(1UL<<hwc->idx);
+		cpuc->idx_mask &= ~alpha_event_idx_mask(hwc, hwc->idx);
 		hwc->state |= PERF_HES_STOPPED;
 	}
 
-	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
+	/* Parking a ProfileMe event overwrites the counter, so read it first. */
+	if (((flags & PERF_EF_UPDATE) || (hwc->flags & ALPHA_PERF_FLAG_PROFILEME)) &&
+	    !(hwc->state & PERF_HES_UPTODATE)) {
 		alpha_perf_event_update(event, hwc, hwc->idx, 0);
 		hwc->state |= PERF_HES_UPTODATE;
 	}
 
 	if (cpuc->enabled)
-		wrperfmon(PERFMON_CMD_DISABLE, (1UL<<hwc->idx));
+		wrperfmon(PERFMON_CMD_DISABLE, alpha_event_idx_mask(hwc, hwc->idx));
+
+	if (hwc->flags & ALPHA_PERF_FLAG_PROFILEME)
+		alpha_perf_event_park(hwc);
 }
 
 
@@ -605,9 +694,9 @@ static void alpha_pmu_start(struct perf_event *event, int flags)
 
 	hwc->state = 0;
 
-	cpuc->idx_mask |= 1UL<<hwc->idx;
+	cpuc->idx_mask |= alpha_event_idx_mask(hwc, hwc->idx);
 	if (cpuc->enabled)
-		wrperfmon(PERFMON_CMD_ENABLE, (1UL<<hwc->idx));
+		wrperfmon(PERFMON_CMD_ENABLE, alpha_event_idx_mask(hwc, hwc->idx));
 }
 
 
@@ -647,6 +736,7 @@ static int __hw_perf_event_init(struct perf_event *event)
 	struct perf_event *evts[MAX_HWEVENTS];
 	unsigned long evtypes[MAX_HWEVENTS];
 	int idx_rubbish_bin[MAX_HWEVENTS];
+	bool profileme = false;
 	int ev;
 	int n;
 
@@ -660,9 +750,13 @@ static int __hw_perf_event_init(struct perf_event *event)
 	} else if (attr->type == PERF_TYPE_HW_CACHE) {
 		return -EOPNOTSUPP;
 	} else if (attr->type == PERF_TYPE_RAW) {
-		if (!alpha_pmu->raw_event_valid(attr->config))
+		if (attr->config & ~(ALPHA_PERF_CONFIG_EVENT |
+				     ALPHA_PERF_CONFIG_PROFILEME))
 			return -EINVAL;
-		ev = attr->config;
+		ev = attr->config & ALPHA_PERF_CONFIG_EVENT;
+		if (!alpha_pmu->raw_event_valid(ev))
+			return -EINVAL;
+		profileme = attr->config & ALPHA_PERF_CONFIG_PROFILEME;
 	} else {
 		return -EOPNOTSUPP;
 	}
@@ -671,6 +765,17 @@ static int __hw_perf_event_init(struct perf_event *event)
 		return ev;
 	}
 
+	/*
+	 * ProfileMe samples report the exact PC of the profiled instruction,
+	 * so it also serves any request for precise samples. It only makes
+	 * sense for sampling events.
+	 */
+	if (attr->precise_ip)
+		profileme = true;
+	if (profileme && !is_sampling_event(event))
+		return -EINVAL;
+	hwc->flags = profileme ? ALPHA_PERF_FLAG_PROFILEME : 0;
+
 	/*
 	 * We place the event type in event_base here and leave calculation
 	 * of the codes to programme the PMU for alpha_pmu_enable() because
@@ -835,6 +940,147 @@ void perf_event_print_debug(void)
 }
 
 
+/*
+ * Frame holding only the PC, for a ProfileMe interrupt taken in a different
+ * mode than the profiled instruction. Being off the stack,
+ * perf_reg_value() reports no SP.
+ */
+static DEFINE_PER_CPU(struct pt_regs, alpha_profileme_regs);
+
+/*
+ * Report the sample with none of the given PERF_SAMPLE_REGS_* registers.
+ * Having no user registers also means no user stack.
+ */
+static void alpha_profileme_drop_regs(struct perf_event *event,
+				      struct perf_sample_data *data, u64 which)
+{
+	/* STACK_USER consults regs_user even without REGS_USER. */
+	if (which & PERF_SAMPLE_REGS_USER)
+		data->regs_user = (struct perf_regs){ .abi = PERF_SAMPLE_REGS_ABI_NONE };
+	if (which & PERF_SAMPLE_REGS_INTR)
+		data->regs_intr = (struct perf_regs){ .abi = PERF_SAMPLE_REGS_ABI_NONE };
+	data->sample_flags |= which;
+	/* Only the ABI word is written for each. */
+	data->dyn_size += hweight64(event->attr.sample_type & which) * sizeof(u64);
+}
+
+/* Report the user registers from a frame known to be complete. */
+static void alpha_profileme_set_regs_user(struct perf_event *event,
+					  struct perf_sample_data *data)
+{
+	data->regs_user.regs = task_pt_regs(current);
+	data->regs_user.abi = perf_reg_abi(current);
+	data->sample_flags |= PERF_SAMPLE_REGS_USER;
+	/* STACK_USER consults regs_user even without REGS_USER. */
+	if (event->attr.sample_type & PERF_SAMPLE_REGS_USER)
+		data->dyn_size += (1 + hweight64(event->attr.sample_regs_user)) *
+				  sizeof(u64);
+}
+
+/*
+ * Handle the close of a ProfileMe window on PCTR0.
+ *
+ * PCTR0 stops counting when the window closes and does not start again
+ * until PCTR_CTL is written, so the status must be read first and the
+ * counters then rearmed unconditionally.
+ */
+static void alpha_perf_event_profileme(struct perf_event *event,
+				       struct hw_perf_event *hwc,
+				       struct pt_regs *regs)
+{
+	struct perf_sample_data data;
+	struct pt_regs *pm_regs;
+	bool pc_only = false;
+	unsigned long i_stat, pmpc, ovr, pc, saved_pc, saved_ps;
+
+	i_stat = wrperfmon(PERFMON_CMD_I_STAT, 0);
+	pmpc = wrperfmon(PERFMON_CMD_PMPC, 0);
+
+	alpha_perf_event_update(event, hwc, 0, alpha_pmu->pmc_max_period[0]+1);
+
+	/*
+	 * When PCTR0 counts instructions, up to 7 of them are counted after
+	 * the overflow but before the window opens. I_STAT reports how many.
+	 */
+	if (!(hwc->config_base & EV67_PCTR_PCTR0_CYCLES)) {
+		ovr = (i_stat >> EV67_I_STAT_OVR_SHIFT) & EV67_I_STAT_OVR_MASK;
+		local64_sub(ovr, &event->count);
+		local64_add(ovr, &hwc->period_left);
+	}
+
+	/*
+	 * Attribute the sample to the profiled instruction rather than to
+	 * wherever the interrupt landed. perf takes the sample's mode,
+	 * registers and stack from regs, so:
+	 *
+	 * - Interrupt taken in the same mode: the PC is set in the
+	 *   interrupt's own frame, and restored afterwards.
+	 * - User instruction, interrupt taken in the kernel, typically
+	 *   because the instruction trapped: the frame at task_pt_regs() may
+	 *   not be built yet. The interrupt is often taken on the first
+	 *   instruction of the entry code, and its own frame then overlaps
+	 *   that one. Report the PC alone, in a per-CPU frame.
+	 * - Kernel instruction, interrupt taken just after returning to user
+	 *   mode: the kernel state is gone, so a per-CPU frame that holds only
+	 *   the PC. The user frame in regs is left alone, since perf samples
+	 *   the user registers from it.
+	 *
+	 * A PALmode PMPC is a physical address that perf cannot resolve. That
+	 * happens for ITB miss, Istream access violation and interrupt
+	 * redirects, and for instructions inside PALcode. Keep the
+	 * interrupted PC, which for redirects is the instruction that
+	 * trapped. Do the same for a user PMPC in a kernel thread, which has
+	 * no user frame.
+	 */
+	pm_regs = regs;
+	pc = pmpc & EV67_PMPC_PC_MASK;
+	if (pmpc & EV67_PMPC_PAL) {
+		pc = regs->pc;
+	} else if (pc < TASK_SIZE && !user_mode(regs)) {
+		if (is_user_task(current)) {
+			pc_only = true;
+			pm_regs = this_cpu_ptr(&alpha_profileme_regs);
+			memset(pm_regs, 0, sizeof(*pm_regs));
+			/* PS bit 3 is the mode bit that user_mode() tests. */
+			pm_regs->ps = 8;
+		} else {
+			pc = regs->pc;
+		}
+	} else if (pc >= TASK_SIZE && user_mode(regs)) {
+		pm_regs = this_cpu_ptr(&alpha_profileme_regs);
+		memset(pm_regs, 0, sizeof(*pm_regs));
+	}
+
+	perf_sample_data_init(&data, 0, hwc->last_period);
+	if (pc_only)
+		alpha_profileme_drop_regs(event, &data, PERF_SAMPLE_REGS_USER |
+							PERF_SAMPLE_REGS_INTR);
+	/*
+	 * perf_get_regs_user() has the same check, but it will find the PMPC
+	 * in regs->pc rather than where the interrupt was taken. Decide here
+	 * from the interrupted PC, for either answer that would differ.
+	 */
+	else if (!user_mode(regs) && in_entry_save_code(regs->pc))
+		alpha_profileme_drop_regs(event, &data, PERF_SAMPLE_REGS_USER);
+	else if (in_entry_save_code(pc) && is_user_task(current))
+		alpha_profileme_set_regs_user(event, &data);
+
+	if (!alpha_perf_event_set_period(event, hwc, 0))
+		return;
+
+	saved_pc = pm_regs->pc;
+	saved_ps = pm_regs->ps;
+	pm_regs->pc = pc;
+	/* PS bit 3 is the mode bit that user_mode() tests. */
+	if (pc >= TASK_SIZE)
+		pm_regs->ps &= ~8UL;
+
+	perf_event_overflow(event, &data, pm_regs);
+
+	pm_regs->pc = saved_pc;
+	pm_regs->ps = saved_ps;
+}
+
 /*
  * Performance Monitoring Interrupt Service Routine called when a PMC
  * overflows.  The PMC that overflowed is passed in la_ptr.
@@ -869,6 +1115,10 @@ static void alpha_perf_event_irq_handler(unsigned long la_ptr,
 
 	idx = la_ptr;
 
+	/* A ProfileMe event owns both counters but lives at index 0. */
+	if (cpuc->config & EV67_PCTR_MODE_PROFILEME)
+		idx = 0;
+
 	for (j = 0; j < cpuc->n_events; j++) {
 		if (cpuc->current_idx[j] == idx)
 			break;
@@ -876,6 +1126,8 @@ static void alpha_perf_event_irq_handler(unsigned long la_ptr,
 
 	if (unlikely(j == cpuc->n_events)) {
 		/* This can occur if the event is disabled right on a PMC overflow. */
+		if (cpuc->config & EV67_PCTR_MODE_PROFILEME)
+			alpha_write_pmc_profileme(-alpha_pmu->pmc_max_period[0]);
 		wrperfmon(PERFMON_CMD_ENABLE, cpuc->idx_mask);
 		return;
 	}
@@ -891,6 +1143,17 @@ static void alpha_perf_event_irq_handler(unsigned long la_ptr,
 	}
 
 	hwc = &event->hw;
+	if (hwc->flags & ALPHA_PERF_FLAG_PROFILEME) {
+		/*
+		 * This overflow was pending when the event was stopped, and
+		 * alpha_pmu_stop() has already parked the counter.
+		 */
+		if (!(hwc->state & PERF_HES_STOPPED))
+			alpha_perf_event_profileme(event, hwc, regs);
+		wrperfmon(PERFMON_CMD_ENABLE, cpuc->idx_mask);
+		return;
+	}
+
 	alpha_perf_event_update(event, hwc, idx, alpha_pmu->pmc_max_period[idx]+1);
 	perf_sample_data_init(&data, 0, hwc->last_period);
 

-- 
2.55.0

