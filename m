Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795755796;
	b=CrZ+71C4JlTpTR0RJ/15ApqiA6q4sFCKtIOWE/81qa6PcdEMuS2Urx9fw4FtoohLaq8y
	 rFcztVROSllARKBpqTJuzTMC1Bd+pAWGeIn/TTrYLeqbOdJZn2uu9JO2u9mXIrdwzTGYP
	 vtEm3m08bhmfBTYCnh8zXNxv91OD5mXjiaPNUMgWGVUzHJ11qtRHmuNWMY1lt5SbUPcM0
	 J5G3tzAt4kxt1b3rCPEOM4Q8CVbbIKNPuyffHxGpNy3EcaWBjBIG9KdIvjGu2HDcKwXBN
	 vGcJXhwPRorbFQd6oX2hK4OWQpNQs8CDTUQQv1jAttbGq8jcgR8XNyDTI9lXGpxMP2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795755796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=gcDZIRK6dF5ps1B+vXDiXqSxeIoKjOtedlk5scz0PGc=;
	b=KIJAsrhhQgvyjE1B0tKhCVG/63YKsDoFSPsynjXVrkHVe9KfkELpsYMsYmNG7VF2RzW1
	 6X1g//Vkj46jWcYjNNz1kxblWKnsWGPRMUS9e3jKDbkY4TNNxIIxjXlcz9p+UFzjEzxw+
	 6W4LcRIevNeoEz4PYkqrf0WPdL3IVpOoMZKvqeY6hkcjdiTJz4g8fNZlPsjjL7a+QnOji
	 vyfL2SWInCxfeRYoho/TaFzOy/hJzOeldOk9PlKkO2UjtMWz0iF4rz+J/9Lko8/2OqJHY
	 SVATYj/2Zevplz66e0Nt03Z9CmrOGZhr5cXYkoWwR+lO7oRhPYRsMqgsqFwcfw6w1Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0raKuYBn;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EEF606A32F
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 05:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12EEF606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0raKuYBn
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b10d24345dso70043937b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 21:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795755795; x=1796360595; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gcDZIRK6dF5ps1B+vXDiXqSxeIoKjOtedlk5scz0PGc=;
        b=0raKuYBndcOS7hmcaMREmWqi9OOctJVB8AfDYLLgihMvIIQTwYDpMH/k4Imv5ingst
         5pwN1dWvH4moePhwWGusUKP4yt2qhO7tmt7GEuxhnLbS5uHznzGW8pwgSgmsnn9Iwcox
         GA+mg9B4RNfFEbHpW6xlQbkQ+TYcWNPJXsG2PAwml2oVJgMjFtyyRiV55dh7ufXvnGP5
         jDeKm8klPOVK1GqAvXdk9NXEM0WIN1HVKBp24J1VUbs2m38P1PMz6yNzPVA/3EqtCVht
         JWX0pEPEtlxOy7/rI2qB7xZt4ZlcvLc041b0D+8Qvn301meysG/cJzvJU2JekTbmXMfG
         zBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795755795; x=1796360595;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gcDZIRK6dF5ps1B+vXDiXqSxeIoKjOtedlk5scz0PGc=;
        b=BGepskNELOFRCa0CEUijRu7+dUaq6lUczZKE1e/Sfud0syKyQyYN26q7IOAtoRj8SM
         nPeIWAZPLMAeC3BNCr0sJ2AQm7nzOlEYF2rmQy1PYeFHv/M2ZNijwXof1s0NApd5v4iD
         1doJpbfNNGumcBrPC67OP341fu1QW7knNPE52/I4MyXSXEP0KMvcBzJCasUf87zYGDzK
         OhWNTRTpfdnLl6VrI8XYg9sczJfl8Fr4fqzwu3g9ear+7EY1VYZqFzoDbzLUd8Lf1Ou4
         1tzcrDAFRqslv0VbqOqd1EvOxxRPYql+NHqHeALMapXU/Fi1JCn2wGh3EsZTHDAtHv2c
         5ZJg==
X-Forwarded-Encrypted: i=1; AL+hErEse4SwLf4ZFHJdLrTOrU6Huh+IiQ2xnXmQmpuzuRlZQrljZ+5FfrN29lWOm6QP3VvxEwnhXWawvDNyhGW8Hu0z@vger.kernel.org
X-Gm-Message-State: APuU4Z/236Sodhyac+uJ0JT39LixPXadBlErP9X8QC1VA5ZouCFRASmm
	3al94Rh99/JJsMfOgqFg+M6vUsjZYuKJgXjCdjMeuobPKoLTyoFL+blo
