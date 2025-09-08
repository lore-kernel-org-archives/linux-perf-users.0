Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA13621D00E;
	Mon,  8 Sep 2025 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325645; cv=none; b=aomyke7qUYFIYWouK9qttQb4qcozob44F68CcoCEfOpziIJmAjFq5izpSV/vB8RJ4lVQyOn1ERYJcPMIVPOqxdd9YzAcvfGJ7CIySSLNydu0TDx6ljism61PnxO41VCqqbKenl6q+le6aOXU8Zk3MWWJrL7WFdP2deKMOj4SmLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325645; c=relaxed/simple;
	bh=+LAKu174f1xhSbC2VdiHkWIZYXz3wYKQPJAQC4FzNig=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pTGyTYkkQdPJmQx8RbbCby7+G7wkkQ7U0NSPj2nMaPElY++xl8VarNdPR49/grD3nOjPu4UjvduI8AQ4kKOIp9sslHQtP4I7ufRBEK06opw4jDcCtX9RTQ5LEHjJC6pAVknc7VEy4GKYLJVLgyjvur2SY/5fMPI0VFIV4JokClk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChD04QDO; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChD04QDO"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-25669596955so8195515ad.0;
        Mon, 08 Sep 2025 03:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757325643; x=1757930443; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8imCO2VyYcb1j5phQLrLVVRIepCgCLAAPrEPMDTG34Y=;
        b=ChD04QDOBXIX6C30fshnpAVhG6EM1WwqrUrFiDqB6qsBnUzTYl/0KwSeifEP1iTxCW
         1eCf7SW1x+1x1Rof3gPA3tzCrHl+C96JpMC1kE72foMwh/5Tr32lTpqn6cWxIY682h0U
         Bji7WNSKkVbZ3m96w8M4p06RHEdjKMFKTM+dPjYSCgq820MPJ77ed5wcUxcdVRbmbu5Y
         epKmuhSEZ5S5cpTufNsSHnSvz7KCBGFj5PiJA9VSYftKoR5f9L7Xd8W2bS4Koa6kl5TQ
         JXEsV9o4yTlulqrcDt9lL7kvnxO3M1cJTYUuYA2Qcru+6XCxWHl0i8zlDVbtfKlysXkK
         O8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757325643; x=1757930443;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8imCO2VyYcb1j5phQLrLVVRIepCgCLAAPrEPMDTG34Y=;
        b=j3ijoV9tfqw+CkFsaOmLWWCjUcNkwMAFmdsy136n4N5DYGOptbBbzW5hLz02O3kF87
         a1VkXf411zpUQ5sBNkL7N/oaxXeyN2Rj/JXQJSNyZ3BtsRUuzR590j33jPmga7iuJ8bg
         UkBjBUYuW2oAAdJZ+2jbQc3n6TH/sYm/2viLLYLLfjvIh2m3p21jyv4Rwnp0knMsB/71
         tt22k6+9bexXS3K4Ntsb5XBQ35nzpEx8rGO5AvDHlqFv0varK567e6D3iLzTXHg66Lfy
         5HoPQQ7meSYH9+SkgvBU0s/gkzNEd2jknRVxz10Md/jL1aUDJ5ZUPvAa46KFdsjN0VMP
         YXqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAHjOIaS6ko3pEy0nG8FecxPjhbLIeRmH9tzdXh7AL5YBxF3gmpJ2KC1P9Si59lm10s42nQyEnwzJ8@vger.kernel.org, AJvYcCWTU09HCq6YqOjN87FcAXSAzNQi+rxXieEfeVZA8mzlIAwqUFOSUHKAMKNvg9Nn+7opwSBUkUIlvongHTVSWBWowQ==@vger.kernel.org, AJvYcCXsHJqP6IvEVlYcJZ1I7rATFnk5t2yzie4WGTw8NAN0yURtYbTt7GN9d0IT0xU/8Ga3H61PLOrVIkRRC3eh@vger.kernel.org
X-Gm-Message-State: AOJu0YyCskXd5s0oJrfpymmZ+l7a3yaYC5RmWQr+iOxvSkOl4Ox12jYq
	9czNMn3rdqavjcyKTbp54ctDKLrA5QjbNU1Zm4CcXfUSuwy46hgK2AKP
