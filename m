Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D58B34C811
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988688; cv=none; b=VGT+Efs+A5P9PhmN8bSV1ZxqGTBo1NgN9SdfZy6rYTs/n/SJQfbk+J8DOrt2O6oR61mHdATSwHI7SoZfG3p0gPKxBxCNCgSNBiXyqa2MRxGLjcYkDG3D1rL2QrDlIdHZzWX8ZP6pGS46g8NAGhyaZRQEL6b3E5LaaiX6JrERcew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988688; c=relaxed/simple;
	bh=T7VIuEp6hEe3RkCETbS7KqP+//z7d2ZDmQMS7i30tSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DMw0qVS+HDvP02f3rIZNh5uQms66xAr69hR9ZTAeftKkcR9YhRW3VKDmOPIWAHxURn1Tzn0NXzvXZmxEXoF15C+2pACXK/Cb5Xs1L253JFbFIIsgg1DZXpeuJhLBbgIEBxm6XZMFMVfrYP6c4tK/yr6E+DKWLWAACovyP/kzMSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwRENprO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwRENprO"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0834769f0so46490395ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 08:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765988685; x=1766593485; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gnmU0etDq0lcWJuNgsoBFmFUTXG/dt5JQHfVECxG+u0=;
        b=cwRENprOndkOow5Ty2XXUQ+vpL74uurZMdWOiepGRzbJfY4OrVPfgLur8zoZNqt2c0
         AX1IBkNY8oHNRuejOWlud4cQ/HW1sIBTmkaldkQyGOlLEUfHRIUk+pZIOpVeUJqdM45/
         6mhQ3plds0XTSamdr0e6SQtm4NJj4+WNH10fTRks2fWeADwWL+QO/4Pr828zf6aBoUpz
         BEp4xymS7tGaoPimPy9hEvakQ3HDupOqXXf1BPnRnVPcnXCgLujW7vD0y188y2gVuSZ5
         i8oQJPP+XPOIFqEoiyF1ebwIAf7BJQaJCFtLRFICrQeGAw0/g2s6QmPf94ODpkr2sa6v
         5Aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988685; x=1766593485;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gnmU0etDq0lcWJuNgsoBFmFUTXG/dt5JQHfVECxG+u0=;
        b=BuwtLItoKpX8F6ToaxDdUKwiBmINiVCdk+NNIkbK2IBfcpgMM93+ZpzkyzOh7vEVic
         brPSkwqqalf2OmZNfvwyftp9bl38AStBAz2lCDVTMhVmKqRkjaUaLVjaSXDAJfVdBsrq
         XvkZmmOsqOhZOP3cWpbayVY46jSi5F++T4CgjtPF03f3+O50KkB7GNrE1HTPrcLOJa9C
         bHLDNrm5dmcLyRej+C8UhYx2mWsPBNojLMhsQ4Zsu7CZ5V7k3mqvpnwCsL9SC7OYbLxt
         Eth6qxGiK5Wo9uHrdmB7jU2OfqfgvtTBQPHw+Lk0fj4wgUw3N2a68f9At2oxo5tJG22F
         y8zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVvnkrgRsEU57liqzc44Ty/R4VkCh6o71ptRa5dufyDu4ITzTcVMXcBeQH1DDbTAAhr2YCqT2hUeQFwtKGBVPU@vger.kernel.org
X-Gm-Message-State: AOJu0YxYgcHr6DYBC1Jh9PxKTJvjgZ3tJeQUYSC9B3WXf+euZw/BQrIe
	cnbccBZi/xiiUSDvufvU1144lUgBbLego9eUr2my7ZafyK+dG2rmHbJB
