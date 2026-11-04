Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818441;
	b=VlyK0n4IQr+1pZ+Qd89HoEyQeBEaEXx8xTkCo2b/6pyDtEkLseCceWmN8/gSDWVJr2lP
	 Fq3lMPtruf3N2ZlvYT6LHYFi2LQTF9mYlMKJOjKAXkREDlQe4yBsfqlU+fagGIgfNqeVe
	 tNnUqvJcszFVcog0PCwdjJf0hd9ToBVQ2tv16VpXLdQovMhlPlKWzXjnSDcPwX82olKov
	 M1FYbBrRARPAMhLGin/Qva8tp3IVkkNVQuaU1ZHyBmaR69Py5N7lVPUbWKUAthSLexcrs
	 J9xsswkzpNI5hNGLw6t+jEOno1hvaaPG9QAoLBT0guN5d91FhrWhlk3FhR1YB6JH7ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=bG17toEvZh++6oWvbtdtKUsBVX6r9sD7TdpJIvwp2W8=;
	b=rxwLuGDytf90XTz1ynZ84+B17EOiDQ5jj2cQlu9cAvgw4C8Ipvqt3bddXCQNL2CzEqpX
	 X2eGTypCYbbxioljJ2cI9uBdDhSt1bFEdDjbxD2wsN/62sNHbXjhldl5KoWe5zH4K4y6R
	 MXIXPjsRqmUbLPvPFJ66OMNTXShOQ9Xmg4+87Dwrgew5qv9LWfH5misPC6UnCXCEKppiY
	 WOGv4Cq2ress4ABYjpIWsBawiDAlYAuiwmzgegFNl0jYS4v0v3QdsgqY607oQTUqSx1hs
	 Y7Z5ZeAhKxtf2U9KWq7b7m3SBD9Q3+s4ULPNnBKEp8jLiOXcRTr3VD8E5sRB5b42f0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SI6EEa2n;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7731E606EEA7
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 18:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7731E606EEA7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SI6EEa2n
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b10d24345dso10249307b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 10:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793818440; x=1794423240; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bG17toEvZh++6oWvbtdtKUsBVX6r9sD7TdpJIvwp2W8=;
        b=SI6EEa2noK56LZOEvuTiGj/vbhYI+Cae8xlwRgjKig4fhTbIr9UoIwjh6oqZWvB39g
         zRr2B6xRcISCXu8NZvap5bJNIkZUIeIEJyYOceD3/ZgK6fpNOKZOT+QkdbVhWRG2/sF1
         XVSigwBaA/5Espmk3Zrx05eRd0OuNI+clihfvHAHnN5UJSPruNFJC1vqP46ORtsG0VI3
         bN7zsQB4un/IquEUPzaKX8cHzu1bDp/9K9LAelPji7FRyo+XMClNqVvQA75OKMnPMj7S
         SpqTNmuOAmc1W60ULK4MCvEiJMVGS8y19SsUVxiWjNXjj8zfBKxt7+9iXfWvtWM943sX
         eA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818440; x=1794423240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bG17toEvZh++6oWvbtdtKUsBVX6r9sD7TdpJIvwp2W8=;
        b=NKTTR7Ra5+OQTG17iYOYf9J50LyKm36D6Z0sbzU+LQH0cvWz6gUrUDOxYrZap9YLcO
         RCGqQXLudkhR/QD/jHJjg0kGD0OLeI8aZfNf2RWcSM+v+SYPELn+JOD2em912CEQHjg/
         KlFn/+eOEXpBZfKvXQQfR8/AznSzElPDnsTHbgEk/SNM/VvXqSLNQ/vULXCth/Ffmgbe
         vAw9nSA4kp4JwtBKF5ZcBlFilYLCofWlQOqRy0IMlCug+hkM9F5uA50ktDX7G3uSrZks
         pIgoMZisCE1Bx4RqHxHbgKZZAFrWYFZFuMG2h158GTCaOXxzaYgD9B1V5f1sxhwoUVhH
         cb/w==
