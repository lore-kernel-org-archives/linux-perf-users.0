Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795755794;
	b=yzTQ49WAnb/aiFIl+yzMr8wiOkyWKBZnPL4WVwUNEx2gI9+ydM3Yybh/2uGp0o7PjU0V
	 JGUP6YDEKavo6SRH+lA+INXWw1rBCM/dq7jPLHMi0QERHr4FAcc9AoNe9QLRGTQ0ede29
	 tr72sDSN6eC+i3zpLnIl0P6/2U2Ei3lQe8K7y8d+6kwpj59EJbBH0pMzlx4ixKl/NhAOt
	 RxP2MPpFllOZnpDMviC6G4EEQib1nUQrQsB9n/O1Y1qDSic8O8cvijcwunYTeYGisSOWv
	 +7/hSwnvXAGnCUUgwNeG0MeWFUNdj98dTjyPGrWtott+yw6rBsKQ2szgTy9E5jmdEQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795755794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=t8OXfROPB6uxAnJi0tzx26fxcmhnTza3+rRcXH/CCIU=;
	b=ODkKqpUcaSF0CDXKcl0cKM0odeRnofc4Fwa0vPQ6SfyC0NxvdQXSRt8OsqOwkKkMK0FP
	 01J8Thv5BUy8I8dpvQkhDjH9k7/Ry1OWK0/YdZOjE0DelrsYgKc99F9GtNpuvTUfmJFAt
	 sPAG7+VZm9cVfxlJapiq3YGZupZ5I9P5f3BYC3OeaMOmBFWBDIaBzxhdpA5osoR5NXwJY
	 mJIrWueArYw2fJu/GGZlm8qXVzxFUE8l/6zv33/iK3JIg47C9/uerBQ2mZASL4InI/hAq
	 rXaOy/PTwIDS3/19tvv6xnQJu8up9vL9PhnE/SA5hUBNy2GTbrk9Nj5fkM4flS9GKlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MoxLb7KA;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2888F606A32F
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 05:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2888F606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MoxLb7KA
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b0ca1ebc8bso66797277b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 21:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795755792; x=1796360592; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t8OXfROPB6uxAnJi0tzx26fxcmhnTza3+rRcXH/CCIU=;
        b=MoxLb7KAmeMfVH9axfx8dt0QiXxxIlQJJ3czDPrzZL1HlMxVBMs/NVR/vFPJzSfv8d
         5//3852Y4/mHfC/RLCZ4Q6gqQQkJALfr8qRqTvpKp/MxeIdguuAtchr9cBvqFMzvMI//
         ZgfMbmIyvy1eKu1c99HjzNHHcKVVvYOm9u/85LSAlDxOrpi2te9S77qTE14H/CeqqVGw
         bXczwk2EYkFyOR05tFjsLjyqW4dgMCbmdevkM1iZeCvkHe/8AtykRHNLggasi2peEK6g
         +oVgGhxqum9L9rfFUyC0pMbsJ+UNBXbx3hNVDjDf6ILbZA8v66IwhSGF+fAMLX1z+L3M
         GmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795755792; x=1796360592;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t8OXfROPB6uxAnJi0tzx26fxcmhnTza3+rRcXH/CCIU=;
        b=gAfRikqqxhJHBDQIVKd5K0H+9Lym9h0H2LbwGNYQ/NFF0OJC9Flx622IYJFw2Od9qV
         wdK3TjU/jn2cKz6f+38g4H5eVaNswmN4jPaZekBAoRrxBlAS4RbzuFxjIOEbJucAvTc0
         5BHOj7kVVSb78EVIw++8bZaMihiMzK4LlAUxDnjnxmLG3mppp8nPN331reKWw9csGEcm
         bm/02wNqkXxMkDs3z3b+Ptz8TDt16IbRnimjBss0xL5k7DJ0laCfU1+ehaQRT+fop5UV
         7DGFfJDN3E/x6pWwPmSvwuUYXB37dXlyaylBEH346PiZ0l2fMq2uC7oEkwQ6lQan++rn
         ngTg==
X-Forwarded-Encrypted: i=1; AL+hErGS6KLh1qPmq3xID+TW9XonklyRWgkWCi6OVODmDOeEuFoEW5Bm3WwB/szP2yt6BBE/ZgpHWckLIYHAlQFdvKcM@vger.kernel.org
X-Gm-Message-State: APuU4Z//Pp9/M+w04w2JL8xcBapZdrEJOG94jdf5plPXwi2xZLdGnCgJ
	5+a0pLpiumDNj3Fgy8ViCJShiC68J6E3s9slhiNEiLl/evvb0m/wgYmB
