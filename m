Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795755791;
	b=W1+AVoyHLsOL4F0KK+NNgbvSpC6NbbnpTNpIhut07p4DdaLO/DBk3QRH98BuqrbfZ6DD
	 w8Z007YkYieIkknqp91w4w+XPmUM7LFf7Y9jw5XtN2ioOzv2sXXdVf331mS3W5Zr15qZ+
	 LSz5qeOb+7kNubbcOxvSH1m69oS9P8LrWBY2I+FHzksw15dE4EHf7yx7fPPYls1kCfSSW
	 9N9sIij/7zEHOb+9S09H0KhCYtzmU4k1mJwXv1VjDeNPIzXIlqBaQ0dZ+VBWYAoEFk7b9
	 ETFyF3UCAsRvtmbxz/vaKohkPHv+xhTymYWV4RCmIYy9m+UA+EPpQYYGjyC3ByKa6NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795755791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=NU6B5ejr1ZtQh+3o0BJNPa3k/4FRNqGMZ46W+lKcYxw=;
	b=IP22U2KCnMWN1Hku/MVHtGiuqmQNYKITDq44pMD+tmyDN9hjmeQdQPaYaAoksvk/l1qn
	 91hOzOhcIH/S6evzIqzZINRGCygAhNgO1oOilz2/g02TjA0JWgJXp5U7tGghOs9IILxWV
	 qb9bx1dLKO3Zut76ITf9aya+pOQ/uE9Hx46kYGQY24thbboYYaiDRRmNgAW7ig5d0IVXf
	 4VMsa+bRwm/MWVoYulyALkilU65XNsI1Fjgh3cg40Vg1rKCw30rmsbzbY3188oiejp8vq
	 XjMBEvnfTnE0OyCwVRz3oPQ4/chzx86eezpuc1haQ5oRkU2v0C5plqxSc0VpAoPcakg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BwwOuJy6;
	arc=none smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D53606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 05:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98D53606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BwwOuJy6
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b2d14968c9so72719467b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 21:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795755789; x=1796360589; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NU6B5ejr1ZtQh+3o0BJNPa3k/4FRNqGMZ46W+lKcYxw=;
        b=BwwOuJy6uvc4IAzuXBsOaWxx/pasVbTFmA4pe3OGuXfBZkuGTnl8b6aa2UDBnT0Cjp
         g9Ta7yuATsT5Rqk2wQTwWjQaDKs2UsusPEcYsz9yyp5/ur90QT7AClsD/uAYMFY3LY56
         GLO6j1G3DmjzG6mlbRJPidoqp3cJ5D+jqE9kEmVeIc7BJ8ayNlVwrGA0rYz1lXiP23mq
         2czfJjjDqeHQXf2wTpuXkfkViiZebIQFw07yAgT/FogZ6bOwrR62uMlwoNw7R5hUTOni
         IFmO17FAosOJC8+yNJz1x7YWCo2mkGnASlVe39T6+guj2EDDDgfijovUq6glqlKo+2Ia
         gePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795755789; x=1796360589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NU6B5ejr1ZtQh+3o0BJNPa3k/4FRNqGMZ46W+lKcYxw=;
        b=u0IYaBBmiYxE3UMBRwFfFtivja77BqSh4rgiDJnKfXGeL5lciI/TCZNO/Iw3nYL60/
         T5R0om63KjonYLwWZzXaoy+ainyLQJRBLkBnsj4ES915EF7oXTXCiLsE4gxQvjmbCOa+
         xf0VEiRn1K4LBpfWB2v6L/vs3PG8wmyuhW885Id/qtvIkJBoK3FkvkidPjO+PqHoZXgn
         Sx2c7wnMSnxQY7MzzuqA4teuBCZcnZQCMO81p+yV3DJJTx/4EjdgZafJnT3XQy3RsMZM
         QEKSs4PJg6lY/mBdei8A/vHje+7EI7O+/RJMjx2UMzq+tNG6cRiOOTLXIglrdyflLX5y
         qHtA==
X-Forwarded-Encrypted: i=1; AL+hErGx3zVy6vxF0esibpJkFuPnvRNGYGyLZD0YrXan4dU9LsF/a+rDPExxz2KE3xp4P97NQPVyG9Ipaw/fORZNDtc8@vger.kernel.org
X-Gm-Message-State: APuU4Z+kJ+wDhPJOS+Mbo4Esgypwz2oUb0AEz1HI5KqRSimqLevD+Stq
	oEjRgriGGfmDNh3cpIy/xtvrMmFLKCVIv8VkTpxZ4RizyLrwJDRVajSl5SHGOrVpa6A=
