Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333050;
	b=iHCfyS9qRE6ubWRKZFpEaXHtPloTv35lbnowCMuFLZrcymlocf80nRmgIapwJC2VxCdD
	 Q7ZqzvK5oS4p0cKlroGI7ZsRin9ZxofriYaYy76JKpCGxEPKHqK6Tu8xQ6wqUKtMDlBzs
	 t0A9ErTQK9uXqFIava1D0AG0iX/ODFEe8VMGq1huahMhnoOaGJShwLPJYgEFCflTLXjsb
	 hqAv/zlr1KO8BuKV3Ktuk6ZL4JRdy4o5TRyIeiYEv/5LzWUx+Udq9na9ys3RuqhF9Ke6p
	 6XTVuZrwGXDsEj7H/VRUDKCVDAHxed66ky08BoqCvfzOEJq/N9JcQ1UpNuNTHQueMzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=k8YQrYmaFnJ/bzLv9j3s7TLlYstk/zuxpU418CkuffM=;
	b=eB/7EK11VPIn7z6EpQiWHNVc9E948kfdVOpBVqneHEEIR3pppx/kf22eR3pAKxvy1YgA
	 PeLm2zVqdZDgQXs8a0InO0/llgWwRD5Rub/2kK8ePLJWyO/S4RiiMf2ZrfOGY3AbjDJHL
	 e83/u3fLpc0Q4tjTHPcqcnyzuqiyAmiCf7zGhpYFH1l2GxvQJ6n2F934zbx945XCHuNPb
	 ut2MuivkrgtGRev8fzPhu+y2Y066TKieaakFRBRwvjngLejfb29PTt0c23Gx+xXwNveCC
	 G9N8dieLUMTObuCYYp65ZG6U0nFSxrQ6x40GrsuTMh0xHayutwvEkjUIXINhEkOo10w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IEjorO+3;
	arc=none smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8765F606A32C
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 04:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8765F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IEjorO+3
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b0cf2c0785so2527687b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 21:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793333049; x=1793937849; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k8YQrYmaFnJ/bzLv9j3s7TLlYstk/zuxpU418CkuffM=;
        b=IEjorO+3I04jCRUyvIACSf5cC1/XMmFdxw/lxIVFoZ5BwEYbvdoGAy7k8B/ZqTVMsK
         rxAYYXa8Jd5S1EXEBZUGymFXifFCpKePF/5j3GEGS3fSajemW7hrnzj2J6LPysGicZs1
         lywdjepBM1MikivSSy/nEAyI6NNla/d14FKGQjIEYGvt74p3Q6pjnm+wnokZlpsIjmDj
         NdMca9uf/A4CgEpFpg2XQZeDxK6wzytFt4ru4aGCuWqyRdvfzmsRXKGTjCYJZ7AwRuC8
         vqg9rBkGc6KzUPM8Pz6LzzUlo+RufI4tuuT100rCu0ighjkerKX59ZY1bXFAeV+bgijz
         pI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793333049; x=1793937849;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k8YQrYmaFnJ/bzLv9j3s7TLlYstk/zuxpU418CkuffM=;
        b=Vn+KdTUvRQ4rO4172WDYNK25jESkzVsquzQcVP43Dchx9qSR1Y+TILW0qlgrYF6W1n
         Bjod5IvXrZ9ZDZnvwAKkIAYrYwkdSJGST058LZrCSp6i/7HK0bdvWy+QFefkO0xug/c4
         LBZ/CzTctLC1pGzSLYen02wtEnHGFifhdHz0is/sMI0HHfqyrp5GdWkvAzfqJa/DPBEi
         d6JDzViLNGP1Qt2iZzq6SHlNJ7z/q9eevFsTUbhR25FILqgy88REP4dlGMZ6r0TMRFoV
         db3D6x1VjsoZuBuTKUwYo9VqaBjwr6GIX6SsUdJ4sGTL0dbfMWEi2Pzrfc/rB6TKCvEF
         tZsQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4G7eqH9AV96PJZSkbm0xUEa7Dm5Jjx2wH8UuFLAjowX37ZEJX6T5yWiNYi7E5nQCiwlGeWGAXYx9YyC9fuJwY@vger.kernel.org
X-Gm-Message-State: AFq9FYLqKtIvvkiaT0btNfj4+BrzmuMDCLqTnPwnv+kaK6fnGDQ8miDF
	7Kdgs+9umLlpYjWeJw78L0YMLgoGPXcLQcEDgXRxyYaRHl8v9r6blQIt