X-Gm-Gg: AY/fxX5ypeZoQeVZeRAIOw5utomVU/k7WgUExyLqGxPifVgLFNytb94zmfuCFdyXSoW
	YCXgsydtuEcJLHUWcnlxpoUaaowaG9BNuilnxd4r6TuUQ4EtplA1uFYPeEReL456wmXRvpuslVK
	DnMqnlI6BfNn0w+lwH19p02PCi3g9R1qLsDLC5CI0Czj0HNd2l4cLY6nf/kmOEsN1QmMMGQiQ6N
	b7fZoocldhpwL5bVg5WcPM8TPnD3X7Y1iJ21SOkCvy8TIhTZXm94GPePLKjgckJ6KtlglBvRJPS
	+Ir1FkIgb17cB7u1P2zhn9URxG/5lx1szVu5nI2y2JUiv3u7eoUI0c1s+np1/0ER3A4IlZEoGBV
	ZcpIPxpCRpP8WBPaXlFIHWfxGoYNmnsVVtaafuLmQvsBDS7QDEo8AWhX8bxziboaJqe3jrm00fh
	Js/UFzQCiemaXf
X-Google-Smtp-Source: AGHT+IG/nquZVvdb7hdBfthWotpPmdj/WUeQ/0emdMCtPLX4TCGdHlRO8AWzO6VXDeE101kKUDS78A==
X-Received: by 2002:a17:903:4b27:b0:295:ceaf:8d76 with SMTP id d9443c01a7336-29f2435b8d6mr184902615ad.47.1765988685325;
        Wed, 17 Dec 2025 08:24:45 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a0b0687c62sm122980415ad.88.2025.12.17.08.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:24:44 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 18 Dec 2025 00:23:15 +0800
Subject: [PATCH v9 02/21] drivers/perf: apple_m1: Only init PMUv3 remap
 when EL2 is available
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-apple-cpmu-v9-2-4deadbe65d03@gmail.com>
References: <20251218-apple-cpmu-v9-0-4deadbe65d03@gmail.com>
In-Reply-To: <20251218-apple-cpmu-v9-0-4deadbe65d03@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=T7VIuEp6hEe3RkCETbS7KqP+//z7d2ZDmQMS7i30tSU=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpQtlAE5NDqs7fuGSBDfaoYGlzVF4qIaF1lkua9
 vndWjdJ4UuJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaULZQAAKCRABygi3psUI
 JIu4D/9aF7Vmpryy6HujH92+R1amWBbT29Pk0lgoF+TezSRD2mGenGzsAFgeGPO1uhu6SNcGhLA
 9aovgC8dRLUhnM+lq07wJN8mog+EtcMVDUCNPbS+lOF+fm2lUb1E8v+mUh2AiSG98pPOXyxrLVb
 aX7utsSghAD7AjWd+CDTx4LJxDbLVNs6ZYCNlVMxhz+einkIjKBqs5k1+M1omv7BYR9QSY/kyU4
 7yfSx3/VqpK3jdWJnXMhYqLM2a4iwar70Fa8v6zCUI5i4eLqox4VsBNEKcmWiYZk5XKQC1wj0Wk
 gKs1RVHwkOPaweHbQgnnQQOw2lAl18Ot0vvP49Gg/ZGi3wM5s3C3PXqIBsu+vBYthkDeghuDWod
 SXN1xtbIfDPrSdruCYMpccow4QJv2+aTLMFutcf37T2prLmgRAuhVEzvsFsQfEmGgL0MWfgxupM
 8azf8sRLi5FuFbdShEK9mwZPX9mrhc4/QkSJzYc1VUtX0U4v/jxWTKgFT5mhSegmsIpeP1EqUHB
 v5L5Jr/PiJ7k2UCXoKOYHLc24hMgpROoVNyWt/DJaY0YKeAu5hohiEPlbz40CCnOa7mQDGw94qq
 MpvpFbZ5v1p8NCmvBMCDOij33xk0cusBM0Ep7YJmCftcvETI0FZOrnPpHIXcowieMk4zUfpnC1y
 AURR4XPLwieqCtw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

The events in the Apple A7 PMU is very different from the ones in M1, and
EL2 is not available on Apple A7. Instead of assigning the wrong PMUv3
remap on A7 or declaring a new PMUv3 remap that would never be used in
practice, skip initializing PMUv3 remap altogther when EL2 is unavailable.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 81b6f1a623499566ef04d04075752f34e2cb6a92..f3948528e28e0189efd0f17fde0d808930d936af 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -645,8 +645,10 @@ static int m1_pmu_init(struct arm_pmu *cpu_pmu, u32 flags)
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
2.52.0

