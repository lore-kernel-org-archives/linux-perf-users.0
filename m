Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333049;
	b=y9oGq0wnqEsMY0mUfSs+RR5DSpDtf6R65K+0/KgF6ocjgFPB3mKEHxl3XQ9tj9wGLXR1
	 4uTNG0kV9JULJl0eGBkKxl76/sNrvQ2Cc4GXszpyFWd5Bu3q5TgtKfPsgy5+bvsSWRWK3
	 XRQ9f9cxmb6Kpcgc+NgyGO590wlbZvvBOcwurwFK0X4spj6AGSbXlP6FgxO7wzcT23QKP
	 nvToQYfUomEVlgwotkQ5nRD3oj4jiuITottN65jZbU7kumN/wzYZD7sxu3+dhp/CsrUxZ
	 L1fV1dwVgAlgQND+2g/K9lvAEIZBK8wzHmoRWoVoRFQgOGA7X987FQwXx3argtCzvEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333049;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=NWTcdIaikLTNhwFcPDbroIvnGY8h2lK4oC1MpeK49Bg=;
	b=RzRwpA7e+lY2pkFtbxCUloPKY7MuYC7Gkp3WG7S99uiJ0VogLPnPsCe+YWZq5dQUH2Qa
	 28IkxMK7fbIOgdMzfzrsLMxYrjWpfABM4isP2Nw//LJWOczHncYaXH5M/in3h/5uFMtkq
	 tABLWgoBVVDNfZykDtyxz7eEL8KJfW/TdjBCeDot0dmhaZ/zfLLSE/d4O9IQJxN9wSeUd
	 G1Z/i/Bia/gJdN+7LVnHHOtQOQYEhDGrHN6Esyr52I2zKFaccyOe6xwmF5LQ02PdBzIc6
	 EDycXio3O1b/fbU/st9TYXRg/8RbgcuaGoH1raY8QiA619H8iUL1diIrK/l1+SwaUTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H1fKw5PJ;
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6531606A33C
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 04:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6531606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H1fKw5PJ
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8acda240937so2365887b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 21:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793333048; x=1793937848; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NWTcdIaikLTNhwFcPDbroIvnGY8h2lK4oC1MpeK49Bg=;
        b=H1fKw5PJ0gCRVCE8KJXtj48ofHvfj4Fcm7yKiz4lZ++INQhbioJgfjdjBjKoI+qE9K
         mIgfdph64pPm4j1W+TSwp6eMf0Swoa03sXSFtzqpkVNOWNVts+bYnXR9h5CngrP/ALkp
         OaBl7/Ba45ORWGt3zfHAAFDUAg7Kx4iaVGGhYhMPMIsjvPT0ht0EAOQ+G9qqITMX3ahx
         ux1a8N3vuA3OdrC3SQxEMnf2zkcsKBU8ioY0kgtJ8faeu0gmOv0c5t2fVpEsWSFrKy6l
         hieUdshcJgzLH0TjiLAwBmv9XDiuuGABac+kwxg5S8jImZ21m4Q7vr60zDHuMOlj/5zG
         DH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793333048; x=1793937848;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NWTcdIaikLTNhwFcPDbroIvnGY8h2lK4oC1MpeK49Bg=;
        b=aMEmRLTyMCJHnE29uc0PMccZrLEz0G7jPpqTLdVmi1vRI7YckSVsi/zSf4BB81I9gc
         EITuunJohIRjVzVqT3yC7qaLlZLKvUHKhBOOCfIDp1oZj3w6AXgZ+edmYeKp/DZhI8mj
         P8dvBEtgWpDUASizHHwVqX2QVvBSNvL/GghTiSreqdVbB5HcnkcGVJzb4V38GZlaxUH4
         ikD2SI3VvZWUO8zNZECjD6nqWbFcLU2PxApex3rr+k83lbeI+ZGrL4dg+lR1N4vzqFS2
         uhcvODK/avQVuh08nT+wL7PzeElyY/1594a683aN7Iigx1ucPNoaoXY7RGesN+cqM8Eg
         nCBw==
X-Forwarded-Encrypted: i=1; AKwUvByqWKlfrkonCxArvmqwXc9aW/OP84oCeaXeQt/0bzYUgoyZm2NTle+Qz8/LNaRqe43d9HeLQI4m67zIarLNgrwR@vger.kernel.org
X-Gm-Message-State: AFq9FYLpnqBaqLWM4DuzLiwzcZeSfwmJFE3lm60qBRJ3hzbDaNL/Dcj8
	gYpO1cbbdZebBS8qmuIUYvq+jEgyvNcGt3LcDpVwM1gv4gzrVmzCTimb
