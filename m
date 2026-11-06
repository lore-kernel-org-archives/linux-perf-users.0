Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939462;
	b=hc9p/oNhAJsRhoFT09/F2ihKnfCBytCfvVLloJYLML3gOuKp2YqH19g7YPy8vmLTh9jX
	 /EhWNVRR5HdMcetEQYoUfJAWE6L3ysXDjtrhJbRmAcjSiawuZ449W2stFQH4tdpYvcUVs
	 v6R/l+M/rui3LgNDirBxe0Zy7ve3BtVuSNmocLTMJ2WbEsRv3Vk/EIO1p726RfQRUUfz6
	 vn5m+FbRvSDDY5nIUSPw+2OM1IJmkR00wWz2/uNit4cU7RIzxWr9fq+lMIvH0ncoNd2km
	 KQiNakFZGflmEFtJjCsHuNZroKdNMomgNYePa88VwVPjY3iztZl4H8oRiooOccWPHpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=G831IGB9qOUDsorlr+4vmy2c2tG0vM4lZyaYNCG2Gtk=;
	b=DAwDjdT9pLqnruuvg5a58P3g43yUu+vkNQdMGAnykeCQ1d5QGvPDpzykJ2clrDBMRV+z
	 t5gQ8GE+GxRaiV5yp+AJV2/HYffETMWiJKynbFjFYG6JZVfD1iJvHFPRKgf4OvFzV8OLf
	 badguugMxwNDSFLS6LMQ3R83kvwu3iFp0OW0uoi+XIqOWE1NFr4zmowE24LJyytTpW3gn
	 qTx9tZB+6pAO4R+aw9KOyn7DM9DwQ8xLte2de4ViLM6kzbPt2v0gLntrrum8/iT4eNrnS
	 /IfSEHTAr2DAnNR4ZoE+QnH15v7/4pUB7hQWUpAhVNLtvN0lyXScOoXlyJCPVIMukkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JW9uZOk+;
	arc=none smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824D0606D812
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 04:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 824D0606D812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JW9uZOk+
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-677af43eed4so243259d50.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 20:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793939460; x=1794544260; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G831IGB9qOUDsorlr+4vmy2c2tG0vM4lZyaYNCG2Gtk=;
        b=JW9uZOk+rNSQ0m1adb0AsrizzOXv///NVOzlcihnXuhGXfg7nk6sI/LzJXLs9znidL
         xultSDHgrmVtwdxSvRjf0vsO0gVNnOf42FlZjbjj2v0xzBBywYjTHKHe/ZSv4h1qBdMJ
         SzbmcB+B0xIpnLwRefdeiD9iiRRJ/zkQqddXcFGyDvW0yVINTPlZV6rWBPD3nUWDYual
         g1owPhzY5b84z2MN43fMbeBNuhcoZCnSudC1B2iTIEzmh8u1UftGmVwGVUyIf4aJseta
         sk7dcir+3YOWR4Kfc6xW+CR6Z3pBEakhYo+jV8/xDp+Mk78WwLD2xiW0DVx0K7Orelnd
         qvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793939460; x=1794544260;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G831IGB9qOUDsorlr+4vmy2c2tG0vM4lZyaYNCG2Gtk=;
        b=OwQeeVaKb+He5UMGeejCGfAQvjL7dMyIxh7RI8dPJ1iszRFiCKIVwrTeyiOHHubSao
         c93f8ZajKlnLImVNSm0bT2ymUxYCHS+hbPsYmrP0qL0c2RrGC9EK8dPD6fywdBGIugjy
         pvs2mAjrtuIojdZV/l/aOnt/UiIp1QNBihxo3HlL5HEdz31HUDfKATAIlhLpK0RBfG1v
         uA1dGORln2FjPtRHZ4cloPccUty81kKfD6LriwpWuZbKDUqECOHSC4SSnFeHc/DcyuSv
         /UNbVm/9mIrnpPYPWvkRA4GRTBOntyvTpdkmd3/dcPLRld/UzaX/C9tVE3zvun6Ux4at
         CliQ==
