Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795755799;
	b=QoCWp5D8oLYkF9NEZP/StHqQNBNvGsOH9zl7lsDGHU+K31/2wirvUFo8mlevLi4y5Jfy
	 hcmenrT4EWZ2BXZ+rei8+bqmyOrPnTp4MEI+gzBZWZNbYJUIWZWsh5Q3fDrvjWPi9a8nR
	 JYoMUx6ctg25Y44tLQpa1VaG68f+Nm2Mfdcg1VEyDs0nxJ0nEXHwv33fKVkdfqFQmxkVI
	 5UBlAALz0/esx24g246/kIfthoZ93RRcZXrgPVGwCmhjaEKgbmz9/wvAU5LpZ0nk5x+4y
	 etP2O8iOouGtDOMxNbfoGpfhi3QtAEJLycnTi6Itgg2LLKj5gFLpbW3ZUBrEASwbaEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795755799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=DpIois4Ujh17xwC4T8qgSSKBqN7XNqEPRqIoJONvB+Q=;
	b=mPkhXAmueOg2WMsgKlwjS77zs66GI4bVUSElk0C3VbCo0brLTiyt5Gd6A0zAexi7/571
	 itcE45/AQPZ7Nvu8y/chgpdvnLZLHEpNkcJEM/dkGW+S9qDR11LIKBB5fAOl0SGJYQPOe
	 rCPjiwUmsI6X23U1apUdnGrPKIzWB1Q3QBEZnGFPJtVm5G1ccQHixbQvY4d4DqguzVIVJ
	 LZvG3chbtwIQ8Y9WfIRIUGa9c0yQRVyYwNatQDksEgPy1DQevSdz2j6w5FsqLhV821tnW
	 6uBg4oSMudCdVQPk15LkQY3X477NWNmTGMaHttTMEdmYbONnfTgUu3iwwFUaf0IP0ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hlk9Z8pc;
	arc=none smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B13606A329
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 05:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2B13606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hlk9Z8pc
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-67dabd38cdfso7746847d50.2
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 21:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795755798; x=1796360598; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DpIois4Ujh17xwC4T8qgSSKBqN7XNqEPRqIoJONvB+Q=;
        b=hlk9Z8pcyBpJ/P4JMlWJITIn4co0JCkMXlarSANzmn1IeStCLaacc4/m0GZALXZuVe
         Ds91ReslKt6vAtCrs+J8rnrBTg/keg+KRUb0D+VOWqQhHxGRw3CeqJ1gnffnV/khjkHe
         pWiir+cmcTtLvTV41O0IMkRkIKGflXHgmia7W6gwOCB8WPHkuqhkyPeANvcEWc15JE5j
         zgbaaTqFt28+HK9MgUcf0JQEvwpl41xMIS7FsuqeGSnlsr+XPecqSZTcpufyx6unqpvB
         mbwunt/kaWhzAKCiMZ7ZHukSQqj2V8utt/pYwDHuZCBoHmE5urjgaot3RARjuxU1Eexb
         jgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795755798; x=1796360598;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DpIois4Ujh17xwC4T8qgSSKBqN7XNqEPRqIoJONvB+Q=;
        b=KQVPF5PUYkQ/bZr4WZXBEMr5Qo/qsRkh3cwH7mD858ykX3LA54hr8wcTLGkVpZ1ird
         Ntv7ItltFyb4p7XiVhJd2iHJ6hAUgS4/yomM2S/mIJ7FYk67cFmLLSKPjdbVWW6A7n0h
         QWrJCPFOgBPYSO8mX/XdYo+d6QUM59PZq7LzzB7RGGoasm1np+Wz902BRqIeFQLUG1ut
         v9mEkUhzB5SKLFcieUHOiW013wiItJtKhOerOQa9NaiuDUhi0UvxwrViVlk1v24fpxp5
         bIkiZfdN4DSVntcCCDriTp357bahYWes1vLehV28nmUDfq9mEUlDkrWEMp1tAb5+btHx
         uARQ==
X-Forwarded-Encrypted: i=1; AL+hErFSTFb6k3uXzNB2Y0DLtJUSeHPY4stwBND5ZgAlj9MYSmDednXCXJ/YvFluPqqdwo/0GlrkYBsevDpTM2zqCDzw@vger.kernel.org
X-Gm-Message-State: APuU4Z+5rPUETkXB10W1f96sphN3reYwY0wAd+7aaKvJhRjdYjcCYyYo
	KKu8i5hta7ucuyg2/AtXjPElbbw8R5uCPDj+DCwCDbXPqz/5z52nNPBs