X-Gm-Gg: AYBFou0e5uJD742VUC/ijKPoN1iZ3CEFxhXN0UQgq24jhNCuH3oOsncD0PAacsF32tQ
	EiWqFvIV67ZjuPUXTCPsa5p4VppgGKQ2HOG5MrWk0EP8NPQEK+hDUK4wrDuInnuuQOR7ni5lDQ9
	xjyOUUWX0/rU+5WDthLRwO3zkGVhqiQ8C4SgsAdmwAkF+LeEIudeCCsoJbSni7En8lQy6bQNHOT
	lPsfOdcVXGmpCXKX/9i9n5AaH2kl24KYsX0DepnKSe3Ux789IfpzVzai+AUOYn+FT1DqRpEy9S8
	StsdXf/dXVdOZ4UO5FCJV+8gn7EZQDxfncBrX0ffBup1urVjR7yBvubszoyODEY0wBk4b3M09P8
	onD8E+sDxN3LI2l5FlQUoraz/H0IhIQ0M82rYpheFUM56BSXvDDa4SNpCuh2iZlD8fQZSKNsIBx
	VYyugOArxc92/J6A2sP8B5D067YOm0RQCdDaV/PSoAJagoJH1KJt8ZCJijv/iKDF5xQiXk7dUJJ
	ziJHnnorbIzp55a5cr7HB7X968cHjk/5PXK3Pq8k3N/cg5Y+78MeM/Ad8oGN5RuPU//Tfj2YFgj
	TtXB/1Dp93xohwMkr8cvsS7HwAnJiRoH/kWcf7cxMuPWHoNoRd5LNUzlD53ddzAptOxfuLUkseZ
	IV11P69HSow==
X-Received: by 2002:a05:690c:389:b0:8b1:447c:cf05 with SMTP id 00721157ae682-8b2b67cd1b4mr6151087b3.67.1793333047546;
        Thu, 29 Oct 2026 21:04:07 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b716d420sm3572597b3.33.2026.10.29.21.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:04:06 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 30 Oct 2026 00:04:01 -0400
Subject: [PATCH v2 3/5] alpha/perf: implement ProfileMe sampling
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
Message-Id: <20261030-alpha-profileme-v2-3-c702f1c65272@gmail.com>
References: <20261030-alpha-profileme-v2-0-c702f1c65272@gmail.com>
In-Reply-To: <20261030-alpha-profileme-v2-0-c702f1c65272@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=16595; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=KSEQJ5+lldRJwnKDj3ujqfW2mx21flpTt9vWH9PLCeM=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLKeiOt/XnGqXScxecmBN9O3/pymE85xYr3ew+t2W6Ta2
 lxyuFLWdHxkYRDjYpgppsgSt16RZVbbjqU+p6V/wcxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjlE8RE6PQSOzuLg0tUg3raDIIS+/JLEkMz+vWC+/IDWvIL1ALy0zrSQjI7+oOBVohF5eaom
 pq6ObkaGBiaWjhZmThaOpibOzk6GTm6Ojs6uTkaW5iYGzpaOJq6U5AxenAMw1rcsYGY4FVy1Svs
 RxNv3KSbPf97b/WcK1Nnrvz89i7j+n3WDZUmnL8Id/2b8vNe9fGQUeu9DfOTMpdOGTnOTfNW0/L
 i9hmukhOZ8NAA==
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
access test on EV7 that was true of three quarters of the samples. So
for the overflow call the PC is set in the trap frame of the
instruction's mode, task_pt_regs() for a user instruction, and restored
afterwards. perf's mode, register and stack sampling then all see the
same frame. A kernel instruction whose interrupt is taken after the
return to user mode has no kernel state left, so it gets a per-CPU frame
holding only its PC, which leaves the user frame intact. PALmode PMPCs
are physical addresses, so those samples keep the interrupted PC.

PCTR0 is left stopped just past overflow at the end of every window,
which the EV67 PALcode restrictions 32 and 38 warn about: a disabled
counter near overflow keeps signaling it and blocks all other
interrupts, and a disabled counter only clears its overflow state when
written twice. So the counters are written twice when rearmed, and are
moved away from overflow when a ProfileMe event is stopped or a stray
interrupt arrives for one that is gone. Without this, sampling every
10000 instructions wedged an EV7 in 7 of 16 runs, with no console
output, until the service processor reset it. With it, 66 runs passed.

