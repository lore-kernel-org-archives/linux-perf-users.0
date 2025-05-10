Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD0123507D;
	Sat, 10 May 2025 15:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746889911; cv=none; b=OF/6qxw5HsHvGZLAfKMb6iQEO9OG1ELLlzws+lViErHgCQweZpBswDTLXW4Rxnd4/TV2gYlOrHt0bB2nX0jwNj54F0xIAKFvpbOJLb/KKkss7pSWVCweCvuV5hzUGCr86cUw9Hs2irBdVaPMuk2NRGx3SolSsDtRNxmmndi6+F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746889911; c=relaxed/simple;
	bh=EHqn1hF+O5cx1kCcX9b9emwg/l7WZgXjC8JEUTZtaNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QHykH2eJ0sjkmDxyHbpWHYLxu3dZLkTxuF9QL4G61GOOffMRJPL/Wr/fH9H7tmBY6qJfAkj2ObBCyn1av2s2B37zaJoLAduWhQs6LQz/91gJHXluulo2u4h7O0d3eKlVjsLZp84BRAtvmUjUgWujWc/H67b4TtKG9lMnXckSL4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdEkthmN; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdEkthmN"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-30c1c4a8224so2126159a91.0;
        Sat, 10 May 2025 08:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746889909; x=1747494709; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D8V1iPWcqNA0HiKYEXXLEH80k6K3piZxher31w9nAbY=;
        b=HdEkthmNytK0TlKIeXzDeALm0dZDIcu/NsrBJSVLyrHMfKO9ni0L4BiPVZEo0LN2RM
         a/Jyws94XhYa8tA5TFTUOx2+vM52r6dSRjH6+4aoO8VW6ty7uJqBnftyQGCEkhiWAESE
         uyJJ6wJ8/Mw3p/4ktjlx2crfigA3kRyq3QUkTGuNm8nSMh1oECUkkSLa/X+PctR7y8gr
         ropX8uWZSKE1ft3FKRcC+UcARiq7wa0LKSP1qQ93Vj60LxK93UflNPDn2vcTRcX1HImJ
         cdimWv9Seb7OzFj9CL7a1aMlu0TbEv2QjzGfuti4uhPXUiQdl4Op1GaKvrl4UH70CfAC
         yMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746889909; x=1747494709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8V1iPWcqNA0HiKYEXXLEH80k6K3piZxher31w9nAbY=;
        b=gFg2NprGggExx1ia5LQelTQ8b8yWpO9sjXfDBanOmeIUlBxL6IhC3ofFJmjtCNO2ON
         E2kvufqwbwRIFqNt9Zr/fY0QNO/33Pb1bID5wT1HUf55kQ8CvcqQe9VildHJfOAOJHA1
         yGnJRccW2UwGw5HNFQdvDhEUKei3x4D5wtnfW05MemVUq747gjFmkVBGY9c5cMAl+uAC
         BqF78BIDdW7Fi+CZwWFYHfkybanfbqFNkS9lZWkCCAkUBKJOvqawFibgUlq68+fZBeLQ
         VzreOJfPT0cYqJ0X7/K/Fi5UNf+dQfnZt8cdkt4/WIYos1UZ7JEdOwP1TEI9SeSUlrsG
         HQQw==
X-Forwarded-Encrypted: i=1; AJvYcCUHObpIuxIBus/QIwsBahM8wyjT2K9okenznFS0AOEp5yIpLw6TuZe4BtQ/DplS0Zay48jqiayZJ20D8GqK@vger.kernel.org, AJvYcCV1x4WzkgSoP1plE0StzcTARSPFPGFtMsdo/CuoUCU7GzuB3nR0SQtpV3Fa2TX0sO+NRGe1Z670MACfwW8Eyqt9FQ==@vger.kernel.org, AJvYcCWDnyfrXXpuoPIJwUXsgEVH+R6VVKtx/wDkjYN4HtTCeT3R8QP3ziTcvTA5c+8hIFi1njfB2Tw2OQbP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ia0u4Mu8j/lWr8c5hlpa1nTvMI5Xt+ZnCQJzA02/5tJAfE3e
	eGAZHW5e4/duyRBbZe6Nfr78Cw/1I2acNXJoc8dU9E1VE1puoyL1
