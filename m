Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BACD34B195
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988681; cv=none; b=M7Cvg6Qic5a1dOVuhVFasLeTuCxQpQ5SaGRmbbF3vDtSbVGUdzWp+tm0Z6arqYtHTUcOOQbJT7u08/rXvglTeOAsy8dr8fbfetrH9Nu3qKUigp03hJ/Ap+IidUvOmcfPnDCpxeRYmgOHua/CN9osDT68gkw2nktUdvuDTNA0rOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988681; c=relaxed/simple;
	bh=PgTQRT+gLvYaLCi8qjd1aU/cyiFqcrVhwIPj3U+4edM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JWe3m0xWSgzBBBcqPJqYVkIwTKxW+mwgkAA03kAkaCiiWEq90A+BdfdT4UQiepYmZxAoarNcDkf6alkfbpFL4VMQtgYLz0seHsslWOTpKvny4d1jIiCSKAIy/yft0PY7Jp1wjXrIlf8xhiBsUqoYGAeI+yoTNQSmKYnoITMlSo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+XSh+iq; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+XSh+iq"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a09d981507so6450525ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 08:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765988679; x=1766593479; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JsPcnAXX0HxXZqnB4n6Iu8u5L4r6zw595gJ+705EC+s=;
        b=J+XSh+iq4QG9YC6DnfCSS01xt6pHXOSaEyO9VCO0BTjZtFw242zM+H2UIuDm6MFjPO
         /WwPhirabcTibA6ACDQqrr9tdluRYHiSQSvBZpZPKHdCDilnnZL0oTuXVkSQPkjzVNbj
         v2jEEkpdxOM5wDOwcBsAeL9Q24ER0vjPmnrIlZkAFnyPM1YVAmSSNB96k459hTvru7Ru
         29Exv9lGhflV50zro0jFc4ZYGQZLqQTJxFFdMJr0rCXHLkzpJgg45U6/NcPQiEEX7N7o
         hAFBiBhK7X7otB9ze16aw08OI/T8SZ7krnOsbZayOQ8n1aALAHfBH+vCsNrL2GJy5PUU
         Nc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988679; x=1766593479;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsPcnAXX0HxXZqnB4n6Iu8u5L4r6zw595gJ+705EC+s=;
        b=KXRz8MbCyklSZORhwULBio9ouhnyruZIZ5ra1wI2W4L8XnUHPGYZTGD2AFSIiatkJP
         lk9H7cdskrAKn1EU71PzKBQs0wuIdE7j/TUDFrpgbJ6Rxw2iJjPiIm/vjlVvnp0RyXAP
         hXNx9kaue3wBd/Y09iRPVXBAcHTcnmBKshncXHiDvbx5C0LRZ0vCucWm4X3xRDucsfw1
         FtoeE4ROB0xiNmxCZFNubpjkU98El6XgdhPchsKuMmEbwT0YX3dhReucJVokdevNKSRG
         SrOQ+M/jwoU+ACSAuNlummkf5oYYjqx53O+gSJ8ksTcxsua4DQUj4qmDT9cal/0/rS/u
         7YvA==
X-Forwarded-Encrypted: i=1; AJvYcCX/uWNP1p7DmlAxH1Ahrfjbdxf2AhjC7tlmBalB5FmsPeQn41ryI067cQRzvcGNH1P3kuyN3rFazVyuoCTaSnQi@vger.kernel.org
X-Gm-Message-State: AOJu0YxGxSAicd752WEvY4BVzrGxPfiQqPvrbqO4a6oKc4goKtjcCskP
	vvFVwXZ6IrwSKwDCkOgbJgRpMfMwaB+vvb9DgYIJc/q89BHmaeb2fBW6
X-Gm-Gg: AY/fxX4bYn9sqZ+tylgYltgbTUyUdZmYWN4SYOqlk9CIDRhhc98Bzni2LE8oOMX+eTT
	2vI+z+WHXn0AayeVl5Wed3NNsJBFmeQW9uGke5autWnUL+MNzcjf0ok3LeBNH6TuUZRY33miMjJ
	oeWkmX9xUlbxHhXEq81OW5WLdC8Nm4sxgk0vCSZwngvOYqvj4evCLQi/Lpystf8aDZ3GWrpxusn
	L1/GwO0vXztME6vfTTzNYeWizXYjEa/HVaxcj/rYGwfURc0JWF7c6zjtFee8MwihP3M/jKP85qe
	espwRQHwbSVjHvAS3PobHA8y7RQylz/8VH1k/Kh15QYMjgXc+f/7ssFLCGtgPb5WTocweM9IALC
	5lF6zNGls5wSNUMXWdNnmkVsC08iT77FpILYOF1CA/2/Es3qGeIIQERdj+S8a39Xxl4pZkmgUzp
	HrLCGLA0KEmsK8
