Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793561301;
	b=N5KZM8QfX3mCC04vV5RQ6h3XFQ0Be8JJOMtEffB09zRwunUpo4I7UeK0T0NajIQRnGwU
	 MHidjK5XTCRT/+wuw5sJU57jTTPfEg9nho4n9DsbbUHLKjUPg3eqbXt6Hjx9FvhI93hAG
	 LY9kA6R5SV4SMKoZ3PFEiNeQWnnBVmm2rBvt24BBWtpPMmf0VL1AuIZVDa+DmzFNAMBan
	 3egSFkK7eWtYrNp9sW5t8DsBMFHjOJ5zSskVkZRueFPnUsu6iDwMF8Deyc2IZQGsvBXe9
	 Oi1hEqzk8F+KKfZxCqa+Gx1pygo6eyJ09UVb+5ae4hpw37J2ap5MI2CG4clU+OAO5hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793561301;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=0r3yUZYAMoAv8gYB8pqaaXRfwu3+kjfroYDJFcnOW1Q=;
	b=BoholychbeAzKwM7g0uhCj+LFJebwtw9r8H3iqLK4eZftmRuaVWBpb9fECVUx31yjp1p
	 qIB1scHaD7JWPI4B8bQF/jDpkLM9pa9YKUIL+HDHr0LUfE7p60bgT9k1mk+uq13nKjoMn
	 Ef6OQ2cZ4kZKREIPmdlcRSBPMVv+FYpuWeJ6Fg//S5sve2JdJY/sZezfw6LWc3y/oFqK2
	 U96zcpza6OZjba5uNt3kOJPdeDCyWYIxL3j0XXUa5MqJ812OkWWIHH+utojXqJg1pXeCy
	 5xwcGAgDslepnOE357GDWzKvatdfxE24UIXYU8EswTseVCTQz+SRh7TCBTdsCqqSKPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dGBODuVT;
	arc=none smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A3A606A329
	for <linux-perf-users@vger.kernel.org>; Sun,  1 Nov 2026 19:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76A3A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dGBODuVT
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-676858d42f8so1942465d50.2
        for <linux-perf-users@vger.kernel.org>; Sun, 01 Nov 2026 11:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793561300; x=1794166100; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0r3yUZYAMoAv8gYB8pqaaXRfwu3+kjfroYDJFcnOW1Q=;
        b=dGBODuVTMqjdgfE1oRa/OU9+NoH8QL8EVlF9P0v5i5Q6nlUiwMch68V6tMMxjm3cQf
         MRLGfFyuOAdP3wkhJE+KhS1HZDHILa2KdRkC9uInnOR8kQBIcQRbNsrux7JSgKHGo9xg
         7ASjCtc6qtsqxa2fHeADvSC845q/xIlN0NGMenuzmaX7zmjq8VY5uMl5yB7+C4+yE2d/
         SAu6DrLc+7F/ug0qbMZNOraMT8C3pkokeXOkZSa6/jqnmWln0nc2zYhqFiev0prJPETS
         DPaIJ0dWZP/vZ76p5n6R/zoIRg3FxlTYgAU/GgarhHTFZ4RJRGnpQi2SXlklcpEkChNS
         IxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793561300; x=1794166100;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0r3yUZYAMoAv8gYB8pqaaXRfwu3+kjfroYDJFcnOW1Q=;
        b=mgRkVyaXkx1PYx3oNS9pEMUjsiv+Hj200hsbnpfWv6jq03pwrD73pnALDTbee5W0RK
         Gv93tulBnUDKz2nUvTOdJECu3Q8DlS3N/ruYhHwNMq0G+KhNyMxKDxGgz5G67mzl11dD
         gRbVgmtDqmiDBeGfVSGNLQ2yiYYF7wxQe79NykJ86XpBtOgUlPpLBMJZ1q4OW4G36Cwz
         UxrOCOit5BNes3BbvazjQkMEK2IFwD9QbsS42A4Zah6pVOq3H1lQc2PFzB1gJfePiWxt
         eRH5dYyKaiTsr9RMazS464WEFOqSfHZTiIhakSvWwi1DC44h+QkSOHCUXPpzfjU1Ri0O
         Z3TQ==
