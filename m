Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2182A223709;
	Mon,  7 Apr 2025 04:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744001186; cv=none; b=VFZdYxkBqEtUentghc/HDYXkYLTK4nUjtb0m6IDp5bSxJ2dvIal191R86HuNhY50TNZVk1m0jTCfsvoHn+3yARXNouvF6lJ1n3pIayKce3mGyW9tBKZ/9c3eyP6Js9IoPhqzlp32X/+dLgUvMeTMS+6ktAB0BUkXIzJn+LQfv9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744001186; c=relaxed/simple;
	bh=XuN7zsZ7YOoemig6fmya2Ywu9aWxTuisbfQnSd0HHz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PRPHIh8zLugMkF3NgH6+tD4bULR6buJ/vQpzTXCMot8j2wQqM1AlVT0l/sWCFTDZv990HJR1z5q+dDZe0IKbohdlFrWqYQ5cTH8wzGFTJGRf6rYYIxNwQbq4gFdU5BvPv+bdHKcyUYDQUhoYPXXIBermO0X172FqZnfOQQXQZnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dg5TTI89; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dg5TTI89"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-ad51f427054so2577877a12.1;
        Sun, 06 Apr 2025 21:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744001184; x=1744605984; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qETjSISznhSwPPS1o1aaIPNAE1fFREGWY+BmDgwUuls=;
        b=Dg5TTI8920VGSSf4Ibtk4BmUPPeWwuRaZv1VclxgydRTKtAne1MCXPSGDl2fHTDo73
         wFhIVqUHzKEsJEcC5kK+OUTMOTPDBFIHjJG4UGd5uM86geNcE5u4nesYgFaSGTAklfCl
         lI/14Vwz56olrKbpVQGbdgJtqwcDvtu+MptzQ3tl1EzxZTPu6Js8zSLSYdT2FB5pGd+0
         zSewnqmb2AMkvQ5O+HJMHAAfLvKgznULGMhEuGMilHTcVXeef5hCZWinkvGIv//09hYv
         QjoiTmJ02cq74WjoJngIm/8SvNHzz1T9ryYEzWMhlQ2okDHNB7eUqw9Cbpgcw4VzPdAI
         4WVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744001184; x=1744605984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qETjSISznhSwPPS1o1aaIPNAE1fFREGWY+BmDgwUuls=;
        b=miUGli6B8AlsWR5y0BD1QHbwaitLZ6CFVblH3aV1zOSDbV0sp7ngl63WDWHJHyDqFR
         pYhUf89J0Eq8ZZbOj1nSIhJl+9fYpMi4mQU4jKduhmB5dTNCivPhSoYog6iviMod4DTs
         3RKThIolXz8mFHuPScUX3xMb6IGjoy0WeVXrSgwj73i71kFvIXcCQ7VoTW/UMx01soW2
         xzmus5GgbQ0EDw3iydyS7afUmn6nNZtkXhXuIinqNjsXCqxwvq81BYYNR7gO2jIPh6IN
         AM+n1qqdzaETOzZ6WynGv/VDdjT9L9JQ9eInNy5Vmbmm+DKVi12+q9kD9qwtUVsHve0u
         peEg==
X-Forwarded-Encrypted: i=1; AJvYcCW6Ef44yEJFyobSnOWTZEGMxdMMmZhypJ12RGn+xVBNaREJ5kSNJrBtHwWMRmLnUcFF3QqGAqNbEd7FtD0B@vger.kernel.org, AJvYcCXJokiSa2sOXu+9EkuNa2VmSyF/0nsMopTC7RYjVSN/kK9Xm/zXNSmjGWlzkp+lJSBFE8mi7yfD4CEc@vger.kernel.org, AJvYcCXS81wVRtWwFsk5Ic6Ncz5uFhnQlVQWOuwLfNibH6enDc7kju5PZdAhoIQBQc2iWqYi++h1h+MB3gr/A1Dhx40+Kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxShn0tfB6rBAVrB8r7BG+b/kD8DIwFZlubz2u12UZNXHz7Qp4M
	jQuvj6FIRgZ4PStJkQM43pKOueGvYl0B0soGaMCRsWCj0ssoRyLf
