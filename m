Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D293250C0F;
	Tue, 11 Feb 2025 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739290093; cv=none; b=BzGi74MDwvIYt9LWwP3X0umH0C5ZBj2nE4qOqqGfANHjhnb689Lq5jo32vRwlhVwj6kV+Yrsbiint1d+XPGlr0cbv1Fw+mNYpY/c+feMHYXrUjyGUnPwPiCkTN/Z0zuNVH2neFSuLOvhZ7QNKS+fu7NuJ1c7JpUXohqqMC/7/VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739290093; c=relaxed/simple;
	bh=LhWKPpTipmLEivaGN54U0rIDOOw1aCiRMd+yRoDvpMg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I4KmLIj0oD0JCl5b7I9zcoEL4ooz9BbW9mLedHO1tYYHQkBO6ekZCLv1V+J69Ior3JaUvaT6uvPuLyEPgeV4kJYS0S0k7Ovvhkn9A0aZgQjOYfqUB7KKVFfqS5LWAZbowiLKEUWhKgFLMtnOYZ9TFr6+Rctd+IumvoPA/A7EvnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e50Sf/CM; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e50Sf/CM"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fa2c1ab145so7766275a91.3;
        Tue, 11 Feb 2025 08:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739290092; x=1739894892; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ixc1THfJdnAMw/BKiEzGtjmAxEFef8cRNT447pbK/8=;
        b=e50Sf/CMFuXpeUqCFmoEjAROcxE3FkkjGtNlglBzfX8dJ5yaKoCcoDaD9RfzUNfeIY
         /px8yvvj6Z+XUh4EE7pNCnxJit7gmYRpF2mSFuPKDkBXLY5Prn6p2XyfM2UQZwIEXJ3S
         +yTNz1O1oZFeEDVI7yVsCyCxEHiFU/MSH/uymgFcbD1zHxb6qrng7Lrm9vVYZmMty6lY
         zD/3freEzr/wpEzE6cAVQJzi7YCwUm5ZugiHkPzn44dPeeKs+cji4SdxlqsSktSunkZn
         MB1UHR/CWz0LAc5vu4MsXYIYnAdVtnY9e74Ig7ywzjPeEv/ayGQFRRtg+fzREjcGqeFl
         ivmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739290092; x=1739894892;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Ixc1THfJdnAMw/BKiEzGtjmAxEFef8cRNT447pbK/8=;
        b=QjQH5t+M/uL367/JBAmv2g+vpDufQoiQ2TqZ4AeUOEJOKw+q7nqX/XBJ1r7f0eo6wj
         TzTb6ujw6GmUG05OXSREWucCwgzLUkmyYq2EYtux2L5nXFgfBV+X/LVg7kKpF1aYfQNM
         tM8at9c8DNOPtwJQzxjYT2cFLdGz2O8oFQ2CPzjkGEM5oNR4YWkZ5CS8a24h01+IPIGz
         l9FbFGFNgonkq7qogo9fQrLvXlFUWr1Tt6NGd1Bv7JOKHCb3usy2kqzBH/AdAK4rwWQY
         uTOmoWoQ7MI7SxmndY7o84Hq2avG536MtHeSZNMEAKNOz8QP0mToW++UrJ2rXoQGrjk4
         7VGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4aC4dQLwZsgYkqUSjXPJa19BoT9KAewfv+6zhZHCOAG4R+l+C7QDkdtqfv1RWXHabtCk2N0iAgKJ975C3@vger.kernel.org, AJvYcCWxzmcA4MeyMjVjMQ9uwXdssZXaYJhq4tQYyocHDI9u3LAmG0sViGaeILidMik9xNSCQwDEFPJ6AII4@vger.kernel.org, AJvYcCXikp9v4g+pWs7ja2SvhCu2g75WsHr/cdAyTvRs+GdPPmo5+FAcLUzdJu7K1vKLi59dW9PrJ0X09Y6C64SAxnsEtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCZKmJi98JAQJVFHnI6M2cLbY1q7e6cb59Mwkj4x+YBnZFO9SU
	WkmuKZ+CgYosXQTyPuVMojmGHXcwuqFS1mSuWC9YP139NRaOaTK6
X-Gm-Gg: ASbGncuPd5KZAERJHsx9BLa1/f6dRd1E2H8bdoR7clHAttIAQx4Y7MQ0osvnYT9QgDj
	sIrtD4bP2FeEQPaD4If10RXcapZr/i08wndI3bfFICyoJ6CxIm0TY8SIE0xcNeE0iEkaTT/KCY1
	eWX7wq2d5LNhO8EtjNVzMtgYq6JKWN44VsiwbqBt2WKflwXblRFHyrp9FVZhlP4s2GroZ+wZW3I
	taAcDffZncRg9cMk8G/BRWLT5+pGDE/6AuNkjh1WJ5cJ9EGcNTh89XA5XYCy15aleDYq5XulPxa
	FCn+dvvPPQpQee4LYQ==
