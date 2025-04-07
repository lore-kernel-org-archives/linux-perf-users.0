Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCB32222CB;
	Mon,  7 Apr 2025 04:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744001173; cv=none; b=kOrTlM2a2gJGbZyFUG1fk+93JP2fV7Pu3mbkuk8blho1NN2BR15ffxgHA/oKjpdeH9vcazebgfMNGz2CyFty/Gw0oilFqi1HNsdhRZ8Xr7ws3myP3ho8jIsGhQnkTKtaLY40guVoNSRsPVCLG8kfsyVEUCZoQ+PEYAeTxQX64d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744001173; c=relaxed/simple;
	bh=Qn+UBxFKpVtKUsbAnfhiKrUYfNaGPfBOlGOEhF8eJS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ouYHEYrjR3b5way6WA12lyTBLWsVPkzVo7xQCRy4VeDcRKiyTkawWV7oAvSuOgrmrG0zkww17euWBx/yOYgAr56Cjq0mIN09ClqjIyVey9zcTKNuwcZAQTW5uyOCiNvD6CAbEyGMwqFovXLgDpoMfxavCosTV2YFPQHGH3RWewA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlrZ3cFK; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlrZ3cFK"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-301918a4e1bso2692328a91.1;
        Sun, 06 Apr 2025 21:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744001171; x=1744605971; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xedAeEvApSvQrplSU1ekdbA9NGbHkG9Nteo4ChiFRyw=;
        b=dlrZ3cFK6YJvHOxoIHMIl0zuyWYiNlSMEh7WjZgOqT8ku0Voxjy4MdVjlZ7EKg3+e1
         BNe2A9V6WiSFiF7rqak84fQxPZAavEjpQt7H02dWrrYvRj+3W1V9SKX551+QqfnHGw9z
         6PIDQh3/iWiv7hkGSdDSzFvfvfuOUjKSoeJdO9E/jFLdv5vK1wGGwrjMwy1pys32K7qj
         TLbEV8ehnIEulCrbCBh0mrU74uaqeB0vu1i2+pD59nesLQesTud1B3cv0rs4bpcdcci+
         oHCoHmsy2RQnXSmsQIuTNLaI4G9sUCuoIYxnjmP7UWlgskxlRDW+2IpQCpZ/kUoPgbNp
         mOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744001171; x=1744605971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xedAeEvApSvQrplSU1ekdbA9NGbHkG9Nteo4ChiFRyw=;
        b=LRlgnF1ZMA/Xx4zc6f2fzf0pwFTuvcJEJR+jgnFaVEDWtd6CMIev9YtttVzUYWe8tL
         5kka0w0rBz2fIjzWE+9izxwhhpjLEQVJ+Xk1Um3qyanDUTv2nX7I2DAsQuA49O1RM1cw
         tsvy6RSzC1nRRQZ0nI0uua33WcHb/lza4+G6/rVadLHyqkYDaW1KFr6qmAlY7cKw7x/Q
         EdKFlyCiuD3nnq0AqZU1qUzdCtCmMFgOmhgovHPdVbNhINVdElgH9uAMLt6CN6rt0w37
         fUO2Is/7FWaNi5bPEta2fWCL7IuARtISv84G+7woqjy5UV7isYjgklWs3WdisgdS+l+O
         PKBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8+18v4gWYhQmleGFdLgHcysrka9tOCdPeOYQdsdc/aQ9PZSx0o/uafXVAD9FNSYS2WMh0kSfxqBlwfsn6@vger.kernel.org, AJvYcCWXIiWD/XsWynI4bIi/VcilpwLYWBbkfmO65yp/FKmsQDrklSeS2d3Kh5e3jpd2pTkqWshDiU/P4fVy@vger.kernel.org, AJvYcCXvgVLwsbxEw+naJd7zTa+uVdtLBmltXExZ3rQVb+wBIqJ4DHTbxzn/H85Fxaq9bsCmTPdJiZ+ikpHdPB6+O+jkjA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeg2Q9NUt3Q4gatIiBxg4dPjLFAqZ5YyZ00rLCkG6yCuP+lo4v
	M+zICYvuiu45htJxAiFPQBv5Nz0Xp3KT40/MvFQbo9NvI2d+OsYk
