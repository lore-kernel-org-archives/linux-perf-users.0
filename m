Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B948525D55C;
	Wed, 12 Feb 2025 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380997; cv=none; b=SgLVYbw0g3QiCVu+W8yHh0Xg1Mq/ntjY+sySL95GKV22TwN7K5Ms8rrNHYCeU2VL9n6XO83DZSPafJR4Y01tFWuGzjcJnRfE95VJpAeDzKoOImk2oHRDOsh57Qor9Jtu/d1tu52rgJhqOc56rav978KLEvORVF2oJe4hdR78r1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380997; c=relaxed/simple;
	bh=/4qXPFHVNQhhoJUabUe1xtQ/R9DQ+Ipv3G6eXZu+6Qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=biauqkGSSc9p2oJCtsTHnUbEiZxKlA8FL98G5TeGcQ9BeBUge3/tIKB84m75MGh+j+jiBaPlok14sIFYUl6x95I+xbb7V1sUTeFf01uWeTkoXLUnS0GHVvNFUpNDPgTM67k4mBVCLiVynR/3XoUKkH8IFhvZYBwXhRLdQYmmkGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ro+OnOUr; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ro+OnOUr"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f6a47d617so82170525ad.2;
        Wed, 12 Feb 2025 09:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739380995; x=1739985795; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5yMYPtbWoioljIi5CGJJ0bbQtImjQrSrLugDRy/Wgxc=;
        b=Ro+OnOUrXrzvAJFINc7WFrTWwym+2nbOXyCNpMOVwWdetaD2KJRmoTecqpoCPrGSR1
         LGCTCTLvr22u5r7GZ8V+VNX+UqomHErg1a5/CBfSqlYaOSthG2dnIBwpGt1rXLEpdTi5
         gcQWQ9y0NMJYz7OuK+CC4P6L3PBvDLEFDYy9Q9rFmHgTA60spbja8czxNThwaqYrQXFg
         tgahA/O6qkiWI7uDzLKR3N0Mny8fcDYh5xcByPSyu5GLedB2iFEgiA4BlC9k3gmMGpO4
         mT/xDUwnHG8A6eK5qYqaPAqbX9vjd9J6+CGdJYIx2cGyV/zMc4Z3boP/xSPpFgk24fso
         DRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739380995; x=1739985795;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yMYPtbWoioljIi5CGJJ0bbQtImjQrSrLugDRy/Wgxc=;
        b=uOz5bDTzi7LWugRSAwBhXn0CN9WHQiJaG8bqREXvgRzUZBHSlsrGBNjZgHxDp7YsmV
         T3HliVMDYPlgewZGvQGet2UE+miehXbm77QUsL4Q4nLFnvtQbEvLUlBtpaIcZpIOu/zB
         948ns4HaD3yQg7ycEhVT4Ahp3VQe3h59yqIgZJ8Zjel5yXcf55Esfc4Xv7XNyDOx5Tpy
         SuDOzdMAaWsX7GmIfQ6MK7tRzR8nSpmFPd4OaEeUbo/8QFsZZVYa+KlpH1UOgEo44EBA
         RtSiUmH/ifU/I2DxBXHbmswhH8lDd102P5NfzSbeEpOvr2QxruMusEAc+PU7DqaIV/Y8
         1kjw==
X-Forwarded-Encrypted: i=1; AJvYcCVfvS8cVmu5oPt9NRkAbSuuWB9rDQt7d8EuVS9Oj8ywkt56hOrSEQoKNEebtfPvZLV0PdjxIr8cdCwXMVqT8CspQw==@vger.kernel.org, AJvYcCWO5TcgeZSjoySbzNLr716xDVxYUExu4m8ZpnyK1ZhJmk6oBA+YgDGHBL5fOargbT6EV2b0zaWJINc7IuIN@vger.kernel.org, AJvYcCXbO9wJYMlXmzsXBI2UIZdAOnRuXn0V0Bmesdo/PaANk3vNzqC/SbNyK+oHGu7WZvP4j9GhPPRH6Sal@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8xAG19pqV9KD/lRM9MSPGUZyn3LFF2w7erR0mrA57oadYWPsW
	x4mtfA/75kGFL9l3CfM9WuQAJ1gp9PBEC5aWM9C28BzmlvcD6+Av