X-Gm-Gg: AZFdTZdRC4zZXVmAM6lCQ2nochx7ivSlhnewkfgK8EsvrMDk697zaFwSa7Qr7RDn9As
	biVbeWVjKIctX5TTAB6kRkaJFZkrlZ+z++O4bjKnRkd1YsDKOgIOPGwOJmW9cP+BaJnESLuZKBE
	qxekP1eavviRheOEBAXP2+r56iqBI+hJW341uq2y6a0KUFRigAvgYN/NzVZb6YBpu08wV6ab9LR
	Sqw/j1HaQ+X71CGYLG+NsOnchIuQj2M5idn55XAu7UlwELVUxGNMsHghUeSLywPtqR/ReHcVZN6
	lQYhWay3SvMZhgt5LyozxrrULWUg41vshjRd6a0eAPrik49lSJU1Dcj8O53EeWwOinIhjXDVHMM
	xR/5Q75GjLbR5/9+Lb5x9xzQZJ08lXiKJJzLKVEhBrRKPmHNmvXoo0L4ysU4i/Ewpob3MlV50Ef
	OnrI5+Q6ePFLnpcH6KZxTWEGtCiG43IVcqT/+7PTNaWeEWpAAWjgdxNlGwm75YH1i2nO9OI+KFR
	XO5g/CYHiX2jxhn7/ggZyhYjXjOYKi3U9DqqwscIoatmMTuZJOds7tS/Ig5itxkCAsYNnILRCuI
	4R10hUjt3+kPNYvv3QEoihhMxQQVD299r9s6vipg93l0vDXBHVKaGY0U3lSZZfvtlwJNWcfCNZE
	olXf1thiF9imidY6kbaDjwjLQSYIYKIU8CRf91XklhA==
X-Received: by 2002:a05:690c:968c:b0:8b4:fc74:a00 with SMTP id 00721157ae682-8b5204a1396mr111045827b3.27.1795755791699;
        Thu, 26 Nov 2026 21:03:11 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df3378f59sm10383728d50.14.2026.11.26.21.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 21:03:10 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 27 Nov 2026 00:02:58 -0500
Subject: [PATCH 5/7] parisc: perf: add a perf events PMU for
 PA-8800/PA-8900
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
Message-Id: <20261127-parisc-perf-pa8800-v1-5-4f3f077010ce@gmail.com>
References: <20261127-parisc-perf-pa8800-v1-0-4f3f077010ce@gmail.com>
In-Reply-To: <20261127-parisc-perf-pa8800-v1-0-4f3f077010ce@gmail.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=23398; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=fuQ5hjAH1GdSdhuV8vsteIeI0Bj/o+Xe1Q1oXEK5hek=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLI5+f4Lf0m2UTzccb9FSOlEmO4R/tkMMxv+fN96+V5sl
 NPa0tc6HR9ZGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHPNM0+G/547fZ5HHF
 eefTTY2Df+3Mo9pTsSpxxbtveI36br+qbB1eKMDGeWdBWYNYo5+37dupPxyGvfl1IO+5ru8B3an
 7Btyt7Lv/gA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

Expose the PA-8800/PA-8900 counters to perf as the "cpu" PMU, so that
perf stat works. The generic cycles and instructions events map to the
counters of the default image, and raw events select what ctr0 counts:

  event=0  cycles                     ctr1 or ctr3
  event=1  instructions               ctr2
  event=2  tlb-misses                 ctr0
  event=7  dtlb-misses                ctr0
  event=8  itlb-misses                ctr0
  event=9  nonnullified-instructions  ctr0

The first byte of RDR4_0, which each core has its own copy of, selects
what ctr0 counts. Bit 6 leaves out the data TLB misses and bit 7 the
instruction TLB misses, and bit 3 makes it count retired instructions
that are not nullified. The other event codes are left for the events
that need more of the image changed.

The counters cannot interrupt and do not tell privilege levels apart, so
sampling and the exclude bits are not supported. They are 31 bits wide:
a counter wraps from 0x7fffffff to 0 and sets bit 31, which stays set.
At four instructions a cycle ctr2 wraps in about half a second, so a
per-CPU hrtimer reads them every 200 ms while events are active. Reading
needs the counters stopped and shifts RDR15_1 out and back in.

The image is loaded again, which restarts the counters from zero, only
when what ctr0 counts changes.

/dev/perf programs the same counters, so it cannot be opened while perf
events exist, and the other way around.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/parisc/kernel/Makefile          |   1 +
 arch/parisc/kernel/perf.c            |   4 +-
 arch/parisc/kernel/perf_event_mako.c | 414 +++++++++++++++++++++++++++++++++++
 arch/parisc/kernel/perf_mako.c       | 183 ++++++++++++++--
 arch/parisc/kernel/perf_mako.h       |  25 +++
 5 files changed, 605 insertions(+), 22 deletions(-)

