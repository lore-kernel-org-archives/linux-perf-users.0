Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC79327FD5A
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Jan 2026 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767258159; cv=none; b=Fyr9WDxuAla8ZGEf0QG45nVvsn0CM5hiuTJq9wQkDF8A4np4OgQM71ZKnQQFGrtUGUaYp8rgdxj8nhOKws0+/SKSbjvxR/N3H09xi/8RQQ3bTTREG5HxbCIt/0067Wz7YTiVsopLE7m2B9yaNuvLK8hMlZw24NCvjc0pTmPbsR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767258159; c=relaxed/simple;
	bh=EQFY3VpkRGJAmRC+3usD9WjCbbVU82Myoged0+CY6HY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OAeHdDV0Snlanbf1vFx/RsGHbsj2i5uGo3CVSRyenkpIDAkrICyR7qwb1uhGO1SO51BwguOplOAQNiwE/O+AxluCf8LcTz8slNGu9jidg544+wXI+wCGLg5J8g3LyQFIIinD04tswPH2zvHc+1/sZ2fdMIjrGE453FMOUVapDs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQx2uH2R; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQx2uH2R"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so12867611b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jan 2026 01:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767258157; x=1767862957; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hihZBSA6ypcKPzQIvhGDpg48Y7yieDYcaYuDOCtFxfc=;
        b=GQx2uH2RRq48uD8KNQG4gcOCio6GHliDJEIAJ23Ci2u9O8PqIDWiOfllk+Zwfpdyep
         zUyGZ0vNAQk6STYTFunGjVkXNOvvMi2jy5bBqpYMTUUsVwJj8Vo1kUcTjCu+wbKiIGAp
         DW/giJOd9mr6RPoTPo7edkvP51SwVxyM1C3m8WWrTJIjsCxW/wPfcWbTwKVPzH/A0Dfm
         5CQCUjQqa5RTD6auln+w5dd/DXGX2Tv4z9yVWcohJbMyGi2LeK9o+AC+SaiUh+DH2r/E
         CwtwExqSvbTNpAqlZb5kJC63vm06o6AiTxAMJHRCFznlVp80DGmP0CGElhUqaTR7PrGb
         2cJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767258157; x=1767862957;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hihZBSA6ypcKPzQIvhGDpg48Y7yieDYcaYuDOCtFxfc=;
        b=UCJY3VtuqTsB2YxIqXBKqSzHmnPE7y+yawyPi8Prs0u6fvwD7YrN+2NVST3ls8Of0D
         2fUFPvBJAsDdvwvL1paojyMF0kwrwVkSJ/05KzRLQiXtUKxy8gcS9JusIe7dCpGUef7O
         IqBWlRg4aaCh9kEK41ay8Dulz9KpAs4dsNQkELPTB5LfdkKi5hkRa/BYShEzyK1VbWrD
         i06qRWGHkrU80FT92IC3hCIfcNltdGqB/l7eVNc+Da8ZYHI9r1AF/3ZR88cULdCcXGuN
         xsQWQ9msM0zqCYu1vltI9b0kpyG2aU5ltsLVzgc//eHE2JEMkfEJPMa7ejDIGLm3P9LJ
         aa/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXG28PiUfbCX5gC8K+PCTFLc3SMRa+BaqTZXZEet9RMHruKxiGFTPBjLd25PaUJzlRJBorEIia4S3lpHHoCH/HV@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfo3lJpJ+FG25mjjNKLivW8Qj5x7JvPzum85CO8GbaaDlypI34
	uuAMzP8JIE/26je5/zMdDa9+CViIXFJVOkqA6O/xw/uGOS3/dh2Xeq2F
X-Gm-Gg: AY/fxX4rQPF2saNqVI1mlEFjLrTn/83L6nnJBlR8RdlAXb05vjjYY1ZgVP+pLmx0P0+
	Asq6f0fIpOpyfoDyPzJnwI/muatrGufNXlF6nDBC4W+pdFWYcgXH8WMU26WUJIvr+hcGA3U8QTi
	s9xUIWD6NDtLaI3C3PA5xQZ/67BPzaB8jeQNiQLsws4JKupLw3d0J3e8mU79XTjjOmHb74ZlbjE
	7RQ6ES9ObWmwKVQK7V1JsQHXurfoHeJsbY/4mg50gRi0YA4ZeWszyCqR9/pPEQT+Nj8NC+o0OwL
	GYfHegLNVJrIw7TmvRzRxuOYEE60uTZa8uhmtnp7Zk+L7tp6IBnIyiPcXEHy1HP5U7Pk7o95t26
	fpdjZ3kPctVZyN9p21efPp/D107NFmCm1uQyO3fScWuH5akRuqdBLQWlCVIJNdc+28tud2j7PjP
	wKJDZP4Taah4QB