X-Google-Smtp-Source: AGHT+IGUgRw95Xr5p5dnLjRuf5lW7GFqBihDMP62NQd8lMGS3/Oqusjqad+1bvDfuQDFoX5VFLQOqw==
X-Received: by 2002:a17:90b:4f87:b0:2ee:d63f:d71 with SMTP id 98e67ed59e1d1-2fb63d16655mr547999a91.14.1739290091498;
        Tue, 11 Feb 2025 08:08:11 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2fa618e5e18sm6040478a91.41.2025.02.11.08.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 08:08:11 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 00/10] drivers/perf: apple_m1: Add Apple A7-A11, T2 SoC
 support
Date: Wed, 12 Feb 2025 00:07:21 +0800
Message-Id: <20250212-apple-cpmu-v1-0-f8c7f2ac1743@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALl1q2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0ND3cSCgpxU3eSC3FJd00TTROOURGNLEwtjJaCGgqLUtMwKsGHRsbW
 1APVHuVJcAAAA
X-Change-ID: 20250211-apple-cpmu-5a5a3da39483
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1608; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=LhWKPpTipmLEivaGN54U0rIDOOw1aCiRMd+yRoDvpMg=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnq3Xhx5X5ZyZ9c0S7S8AqLAss0fNOYSurIR8iI
 1MgMsTYRqiJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ6t14QAKCRABygi3psUI
 JKa9D/0ZvnMJNLT9eidZ6vnHegswqc6/yypIZuzVV8rtSBXxbRzjGJ2KkBj/IQj+mPZZxNMjee3
 K6y3uflppl6Qk0nqnxz3f33yIT2zHfqbaAoupm9PZNcL2dKtKSgxv39VlhPOhXK7jzEtI9Hojro
 iFBcgFdET7U18wHHHaQsOZLO/t73mlZ9i3rCY+vOnSj2KH3rA/r47XNRvLhWy1YUuqPsYAwXFHU
 domqHN9pWbmcGQ/LEmW5vGmUUNXGT7YWhw7Sqy0/QK+i9LkI98ZeGFuQq0ux7JdXgtnFjzWcxJ5
 J58yhkWb6iKAztnK4Ize+k7BvofuhKI9r+8FjGtWz3VMkGESsOyDGA/RHLoBYQUj39dzm0aRU0m
 0dYlnRE68z7spsqs6d1kNelPcwraWYZY89hSEsN3KSHtAlVzJ+DTWrjzHBNvTbflHW+69I0qE8U
 FANVs+jYI7ZHnYrQdoEElMUCGWDDMWPymyYkeoD5YMauWBY7jc9I1jlJwIf8LeAabu+g3fgynFE
 soGVzcH9PLSSs/lMTJ6pY0enYGl1MabEouv0/Y4yX802RgdNm3laJTYQQclq2YHgx+r65IgGj3R
 +uzd+B2sylPAb5mKouwjhM8X0UXGxCRjiZArrhYKU8rz6lPdWhJmt7NUjTrlJUKiPGOPLvrSK7r
 fnhYnkPHdiYs23g==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

This series adds support for the CPU PMU in the older Apple A7-A11, T2
SoCs. These PMUs may have a different event layout, less counters, or
deliver their interrupts via IRQ instead of a FIQ. Since some of those
older SoCs support 32-bit EL0, counting for 32-bit EL0 also need to
be enabled by the driver where applicable.

Patch 1 adds the DT bindings.
Patch 2-5 prepares the driver to allow adding support for those 
older SoCs.
Patch 6-10 adds support for the older SoCs.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Nick Chan (10):
      dt-bindings: arm: pmu: Add Apple A7-A11 SoC CPU PMU compatibles
      drivers/perf: apple_m1: Support per-implementation event tables
      drivers/perf: apple_m1: Support a per-implementation number of counters
      drivers/perf: apple_m1: Support configuring counters for 32-bit EL0
      drivers/perf: apple_m1: Support per-implementation PMU start
      drivers/perf: apple_m1: Add Apple A7 support
      drivers/perf: apple_m1: Add Apple A8/A8X support
      drivers/perf: apple_m1: Add A9/A9X support
      drivers/perf: apple_m1: Add Apple A10/A10X/T2 Support
      drivers/perf: apple_m1: Add Apple A11 Support

 Documentation/devicetree/bindings/arm/pmu.yaml |   6 +
 arch/arm64/include/asm/apple_m1_pmu.h          |   2 +
 drivers/perf/apple_m1_cpu_pmu.c                | 776 ++++++++++++++++++++++++-
 3 files changed, 752 insertions(+), 32 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250211-apple-cpmu-5a5a3da39483

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>

