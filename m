Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ACE2D8385
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103112; cv=none; b=rv6pAadmiFv0uqVfDN43FOVtCYm70hpIOuWxrlCzv6bxEeVfvkhaiHfjK14rOteuUo/uXOJICjvem+gr4yFdjSUu4xUe5/kn4pSECeG4qrnzdwJYYPxfAvEJ3unSgo+vx8IQfZOfSx4beIYW3uW7UMygsONowXHmcTi84r9BJbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103112; c=relaxed/simple;
	bh=ry0kx3kENC8esVaLonHweRVq6aJ9sMvhgF+NrHgtoBQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Hjldmw7eW73ROv88V6Cr6Ndr638ADsPAcNiFc43NdHgEDz44CpWh48Pt4N06mpuAJkq/J+EgYhVeakpOQNkK0SnZoUG0AkOdQd5RBPZSdommeRsWlA4WiOOle2z3rqWiy5iBBnbPUH+edKM4JNgVz5li5nAln9vC0c5/czTQ/YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kuv2jShs; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kuv2jShs"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a6d77b43c9so3266689f8f.3
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 06:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753103109; x=1753707909; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=58/apG919MzAEhvuWxJriNjU0gqcpf1GWX4IKunwUcM=;
        b=Kuv2jShsuvl+HqdClFBeEF7lQgIymMqG8rPML8AEXOqbMEL1Q7HONpqSIsjQgWP9d1
         QDc4GrIjbi/Htfdx7tpL1g9InWXUNhFDNcsWguy41VCRzv4x1PPYw4+ba9EugYGVQSI3
         37+2QJJwIPIbMS7ILoZ8tZLkRdEeySuDxOTNAW8GLXlIDb4F4TotfdWv+MiJ65zYQ+0s
         4ZqNTTqAeyngu/RrkFeJG8Bal2UoWn0b7XfRiPC3uj0JHbtOUern7P4+qMqwRGIpXOD3
         hN/MmKxWACat+6O2O1tjGgkgTM9Y5N6jQDGV834GpJ0vvZd/nGHQROjWfS5hOkgc07/W
         X/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753103109; x=1753707909;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=58/apG919MzAEhvuWxJriNjU0gqcpf1GWX4IKunwUcM=;
        b=PiiiRmUpCegLGN1GH3qaTN0HzfUyQkf35C3hojYNotDNbfiYdIGaYzz1s4sae2nzlX
         JgS9tNNa2YjuNEKLmQu0+pQxiB6GbSVLwZ+/xtMJ2DCTtg9ZyYRsLFVSr6gP6395PAwW
         +Vu9r8kkGxkmWDsgYVwuumGREyUyiUW0Lq2wEcKg0PQVytQgx5u9rimeo7s3EP0Wl/jP
         7dJzJ+h3P2Ltf5+16YrcKy3e7eBL+x+TWf3/iK8jujyEQFkkJzMk34Ds3LM+9Ou2YOxU
         Z5H32x6Ow8xxpK75xwZO/3gLAJl7NBp1/SnbPo93yFEWp6qwfmRvHnhC59X9UM1tdUS6
         qR9w==
X-Forwarded-Encrypted: i=1; AJvYcCXHFc0yojG6kxxI2td1cNMl2EgK7FhCNogJAZNUWB3MhNmu6pkVXSVTrfBywfDIltYXc6+jTujAkRfbgyWtTC2J@vger.kernel.org
X-Gm-Message-State: AOJu0Yx57O96hl+JMPniiay3A4FDcDFnVy2CsclKTMmMOkXBqmVAKxfq
	lma91Qi3SCKQwJ2M3WacZObhKgqXceSen40oljahp/Ur3DN4P5t1ZmNpyU55aNETtEM=
X-Gm-Gg: ASbGncvYAlHit3hf0Hnf2Zu0+WmQK0nq6TvdvlcEzomM2xuRJuoEA8yYZPOi4A6NBLF
	q87gHP5BdsHLU45wMwpYRuSOlsmiF0MZ5Nm0aqwRjfxR1cNpOpQLnfgNMfv3dRajx9z7hLqnI4R
	z20+8QyrgMpNzk+n0O6vXavoCce9juKcNMBBvd9jd0SnQ67d4beVTT0+R2SwVm4893NJV5Fr7nP
	0H9Yy03rcjPLLQcE9ylV7GY9fyZj48/urViiK6me2L4/IA6heZXIjyb0426WlrCEVYQWpGw4kkI
	WxaUp3Arh3nmN1kXXNnGWEchxgaeeVB9e5nUw/ty7Vw3Ra2rLl0e2BEe1wAW/P1ChSUcRzzG0Vi
	oPfAQuR/yFHkzcQghPY7t6y7HsNjYtyM=
X-Google-Smtp-Source: AGHT+IEZxYSbFxrrmP7cZP+9xTts1CuqTjmAYcW5ZBGc70QshBzfW0k8oadRGMw1/lOur4xQKdph0w==
X-Received: by 2002:a05:6000:288a:b0:3b2:fe84:a10 with SMTP id ffacd0b85a97d-3b60e440dddmr14665497f8f.0.1753103108852;
        Mon, 21 Jul 2025 06:05:08 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c632sm10485077f8f.80.2025.07.21.06.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:05:08 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v5 00/12] perf: arm_spe: Armv8.8 SPE features