X-Forwarded-Encrypted: i=1; AKwUvByv1ICh/CuQQnA00QKCoXAONOYx4V8pN7Rd4tV8GmTFJQkvcjZ0lS9XR0Na6QhPozU2fxLXHj+iYordAPmOrOMj@vger.kernel.org
X-Gm-Message-State: APuU4Z8045OIxP5vJTZ5GR6dxtBjSn/kkN2BdaZIUsQ7aEezd7zSVvhG
	IGXrTQ5TF7Y18exfsK346qKT0M5w19lC6TjL1YuWlNmqP+m9h39g3UQI
X-Gm-Gg: AYBFou0PneoCvvsrGmPEEuuSiFh/9Mbb+/4Qr/mPmHFvZ49MfYg0V5MTI/tB40i6MiP
	6n0NpqbO2KlM14H0Gi/INe52PhmdxeQO0u04jly+I++95waHI0FsmrQa2aLjBg9HqDbKGCvOOOZ
	s7lBoIYJIO2eJTxMrL7qvKcevmWQhRDuuzdy5k/wQf6/yWpdDX8EIoWts/Z8Vj6KkXNrxOOr7hy
	q4T9fyfsx0c8LW/2zfXNJTm2Y8H8pyJv3lKnxWe6dbokehUR9LpBfpzpFhlTNJ+v4LmS0roRstk
	2/TBLIIQQOIRQrJK6Rcm5ExTqVvlDA7sNBf6NkcPgMHkHm2KoZJx5sj/eEDG8thiHpdFNeoEx3v
	cFzSj2iTefVid9+KV4RH593ALe4hBgvk0+H801CE5xjxc+rOTouvG3goi5mYAMeOO6OnJgOFSLM
	1qSPrkNIruCM6dO4RDrCOqE8YBoJElt9ktsNDxCEFilkld4tvJ6q/cLN4HlAbWjhSTACW7i+pUB
	7zm96jd1zE6s69V8A96jDODWGP4JUGQsC4Bv5IeF3gcCLsyHHSRgl3wtzzp+Muwn4ozfz0uX7da
	i7oLCRKayRNEzciVmLZM/PsVvy7nK7077yHMAMbpJjI+1hAua75vJpnxcEqWZE4rOUw4uaUx0ZD
	Em/YTKkz6eg==
X-Received: by 2002:a05:690c:30a:b0:8b1:6e61:513 with SMTP id 00721157ae682-8b2b64382d1mr172025907b3.0.1793818440462;
        Wed, 04 Nov 2026 10:54:00 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:66f3:d5d6:2d12:d460])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3099291d7sm24787807b3.16.2026.11.04.10.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:53:59 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 04 Nov 2026 13:53:56 -0500
Subject: [PATCH v4 1/3] perf alpha: Decode ProfileMe raw samples
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
Message-Id: <20261104-perf-alpha-profileme-v4-1-1771ea02950e@gmail.com>
References: <20261104-perf-alpha-profileme-v4-0-1771ea02950e@gmail.com>
In-Reply-To: <20261104-perf-alpha-profileme-v4-0-1771ea02950e@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Magnus Lindholm <linmag7@gmail.com>, linux-alpha@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10228; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=vN2dNodGOzqDv+WTFB0OWLrULDzd2p5lHoMP/25UmAw=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLJe17uwX58wQVfU54+Npuoam/MJvf1Bi1bpvmV7r+nSc
 vxR+uRdHR9YGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHNNlQjDj53s13uZNv
 5f/nFKaVGtbeivgyGHTXYbXrLle68bN1n3LSPD3+Q31XKPV8dEn23c4fq9OM370o+ksOxnX9klM
 utsPjEwAAA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

The Alpha cpu PMU attaches struct alpha_profileme_sample to each
ProfileMe sample as PERF_SAMPLE_RAW data: the profiled instruction's
PMPC along with the I_STAT and PCTR_CTL status that says what happened
to it.

Decode it in perf report -D and perf script -D the way AMD IBS raw data
is decoded, naming the trap from TRAP_TYPE when TRP is set and from the
PALcode entry offset in PMPC for redirect traps, which TRAP_TYPE does
not report. TRP is ignored for an instruction killed before it was
mapped, as an EV7 leaves it stale there. The payload is copied out of
the sample and converted from little endian, so that it decodes on
strict-alignment and big-endian hosts too.