X-Forwarded-Encrypted: i=1; AKwUvBzLCHWOiQs3VDHL78gcah4BXH8g+QjQKfl0VodYKzJYyxB40cV7E+KmdFnicM6c2MCm9SWcBnkDpfqrUwj9l4OB@vger.kernel.org
X-Gm-Message-State: APuU4Z8U7JYAKJ5OZSrf9Yjanp/zPJOv0x6/rO1KtYUoz967UCTQac5q
	JlSGCGHguNHkr5cox/NXRTKBSEVm6bg7/Gyj57zCVYbEheNU9i35w1BU
X-Gm-Gg: AYBFou3lLOLkjnAB5VG9Myh2hWpWX9fL7QQbU7GaAbO1O+bWBZc4FS48S1YXzu2BK+d
	vw7LEyx86/v0t6m5TPboA227+d6HhqtOuBi4kZeVosl8fke7/bn744at082Wj1cGJfFfv6rXd0y
	uZDFRZdjKQL2q/X1p0qwoAFAiUECPhtTXuOxm4OaIHTaLAY2c5uUAhZaFL1AUPqljsdhLzZo1yq
	zqmqFVVz/Ycq1CxSuNLtCzVeo20j45X8/7TpU0AP2GLcvbQroUKvHBMb2ottGUn5lpl6Rhx4Smh
	2hJXiV0eJbJ5Ldhc5hdlaCWJmaIDYotkegstdERp+mLoe/vw1sdvvR70daPRP0Ev4vwsHa0XRX9
	bsfSl4BGA5CFjCHYBzuyB7F1/WWeY+iZHv+R6CI5ziwrinS3N7/eqzmrQdTyr3OvcyL9+AgJFJ0
	GztBUFgsZLsGILfUhvn/LtK3hA8jdP08zePQd5pC1dYc4KtUhS2E9Ba1mi9dvcdI5ZSLMo1uWGl
	jhrScu0KSVM1l+HFGtAhgJFGvL9GRf0gQuveL1It88IwPkBosd9R3yeLMOfWJ1s9s5FtYLyDlk0
	P0cfZ/4TikvSgI0L52X2EAKFTFOuCccUOPaNngTyDCIfQJzDySVaj/Zw5Zs4SR4k6saT9yGzMIY
	ux6MBzvx6eunkxsLYi9B/hm+c/31si6w=
X-Received: by 2002:a53:b407:0:b0:679:8f04:229f with SMTP id 956f58d0204a3-67ba5058fffmr3603785d50.161.1793561300395;
        Sun, 01 Nov 2026 11:28:20 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b704e62esm40700517b3.3.2026.11.01.11.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:28:18 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 01 Nov 2026 14:28:09 -0500
Subject: [PATCH v3 6/7] alpha/perf: attach ProfileMe status as
 PERF_SAMPLE_RAW data
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
Message-Id: <20261101-alpha-profileme-v3-6-92d511b5a044@gmail.com>
References: <20261101-alpha-profileme-v3-0-92d511b5a044@gmail.com>
In-Reply-To: <20261101-alpha-profileme-v3-0-92d511b5a044@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Oleg Nesterov <oleg@redhat.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>, 
 Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4982; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=OmXQMd3w1MENTUR3kM0+E6xHkv5n6Mmuqmd3Mvb0SnE=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLKeTzoq28OwYf90h+3aTt2ecbecFHoY9tk/LO2s8rYsf
 6/gw8HY8ZGFQYyLYaaYIkvcekWWWW07lvqclv4FM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 Ahk6RvEQOT0Gjczi4tLUIt20giKHvPySxJLM/LxivfyC1LyC9AK9tMy0koyM/KLiVKARenmpJaa
 ujm5GhgYmlo4WZk4WjqYmzs5Ohk5ujo7Ork5GluYmBs6WjiauluYMXJwCMNe4FzH8r+2edXMln8
 QGtY7VM+r9Ls2YuHTixHXF6xn35cYXK67Y3sHIcPfYxu2KJlvzORuncvvPPbq47eiZ632VK5pCB
 dU319rYsQEA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

