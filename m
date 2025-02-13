Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE31281349;
	Thu, 13 Feb 2025 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457386; cv=none; b=lQsWmRNQHBoowDYEPH88UYRnjEYJ3oQSvmzzVvIGlCUkE/LLMJLXBf5jG8+lqpwsixzv4u06EexqrziNCUDYCY05U2FnteCI0c1uWEy/Ugjieu277fUtbONqlERxmn9ECA7yYxaTRQEsGbAH2IRA3Ys6aZ6wgl4iANWjDTtB+aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457386; c=relaxed/simple;
	bh=HlJsqhb8XnHHNzy8AdqFixPhoif08uRtRpp/JRim2Eo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CABg438vIZ2haBzrgub5Vau9c6QizHKwIxgax3KyHyZF5E4CBjdggSTZFWiStBm5nXrMaiJuDScw4AkhgmK4ofWelE7bWb+K/E8CCZ1gJ7Rzhkjo7F3VzIVqUI9pjAOK0JJD//qYluWFk5r/MriFENfGIpsGcUoquw1rLxuDKc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2GDkk8h; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2GDkk8h"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fbfa8c73a6so1848789a91.2;
        Thu, 13 Feb 2025 06:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739457383; x=1740062183; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7s1AnEsbDOxMifWlKKO96YvdNulNwpNMwNrlUq5WAgw=;
        b=F2GDkk8hyPSXXPEh9mkExKzdjCxo3/SXeC+htdQqqZy5+InDSabOcB7yMLKPkfiOTq
         tdx601pqd/TGxStbhiKtWlpfr9HqjgNY+U0kQKpiyjBP53hz3uWexvC3x32GftlOEfLY
         g7jHxXV582zxG3i7LhxJ3QNtcTNQdidnqpBgJ+kDzvtL7IWbem1cGdVcENqQhXs6JlYz
         V99+lWEoLShlvd+nXFWLjr0DwCEaK/YnGoxlg3e2eol3MwaGXD2mE8AaOZDyNFZ1GISB
         P+/2dnPK+DxgkAMm/agFGVQRvaanbkqPXL5vKpNksX7D2ca6ezFpHoTw91gExMlI7wCl
         HXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739457383; x=1740062183;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7s1AnEsbDOxMifWlKKO96YvdNulNwpNMwNrlUq5WAgw=;
        b=v8yGn9KH/wCGgLY3CR4gv41Vm1wK3VOUbb6hCBPJ+dhsm3Ftu4jiPHl3NB4MoZyp/g
         neWPEANwiQ5rwDueBsvWa3gKzXICHwZ102m8KF25PO9lho7NctgGmlbNvSvIh0KoCqpq
         bS/rh7DbVoLWN5OpeO6sVdF1QTPvg6+3pjK/hSHWFkUvlbSmY3HzoM72XtAks4niLT5x
         4/PN3KcaeP1ddGVHjelnpU02X9IoCUtL3K7iCcMikK5m8mPn5LNg1OezcqJBKiffAf7G
         RYxfSnn5KK/qBO7jfHg8JZ7s7KJA4oTP7FpTSqK+3EyHJ8cmPJDQbzglVrSRC9is+eh9
         Yggg==
X-Forwarded-Encrypted: i=1; AJvYcCVIJaZVeG2TinyY32Llydisdie/f4/NlFZ3/DbBi5yzQLyfKFDz4RDwJJ0oEIgxt9/SQ/5lYtEInB1QfBOiN7Vj2w==@vger.kernel.org, AJvYcCVilPTfdOoHDMQmMDeUtukNYguKGsAjNyWBi6prKood4L9FG5um695+Xo4SuJlh0GQmMqNd2DUSnLLQ@vger.kernel.org, AJvYcCW0Zw3oZqqryuH4Pl5qa2jbifCor/hhpxWaL25/jSRpspKUhX2vDpK0H4p59vxdkVZ3RAr5ncv0B+Z6T7dT@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+GxPSlzo6yFl5sddEt7/LV6+jHkxK35wfTaSZJNmrklF/d8zE
	3e9U6Br9jE21o62wTSxMBeC6hqWzCdk8ISRuAJAn/hqG+BXZzfrB
X-Gm-Gg: ASbGncvYcvMUpqzmeGpCqZSFJr/rizu7ERZyLKHXdD1fYvPz2598eyrRbpYaagzU5yq
	19BoizAn3m2vb4/fyxYoFQCuERHZPYJy4JtLUyJu7ta5QXWGoVlGvTZl9nMHr8yVKg4oqh0RvuC
	7Cwqe0EWwouUvB0yY/KFlEKpEtfBFY7NCeki4retCK8GpT1fBDk+JfZSO9PB+loe+mVLEjsPXhq
	koJFytUsLmm22XHo6G6xwWCBvYYiTEGwxgYfoC06jnH/POrl16Tr/kEE5trBYHgoK1He6pI6gKw
	gyWLsGu1Ney1r6MWMg==
