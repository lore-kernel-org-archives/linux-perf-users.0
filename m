Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F2B41BA61
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942155; cv=none; b=RqgV3YpvFLwNkXbcD4rak8Icc+HAfIqwiZ3Q3Oa/KiAx/P1Qs9SuauPYRiG8wlcZj/+NpnJOzEdYH3o4Jw9l6IRos6ATbRhnxtUiko4ZtG0aD6m4toiy/z70D4YzDsTWle2LwIUDamFlATZ5bHAd76eSJ+g+cd/r5UN1MpvnJNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942155; c=relaxed/simple;
	bh=YrfVnORDRZngBes7E8aE7nWhzjQkqGopSGj7UdhOOx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e/aVSeDobFT21K3q4/15OVyWOrpGHBIvwr9ufrfiVuWPDJV1RoEXSrmmDYifUfxcMXWTFqXVkcvSZDUxmjWnuCRB0EAk2esaIRoximRKyR9DVAamo7AGxe8/Hgr4YXDXTnSLtvhTvPA7Q7zGNJsRA0ylYZfcMU7J1jCmcWvHweY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AKrAi3x4; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AKrAi3x4"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4720f3bf164so1478904f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 08:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785942152; x=1786546952; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Flg4QZQ4xZBxdFqtD7yG7JFgD80sYwr4xDNIvMLPrJw=;
        b=AKrAi3x43RZMVyTX6g6jd5V/CXoFWfexVP54e2jkk+D0kXNblNnznlMAZUu6a/bWkq
         GKCKZ9QOD2CQ6q2x3Kv1ZANqnNJM6sQR0TK0lX1wQkefaAyFiTA9UF/lWRtgdYmXJFbX
         9/XjPMuSwmH5yRF6oSR7k7pXxR54zm+TeJjNMpFGr3BuORPxadChcKYdA/xBrJ3MoLkQ
         e5+A+RjboyFmzowj0gHZ1D3a4Z97VEd+pZf2bOmGPQdTrPf2idHjZi4Y1rRACPsrYaRY
         /TuTnl2CGBb8GchQDa+SkRUqmB/zalfr6MNxan8QUZWKoMoVMS4dItk1QtXVXTSncwyM
         yNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785942152; x=1786546952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Flg4QZQ4xZBxdFqtD7yG7JFgD80sYwr4xDNIvMLPrJw=;
        b=QvQkehLTsKid5ckjoN8hTXcm/ymnatj3QGsmo0UImVcRHNcT0eR9iy9VJrPVSreyMw
         EeUgeliR3zLx44Xwm/mEyVoJ8LU90TWjLGNQyKcERBrSNMOwP9ql67Dy4PGqmSJNJPqu
         Dz7OY3ZdOSnjiJ66fORUxsLHTq7Am9Auz/3q/i4N9tfI4IH+28jZmc2P5bZXtPCaRoVu
         FR0NdmuIjIVRXZHMg+dyl/XTZi9ohrlp4kt4oeuIfaMUzDdi5FV+8Q4x3ksE2003Yy/9
         WJkf2JwOaLLzTqy5XgOQAG9ZyfHVDaxIGqDCogieCmtUkWzTMEDfAWmyJ5MrVnE702zT
         Ym2w==
X-Forwarded-Encrypted: i=1; AHgh+RpaKcO9TFeqle+emonFRdmhNJm7zN8m6JY6bO0QXeDDTZ/jHF8XAoDcwZ50arL6upAYCQeJrR/mayYi6klDkX4u@vger.kernel.org
X-Gm-Message-State: AOJu0YyTS1thaEh6sLLr5b9fAqeqpCBC3sQi4SpvnEOwaYCLvaAzvYuc
	f6qDXZAZZKt4QSryQA1Bz4KoRekCPDDd5/LUtMGOoIr1HzA8FdbhEnwaf8UyjkYtlF8=
X-Gm-Gg: AR+sD12cDllrSql9e47XAxMLWVIqxrulTAmjPjkjkZnp2fCUvc/7gQ4GMlrqEfHNYMF
	2F/Vdajj+ZU0hcaLInl5Mo54Re5QjwsX9p6duLgp2AfEjiy/Fb6CGGK+XDKBqqvraQKwkcvtk3y
	/4uTxgkS14VlXrOndIXEXHkp0g2LXeO6+bOlN1n7ACTpkjdFOBHLUupN5Nhik2h9wgChbsojuCD
	xSvSpy1PTd2yJy5ZfyN3n4ijrYYKqPBxgrNtzRZgLA11TCFNBMqGnYoUgwlLZ8bXtLMBRz+cmkO
	7WR3glcO88boiDKeyy8Mg5SdQiTMkuPTTjgDEMzSj9OQO2830preaJw+HF/H4UoY43dcunuT7+r
	r0/2dkFPppNa14MHn8fNplx+lTRIU1mdwEVgfoha1GDCHeYJsJ3FJF9tXC7sqrlCEZ97v+dO3Rn
	+S5Qjj6fBoE0blhnao+zJIb5Foz7mMDJabb+gajHL8aWqMGdugUCXjiU2KtRIz4Gud