Three behaviors differ from Aggregate mode. perf record's default event
is cycles:P, so it now records a ProfileMe profile. In ProfileMe mode
PCTR0 counts valid fetched instructions rather than retired ones, so the
instructions count includes the wrong path, squashed NOPs, and both
halves of each CMOV: on an EV7 loop with a randomly mispredicted branch
it is about twice the Aggregate count. And instructions killed on a
wrong path are sampled at their own PC, as ProfileMe defines them.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/include/asm/wrperfmon.h |  12 ++
 arch/alpha/kernel/perf_event.c     | 217 +++++++++++++++++++++++++++++++++++--
 2 files changed, 219 insertions(+), 10 deletions(-)

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
index 70840c05d39b..c7f0ccf8ec80 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -30,6 +30,13 @@
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
@@ -145,6 +152,19 @@ static const struct ev67_mapping_t ev67_mapping[] = {
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
@@ -152,9 +172,21 @@ static const struct ev67_mapping_t ev67_mapping[] = {
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
@@ -213,9 +245,11 @@ static int ev67_raw_event_valid(u64 config)
 
 
 PMU_FORMAT_ATTR(event, "config:0-7");
+PMU_FORMAT_ATTR(profileme, "config:8");
 
 static struct attribute *ev67_format_attrs[] = {
 	&format_attr_event.attr,
+	&format_attr_profileme.attr,
 	NULL,
 };
 
@@ -276,6 +310,31 @@ static inline void alpha_write_pmc(int idx, unsigned long val)
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
@@ -320,7 +379,10 @@ static int alpha_perf_event_set_period(struct perf_event *event,
 
 	local64_set(&hwc->prev_count, (unsigned long)(-left));
 
-	alpha_write_pmc(idx, (unsigned long)(-left));
+	if (hwc->flags & ALPHA_PERF_FLAG_PROFILEME)
+		alpha_write_pmc_profileme((unsigned long)(-left));
+	else
+		alpha_write_pmc(idx, (unsigned long)(-left));
 
 	perf_event_update_userpage(event);
 
@@ -457,7 +519,8 @@ static void maybe_change_configuration(struct cpu_hw_events *cpuc)
 		}
 
 		if (!(hwc->state & PERF_HES_STOPPED))
-			cpuc->idx_mask |= (1<<cpuc->current_idx[j]);
+			cpuc->idx_mask |= alpha_event_idx_mask(hwc,
+							cpuc->current_idx[j]);
 	}
 	cpuc->config = cpuc->event[0]->hw.config_base;
 }
@@ -548,7 +611,7 @@ static void alpha_pmu_del(struct perf_event *event, int flags)
 			alpha_perf_event_update(event, hwc, idx, 0);
 			perf_event_update_userpage(event);
 
-			cpuc->idx_mask &= ~(1UL<<idx);
+			cpuc->idx_mask &= ~alpha_event_idx_mask(hwc, idx);
 			cpuc->n_events--;
 			break;
 		}
@@ -573,7 +636,7 @@ static void alpha_pmu_stop(struct perf_event *event, int flags)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	if (!(hwc->state & PERF_HES_STOPPED)) {
-		cpuc->idx_mask &= ~(1UL<<hwc->idx);
+		cpuc->idx_mask &= ~alpha_event_idx_mask(hwc, hwc->idx);
 		hwc->state |= PERF_HES_STOPPED;
 	}
 
@@ -583,7 +646,23 @@ static void alpha_pmu_stop(struct perf_event *event, int flags)
 	}
 
 	if (cpuc->enabled)
-		wrperfmon(PERFMON_CMD_DISABLE, (1UL<<hwc->idx));
+		wrperfmon(PERFMON_CMD_DISABLE, alpha_event_idx_mask(hwc, hwc->idx));
+
+	/*
+	 * A ProfileMe event can be stopped with a window open and PCTR0 just
+	 * past overflow. Do not leave it there while it is disabled, see
+	 * alpha_write_pmc_profileme(). The count was read above, so rebase
+	 * prev_count on the value written.
+	 */
+	if ((hwc->flags & ALPHA_PERF_FLAG_PROFILEME) &&
+	    (hwc->state & PERF_HES_UPTODATE)) {
+		long left = local64_read(&hwc->period_left);
+
+		left = clamp(left, alpha_pmu->pmc_left[0],
+			     (long)alpha_pmu->pmc_max_period[0]);
+		local64_set(&hwc->prev_count, (unsigned long)(-left));
+		alpha_write_pmc_profileme((unsigned long)(-left));
+	}
 }
 
 