X-Gm-Gg: AZFdTZdHK3PbltSe0dEb136A4HriRIyi13hK8j4cM5r6Agx5AAxgXzgYD1jrzaV1DvH
	zf8A75hxqI0WiOorrthH3aXSnq6gXfV7vCCU2WOloZzfP96xxQFwhCR4IuXNMhYClSX7+muhphY
	S2KXgIp7kxRNTy8q4hN7VzGlpgft3g8qEYhMSjeRJT7BwS0/dhNAmj07X3yB1bsdehQfYJ5u4iE
	I8AVl3EiVsI2YxX8S9U7puDmOe2ELWe4hEfhOeA0aQxrSLYanp6U0qYeKmSDYmTp6a3d+KYGwqn
	mbz/hDyfJTq3Wtq1Rud3NRbnbj0xaWsMP9Ljudt6461W3uP7UPMa0OdrBQFAZW45IzywBjvwA2u
	HTYqBqQmgL4FXLAn9yV9/Z1PlOVrYliUZzEToFW7SMP7neMHEf3VSpwbM7630sD/ixS+mYIQBQh
	EiSihVm/lEquFgC2Pv/I6X58W2E2tbCE6wQ5No9V+K5U2+BYY8k5Zt74y4Wecq2t622dv+oFPpr
	N1P4f5t39mmx0QcfHLWaLVDfmwq96tlyOqgCZHH7xXB2YRTmIYd0801yuTwxSIz3SbAQr9823Iw
	0eTV4D4X0LszGC05lS94TG3Ons8xiU5xhEmRFZnAZ7OtnOfCs3K80fd+t7+UmUTJTmAcY/ePolf
	5uV9qieGt083M82W7nRIj0wtIiWpqM2gmye+oCsl2qQ==
X-Received: by 2002:a05:690e:4509:10b0:67b:9051:e335 with SMTP id 956f58d0204a3-67df43fbfccmr6441914d50.48.1795755797623;
        Thu, 26 Nov 2026 21:03:17 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df33554b5sm10810155d50.13.2026.11.26.21.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 21:03:16 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 27 Nov 2026 00:03:00 -0500
Subject: [PATCH 7/7] parisc: perf: add PA-8800/PA-8900 memory and branch
 events
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
Message-Id: <20261127-parisc-perf-pa8800-v1-7-4f3f077010ce@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12408; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=SMG8W+ssDWA7drHBNNX5LXn3gGh1t48pJqH6brkaUS0=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLI5+f4/bz3Gx1qo96fsx+t7THw+ep/ErM836G2pSte+Y
 pqwtVC24yMLgxgXw0wxRZa49Yoss9p2LPU5Lf0LZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 BDJ0jOIhcnoMGpnFxaWpRbppBUUOefkliSWZ+XnFevkFqXkF6QV6aZlpJRkZ+UXFqUAj9PJSS0x
 dHd2MDA1MLB0tzJwsHE1NnJ2dDJ3cHB2dXZ2MLM1NDJwtHU1cLc0ZuDgFYK65YsTI0LF1x5m0i4
 IXwjfxH/AJe6LAHK++rOjg4umu3Xrb7PddSGf4nx++aOrHb6v3Me5UvnS9bMbJlp67t7YsvGTxQ
 ntxwNfl7AwA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

RDR0_0 bits 0-4 select what ctr2 counts: instructions, loads and stores,
or loads and stores that miss the D-cache. The loads and stores count
leaves out most of the accesses that miss: a loop of loads or stores
that all miss counts about 0.2 of them. Bit 13 narrows the D-cache miss
count to stores. It narrows the loads and stores count too, but that
count leaves out the stores that miss, so plain stores are counted on
ctr0 instead, where RDR0_0 bit 11 makes the instruction count count
stores.

The PCX-W branch images carry over to ctr2: their match filter, opcodes
0x20-0x3f with RDR4_0 bit 247 clear and bits 266, 268 and 271-276 set,
counts branches, and their RDR4_0 qualifier bytes count taken branches.