A ProfileMe sample's PC alone does not say what happened to the profiled
instruction. I_STAT and PCTR_CTL do: whether it trapped and why, was
mispredicted, stalled, or was killed on a wrong path, and what PCTR1
counted during the window.

With PERF_SAMPLE_RAW, attach PMPC, I_STAT and PCTR_CTL to each ProfileMe
sample in a versioned struct alpha_profileme_sample. PMPC is included
because a PALmode PMPC is not the sample's IP. Killed instructions can be
told apart by PM_KILLED_BM and VAL. The 64-bit fields are packed after
the 32-bit version, since the payload follows the 32-bit raw size in the
sample record: they are then 8-byte aligned in the record, which needs
no padding.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/include/asm/perf_event.h      |  2 ++
 arch/alpha/include/uapi/asm/perf_event.h | 31 +++++++++++++++++++++++++++++++
 arch/alpha/kernel/perf_event.c           | 22 +++++++++++++++++++---
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/include/asm/perf_event.h b/arch/alpha/include/asm/perf_event.h
index 72536566014a..f498c1d47c07 100644
--- a/arch/alpha/include/asm/perf_event.h
+++ b/arch/alpha/include/asm/perf_event.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_ALPHA_PERF_EVENT_H
 #define __ASM_ALPHA_PERF_EVENT_H
 
+#include <uapi/asm/perf_event.h>
+
 /*
  * Software events have no trap frame, so perf_fetch_caller_regs() fills
  * in a zeroed pt_regs. A zero ps already means kernel mode; only pc is
diff --git a/arch/alpha/include/uapi/asm/perf_event.h b/arch/alpha/include/uapi/asm/perf_event.h
new file mode 100644
index 000000000000..aa0eff5a917c
--- /dev/null
+++ b/arch/alpha/include/uapi/asm/perf_event.h
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
diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index f55ddab7478e..a816a18036b7 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -974,11 +974,14 @@ static void alpha_perf_event_profileme(struct perf_event *event,
 				       struct hw_perf_event *hwc,
 				       struct pt_regs *regs)
 {
+	struct alpha_profileme_sample pm;
+	struct perf_raw_record raw;
 	struct perf_sample_data data;
 	struct pt_regs *pm_regs;
 	bool pc_only = false;
-	unsigned long i_stat, pmpc, ovr, pc, saved_pc, saved_ps;
+	unsigned long pctr_ctl, i_stat, pmpc, ovr, pc, saved_pc, saved_ps;
 
+	pctr_ctl = wrperfmon(PERFMON_CMD_READ, 0);
 	i_stat = wrperfmon(PERFMON_CMD_I_STAT, 0);
 	pmpc = wrperfmon(PERFMON_CMD_PMPC, 0);
 
@@ -1015,8 +1018,8 @@ static void alpha_perf_event_profileme(struct perf_event *event,
 	 * happens for ITB miss, Istream access violation and interrupt
 	 * redirects, and for instructions inside PALcode. Keep the
 	 * interrupted PC, which for redirects is the instruction that
-	 * trapped. Do the same for a user PMPC in a kernel thread, which has
-	 * no user frame.
+	 * trapped, and report the real PMPC in the raw data. Do the same
+	 * for a user PMPC in a kernel thread, which has no user frame.
 	 */
 	pm_regs = regs;
 	pc = pmpc & EV67_PMPC_PC_MASK;
@@ -1048,6 +1051,19 @@ static void alpha_perf_event_profileme(struct perf_event *event,
 	else if (!user_mode(regs) && in_entry_save_code(regs->pc))
 		alpha_profileme_drop_regs(event, &data, PERF_SAMPLE_REGS_USER);
 
+	pm.version = ALPHA_PROFILEME_SAMPLE_VERSION;
+	pm.pmpc = pmpc;
+	pm.i_stat = i_stat;
+	/* PALcode sign-extends bit 47 of PCTR_CTL. */
+	pm.pctr_ctl = pctr_ctl & GENMASK(47, 0);
+	raw = (struct perf_raw_record) {
+		.frag = {
+			.size = sizeof(pm),
+			.data = &pm,
+		},
+	};
+	perf_sample_save_raw_data(&data, event, &raw);
+
 	if (!alpha_perf_event_set_period(event, hwc, 0))
 		return;
 

-- 
2.55.0