X-Forwarded-Encrypted: i=1; AL+hErHtJBUF4oR78BFGBXpIWi+7yCAqJKxIoKPKMkGfJRB1nc7PDAHRAnBS7xFJUD500MQrVJ8fslHsSWjFKDYqimJM@vger.kernel.org
X-Gm-Message-State: APuU4Z9SM39bGg4rdDv8ZfE2rcYPRJvGkKFqpRkbFWRTPUmZZTE/NVGm
	1bIGC7GHzP23PVE0PX7crBPdF0Unc2O1CQFhtOm2llk31ZtUoSNUaNAX
X-Gm-Gg: AYBFou0jj/YV0vJ+VUcsn8StRBXjnNHE06W7WBphu4bVxKU7rvGE6Q8N1THvEteFGFs
	8iZnP1f5r6V8QE8OkLMRj4RM/QNba3XYT/uoBzFxnEoAqkPIT65rQgK/zmVwWcrDtBxeTRuw+t/
	SM71kJ22lsaZN9hqKcU9V9Qll4/AbuloSdToJtDl7cyJImp9ebovf6L1QlMfzBjGHOCPSyeU4md
	p4J2SuPY2Y0yLQ1riz/jbT8xKWxZ0Owtni8ai8UorIRTBttXq/T5L6c23TK6xxwKEUN3t0Ph9/d
	eagNaxrAMqS2i/eLMDYM567NfP74p07pOEqU7wLYOQKFE9bc/TKtDSM1bQka+KpVDAYtxVDcgkf
	zGdJVtZ2wDfySz5auaROwa1IMP0y6hYhk9fpRVSM/i3kHJSmR9ZNsveYX6Ql4gC9wlc8s8RlfMb
	aXuen2pchHE1Frmr8P58iRPwsA3tmaP23cYXueMvSlqecd101oZVTmjLjXtOY33kehwjRiwyeI4
	H3Matn7VifZWk4Mu6Xr02APjki/OKEoYtMJE+H2l+1jzL/yH7eZtBqbNg3wVhvESTEYYBsJ9GFw
	NzMBJAlSDVktKgmNBv1xrWIoCOejdUfCYuQGbfwMh06MnjnlDwoZ6pLcFxfEYNMCD3Rf2FZxan1
	pbM4ZxLdHAA==
X-Received: by 2002:a05:690e:400c:b0:67b:e062:2972 with SMTP id 956f58d0204a3-67c143dc3c6mr999569d50.40.1793939460464;
        Thu, 05 Nov 2026 20:31:00 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c13371f3csm1206662d50.3.2026.11.05.20.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 20:30:59 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 05 Nov 2026 23:30:33 -0500
Subject: [PATCH v7 14/14] alpha/perf: honor exclude_user and exclude_kernel
 for ProfileMe events
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
Message-Id: <20261105-alpha-profileme-v7-14-c474e892abb0@gmail.com>
References: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
In-Reply-To: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Michael Cree <mcree@orcon.net.nz>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4451; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=etGiS+KjgiyXzjebY7Rb4XAH8uHilSqEgpWO7GWDiV0=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLeht+9d2HOdUku7mwvlT32rmWdc2//WKtRkn3Wy9BWs
 /hrhkZHx0cWBjEuhpliiixx6xVZZrXtWOpzWvoXzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 CGToGMVD5PQYNDKLi0tTi3TTCooc8vJLEksy8/OK9fILUvMK0gv00jLTSjIy8ouKU4FG6OWllpi
 6OroZGRqYWDpamDlZOJqaODs7GTq5OTo6uzoZWZqbGDhbOpq4WpozcHEKwFzzM5mRYYNwHC+v9O
 6drUE/T8oqhfbqxd7uuGzduS3qRMisJmabM4wMt6/P4mX9diNpfdaF8mojf0HXaRGqR9PWXva3+
 hHMc+AEDwA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

The PMU sets PERF_PMU_CAP_NO_EXCLUDE, as the counters count in every
mode. perf record then fails for unprivileged users: at the default
perf_event_paranoid of 2, the tool sets exclude_kernel for them.

A ProfileMe sample says which mode the profiled instruction ran in, so
the excluded samples can be dropped, as AMD IBS does with swfilt. Do
that for ProfileMe events, counting PALmode as kernel, and ignore
exclude_hv, as there is no hypervisor. A sample that falls back to the
interrupted PC is dropped if either its PC or the profiled instruction
is in an excluded mode. Aggregate events cannot tell, so event_init
now rejects their exclude bits itself, along with exclude_idle,
exclude_guest and exclude_host for all events.

