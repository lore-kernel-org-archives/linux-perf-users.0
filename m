Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E12B281520
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Jan 2026 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767258179; cv=none; b=D1Kb3GysRtE+7m221UyV9zVkqF5DWSNF8r2H+rtmxiNhVfD1TluQWvtlbeW84gTFThaXoJ3+rDrk8GaxLJppWMaWvaHyJmtT4m/etJC06jBLpT7XRqxaiZo6pghUmBWOlV6Q5Z6tWvKbNkVRR+Xif6ZlvyoQY6yrnce1/fWNlZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767258179; c=relaxed/simple;
	bh=NU8ScGmoP75NTB+9OTDUGxz+f/5ItDBm5slDMiDdGlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mAzyMQIVg3/SYq/2sKYFFnTxrcGHgRCZIZ+WJoPkRYA6019nyuG3CfT4hmJVeqObQoU+MXV431+dYgs2C4K3/i0Se2s9ZHHrWsTUSbLt84otUR+OyxRI4yOUW1CFW1sA+4+bTln7ue7mQGjqQ/RJOazpUc/z7sZ33Y/o9cHiwM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OV2KxEYb; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV2KxEYb"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a09a3bd9c5so101169655ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jan 2026 01:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767258176; x=1767862976; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=562CWWEEZvkhVziZnN5oXKTCmOhNnY9tXruJsoQZ0p8=;
        b=OV2KxEYbbND/HdhC8BzO4I0rapkZIFH4rRXHr+7ndVzL3QgOvuk/EfTh5UQ1HmBM/i
         t/YINT3A3JEBTfKU30W4AhKashL8pb39QMArmDmdwxNF3Of84kOUKnLmfMjB/kP+S09e
         oxIEmneULDMqGayJ5mn/N1FdM5T67oyFL23jdgMBgRpYRsCWRrE4/LCBzwmCH5Ny8Tgm
         x6p1DcGpu3JbxYdsKfJ95SiNba1PEJLdHnQxyFN8LgxXPdjigeZawDbIcNOfETWFTkWy
         UzAe19EiQsmlXqTppQp5yAeX3T2it504+Jk2xl6KlbZ3jtiIOxS8CGKHreupj5SOMYTs
         VX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767258176; x=1767862976;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=562CWWEEZvkhVziZnN5oXKTCmOhNnY9tXruJsoQZ0p8=;
        b=Pebk8wg/aOIu1zFjfT0/GfCstjx3pN7g48TCD/Rk0nRW13RGzCrUtx2TIDQTk+ySKu
         5lkPkY+aVZcB4vSbp735XR7LKBWLOoPdQpk5JeyfUSSSksTxN9EM0aUFnBExvxoyQ+pd
         Bw9bY8ZI1l2N9FEW3bDKOJwBCULk/IR4km0CnwWpCuo/08/p+B2B5VBu+ttVCgL0xgzy
         zSrbGbRSYNUmUR/yxu6XpncDssu6NWgbCvZEI1Xdm3Ewyo3ru3/JpTfNXs1VTMT5kkSM
         5DeVS935a9XaoeN3RbOl2XfQ+Ubu4k8dacub4jdNMS04rPOyoxRJNHPYN88VHnj2vr2q
         JDzA==
X-Forwarded-Encrypted: i=1; AJvYcCUxU5IhwvTGoE7E0Jn2iSQHCXvEZX8VNoOdqh8Ey5126yp5i6U3GMVb4IbD+77kbzDTRCsbvYGSNDktXbC4t8Wh@vger.kernel.org
X-Gm-Message-State: AOJu0YwyBfWh2jRQWof9j+zbNPbfsHJ5rtdk1LQDwcpNb2qtVNclLExV
	1oNqiUTv0MYHDSeTT8Mbgjn+ki5rqyp0oAJoKgVsFc+qR771OSmyelNZ
X-Gm-Gg: AY/fxX5f2eZyBr7N5eUpQMlNaPvmGvIxpnBiv+gvp94N4AMPuE4A+1IlTbCYupLT+4L
	C5F9AhUuBbttHG0SG+H8szkkiTwVCM38ofCchgxHlHv63enEV3zR1vFx14fpoifpuYSeAlMqVWJ
	DBEdtb2UD00oC/ipA08onFxYw+iuZq1Ri76rN9zlnfghavehbngNuOclrJXc3F/5epsm9GWFlCx
	EPYqS3fClSvmCCThrtBORZV4FNH3A4P3Xp8LeecE7NhMnCoXg9cfb6xabByg+gp+oRO+TVOK9/Z
	WFVP60sJ3o4TJw9L6mDp0sY3NWoovGOEprod33i0ssiJGgBMrTYQUrQoD2hfeKO+BkLmX/vG+c4
	g6Hz63fa6Okk1T5GZ1JbZpsxKlm3vQogIV5zqyMfD10XILgOBB+Ndc+xc/SjFK89kzfLmFOP+jG
	e5Q/4gqpksqGRb