Copy the uapi header that defines the struct into tools/arch and add it
to check-headers.sh.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
---
 tools/arch/alpha/include/uapi/asm/perf_event.h |  31 +++++
 tools/perf/check-headers.sh                    |   1 +
 tools/perf/util/Build                          |   1 +
 tools/perf/util/alpha-sample-raw.c             | 156 +++++++++++++++++++++++++
 tools/perf/util/sample-raw.c                   |   2 +
 tools/perf/util/sample-raw.h                   |   2 +
 6 files changed, 193 insertions(+)

diff --git a/tools/arch/alpha/include/uapi/asm/perf_event.h b/tools/arch/alpha/include/uapi/asm/perf_event.h
new file mode 100644
index 000000000000..aa0eff5a917c
--- /dev/null
+++ b/tools/arch/alpha/include/uapi/asm/perf_event.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_ASM_ALPHA_PERF_EVENT_H
+#define _UAPI_ASM_ALPHA_PERF_EVENT_H
+
+#include <linux/types.h>
+
+/*
+ * PERF_SAMPLE_RAW payload of a ProfileMe sample from the cpu PMU.
+ *
+ * pmpc, i_stat and pctr_ctl are the values of the PMPC, I_STAT and
+ * PCTR_CTL registers when the ProfileMe window closed. i_stat holds only
+ * bits 40:30 and pctr_ctl only bits 47:0. See the EV67/EV68 Hardware
+ * Reference Manuals for the field layout.
+ *
+ * In the sample record the payload follows the 32-bit PERF_SAMPLE_RAW
+ * size, so it starts 4 bytes past an 8-byte boundary. The 64-bit fields
+ * are packed after the 32-bit version so that they are 8-byte aligned in
+ * the record and no padding follows the payload.
+ *
+ * Fields may be added to the end in later versions.
+ */
+#define ALPHA_PROFILEME_SAMPLE_VERSION	1
+
+struct alpha_profileme_sample {
+	__u32 version;
+	__u64 pmpc __attribute__((packed));
+	__u64 i_stat __attribute__((packed));
+	__u64 pctr_ctl __attribute__((packed));
+};
+
+#endif /* _UAPI_ASM_ALPHA_PERF_EVENT_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 531c0e0e84df..de66bb148754 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -36,6 +36,7 @@ declare -a FILES=(
   "arch/x86/include/asm/msr-index.h"
   "arch/x86/lib/x86-opcode-map.txt"
   "arch/x86/tools/gen-insn-attr-x86.awk"
+  "arch/alpha/include/uapi/asm/perf_event.h"
   "arch/arm/include/uapi/asm/perf_regs.h"
   "arch/arm64/include/uapi/asm/perf_regs.h"
   "arch/loongarch/include/uapi/asm/perf_regs.h"
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 2c1f880c4c47..2ab63bbe4a05 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -77,6 +77,7 @@ perf-util-y += sample.o
 perf-util-y += sample-raw.o
 perf-util-y += s390-sample-raw.o
 perf-util-y += amd-sample-raw.o
+perf-util-y += alpha-sample-raw.o
 perf-util-y += ordered-events.o
 perf-util-y += namespaces.o
 perf-util-y += comm.o