X-Gm-Gg: ASbGncsczH3J3c78KOD6Skf4cZ+iO23XyKDiNy0elBRazqT1xGrPkneDczs24onLAbk
	aITOfUpxEVg48sa0mMQA0tDt5C9URx8AcfM28JbKJ3Lol38M3/BW4kN8q0s05P9VeiBf+Gxr3gm
	8AUSAJ6sFQMZvdh/BXLeeeBcTFkM3Wa9+cqwN7JXX8blkXHEeQU50aEzIXs5RGFb4zc29jmBlZV
	iBilm5i6X6dYdt1tLbXsgIWC+cRLSc3SvaZVW8qufjD9kJJLYLXNfAxc2JNeBY72uh6YloKzdcB
	RMu1NdFtWn70kDUlX80s5All1PGfD9MPiEsodG5HlvAcJ7FysVREGNxo8MtdgkCWnlPLF7zO949
	Ia9hrBrZp6wvyhr7VkQPsRBjETv+fJQjsh8QMSw==
X-Google-Smtp-Source: AGHT+IEZb8enaTAgcy3PKy19tewnYb0cV0Lsum67cTjohRrkEFZOPERorSxB/CUny9AKPTfHG4lprg==
X-Received: by 2002:a17:903:18b:b0:24d:37fb:6f38 with SMTP id d9443c01a7336-25170395983mr103298955ad.20.1757325642793;
        Mon, 08 Sep 2025 03:00:42 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24ccfc7f993sm107826545ad.63.2025.09.08.03.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:00:42 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH RESEND v8 00/21] drivers/perf: apple_m1: Add Apple A7-A11,
 T2 SoC support
Date: Mon, 08 Sep 2025 17:58:24 +0800
Message-Id: <20250908-apple-cpmu-v8-0-d83b4544dc14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4373; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=+LAKu174f1xhSbC2VdiHkWIZYXz3wYKQPJAQC4FzNig=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBovqkTtL7kDRdJXZf7Bq4gh7VfG/iXETTlRfC+O
 gEURdMqqiSJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaL6pEwAKCRABygi3psUI
 JNzWEACqUePWP9/3y8oeVTH4hpFlV4h5LKJ2MdY/2vUZRXl+Mf7isTGEsrSe+ywZxIzu7iiIz3T
 WwdRaae72juKh+C+JTa5TC8k5pYM4ZzTzl3W+NVoYYQ9Gcy3ej/1EOJc6uSsMsm19m88FYo31IC
 k3gx2LI26i9sCX8gVX4znkZELyRg2LZ1MFHz9wkp/UFH/YWD62jUwe2+EJgOulzNB3qZAWAXuMi
 IoHk5P8ElmEj8kOE/Hy1tSh4Bek5rvAUgaZq9FJDTwnadV5lI7qAg3E2EMfKHsxmMWf/ZjkP/2B
 3WhOJsBT5E/3j+wHMbnxoaV4PXyVFX4qzcjCNAqPOFjfo/neTF+/AwLLr5wt1v7CS0lgXcF3wju
 /T1E8H9wemtsdwTQMPdliJBE9zphWN/fpwtrLbOFDtYUCparvWxDmRue2nVG0gp9AwazwyBGLEO
 luma2Yi0VmpGabZuIDCHjOtaHI0tNj4rjINcq9faeoViOf645MKPNsmUBjvvArMTM2YWyhzgROR
 oH921F5PSJDwzvYUhIwsvYLYDqTru2cXxHN29bgwlxIBbRcB+L5m5lcLi/ysNsvMjy9yJfbpG0a
 joEq3xET3uLp/tJ+zsLjoDqtk6erYCWz5/ExOqUA8OIdpYs2geUoa9xNLb4wqMNBiFxKmr0EzgV
 ZAiSd2w2vwWe/gw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

This series adds support for the CPU PMU in the older Apple A7-A11, T2
SoCs. These PMUs may have a different event layout, less counters, or
deliver their interrupts via IRQ instead of a FIQ. Since some of those
older SoCs support 32-bit EL0, counting for 32-bit EL0 also need to
be enabled by the driver where applicable.

Patch 1 adds the DT bindings.
Patch 2-7 prepares the driver to allow adding support for those
older SoCs.
Patch 8-12 adds support for the older SoCs.
Patch 13-21 are the DT changes.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Changes in v8:
- Rebased on top of v6.17-rc1
- Collect Ivaylo's Tested-by
- Drop #define PMCR1_COUNT_A64_EL3_0_7
- Reword reason to not initialize PMUv3 remap in EL1
- Link to v7: https://lore.kernel.org/r/20250510-apple-cpmu-v7-0-bd505cb6c520@gmail.com