X-Gm-Gg: AZFdTZfsndlTuGDZlO/7FlF2hpIRhMEjQJXQqE02vzQgJl2YIWPvfd1EafVjYRhYuPT
	UJpqnJG/QUgE0ukE8PFDX8XCfrtPZy1WkRlpVVEe0uKBmL+eCzhG5nH/9SGk4zzVCUQWaIGxwcM
	rPA5nkWnrBJzK0YCbMQoibe8yyRdYKq3yn95+VVPRBKGoAGafZNqnlLG2yMd9fJh2Fi+zpAd/t6
	Lm+m2gGYGsNRijsoQCbESrcUtYVktcpbAjyb+h2apXrr0OQPo6Ht9QK0LFOBm7AW/NC01+VQx1g
	7xNfO0Y3LXYqF6F+CCxnHHw66lip2RxMfI84Z9Z8YktfNNkDmreMhq4CW+1+xTcOFfVz01+1ftT
	gL3ovYHDSjjedFOfXHzXVIHdc+MiAgqYv7WGii0iFC/J3CgCNzhe6Jjvi5HF1kn0rEfL3aooBfP
	AP+aXhYdZgyi5S1FEwMfQuWKO71FFzDEnDE+2EQX1yn94EFDyhxRcqu6O9j87GOULJHUJbsHBPA
	RwYfasFwYlyGGOnJmnS8UC5vFLAsX/AQsSsYwlQYxKrMsLDYM39fKQ2frTJ/rC1TbeQ1rYTfkmj
	Akxxmc3jlpYEJ8Vt5YWHdP2+3q3bvCHzQl8CLeoRv54zBauF/lE9ju1RNVFciTibJXvkSilVoX4
	1L/hQQbiax6Qp/hdPH3r1kG6DmuFgm/F2h/fWu5NyDA==
X-Received: by 2002:a05:690c:29a:b0:8b3:6d4e:3f60 with SMTP id 00721157ae682-8b520507308mr72678507b3.61.1795755789170;
        Thu, 26 Nov 2026 21:03:09 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202bf474sm91726777b3.21.2026.11.26.21.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 21:03:07 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 27 Nov 2026 00:02:57 -0500
Subject: [PATCH 4/7] parisc: perf: program the PA-8800/PA-8900 counters
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
Message-Id: <20261127-parisc-perf-pa8800-v1-4-4f3f077010ce@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=22659; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=ho5U7UtcjoP7GTaZ9QRFbMYgF5tvHpalaQa46i2sQUk=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLI5+f6fz8u0TFSyriuQ2pEXdjtAV3bB00POXD7HhVSqf
 1XtX6Ha8ZGFQYyLYaaYIkvcekWWWW07lvqclv4FM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 Ahk6RvEQOT0Gjczi4tLUIt20giKHvPySxJLM/LxivfyC1LyC9AK9tMy0koyM/KLiVKARenmpJaa
 ujm5GhgYmlo4WZk4WjqYmzs5Ohk5ujo7Ork5GluYmBs6WjiauluYMXJwCMNds3s7IcKhosiNPmX
 VtWP8T5WrP6+XrdyjzsyzceYV71RX7V9tNpjEyXOiq8zb3eLanWJ7/WtqJZtXPOhEBlpWrFHsmn
 toaO+EpPwA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

On PA-8800 and PA-8900 (Mako) /dev/perf uses the PCX-W2 bitmasks and the
PCX-W images, which do not match Mako's RDRs, and reads the counters from
chain 0 RDR15, which does not exist there. PA_PERF_OFF fails and writing
an image shifts the wrong number of bits into the wrong RDRs.

Add a separate Mako path that loads the first built-in image of the C8000
PDC 2.13 firmware, in the order and with the masks the firmware's
PDC_INTRIGUE implementation uses. Masked RDRs are merged with their
current contents, so the RDRs that hold live state are kept.

The image is changed in RDR16_1 so that every core counts TLB misses on
ctr0, cycles on ctr1 and ctr3, and instructions retired on ctr2. The
firmware's image enables only ctr0 and ctr1 of the first core.

RDR15_1 holds the counters of both cores of a processor, four each in
32-bit words, and reading it shifts it out. Read it and write it back,
clearing only the half of the running core (DR2 bit 54), so that loading
on one core does not reset the other one.

pmenb before an image has been loaded takes an HPMC, so PA_PERF_ON loads
the image the first time it is used on a CPU and only runs pmenb after
that.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/parisc/kernel/Makefile          |   4 +-
 arch/parisc/kernel/perf.c            |  33 +++--
 arch/parisc/kernel/perf_mako.c       | 260 +++++++++++++++++++++++++++++++++++
 arch/parisc/kernel/perf_mako.h       |  20 +++
 arch/parisc/kernel/perf_mako_image.h | 208 ++++++++++++++++++++++++++++
 5 files changed, 512 insertions(+), 13 deletions(-)