X-Gm-Gg: AYBFou2mV6tO+n7bK3+xiu9U16MWSohXDYqvpc+eKRxhUPkioWQI5VAlJd5nOLzRez4
	/6evDNEPNTbJ4q5U85D8Gprj8HREXWIZgocezzimoTVDh89PUB248mlTCMaoDRP9AoHRw3TbQwe
	cg/AJLDgtx6d0bBE/gxZ5V92YtGRCBJlWQhSXSTgrY+LDpi///MYEo+0cAUI6jH1Zh4QkehXleE
	fBmHyhkJTA3W7JC9D+mMWrVErVbKv6kpMTZiXw5feSNUJ3F3GshZBsYxabwnZjgFNL/Z8F0NbJ3
	OO7DwnDA1niI5ZQ/Jr3sq2Qs63ZsyUuNevyKOUzsqVXyxUeIb7hFvuSbtY0gknUkqAHHjj2+4La
	lZ9G4qXK74u6wkbDkL64XxqhnZu/5rp5NcAMxLNkkH85xQANkvnghuYvqRRrbs2xC55G2uIXzx+
	Ebw6TyWLOom6Oej1FFf9BogFYF2/XzD8sCJ/iGn4ojOeyrFisORXHp3HbPXtT81Z1WD8wgFCTZ+
	ySpHZMUTtMmEwXReR3Kzm6NtAtbiiC2Cuzvcd48NcuYkbPZm3HkoU5BMz6xNdnTIM4Jt4SXvd6g
	4/Jbzk7+omQhZgh4ShdVkVnJZgBW2s43eifmt5ph3Qoz6a3NGs6O4kUSsEjc58TGnP4iGaQa7nL
	8PZxYuV/dbA==
X-Received: by 2002:a05:690c:d94:b0:8b0:e619:7047 with SMTP id 00721157ae682-8b2b671ed55mr5656637b3.50.1793333049437;
        Thu, 29 Oct 2026 21:04:09 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b7165ae6sm3471687b3.29.2026.10.29.21.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:04:08 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 30 Oct 2026 00:04:02 -0400
Subject: [PATCH v2 4/5] alpha/perf: attach ProfileMe status as
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
Message-Id: <20261030-alpha-profileme-v2-4-c702f1c65272@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4784; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=lF+dz+Xc1sLLtZ2TrZNGFNa69QyOYvxydhn2/MxKdd8=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLKeiOvzchjcXXP52/5ZvnqGQmbXJW/Yxt6ws3yhe+2Qa
 TH/tE+LOj6yMIhxMcwUU2SJW6/IMqttx1Kf09K/YOawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyBDxygeIqfHoJFZXFyaWqSbVlDkkJdfkliSmZ9XrJdfkJpXkF6gl5aZVpKRkV9UnAo0Qi8vtcT
 U1dHNyNDAxNLRwszJwtHUxNnZydDJzdHR2dXJyNLcxMDZ0tHE1dKcgYtTAOYamxaGPzzWD9XYd+
 /cKeH4fINg/Ip3Lv1MDs94Xu5g+nXu5vI707gZ/mncPy6oqqJlfqKkl/nn/4hLU5kzTJjlN71u8
 X2yQIq1gxMA
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
index c7f0ccf8ec80..c9d4b13817bc 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -944,10 +944,13 @@ static void alpha_perf_event_profileme(struct perf_event *event,
 				       struct hw_perf_event *hwc,
 				       struct pt_regs *regs)
 {
+	struct alpha_profileme_sample pm;
+	struct perf_raw_record raw;
 	struct perf_sample_data data;
 	struct pt_regs *pm_regs;
-	unsigned long i_stat, pmpc, ovr, pc, saved_pc, saved_ps;
+	unsigned long pctr_ctl, i_stat, pmpc, ovr, pc, saved_pc, saved_ps;
 
+	pctr_ctl = wrperfmon(PERFMON_CMD_READ, 0);
 	i_stat = wrperfmon(PERFMON_CMD_I_STAT, 0);
 	pmpc = wrperfmon(PERFMON_CMD_PMPC, 0);
 
@@ -982,8 +985,8 @@ static void alpha_perf_event_profileme(struct perf_event *event,
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
@@ -1001,6 +1004,19 @@ static void alpha_perf_event_profileme(struct perf_event *event,
 
 	perf_sample_data_init(&data, 0, hwc->last_period);
 
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