Add the events mem-accesses, dcache-misses, stores, store-dcache-misses,
branches and taken-branches, and map the generic branch-instructions
event.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/parisc/kernel/perf_event_mako.c | 55 +++++++++++++++++++++++++---
 arch/parisc/kernel/perf_mako.c       | 71 ++++++++++++++++++++++++++++++++----
 arch/parisc/kernel/perf_mako.h       | 14 ++++++-
 3 files changed, 126 insertions(+), 14 deletions(-)

diff --git a/arch/parisc/kernel/perf_event_mako.c b/arch/parisc/kernel/perf_event_mako.c
index 50171267f98b..5898d1c032cd 100644
--- a/arch/parisc/kernel/perf_event_mako.c
+++ b/arch/parisc/kernel/perf_event_mako.c
@@ -5,12 +5,17 @@
  * Each core has four 31-bit counters, which count fixed events chosen by
  * an event set (see perf_mako.c):
  *
- *   ctr0: TLB misses, instruction and data, or only one kind, or
- *         instructions retired and not nullified
+ *   ctr0: TLB misses, instruction and data, or only one kind,
+ *         instructions retired and not nullified, or stores
  *   ctr1, ctr3: cycles, stall cycles, non-stall cycles or, on the first
  *               core of a processor, cycles handling TLB misses
- *   ctr2: instructions retired, optionally filtered by instruction, or
- *         instructions retired in non-stall cycles
+ *   ctr2: instructions retired, optionally filtered by instruction,
+ *         instructions retired in non-stall cycles, loads and stores,
+ *         D-cache misses, store D-cache misses, branches or taken branches
+ *
+ * ctr2's loads and stores count leaves out most of the accesses that miss
+ * the D-cache: a loop of loads or stores that all miss counts about 0.2
+ * of them.
  *
  * The counters do not interrupt, so only counting is supported, and they
  * count in all privilege levels. A counter wraps from 0x7fffffff to 0 and
@@ -56,6 +61,12 @@ enum {
 	MAKO_EV_ITLB_MISSES,
 	MAKO_EV_NONNULLIFIED_INSTRUCTIONS,
 	MAKO_EV_TLB_HANDLER_CYCLES,
+	MAKO_EV_MEM_ACCESSES,
+	MAKO_EV_DCACHE_MISSES,
+	MAKO_EV_STORES,
+	MAKO_EV_STORE_DCACHE_MISSES,
+	MAKO_EV_BRANCHES,
+	MAKO_EV_TAKEN_BRANCHES,
 	MAKO_EV_MAX,
 };
 
@@ -76,6 +87,21 @@ static const struct {
 	[MAKO_EV_ITLB_MISSES]		= { BIT(0), MAKO_EVENTS_DEFAULT },
 	[MAKO_EV_NONNULLIFIED_INSTRUCTIONS] = { BIT(0), MAKO_EVENTS_DEFAULT },
 	[MAKO_EV_TLB_HANDLER_CYCLES]	= { BIT(1) | BIT(3), MAKO_EVENTS_TLB_HANDLER },
+	[MAKO_EV_MEM_ACCESSES]		= { BIT(2), MAKO_EVENTS_DEFAULT },
+	[MAKO_EV_DCACHE_MISSES]		= { BIT(2), MAKO_EVENTS_DEFAULT },
+	[MAKO_EV_STORES]		= { BIT(0), MAKO_EVENTS_DEFAULT },
+	[MAKO_EV_STORE_DCACHE_MISSES]	= { BIT(2), MAKO_EVENTS_DEFAULT },
+	[MAKO_EV_BRANCHES]		= { BIT(2), MAKO_EVENTS_DEFAULT },
+	[MAKO_EV_TAKEN_BRANCHES]	= { BIT(2), MAKO_EVENTS_DEFAULT },
+};
+
+/* What ctr2 counts for each event that ctr2 can count. */
+static const u8 mako_ctr2[MAKO_EV_MAX] = {
+	[MAKO_EV_MEM_ACCESSES]		= MAKO_CTR2_MEMOPS,
+	[MAKO_EV_DCACHE_MISSES]		= MAKO_CTR2_DMISSES,
+	[MAKO_EV_STORE_DCACHE_MISSES]	= MAKO_CTR2_STORE_DMISSES,
+	[MAKO_EV_BRANCHES]		= MAKO_CTR2_BRANCHES,
+	[MAKO_EV_TAKEN_BRANCHES]	= MAKO_CTR2_TAKEN,
 };
 
 #define MAKO_CONFIG_EVENT	GENMASK_ULL(7, 0)
