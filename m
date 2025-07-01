Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436B827934E
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Jul 2025 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383984; cv=none; b=tBApSbBs7gtlN8jF6CrCiyTb5nt0vla17nWliqX0R3Zww0ReG99jQl7lnmWHz3wjmXJ3r2ZyvOG1pQAjkODRrWRyB3vZ2jqhOnkK2nTsbOcxLH3Kcpxj0kt8yZ+eaTiazyQSTz+TQH9oo3YLi0FeO5sUsim+0nwdCOYFBwX92UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383984; c=relaxed/simple;
	bh=aVg2cJv9wSlB+Ifm0onjtL26hKkRkwYqLwa+gwkEP7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PF9n80A5Pgj3UBDs2iqYnmvrDh0Broo8HVBQwh6KnnfrpCerycD+YABV3Slj3pl/ggb9VXJ+BJXWAREsxt8+MkBzUwh/O+leHld8IMg6YXO4bWIOMw97benQgX0XZnlVNcoUrU1DhjvvIJadCOArdIqeP1ncjtPxFFNb1QGyHAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CRBQhG4l; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CRBQhG4l"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a510432236so2557664f8f.0
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Jul 2025 08:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751383980; x=1751988780; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GrLv8E2JzJaKuEQhctmJvd3DUiMTxFOf1wZ25rSjEVo=;
        b=CRBQhG4le6OV98QI1qnk/dC002sRE6g1S75Pn5yjgVWeBTLp1QIx6TzR6cJVMu+9/L
         rn37WdQW7MxRcnSVrkXE2PnjMNznfMkF6EXiQVXiZIKnfYQN8gm3MU631oyHo4FoxnV+
         u21lXp/CAHwudss8SuXxxjkzSW4orIJVNDsP6mcvuVgiwjLFBwm2Ks+MxNDj9/LASofI
         omgB5tkV51ipO5jgbLFxR8tXAON8+YyUVK86chVXTdERH5MCW7rECpPYgRQLhqtwP/El
         8jvC+RvI6RGW/XkgXibCdMFn6KSfoaDXBlxUHwmi/NPFaz9ta0SzFo574XowZjH/s21n
         jHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751383980; x=1751988780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrLv8E2JzJaKuEQhctmJvd3DUiMTxFOf1wZ25rSjEVo=;
        b=J2ajY+1Kh/Fk1n56QOnlfrdPxYgwnEo5bhdSvgXpsgfovjwZqwQxa5rgp4U1QobxWH
         6rlOAFpdgZ8UY0z3lgDaHoLmgYxywijAJcuDP9o0ATmAD0+aYsgdTOvkSA/5Cn+5sHAJ
         suXzv+pd4qmQH9HtZjtcOQWVkZa1tMSJ56SjgyZbTZc93o3uZBB6l2U9HM2sycQl4C04
         cyjzS8lEJTqWv3cQVlReDwl3RKcc6rUWAAYMLrccG0aZZ35Kf+w+4liwFD5TmVV3N4Jc
         xSiXdTPbc+AdAQfp0yk3oNupsBkcLFT4xH+o7vVzzC3r3oWZ2w3Bu7fOt4T2ioTQLFl6
         p+4A==
X-Forwarded-Encrypted: i=1; AJvYcCW9yLkj2/VQWUqqGzfxx3YjSPNh5F1srcsg5cptL7F8zij1l5lKvLG1T52aGdbiPq+y6VzuEkpA+CJQ1hoVskD+@vger.kernel.org
X-Gm-Message-State: AOJu0YyvcD9Xlq4KZjj+FylPowZ/a/f6KjIz6jU/y6Ky3T+J8rBsXu78
	Mix4sGOcKnA+ecMtBGu+FHGlql3dekh6GP7o6l3TkCEpvKtYtZRM4JBFHAkdg0KYrVo=
X-Gm-Gg: ASbGncsgazLeyptgJw72A4K1EPQHTRM4htGc8Yp5fWa95CFmBi4ulA6JW8SOKCmxsZs
	a9OcERqTqF0xuQCpPgmu7Kv7IUqcIoi6xCwRH9izNKQ4fGvMUteywsgTdPERXP0TknwPfxZfU+O
	A9btsQPJMeBBAFmev2HBz8cXE1Rmsyq2hLdWJ5oZEdL5mItSe+kKNGNqFqFLBrw2t7le9KNFRcq
	EHcWhyO4ehAr4XJwXm413Kox8ErGMmCMKjNk2PrcLkhKKZjUhRphyXPIBt3HJ1sk/L9jnfBPb47
	l3ei59nFanAUJ+KpddckMsoLt0LuYLsNaYc6G/ooKMhgGJg8Ih/ynbZVQgK5x3gSAkQ1k3DVSTn
	VCSo+kw==
