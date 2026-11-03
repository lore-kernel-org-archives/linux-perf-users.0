Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672353;
	b=b538USt+GcKZAgfdGXyo8g5/8cyvs/LfKFU92e4SnNqxjZl3Es9KPGwXdADKVIzS9kSJ
	 E89Y9mEt5M3f7HRZi+Bt1W/FE5sw7aRwdUquYhsbBtTXZ+neg+T3PUO+Ll6nL/tk2pFWn
	 g0K/ysstis+nJom+noX6dSbZgSdTXqoTfvxVvuqXTNjb1MssmXZ7rdxQ2P6rF/DfY0Dmg
	 Yw0c4VIPlGYbC7aA65Y3iQFAMjuqIOnSJx/HXdzsmWWksl5MCIT71XNqwDXZhIRtJOgtR
	 jRVjQIzV1QdARqc32CuI874drzMb+C9lrPhUeHLUWI1N0pAwnMKX5nyh8rrB/OntzXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672353;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Ieb1Wuoqk1M0uQhH5oMrUB8Fx3AFSLm3Ma4CMZW0nno=;
	b=fstU9j8IoG3LqF7Y047fuU+U5+XyYydAxVDBR2DqYHTiqOFNveIYKRTAHrKKzHT8qzda
	 x+qcVVhlyeAP8S9eJtFcn2hriaBRK9YUOr7NjajphsxrVvtu4Vqst50w0wdbbQ9ISi86A
	 LBXZbkyXOa4Hh9pjB+YQHgaE5jny3X36D9mpTe4AkvFMTO7GxIbMbOJ1KOv6urnyDU8tA
	 zT4LhRYJ2PalETV5ECj2lZ7yO9adyX/YaoC3Wyno2uAZqryOi4dBFHI+dEI3Qu+xtxNy0
	 MIZY5hWIErWJlFzAqeLtxlB8wwIS7YAwPnYzAmx9XkP69T+f0+iKt+YQ3pkaQ1gdxkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="j6Hto/id";
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BA9606A333
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 02:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95BA9606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j6Hto/id
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b0d63f60bcso29827397b3.3
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 18:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793672351; x=1794277151; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ieb1Wuoqk1M0uQhH5oMrUB8Fx3AFSLm3Ma4CMZW0nno=;
        b=j6Hto/ida5XRbaRW5hIrlK5gemlSt704KPKrBzkUd+nYVFEyT537d/xAVbRYVXW8Nl
         6RXo16f+Tz17kEPTYP1ISDfdQj2PpppkSZgDiGgvHdYZaU4yytEQrMZVezJEvLcYBVus
         /1/uIJDLIkcNNmdUe3t0/sn9q1yXmtbImFH9mx0dYI6Rl/UY05/EG0JwIlbuvZe1+0bj
         7oTOnBq5rERYx+tVabmPbFKhE0BnO0SiVGH34SN9Vl+wT36WMBbcPAWYDAVmR4QrxW/L
         05cSgkmHcePRcxyMHwlWnkr3MFrEGb+LP0Zxowvnq/kUgjoUJB0YFH7JNCotoN2CCkwW
         BNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793672351; x=1794277151;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ieb1Wuoqk1M0uQhH5oMrUB8Fx3AFSLm3Ma4CMZW0nno=;
        b=ET2EWLC9JbqVPi585gxUCuWaDPXmWaQB0bC4v3C3gN2NEm3Mnyn8zMQX0DfqNaTNK2
         8ogiX6iSfGHj3QFGjEicacCHyoBWj6GN7cNP+oai+VKcO/YQ/PD8Ffl8a8sjHE7hhL7L
         TT5nxhHTWw3zFxH9fatIrVoi8711xYCPXITAcXkpeAi94xEZeak1TqZdjqK/vg/B5vRo
         e7Q7e9Qdy7lsO7OBioqpZ0A+IUdJ2BEwoKJaMj8GIEEDW8Pw70Z3C++APQzwHZWQDzMb
         x1PbnTXaFM/VymEN406h3vAUdOZzWqTpG/Bd0viUywMc9aWwgX9WbU0IZO+5XLxlW3v0
         NJlg==
X-Forwarded-Encrypted: i=1; AKwUvBz0a4niA4AFwdYc5dQZCssnJhRZkN0YLpJUese8TV74t1QgXFYV6uTC3Ys71R8jNvtbf53PulxfOszyPcG/JE0c@vger.kernel.org
X-Gm-Message-State: APuU4Z8v8GPpz1AvyCa5/CgJ1IsBb/Wf6Exvf9LZpVAOSkslpUf85pQH
	nq4M/vDLgwBLjWF51KpAo97JAHMujXOQssIkX3aTZM1v8IawU8qZsfe0