X-Google-Smtp-Source: AGHT+IFhfs9TjAcjn/ErTnxMN1WJfk7JOQCk0pFIocG3OaK+NCISwQFpuudm6tJWQ1iLr3j32Tlxow==
X-Received: by 2002:a17:90b:2c8e:b0:2ea:712d:9a82 with SMTP id 98e67ed59e1d1-2fbf5c71357mr11037562a91.29.1739457383189;
        Thu, 13 Feb 2025 06:36:23 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2fbf999b5b4sm3655165a91.30.2025.02.13.06.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 06:36:22 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v3 00/10] drivers/perf: apple_m1: Add Apple A7-A11, T2 SoC
 support
Date: Thu, 13 Feb 2025 22:36:02 +0800
Message-Id: <20250213-apple-cpmu-v3-0-be7f8aded81f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFIDrmcC/1XMywrCMBCF4VcpWRtpZlobXfke4mJM03agl5BoU
 Erf3bQg1OU58H+zCNazDeKSzcLbyIGnMQ08ZMJ0NLZWcp22gBzKHJSS5FxvpXHDS5ZUEtaE50K
 jSIHztuH3ht3uaXccnpP/bHZU6/tjYM9EJXPZaFM1QEZVBV7bgbg/mmkQKxNhn+JfCinV1QNP6
 oxgtd6ny7J8AfHpc4DfAAAA
X-Change-ID: 20250211-apple-cpmu-5a5a3da39483
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1988; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=HlJsqhb8XnHHNzy8AdqFixPhoif08uRtRpp/JRim2Eo=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnrgNiM5TkmibLzic5zEE81YsjeEvk1L/dOVFUD
 dU7mRTs/A2JAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ64DYgAKCRABygi3psUI
 JKjfD/9mscaarB494OgyW4uYq1QJXorP6V5eRfYcimmfTN9369PcFCxeFReuiEaPK98qUT+2YF/
 CBI/e3iAMHFZI3YcOgVE7ZNjBuYvLxxaqFPqhxYQRcJPG6MZZnZFDuT3tdL62Ue4NEGdDYeShaC
 Er7IK91opJjC6qqaNrprt2d2GkuStvOK9TbZLJh+/OCVJSXzp+TsSzLurHBWHm/Bo4lpPf5RVhJ
 oqXinanCkSZbovdZUJlPb+q6bpge/+kNpLSsc3/Zl2tfnz8zNXpr8MpPj8MRKYrwITwRKFnvDSp
 uFNecTEscCTbURrjoFq34VMUYACEheQlq2v4AkOTA5jLpMWp3zmcayTEKsQuY98vBAvcoGeixiP
 dhxsIKSMTSmEKPwNssoRtrdKMJCGKVSNlZP46Uxp3A18p6W0VOvQ7IMhvQBZG/B1px6CcXxD/di
 rmCB3ispE2rueghdb1CgBCIK8UVdXYY6HCtFoUtKQBs+o6BXPBMMr2sPLIyeKQ49hs8fj9vH+FF
 DsAn8Sqdm6Uyj0aUIxXA4eoiuOuc3C16QyvsL6IG427z/oEyGqEr4z/K10gkY5ZtWHKjfm1wTjX
 3M/d+NQZ8VCscIuB52fHn2zrHmsx3o9RdOLquraPTzyiKMto9DQiU2D7HV02uq2wKe6INiUl3vu
 hC1DzYdr7M/KW5A==
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
Changes in v3:
- Configure PMC8 and PMC9 for 32-bit EL0
- Remove redundant _common suffix from shared functions
- Link to v2: https://lore.kernel.org/r/20250213-apple-cpmu-v2-0-87b361932e88@gmail.com

Changes in v2:
- Remove unused flags parameter from apple_pmu_init_common()
- Link to v1: https://lore.kernel.org/r/20250212-apple-cpmu-v1-0-f8c7f2ac1743@gmail.com

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
 arch/arm64/include/asm/apple_m1_pmu.h          |   3 +
 drivers/perf/apple_m1_cpu_pmu.c                | 779 ++++++++++++++++++++++++-
 3 files changed, 756 insertions(+), 32 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250211-apple-cpmu-5a5a3da39483

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>