@@ -141,7 +167,12 @@ static bool mako_schedule(struct perf_event **events, int n, int *idx,
 		idx[i] = __ffs(free);
 		used |= BIT(idx[i]);
 
-		if (code == MAKO_EV_DTLB_MISSES)
+		if (mako_ctr2[code])
+			cfg->ctr2 = mako_ctr2[code];
+
+		if (code == MAKO_EV_STORES)
+			cfg->ctr0 = MAKO_CTR0_STORES;
+		else if (code == MAKO_EV_DTLB_MISSES)
 			cfg->ctr0 = MAKO_CTR0_DTLB;
 		else if (code == MAKO_EV_ITLB_MISSES)
 			cfg->ctr0 = MAKO_CTR0_ITLB;
@@ -382,6 +413,8 @@ static int mako_map_hw(u64 config)
 		return MAKO_EV_CYCLES;
 	case PERF_COUNT_HW_INSTRUCTIONS:
 		return MAKO_EV_INSTRUCTIONS;
+	case PERF_COUNT_HW_BRANCH_INSTRUCTIONS:
+		return MAKO_EV_BRANCHES;
 	default:
 		return -ENOENT;
 	}
@@ -479,6 +512,12 @@ MAKO_EVENT_ATTR(dtlb-misses, 7);
 MAKO_EVENT_ATTR(itlb-misses, 8);
 MAKO_EVENT_ATTR(nonnullified-instructions, 9);
 MAKO_EVENT_ATTR(tlb-handler-cycles, 10);
+MAKO_EVENT_ATTR(mem-accesses, 11);
+MAKO_EVENT_ATTR(dcache-misses, 12);
+MAKO_EVENT_ATTR(stores, 13);
+MAKO_EVENT_ATTR(store-dcache-misses, 14);
+MAKO_EVENT_ATTR(branches, 15);
+MAKO_EVENT_ATTR(taken-branches, 16);
 
 static struct attribute *mako_event_attrs[] = {
 	&mako_attr_0.attr.attr,
@@ -491,6 +530,12 @@ static struct attribute *mako_event_attrs[] = {
 	&mako_attr_8.attr.attr,
 	&mako_attr_9.attr.attr,
 	&mako_attr_10.attr.attr,
+	&mako_attr_11.attr.attr,
+	&mako_attr_12.attr.attr,
+	&mako_attr_13.attr.attr,
+	&mako_attr_14.attr.attr,
+	&mako_attr_15.attr.attr,
+	&mako_attr_16.attr.attr,
 	NULL,
 };
 
diff --git a/arch/parisc/kernel/perf_mako.c b/arch/parisc/kernel/perf_mako.c
index da8ffcdaa5eb..a93bcb332c9e 100644
--- a/arch/parisc/kernel/perf_mako.c
+++ b/arch/parisc/kernel/perf_mako.c
@@ -15,6 +15,7 @@
  * are only started on a CPU once the image has been loaded there.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bug.h>
 #include <linux/errno.h>
 #include <linux/iopoll.h>
@@ -63,7 +64,18 @@
  * misses; bit 6 leaves out the data TLB misses and bit 7 the instruction
  * TLB misses. With bit 3 set it counts retired instructions that are not
  * nullified, and bits 4-7 each leave out the instructions at one of the
- * four word offsets in an aligned 16-byte block.
+ * four word offsets in an aligned 16-byte block. With bit 3 set, RDR0_0
+ * bit 11 makes it count stores instead.
+ *
+ * RDR0_0 bits 0-4 select what ctr2 counts: instructions (the image's
+ * 01000), loads and stores (00100) or loads and stores that miss the
+ * D-cache (00101). The loads and stores count leaves out most of the
+ * accesses that miss. Bit 13 narrows either count to stores.
+ *
+ * The match filter set to opcodes 0x20-0x3f, with RDR4_0 bit 247 clear and
+ * bits 266, 268 and 271-276 set, counts branches on ctr2. RDR4_0 bytes
+ * 0-3 set to a0 80 80 a0 count taken branches. Both settings come from the
+ * PCX-W (PA-8500 to PA-8700) branch images.
  *
  * RDR bits are numbered from the most significant bit of the first
  * doubleword.
@@ -79,10 +91,22 @@
 #define MAKO_RDR4_0_CTR0_INSNS	3
 #define MAKO_RDR4_0_CTR0_NO_DTLB	6
 #define MAKO_RDR4_0_CTR0_NO_ITLB	7
+#define MAKO_RDR4_0_BRANCH	247
+#define MAKO_RDR4_0_TAKEN	0xa08080a0U
+#define MAKO_RDR0_0_CLASS	GENMASK_ULL(63, 59)
+#define MAKO_RDR0_0_MEMOPS	0x04
+#define MAKO_RDR0_0_DMISSES	0x05
+#define MAKO_RDR0_0_CTR0_STORES	11
+#define MAKO_RDR0_0_CTR2_STORES	13
+
+static const unsigned int perf_mako_rdr4_0_branch_set[] = {
+	266, 268, 271, 272, 273, 274, 275, 276,
+};
 
 struct perf_mako_cpu {
 	bool			loaded;
 	struct perf_mako_config	cfg;
+	uint64_t		rdr0_0[ARRAY_SIZE(perf_mako_rdr0_0)];
 	uint64_t		rdr4_0[ARRAY_SIZE(perf_mako_rdr4_0)];
 	uint64_t		rdr16_1[ARRAY_SIZE(perf_mako_rdr16_1)];
 };
@@ -190,33 +214,62 @@ static void perf_mako_set_bit(uint64_t *buf, unsigned int bit, bool val)
 		buf[bit / 64] &= ~m;
 }
 
