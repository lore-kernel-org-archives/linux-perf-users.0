Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA64F219EB;
	Tue, 29 Apr 2025 03:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745898220; cv=none; b=dUsGEeMiptsfFrF/2bIAl/dkg6MQxzCADJcfO51Wsmc8fIyoM8VLqYK8Yc0t9xDvAe3eIdkhbo6QHxcAaPE8fQtUAgshQZFEas6PIR5ByP768ZTo0YA5BBvieq0K9LidM6aJDbipAKm3JDJ9yRSHHZ/m8kGwMbJWu2dJuE/W5EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745898220; c=relaxed/simple;
	bh=A/h8OXs8Wekr7gbuWaO+81ojzwQgObVHH0lNAKAIdNU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pbLw9yM05P2UURbfKjNjtmByWztuk6cTFAEfqmOjxTeMiSHUjZ2PfApuwTowsaddqL1HpQzWpKU5vTtvia05RfTen2kKgDUjJ6BTwtuac2mr34RxEY+oNxOMbKGjUpsOJg3drdMjD6TRUmRykP+ftM7rDH71BWb56WApht1Qhxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwa6FOXm; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwa6FOXm"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b0da25f5216so3489805a12.1;
        Mon, 28 Apr 2025 20:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745898218; x=1746503018; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3EuDa5MdYzDvx9phCQyiyQIJ/EzyBR8j5u1DkbRAKbc=;
        b=kwa6FOXmn8yNcmqt/YCMrCl4Ng83V8WgqeBECSYRjnbG3203aM1YmUPNHg6NbA2EnQ
         OHcydG8xivIsKKNcfipSwZlnnKoBzy6HAlQdQrjBf/AB3lpaUBzEfEcjiLtM4oPoWuDa
         O/7HfBXAU/uO7IhL4+7OBgLOO4vG6PpYsjWhr5ms7FZRKNaSwoyXsYrIZCJg+Fm+5gRV
         tS6d3lEM11FS/dBevzxARPiOIJMKcsv9OT0rfTRRwfUyYsmcEazdcG23X3tSuulUPHMw
         FPa/dXB7VMMXauU/E4Qe6piQq29vUHmmMUouLBeu0Xlnf0E6fjIlBEJmBOwWRrH+5hgn
         RgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745898218; x=1746503018;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3EuDa5MdYzDvx9phCQyiyQIJ/EzyBR8j5u1DkbRAKbc=;
        b=ixztVFPXeTgl8NMOqSQIPRhm8KWIUsmYEzZR5z6sMTS2teP7CPNvQkeH+dGWmk397Y
         RGw8xYG8HPyBw+BYnYWdBkmRAOcReh8z/nlAG/MJWXk1tF8XeEs3pRNuXuuKD32el0Xc
         XfH8jI0YjPVgQrW+LibI98J1PCobPTAvO42YxGUdIXMKf9ToCWC3kn8955CWqUTlH7fq
         pIKL8L4YaU6/mNvOzd2HmQc4VW1VDqiqUWYFF3HUFQTYQrVyGferOa6xtSpiWx4hU70x
         jKs3HCBdGTrkOgTwilxB/QRX6A0zBPcAB9Yt/DV8BaK5/BhqDTfC4CvbHuYScQOkhn/p
         30PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyrD/AnUDJ1hIbHWjpTe1MclgcWP/ZhFGJHrtHHwEWYoMyUw2LINyUYwykkODE8LpCY7qy8whlIMPcLcqW@vger.kernel.org, AJvYcCVzFrJYtDMqosdynQiI1OtNka6DlSEJG2z9zTPlCvTM3TsBFpSWKMEr3GALFw3DO7ok8+xHw+Ra5h0ADl8FzaSjAQ==@vger.kernel.org, AJvYcCXIO68QCrYUp/0grG/ip2ikG+AHXJA+wmwaMIfhfsd6SS9xQbZFdoYoJe0x3GMXnzGCggN8wmHQ4aUM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/tRGDwzyUokYOzm1BilTHJzObccMxrjepDxt0G5GWL4/Qwz5x
	Dp3kcff9528v3vILKwBXoClyNt9kf3lxYQCPjFSlI3QYLVJq1kKq