X-Gm-Gg: AZFdTZf6F5rrxCu5RzfcfZklzHLHVWKJ5wfa/ri05In2l1wQ3QJMGWO1+GgdE5m2qA8
	ZrQcdKlJAd6lInPfn4Hpe9vUXta5Qo+LwQEdOzLF0I97JceoJvmfMpy1Z3DQxqLRDixfzTMrewz
	ohsK8Q8OERCg3f4aresmQx/WefDXO4UHtTts8OQ8b2mct0nExTH25IlBU/S9F4GmTKXjIOZp5s6
	UEQ00EFTvbMkAhed0hQ312DeuLs/zlGSZSRf56o1MWUkRSfj/4Z9bVmjZONJTsPWxNV1zzgaoxj
	bbJpfRe2EjdJjhx9g5J2+lVKYGoFXc3YqlAux5NSKeGBVpsaCfIbIJDT9Y6Bl/XcQJKHVIdoY94
	UQ+lbymZEgysTAn+U9wBZ54I8Ne1QLDN7AAurXfmQpCNUeuuczLqdwRGf4R0evz+pzOHnwwagI0
	GMVRL1aAFgsidOWAfsK5nFAredgGMXpTYoriozSU8iet3ewWlwcff0FlDGueyJ2cweK/wrm6w+d
	3t244uG4abiFbImxbHGlMx5VZMczILqBEBVn01R2z5AF458LNAUBvQ3L3zwt7OTp2vT46IbujCa
	SUhM2o7Ihe2TgKf9khM6YYNcCr6NS6tSCjnGR8AbEqSuA6+rexkAiMnb1Dh8cnc48AWCGJoo1Tm
	JauK3eaCYO0xXqwmYPA8lf6rrogeNbABINjWlGZ3C7A==
X-Received: by 2002:a05:690c:6d8a:b0:8b4:dba5:f101 with SMTP id 00721157ae682-8b5204f720cmr99107357b3.52.1795755794720;
        Thu, 26 Nov 2026 21:03:14 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202bc515sm94584187b3.19.2026.11.26.21.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 21:03:13 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 27 Nov 2026 00:02:59 -0500
Subject: [PATCH 6/7] parisc: perf: add PA-8800/PA-8900 event sets and an
 instruction filter
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
Message-Id: <20261127-parisc-perf-pa8800-v1-6-4f3f077010ce@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=24681; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=dqSmgfMD0t8XlLzq5XQNSHAit441TI2zDROO0YDskEE=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLI5+f6/2bFpjuihDsv768/lS64JfP8j4NCJms3+V2TWf
 082O6SS2/GRhUGMi2GmmCJL3HpFllltO5b6nJb+BTOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GQIZOkbxEDk9Bo3M4uLS1CLdtIIih7z8ksSSzPy8Yr38gtS8gvQCvbTMtJKMjPyi4lSgEXp5qSW
 mro5uRoYGJpaOFmZOFo6mJs7OToZObo6Ozq5ORpbmJgbOlo4mrpbmDFycAjDXtPsyMnQWil/YFb
 dG8tQSodoX3B6rjNY/79181L1J8eWRJd47u48y/LNRU9233z0wZGuRe/sm3YPdqt/nF3FJOJ14+
 PHnhcpr0fwA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

Add perf events that need the shared RDR16_1 changed, which selects what
ctr1, ctr2 and ctr3 count, and an instruction filter on ctr2:

  event=3  stall-cycles           ctr1 or ctr3
  event=4  nonstall-cycles        ctr1 or ctr3
  event=5  nonstall-instructions  ctr2
  event=6  filtered instructions  ctr2, with mask, match and invert
  event=10 tlb-handler-cycles     ctr1 or ctr3, first core only

Stall cycles set one bit of RDR16_1 per core, bit 291 on the first core
of a processor and bit 275 on the second, and ctr2 then reads zero.
Non-stall cycles clear bit 559 on the first core. On the second core
that stops all four counters, so bit 275 is set there instead, together
with bit 324, which turns its stall qualifier into a non-stall one, and
bit 21, which does the same for ctr2. Setting bit 408 and clearing bit
415 makes ctr1 and ctr3 count the cycles spent handling TLB misses and
ctr2 about one per miss. This works only on the first core; on the
second it stops all four counters, so event 10 is not scheduled there.

The filter restricts ctr2 to the retired instructions that match a value
under a mask, or with invert to the others. RDR4_0 holds the mask and
match bits in two runs each, split after instruction bit 18.

The stall and non-stall qualifiers gate ctr0 as well (on the second core
they stop it), so all ctr0 events belong to the default set.

None of this is documented. The bits were found by setting and clearing
RDR bits one at a time on a C8000 and comparing the counts against known
workloads.

RDR16_1 is shared by both cores of a processor, and the stall bit of one
core garbles the other core's counts. All events on a core have to agree
on the event set, and the stall, non-stall and TLB handler sets are used
only while the other core has no events. Events that do not fit are left
to perf to multiplex. The image is also loaded again when the other core
has since loaded a different set into RDR16_1.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/parisc/kernel/perf_event_mako.c | 183 +++++++++++++++++++++++++++++------
 arch/parisc/kernel/perf_mako.c       | 123 +++++++++++++++++++++--
 arch/parisc/kernel/perf_mako.h       |  31 ++++++
 3 files changed, 302 insertions(+), 35 deletions(-)

