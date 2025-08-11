Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4C725FA0E;
	Mon, 11 Aug 2025 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920551; cv=none; b=bUZ3qMJ6MWFSOt5/tscVFqogXmgV04tj1PQk13g86ctoPP2s/MpV72xikMfHszygUsDhfbohFnpYy2n8lAcEOOhAWuelmK6IignF2yXlpuJPQXPAdYmqUIPk9474vNksCLnp4+tw1IZJkn8+n2AKqHjylu0PivKgvs+3MMJbdQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920551; c=relaxed/simple;
	bh=MBYkOMp8zRY3vG74r0/6XW89V1iPdN6l9V1/vB4q2xk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q+zckk0rw/llBonrVg/85fUqPm8eZJbnJS+8ERIuqh5ySW8QRn+4xKiZpapf0nicT3EuuTnNf8Bu+tv5B9eD+lkUxKvPWSn8ZP0qjQBchGcrIUMYCz0dht22H4IbqzxC10yFM/xzR2jK5jFnZIlg5b7ubnklFc+BqC8fK4z52hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LS6E9+vY; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LS6E9+vY"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b429db71b3dso2845421a12.0;
        Mon, 11 Aug 2025 06:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920549; x=1755525349; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/mnOzr3VUFjAXVfJVKgy254i42mcNI9/0Eo4cq3orc=;
        b=LS6E9+vYvVX9nFxN6KKq9SRrkJ+yKma10g4vQnWb7X/NRKC8cTGg9o8QxifuCgWCir
         KD1ECAkRsRILvm/X33LPD8LC4RkjT66fJggjlfFI0NnxihnSihKVe3WSAYaHNyGBc4Qe
         2KX6Rz9TiZwj31VlULkprg29u64z/GA08Onmyb+QIbDlebgo6gWZQifGIA/41kuJiUWt
         hmjYFmZzx3iGmhdG3nDlM+RPY082GuPQBKaVkbxlhhRigvqmg/UcvCc0tybcbd7xiQlw
         9AU8W+bfWKKyIxRqda+mwWT4Bhz/vjeBQoAVatpqLrXyVNYJhH1QyE0lPmUpo1OlWVMQ
         of0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920549; x=1755525349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/mnOzr3VUFjAXVfJVKgy254i42mcNI9/0Eo4cq3orc=;
        b=SrfdINdoANuYE/+7fSsWkzJp7kPlkG8wWIMgSjHxIzvc8q21BWblNBy9n/6HKYES5i
         E2qU/fmd+lD8KhU3svCZAge0BAn9wTGRHjZeoAf8ZtWdqItJy8ANuaANqgLZBov/duF7
         uwJalteN+OsQOx96FGIdZP+IkSWIsd2Ji8/gIHYXGS73FhMweQ5/ffIGQ/+fug9TrwxC
         7liE1oYZSZvlEb9GuiLPOG0Cf1bL7Yr/e35WZ5DLvuTd2iKAbJVu2P+6uW9VWw4cUVLd
         uMl+VDVCR0/J2+sP1hpu7kURMBIvuNhit4dQXdN7UqbuYCH6+sRtS2KDtCEaD+E6kbi5
         +zNw==
X-Forwarded-Encrypted: i=1; AJvYcCVSq3tf31ouuX6uihaftF8NvSAf5S5wIuzFS4SYA3CuYJ9JkyewQMgzjMux3a93sNJfj6AZXXcOured@vger.kernel.org, AJvYcCVhZxfO6qQFe97J+NdccCJHagCku721bdoFzDKho54qwDlxP48qSshcBZ/8wyKaDOjLAoAmBIHQzC9u+ouP@vger.kernel.org, AJvYcCW0IGNO8lQTU0iX3RFG4zKvrTh1S/68ht4hMbql3Rqa+r+DIFme5KHORK3jXHRc5rkpJwgB2pMzvGpYTFTfDRN1JQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtgy70WX2wNjTOryt9sWfOhGSGd/c4KmhMwX0Kp65CIpvI9kF2
	614e3VAzl4+2wMOrKU+7JxsuRqVQdCCesmvwCip9jtWOsCbSwdKTdk34
