Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0811AF4C1;
	Mon, 16 Jun 2025 01:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750037543; cv=none; b=i3Gde+W3BiPG9O/VQVOV0PHta3Xe11FoKpPt3vck8ACfdZAYrIFR2CqSyrQuxl1vpma861UwOPzaONURARocfeNrpzXaTr/tEhwp3byc4TkUiQn4kbsAj0Y3fIynGicbJGRBz5Rk/g2ixDssNL7m9iYZQ69OHzTsiP10NqtK3Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750037543; c=relaxed/simple;
	bh=Qn+UBxFKpVtKUsbAnfhiKrUYfNaGPfBOlGOEhF8eJS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mZx2ThH7lHMH0ReKUgKpzBZGB9RpTPVjAhYafPh+mKmKvk2XfVjcgKV37OhlyiG52WtTSzGFCqPQ+mNmREO/nJps96w0CIiTp/pg6majf+6isY9GN8EjNBSYhuT5K5OD6NOYmjuo7D/asLCMEQsJWG8za3TDpDgOsZoZLKkCQkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5MW3N0D; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5MW3N0D"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23508d30142so43931095ad.0;
        Sun, 15 Jun 2025 18:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750037541; x=1750642341; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xedAeEvApSvQrplSU1ekdbA9NGbHkG9Nteo4ChiFRyw=;
        b=d5MW3N0DQbkHUfBh36p9bV0t0nCFt0qy1kiZ8RTT+2exDVtajTpunJd8mIDH7dAhFZ
         4VVqdycjYUOiCp3FgWm7us5AUh5FNugr+PDxIUXCDrpfBi7r0TlL/CCwM7Xv0rd+ssxP
         hbvsM4Mn5TlnEJ9ZsIqOIr0fmKruJTMNGOayN8mA7DIEF9aJU4ZsDw5aeOjMFtJDIJXO
         aU8nDuFE/bsKO/CoRAy54T8rYeDq0kCOuu47NHZBzkCyOkO7uIeX9Xs1xGMTHwfuT7Xu
         tLJpId123ziLABHzIFU2Ks3Ib/vO6KSajvlqMhnBuIE1s75UUICYiI9kIMvIY9NmgxU9
         oheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750037541; x=1750642341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xedAeEvApSvQrplSU1ekdbA9NGbHkG9Nteo4ChiFRyw=;
        b=JICH1oi58osIDswUWeRLRJdGhk8ltbVagQANGy9m5Lz78xuTlalZJVNwc+720pG4ic
         rB4fePOp9GKWMU1O6Ip/omPYvwjwOmygcXUvIXP0xrBK9xMvyT8ZLkAksQ62oN4p8YOU
         K7ZbxyDp2yM5NdMGM5ZicgBtlBaCnO7FkcsEIyfRASCtITSqOyMrHa+8RO7zT0DNroDf
         bu261NvXp2RwdtPt8Cn6HLk2dwMZ6F7Sv9uTW4Gxmian+x06yIgc8e3r+rS8VN1iDILX
         Sd+LN7VXKq5K2IOgK3k/m8bOBBTA8jhaT6mhfFrN9Mz2wL1CxA8IR4aiAJo7UUvYNexB
         28Ew==
X-Forwarded-Encrypted: i=1; AJvYcCU0uC8UFLDu4v0uhx6bx0n9dnNwkXltLCy8+dRhmTdiouahwAuD0bJrWVFZ7HJCjm6IrjAG29OneAvX@vger.kernel.org, AJvYcCVuJuNOQHKNiriUBMrbPZJsOtACpWpKvS5LEkkt+KKAv4Z0gME/E13a/bIVTxeusB1pm5UH/V3swHxlNnvT@vger.kernel.org, AJvYcCXU6vfboNwH78FhLMOPR5G3QkjzRzbaM+1UBkJlQS/wvIk+lcHWPqJtGoGmG/H9Pl/FMLR6mc8UwzVTMyfwht2k+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg2c8dkk/8ah0ppO8rh8BxR+SuqOs2kmBr/Wr8kvnV/qOOYFPU
	TTC74qUWqp5HNS2+p0R38t1UxejnpAMhihAdwcurhHDoK3e5YcfLAgFg3FIqrw==