-/* Build this CPU's copies of RDR4_0 and RDR16_1 for cfg. */
+/* Build this CPU's copies of RDR0_0, RDR4_0 and RDR16_1 for cfg. */
 static int perf_mako_build(struct perf_mako_cpu *pc,
 			   const struct perf_mako_config *cfg)
 {
 	bool core_b = perf_mako_core_b();
+	bool filter = cfg->filter;
+	uint32_t mask = cfg->mask, match = cfg->match;
 	unsigned int j;
 
 	if (cfg->set == MAKO_EVENTS_TLB_HANDLER && core_b)
 		return -EOPNOTSUPP;
 
+	memcpy(pc->rdr0_0, perf_mako_rdr0_0, sizeof(pc->rdr0_0));
+	if (cfg->ctr2 == MAKO_CTR2_MEMOPS) {
+		pc->rdr0_0[0] &= ~MAKO_RDR0_0_CLASS;
+		pc->rdr0_0[0] |= FIELD_PREP(MAKO_RDR0_0_CLASS, MAKO_RDR0_0_MEMOPS);
+	} else if (cfg->ctr2 == MAKO_CTR2_DMISSES ||
+		   cfg->ctr2 == MAKO_CTR2_STORE_DMISSES) {
+		pc->rdr0_0[0] &= ~MAKO_RDR0_0_CLASS;
+		pc->rdr0_0[0] |= FIELD_PREP(MAKO_RDR0_0_CLASS, MAKO_RDR0_0_DMISSES);
+	}
+	if (cfg->ctr2 == MAKO_CTR2_STORE_DMISSES)
+		perf_mako_set_bit(pc->rdr0_0, MAKO_RDR0_0_CTR2_STORES, true);
+	if (cfg->ctr0 == MAKO_CTR0_STORES)
+		perf_mako_set_bit(pc->rdr0_0, MAKO_RDR0_0_CTR0_STORES, true);
+
 	memcpy(pc->rdr4_0, perf_mako_rdr4_0, sizeof(pc->rdr4_0));
+	if (cfg->ctr2 == MAKO_CTR2_TAKEN) {
+		pc->rdr4_0[0] &= ~GENMASK_ULL(63, 32);
+		pc->rdr4_0[0] |= (uint64_t)MAKO_RDR4_0_TAKEN << 32;
+	}
 	if (cfg->ctr0 == MAKO_CTR0_DTLB)
 		perf_mako_set_bit(pc->rdr4_0, MAKO_RDR4_0_CTR0_NO_ITLB, true);
 	else if (cfg->ctr0 == MAKO_CTR0_ITLB)
 		perf_mako_set_bit(pc->rdr4_0, MAKO_RDR4_0_CTR0_NO_DTLB, true);
-	else if (cfg->ctr0 == MAKO_CTR0_INSNS)
+	else if (cfg->ctr0 == MAKO_CTR0_INSNS || cfg->ctr0 == MAKO_CTR0_STORES)
 		perf_mako_set_bit(pc->rdr4_0, MAKO_RDR4_0_CTR0_INSNS, true);
-	if (cfg->filter) {
+	if (cfg->ctr2 == MAKO_CTR2_BRANCHES) {
+		filter = true;
+		mask = match = 0x80000000;
+		perf_mako_set_bit(pc->rdr4_0, MAKO_RDR4_0_BRANCH, false);
+		for (j = 0; j < ARRAY_SIZE(perf_mako_rdr4_0_branch_set); j++)
+			perf_mako_set_bit(pc->rdr4_0,
+					  perf_mako_rdr4_0_branch_set[j], true);
+	}
+	if (filter) {
 		for (j = 0; j < 32; j++) {
 			uint32_t b = 1U << (31 - j);
 
 			perf_mako_set_bit(pc->rdr4_0, j <= 18 ? 145 - j : 282 - j,
-					  !(cfg->mask & b));
+					  !(mask & b));
 			perf_mako_set_bit(pc->rdr4_0, j <= 18 ? 108 + j : 205 + j,
-					  cfg->match & b);
+					  match & b);
 		}
-		perf_mako_set_bit(pc->rdr4_0, MAKO_RDR4_0_INVERT, cfg->invert);
+		perf_mako_set_bit(pc->rdr4_0, MAKO_RDR4_0_INVERT,
+				  cfg->filter && cfg->invert);
 	}
 
 	memcpy(pc->rdr16_1, perf_mako_rdr16_1, sizeof(pc->rdr16_1));