X-Google-Smtp-Source: AGHT+IGaOzY6wshAcbbeVkzC3Qr2Y9GtbIIPSO/l6MCiYeY7h9AAOipH+K9CNz+QNORa7BFGihwSWw==
X-Received: by 2002:a05:6a00:b902:b0:7b8:9d86:6d44 with SMTP id d2e1a72fcca58-7ff644012e2mr30833268b3a.9.1767258156940;
        Thu, 01 Jan 2026 01:02:36 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac29bsm37182957b3a.39.2026.01.01.01.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 01:02:36 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v10 00/21] drivers/perf: apple_m1: Add Apple A7-A11, T2 SoC
 support
Date: Thu, 01 Jan 2026 17:01:36 +0800
Message-Id: <20260101-apple-cpmu-v10-0-48812c529ffc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPA3VmkC/3XR3WrDMAwF4Fcpvl6GJf+mV3uPsQtHlltD24RkC
 xul7z6nsDXO2KUOfAcJXcXEY+ZJ7HdXMfKcp9xfygDyaSfoGC4HbnIsgUCJRiJAE4bhxA0N54/
 GBBNUDKrVXokChpFT/ry3vb6V+Zin9378upfPsKQ/NbiumaGRTfLkEgYCp9XL4Rzy6Zn6s1hqZ
 lxTVVEs1LtOWWgVsvdbqv6nqtCOXfIhcvSQtlSvqa6oXhZOFCRrA9rxlpoVRV9RU2jLgJoieo5
 6S+2DaukqagsN7AkToqG/C7sHNSAr6pZbY8mps2RQbql/UF//ePaFkrGSu9hS0HZL218KCPWtb
 aE6cogdWxNl9dfb7fYNUba2qn0CAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5031; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=EQFY3VpkRGJAmRC+3usD9WjCbbVU82Myoged0+CY6HY=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpVjgDKe7KDF0MQ7xXnBNenpOX0XfR5VF7q+6wr
 B1bkRk3I4mJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaVY4AwAKCRABygi3psUI
 JJxQD/9ZOl2Lpn7EgE7JzPylfWJeOYnwx5opMAFwVgmFgdtoDeWwW17v48KMrfWxcJtVncwBHzX
 UmpwvnLyBO7v/+5gK/RVnES48YNgw0WtURWsUrFddKU/qDw6UnS8Oz+xkr1ra0tNFN2pB0TdkF+
 FqnsDx5Sej3oQ6I/Gw08urmNSS92o3+Oe7I9G/qhHUNrK3mSJ507iMFqFRCWyGx/OR1L0lBKQ9k
 MLzPIlTtgzV2h0tT0463MzrZgRtwUCv5bqsNG5ycPo6DTOntQ+MfxRXkufG28XDbPkza4KGQVhF
 7uq5eGKFh0x5zZIH/v23EgI/MpowpeiSBopKQ58tr8Q0grmR99E2J5zHqlro6G4RA38FhokG5W2
 Rtoei/rcwg6PV756cdTeumCXm9HXEtdOwupUJBT2aZ0qB7nr13gTnCZRRvjBoF1va0AvP3v3dmV
 qmWlFdtIegWoNnLfgK4d+yEAMZne/+miJO0+H4vAixZG9ErDl3HiogEjc9JHSi97ej2QUYpTv/7
 50CqRe03HpCcwtD7bBf04BaPbz5ht2u54EAUoZ2xI2QYQXsGCKRUAy67sbNS/Xy46ybi24YnWUu
 /OHGVhQdypJby7Dz+PK4mHIYRJ3dRjIHztVFESW5boTVRNsW2DnPGUuoovJ7AharLoCHIPXfTWh
 mdNeBUHo0XlxYew==
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

Happy new year 2026!

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Changes in v10:
- Modify apple_pmu_get_event_idx() to take the number of counters supported
  on the current PMU, which allows `perf record` to work correctly on A7-A9
  with 8 counters in the PMU.
- Rename the added counters to nr_counters in apple_pmu_init()
- Link to v9: https://lore.kernel.org/r/20251218-apple-cpmu-v9-0-4deadbe65d03@gmail.com

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
 drivers/perf/apple_m1_cpu_pmu.c                | 820 +++++++++++++++++++++++--
 12 files changed, 883 insertions(+), 35 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20250211-apple-cpmu-5a5a3da39483

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>

