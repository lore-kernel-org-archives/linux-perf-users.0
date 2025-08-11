Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B545C1F583D;
	Mon, 11 Aug 2025 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920523; cv=none; b=s7+xjyLt3LKCqUIvH5rvgUdJDVLsM64pnZtHUZBde+gurMhavWjK4TIlvF7JmRd/390lfQMt4jwglDD88z2sz4lCppmE/D4OevmZQfyc/kfWtoqueQ6WyWcS/nBGMDM4c9tD4gFPgFp9xyRGQr8N0HcooJTfdecNPTBg3iTa0LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920523; c=relaxed/simple;
	bh=+LAKu174f1xhSbC2VdiHkWIZYXz3wYKQPJAQC4FzNig=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XV0oMZvpfpXwJIInLTbwlAT621k6AV7XgczjJOtAHqd4nCVdEQa+Hp1/tfH/DMU3bsBbUOYKV5t5vj9dG9tK/2rJ9dfY6uOflNzwHvrrSqA4uwKrukIp7e8TVE9zjyhe0zLVJ+qsTYJ+l3tHl7gSc5L4ZlPH9agfPHz2AWa9h0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Imoov6qF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Imoov6qF"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76bd9d723bfso3753250b3a.1;
        Mon, 11 Aug 2025 06:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920521; x=1755525321; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8imCO2VyYcb1j5phQLrLVVRIepCgCLAAPrEPMDTG34Y=;
        b=Imoov6qFfYe6JWyePDTLeGYQMzUPURDbgQ6xQbMenF66PYuGIKCKrB7z7v7154xZfR
         ibpbn5rYQu12zDQIULlsUUXkS214SBntp/c03uIuWmbU9gLH2rwMkUkcVymLxLP0wwZS
         EbMdVJt1AOl5oU02MDMnItv++bRD2fkpgmSpUEYlHLZmEopgItgMPBwu3yk/HIJkR1Dm
         bCDpOR2yYhym2pYxaaj8Sm5e/oRY+Ivkoe8QenF/IqItlH5K7UH02uMzPHPozodtrQTW
         2wPMSFWyEPKl5f88BeltJZTxG9P8dntA+03rvWt7hgr63uR7gcDmo7xQJuOaOQDTKEbK
         sYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920521; x=1755525321;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8imCO2VyYcb1j5phQLrLVVRIepCgCLAAPrEPMDTG34Y=;
        b=Fq5No7+QauY7yd+baZrfonZIC5qdMoWdW43zbiTQbYZUJfqvkxtztyt8mSMF2GcwfS
         LThGFIwsfFVg4v1IL3LOrcGT9Ixm6PwR5e3pXnHiJfcptmqK8Asjuv/fZlMQiKquAuZD
         v9ogy4hAeLJwjblWpA7qftvDL4UQGulIU3U3Qxei/CUXfs4/LXbNd0QxEfmHA1bfQjys
         +/VXxYdY9JXtxq+Rva5gqG/DxfICDq1tGniEDC3O/0keMSY5pnzrbkWJf+6SjrMJqiKq
         79e24CGj9g1rrHXZpQnywnaRgrQyd+6JclU24Jt+BYH+e+zcyw8XmoOsulcEp97Th6Zh
         sucQ==
X-Forwarded-Encrypted: i=1; AJvYcCVReWrbp34WBMdKPmM7OvONqidipx9NE9cIUVOAIyKtfN0uX4g3yQqU3WMdzXHFeXG3fBk+EIhpKlU1@vger.kernel.org, AJvYcCXTWQnmKm3/eDryElDiLOSffUvjHqdLEJxXWAVZTUS9tiFERcXgf5a07wwpDehPOUZUUN02mGs7btGayl03@vger.kernel.org, AJvYcCXlNePyvxYK8lcVQc/Sq/WouOB9EWlAIDb88HAWNN214zbE0kp0dW1oO5Tkd6JRKbk7E7gBrJlMkJ0+8A9h7ZTT2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwR9l41zz9kusxm1k4o0hhBnHkRPVfuR00BZuOkcdfpqsAhpn8p
	sHnZznal8oT0E0kYFUmQCSIODq/0R3/qDyv3lL6W5O68pTuUob2bJak5