X-Google-Smtp-Source: AGHT+IGhfDvVLxXK0g4NeIbM0C+Rf8R4M1m1N7M8/7K4QfeNkwE1w4jj6lEbfgM0B+KT2OK6Dd4PJA==
X-Received: by 2002:adf:9dce:0:b0:3a4:d6ed:8e00 with SMTP id ffacd0b85a97d-3a8fdeffa19mr14766121f8f.33.1751383980385;
        Tue, 01 Jul 2025 08:33:00 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c80b5a3sm13435002f8f.40.2025.07.01.08.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 08:33:00 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 01 Jul 2025 16:31:58 +0100
Subject: [PATCH 2/3] perf: arm_spe: Disable buffer before writing to
 PMBPTR_EL1 or PMBSR_EL1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-james-spe-vm-interface-v1-2-52a2cd223d00@linaro.org>
References: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
In-Reply-To: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Alexandru Elisei <Alexandru.Elisei@arm.com>, 
 Anshuman Khandual <Anshuman.Khandual@arm.com>, 
 Rob Herring <Rob.Herring@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>, 
 Robin Murphy <Robin.Murphy@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

DEN0154 states that writes to PMBPTR_EL1 or PMBSR_EL1 must be done while
the buffer is disabled (PMBLIMITR_EL1.E == 0). Re-arrange the interrupt
handler to always disable the buffer for non-spurious interrupts before
doing either.

Most of arm_spe_pmu_disable_and_drain_local() is now always done, so for
faults the only thing left to do is clear PMSCR_EL1.

Elaborate the comment in arm_spe_pmu_disable_and_drain_local() to
explain the ramifications of not doing it in the right order.

Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/perf/arm_spe_pmu.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 6235ca7ecd48..5829947c8871 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -559,7 +559,12 @@ static void arm_spe_perf_aux_output_end(struct perf_output_handle *handle)
 
 static void arm_spe_pmu_disable_and_drain_local(void)
 {
-	/* Disable profiling at EL0 and EL1 */
+	/*
+	 * To prevent the CONSTRAINED UNPREDICTABLE behavior of either writing
+	 * to memory after the buffer is disabled, or SPE reporting an access
+	 * not allowed event, we must disable sampling before draining the
+	 * buffer.
+	 */
 	write_sysreg_s(0, SYS_PMSCR_EL1);
 	isb();
 
@@ -661,16 +666,24 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
 	 */
 	irq_work_run();
 
+	/*
+	 * arm_spe_pmu_buf_get_fault_act() already drained, and PMBSR_EL1.S == 1
+	 * means that StatisticalProfilingEnabled() == false. So now we can
+	 * safely disable the buffer.
+	 */
+	write_sysreg_s(0, SYS_PMBLIMITR_EL1);
+	isb();
+
+	/* Status can be cleared now that PMBLIMITR_EL1.E == 0 */
+	write_sysreg_s(0, SYS_PMBSR_EL1);
+
 	switch (act) {
 	case SPE_PMU_BUF_FAULT_ACT_FATAL:
 		/*
-		 * If a fatal exception occurred then leaving the profiling
-		 * buffer enabled is a recipe waiting to happen. Since
-		 * fatal faults don't always imply truncation, make sure
-		 * that the profiling buffer is disabled explicitly before
-		 * clearing the syndrome register.
+		 * To complete the full disable sequence, also disable profiling
+		 * at EL0 and EL1, we don't want to continue at all anymore.
 		 */
-		arm_spe_pmu_disable_and_drain_local();
+		write_sysreg_s(0, SYS_PMSCR_EL1);
 		break;
 	case SPE_PMU_BUF_FAULT_ACT_OK:
 		/*
@@ -679,18 +692,14 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
 		 * PMBPTR might be misaligned, but we'll burn that bridge
 		 * when we get to it.
 		 */
-		if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)) {
+		if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED))
 			arm_spe_perf_aux_output_begin(handle, event);
-			isb();
-		}
 		break;
 	case SPE_PMU_BUF_FAULT_ACT_SPURIOUS:
 		/* We've seen you before, but GCC has the memory of a sieve. */
 		break;
 	}
 
-	/* The buffer pointers are now sane, so resume profiling. */
-	write_sysreg_s(0, SYS_PMBSR_EL1);
 	return IRQ_HANDLED;
 }
 

-- 
2.34.1