@@ -368,6 +421,8 @@ int perf_mako_load(const struct perf_mako_config *cfg)
 		 */
 		if (r->chain == 1 && r->rdr == 15)
 			perf_mako_ctrs_rw(ctrs, true);
+		else if (r->chain == 0 && r->rdr == 0)
+			perf_mako_rdr_merge(r, pc->rdr0_0);
 		else if (r->chain == 0 && r->rdr == 4)
 			perf_mako_rdr_merge(r, pc->rdr4_0);
 		else if (r->chain == 1 && r->rdr == 16)
@@ -436,7 +491,7 @@ void perf_mako_disable(void)
 static bool perf_mako_cfg_equal(const struct perf_mako_config *a,
 				const struct perf_mako_config *b)
 {
-	return a->set == b->set && a->ctr0 == b->ctr0 &&
+	return a->set == b->set && a->ctr0 == b->ctr0 && a->ctr2 == b->ctr2 &&
 	       a->filter == b->filter &&
 	       (!a->filter || (a->invert == b->invert &&
 			       a->mask == b->mask && a->match == b->match));
diff --git a/arch/parisc/kernel/perf_mako.h b/arch/parisc/kernel/perf_mako.h
index 15311b9d770c..424e90cd0583 100644
--- a/arch/parisc/kernel/perf_mako.h
+++ b/arch/parisc/kernel/perf_mako.h
@@ -37,6 +37,17 @@ enum {
 	MAKO_CTR0_DTLB,		/* data TLB misses */
 	MAKO_CTR0_ITLB,		/* instruction TLB misses */
 	MAKO_CTR0_INSNS,	/* instructions retired and not nullified */
+	MAKO_CTR0_STORES,	/* stores retired */
+};
+
+/* What ctr2 counts, in the default event set */
+enum {
+	MAKO_CTR2_INSNS,	/* instructions retired, maybe filtered */
+	MAKO_CTR2_MEMOPS,	/* loads and stores, few of those that miss */
+	MAKO_CTR2_DMISSES,	/* loads and stores that miss the D-cache */
+	MAKO_CTR2_STORE_DMISSES, /* stores that miss the D-cache */
+	MAKO_CTR2_BRANCHES,	/* branches retired */
+	MAKO_CTR2_TAKEN,	/* taken branches retired */
 };
 
 /*
@@ -47,7 +58,8 @@ enum {
 struct perf_mako_config {
 	unsigned int	set;		/* MAKO_EVENTS_* */
 	unsigned int	ctr0;		/* MAKO_CTR0_* */
-	bool		filter;
+	unsigned int	ctr2;		/* MAKO_CTR2_* */
+	bool		filter;		/* filter MAKO_CTR2_INSNS */
 	bool		invert;
 	uint32_t	mask;
 	uint32_t	match;

-- 
2.56.1