X-Gm-Gg: ASbGnctuotCduGXU58xhWrz4BiD/UbWIPMANv+5bt50untsq2MKryq6GpXwLt2jsvsv
	ztCnD6FXPFkg4+RGLMbZ8avRYsqNebW0mXLMij4eSbtlvEscVCpFOS/q6ZIp8558GhBr8/nLvGK
	5MDwrdO+OfQeTXb2wAy5AJn6wUTbSE7caaPyflng4f35LIhtowvh+KaKX9cy5ZvU8+sDdfl5l/D
	EYwgXt1e/kVc0fNjk45tbjKlPrv0x8scVsSHGZUos9Udl2hrL8E/NJkoOp/1XYrOlfWK0qzH0ZW
	geTmEtn6FnpjhG8pHfLlqDR+BUcCKsdbX12Tuy/GFm/8CN7sXelseuH75mvkE3ILYAwFmWO7+8t
	zL5EP4YpRRnPyqmdPPXUMYLVlFyKgkV/kkQkDUAmMNP6PTKr1R0uXIQso0A==
X-Google-Smtp-Source: AGHT+IENxJyKg8e2tAP2l4pvGlyIwFK3L3UGuIA5zM1QHUrPj8V2EFyRgxWPSC9CGd+swIwok6HwCQ==
X-Received: by 2002:a05:6a20:6a0a:b0:23d:cf88:e31e with SMTP id adf61e73a8af0-2405500e280mr21954086637.8.1754920520924;
        Mon, 11 Aug 2025 06:55:20 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422bb1133fsm23585496a12.56.2025.08.11.06.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:55:20 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v8 00/21] drivers/perf: apple_m1: Add Apple A7-A11, T2 SoC
 support
Date: Mon, 11 Aug 2025 21:54:32 +0800
Message-Id: <20250811-apple-cpmu-v8-0-c560ebd9ca46@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABj2mWgC/3XPQWrDMBAF0KsErasijSRr3FXvEbqQR6NEEMfGb
 k1K8N0rB0psly7/wPv8uYuRh8yjeDvcxcBTHnN3LQFfDoLO4XpimWPJAhQ4BVrL0PcXltS3X9I
 FF0wMprZoRAH9wCnfHmXHj5LPefzshu9H96SX628NrGsmLZVMSD5BIO2teT+1IV9eqWvFUjPBm
 poNhULRN6bStQFG3FPzPzWFNuwThsgRddpTu6Z2Q+0yOFFQbJ22nvfUrSjghrpCa9ZgKQJytHt
 aPalVfkOrQgMjQQJw9Hewf1Kn1Yb65ddY7tRU5ECt6TzPP8dqajwGAgAA
X-Change-ID: 20250211-apple-cpmu-5a5a3da39483
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
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfZAzeYECu3q9NXPYbpcYcvwUCODSxZ5a4119
 wtG+Jdk0MSJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn2QAAKCRABygi3psUI
 JIh2EACPm7iZczQOtNsl2grpezfen4As7n0d//LN0qy3Ld3fMEkyBoW9c5vVIsSm7X03a35pPtq
 3a3dIbo5xCsN61OmqliYDNotIpnMXzslz+7jtgdfTdM/qygjXB0q/ZEUQpSUO/Eg/G1JeV5QsAI
 iBdrY0BaokZnPbg13soaR9dO9r8rWlEpHkzj4XOwiD3gvZ/sFjKSJGnMEsm0MQgxpFVc7cty2sz
 9C2QXBvMXSUjFVzQCIPsrj50Y08lfpL72kadxbGolxpe2x4/zfTIGS7oJhz4smU54IMakcwznjl
 VebELeykl8bm4BDv/m/RPz9KgebuabPPi4/WyQGYkMfj2WTY8RObTmg9l8gbneuM2D132ZruiON
 QxNcXSlseDl5TBIWRcXkrw0DlHvxAsw+OTqIY/EOV0+ih81PSQHtVxx1IfgKPY7P/U/v0M1GioU
 FG6UxNVff6odUQu7OLONzY0Twmc7tCgOiwm2BQDHnDLmSgsxHeeVbPmLKrxmQ0mg6QAfNLT1Hcu
 TEPOsKAm8CR5EO6d6ERkN1hYsrWGOqOR3dPU4fINpCdEkBbt+CouNYtPkdZE5SSL5KKYezyDaOb
 XPUA3ZpMxMKYaAD7FZEHxwj3kOf39SJxxZ/KMsSRn+T1WkXqR4hZ65wmcz5W4894H9poMX4T6sV
 aiBYe2hh5qgTWXw==
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