diff --git a/tools/perf/util/alpha-sample-raw.c b/tools/perf/util/alpha-sample-raw.c
new file mode 100644
index 000000000000..6ff0566799ca
--- /dev/null
+++ b/tools/perf/util/alpha-sample-raw.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Alpha specific. Provide textual annotation for ProfileMe raw sample data.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <linux/kernel.h>
+#include <linux/perf_event.h>
+
+/* -Wpacked objects to the packed fields where __u64 is 4-byte aligned. */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wpacked"
+#pragma GCC diagnostic ignored "-Wattributes"
+#include "../../arch/alpha/include/uapi/asm/perf_event.h"
+#pragma GCC diagnostic pop
+
+#include "evlist.h"
+#include "evsel.h"
+#include "sample-raw.h"
+#include "util/sample.h"
+
+/* I_STAT */
+#define I_STAT_OVR(x)		(((x) >> 30) & 0x7)
+#define I_STAT_ICM(x)		(((x) >> 33) & 0x1)
+#define I_STAT_TRAP_TYPE(x)	(((x) >> 34) & 0xf)
+#define I_STAT_LSO(x)		(((x) >> 38) & 0x1)
+#define I_STAT_TRP(x)		(((x) >> 39) & 0x1)
+#define I_STAT_MIS(x)		(((x) >> 40) & 0x1)
+
+/* PCTR_CTL */
+#define PCTR_CTL_TAK(x)		((x) & 0x1)
+#define PCTR_CTL_VAL(x)		(((x) >> 1) & 0x1)
+#define PCTR_CTL_SL1(x)		(((x) >> 2) & 0x3)
+#define PCTR_CTL_SL0(x)		(((x) >> 4) & 0x1)
+#define PCTR_CTL_PCTR1(x)	(((x) >> 6) & 0xfffff)
+#define PCTR_CTL_KILLED(x)	(((x) >> 26) & 0x1)
+#define PCTR_CTL_STALLED(x)	(((x) >> 27) & 0x1)
+#define PCTR_CTL_PCTR0(x)	(((x) >> 28) & 0xfffff)
+
+/* PMPC */
+#define PMPC_PAL(x)		((x) & 0x1)
+#define PMPC_PAL_OFFSET(x)	((x) & 0x7fff)
+
+static const char * const trap_type_names[16] = {
+	[0]  = "replay",
+	[2]  = "DTB double miss (3 level)",
+	[3]  = "DTB double miss (4 level)",
+	[4]  = "FP disabled",
+	[5]  = "unaligned",
+	[6]  = "DTB single miss",
+	[7]  = "Dstream fault",
+	[8]  = "OPCDEC",
+	[10] = "machine check",
+	[12] = "arithmetic",
+	[14] = "MT_FPCR",
+	[15] = "reset",
+};
+
+/* What PCTR1 counts during the window, by SL1. */
+static const char * const pctr1_names[4] = {
+	"cycles",
+	"retire delay",
+	"bcache misses",
+	"mbox replays",
+};
+
+/* TRP, and MIS and the trap type with it, are stale for a killed insn. */
+static bool trapped(__u64 i_stat, __u64 ctl)
+{
+	return I_STAT_TRP(i_stat) && !PCTR_CTL_KILLED(ctl);
+}
+
+static const char *trap_name(__u64 i_stat, __u64 ctl, __u64 pmpc)
+{
+	const char *name;
+
+	/* Redirect traps leave TRAP_TYPE alone and are named by PMPC. */
+	if (PMPC_PAL(pmpc)) {
+		switch (PMPC_PAL_OFFSET(pmpc)) {
+		case 0x481:
+			return "Istream access violation";
+		case 0x581:
+			return "ITB miss";
+		case 0x681:
+			return "interrupt";
+		default:
+			break;
+		}
+	}
+	if (!trapped(i_stat, ctl) || I_STAT_MIS(i_stat))
+		return "none";
+	name = trap_type_names[I_STAT_TRAP_TYPE(i_stat)];
+	return name ? name : "other (see PMPC)";
+}
+
+/*
+ * Copy the payload out of the sample, since nothing guarantees its
+ * alignment in the buffer, and convert it from the little-endian byte
+ * order it was recorded in.
+ */
+static bool is_profileme_sample(struct evlist *evlist, union perf_event *event,
+				struct perf_sample *sample,
+				struct alpha_profileme_sample *pm)
+{
+	struct evsel *evsel;
+
+	if (sample->raw_size < sizeof(*pm))
+		return false;
+
+	evsel = evlist__event2evsel(evlist, event);
+	if (!evsel)
+		return false;
+	if (evsel->core.attr.type != PERF_TYPE_HARDWARE &&
+	    evsel->core.attr.type != PERF_TYPE_RAW)
+		return false;
+
+	memcpy(pm, sample->raw_data, sizeof(*pm));
+	pm->version = le32_to_cpu(pm->version);
+	pm->pmpc = le64_to_cpu(pm->pmpc);
+	pm->i_stat = le64_to_cpu(pm->i_stat);
+	pm->pctr_ctl = le64_to_cpu(pm->pctr_ctl);
+
+	return pm->version >= ALPHA_PROFILEME_SAMPLE_VERSION;
+}
+
+void evlist__alpha_sample_raw(struct evlist *evlist, union perf_event *event,
+			      struct perf_sample *sample)
+{
+	struct alpha_profileme_sample pm;
+	unsigned long long i_stat, ctl, pmpc;
+
+	if (event->header.type != PERF_RECORD_SAMPLE ||
+	    !is_profileme_sample(evlist, event, sample, &pm))
+		return;
+
+	i_stat = pm.i_stat;
+	ctl = pm.pctr_ctl;
+	pmpc = pm.pmpc;
+
+	printf("ProfileMe PMPC:\t%016llx %s trap %s%s\n",
+	       pmpc, PMPC_PAL(pmpc) ? "PAL" : (pmpc >> 63 ? "kernel" : "user"),
+	       trap_name(i_stat, ctl, pmpc),
+	       trapped(i_stat, ctl) && I_STAT_MIS(i_stat) ? " mispredicted" : "");
+	printf("ProfileMe I_STAT:\t%016llx TRP %d MIS %d LSO %d TrapType %d ICM %d OVR %d\n",
+	       i_stat, (int)I_STAT_TRP(i_stat), (int)I_STAT_MIS(i_stat),
+	       (int)I_STAT_LSO(i_stat), (int)I_STAT_TRAP_TYPE(i_stat),
+	       (int)I_STAT_ICM(i_stat), (int)I_STAT_OVR(i_stat));
+	printf("ProfileMe PCTR_CTL:\t%016llx VAL %d TAK %d Stalled %d Killed %d",
+	       ctl, (int)PCTR_CTL_VAL(ctl), (int)PCTR_CTL_TAK(ctl),
+	       (int)PCTR_CTL_STALLED(ctl), (int)PCTR_CTL_KILLED(ctl));
+	printf(" SL0 %d SL1 %d PCTR0 %d PCTR1 %d (%s)\n",
+	       (int)PCTR_CTL_SL0(ctl), (int)PCTR_CTL_SL1(ctl),
+	       (int)PCTR_CTL_PCTR0(ctl), (int)PCTR_CTL_PCTR1(ctl),
+	       pctr1_names[PCTR_CTL_SL1(ctl)]);
+}
diff --git a/tools/perf/util/sample-raw.c b/tools/perf/util/sample-raw.c
index f5ae9f468983..f765429a481d 100644
--- a/tools/perf/util/sample-raw.c
+++ b/tools/perf/util/sample-raw.c
@@ -19,6 +19,8 @@ void evlist__init_trace_event_sample_raw(struct evlist *evlist, struct perf_env
 
 	if (e_machine == EM_S390) {
 		evlist__set_trace_event_sample_raw(evlist, evlist__s390_sample_raw);
+	} else if (e_machine == EM_ALPHA) {
+		evlist__set_trace_event_sample_raw(evlist, evlist__alpha_sample_raw);
 	} else if (e_machine == EM_X86_64 || e_machine == EM_386) {
 		const char *cpuid = perf_env__cpuid(env);
 
diff --git a/tools/perf/util/sample-raw.h b/tools/perf/util/sample-raw.h
index c8d38c841c8c..8df0bd3d02aa 100644
--- a/tools/perf/util/sample-raw.h
+++ b/tools/perf/util/sample-raw.h
@@ -14,6 +14,8 @@ void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event,
 bool evlist__has_amd_ibs(struct evlist *evlist);
 void evlist__amd_sample_raw(struct evlist *evlist, union perf_event *event,
 			    struct perf_sample *sample);
+void evlist__alpha_sample_raw(struct evlist *evlist, union perf_event *event,
+			      struct perf_sample *sample);
 void evlist__init_trace_event_sample_raw(struct evlist *evlist, struct perf_env *env);
 
 #endif /* __SAMPLE_RAW_H */

-- 
2.55.0

