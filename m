Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F4934D398
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942150; cv=none; b=FO9gKugjVJiTzvwhvopmc8fS3C+o+M3z8Ger+5mOF1Dvx+tNB18MNxCJAoNazsV9rFOsaDLRuesbqWte3gMeFcsfRhiuiZIZH4/fIogX2UcwMtHWL8eb9ZVNdliUzjkrvjjIh6OjK2hITxqhImfbLmxykXQVDg7EVH6ZAfNWBN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942150; c=relaxed/simple;
	bh=XjGEA+w8gpV2jQYN6R3+Kgx/wLLSx/0QslA0PACaxXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CqT5HvfDVAbVtJSraW+9QHJ5MVKLjf1iMoQs5/mjK15aaBw0BLg/MxlHHVDSRFqz8MNoH9zxCPLmRiZpm1KZZAMum0TvZFBnqBqNx3Qv/gKdjnRNG3bskyGi36WCklSJrzTHWLiA/iZ7JmeQAUQOwvjyhrihK/Fu1Q/BJ8IUJiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K2Cr0bmo; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2Cr0bmo"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso763940f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 08:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785942146; x=1786546946; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YdFUB2zH6KQ2jS1Qeu0n7oVNGn5pzmET1AhmT2Fra+g=;
        b=K2Cr0bmoPhlHcTx6kL2912yI2aB/PBx659e7uGML2yzv84YzRp1xTUi71yRt9FnPCX
         AlcXeptDwzssxXh4I0aYwTFpppgE9Hb00NBJSKGjkwl4AxRdq4+uZZyvFLkE053lidIt
         BQYziNJncB5j9dVmXpixDhdDYQ1ON1GFtmBOzjBdO6/bcmlHGeeESKDTavNUGkZe2Vo2
         m9I3PFc24uCFvVj+SoSgb3/x31A0lQoGDXY0GT8w3EQb2jRBKbkxMb+dUDJDaeRYVWVq
         FpMg0YeK9+PR8Mfy5n6AKGcpPz6eORBrsoEQRC6vns47DeGrPkGHkn8xSvq/M510qplD
         Bl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785942146; x=1786546946;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YdFUB2zH6KQ2jS1Qeu0n7oVNGn5pzmET1AhmT2Fra+g=;
        b=og2JV10vJjYI2bJO/G5ELXCJjRj3SPIRmAmtqr5/ESiiq1x2pq9XOo8uPGinEk32Ag
         dT0fTTLiQ9rlYZA1D3q0GyrRyzoYG0NtEchTMjkfr4PtGfIjs5NbstORqm+0ORf/Rrgz
         Z6NVmV76umVzTmWsFAAfbn0Ykn3zi+YvDx6Pr4lTdbpdKetUvRhg56Q70NdxBvgy+19o
         UMLUTQq9HkGNHks1VQfSirFabzAhXeL0bJRrZ4x3vtjEo4YPf04B007y7ScT4oEt5m2N
         IxVW0L1T48RHI07ccvyYAu9EPbz/nxg6co6M7hW5kzsFjyWv0v94BoZBWRQxtDe29QMP
         XRxg==
X-Forwarded-Encrypted: i=1; AHgh+RolYSkIj+vmibuds1n5A16RfpMYPv1fm5Tkjd86YvEag8tw2Yo2SDRegBfzb2zlea3VBmguGwHRjwy9LsSxywDV@vger.kernel.org
X-Gm-Message-State: AOJu0YyIRh90vGnVlsdTIdOVc/QHiJRtqnHZjgTt8TXZAhhdgWT14Yr2
	PLp0ZTazyDXLDcmSpu07jOZSAIilYpd1MtKrrwREJfFb2SD8XxgrzX7kihVbwn/navU=
X-Gm-Gg: AR+sD106gfAbf3pAxUTuCfxbiMiyuaC8piNq9y3zOoR1sdnAB0lRewkYwAvPcQrVXxL
	eIh290k1SpDtxP4QeTYW6Ji4KIO8VNAcDPXPfnow5MnEjraXhhAD+UyKZoZGWT0m1M+henIQj+c
	45hrJMdwhwGoPSOXjnHSCSkbK0V11jiYfd1dwAOQRAx0R/ts1Swq/A7z/1kIrtc3W2gEOQbnPkq
	sx3PLpy/YY/p/vT8hOVt95fWVpNU0Xo8tMf85VCboff22fxwg8xt1gwirfJgjGsz9/8rzDIy5a5
	Ckx76iXEWnXWEWv7GLmKRqLGJjCUkI0vK4nzYizSxKJpetEJ6UeQUPPYuXGiLM8fZ4H+r8275eS
	yNJyWmB56hix0BlY9nki9PTCkAmSHP78L7or8LtSgog3gVuFvH1W4P+fsVBhF/Zo7RJpV+SOBdM
	OsB9AVm2VikTf9ETI2cQJIQpwdIksjk1FbNBmHLp5rWUf0eVaaFKFaLbUM/e7GkTlVC77EZIuiY
	5I=
X-Received: by 2002:a05:600d:4448:20b0:495:5e3d:15e1 with SMTP id 5b1f17b1804b1-4994e7d21fdmr85868895e9.16.1785942146401;
        Wed, 05 Aug 2026 08:02:26 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec23ede6sm10308695f8f.30.2026.08.05.08.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 08:02:25 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 05 Aug 2026 16:01:51 +0100