X-Received: by 2002:a5d:64e3:0:b0:47f:f002:3656 with SMTP id ffacd0b85a97d-47ff011797dmr8776881f8f.12.1785942147253;
        Wed, 05 Aug 2026 08:02:27 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec23ede6sm10308695f8f.30.2026.08.05.08.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 08:02:26 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 05 Aug 2026 16:01:52 +0100
Subject: [PATCH 2/3] perf: arm_spe: Factor HW discard mode out of
 arm_spe_perf_aux_output_begin()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-james-spe-software-discard-v1-2-0ff0e44c4c92@linaro.org>
References: <20260805-james-spe-software-discard-v1-0-0ff0e44c4c92@linaro.org>
In-Reply-To: <20260805-james-spe-software-discard-v1-0-0ff0e44c4c92@linaro.org>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Leo Yan <leo.yan@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>, 
 Al Grant <Al.Grant@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Discard mode doesn't call perf_aux_output_begin() or emit aux records,
and enabling it never fails. We'll add a second discard mode in the
next commit so it will be cleaner if there is a separate begin function
just for discard mode.

No functional changes intended.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/perf/arm_spe_pmu.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 10d28ad81256..562a1d3be39f 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -363,6 +363,11 @@ static const struct attribute_group *arm_spe_pmu_attr_groups[] = {
 	NULL,
 };
 
+static bool arm_spe_discard_mode(struct perf_event *event)
+{
+	return ATTR_CFG_GET_FLD(&event->attr, discard);
+}
+
 /* Convert between user ABI and register values */
 static u64 arm_spe_event_to_pmscr(struct perf_event *event)
 {
@@ -609,18 +614,23 @@ static u64 arm_spe_pmu_next_off(struct perf_output_handle *handle)
 	return limit;
 }
 
+static void arm_spe_pmu_begin_discard(struct perf_output_handle *handle,
+				      struct perf_event *event)
+{
+	u64 limit;
+
+	limit = FIELD_PREP(PMBLIMITR_EL1_FM, PMBLIMITR_EL1_FM_DISCARD);
+	limit |= PMBLIMITR_EL1_E;
+
+	write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
+}
+
 static int arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
 					 struct perf_event *event)
 {
 	u64 base, limit;
 	struct arm_spe_pmu_buf *buf;
 
-	if (ATTR_CFG_GET_FLD(&event->attr, discard)) {
-		limit = FIELD_PREP(PMBLIMITR_EL1_FM, PMBLIMITR_EL1_FM_DISCARD);
-		limit |= PMBLIMITR_EL1_E;
-		goto out_write_limit;
-	}
-
 	/* Start a new aux session */
 	buf = perf_aux_output_begin(handle, event);
 	if (!buf) {
@@ -775,6 +785,12 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
 		arm_spe_pmu_disable_and_drain_local();
 		break;
 	case SPE_PMU_BUF_FAULT_ACT_OK:
+		if (arm_spe_discard_mode(event)) {
+			arm_spe_pmu_begin_discard(handle, event);
+			isb();
+			break;
+		}
+
 		/*
 		 * We handled the fault (the buffer was full), so resume
 		 * profiling as long as we didn't detect truncation.
@@ -864,7 +880,7 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	    !(spe_pmu->features & SPE_PMU_FEAT_EFT))
 		return -EOPNOTSUPP;
 
-	if (ATTR_CFG_GET_FLD(&event->attr, discard) &&
+	if (arm_spe_discard_mode(event) &&
 	    !(spe_pmu->features & SPE_PMU_FEAT_DISCARD))
 		return -EOPNOTSUPP;
 
@@ -884,7 +900,9 @@ static void arm_spe_pmu_start(struct perf_event *event, int flags)
 	struct perf_output_handle *handle = this_cpu_ptr(spe_pmu->handle);
 
 	hwc->state = 0;
-	if (arm_spe_perf_aux_output_begin(handle, event)) {
+	if (arm_spe_discard_mode(event)) {
+		arm_spe_pmu_begin_discard(handle, event);
+	} else if (arm_spe_perf_aux_output_begin(handle, event)) {
 		arm_spe_pmu_stop(event, 0);
 		return;
 	}

-- 
2.43.0