X-Gm-Gg: ASbGncuxGzXg+yG7GqP0z7wVCG8M1VjenpazwzvxoHy30wslF4R3jNAM2M3pZ2UdNR3
	o3dVJ1pmrTyuJi0GUPXWdzueAESig/HxwRIvjoqFx9U2yPWfdlV9fSW8vpYtku4F3UYuF8Q3AmQ
	7tTEaEjuPoR39s9EMQKNeBT+c5yXtPn5XLjo83oDkb7L8tOLFZf1H4EXwNQyYFSKjN9d8NdR0Tt
	s6osDJyfY4hkyqL2bUxigl88MhE0NXmQySGsTjLTektn/51TWY0lo6CUfyBJj3MHw7EYw2rMy9M
	r/ijvLixjWnJUlDITZj4qqdhcns6oaQuJVFv9I3Ec5MahqQ=
X-Google-Smtp-Source: AGHT+IGrxaobhUpE/KKrj4rgCnJzb4I798A3JeTUshuwGCuxTpNwaCSNZ7EcgS9JOSvfkcezth+Xeg==
X-Received: by 2002:a17:90b:2547:b0:2ff:618c:a1e9 with SMTP id 98e67ed59e1d1-306a61ee159mr11785909a91.23.1744001171050;
        Sun, 06 Apr 2025 21:46:11 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-305983b9954sm7765810a91.32.2025.04.06.21.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 21:46:10 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 07 Apr 2025 12:45:11 +0800
Subject: [PATCH v6 02/21] drivers/perf: apple_m1: Only init PMUv3 remap
 when EL2 is available
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-apple-cpmu-v6-2-ae8c2f225c1f@gmail.com>
References: <20250407-apple-cpmu-v6-0-ae8c2f225c1f@gmail.com>
In-Reply-To: <20250407-apple-cpmu-v6-0-ae8c2f225c1f@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Sven Peter <sven@svenpeter.dev>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1091; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=Qn+UBxFKpVtKUsbAnfhiKrUYfNaGPfBOlGOEhF8eJS8=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBn81iFZ5puw9qhFP8u5Nje2j0soWKWkUUFQDGlD
 seWq/74HMmJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ/NYhQAKCRABygi3psUI
 JFtwD/9QIvFD8R/1BTp/iJHipmTBs9PZYMuBIs3cVUwC9kIXc0+7zHN5ocj1qBmkq7TkKqGg3wG
 GAioGthoqoUVd5C9RXfNdgojjnVXTXO/8fQVRrWftQYMXb8orZXKBXZuh+BEQ9hxzowM3Hscjb8
 tC/wh+VGmijBEl3mxLbbc1ONfbS4IoX6m2NccKLFAE6syIN+izy+2nGBHXulNnb/GqR9SeiT/c2
 LPW7fJD9WXFe0k/gVSD0PMyacqyDdh/HS+uCfFiuriV+53w87Jh6Aog7GH0ftk4sollgTrGxxVy
 f2H37/PRE5eEVTLbDux0PC7tGhX56exzxY7hMO12x+6nx2ax5L1pu9gBa2aVz9GCt11sSL1ZX0d
 Sz/VaJhDyvdG1Onc9Tt7xWlMPfZ3Tpo2vnjLf8/CZZqnEbF2NiN24qZ5wDwZ8/ebgoFPLbfmRgM
 6RUYjPBpcVRArrNu1KsBKODpwEGWdYQ/Wn5oAmOGGUGQBKove52Vx/BOva0JexTrbjCtIZnGhyW
 ZwmBRryhdedFxcCY8YHYsHLkpSKMVuP8EVw0j3Et9a0UVRSt6R2adV4j41hBzZoAEXOyDsyC3KW
 LNNxDgAmJhvlKgrK6rkVYFD1gM+APCwQP0mIHuSPJR9THsQ7eDS/G3vn/6BeW1bZwmbuGvcMr1x
 DvgL3hl9tP+PhTg==
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