X-Gm-Gg: AYBFou2Hk9n34svCgDY6sB5SjRGZ8ANe+sQ0KeXIxwE1eJehnaT72Y2T3XErWvAdIF0
	96Wyz/OwK2n3HWqzckAFOB5o7W37+F1KOA3w20Mm4FZcUp+t9ewGVAppNmGKKo/c/r3jpxYxqpn
	65GkIMYBQ9k/tbe/7tzvBh1kuoGwYoEi9Ci4zRdNhSIe5SCOjiOqhzwjDpOxuSis9TDnyOAxf1x
	uHBOZ1pr545hDZGf8VVwyxd8tsuY9sj/RSLgVRLRj911uZLlG5kkc7YdLbYac/56Ev0HkybgF38
	XD7DN1btPJn5kwwRoxOfUlV0PLUZ14wJkSjU9QokTJ+ulqq+BVbidq0RbLdhelsHZRcEwBi2zw4
	/cMseD1sFey204cnzrpF6hdhiNAsknzNuFMBekwbFEiNBE4Cy3j1at5/1uyVBE0tt1IrWvnw+vu
	SYuoysb5G5aE36lRBcT9td78Jd+0ftZy3I3kcqp8Ldabok2LLzLH3VmrbPaz8iz4pxouYMNbHcJ
	pmrkfwTc2Ss4XJ3jTPAbabYaT2NQeBVYm0PCKMIzRBhUAr6ih66kLTQeQqx5t4mEWv0FBm510n9
	A95+RYrsWGlfKcJBNaMNUpZikDdpQjWB/BigO/+ww7+FONhL1lgmlQ5QNT5jkPQf0lnHJukGnkm
	T7rnr1QaZ9g==
X-Received: by 2002:a05:690c:83:b0:8b0:881d:aadb with SMTP id 00721157ae682-8b2b671b917mr90113227b3.32.1793672351464;
        Mon, 02 Nov 2026 18:19:11 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b71240a4sm63029937b3.7.2026.11.02.18.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:19:10 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 02 Nov 2026 21:19:08 -0500
Subject: [PATCH v3 1/2] perf alpha: Decode ProfileMe raw samples
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
Message-Id: <20261102-perf-alpha-profileme-v3-1-4bf6e1dda733@gmail.com>
References: <20261102-perf-alpha-profileme-v3-0-4bf6e1dda733@gmail.com>
In-Reply-To: <20261102-perf-alpha-profileme-v3-0-4bf6e1dda733@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9921; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=7lcubxbmB7ufGAmyO6K8gbaB2Adi+GhCZaQDaJGyq6Q=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLJeusxxn6FQ/XHhorlRKdL5XbkV0ZryHd0vlin1fvJ7+
 TRx2aNrHR9ZGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHNN6k1GhoUOUt8L90
 tfnXm6eW9me7DXGZYOmcTLjS+YP7/8zX3g2UmG/25ZtWpPdxz5nFE+J4Gb91thZcDiw/EFe184O
 8sUvjR9zwwA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

The Alpha cpu PMU attaches struct alpha_profileme_sample to each
ProfileMe sample as PERF_SAMPLE_RAW data: the profiled instruction's
PMPC along with the I_STAT and PCTR_CTL status that says what happened
to it.

Decode it in perf report -D and perf script -D the way AMD IBS raw data
is decoded, naming the trap from TRAP_TYPE when TRP is set and from the
PALcode entry offset in PMPC for redirect traps, which TRAP_TYPE does
not report. The payload is copied out of the sample and converted from
little endian, so that it decodes on strict-alignment and big-endian
hosts too.

Copy the uapi header that defines the struct into tools/arch and add it
to check-headers.sh.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
---
 tools/arch/alpha/include/uapi/asm/perf_event.h |  31 +++++
 tools/perf/check-headers.sh                    |   1 +
 tools/perf/util/Build                          |   1 +
 tools/perf/util/alpha-sample-raw.c             | 150 +++++++++++++++++++++++++
 tools/perf/util/sample-raw.c                   |   2 +
 tools/perf/util/sample-raw.h                   |   2 +
 6 files changed, 187 insertions(+)

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
index 000000000000..e8751224748f
--- /dev/null
+++ b/tools/perf/util/alpha-sample-raw.c
@@ -0,0 +1,150 @@
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
+static const char *trap_name(__u64 i_stat, __u64 pmpc)
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
+	if (!I_STAT_TRP(i_stat) || I_STAT_MIS(i_stat))
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
+	       trap_name(i_stat, pmpc),
+	       I_STAT_TRP(i_stat) && I_STAT_MIS(i_stat) ? " mispredicted" : "");
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