X-Gm-Gg: ASbGncv/L3rKx85e/ssRfFLVnLmBnHfzUGFTek13msPIatmVGcRHAPwF0//gPnTki9H
	N18DXvqJdtn9EQf1bjyokaLxWM4qzVbwqOuW6RAJnAXG+9uGTm9lWa6+AduwOw0nZSipSJ7mxIN
	cAVN+gel3Zc8iiYw11mKlxG/703CzRrkgH0npYEpQJ8bNq627PQreB9cb8xmeq4Z4SnMtYCxEmm
	4QA+kC0sZGkhgChHFMrZavfEd6H40Tp+WzMHsBeK+PTGNBI1JGr+IsASslaWs14oG97R0PV9Ijg
	PCz+mIb5d5DyaNqKAXt+ZVmEEQkSPU5xtnOK61zgqC1uLcUfgZag1ChtMQWoz9K9c27yPkkkiiy
	LehU=
X-Google-Smtp-Source: AGHT+IFISDWBL7BPw8cSUkGaFEbifD6DnUVRGFGlmdHKDSr0FEa14n0OgyU9SWJHrR71gKoWz7K7Ng==
X-Received: by 2002:a17:902:ea03:b0:235:ef67:b595 with SMTP id d9443c01a7336-2366b14954fmr120715055ad.35.1750037540464;
        Sun, 15 Jun 2025 18:32:20 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2365deb2cedsm49932455ad.163.2025.06.15.18.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 18:32:20 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 16 Jun 2025 09:31:51 +0800
Subject: [PATCH RESEND v7 02/21] drivers/perf: apple_m1: Only init PMUv3
 remap when EL2 is available
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-apple-cpmu-v7-2-df2778a44d5c@gmail.com>
References: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
In-Reply-To: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1091; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=Qn+UBxFKpVtKUsbAnfhiKrUYfNaGPfBOlGOEhF8eJS8=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoT3QW0RWxD6BW94sGBJvu3l9l41lpp6YjR6y5b
 L13ka+GzEuJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaE90FgAKCRABygi3psUI
 JLfyD/47l3DoVLnVWlN7rfaCtVBAT7NOIUMhhRoueqjpsc5Nr7uxPFgcQBPxEwuCd9zKs5y+z2Y
 urnBCkgvo/EwrfF9IsTpLy+eIvH93tKRmc6mONfBTE5Tg1cQW8MyGVQ6VcTiArNIZ2PKmNz5bh0
 DbUCg3dtH61/hoQqSQQ0lxv8jaFZ6v8/d4bXmXbzpVCTI5EOQDSRxeJYUvBOFGnnDv9e2ZQ+Hjm
 t443NbhyFB/p6afW2FOXWq/SaNW8IJednDByrfUtIG5TMLixf+c+H6bo4/LX7XgDmVdmMkGPWaz
 VsXtP5B1xvdMxv3PXc8YoSvg+pwwQ8T9IVFN56OQ4vIdG0asSJa7FaYclMa27dR1pzMVRmYbQu2
 9/7q4g3pXyesglP+GFSANYVT5nR71/eGDq2nUU2pwv/LDX0hdlkNbdZifAOvXIm67ktwre5sohp
 LW1l226gL8XQhoUBCxyKI9alERX8/tEkwnxOkWB4sbico/dLFXR9KkyQZkkCtOCwzE/394jPeK3
 11AgrKtTjvADhxLX9CTVYrYw1PM280pMU7KwG3xYhnBWAUuojdfdVSXD8MCg/C04kpNidgWGSgj
 86nZPOmShxVZyMmX/7F1dtmlCZnCrZp8BmO8IYjj7Hoqd0tKahjHA/kQIZ9QiF6wSv23fvFrNiW
 9C8DWiYD+nqNMuA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Skip initialization of PMUv3 remap when EL2 is not available.
Initialization is harmless in EL1 but it is still a weird thing to do.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index df9a28ba69dcfad6f33a0d18b620276b910a36ca..b800da3f7f61ffa972fcab5f24b42127f2c55ac6 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -646,8 +646,10 @@ static int m1_pmu_init(struct arm_pmu *cpu_pmu, u32 flags)
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
-	cpu_pmu->map_pmuv3_event  = m1_pmu_map_pmuv3_event;
-	m1_pmu_init_pmceid(cpu_pmu);
+	if (is_hyp_mode_available()) {
+		cpu_pmu->map_pmuv3_event  = m1_pmu_map_pmuv3_event;
+		m1_pmu_init_pmceid(cpu_pmu);
+	}
 
 	bitmap_set(cpu_pmu->cntr_mask, 0, M1_PMU_NR_COUNTERS);
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;

-- 
2.49.0