X-Gm-Gg: ASbGnctuUGbgrkAXtQV3AM+xK1TRCJi49SMXmk7craA5EjhH4mwUBnHTpxECsCZJZy+
	8cav/dR3zFDt8k0vJY4aUskpBRdJAn9w6pFszcx1o2VFQwbVWZQIdXE0EpRRO3lVEh4q20Ho81n
	xKE9SZ0zWCC2WaIC24qRxs21y160EvjFX6F7n4ZGLNH1ZxjtOkXSRCpfUIi3XC6wZcR1b6TWqxF
	nVphkgk+D0D7IyXTbLtXTN4CAAW1ZiKmW7k0yiHoPgUP/8H/3OokrcilKDYqQJ6sOMgdL4TXDMM
	49KZnrxC/kE5OQWDvg==
X-Google-Smtp-Source: AGHT+IF9Hqg1hDtMETPcTVQMDIUifIcDM3rTf0I2IXiMK50CYiFNlKKpQ8vQz3ex521MFyS0zANQ0A==
X-Received: by 2002:a05:6a21:6f10:b0:1e1:bf3d:a191 with SMTP id adf61e73a8af0-1ee5c83db7cmr7106147637.33.1739380995098;
        Wed, 12 Feb 2025 09:23:15 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-ad54f1691ddsm6001705a12.61.2025.02.12.09.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:23:14 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 13 Feb 2025 01:22:28 +0800
Subject: [PATCH v2 05/10] drivers/perf: apple_m1: Support
 per-implementation PMU start
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-apple-cpmu-v2-5-87b361932e88@gmail.com>
References: <20250213-apple-cpmu-v2-0-87b361932e88@gmail.com>
In-Reply-To: <20250213-apple-cpmu-v2-0-87b361932e88@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2211; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=/4qXPFHVNQhhoJUabUe1xtQ/R9DQ+Ipv3G6eXZu+6Qs=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnrNjwdQLJ8DKd8ePzg7bkvfftYg1GlHSWGLpkf
 g+nrc1zB+uJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ6zY8AAKCRABygi3psUI
 JBfpD/9guHkkdm7MB9Lf6dTLwpTEkIlSUVy2My1ORooQxfsc1CRRCjYApVz+pI1XTsydkT535XU
 /T12u8brSIgFHOpgmGXTvedcWQL7JmVEvbRG6i6vnN7j4ymwR/V6jgRIoamXh9AAAf/n0Dteret
 N+3WguwH2fqY+64yR2/PYkJwSuyRxFr2YiY+Hqroo67BD/bXk0RMSqTfPkmhYu7bRMjPLeRrkUB
 6SOsYDSnwFuVbUSvv/LJZHAqsYAsXL5RLQUzDNTCszx+xIpr2kFyWrm5S8x64xVVaKOJSHPAi/M
 RvFyWP3s5LWfgy3FotRwZ2TyQpl2Ai5FMF+Yv9GJW5Bv04h/sAWwfGfmJMOAFSF7wIcWw02GP6b
 rQ27MB05ApxpnGE6OU2L2PbwZYD7JqqRF2UqueCkJ2kDR8HtO6c04u6p+7pCBMbtms8uulLdnPT
 XbhywTNKNvja6+5Bz0etrJ53Z0ZzRGnNMuvsYxpWA0cVLYn/bUbzZaPk0wAQo5PkFHwk6Ml2JLc
 HtZU7z3mb+94BJin8Y5EgcCh7DljwnubxtfSOav9jdEanL9o+8BwX1SnWROQ7jYQH8wK1A7/GUy
 Om9J4NzuAcIu9EPJyDk64ZQQMMPYhSwXOMNojHc+nnLXiV9Rh96SQk/seTbLBuQpzkgrELVsc2G
 SiqiRMKS6aqAO/w==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Support for implementations that deliver its interrupts in ways other than
FIQ will be added, which requires a per-implementation start function.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index e7b898aef45e9e18899693774ad673fd370b19d7..12eba1075b36768afc29e211926331b9a426c54f 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -605,7 +605,6 @@ static int apple_pmu_init_common(struct arm_pmu *cpu_pmu, u32 counters)
 	cpu_pmu->read_counter	  = m1_pmu_read_counter;
 	cpu_pmu->write_counter	  = m1_pmu_write_counter;
 	cpu_pmu->clear_event_idx  = m1_pmu_clear_event_idx;
-	cpu_pmu->start		  = m1_pmu_start;
 	cpu_pmu->stop		  = m1_pmu_stop;
 	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
@@ -622,6 +621,7 @@ static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init_common(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -631,6 +631,7 @@ static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init_common(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -640,6 +641,7 @@ static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init_common(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -649,6 +651,7 @@ static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init_common(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 

-- 
2.48.1