diff --git a/arch/parisc/kernel/Makefile b/arch/parisc/kernel/Makefile
index 49f937c2abbe..90140593be54 100644
--- a/arch/parisc/kernel/Makefile
+++ b/arch/parisc/kernel/Makefile
@@ -32,8 +32,8 @@ obj-$(CONFIG_64BIT)	+= sys_parisc32.o signal32.o
 obj-$(CONFIG_STACKTRACE)+= stacktrace.o
 obj-$(CONFIG_AUDIT)	+= audit.o
 obj64-$(CONFIG_AUDIT)	+= compat_audit.o
-# only supported for PCX-W/U in 64-bit mode at the moment
-obj-$(CONFIG_64BIT)	+= perf.o perf_asm.o $(obj64-y)
+# only supported in 64-bit mode at the moment
+obj-$(CONFIG_64BIT)	+= perf.o perf_mako.o perf_asm.o $(obj64-y)
 obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY)	+= topology.o
 obj-$(CONFIG_FUNCTION_TRACER)		+= ftrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o
diff --git a/arch/parisc/kernel/perf.c b/arch/parisc/kernel/perf.c
index 2494f16bb8fd..0b9619d18766 100644
--- a/arch/parisc/kernel/perf.c
+++ b/arch/parisc/kernel/perf.c
@@ -43,6 +43,7 @@
 #include <asm/io.h>		/* for __raw_read() */
 
 #include "perf_images.h"
+#include "perf_mako.h"
 
 #define MAX_RDR_WORDS	24
 #define PERF_VERSION	2	/* derived from hpux's PI v2 interface */