X-Google-Smtp-Source: AGHT+IGvF03jWexAPJyhOO/i64xBB7TgDY1P/zTwtuv+fTjh6qLFIzbXX3lAjmk4xMTgxWdhAdn6GQ==
X-Received: by 2002:a17:903:40d1:b0:2a0:8972:d8ca with SMTP id d9443c01a7336-2a2f28367f5mr416747135ad.35.1767258175996;
        Thu, 01 Jan 2026 01:02:55 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac29bsm37182957b3a.39.2026.01.01.01.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 01:02:55 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 01 Jan 2026 17:01:42 +0800
Subject: [PATCH v10 06/21] drivers/perf: apple_m1: Support
 per-implementation PMU startup
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-apple-cpmu-v10-6-48812c529ffc@gmail.com>
References: <20260101-apple-cpmu-v10-0-48812c529ffc@gmail.com>
In-Reply-To: <20260101-apple-cpmu-v10-0-48812c529ffc@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2181; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=NU8ScGmoP75NTB+9OTDUGxz+f/5ItDBm5slDMiDdGlc=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpVjgn4+BbzPzmvWZ//5Po4M/zFrkKjQT2wI+O8
 wgEahlzfFqJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaVY4JwAKCRABygi3psUI
 JEPmD/sFiwZMs7NQhuYcsTtLBMmLLgeraA1aRrIEksKSz/7IB3rYXDcntcSrfcGLZTTIgwqsm4N
 /pMVUnhEYu6wCag9SPwikW+oLIyA+dkw8vIrhEdmF8ZmoNpliYBe707KXo0pjkUQuxkjFJrdPYJ
 EYJftIe0s9FQYrwhNFqlFr8w4kpQKiHWzQ7E+IxntmQsWQdPYlsQVgkPSTIxjAJdeGrbWtO2daO
 Kl0ops2XzNpwhDlZAZFJ+38pctInGZQ7Jr/Z1U90efBoaPnrOjghj4Gk7MqL7KvHQ+DCl7PRP1o
 IqOYRKw30cZGMJBkcle5sj+k1b/EjDkURtWBt9EGr1d3vYSgsgPDsJ0quEYC4B7LFD/4kpySjiP
 CD46EcVx/ZclAF4SbtmmRrhCWr3ThPeTgKlNFRAtwQwbtcFfz8yBlJJ8GlARzEh/UrgFpJxpcbq
 h/oTeLN35rWdc32FeOephqdk7YbqymuBwWEUEjc+wpGZBN3ysz4t3XJNx2o1Mo0sscPobAehXPJ
 uMX5mrVQ1SRxeK1D/FfGxHfFMKc1TxqUrlyCwEVNAe449Wbn0Yl/XTpnJk95QTG9DcsuNd/h0Hf
 5dimwO6+AvzmtPzXO3o/i9jPLCE3sT8ezpasjGmTq+UEYimtNEaGgfWEZIIecV75BS6RXVnIC/n
 pdtZ725SgGg3DNw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Support for implementations that deliver its interrupts in ways other than
FIQ will be added, which requires a per-implementation startup function.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 6340ff7d3b75d7f0c7ab159e4114d49cf031daca..0655eeaea96b46d638b0998944c30a07f3273c2b 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -661,7 +661,6 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu, u32 nr_counters)
 	cpu_pmu->read_counter	  = m1_pmu_read_counter;
 	cpu_pmu->write_counter	  = m1_pmu_write_counter;
 	cpu_pmu->clear_event_idx  = m1_pmu_clear_event_idx;
-	cpu_pmu->start		  = m1_pmu_start;
 	cpu_pmu->stop		  = m1_pmu_stop;
 	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
@@ -683,6 +682,7 @@ static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -692,6 +692,7 @@ static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -701,6 +702,7 @@ static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -710,6 +712,7 @@ static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 

-- 
2.52.0