X-Gm-Gg: ASbGnctsUIaZWED63d6T4HfBps9QBP8/kLJH0wGt/PWcub7WT7JB4LFt+pZzJy0dqkj
	TCn6aQ3103IItDcUF6j+Oq/5X7tGStllOMu2FZGpF9dbzvsRwARurOA5I1gVM8M1OV7eZGh04pi
	L/rceFXJJXEkyao6PDE15PkV4o+QSXJ1VqTtPqUkg/X1L9m76MQIzvghfEkOL14zESuXF4Cewc1
	eoZbHoVxAnfXTLcK8+nU4ExQWxMb8OqyMTKg/kBL+14fY2Q40eN7/fy5aA1ciJ0qzs0P+Woi7v4
	Sj/YZqXDcx4o/PnoGQQjECgyx+qDHn8LMtLEZLu7eU+eyj4sydUxug==
X-Google-Smtp-Source: AGHT+IG+6iuaHV5VMdUjI4NiHZ4ZYI6UNAo/RMO/6rakgw1KRm9K6rCnAM+HbTPpoBA2+u8ionYImg==
X-Received: by 2002:a17:90b:2d92:b0:2fc:ec7c:d371 with SMTP id 98e67ed59e1d1-30c3cafda23mr10665386a91.3.1746889908845;
        Sat, 10 May 2025 08:11:48 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b2350ddca3asm2990493a12.58.2025.05.10.08.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 08:11:48 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Sat, 10 May 2025 23:10:47 +0800
Subject: [PATCH v7 06/21] drivers/perf: apple_m1: Support
 per-implementation PMU startup
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-apple-cpmu-v7-6-bd505cb6c520@gmail.com>
References: <20250510-apple-cpmu-v7-0-bd505cb6c520@gmail.com>
In-Reply-To: <20250510-apple-cpmu-v7-0-bd505cb6c520@gmail.com>
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
 h=from:subject:message-id; bh=EHqn1hF+O5cx1kCcX9b9emwg/l7WZgXjC8JEUTZtaNY=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoH2yalP9EYa1Hto2s555HOXngh1U9zcmMv/j18
 10nML/8yWyJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaB9smgAKCRABygi3psUI
 JFPKEACLAir2vysaJA4vW2/wJNXc3LFvdB6JbUIkeCnNhdYZBqPk1wOsy+4D70Zpndy6fUI+g9O
 pTv4FMrBHZSJGO1gIVgM4uy3qYT8TyQiX88ZGV8TEy7evFYsT2HGn/wmWmnKuXX0kS3ZsFm2QgX
 HqYYqPnINxdvSzgENDCWcqRxaelhXDu3j6EFVS2vIcJrODPFo70JquC+FJHi231FTSkCo7gxuIe
 UsU4DL4Migghp4vlXdFCmrfVCH8YEo3ivJuXHljZ150YJNKAyxV8Orfr7MiVTo1zsiiEeTuq61z
 88CwjDnbGvTwTYI7iFoXM4RHnMFiBUFDmyeKIiSizQSIOxJVjq31LbiXCGDyF2zFKlM4FNnKwem
 7loSz1HSE6p/Ps4RAN0pag2hl9DqPGdmevV9ZrczVaCSK2AkuNdQvw7qSzXC8vVY2g0i3D7xI1T
 hQLUE8XUtC97EkKkUXjXSx9wd3o0IMZO1VWYuM6Br+Q07NCv6r5H4ZTQtkP7+xGzmGskU6/IhpQ
 Ini9u3C/Sm8s38ZXLNJUo42/ciLHuJlpNiKFIogWlnAmf/3HZin/0mFixUTV1HlYIoPnCsBa8aM
 8j7yR4FDBuKbScHabpHy2go+ai36DU1SZVQSJCBLU3ZP4NErrfSoaXyKV3FYwNiyya8yXJZouR+
 2JCVzmaTrq26L+A==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Support for implementations that deliver its interrupts in ways other than
FIQ will be added, which requires a per-implementation startup function.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 6736909a7df672a08938a392d450dc9b5b7bce9e..f4d8da4a8aa0c197cd16af422b33f4cd943d379d 100644
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