diff --git a/arch/parisc/kernel/perf_event_mako.c b/arch/parisc/kernel/perf_event_mako.c
index f43c8a6cf13d..50171267f98b 100644
--- a/arch/parisc/kernel/perf_event_mako.c
+++ b/arch/parisc/kernel/perf_event_mako.c
@@ -2,27 +2,40 @@
 /*
  * perf events for the PA-8800/PA-8900 (Mako) performance counters
  *
- * Each core has four 31-bit counters (see perf_mako.c):
+ * Each core has four 31-bit counters, which count fixed events chosen by
+ * an event set (see perf_mako.c):
  *
  *   ctr0: TLB misses, instruction and data, or only one kind, or
  *         instructions retired and not nullified
- *   ctr1, ctr3: cycles
- *   ctr2: instructions retired
+ *   ctr1, ctr3: cycles, stall cycles, non-stall cycles or, on the first
+ *               core of a processor, cycles handling TLB misses
+ *   ctr2: instructions retired, optionally filtered by instruction, or
+ *         instructions retired in non-stall cycles
  *
  * The counters do not interrupt, so only counting is supported, and they
  * count in all privilege levels. A counter wraps from 0x7fffffff to 0 and
  * sets bit 31, which stays set. At four instructions a cycle ctr2 wraps
  * in under half a second, so a per-CPU hrtimer reads the counters every
  * 200 ms.
+ *
+ * The stall and non-stall qualifiers gate ctr0 as well, so the ctr0
+ * events belong to the default set.
+ *
+ * All events on a CPU must agree on the event set. The stall, non-stall
+ * and TLB handler sets also disturb the other core of the processor, so
+ * they are only used while that core has no events, and while one core
+ * uses them the other core can not add any. perf multiplexes the events
+ * that do not fit.
  */
 
 #define pr_fmt(fmt) "perf: " fmt
 
-#include <linux/bits.h>
+#include <linux/bitfield.h>
 #include <linux/hrtimer.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/perf_event.h>
+#include <linux/spinlock.h>
 #include <asm/processor.h>
 
 #include "perf_mako.h"
@@ -35,23 +48,40 @@ enum {
 	MAKO_EV_CYCLES,
 	MAKO_EV_INSTRUCTIONS,
 	MAKO_EV_TLB_MISSES,
-	MAKO_EV_DTLB_MISSES = 7,
+	MAKO_EV_STALL_CYCLES,
+	MAKO_EV_NONSTALL_CYCLES,
+	MAKO_EV_NONSTALL_INSTRUCTIONS,
+	MAKO_EV_FILTERED_INSTRUCTIONS,
+	MAKO_EV_DTLB_MISSES,
 	MAKO_EV_ITLB_MISSES,
 	MAKO_EV_NONNULLIFIED_INSTRUCTIONS,
+	MAKO_EV_TLB_HANDLER_CYCLES,
 	MAKO_EV_MAX,
 };
 