X-Gm-Gg: ASbGnctTR86pzB9CUY9k0TyAbSn1qSA+0eNOiPAy37DA73ZbAtBwcJ10G/YWEBntZGJ
	pHUJguyM/Y3fc/7+cp+O25elviNhVNl1JZa3wHhoNKL32VtNRsPiQUnhYtiUyMNGSI8JJe8A6A6
	tw/A1hBkEyU1wEsKgD90AhvXlKbLL+L9apN3OExAPMgr7BrTvBYA8Wa6AX2Eag4nezquGAp+kQQ
	BfVNYMUmh+6lnSMSFhoIIkXfctns6zgfLe0E5y0h8RcBSpzIT1MC9TjSETjfATYH+jzkYV1lmRH
	EDwOJA2aA9YDHcwd7z1dhZP38TEAhVHbXET9XVmcom8koqShBu9PVcTCAc5u6oA5lI9nc8JgNWP
	Fe79a1fRYMrwUjv9p73ulLYmnl3tHCk9TVpKWDowX8kAX4Whft+3lTCQbVQ==
X-Google-Smtp-Source: AGHT+IGcGOQc/b1r6JOl0o2juyTRwQNWPtFwlqjVOFrEFp3jVQx/keXJWe93BPYVrzH0bIv448I9yw==
X-Received: by 2002:a17:902:f549:b0:242:e38c:89db with SMTP id d9443c01a7336-242e38c8c3bmr77391645ad.35.1754920549020;
        Mon, 11 Aug 2025 06:55:49 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422bb1133fsm23585496a12.56.2025.08.11.06.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:55:48 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:54:38 +0800
Subject: [PATCH v8 06/21] drivers/perf: apple_m1: Support
 per-implementation PMU startup
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-apple-cpmu-v8-6-c560ebd9ca46@gmail.com>
References: <20250811-apple-cpmu-v8-0-c560ebd9ca46@gmail.com>
In-Reply-To: <20250811-apple-cpmu-v8-0-c560ebd9ca46@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2178; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=MBYkOMp8zRY3vG74r0/6XW89V1iPdN6l9V1/vB4q2xk=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfZBt0TVBcxz/c5qr7JmkQBF5U88g5YmXrAFU
 387FXSG2faJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn2QQAKCRABygi3psUI
 JMdqEACWf9cYzVRAvPO4kE63gH5ewqMqVwB6jD1J+tfwEiXp+Fr7BHWs67QTeMB1RvNG3dXs+zx
 8LYbi7RNJ9O1fpDHGdrxl7GREHlp3U7Fc1GpP4OZJS68TxsDbB+tPSy/i6lGK1H8E3zJvQ1LlXu
 Fl/WZQI7Qfx9lR5WoTjeV3PjAGmCWjj1Kvuw9tA9ortgG5KKU8uST4yxb/hwdTIJiRFoz4rwQsB
 oBuaimMRGBFV6z2vC7N+B18V4+kOFiwLzl5Up3okjP0C4OcSMA6W8kBrnQoVGHnjHr//s6cmSBT
 4woRXP0MQkbu4ueQhA/fgJCub55EzKWfxIA0IgdmE9xHoj5mrVIsAt5WiAHiSgSXqFmO7AzqJcT
 fLgvZZJjddkfFJTsvGZ0TPOeUvBGOUcK0i85bpqdTpd2E9MdFBNxlrtDwmny1o6oo527I/7msbd
 3nWgozb0k5bRBgQgadcrYHbZyWSQY8GdCQJEgpe86+uwMiLAR81Xn5SVcaRHz2ckmixDJhNTIqZ
 ds2iEckJkQVKP3BW/Dp1ptrx0n4SHqi590VzWSRdCSOjIXuEPJd17F1uFU4u+aBsS7C5KFmloed
 dGG8Eg1ZZmZZYfHmtNXIPpK014nExmv5LchT02piUGLTv5xkfxsNgQlnpjhyN4Uep2iZi0lOLtV
 5J9LY8BGXyzbHTQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Support for implementations that deliver its interrupts in ways other than
FIQ will be added, which requires a per-implementation startup function.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index fb2759069fe9e47146f0342fa46e40f3ab836926..303c0e62432281e899a33fc197365c70078d6ac1 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -659,7 +659,6 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu, u32 counters)
 	cpu_pmu->read_counter	  = m1_pmu_read_counter;
 	cpu_pmu->write_counter	  = m1_pmu_write_counter;
 	cpu_pmu->clear_event_idx  = m1_pmu_clear_event_idx;
-	cpu_pmu->start		  = m1_pmu_start;
 	cpu_pmu->stop		  = m1_pmu_stop;
 	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
@@ -681,6 +680,7 @@ static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -690,6 +690,7 @@ static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -699,6 +700,7 @@ static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -708,6 +710,7 @@ static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 

-- 
2.50.1