@@ -602,9 +681,9 @@ static void alpha_pmu_start(struct perf_event *event, int flags)
 
 	hwc->state = 0;
 
-	cpuc->idx_mask |= 1UL<<hwc->idx;
+	cpuc->idx_mask |= alpha_event_idx_mask(hwc, hwc->idx);
 	if (cpuc->enabled)
-		wrperfmon(PERFMON_CMD_ENABLE, (1UL<<hwc->idx));
+		wrperfmon(PERFMON_CMD_ENABLE, alpha_event_idx_mask(hwc, hwc->idx));
 }
 
 
@@ -644,6 +723,7 @@ static int __hw_perf_event_init(struct perf_event *event)
 	struct perf_event *evts[MAX_HWEVENTS];
 	unsigned long evtypes[MAX_HWEVENTS];
 	int idx_rubbish_bin[MAX_HWEVENTS];
+	bool profileme = false;
 	int ev;
 	int n;
 
@@ -657,9 +737,13 @@ static int __hw_perf_event_init(struct perf_event *event)
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
@@ -668,6 +752,17 @@ static int __hw_perf_event_init(struct perf_event *event)
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
@@ -832,6 +927,96 @@ void perf_event_print_debug(void)
 }
 
 
+/*
+ * Sample registers for a ProfileMe kernel instruction whose interrupt was
+ * taken in user mode. Being off the stack, perf_reg_value() reports no SP.
+ */
+static DEFINE_PER_CPU(struct pt_regs, alpha_profileme_regs);
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
+	 * registers and stack from regs, so the PC is set in the trap frame
+	 * of the mode the instruction ran in, and restored afterwards:
+	 *
+	 * - Interrupt taken in the same mode: the interrupt's own frame.
+	 * - User instruction, interrupt taken in the kernel, typically
+	 *   because the instruction trapped: the user frame at
+	 *   task_pt_regs().
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
+		if (is_user_task(current))
+			pm_regs = task_pt_regs(current);
+		else
+			pc = regs->pc;
+	} else if (pc >= TASK_SIZE && user_mode(regs)) {
+		pm_regs = this_cpu_ptr(&alpha_profileme_regs);
+		memset(pm_regs, 0, sizeof(*pm_regs));
+	}
+
+	perf_sample_data_init(&data, 0, hwc->last_period);
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
@@ -866,6 +1051,10 @@ static void alpha_perf_event_irq_handler(unsigned long la_ptr,
 
 	idx = la_ptr;
 
+	/* A ProfileMe event owns both counters but lives at index 0. */
+	if (cpuc->config & EV67_PCTR_MODE_PROFILEME)
+		idx = 0;
+
 	for (j = 0; j < cpuc->n_events; j++) {
 		if (cpuc->current_idx[j] == idx)
 			break;
@@ -873,6 +1062,8 @@ static void alpha_perf_event_irq_handler(unsigned long la_ptr,
 
 	if (unlikely(j == cpuc->n_events)) {
 		/* This can occur if the event is disabled right on a PMC overflow. */
+		if (cpuc->config & EV67_PCTR_MODE_PROFILEME)
+			alpha_write_pmc_profileme(-alpha_pmu->pmc_max_period[0]);
 		wrperfmon(PERFMON_CMD_ENABLE, cpuc->idx_mask);
 		return;
 	}
@@ -888,6 +1079,12 @@ static void alpha_perf_event_irq_handler(unsigned long la_ptr,
 	}
 
 	hwc = &event->hw;
+	if (hwc->flags & ALPHA_PERF_FLAG_PROFILEME) {
+		alpha_perf_event_profileme(event, hwc, regs);
+		wrperfmon(PERFMON_CMD_ENABLE, cpuc->idx_mask);
+		return;
+	}
+
 	alpha_perf_event_update(event, hwc, idx, alpha_pmu->pmc_max_period[idx]+1);
 	perf_sample_data_init(&data, 0, hwc->last_period);
 

-- 
2.55.0