The event count, and what PCTR1 counted during a window, still include
the excluded modes.

Suggested-by: Ian Rogers <irogers@google.com>
Assisted-by: Claude:claude-opus-5-5
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/kernel/perf_event.c | 47 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index aa6ec2161ec4..58d132be8d0e 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -844,6 +844,18 @@ static int __hw_perf_event_init(struct perf_event *event)
 		return -EINVAL;
 	hwc->flags = profileme ? ALPHA_PERF_FLAG_PROFILEME : 0;
 
+	/*
+	 * The counters count in every mode, but ProfileMe samples say which
+	 * mode the profiled instruction ran in, so those that are excluded can
+	 * be dropped. PALmode counts as kernel, and exclude_hv is ignored, as
+	 * there is no hypervisor.
+	 */
+	if (attr->exclude_idle || attr->exclude_guest || attr->exclude_host)
+		return -EINVAL;
+	if (!profileme &&
+	    (attr->exclude_user || attr->exclude_kernel || attr->exclude_hv))
+		return -EINVAL;
+
 	if (attr->config1 & ~ALPHA_PERF_CONFIG1_FILTERS)
 		return -EINVAL;
 	if (attr->config1 && !profileme)
@@ -995,7 +1007,6 @@ static struct pmu pmu = {
 	.stop		= alpha_pmu_stop,
 	.read		= alpha_pmu_read,
 	.attr_groups	= ev67_attr_groups,
-	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 };
 
 
@@ -1151,6 +1162,24 @@ static u64 alpha_profileme_status(unsigned long i_stat,
 	return status;
 }
 
+/*
+ * Whether exclude_user or exclude_kernel rules out a sample of the profiled
+ * instruction at pmpc, reported at pc. A PALmode PMPC counts as kernel. The
+ * two differ only when the sample falls back to the interrupted PC, and
+ * such a sample is then dropped if either mode is excluded.
+ */
+static bool alpha_profileme_excluded(struct perf_event *event,
+				     unsigned long pmpc, unsigned long pc)
+{
+	bool pm_user = !(pmpc & EV67_PMPC_PAL) &&
+		       (pmpc & EV67_PMPC_PC_MASK) < TASK_SIZE;
+	bool user = pc < TASK_SIZE;
+
+	if (event->attr.exclude_user && (pm_user || user))
+		return true;
+	return event->attr.exclude_kernel && !(pm_user && user);
+}
+
 /* What the memory instruction at pc does, or PERF_MEM_OP_NA. */
 static u64 alpha_profileme_mem_op(unsigned long pc)
 {
@@ -1261,14 +1290,6 @@ static void alpha_perf_event_profileme(struct perf_event *event,
 		local64_add(ovr, &hwc->period_left);
 	}
 
-	/* A dropped sample still counts, for throttling and frequency mode. */
-	if ((alpha_profileme_status(i_stat, pctr_ctl, pmpc) & hwc->config) !=
-	    hwc->config) {
-		if (alpha_perf_event_set_period(event, hwc, 0))
-			perf_event_account_interrupt(event);
-		return;
-	}
-
 	/*
 	 * Attribute the sample to the profiled instruction rather than to
 	 * wherever the interrupt landed. perf takes the sample's mode,
@@ -1313,6 +1334,14 @@ static void alpha_perf_event_profileme(struct perf_event *event,
 		memset(pm_regs, 0, sizeof(*pm_regs));
 	}
 
+	/* A dropped sample still counts, for throttling and frequency mode. */
+	if ((alpha_profileme_status(i_stat, pctr_ctl, pmpc) & hwc->config) !=
+	    hwc->config || alpha_profileme_excluded(event, pmpc, pc)) {
+		if (alpha_perf_event_set_period(event, hwc, 0))
+			perf_event_account_interrupt(event);
+		return;
+	}
+
 	perf_sample_data_init(&data, 0, hwc->last_period);
 	if (pc_only)
 		alpha_profileme_drop_regs(event, &data, PERF_SAMPLE_REGS_USER |

-- 
2.55.0