diff --git a/arch/parisc/kernel/Makefile b/arch/parisc/kernel/Makefile
index 90140593be54..2dcd74fe5cbc 100644
--- a/arch/parisc/kernel/Makefile
+++ b/arch/parisc/kernel/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_64BIT)	+= sys_parisc32.o signal32.o
 obj-$(CONFIG_STACKTRACE)+= stacktrace.o
 obj-$(CONFIG_AUDIT)	+= audit.o
 obj64-$(CONFIG_AUDIT)	+= compat_audit.o
+obj64-$(CONFIG_PERF_EVENTS)	+= perf_event_mako.o
 # only supported in 64-bit mode at the moment
 obj-$(CONFIG_64BIT)	+= perf.o perf_mako.o perf_asm.o $(obj64-y)
 obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY)	+= topology.o
diff --git a/arch/parisc/kernel/perf.c b/arch/parisc/kernel/perf.c
index 0b9619d18766..113fe97e6c5f 100644
--- a/arch/parisc/kernel/perf.c
+++ b/arch/parisc/kernel/perf.c
@@ -290,7 +290,7 @@ printk("Preparing to start counters\n");
 static int perf_open(struct inode *inode, struct file *file)
 {
 	spin_lock(&perf_lock);
-	if (perf_enabled) {
+	if (perf_enabled || (perf_mako && !perf_mako_dev_get())) {
 		spin_unlock(&perf_lock);
 		return -EBUSY;
 	}
@@ -307,6 +307,8 @@ static int perf_release(struct inode *inode, struct file *file)
 {
 	spin_lock(&perf_lock);
 	perf_enabled = 0;
+	if (perf_mako)
+		perf_mako_dev_put();
 	spin_unlock(&perf_lock);
 
 	return 0;
diff --git a/arch/parisc/kernel/perf_event_mako.c b/arch/parisc/kernel/perf_event_mako.c
new file mode 100644
index 000000000000..f43c8a6cf13d
--- /dev/null
+++ b/arch/parisc/kernel/perf_event_mako.c
@@ -0,0 +1,414 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * perf events for the PA-8800/PA-8900 (Mako) performance counters
+ *
+ * Each core has four 31-bit counters (see perf_mako.c):
+ *
+ *   ctr0: TLB misses, instruction and data, or only one kind, or
+ *         instructions retired and not nullified
+ *   ctr1, ctr3: cycles
+ *   ctr2: instructions retired
+ *
+ * The counters do not interrupt, so only counting is supported, and they
+ * count in all privilege levels. A counter wraps from 0x7fffffff to 0 and
+ * sets bit 31, which stays set. At four instructions a cycle ctr2 wraps
+ * in under half a second, so a per-CPU hrtimer reads the counters every
+ * 200 ms.
+ */
+
+#define pr_fmt(fmt) "perf: " fmt
+
+#include <linux/bits.h>
+#include <linux/hrtimer.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/perf_event.h>
+#include <asm/processor.h>
+
+#include "perf_mako.h"
+
+#define MAKO_NUM_CTRS		4
+#define MAKO_POLL_NS		(200 * NSEC_PER_MSEC)
+#define MAKO_CTR_MASK		GENMASK(30, 0)
+
+enum {
+	MAKO_EV_CYCLES,
+	MAKO_EV_INSTRUCTIONS,
+	MAKO_EV_TLB_MISSES,
+	MAKO_EV_DTLB_MISSES = 7,
+	MAKO_EV_ITLB_MISSES,
+	MAKO_EV_NONNULLIFIED_INSTRUCTIONS,
+	MAKO_EV_MAX,
+};
+
+/* The counters that can count each event, none for unused codes. */
+static const u8 mako_ctrs[MAKO_EV_MAX] = {
+	[MAKO_EV_CYCLES]		= BIT(1) | BIT(3),
+	[MAKO_EV_INSTRUCTIONS]		= BIT(2),
+	[MAKO_EV_TLB_MISSES]		= BIT(0),
+	[MAKO_EV_DTLB_MISSES]		= BIT(0),
+	[MAKO_EV_ITLB_MISSES]		= BIT(0),
+	[MAKO_EV_NONNULLIFIED_INSTRUCTIONS] = BIT(0),
+};
+
+#define MAKO_CONFIG_EVENT	GENMASK_ULL(7, 0)
+
+struct mako_pmu_cpu {
+	struct perf_event	*events[MAKO_NUM_CTRS];
+	u32			ctrs[MAKO_NUM_CTRS];	/* last read */
+	bool			running;		/* counters enabled */
+	struct hrtimer		timer;
+};
+
+static DEFINE_PER_CPU(struct mako_pmu_cpu, mako_pmu_cpu);
+
+/* The event code, which event_init() leaves in hw.config. */
+static unsigned int mako_event_code(struct perf_event *event)
+{
+	return event->hw.config;
+}
+
+/*
+ * Assign counters to the events, and work out the configuration they
+ * need. Returns false if they do not fit together on one core.
+ */
+static bool mako_schedule(struct perf_event **events, int n, int *idx,
+			  struct perf_mako_config *cfg)
+{
+	u8 used = 0;
+	int i;
+
+	memset(cfg, 0, sizeof(*cfg));
+	for (i = 0; i < n; i++) {
+		unsigned int code = mako_event_code(events[i]);
+		u8 free = mako_ctrs[code] & ~used;
+
+		if (!free)
+			return false;
+		idx[i] = __ffs(free);
+		used |= BIT(idx[i]);
+
+		if (code == MAKO_EV_DTLB_MISSES)
+			cfg->ctr0 = MAKO_CTR0_DTLB;
+		else if (code == MAKO_EV_ITLB_MISSES)
+			cfg->ctr0 = MAKO_CTR0_ITLB;
+		else if (code == MAKO_EV_NONNULLIFIED_INSTRUCTIONS)
+			cfg->ctr0 = MAKO_CTR0_INSNS;
+	}
+
+	return true;
+}
+
+/* Gather the events on this CPU, plus extra if not NULL. */
+static int mako_collect(struct mako_pmu_cpu *pc, struct perf_event *extra,
+			struct perf_event **events)
+{
+	int i, n = 0;
+
+	for (i = 0; i < MAKO_NUM_CTRS; i++)
+		if (pc->events[i])
+			events[n++] = pc->events[i];
+	if (extra)
+		events[n++] = extra;
+
+	return n;
+}
+
+static void mako_event_update(struct perf_event *event, u32 now)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	u32 prev = local64_read(&hwc->prev_count);
+
+	local64_set(&hwc->prev_count, now);
+	local64_add((now - prev) & MAKO_CTR_MASK, &event->count);
+}
+
+/*
+ * Read the counters, and if they are running for perf, update every
+ * started event. The counters have to be stopped to be read. They may
+ * have been left running by /dev/perf, so this always reads them. Called
+ * with interrupts off.
+ */
+static void mako_read_all(struct mako_pmu_cpu *pc)
+{
+	int i;
+
+	perf_mako_disable();
+	if (perf_mako_read(pc->ctrs) == 0 && pc->running) {
+		for (i = 0; i < MAKO_NUM_CTRS; i++) {
+			struct perf_event *event = pc->events[i];
+
+			if (event && !(event->hw.state & PERF_HES_STOPPED))
+				mako_event_update(event, pc->ctrs[i]);
+		}
+	}
+	if (pc->running)
+		perf_mako_enable();
+}
+
+static enum hrtimer_restart mako_poll(struct hrtimer *timer)
+{
+	struct mako_pmu_cpu *pc = container_of(timer, struct mako_pmu_cpu, timer);
+
+	mako_read_all(pc);
+	hrtimer_forward_now(timer, ns_to_ktime(MAKO_POLL_NS));
+
+	return HRTIMER_RESTART;
+}
+
+static void mako_pmu_disable(struct pmu *pmu)
+{
+	struct mako_pmu_cpu *pc = this_cpu_ptr(&mako_pmu_cpu);
+
+	mako_read_all(pc);
+	perf_mako_disable();
+	pc->running = false;
+}
+
+static void mako_pmu_enable(struct pmu *pmu)
+{
+	struct mako_pmu_cpu *pc = this_cpu_ptr(&mako_pmu_cpu);
+	struct perf_event *events[MAKO_NUM_CTRS];
+	struct perf_mako_config cfg;
+	int idx[MAKO_NUM_CTRS];
+	int i, n;
+
+	if (pc->running)
+		return;
+
+	n = mako_collect(pc, NULL, events);
+	if (!n) {
+		hrtimer_try_to_cancel(&pc->timer);
+		return;
+	}
+
+	/* add() placed the events, this only recomputes the configuration. */
+	if (WARN_ON_ONCE(!mako_schedule(events, n, idx, &cfg)))
+		return;
+
+	if (perf_mako_is_loaded(&cfg)) {
+		perf_mako_enable();
+	} else {
+		int ret = perf_mako_load(&cfg);
+
+		if (ret) {
+			pr_warn_once("cannot load the counter image: %d\n", ret);
+			return;
+		}
+		memset(pc->ctrs, 0, sizeof(pc->ctrs));
+		for (i = 0; i < n; i++)
+			local64_set(&events[i]->hw.prev_count, 0);
+	}
+	pc->running = true;
+
+	if (!hrtimer_active(&pc->timer))
+		hrtimer_start(&pc->timer, ns_to_ktime(MAKO_POLL_NS),
+			      HRTIMER_MODE_REL_PINNED_HARD);
+}
+
+static void mako_pmu_start(struct perf_event *event, int flags)
+{
+	struct mako_pmu_cpu *pc = this_cpu_ptr(&mako_pmu_cpu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	mako_read_all(pc);
+	local64_set(&hwc->prev_count, pc->ctrs[hwc->idx]);
+	hwc->state = 0;
+}
+
+static void mako_pmu_stop(struct perf_event *event, int flags)
+{
+	struct mako_pmu_cpu *pc = this_cpu_ptr(&mako_pmu_cpu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (hwc->state & PERF_HES_STOPPED)
+		return;
+
+	mako_read_all(pc);
+	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+}
+
+static int mako_pmu_add(struct perf_event *event, int flags)
+{
+	struct mako_pmu_cpu *pc = this_cpu_ptr(&mako_pmu_cpu);
+	struct perf_event *events[MAKO_NUM_CTRS + 1];
+	unsigned int code = mako_event_code(event);
+	struct perf_mako_config cfg;
+	int idx[MAKO_NUM_CTRS + 1];
+	unsigned long free = 0;
+	int i, n;
+
+	n = mako_collect(pc, event, events);
+	if (n > MAKO_NUM_CTRS || !mako_schedule(events, n, idx, &cfg))
+		return -EAGAIN;
+
+	/*
+	 * Keep the events already here on their counters. Each event can
+	 * use either only one counter or only ctr1 and ctr3, so if the
+	 * events fit together, one of this event's counters is free.
+	 */
+	for (i = 0; i < MAKO_NUM_CTRS; i++)
+		if (!pc->events[i] && (mako_ctrs[code] & BIT(i)))
+			free |= BIT(i);
+
+	event->hw.idx = __ffs(free);
+	pc->events[event->hw.idx] = event;
+
+	event->hw.state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	if (flags & PERF_EF_START)
+		mako_pmu_start(event, PERF_EF_RELOAD);
+
+	return 0;
+}
+
+static void mako_pmu_del(struct perf_event *event, int flags)
+{
+	struct mako_pmu_cpu *pc = this_cpu_ptr(&mako_pmu_cpu);
+
+	mako_pmu_stop(event, PERF_EF_UPDATE);
+	pc->events[event->hw.idx] = NULL;
+	perf_event_update_userpage(event);
+}
+
+static void mako_pmu_read(struct perf_event *event)
+{
+	mako_read_all(this_cpu_ptr(&mako_pmu_cpu));
+}
+
+static int mako_map_hw(u64 config)
+{
+	switch (config) {
+	case PERF_COUNT_HW_CPU_CYCLES:
+		return MAKO_EV_CYCLES;
+	case PERF_COUNT_HW_INSTRUCTIONS:
+		return MAKO_EV_INSTRUCTIONS;
+	default:
+		return -ENOENT;
+	}
+}
+
+static void mako_event_destroy(struct perf_event *event)
+{
+	perf_mako_pmu_put();
+}
+
+static int mako_pmu_event_init(struct perf_event *event)
+{
+	struct perf_event *leader = event->group_leader, *sibling;
+	struct perf_event *events[MAKO_NUM_CTRS + 1];
+	struct perf_mako_config cfg;
+	int idx[MAKO_NUM_CTRS + 1];
+	int code, n = 0;
+
+	switch (event->attr.type) {
+	case PERF_TYPE_HARDWARE:
+		code = mako_map_hw(event->attr.config);
+		break;
+	case PERF_TYPE_RAW:
+		if (event->attr.config & ~MAKO_CONFIG_EVENT)
+			return -EINVAL;
+		code = event->attr.config;
+		break;
+	default:
+		return -ENOENT;
+	}
+	if (code < 0)
+		return code;
+	if (code >= MAKO_EV_MAX || !mako_ctrs[code])
+		return -EINVAL;
+
+	event->hw.config = code;
+
+	/* The whole group has to fit on one core. */
+	if (leader != event && leader->pmu == event->pmu)
+		events[n++] = leader;
+	for_each_sibling_event(sibling, leader) {
+		if (sibling->pmu != event->pmu)
+			continue;
+		if (n >= MAKO_NUM_CTRS)
+			return -EINVAL;
+		events[n++] = sibling;
+	}
+	events[n++] = event;
+	if (!mako_schedule(events, n, idx, &cfg))
+		return -EINVAL;
+
+	if (!perf_mako_pmu_get())
+		return -EBUSY;
+	event->destroy = mako_event_destroy;
+	event->hw.idx = -1;
+
+	return 0;
+}
+
+PMU_FORMAT_ATTR(event, "config:0-7");
+
+static struct attribute *mako_format_attrs[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static const struct attribute_group mako_format_group = {
+	.name = "format",
+	.attrs = mako_format_attrs,
+};
+
+#define MAKO_EVENT_ATTR(_name, _code) \
+	PMU_EVENT_ATTR_STRING(_name, mako_attr_##_code, "event=" __stringify(_code))
+
+MAKO_EVENT_ATTR(cycles, 0);
+MAKO_EVENT_ATTR(instructions, 1);
+MAKO_EVENT_ATTR(tlb-misses, 2);
+MAKO_EVENT_ATTR(dtlb-misses, 7);
+MAKO_EVENT_ATTR(itlb-misses, 8);
+MAKO_EVENT_ATTR(nonnullified-instructions, 9);
+
+static struct attribute *mako_event_attrs[] = {
+	&mako_attr_0.attr.attr,
+	&mako_attr_1.attr.attr,
+	&mako_attr_2.attr.attr,
+	&mako_attr_7.attr.attr,
+	&mako_attr_8.attr.attr,
+	&mako_attr_9.attr.attr,
+	NULL,
+};
+
+static const struct attribute_group mako_events_group = {
+	.name = "events",
+	.attrs = mako_event_attrs,
+};
+
+static const struct attribute_group *mako_attr_groups[] = {
+	&mako_format_group,
+	&mako_events_group,
+	NULL,
+};
+
+static struct pmu mako_pmu = {
+	.task_ctx_nr	= perf_hw_context,
+	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT | PERF_PMU_CAP_NO_EXCLUDE,
+	.attr_groups	= mako_attr_groups,
+	.event_init	= mako_pmu_event_init,
+	.pmu_enable	= mako_pmu_enable,
+	.pmu_disable	= mako_pmu_disable,
+	.add		= mako_pmu_add,
+	.del		= mako_pmu_del,
+	.start		= mako_pmu_start,
+	.stop		= mako_pmu_stop,
+	.read		= mako_pmu_read,
+};
+
+static int __init mako_pmu_init(void)
+{
+	int cpu;
+
+	if (boot_cpu_data.cpu_type != mako && boot_cpu_data.cpu_type != mako2)
+		return 0;
+
+	for_each_possible_cpu(cpu)
+		hrtimer_setup(&per_cpu(mako_pmu_cpu, cpu).timer, mako_poll,
+			      CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED_HARD);
+
+	return perf_pmu_register(&mako_pmu, "cpu", PERF_TYPE_RAW);
+}
+device_initcall(mako_pmu_init);
diff --git a/arch/parisc/kernel/perf_mako.c b/arch/parisc/kernel/perf_mako.c
index e717ac0c97c8..626163c0b0ce 100644
--- a/arch/parisc/kernel/perf_mako.c
+++ b/arch/parisc/kernel/perf_mako.c
@@ -20,7 +20,10 @@
 #include <linux/iopoll.h>
 #include <linux/irqflags.h>
 #include <linux/kernel.h>
+#include <linux/lockdep.h>
 #include <linux/percpu.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
 #include <linux/uaccess.h>
 #include <asm/perf.h>
 #include <asm/special_insns.h>
@@ -35,7 +38,75 @@
 #define MAKO_RDR9_1_CONFIG	(1ULL << 56)
 #define MAKO_CCR_PERF		0x20
 
-static DEFINE_PER_CPU(bool, perf_mako_loaded);
+/*
+ * RDR4_0 bits 0-7 select what ctr0 counts. With bit 3 clear it counts TLB
+ * misses; bit 6 leaves out the data TLB misses and bit 7 the instruction
+ * TLB misses. With bit 3 set it counts retired instructions that are not
+ * nullified, and bits 4-7 each leave out the instructions at one of the
+ * four word offsets in an aligned 16-byte block.
+ *
+ * RDR bits are numbered from the most significant bit of the first
+ * doubleword.
+ */
+#define MAKO_RDR4_0_CTR0_INSNS	3
+#define MAKO_RDR4_0_CTR0_NO_DTLB	6
+#define MAKO_RDR4_0_CTR0_NO_ITLB	7
+
+struct perf_mako_cpu {
+	bool			loaded;
+	struct perf_mako_config	cfg;
+	uint64_t		rdr4_0[ARRAY_SIZE(perf_mako_rdr4_0)];
+};
+
+static DEFINE_PER_CPU(struct perf_mako_cpu, perf_mako_cpu);
+
+/* /dev/perf loads the default configuration. */
+static const struct perf_mako_config perf_mako_dev_cfg;
+
+/* /dev/perf and perf events must not program the counters at once. */
+static DEFINE_SPINLOCK(perf_mako_owner_lock);
+static bool perf_mako_dev_open;
+static unsigned int perf_mako_pmu_users;
+
+bool perf_mako_dev_get(void)
+{
+	bool ok;
+
+	spin_lock(&perf_mako_owner_lock);
+	ok = !perf_mako_pmu_users;
+	if (ok)
+		perf_mako_dev_open = true;
+	spin_unlock(&perf_mako_owner_lock);
+
+	return ok;
+}
+
+void perf_mako_dev_put(void)
+{
+	spin_lock(&perf_mako_owner_lock);
+	perf_mako_dev_open = false;
+	spin_unlock(&perf_mako_owner_lock);
+}
+
+bool perf_mako_pmu_get(void)
+{
+	bool ok;
+
+	spin_lock(&perf_mako_owner_lock);
+	ok = !perf_mako_dev_open;
+	if (ok)
+		perf_mako_pmu_users++;
+	spin_unlock(&perf_mako_owner_lock);
+
+	return ok;
+}
+
+void perf_mako_pmu_put(void)
+{
+	spin_lock(&perf_mako_owner_lock);
+	perf_mako_pmu_users--;
+	spin_unlock(&perf_mako_owner_lock);
+}
 
 /* The second core of a processor, which owns the second half of RDR15_1. */
 static bool perf_mako_core_b(void)
@@ -43,6 +114,29 @@ static bool perf_mako_core_b(void)
 	return perf_get_dr2() & MAKO_DR2_CORE;
 }
 
+static void perf_mako_set_bit(uint64_t *buf, unsigned int bit, bool val)
+{
+	uint64_t m = 1ULL << (63 - bit % 64);
+
+	if (val)
+		buf[bit / 64] |= m;
+	else
+		buf[bit / 64] &= ~m;
+}
+
+/* Build this CPU's copy of RDR4_0 for cfg. */
+static void perf_mako_build(struct perf_mako_cpu *pc,
+			    const struct perf_mako_config *cfg)
+{
+	memcpy(pc->rdr4_0, perf_mako_rdr4_0, sizeof(pc->rdr4_0));
+	if (cfg->ctr0 == MAKO_CTR0_DTLB)
+		perf_mako_set_bit(pc->rdr4_0, MAKO_RDR4_0_CTR0_NO_ITLB, true);
+	else if (cfg->ctr0 == MAKO_CTR0_ITLB)
+		perf_mako_set_bit(pc->rdr4_0, MAKO_RDR4_0_CTR0_NO_DTLB, true);
+	else if (cfg->ctr0 == MAKO_CTR0_INSNS)
+		perf_mako_set_bit(pc->rdr4_0, MAKO_RDR4_0_CTR0_INSNS, true);
+}
+
 /*
  * The other core holds chain 1 only while it loads or reads its counters,
  * with interrupts off.
@@ -138,16 +232,24 @@ static void perf_mako_ctrs_rw(uint64_t *buf, bool clear)
 }
 
 /*
- * Write the image and start the counters on this CPU, from zero. Called
- * with interrupts off. Like the firmware's boot-time load, this holds
- * chain 1 across the image write and pmenb.
+ * Write the image for cfg and start the counters on this CPU, from zero.
+ * Called with interrupts off. Like the firmware, this holds chain 1 across
+ * the image write and pmenb.
  */
-static int perf_mako_load(void)
+int perf_mako_load(const struct perf_mako_config *cfg)
 {
-	unsigned long ccr = mfctl(10);
+	struct perf_mako_cpu *pc = this_cpu_ptr(&perf_mako_cpu);
+	unsigned long ccr;
 	uint64_t ctrs[4];
 	int i, ret;
 
+	lockdep_assert_irqs_disabled();
+	perf_mako_build(pc, cfg);
+	if (pc->loaded)
+		perf_intrigue_disable_perf_counters();
+	pc->loaded = false;
+
+	ccr = mfctl(10);
 	mtctl(ccr | MAKO_CCR_PERF, 10);
 	ret = perf_mako_chain1_get();
 	if (ret)
@@ -164,6 +266,8 @@ static int perf_mako_load(void)
 		 */
 		if (r->chain == 1 && r->rdr == 15)
 			perf_mako_ctrs_rw(ctrs, true);
+		else if (r->chain == 0 && r->rdr == 4)
+			perf_mako_rdr_merge(r, pc->rdr4_0);
 		else
 			perf_mako_rdr_merge(r, r->data);
 	}
@@ -171,19 +275,28 @@ static int perf_mako_load(void)
 
 	asm volatile("pmenb" ::: "memory");
 	perf_mako_chain1_put();
-	this_cpu_write(perf_mako_loaded, true);
+	pc->cfg = *cfg;
+	pc->loaded = true;
 out:
 	mtctl(ccr, 10);
 	return ret;
 }
 
-/* Read this CPU's four counters. Called with interrupts off. */
-static int perf_mako_read(uint32_t *c)
+/*
+ * Read this CPU's four counters. Called with interrupts off and the
+ * counters stopped.
+ */
+int perf_mako_read(uint32_t *c)
 {
-	unsigned long ccr = mfctl(10);
+	unsigned long ccr;
 	uint64_t buf[4];
 	int i, w, ret;
 
+	lockdep_assert_irqs_disabled();
+	if (!this_cpu_read(perf_mako_cpu.loaded))
+		return -EINVAL;
+
+	ccr = mfctl(10);
 	mtctl(ccr | MAKO_CCR_PERF, 10);
 	ret = perf_mako_chain1_get();
 	if (ret)
@@ -202,31 +315,61 @@ static int perf_mako_read(uint32_t *c)
 	return ret;
 }
 
+/* Start or stop the counters of a loaded CPU. Called with interrupts off. */
+void perf_mako_enable(void)
+{
+	if (this_cpu_read(perf_mako_cpu.loaded))
+		perf_intrigue_enable_perf_counters();
+}
+
+void perf_mako_disable(void)
+{
+	if (this_cpu_read(perf_mako_cpu.loaded))
+		perf_intrigue_disable_perf_counters();
+}
+
+static bool perf_mako_cfg_equal(const struct perf_mako_config *a,
+				const struct perf_mako_config *b)
+{
+	return a->ctr0 == b->ctr0;
+}
+
+/*
+ * Whether cfg is loaded on this CPU and still in effect, so that the
+ * counters can be restarted without loading it again.
+ */
+bool perf_mako_is_loaded(const struct perf_mako_config *cfg)
+{
+	struct perf_mako_cpu *pc = this_cpu_ptr(&perf_mako_cpu);
+
+	return pc->loaded && perf_mako_cfg_equal(&pc->cfg, cfg);
+}
+
+/* PA_PERF_ON: load the default configuration, or restart. */
 int perf_mako_start(void)
 {
 	unsigned long flags;
 	int ret = 0;
 
 	local_irq_save(flags);
-	if (this_cpu_read(perf_mako_loaded))
-		perf_intrigue_enable_perf_counters();
+	if (perf_mako_is_loaded(&perf_mako_dev_cfg))
+		perf_mako_enable();
 	else
-		ret = perf_mako_load();
+		ret = perf_mako_load(&perf_mako_dev_cfg);
 	local_irq_restore(flags);
 
 	return ret;
 }
 
+/* PA_PERF_OFF */
 int perf_mako_stop(uint32_t *raddr)
 {
 	unsigned long flags;
-	int ret = -EINVAL;
+	int ret;
 
 	local_irq_save(flags);
-	if (this_cpu_read(perf_mako_loaded)) {
-		perf_intrigue_disable_perf_counters();
-		ret = perf_mako_read(raddr);
-	}
+	perf_mako_disable();
+	ret = perf_mako_read(raddr);
 	local_irq_restore(flags);
 
 	return ret;
@@ -251,9 +394,7 @@ ssize_t perf_mako_write(const char __user *buf, size_t count)
 		return -EINVAL;
 
 	local_irq_save(flags);
-	if (this_cpu_read(perf_mako_loaded))
-		perf_intrigue_disable_perf_counters();
-	ret = perf_mako_load();
+	ret = perf_mako_load(&perf_mako_dev_cfg);
 	local_irq_restore(flags);
 
 	return ret ? ret : count;
diff --git a/arch/parisc/kernel/perf_mako.h b/arch/parisc/kernel/perf_mako.h
index 88ca6cef988f..5a5ba83c893f 100644
--- a/arch/parisc/kernel/perf_mako.h
+++ b/arch/parisc/kernel/perf_mako.h
@@ -12,6 +12,31 @@ void perf_mako_rdr_write(unsigned long index, uint64_t value);
 void perf_intrigue_enable_perf_counters(void);
 void perf_intrigue_disable_perf_counters(void);
 
+/* What ctr0 counts */
+enum {
+	MAKO_CTR0_TLB,		/* TLB misses, instruction and data */
+	MAKO_CTR0_DTLB,		/* data TLB misses */
+	MAKO_CTR0_ITLB,		/* instruction TLB misses */
+	MAKO_CTR0_INSNS,	/* instructions retired and not nullified */
+};
+
+struct perf_mako_config {
+	unsigned int	ctr0;		/* MAKO_CTR0_* */
+};
+
+/* perf_mako.c, with interrupts off */
+int perf_mako_load(const struct perf_mako_config *cfg);
+int perf_mako_read(uint32_t *c);
+void perf_mako_enable(void);
+void perf_mako_disable(void);
+bool perf_mako_is_loaded(const struct perf_mako_config *cfg);
+
+/* Exclusion between /dev/perf and perf events */
+bool perf_mako_dev_get(void);
+void perf_mako_dev_put(void);
+bool perf_mako_pmu_get(void);
+void perf_mako_pmu_put(void);
+
 /* perf_mako.c, for /dev/perf */
 ssize_t perf_mako_write(const char __user *buf, size_t count);
 int perf_mako_start(void);

-- 
2.56.1