X-Gm-Gg: ASbGnctQJtUriWVhPVZi9N1wKZGmMuMtVGIBCsGjTTmwXpRdgmRH880etiyNUiGKl8V
	h0jmX08BAeAUqpnrMT49gvFl4xEN7RDJHvTSas8cM00YL6Vz7JFmiZXvkTKw6cn1pPamqXIu9Xk
	w2jCJvX/NQ/KCGcGqySPscXMmR0VNVLo23bYzxcHDKVGAKbfD1fulO73P9SGAvRqzWZy1qOs4m3
	Eu8QJkAX52Dpm5tlnIUE4gax6jGVxsOUNK6k4wKXmXgA/mAOcSp7i6l7Z8vmJXbcq5+7eIylgY0
	sihW3lGy5U214OqodU8Bhm+6tP3vKr8Epb5kejJuiYX7h0wJn6s5qbObiw==
X-Google-Smtp-Source: AGHT+IHDlfH5cI7f1OQklMi9xc6LaYpwXhhqvPBfBvQ0fZ4Ac0OERq6XWV3yO59OjjnYFowNpLs0xw==
X-Received: by 2002:a17:90b:2f10:b0:2fa:1e3e:9be5 with SMTP id 98e67ed59e1d1-30a0102977fmr18745487a91.0.1745898217839;
        Mon, 28 Apr 2025 20:43:37 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-309ef03bb7fsm9953249a91.9.2025.04.28.20.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 20:43:37 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH RESEND v6 00/21] drivers/perf: apple_m1: Add Apple A7-A11,
 T2 SoC support
Date: Tue, 29 Apr 2025 11:42:24 +0800
Message-Id: <20250429-apple-cpmu-v6-0-ed21815f0c3f@gmail.com>
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
 Catalin Marinas <catalin.marinas@arm.com>, Sven Peter <sven@svenpeter.dev>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3865; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=A/h8OXs8Wekr7gbuWaO+81ojzwQgObVHH0lNAKAIdNU=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoEErbsRiI2o9zO9yGgrIDiPGqiBCwQ/exVDgtU
 yLxoDGk792JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaBBK2wAKCRABygi3psUI
 JOc6D/9YZLf+qLgGlcRIAvMjZ0bDXDsXrSD0YBt2SLzeB7VjTMMw+LFsxMbOZPgDmIHDx8i8AtJ
 MkeCh/kYRZE4OGpvb9wiMGts7rjIRZZKL07IiMHHRlG12dRlSnlxWouS7ycpn8vom0TltxhHbIK
 P0RByJ5zt9SFyUcU47cf5pCIo3Wx0grcqRB2ls0DtFbkVIvEd93UXUXMOA2Z0t/BI4eWR7IJMw3
 1ew95gkM+NuMb7G+thfluv7GLZb0SVt2d3KXtMAOrk5bgFsxzHH5XNYT+3tE7ljk0aVk3HkBkY7
 do//A5q5xglJKvizGtz8NzRSmYojIVxBCRTHn2hQMZtfoXzZv7pnIqaI7zvtu8PX6f+g8uZK5HX
 SfEucgyW9U6W6fJs308ifDSvZP62wFw4sfJ0ygw596PONfJhb/tRzGnJvo8DQ0mOYrM+4UBmBdO
 EExVPj9br0dRY13U4c5Xrqc6SmM3ffQ7Vy4lVRQ3wOWxkUpxcNttI6r4kQO0XWkOKV6UvBW2+TW
 fHK7BjsHgAr/G/nD7gSH9za6MOHULZFd9Js6idty98w//3uzXwwbnefcA9FdmL/RlsjPUec26iX
 nkPrPAA3GVbF52t0uaG8++C4ca1w9b/0qWNJUbBgF3492W+/M1ucVj1pRB9JQScNkrPNuzHtcDa
 FOrYz7yCtmIbOdA==
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
 arch/arm64/include/asm/apple_m1_pmu.h          |   3 +
 drivers/perf/apple_m1_cpu_pmu.c                | 807 +++++++++++++++++++++++--
 12 files changed, 871 insertions(+), 35 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250211-apple-cpmu-5a5a3da39483

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>