Changes in v7:
- Fix a W=1 compile warning in apple_pmu_get_event_idx() as appearently using GENMASK()
in a function prototype causes a warning in GCC.
- Link to v6: https://lore.kernel.org/r/20250407-apple-cpmu-v6-0-ae8c2f225c1f@gmail.com

Changes in v6:
- Rebased on top of v6.15-rc1 (Conflict with FEAT_PMUv3 support for KVM on Apple Hardware)
- Add patch to skip initialization of PMUv3 remap in EL1 even though not strictly needed
- Include DT patches
- Link to v5: https://lore.kernel.org/r/20250228-apple-cpmu-v5-0-9e124cd28ed4@gmail.com

Changes in v5:
- Slightly change "drivers/perf: apple_m1: Add Apple A11 Support", to keep things in
chronological order.
- Link to v4: https://lore.kernel.org/r/20250214-apple-cpmu-v4-0-ffca0e45147e@gmail.com

Changes in v4:
- Support per-implementation event attr group
- Fix Apple A7 event attr groups
- Link to v3: https://lore.kernel.org/r/20250213-apple-cpmu-v3-0-be7f8aded81f@gmail.com

Changes in v3:
- Configure PMC8 and PMC9 for 32-bit EL0
- Remove redundant _common suffix from shared functions
- Link to v2: https://lore.kernel.org/r/20250213-apple-cpmu-v2-0-87b361932e88@gmail.com

Changes in v2:
- Remove unused flags parameter from apple_pmu_init_common()
- Link to v1: https://lore.kernel.org/r/20250212-apple-cpmu-v1-0-f8c7f2ac1743@gmail.com

---
Nick Chan (21):
      dt-bindings: arm: pmu: Add Apple A7-A11 SoC CPU PMU compatibles
      drivers/perf: apple_m1: Only init PMUv3 remap when EL2 is available
      drivers/perf: apple_m1: Support per-implementation event tables
      drivers/perf: apple_m1: Support a per-implementation number of counters
      drivers/perf: apple_m1: Support configuring counters for 32-bit EL0
      drivers/perf: apple_m1: Support per-implementation PMU startup
      drivers/perf: apple_m1: Support per-implementation event attr group
      drivers/perf: apple_m1: Add Apple A7 support
      drivers/perf: apple_m1: Add Apple A8/A8X support
      drivers/perf: apple_m1: Add A9/A9X support
      drivers/perf: apple_m1: Add Apple A10/A10X/T2 Support
      drivers/perf: apple_m1: Add Apple A11 Support
      arm64: dts: apple: s5l8960x: Add CPU PMU nodes
      arm64: dts: apple: t7000: Add CPU PMU nodes
      arm64: dts: apple: t7001: Add CPU PMU nodes
      arm64: dts: apple: s800-0-3: Add CPU PMU nodes
      arm64: dts: apple: s8001: Add CPU PMU nodes
      arm64: dts: apple: t8010: Add CPU PMU nodes
      arm64: dts: apple: t8011: Add CPU PMU nodes
      arm64: dts: apple: t8012: Add CPU PMU nodes
      arm64: dts: apple: t8015: Add CPU PMU nodes

 Documentation/devicetree/bindings/arm/pmu.yaml |   6 +
 arch/arm64/boot/dts/apple/s5l8960x.dtsi        |   8 +
 arch/arm64/boot/dts/apple/s800-0-3.dtsi        |   8 +
 arch/arm64/boot/dts/apple/s8001.dtsi           |   8 +
 arch/arm64/boot/dts/apple/t7000.dtsi           |   8 +
 arch/arm64/boot/dts/apple/t7001.dtsi           |   9 +
 arch/arm64/boot/dts/apple/t8010.dtsi           |   8 +
 arch/arm64/boot/dts/apple/t8011.dtsi           |   9 +
 arch/arm64/boot/dts/apple/t8012.dtsi           |   8 +
 arch/arm64/boot/dts/apple/t8015.dtsi           |  24 +
 arch/arm64/include/asm/apple_m1_pmu.h          |   2 +
 drivers/perf/apple_m1_cpu_pmu.c                | 807 +++++++++++++++++++++++--
 12 files changed, 870 insertions(+), 35 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250211-apple-cpmu-5a5a3da39483

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>