Subject: [PATCH 1/3] perf: arm_spe: Factor aux output and flags out of
 buffer fault handler
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-james-spe-software-discard-v1-1-0ff0e44c4c92@linaro.org>
References: <20260805-james-spe-software-discard-v1-0-0ff0e44c4c92@linaro.org>
In-Reply-To: <20260805-james-spe-software-discard-v1-0-0ff0e44c4c92@linaro.org>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Leo Yan <leo.yan@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>, 
 Al Grant <Al.Grant@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Software discard mode will still want to handle buffer faults, but
doesn't have a real aux buffer to set flags or call
perf_aux_output_end() on. Factor the aux buffer parts out of
arm_spe_pmu_buf_get_fault_act() so it only decodes the fault, which
better matches the name and can be used by the new mode later.

This makes the arm_spe_pmu_stop() handling a bit simpler because it
doesn't need to conditionally call arm_spe_perf_aux_output_end() anymore
to handle the case when the fault handler didn't do it.

No functional changes intended.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/perf/arm_spe_pmu.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index dbd0da111639..10d28ad81256 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -677,11 +677,12 @@ static void arm_spe_pmu_disable_and_drain_local(void)
 
 /* IRQ handling */
 static enum arm_spe_pmu_buf_fault_action
-arm_spe_pmu_buf_get_fault_act(struct perf_output_handle *handle)
+arm_spe_pmu_buf_get_fault_act(u64 *aux_flags)
 {
 	const char *err_str;
 	u64 pmbsr;
-	enum arm_spe_pmu_buf_fault_action ret;
+
+	*aux_flags = 0;
 
 	/*
 	 * Ensure new profiling data is visible to the CPU and any external
@@ -703,12 +704,11 @@ arm_spe_pmu_buf_get_fault_act(struct perf_output_handle *handle)
 	 * flag to indicate that the last record is corrupted.
 	 */
 	if (FIELD_GET(PMBSR_EL1_DL, pmbsr))
-		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED |
-					     PERF_AUX_FLAG_PARTIAL);
+		*aux_flags |= PERF_AUX_FLAG_TRUNCATED | PERF_AUX_FLAG_PARTIAL;
 
 	/* Report collisions to userspace so that it can up the period */
 	if (FIELD_GET(PMBSR_EL1_COLL, pmbsr))
-		perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
+		*aux_flags |= PERF_AUX_FLAG_COLLISION;
 
 	/* We only expect buffer management events */
 	switch (FIELD_GET(PMBSR_EL1_EC, pmbsr)) {
@@ -727,8 +727,7 @@ arm_spe_pmu_buf_get_fault_act(struct perf_output_handle *handle)
 	/* Buffer management event */
 	switch (FIELD_GET(PMBSR_EL1_BUF_BSC_MASK, pmbsr)) {
 	case PMBSR_EL1_BUF_BSC_FULL:
-		ret = SPE_PMU_BUF_FAULT_ACT_OK;
-		goto out_stop;
+		return SPE_PMU_BUF_FAULT_ACT_OK;
 	default:
 		err_str = "Unknown buffer status code";
 	}
@@ -738,11 +737,7 @@ arm_spe_pmu_buf_get_fault_act(struct perf_output_handle *handle)
 			   err_str, smp_processor_id(), pmbsr,
 			   read_sysreg_s(SYS_PMBPTR_EL1),
 			   read_sysreg_s(SYS_PMBLIMITR_EL1));
-	ret = SPE_PMU_BUF_FAULT_ACT_FATAL;
-
-out_stop:
-	arm_spe_perf_aux_output_end(handle);
-	return ret;
+	return SPE_PMU_BUF_FAULT_ACT_FATAL;
 }
 
 static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
@@ -750,14 +745,18 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
 	struct perf_output_handle *handle = dev;
 	struct perf_event *event = handle->event;
 	enum arm_spe_pmu_buf_fault_action act;
+	u64 aux_flags;
 
 	if (!perf_get_aux(handle))
 		return IRQ_NONE;
 
-	act = arm_spe_pmu_buf_get_fault_act(handle);
+	act = arm_spe_pmu_buf_get_fault_act(&aux_flags);
 	if (act == SPE_PMU_BUF_FAULT_ACT_SPURIOUS)
 		return IRQ_NONE;
 
+	perf_aux_output_flag(handle, aux_flags);
+	arm_spe_perf_aux_output_end(handle);
+
 	/*
 	 * Ensure perf callbacks have completed, which may disable the
 	 * profiling buffer in response to a TRUNCATION flag.
@@ -927,6 +926,7 @@ static void arm_spe_pmu_stop(struct perf_event *event, int flags)
 	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_output_handle *handle = this_cpu_ptr(spe_pmu->handle);
+	u64 aux_flags;
 
 	/* If we're already stopped, then nothing to do */
 	if (hwc->state & PERF_HES_STOPPED)
@@ -944,10 +944,12 @@ static void arm_spe_pmu_stop(struct perf_event *event, int flags)
 		if (perf_get_aux(handle)) {
 			enum arm_spe_pmu_buf_fault_action act;
 
-			act = arm_spe_pmu_buf_get_fault_act(handle);
-			if (act == SPE_PMU_BUF_FAULT_ACT_SPURIOUS)
-				arm_spe_perf_aux_output_end(handle);
-			else
+			act = arm_spe_pmu_buf_get_fault_act(&aux_flags);
+			perf_aux_output_flag(handle, aux_flags);
+			arm_spe_perf_aux_output_end(handle);
+
+			/* Assume PMBSR only needs clearing for real faults */
+			if (act != SPE_PMU_BUF_FAULT_ACT_SPURIOUS)
 				write_sysreg_s(0, SYS_PMBSR_EL1);
 		}
 

-- 
2.43.0