Date: Mon, 21 Jul 2025 14:04:54 +0100
Message-Id: <20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPY6fmgC/33OTWrDMBAF4KsErasy+rOlrnqPEsJEGiUqrW0kY
 1KC717ZUNwS3OUbmO+9OyuUExX2crizTFMqqe9qME8H5q/YXYinUDOTIA0oIfk7flLhA+XII+F
 4KgOdKI68aXyIOthIzrH6PWSK6bbKb8ear6mMff5aiyaxXH9MtWtOggOX6CUEDa339vUjdZj75
 z5flo4VMND8D4SgLZAlbY34DSyrJrktMdLtQ7JCCALdGTFAgw+Q2qAGzD6kKtSKM3gXnQWnHiC
 9Qa0U+5CuEKCRrRYQbQx/oHmevwHl8SAc2wEAAA==
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, Leo Yan <leo.yan@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Support 3 new SPE features: FEAT_SPEv1p4 filters, FEAT_SPE_EFT extended
filtering, and SPE_FEAT_FDS data source filtering. The features are
independent can be applied separately:

  * Prerequisite sysreg changes - patch 1
  * FEAT_SPEv1p4 - patches 2 - 3
  * FEAT_SPE_EFT - patch 4
  * FEAT_SPE_FDS - patches 5 - 9
  * FEAT_SPE_FDS Perf tool changes - patches 10 - 12

The first two features will work with old Perfs but a Perf change to
parse the new config4 is required for the last feature.

---
Changes in v5:
- Forgot to pickup tags from v4
- Forgot to drop test and review tags on v4 patches that were
  significantly modified
- Update commit message for data source filtering to mention inversion
- Link to v4: https://lore.kernel.org/r/20250721-james-perf-feat_spe_eft-v4-0-0a527410f8fd@linaro.org

Changes in v4:
- Rewrite "const u64 feat_spe_eft_bits" inline
- Invert data source filter so that it's possible to exclude all data
  sources without adding an additional 'enable filter' flag
- Add a macro in el2_setup.h to check for an SPE version
- Probe valid filter bits instead of hardcoding them
- Take in Leo's commit to expose the filter bits as it depends on the
  new filter probing
- Link to v3: https://lore.kernel.org/r/20250605-james-perf-feat_spe_eft-v3-0-71b0c9f98093@linaro.org

Changes in v3:
- Use PMSIDR_EL1_FDS instead of 1 << PMSIDR_EL1_FDS_SHIFT
- Add VNCR offsets
- Link to v2: https://lore.kernel.org/r/20250529-james-perf-feat_spe_eft-v2-0-a01a9baad06a@linaro.org

Changes in v2:
- Fix detection of FEAT_SPE_FDS in el2_setup.h
- Pickup Marc Z's sysreg change instead which matches the json
- Restructure and expand docs changes
- Link to v1: https://lore.kernel.org/r/20250506-james-perf-feat_spe_eft-v1-0-dd480e8e4851@linaro.org

---
James Clark (11):
      arm64: sysreg: Add new PMSFCR_EL1 fields and PMSDSFR_EL1 register
      perf: arm_spe: Support FEAT_SPEv1p4 filters
      perf: arm_spe: Add support for FEAT_SPE_EFT extended filtering
      arm64/boot: Factor out a macro to check SPE version
      arm64/boot: Enable EL2 requirements for SPE_FEAT_FDS
      KVM: arm64: Add trap configs for PMSDSFR_EL1
      perf: Add perf_event_attr::config4
      perf: arm_spe: Add support for filtering on data source
      tools headers UAPI: Sync linux/perf_event.h with the kernel sources
      perf tools: Add support for perf_event_attr::config4
      perf docs: arm-spe: Document new SPE filtering features

Leo Yan (1):
      perf: arm_spe: Expose event filter

 Documentation/arch/arm64/booting.rst      |  11 +++
 arch/arm64/include/asm/el2_setup.h        |  28 ++++--
 arch/arm64/include/asm/sysreg.h           |   9 --
 arch/arm64/include/asm/vncr_mapping.h     |   2 +
 arch/arm64/kvm/emulate-nested.c           |   1 +
 arch/arm64/kvm/sys_regs.c                 |   1 +
 arch/arm64/tools/sysreg                   |  13 ++-
 drivers/perf/arm_spe_pmu.c                | 148 ++++++++++++++++++++++++++----
 include/uapi/linux/perf_event.h           |   2 +
 tools/include/uapi/linux/perf_event.h     |   2 +
 tools/perf/Documentation/perf-arm-spe.txt | 104 +++++++++++++++++++--
 tools/perf/tests/parse-events.c           |  14 ++-
 tools/perf/util/parse-events.c            |  11 +++
 tools/perf/util/parse-events.h            |   1 +
 tools/perf/util/parse-events.l            |   1 +
 tools/perf/util/pmu.c                     |   8 ++
 tools/perf/util/pmu.h                     |   1 +
 17 files changed, 312 insertions(+), 45 deletions(-)
---
base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
change-id: 20250312-james-perf-feat_spe_eft-66cdf4d8fe99

Best regards,
-- 
James Clark <james.clark@linaro.org>