@@ -56,6 +57,7 @@ struct rdr_tbl_ent {
 
 static int perf_processor_interface __read_mostly = UNKNOWN_INTF;
 static int perf_enabled __read_mostly;
+static bool perf_mako __ro_after_init;
 static DEFINE_SPINLOCK(perf_lock);
 static struct parisc_device *cpu_device __read_mostly;
 
@@ -140,7 +142,7 @@ static const struct rdr_tbl_ent perf_rdr_tbl_W[] = {
 };
 
 /*
- * RDR register descriptions for PCX-W2 (PA-8700). RDR11, RDR12, RDR13,
+ * RDR register descriptions for PCX-W2 (PA-8700).  RDR11, RDR12, RDR13,
  * RDR22, RDR23, RDR27 and RDR30 differ from PCX-W.
  */
 static const struct rdr_tbl_ent perf_rdr_tbl_piranha[] = {
@@ -213,7 +215,7 @@ static const uint64_t perf_bitmasks_piranha[] = {
 };
 
 static const uint64_t *bitmask_array;   /* array of bitmasks to use */
-static const struct rdr_tbl_ent *perf_rdr_tbl_cuda __ro_after_init;
+static const struct rdr_tbl_ent *perf_rdr_tbl_cuda __read_mostly;
 
 /******************************************************************************
  * Function Prototypes
@@ -333,6 +335,12 @@ static ssize_t perf_write(struct file *file, const char __user *buf,
 	uint32_t interface_type;
 	uint32_t test;
 
+	if (!perfmon_capable())
+		return -EACCES;
+
+	if (perf_mako)
+		return perf_mako_write(buf, count);
+
 	if (perf_processor_interface == ONYX_INTF)
 		image_size = PCXU_IMAGE_SIZE;
 	else if (perf_processor_interface == CUDA_INTF)
@@ -340,9 +348,6 @@ static ssize_t perf_write(struct file *file, const char __user *buf,
 	else
 		return -EFAULT;
 
-	if (!perfmon_capable())
-		return -EACCES;
-
 	if (count != sizeof(uint32_t))
 		return -EIO;
 
@@ -474,11 +479,17 @@ static long perf_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 	    case PA_PERF_ON:
 			/* Start the counters */
-			perf_start_counters();
+			if (perf_mako)
+				error = perf_mako_start();
+			else
+				perf_start_counters();
 			break;
 
 	    case PA_PERF_OFF:
-			error_start = perf_stop_counters(raddr);
+			if (perf_mako)
+				error_start = perf_mako_stop(raddr);
+			else
+				error_start = perf_stop_counters(raddr);
 			if (error_start != 0) {
 				printk(KERN_ERR "perf_off: perf_stop_counters = %ld\n", error_start);
 				error = -EFAULT;
@@ -540,12 +551,12 @@ static int __init perf_init(void)
 		 boot_cpu_data.cpu_type == mako2) {
 		perf_processor_interface = CUDA_INTF;
 		perf_rdr_tbl_cuda = perf_rdr_tbl_W;
-		if (boot_cpu_data.cpu_type == pcxw2)
+		if (boot_cpu_data.cpu_type == pcxw2) {
 			perf_rdr_tbl_cuda = perf_rdr_tbl_piranha;
-		if (boot_cpu_data.cpu_type == pcxw2 ||
-		    boot_cpu_data.cpu_type == mako ||
-		    boot_cpu_data.cpu_type == mako2)
 			bitmask_array = perf_bitmasks_piranha;
+		}
+		perf_mako = boot_cpu_data.cpu_type == mako ||
+			    boot_cpu_data.cpu_type == mako2;
 	} else {
 		perf_processor_interface = UNKNOWN_INTF;
 		printk("Performance monitoring counters not supported on this processor\n");
diff --git a/arch/parisc/kernel/perf_mako.c b/arch/parisc/kernel/perf_mako.c
new file mode 100644
index 000000000000..e717ac0c97c8
--- /dev/null
+++ b/arch/parisc/kernel/perf_mako.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * PA-8800/PA-8900 (Mako) performance counters
+ *
+ * Each core has four counters in RDR15 of RDR chain 1, which the two cores
+ * of a processor share: the first four 32-bit words belong to the core
+ * with DR2 bit 54 clear. A counter is 31 bits wide; bit 31 is set when it
+ * wraps and stays set. Before shifting chain 1, a core requests it by setting
+ * DR2 bit 48 and waits for the grant in DR2 bit 53. Writes to both chains
+ * are bracketed by setting and clearing bit 56 of RDR9 on chain 1. The
+ * order and the image are those of the C8000 PDC 2.13 firmware's
+ * PDC_INTRIGUE implementation.
+ *
+ * pmenb before an image has been written takes an HPMC, so the counters
+ * are only started on a CPU once the image has been loaded there.
+ */
+
+#include <linux/bug.h>
+#include <linux/errno.h>
+#include <linux/iopoll.h>
+#include <linux/irqflags.h>
+#include <linux/kernel.h>
+#include <linux/percpu.h>
+#include <linux/uaccess.h>
+#include <asm/perf.h>
+#include <asm/special_insns.h>
+
+#include "perf_mako.h"
+#include "perf_mako_image.h"
+
+#define MAKO_RDR(rdr, chain)	((rdr) | (chain) << 5)
+#define MAKO_DR2_CHAIN1_REQ	(1UL << 48)
+#define MAKO_DR2_CHAIN1_GRANT	(1UL << 53)
+#define MAKO_DR2_CORE		(1UL << 54)
+#define MAKO_RDR9_1_CONFIG	(1ULL << 56)
+#define MAKO_CCR_PERF		0x20
+
+static DEFINE_PER_CPU(bool, perf_mako_loaded);
+
+/* The second core of a processor, which owns the second half of RDR15_1. */
+static bool perf_mako_core_b(void)
+{
+	return perf_get_dr2() & MAKO_DR2_CORE;
+}
+
+/*
+ * The other core holds chain 1 only while it loads or reads its counters,
+ * with interrupts off.
+ */
+static int perf_mako_chain1_get(void)
+{
+	unsigned long dr2;
+	int ret;
+
+	perf_set_dr2(perf_get_dr2() | MAKO_DR2_CHAIN1_REQ);
+	ret = read_poll_timeout_atomic(perf_get_dr2, dr2,
+				       dr2 & MAKO_DR2_CHAIN1_GRANT, 1,
+				       USEC_PER_MSEC, false);
+	if (ret)
+		perf_set_dr2(perf_get_dr2() & ~MAKO_DR2_CHAIN1_REQ);
+
+	return ret;
+}
+
+static void perf_mako_chain1_put(void)
+{
+	perf_set_dr2(perf_get_dr2() & ~MAKO_DR2_CHAIN1_REQ);
+}
+
+/* The last doubleword is shifted first, for both reads and writes. */
+static void perf_mako_rdr_read_buf(unsigned int index, uint64_t *buf,
+				   unsigned int n)
+{
+	while (n--)
+		buf[n] = perf_mako_rdr_read(index);
+}
+
+static void perf_mako_rdr_write_buf(unsigned int index, const uint64_t *buf,
+				    unsigned int n)
+{
+	while (n--)
+		perf_mako_rdr_write(index, buf[n]);
+}
+
+/*
+ * Write one RDR of the image. Where the image has a mask, merge it with
+ * the current contents the way the firmware does, new = (image & ~mask) |
+ * (current & mask). A read returns the RDR's bits right-justified in
+ * num_words doublewords, while the image and the mask are left-justified,
+ * so the read is shifted left by the unused bits.
+ */
+static void perf_mako_rdr_merge(const struct perf_mako_rdr *r,
+				const uint64_t *data)
+{
+	unsigned int idx = MAKO_RDR(r->rdr, r->chain), n = r->num_words, s, j;
+	uint64_t buf[4];
+
+	if (!r->mask || WARN_ON_ONCE(n > ARRAY_SIZE(buf))) {
+		perf_mako_rdr_write_buf(idx, data, n);
+		return;
+	}
+
+	s = r->width % 64 ? 64 - r->width % 64 : 0;
+	perf_mako_rdr_read_buf(idx, buf, n);
+	for (j = 0; s && j < n; j++)
+		buf[j] = buf[j] << s | (j + 1 < n ? buf[j + 1] >> (64 - s) : 0);
+	for (j = 0; j < n; j++)
+		buf[j] = (data[j] & ~r->mask[j]) | (buf[j] & r->mask[j]);
+	perf_mako_rdr_write_buf(idx, buf, n);
+}
+
+static void perf_mako_config_bit(bool on)
+{
+	uint64_t val = perf_mako_rdr_read(MAKO_RDR(9, 1));
+
+	if (on)
+		val |= MAKO_RDR9_1_CONFIG;
+	else
+		val &= ~MAKO_RDR9_1_CONFIG;
+	perf_mako_rdr_write(MAKO_RDR(9, 1), val);
+}
+
+/*
+ * Read RDR15_1, optionally clearing this core's counters, and write it
+ * back. Reads shift the RDR out, and the other core's counters must be
+ * kept.
+ */
+static void perf_mako_ctrs_rw(uint64_t *buf, bool clear)
+{
+	perf_mako_rdr_read_buf(MAKO_RDR(15, 1), buf, 4);
+	if (clear) {
+		unsigned int h = perf_mako_core_b() ? 2 : 0;
+
+		buf[h] = 0;
+		buf[h + 1] = 0;
+	}
+	perf_mako_rdr_write_buf(MAKO_RDR(15, 1), buf, 4);
+}
+
+/*
+ * Write the image and start the counters on this CPU, from zero. Called
+ * with interrupts off. Like the firmware's boot-time load, this holds
+ * chain 1 across the image write and pmenb.
+ */
+static int perf_mako_load(void)
+{
+	unsigned long ccr = mfctl(10);
+	uint64_t ctrs[4];
+	int i, ret;
+
+	mtctl(ccr | MAKO_CCR_PERF, 10);
+	ret = perf_mako_chain1_get();
+	if (ret)
+		goto out;
+
+	perf_mako_config_bit(true);
+	for (i = 0; i < ARRAY_SIZE(perf_mako_image); i++) {
+		const struct perf_mako_rdr *r = &perf_mako_image[i];
+
+		/*
+		 * The firmware presets the first counter to 0x7fffffec.
+		 * Start this core's counters from zero instead, and keep
+		 * the other core's.
+		 */
+		if (r->chain == 1 && r->rdr == 15)
+			perf_mako_ctrs_rw(ctrs, true);
+		else
+			perf_mako_rdr_merge(r, r->data);
+	}
+	perf_mako_config_bit(false);
+
+	asm volatile("pmenb" ::: "memory");
+	perf_mako_chain1_put();
+	this_cpu_write(perf_mako_loaded, true);
+out:
+	mtctl(ccr, 10);
+	return ret;
+}
+
+/* Read this CPU's four counters. Called with interrupts off. */
+static int perf_mako_read(uint32_t *c)
+{
+	unsigned long ccr = mfctl(10);
+	uint64_t buf[4];
+	int i, w, ret;
+
+	mtctl(ccr | MAKO_CCR_PERF, 10);
+	ret = perf_mako_chain1_get();
+	if (ret)
+		goto out;
+
+	perf_mako_config_bit(true);
+	perf_mako_ctrs_rw(buf, false);
+	perf_mako_config_bit(false);
+	perf_mako_chain1_put();
+
+	w = perf_mako_core_b() ? 4 : 0;
+	for (i = 0; i < 4; i++, w++)
+		c[i] = buf[w / 2] >> (w % 2 ? 0 : 32);
+out:
+	mtctl(ccr, 10);
+	return ret;
+}
+
+int perf_mako_start(void)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	local_irq_save(flags);
+	if (this_cpu_read(perf_mako_loaded))
+		perf_intrigue_enable_perf_counters();
+	else
+		ret = perf_mako_load();
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+int perf_mako_stop(uint32_t *raddr)
+{
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	local_irq_save(flags);
+	if (this_cpu_read(perf_mako_loaded)) {
+		perf_intrigue_disable_perf_counters();
+		ret = perf_mako_read(raddr);
+	}
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+/*
+ * The only image is (CUDA_INTF << 16) | 0: ctr0 counts TLB misses, ctr1
+ * and ctr3 cycles, and ctr2 instructions retired. Writing it loads the
+ * image on this CPU and restarts its counters from zero.
+ */
+ssize_t perf_mako_write(const char __user *buf, size_t count)
+{
+	unsigned long flags;
+	uint32_t image;
+	int ret;
+
+	if (count != sizeof(image))
+		return -EIO;
+	if (copy_from_user(&image, buf, sizeof(image)))
+		return -EFAULT;
+	if (image != CUDA_INTF << 16)
+		return -EINVAL;
+
+	local_irq_save(flags);
+	if (this_cpu_read(perf_mako_loaded))
+		perf_intrigue_disable_perf_counters();
+	ret = perf_mako_load();
+	local_irq_restore(flags);
+
+	return ret ? ret : count;
+}
diff --git a/arch/parisc/kernel/perf_mako.h b/arch/parisc/kernel/perf_mako.h
new file mode 100644
index 000000000000..88ca6cef988f
--- /dev/null
+++ b/arch/parisc/kernel/perf_mako.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef PERF_MAKO_H
+#define PERF_MAKO_H
+
+#include <linux/types.h>
+
+/* perf_asm.S */
+unsigned long perf_get_dr2(void);
+void perf_set_dr2(unsigned long dr2);
+uint64_t perf_mako_rdr_read(unsigned long index);
+void perf_mako_rdr_write(unsigned long index, uint64_t value);
+void perf_intrigue_enable_perf_counters(void);
+void perf_intrigue_disable_perf_counters(void);
+
+/* perf_mako.c, for /dev/perf */
+ssize_t perf_mako_write(const char __user *buf, size_t count);
+int perf_mako_start(void);
+int perf_mako_stop(uint32_t *raddr);
+
+#endif
diff --git a/arch/parisc/kernel/perf_mako_image.h b/arch/parisc/kernel/perf_mako_image.h
new file mode 100644
index 000000000000..099df7e42e0d
--- /dev/null
+++ b/arch/parisc/kernel/perf_mako_image.h
@@ -0,0 +1,208 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef PERF_MAKO_IMAGE_H
+#define PERF_MAKO_IMAGE_H
+
+/*
+ * PA-8800/PA-8900 (Mako) image: the RDRs to write, in order, each with its
+ * chain and data. data[0] is the most significant doubleword and is shifted
+ * in last. This is the first built-in image of the C8000 PDC 2.13 firmware
+ * (0x29c920 in the PDC0213 image), which the firmware's PDC_INTRIGUE calls
+ * also load. RDR15 on chain 1 holds the counters.
+ */
+struct perf_mako_rdr {
+	uint8_t		rdr;
+	uint8_t		chain;
+	uint8_t		num_words;
+	uint16_t	width;
+	const uint64_t	*data;
+	const uint64_t	*mask;
+};
+
+#define PERF_MAKO_RDR(r, c, d) \
+	{ .rdr = (r), .chain = (c), .num_words = ARRAY_SIZE(d), .data = (d) }
+#define PERF_MAKO_RDR_MASK(r, c, w, d, m) \
+	{ .rdr = (r), .chain = (c), .num_words = ARRAY_SIZE(d), .width = (w), \
+	  .data = (d), .mask = (m) }
+
+static const uint64_t perf_mako_rdr0_0[] = {
+	0x4001800000000000ULL,
+};
+static const uint64_t perf_mako_rdr1_0[] = {
+	0x0000000000000000ULL,
+};
+static const uint64_t perf_mako_rdr4_0[] = {
+	0x0000001000001fffULL, 0x0010007ffc000001ULL, 0xffffffffffffffffULL,
+	0xffffffff0007ffffULL, 0xffd607ffff846007ULL, 0xffffa00000000000ULL,
+};
+static const uint64_t perf_mako_rdr5_0[] = {
+	0xc0ffffffffffffffULL, 0xffffffffffffffffULL, 0xffffffffffffffffULL,
+	0xffffffffffff0000ULL,
+};
+static const uint64_t perf_mako_rdr17_0[] = {
+	0xc000000000000000ULL,
+};
+static const uint64_t perf_mako_rdr18_0[] = {
+	0xc000000000000000ULL,
+};
+static const uint64_t perf_mako_rdr20_0[] = {
+	0x00ffffffff3fffffULL, 0xffffffffffcfffffULL, 0xfff7fbfc00000000ULL,
+};
+static const uint64_t perf_mako_rdr21_0[] = {
+	0x00ffffffff3fffffULL, 0xffffffffffcfffffULL, 0xfff7fbfc00000000ULL,
+};
+static const uint64_t perf_mako_rdr22_0[] = {
+	0xffffffffffffffffULL, 0xffffffffffffffffULL, 0xffffffffffffffffULL,
+	0xfffc000000000000ULL,
+};
+static const uint64_t perf_mako_rdr23_0[] = {
+	0xffffffffffffffffULL, 0xffffffffffffffffULL, 0xffffffffffffffffULL,
+	0xfffc000000000000ULL,
+};
+static const uint64_t perf_mako_rdr24_0[] = {
+	0xfffffffffffff9ffULL, 0xfe00000000000000ULL,
+};
+static const uint64_t perf_mako_rdr25_0[] = {
+	0xfffffffffffff9ffULL, 0xfe00000000000000ULL,
+};
+static const uint64_t perf_mako_rdr0_1[] = {
+	0x0000000000000000ULL,
+};
+static const uint64_t perf_mako_rdr1_1[] = {
+	0x0000000000000000ULL,
+};
+static const uint64_t perf_mako_rdr5_1[] = {
+	0x65ffffffffffffffULL, 0xf500000000000000ULL, 0xffffffffffffffffULL,
+	0x0000000000000000ULL,
+};
+static const uint64_t perf_mako_rdr6_1[] = {
+	0xfff6fff6ffff0c20ULL, 0x000000000000c200ULL, 0x00000000000ee000ULL,
+	0x0000000000ee0000ULL, 0x0000000000000000ULL,
+};
+static const uint64_t perf_mako_rdr9_1[] = {
+	0x0000000000000001ULL,
+};
+static const uint64_t perf_mako_rdr15_1[] = {
+	0x7fffffec00000000ULL, 0x0000000000000000ULL, 0x0000000000000000ULL,
+	0x0000000000000000ULL,
+};
+/*
+ * RDR16_1 selects what the counters count. The firmware's image enables
+ * only ctr0 and ctr1 of the first core. Bytes are numbered from the most
+ * significant byte of the first doubleword; changed from the firmware:
+ *
+ * - Byte 14 (event selects, bits 7..4 for the first core's ctr0..ctr3,
+ *   bits 3..0 for the second core's) = 0xaa: ctr0 counts the TLB miss
+ *   event, ctr2 the instructions retired event.
+ * - Byte 58 bits 1:0 = 3: count on the first core's ctr1.
+ * - Byte 59 = 0xfa: bits 7 and 5 enable the first core's ctr2 and ctr3,
+ *   bits 3 and 1 the second core's ctr0 and ctr1.
+ * - Byte 60 = 0xa0: bits 7 and 5 enable the second core's ctr2 and ctr3.
+ *
+ * Counters without an event selected count cycles, so on every CPU ctr0
+ * counts TLB misses, ctr1 and ctr3 cycles and ctr2 instructions retired.
+ */
+static const uint64_t perf_mako_rdr16_1[] = {
+	0x00020200a0000000ULL, 0x000aa4444110aa00ULL, 0x000000000009000fULL,
+	0xf000000000000000ULL, 0x0000000005a12000ULL, 0x0000000000000000ULL,
+	0x0000000500010555ULL, 0x100003faa0000000ULL, 0x00000ffff0fff000ULL,
+	0x0000000000000000ULL, 0x0005000f2f0f0f0fULL, 0x0f0f0f0f0f0f0f30ULL,
+	0xfaf0f08000000000ULL, 0x0000000000000000ULL, 0x900ff00000000000ULL,
+	0x000000000005a000ULL, 0x0000012000000000ULL, 0x0000000000000005ULL,
+	0x0015550400000100ULL, 0x00000000000fffffULL, 0xf0f0000000000000ULL,
+	0x0000050000000f0fULL, 0x0f2f0f0f0f0f0f0fULL, 0x0f0f30f0faf00800ULL,
+	0x0000000000000000ULL, 0x0000000090000ff0ULL, 0x0000005000050000ULL,
+	0x0000000000000000ULL, 0x0020000200000000ULL, 0x0500001000000000ULL,
+	0x0800040401000055ULL, 0x500c0000ff000000ULL, 0x0000ff0000aa00aaULL,
+	0x0000000000000000ULL, 0x00000000005af000ULL, 0x0b00555000040101ULL,
+	0x000000000000ffffULL, 0xfffff00000000000ULL, 0x0000000000000fffULL,
+	0xffffffffffffffffULL, 0xfffffffffffffff0ULL, 0x0000000000000000ULL,
+	0x0000000fffffffffULL, 0x0000000000000000ULL, 0x00000000ffffffffULL,
+	0xffffffffffffffffULL, 0xffffffffff000000ULL, 0x0000000000000000ULL,
+};
+static const uint64_t perf_mako_rdr20_1[] = {
+	0xfffffffffffff800ULL, 0x00000000003fffffULL, 0xfffffffe00000000ULL,
+	0x00000fffffffffffULL, 0xff80000000000003ULL, 0xffffffffffffe000ULL,
+	0x0000000000000000ULL,
+};
+static const uint64_t perf_mako_rdr24_1[] = {
+	0x0000000000000000ULL, 0x0000000000000000ULL,
+};
+
+/*
+ * The firmware does not store the image verbatim. It merges each RDR with
+ * the current contents, new = (image & ~mask) | (current & mask), using
+ * the mask table at 0x29ba90 in the PDC0213 image. A set mask bit keeps the
+ * current bit. RDR0, RDR1, RDR9 and RDR24 on chain 1 hold live state, and
+ * overwriting them hangs the machine or takes an HPMC. The masks below are
+ * the firmware's, clipped to the width of each RDR, and are given only for
+ * the RDRs where they keep a bit that exists. Those entries also give the
+ * width of the RDR in bits, which the merge needs to align what it reads.
+ */
+static const uint64_t perf_mako_mask0_0[] = {
+	0x0200000000000000ULL,
+};
+static const uint64_t perf_mako_mask1_0[] = {
+	0xffc0ffffffffffffULL,
+};
+static const uint64_t perf_mako_mask20_0[] = {
+	0xff00000000c00000ULL, 0x0000000000300000ULL, 0x0008040000000000ULL,
+};
+static const uint64_t perf_mako_mask21_0[] = {
+	0xff00000000c00000ULL, 0x0000000000300000ULL, 0x0008040000000000ULL,
+};
+static const uint64_t perf_mako_mask22_0[] = {
+	0x0000000000000000ULL, 0x0000000000000000ULL, 0x0000000000000000ULL,
+	0x0003c00000000000ULL,
+};
+static const uint64_t perf_mako_mask23_0[] = {
+	0x0000000000000000ULL, 0x0000000000000000ULL, 0x0000000000000000ULL,
+	0x0003c00000000000ULL,
+};
+static const uint64_t perf_mako_mask0_1[] = {
+	0xfffffbfffffffffeULL,
+};
+static const uint64_t perf_mako_mask1_1[] = {
+	0xffffffcfffffffffULL,
+};
+static const uint64_t perf_mako_mask9_1[] = {
+	0xfffffefffffffffcULL,
+};
+static const uint64_t perf_mako_mask24_1[] = {
+	0xffffffffc3ffffffULL, 0xffffffffffffffffULL,
+};
+
+static const struct perf_mako_rdr perf_mako_image[] = {
+	PERF_MAKO_RDR_MASK(0, 0, 19, perf_mako_rdr0_0,
+			   perf_mako_mask0_0),
+	PERF_MAKO_RDR_MASK(1, 0, 64, perf_mako_rdr1_0,
+			   perf_mako_mask1_0),
+	PERF_MAKO_RDR(4, 0, perf_mako_rdr4_0),
+	PERF_MAKO_RDR(5, 0, perf_mako_rdr5_0),
+	PERF_MAKO_RDR(17, 0, perf_mako_rdr17_0),
+	PERF_MAKO_RDR(18, 0, perf_mako_rdr18_0),
+	PERF_MAKO_RDR_MASK(20, 0, 158, perf_mako_rdr20_0,
+			   perf_mako_mask20_0),
+	PERF_MAKO_RDR_MASK(21, 0, 158, perf_mako_rdr21_0,
+			   perf_mako_mask21_0),
+	PERF_MAKO_RDR_MASK(22, 0, 210, perf_mako_rdr22_0,
+			   perf_mako_mask22_0),
+	PERF_MAKO_RDR_MASK(23, 0, 210, perf_mako_rdr23_0,
+			   perf_mako_mask23_0),
+	PERF_MAKO_RDR(24, 0, perf_mako_rdr24_0),
+	PERF_MAKO_RDR(25, 0, perf_mako_rdr25_0),
+	PERF_MAKO_RDR_MASK(0, 1, 64, perf_mako_rdr0_1,
+			   perf_mako_mask0_1),
+	PERF_MAKO_RDR_MASK(1, 1, 64, perf_mako_rdr1_1,
+			   perf_mako_mask1_1),
+	PERF_MAKO_RDR(5, 1, perf_mako_rdr5_1),
+	PERF_MAKO_RDR(6, 1, perf_mako_rdr6_1),
+	PERF_MAKO_RDR_MASK(9, 1, 64, perf_mako_rdr9_1,
+			   perf_mako_mask9_1),
+	PERF_MAKO_RDR(15, 1, perf_mako_rdr15_1),
+	PERF_MAKO_RDR(16, 1, perf_mako_rdr16_1),
+	PERF_MAKO_RDR(20, 1, perf_mako_rdr20_1),
+	PERF_MAKO_RDR_MASK(24, 1, 128, perf_mako_rdr24_1,
+			   perf_mako_mask24_1),
+};
+
+#endif

-- 
2.56.1