X-Gm-Gg: ASbGncsEuu7nHmQQw0vwzltn6vKDoerc8tMgMzKZOscWR3ViRq2bWRG/FhhMdPyETqr
	c8i36J7XdalgCkQIRKbyOSIfga2UYZk4Ff9ln1nqw48uCn/s+RYyDcA39Km2ugXlk6X0x2MbULf
	FMzBITf3S4W3bbGCxUf3dFk+rKiD1oIwDmuw8DqEFUf75g75RagHiDwMXy/JngrDaYw6yXy8mFa
	fHnA1/v7Wpwjt9CoGZFrmqq+fRDJ305Cx+h+io1cb3FwXF5rKMbLY+maZ2voAaBsr4XR6y48CEt
	c03LizJx2/PgVeeFnjLD8GEbmsgCzZFB+I4ri73O/FHMaDno5FUydUDDVA==
X-Google-Smtp-Source: AGHT+IGYQoaK3vw8XmhPvcq6HkCDrn06T9cMzDEgAiLjyJ5UOyzNsi1lR4Ihahet6xHWzu4E4Z37Rg==
X-Received: by 2002:a17:90a:d646:b0:2fe:ba7f:8032 with SMTP id 98e67ed59e1d1-306a485e486mr17007211a91.9.1744001184276;
        Sun, 06 Apr 2025 21:46:24 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-305983b9954sm7765810a91.32.2025.04.06.21.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 21:46:23 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 07 Apr 2025 12:45:15 +0800
Subject: [PATCH v6 06/21] drivers/perf: apple_m1: Support
 per-implementation PMU startup
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-apple-cpmu-v6-6-ae8c2f225c1f@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2178; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=XuN7zsZ7YOoemig6fmya2Ywu9aWxTuisbfQnSd0HHz8=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBn81iGrPE67Q+X5dil2ghBm2CGl7DhIEIc+JlRJ
 NJTDrRde/CJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ/NYhgAKCRABygi3psUI
 JAGoD/0YlUpOe37l+KbRTZhMKDfhWXru37w+hdyNOlWkR7VlVG6Wm9JXOoi6TZAfmZ18hLmEWFI
 ApstQjHIziX7xMZmCLoqJzhyz3z+jT/hB/KOZkyqPuXGP9lqXrUv+ZfwOoriN/TxipED4iaFQ30
 RcZojMN02vgjs5V/q70m2yCDB0woPyl0Hi5veJYGk9gW/eWkV4/M1SPbLPA6hjhcPaTBwVk4BMm
 AFYl7Kwd9JGSFjmCX65dWHCEF/oIyYDekVF8eclHld0rb42++mI81Be745a1LnQlIyJ08OZ9aKP
 2Jt9hb1zXMKZZSShjEMijmFjZJjKRMXrF814vXTis/Zz4lLDEF1RRu24GGLmttLmtlvZctbCS+m
 fMAsnjibZCTX6m1QeX3rL4kIdzRbf5AT4jdZFPBXiFAiZkvqNvgxaQ2pxrHhRbokO415JrhDLhJ
 tynSka+I8eH7afYDNUZ8ZxMPSsI+DnELqidBUYQ8Kv6e+zJQzqNYq54TJ4A8kUylkNLpF1wsszZ
 NeOO7hm40HKZMGArEfsv9cgXxJahNEI9jOs0bj0e+fqFzDXtHY935bLrUjOMNYTRKMETpT+KWkU
 hkbrfmnCimvRl4LuLLJIrPS+jEna8ywL4Gh65CecJZB6OgIXY7BKcLfZO7UtsRQx040CazpLyoY
 lDfz2AsMUSeJ7Xg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Support for implementations that deliver its interrupts in ways other than
FIQ will be added, which requires a per-implementation startup function.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index f2566a0f8d330fdc0d71ae298f16ee9700a13c23..38fb9200369c11d0d7674bec4f350915c67352b9 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -660,7 +660,6 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu, u32 counters)
 	cpu_pmu->read_counter	  = m1_pmu_read_counter;
 	cpu_pmu->write_counter	  = m1_pmu_write_counter;
 	cpu_pmu->clear_event_idx  = m1_pmu_clear_event_idx;
-	cpu_pmu->start		  = m1_pmu_start;
 	cpu_pmu->stop		  = m1_pmu_stop;
 	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
@@ -682,6 +681,7 @@ static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -691,6 +691,7 @@ static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -700,6 +701,7 @@ static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -709,6 +711,7 @@ static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 

-- 
2.49.0