-/* The counters that can count each event, none for unused codes. */
-static const u8 mako_ctrs[MAKO_EV_MAX] = {
-	[MAKO_EV_CYCLES]		= BIT(1) | BIT(3),
-	[MAKO_EV_INSTRUCTIONS]		= BIT(2),
-	[MAKO_EV_TLB_MISSES]		= BIT(0),
-	[MAKO_EV_DTLB_MISSES]		= BIT(0),
-	[MAKO_EV_ITLB_MISSES]		= BIT(0),
-	[MAKO_EV_NONNULLIFIED_INSTRUCTIONS] = BIT(0),
+#define MAKO_SET_ANY		-1
+
+static const struct {
+	u8	ctrs;		/* counters that can count it */
+	s8	set;		/* MAKO_EVENTS_* */
+} mako_events[MAKO_EV_MAX] = {
+	[MAKO_EV_CYCLES]		= { BIT(1) | BIT(3), MAKO_EVENTS_DEFAULT },
+	[MAKO_EV_INSTRUCTIONS]		= { BIT(2), MAKO_EVENTS_DEFAULT },
+	[MAKO_EV_TLB_MISSES]		= { BIT(0), MAKO_EVENTS_DEFAULT },
+	[MAKO_EV_STALL_CYCLES]		= { BIT(1) | BIT(3), MAKO_EVENTS_STALL },
+	[MAKO_EV_NONSTALL_CYCLES]	= { BIT(1) | BIT(3), MAKO_EVENTS_NONSTALL },
+	[MAKO_EV_NONSTALL_INSTRUCTIONS]	= { BIT(2), MAKO_EVENTS_NONSTALL },
+	[MAKO_EV_FILTERED_INSTRUCTIONS]	= { BIT(2), MAKO_EVENTS_DEFAULT },
+	[MAKO_EV_DTLB_MISSES]		= { BIT(0), MAKO_EVENTS_DEFAULT },
+	[MAKO_EV_ITLB_MISSES]		= { BIT(0), MAKO_EVENTS_DEFAULT },
+	[MAKO_EV_NONNULLIFIED_INSTRUCTIONS] = { BIT(0), MAKO_EVENTS_DEFAULT },
+	[MAKO_EV_TLB_HANDLER_CYCLES]	= { BIT(1) | BIT(3), MAKO_EVENTS_TLB_HANDLER },
 };
 
 #define MAKO_CONFIG_EVENT	GENMASK_ULL(7, 0)
+#define MAKO_CONFIG_INVERT	BIT_ULL(8)
+#define MAKO_CONFIG1_MASK	GENMASK_ULL(31, 0)
+#define MAKO_CONFIG1_MATCH	GENMASK_ULL(63, 32)
 
 struct mako_pmu_cpu {
 	struct perf_event	*events[MAKO_NUM_CTRS];
@@ -62,29 +92,52 @@ struct mako_pmu_cpu {
 
 static DEFINE_PER_CPU(struct mako_pmu_cpu, mako_pmu_cpu);
 
-/* The event code, which event_init() leaves in hw.config. */
-static unsigned int mako_event_code(struct perf_event *event)
+/*
+ * The event set each core of a processor uses, MAKO_SET_ANY when it has no
+ * events. Kept at perf_mako_chip_cpu() and indexed by perf_mako_core_b().
+ */
+struct mako_chip {
+	raw_spinlock_t	lock;
+	int		set[2];
+};
+
+static DEFINE_PER_CPU(struct mako_chip, mako_chip);
+
+static struct mako_chip *mako_this_chip(void)
 {
-	return event->hw.config;
+	return per_cpu_ptr(&mako_chip, perf_mako_chip_cpu(smp_processor_id()));
 }
 
 /*
- * Assign counters to the events, and work out the configuration they
- * need. Returns false if they do not fit together on one core.
+ * The event code, after event_init(), which leaves it and the invert flag in
+ * hw.config.
+ */
+static unsigned int mako_event_code(struct perf_event *event)
+{
+	return FIELD_GET(MAKO_CONFIG_EVENT, event->hw.config);
+}
+
+/*
+ * Assign counters to the events, and work out the event set and filter
+ * they need. Returns false if they do not fit together on one core.
  */
 static bool mako_schedule(struct perf_event **events, int n, int *idx,
 			  struct perf_mako_config *cfg)
 {
 	u8 used = 0;
-	int i;
+	int i, set = MAKO_SET_ANY;
 
 	memset(cfg, 0, sizeof(*cfg));
 	for (i = 0; i < n; i++) {
 		unsigned int code = mako_event_code(events[i]);
-		u8 free = mako_ctrs[code] & ~used;
+		u8 free = mako_events[code].ctrs & ~used;
+		int s = mako_events[code].set;
 
 		if (!free)
 			return false;
+		if (set != MAKO_SET_ANY && set != s)
+			return false;
+		set = s;
 		idx[i] = __ffs(free);
 		used |= BIT(idx[i]);
 
@@ -94,7 +147,17 @@ static bool mako_schedule(struct perf_event **events, int n, int *idx,
 			cfg->ctr0 = MAKO_CTR0_ITLB;
 		else if (code == MAKO_EV_NONNULLIFIED_INSTRUCTIONS)
 			cfg->ctr0 = MAKO_CTR0_INSNS;
+
+		if (code == MAKO_EV_FILTERED_INSTRUCTIONS) {
+			u64 c1 = events[i]->attr.config1;
+
+			cfg->filter = true;
+			cfg->invert = events[i]->hw.config & MAKO_CONFIG_INVERT;
+			cfg->mask = FIELD_GET(MAKO_CONFIG1_MASK, c1);
+			cfg->match = FIELD_GET(MAKO_CONFIG1_MATCH, c1);
+		}
 	}
+	cfg->set = set == MAKO_SET_ANY ? MAKO_EVENTS_DEFAULT : set;
 
 	return true;
 }
@@ -182,7 +245,7 @@ static void mako_pmu_enable(struct pmu *pmu)
 		return;
 	}
 
-	/* add() placed the events, this only recomputes the configuration. */
+	/* add() placed the events, this only recomputes the set. */
 	if (WARN_ON_ONCE(!mako_schedule(events, n, idx, &cfg)))
 		return;
 
@@ -228,6 +291,24 @@ static void mako_pmu_stop(struct perf_event *event, int flags)
 	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
 }
 
+/* Record the event set this core needs, if the other core allows it. */
+static bool mako_chip_claim(int set)
+{
+	struct mako_chip *chip = mako_this_chip();
+	int core = perf_mako_core_b(), other;
+	bool ok;
+
+	raw_spin_lock(&chip->lock);
+	other = chip->set[!core];
+	ok = other == MAKO_SET_ANY ||
+	     (other == MAKO_EVENTS_DEFAULT && set == MAKO_EVENTS_DEFAULT);
+	if (ok)
+		chip->set[core] = set;
+	raw_spin_unlock(&chip->lock);
+
+	return ok;
+}
+
 static int mako_pmu_add(struct perf_event *event, int flags)
 {
 	struct mako_pmu_cpu *pc = this_cpu_ptr(&mako_pmu_cpu);
@@ -241,6 +322,11 @@ static int mako_pmu_add(struct perf_event *event, int flags)
 	n = mako_collect(pc, event, events);
 	if (n > MAKO_NUM_CTRS || !mako_schedule(events, n, idx, &cfg))
 		return -EAGAIN;
+	/* A task's events can move to the second core, which cannot count it. */
+	if (cfg.set == MAKO_EVENTS_TLB_HANDLER && perf_mako_core_b())
+		return -EAGAIN;
+	if (!mako_chip_claim(cfg.set))
+		return -EAGAIN;
 
 	/*
 	 * Keep the events already here on their counters. Each event can
@@ -248,7 +334,7 @@ static int mako_pmu_add(struct perf_event *event, int flags)
 	 * events fit together, one of this event's counters is free.
 	 */
 	for (i = 0; i < MAKO_NUM_CTRS; i++)
-		if (!pc->events[i] && (mako_ctrs[code] & BIT(i)))
+		if (!pc->events[i] && (mako_events[code].ctrs & BIT(i)))
 			free |= BIT(i);
 
 	event->hw.idx = __ffs(free);
@@ -264,10 +350,24 @@ static int mako_pmu_add(struct perf_event *event, int flags)
 static void mako_pmu_del(struct perf_event *event, int flags)
 {
 	struct mako_pmu_cpu *pc = this_cpu_ptr(&mako_pmu_cpu);
+	struct mako_chip *chip = mako_this_chip();
+	struct perf_event *events[MAKO_NUM_CTRS];
+	int core = perf_mako_core_b();
+	struct perf_mako_config cfg;
+	int idx[MAKO_NUM_CTRS];
+	int n;
 
 	mako_pmu_stop(event, PERF_EF_UPDATE);
 	pc->events[event->hw.idx] = NULL;
 	perf_event_update_userpage(event);
+
+	n = mako_collect(pc, NULL, events);
+	raw_spin_lock(&chip->lock);
+	if (!n)
+		chip->set[core] = MAKO_SET_ANY;
+	else if (mako_schedule(events, n, idx, &cfg))
+		chip->set[core] = cfg.set;
+	raw_spin_unlock(&chip->lock);
 }
 
 static void mako_pmu_read(struct perf_event *event)
@@ -299,25 +399,32 @@ static int mako_pmu_event_init(struct perf_event *event)
 	struct perf_mako_config cfg;
 	int idx[MAKO_NUM_CTRS + 1];
 	int code, n = 0;
+	u64 config;
 
 	switch (event->attr.type) {
 	case PERF_TYPE_HARDWARE:
 		code = mako_map_hw(event->attr.config);
 		break;
 	case PERF_TYPE_RAW:
-		if (event->attr.config & ~MAKO_CONFIG_EVENT)
-			return -EINVAL;
-		code = event->attr.config;
+		code = FIELD_GET(MAKO_CONFIG_EVENT, event->attr.config);
 		break;
 	default:
 		return -ENOENT;
 	}
 	if (code < 0)
 		return code;
-	if (code >= MAKO_EV_MAX || !mako_ctrs[code])
+	if (code >= MAKO_EV_MAX)
 		return -EINVAL;
 
-	event->hw.config = code;
+	/* The filter fields are only valid on filtered instructions. */
+	config = event->attr.type == PERF_TYPE_RAW ? event->attr.config : code;
+	if (code != MAKO_EV_FILTERED_INSTRUCTIONS &&
+	    ((config & MAKO_CONFIG_INVERT) || event->attr.config1))
+		return -EINVAL;
+	if (config & ~(MAKO_CONFIG_EVENT | MAKO_CONFIG_INVERT))
+		return -EINVAL;
+
+	event->hw.config = code | (config & MAKO_CONFIG_INVERT);
 
 	/* The whole group has to fit on one core. */
 	if (leader != event && leader->pmu == event->pmu)
@@ -342,9 +449,15 @@ static int mako_pmu_event_init(struct perf_event *event)
 }
 
 PMU_FORMAT_ATTR(event, "config:0-7");
+PMU_FORMAT_ATTR(invert, "config:8");
+PMU_FORMAT_ATTR(mask, "config1:0-31");
+PMU_FORMAT_ATTR(match, "config1:32-63");
 
 static struct attribute *mako_format_attrs[] = {
 	&format_attr_event.attr,
+	&format_attr_invert.attr,
+	&format_attr_mask.attr,
+	&format_attr_match.attr,
 	NULL,
 };
 
@@ -359,17 +472,25 @@ static const struct attribute_group mako_format_group = {
 MAKO_EVENT_ATTR(cycles, 0);
 MAKO_EVENT_ATTR(instructions, 1);
 MAKO_EVENT_ATTR(tlb-misses, 2);
+MAKO_EVENT_ATTR(stall-cycles, 3);
+MAKO_EVENT_ATTR(nonstall-cycles, 4);
+MAKO_EVENT_ATTR(nonstall-instructions, 5);
 MAKO_EVENT_ATTR(dtlb-misses, 7);
 MAKO_EVENT_ATTR(itlb-misses, 8);
 MAKO_EVENT_ATTR(nonnullified-instructions, 9);
+MAKO_EVENT_ATTR(tlb-handler-cycles, 10);
 
 static struct attribute *mako_event_attrs[] = {
 	&mako_attr_0.attr.attr,
 	&mako_attr_1.attr.attr,
 	&mako_attr_2.attr.attr,
+	&mako_attr_3.attr.attr,
+	&mako_attr_4.attr.attr,
+	&mako_attr_5.attr.attr,
 	&mako_attr_7.attr.attr,
 	&mako_attr_8.attr.attr,
 	&mako_attr_9.attr.attr,
+	&mako_attr_10.attr.attr,
 	NULL,
 };
 
@@ -405,9 +526,15 @@ static int __init mako_pmu_init(void)
 	if (boot_cpu_data.cpu_type != mako && boot_cpu_data.cpu_type != mako2)
 		return 0;
 
-	for_each_possible_cpu(cpu)
+	for_each_possible_cpu(cpu) {
+		struct mako_chip *chip = per_cpu_ptr(&mako_chip, cpu);
+
+		raw_spin_lock_init(&chip->lock);
+		chip->set[0] = MAKO_SET_ANY;
+		chip->set[1] = MAKO_SET_ANY;
 		hrtimer_setup(&per_cpu(mako_pmu_cpu, cpu).timer, mako_poll,
 			      CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED_HARD);
+	}
 
 	return perf_pmu_register(&mako_pmu, "cpu", PERF_TYPE_RAW);
 }
diff --git a/arch/parisc/kernel/perf_mako.c b/arch/parisc/kernel/perf_mako.c
index 626163c0b0ce..da8ffcdaa5eb 100644
--- a/arch/parisc/kernel/perf_mako.c
+++ b/arch/parisc/kernel/perf_mako.c
@@ -24,6 +24,7 @@
 #include <linux/percpu.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
+#include <linux/topology.h>
 #include <linux/uaccess.h>
 #include <asm/perf.h>
 #include <asm/special_insns.h>
@@ -39,6 +40,25 @@
 #define MAKO_CCR_PERF		0x20
 
 /*
+ * The cycle signal of ctr1, ctr3 and ctr2 can be qualified by stall
+ * cycles: RDR16_1 bit 291 does this for the first core of a processor and
+ * bit 275 for the second. Each garbles the other core's counts, so only
+ * the bit of the core being programmed is set. Clearing bit 559 qualifies
+ * the signal by non-stall cycles on the first core; on the second it stops
+ * all four counters. There, setting bit 324 together with bit 275 turns
+ * the stall qualifier of ctr1 and ctr3 into a non-stall one, and bit 21
+ * then qualifies ctr2 the same way.
+ *
+ * Setting RDR16_1 bit 408 and clearing bit 415 makes ctr1 and ctr3 count
+ * the cycles spent handling TLB misses, and ctr2 about one per miss. This
+ * works only on the first core; on the second it stops all four counters.
+ *
+ * RDR4_0 compares each retiring instruction against a match value under a
+ * mask and gates ctr2 with the result. Instruction bit j (0 is the most
+ * significant) has its mask bit at 145 - j and its match bit at 108 + j
+ * for j <= 18, and at 282 - j and 205 + j above that. A set mask bit
+ * means don't care. Bit 19 inverts the comparison.
+ *
  * RDR4_0 bits 0-7 select what ctr0 counts. With bit 3 clear it counts TLB
  * misses; bit 6 leaves out the data TLB misses and bit 7 the instruction
  * TLB misses. With bit 3 set it counts retired instructions that are not
@@ -48,6 +68,14 @@
  * RDR bits are numbered from the most significant bit of the first
  * doubleword.
  */
+#define MAKO_RDR16_1_STALL_A	291
+#define MAKO_RDR16_1_STALL_B	275
+#define MAKO_RDR16_1_NONSTALL	559
+#define MAKO_RDR16_1_NONSTALL_B	324
+#define MAKO_RDR16_1_NONSTALL_B_CTR2	21
+#define MAKO_RDR16_1_TLB_HANDLER	408
+#define MAKO_RDR16_1_TLB_HANDLER_CLR	415
+#define MAKO_RDR4_0_INVERT	19
 #define MAKO_RDR4_0_CTR0_INSNS	3
 #define MAKO_RDR4_0_CTR0_NO_DTLB	6
 #define MAKO_RDR4_0_CTR0_NO_ITLB	7
@@ -56,6 +84,7 @@ struct perf_mako_cpu {
 	bool			loaded;
 	struct perf_mako_config	cfg;
 	uint64_t		rdr4_0[ARRAY_SIZE(perf_mako_rdr4_0)];
+	uint64_t		rdr16_1[ARRAY_SIZE(perf_mako_rdr16_1)];
 };
 
 static DEFINE_PER_CPU(struct perf_mako_cpu, perf_mako_cpu);
@@ -63,6 +92,15 @@ static DEFINE_PER_CPU(struct perf_mako_cpu, perf_mako_cpu);
 /* /dev/perf loads the default configuration. */
 static const struct perf_mako_config perf_mako_dev_cfg;
 
+/*
+ * RDR16_1 is shared by the two cores of a processor, and each load writes
+ * all of it, so a load on one core undoes the event set the other core
+ * selected. Record per processor, at perf_mako_chip_cpu(), which core's
+ * set RDR16_1 holds: the default set is the same for both cores. Loads
+ * are serialized by the chain 1 handshake.
+ */
+static DEFINE_PER_CPU(int, perf_mako_rdr16_1_key);
+
 /* /dev/perf and perf events must not program the counters at once. */
 static DEFINE_SPINLOCK(perf_mako_owner_lock);
 static bool perf_mako_dev_open;
@@ -109,11 +147,39 @@ void perf_mako_pmu_put(void)
 }
 
 /* The second core of a processor, which owns the second half of RDR15_1. */
-static bool perf_mako_core_b(void)
+bool perf_mako_core_b(void)
 {
 	return perf_get_dr2() & MAKO_DR2_CORE;
 }
 
+/*
+ * The first CPU of cpu's processor, where data shared by the processor's
+ * cores is kept. The package id stays the same while a CPU is offline.
+ */
+int perf_mako_chip_cpu(int cpu)
+{
+	int id = topology_physical_package_id(cpu), c;
+
+	for_each_possible_cpu(c)
+		if (topology_physical_package_id(c) == id)
+			return c;
+
+	return cpu;
+}
+
+static int perf_mako_key(const struct perf_mako_config *cfg)
+{
+	if (cfg->set == MAKO_EVENTS_DEFAULT)
+		return 0;
+	return cfg->set | perf_mako_core_b() << 4;
+}
+
+static int *perf_mako_chip_key(void)
+{
+	return per_cpu_ptr(&perf_mako_rdr16_1_key,
+			   perf_mako_chip_cpu(smp_processor_id()));
+}
+
 static void perf_mako_set_bit(uint64_t *buf, unsigned int bit, bool val)
 {
 	uint64_t m = 1ULL << (63 - bit % 64);
@@ -124,10 +190,16 @@ static void perf_mako_set_bit(uint64_t *buf, unsigned int bit, bool val)
 		buf[bit / 64] &= ~m;
 }
 
-/* Build this CPU's copy of RDR4_0 for cfg. */
-static void perf_mako_build(struct perf_mako_cpu *pc,
-			    const struct perf_mako_config *cfg)
+/* Build this CPU's copies of RDR4_0 and RDR16_1 for cfg. */
+static int perf_mako_build(struct perf_mako_cpu *pc,
+			   const struct perf_mako_config *cfg)
 {
+	bool core_b = perf_mako_core_b();
+	unsigned int j;
+
+	if (cfg->set == MAKO_EVENTS_TLB_HANDLER && core_b)
+		return -EOPNOTSUPP;
+
 	memcpy(pc->rdr4_0, perf_mako_rdr4_0, sizeof(pc->rdr4_0));
 	if (cfg->ctr0 == MAKO_CTR0_DTLB)
 		perf_mako_set_bit(pc->rdr4_0, MAKO_RDR4_0_CTR0_NO_ITLB, true);
@@ -135,6 +207,34 @@ static void perf_mako_build(struct perf_mako_cpu *pc,
 		perf_mako_set_bit(pc->rdr4_0, MAKO_RDR4_0_CTR0_NO_DTLB, true);
 	else if (cfg->ctr0 == MAKO_CTR0_INSNS)
 		perf_mako_set_bit(pc->rdr4_0, MAKO_RDR4_0_CTR0_INSNS, true);
+	if (cfg->filter) {
+		for (j = 0; j < 32; j++) {
+			uint32_t b = 1U << (31 - j);
+
+			perf_mako_set_bit(pc->rdr4_0, j <= 18 ? 145 - j : 282 - j,
+					  !(cfg->mask & b));
+			perf_mako_set_bit(pc->rdr4_0, j <= 18 ? 108 + j : 205 + j,
+					  cfg->match & b);
+		}
+		perf_mako_set_bit(pc->rdr4_0, MAKO_RDR4_0_INVERT, cfg->invert);
+	}
+
+	memcpy(pc->rdr16_1, perf_mako_rdr16_1, sizeof(pc->rdr16_1));
+	if (cfg->set == MAKO_EVENTS_STALL) {
+		perf_mako_set_bit(pc->rdr16_1, core_b ? MAKO_RDR16_1_STALL_B :
+				  MAKO_RDR16_1_STALL_A, true);
+	} else if (cfg->set == MAKO_EVENTS_NONSTALL && core_b) {
+		perf_mako_set_bit(pc->rdr16_1, MAKO_RDR16_1_STALL_B, true);
+		perf_mako_set_bit(pc->rdr16_1, MAKO_RDR16_1_NONSTALL_B, true);
+		perf_mako_set_bit(pc->rdr16_1, MAKO_RDR16_1_NONSTALL_B_CTR2, true);
+	} else if (cfg->set == MAKO_EVENTS_NONSTALL) {
+		perf_mako_set_bit(pc->rdr16_1, MAKO_RDR16_1_NONSTALL, false);
+	} else if (cfg->set == MAKO_EVENTS_TLB_HANDLER) {
+		perf_mako_set_bit(pc->rdr16_1, MAKO_RDR16_1_TLB_HANDLER, true);
+		perf_mako_set_bit(pc->rdr16_1, MAKO_RDR16_1_TLB_HANDLER_CLR, false);
+	}
+
+	return 0;
 }
 
 /*
@@ -244,7 +344,9 @@ int perf_mako_load(const struct perf_mako_config *cfg)
 	int i, ret;
 
 	lockdep_assert_irqs_disabled();
-	perf_mako_build(pc, cfg);
+	ret = perf_mako_build(pc, cfg);
+	if (ret)
+		return ret;
 	if (pc->loaded)
 		perf_intrigue_disable_perf_counters();
 	pc->loaded = false;
@@ -268,12 +370,15 @@ int perf_mako_load(const struct perf_mako_config *cfg)
 			perf_mako_ctrs_rw(ctrs, true);
 		else if (r->chain == 0 && r->rdr == 4)
 			perf_mako_rdr_merge(r, pc->rdr4_0);
+		else if (r->chain == 1 && r->rdr == 16)
+			perf_mako_rdr_merge(r, pc->rdr16_1);
 		else
 			perf_mako_rdr_merge(r, r->data);
 	}
 	perf_mako_config_bit(false);
 
 	asm volatile("pmenb" ::: "memory");
+	WRITE_ONCE(*perf_mako_chip_key(), perf_mako_key(cfg));
 	perf_mako_chain1_put();
 	pc->cfg = *cfg;
 	pc->loaded = true;
@@ -331,7 +436,10 @@ void perf_mako_disable(void)
 static bool perf_mako_cfg_equal(const struct perf_mako_config *a,
 				const struct perf_mako_config *b)
 {
-	return a->ctr0 == b->ctr0;
+	return a->set == b->set && a->ctr0 == b->ctr0 &&
+	       a->filter == b->filter &&
+	       (!a->filter || (a->invert == b->invert &&
+			       a->mask == b->mask && a->match == b->match));
 }
 
 /*
@@ -342,7 +450,8 @@ bool perf_mako_is_loaded(const struct perf_mako_config *cfg)
 {
 	struct perf_mako_cpu *pc = this_cpu_ptr(&perf_mako_cpu);
 
-	return pc->loaded && perf_mako_cfg_equal(&pc->cfg, cfg);
+	return pc->loaded && perf_mako_cfg_equal(&pc->cfg, cfg) &&
+	       READ_ONCE(*perf_mako_chip_key()) == perf_mako_key(cfg);
 }
 
 /* PA_PERF_ON: load the default configuration, or restart. */
diff --git a/arch/parisc/kernel/perf_mako.h b/arch/parisc/kernel/perf_mako.h
index 5a5ba83c893f..15311b9d770c 100644
--- a/arch/parisc/kernel/perf_mako.h
+++ b/arch/parisc/kernel/perf_mako.h
@@ -12,6 +12,25 @@ void perf_mako_rdr_write(unsigned long index, uint64_t value);
 void perf_intrigue_enable_perf_counters(void);
 void perf_intrigue_disable_perf_counters(void);
 
+/*
+ * Event sets, which select what ctr1, ctr2 and ctr3 count. Counters are
+ * listed ctr0 to ctr3.
+ *
+ * DEFAULT:     TLB misses, cycles, instructions retired, cycles
+ * STALL:       TLB misses, stall cycles, 0, stall cycles
+ * NONSTALL:    TLB misses, non-stall cycles, instructions retired in
+ *              non-stall cycles, non-stall cycles
+ * TLB_HANDLER: TLB misses, cycles in TLB miss handling, about one per
+ *              miss, cycles in TLB miss handling. Only on the first core
+ *              of a processor.
+ */
+enum {
+	MAKO_EVENTS_DEFAULT,
+	MAKO_EVENTS_STALL,
+	MAKO_EVENTS_NONSTALL,
+	MAKO_EVENTS_TLB_HANDLER,
+};
+
 /* What ctr0 counts */
 enum {
 	MAKO_CTR0_TLB,		/* TLB misses, instruction and data */
@@ -20,8 +39,18 @@ enum {
 	MAKO_CTR0_INSNS,	/* instructions retired and not nullified */
 };
 
+/*
+ * With filter set, ctr2 counts only the retired instructions whose bits
+ * selected by mask equal those of match, or with invert all other
+ * instructions. Nullified instructions count.
+ */
 struct perf_mako_config {
+	unsigned int	set;		/* MAKO_EVENTS_* */
 	unsigned int	ctr0;		/* MAKO_CTR0_* */
+	bool		filter;
+	bool		invert;
+	uint32_t	mask;
+	uint32_t	match;
 };
 
 /* perf_mako.c, with interrupts off */
@@ -30,6 +59,8 @@ int perf_mako_read(uint32_t *c);
 void perf_mako_enable(void);
 void perf_mako_disable(void);
 bool perf_mako_is_loaded(const struct perf_mako_config *cfg);
+bool perf_mako_core_b(void);
+int perf_mako_chip_cpu(int cpu);
 
 /* Exclusion between /dev/perf and perf events */
 bool perf_mako_dev_get(void);

-- 
2.56.1