X-Google-Smtp-Source: AGHT+IHAwxj6DzdDy4Ktf3Hya1n9fwX45F2bVkRoYmLdBMFbognAoioKTp23w8/kQbJXYMZiXIS1HA==
X-Received: by 2002:a17:903:1a0e:b0:2a0:c92e:a378 with SMTP id d9443c01a7336-2a0c92ea624mr148009915ad.7.1765988678823;
        Wed, 17 Dec 2025 08:24:38 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a0b0687c62sm122980415ad.88.2025.12.17.08.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:24:38 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v9 00/21] drivers/perf: apple_m1: Add Apple A7-A11, T2 SoC
 support
Date: Thu, 18 Dec 2025 00:23:13 +0800
Message-Id: <20251218-apple-cpmu-v9-0-4deadbe65d03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPLYQmkC/3XRy2rEMAwF0F8ZvG6KLb+UrvofpQtHlmcMk0lI2
 tAy5N/rDJQ8SpdXcC4SuouRh8yjeDndxcBTHnN3K6F+Ogm6hNuZqxxLFiDBSlCqCn1/5Yr69rO
 ywQYdg64NalFAP3DKX4+yt/eSL3n86IbvR/eklulvDWxrJlXJKiH5BIGUN/r13IZ8faauFUvNB
 FuqdxQKRd9op2oNjHik+n+qC23YJwyRI6p0pGZLzY6aZeFEQbKxyng+UruhgDtqC61ZgaEIyNE
 cqVupkX5HXaGBkSABWPq7sF+pVXJH/XJrLHNqHFmQR4orxf2PJyyUrJPcxJqCcVs6z/MPeEsny
 0ECAAA=
X-Change-ID: 20250211-apple-cpmu-5a5a3da39483
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4650; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=PgTQRT+gLvYaLCi8qjd1aU/cyiFqcrVhwIPj3U+4edM=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpQtk73F6rEAOyEA3wyqqf8KFEkTZ/0x9ysNapI
 uazbrtOdV+JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaULZOwAKCRABygi3psUI
 JFh1D/9eIav9eVp8eoDrGgQhSCtAnDqdHRYJkeC0ulHs3A/Ks3x+GmU7fFqCBmnZOeZv91UPI+m
 VVsJT7Z/8aNJzCsG8/l+rr0any70TKr3Ke+tV409k8s95gKkNHJ2OyH+6hP10VJQ4YnPl3ou32o
 OxHQk2kh9AWH9gfUR1HnfvJP/p5Hd40lrcyw4HQFBPecPTOTv/moettZMyl4VbnyIduhXMKJq9+
 gmYMDKZACjN3yYmSrvUbmy4Y8uOMGzCKr77HTQe69jicpoXwY+D0jbvzuvBqw616pWXKPty6QIx
 W4tEsIb8gOZN1pb5AtMect3T4CxZF6rJV6DFBLKu6kyqtcqxjnx+7i/hLAQrCMkPuw+NihqverH
 jKLffRvah01OZSuS5LB6FaFa4a5KUz8kV79XKvmjgakp4g3IF4fMCX794es24VQ3a718dyvqXTp
 68bI9Yot8ZFD78UDUfzzSH/J8KkNDIVBrZMU7hSpEa1T3rEhjcDQxQFeqDdPuDBT7SbsSJj28yQ
 RUKnhIQwHj+WsDLQtqM+mqFEpAU7kyturFvrOne4wmb/LraaucJVyNCAtYA0WZxBVdYI8CTBO5U
 qpLqAQU3+t87Nvro4etxRgvx2+YPFhf8CNaPzL/VBUtDFqeQXo4PQfBQ3dhJgfWWe/y1UtcXsTv
 wjPHAiSQW7yLVGQ==
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
Changes in v9:
- Rebased on top of v6.19-rc1
- Removed non-existent "INST_A32" and "INST_T32" events from Apple A11
- Added "INST_A32" and "INST_T32" event affinities for A9 and A10
- Link to v8: https://lore.kernel.org/r/20250811-apple-cpmu-v8-0-c560ebd9ca46@gmail.com

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
 drivers/perf/apple_m1_cpu_pmu.c                | 813 +++++++++++++++++++++++--
 12 files changed, 876 insertions(+), 35 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20250211-apple-cpmu-5a5a3da39483

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>

