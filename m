Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1931527A939
	for <linux-perf-users@vger.kernel.org>; Tue,  6 May 2025 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746531756; cv=none; b=QRVuYAxfi6ENHpLmAAxumNtAA/7khIKrjSE1WgGfA248qvq8HxYSRiqD8wB4qkEmHxsO77Gy68UsekAohMfBCdUqFbp7xFAre/uwdbvDSWx/c3l2GoWzyhPhkUwbHCqXugoT3vhdYSYAwrjbTZd68PDyfVIF3QkkWiKP/I56eoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746531756; c=relaxed/simple;
	bh=53o0sYJ2SFYzmVWDlseNZHgWWvafm3wu94/O9xTHfuU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gqBkMn+QvYLCV6neCGaglrHrcW9G/YaTdGtoo3OnVGWqb+xBJP1Y1evVb7mCogI6oCQHLwoqeu4dt3MFbCPpcXuY2VBiGKIQUvamx7Mh3WXBj7+Iy7GLVUXwJXyyYQ4SqzSWYOE2RHlJxSviGC5V5HEqhTZKIePx9MKCAyTS3jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EgrlL2Yx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EgrlL2Yx"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-440685d6afcso48681445e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 06 May 2025 04:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746531752; x=1747136552; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nn7zwwW1+OwGIV0wfJqgAgTa7HI6crOwjPKwSXJSzwc=;
        b=EgrlL2YxItiz4LuspyM9Fbyo1Boyf6mWOY8Nxts2us3tIcHRS/lfM5RHIP+lxtEPI5
         44A6ofRCtDJJNvyl8Bw1pkiGbQDtCnPzk0paGm8TQf0UiSowIx0vNYpoto/dIP/NMx4W
         tM6iib2hJXr6S+Sk9bSxfeDQWBQVAJnnpsl4A/Yc5kI9Wu1Yh7xqL6DaOgzDN58XNPrK
         iyfP7fTr1FRbDBCnm5adl0IQ3m55bbzeD8oVxDxNOmPmElwd0SchmTLRQH4F2lRgnozb
         O1iJUDJr2OTOfAPC9phxCbXTWnu1tMnYQO03BppXKYJBX1jxw/E0LAWvbT1A0YW2Lr/2
         c1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746531752; x=1747136552;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nn7zwwW1+OwGIV0wfJqgAgTa7HI6crOwjPKwSXJSzwc=;
        b=NOaHN5Tb6GLjhY57XXSCIEpJaOW0V9WIVnCtq9KaZTuw5nCFVIY3aquVngsNOe4Ih4
         QUZ1SQ7XtvmAn/zHJwRABUO/80CZAdScWtStekNxEa2QwZjJkar9Mp0HYZQ5Qj46HW8L
         Jn7n7S+782xAhIQyaN3XGM0jY8LKr6PyUfGCsIwo1uBKrM7i/lNiZHEupbL4+Hu+mQKk
         g8zinoCEybVqA/55UNmKPk+VSPF0TAcwLquSeR0fCGcAA4mC+OfUggvnFbtlgYw8j47a
         Qtp0QshZhWiR+QW91exRrNuyw/w9kiHJS5DCuAWKXRcf/CGf2alL6id0xiVvqbAkHUj/
         SwwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTpeBVFpGO84tQb5AmccmMubiqk/jjxqUQL280y9o+MTbxX1ffWs7vLTP/55Qcrehi45RNMP1+ZapwRF7+rn/k@vger.kernel.org
X-Gm-Message-State: AOJu0YwI8sb2dftPZLm5Y5s9jz4PHCr3/9aFgNIElrCdUDw4SOQMMsGV
	SXCZgPUKl7tcQfyzmHwoTRSJ8FU7PsHE7sK5ngIs64xiBxW2YgJrKAHDZPJ4H4g=
X-Gm-Gg: ASbGncu0+zOI3nCPuFCEIwoOxoFGwRXt3/Fp2hvGHrPvZITdySYygY0SchrE0NExnP8
	P1xmHcMPVsUH6jBot78/Z85JzAO6eaUMQ+2LsQVdXHxXCaX6rr2vsKN1AAv63TlpkNiynrFbn9Z
	w0pa1LPL/POmOg+EJdK8CTcQDTc9qMxpcY30kGk1WSwEo6L6qzTN1lrSQMdvjzCSbgPx0pgX04p
	MaAHPoYhRZrNn516DCc71Ny+tHTnQKAEEOAe4+F0Ti/aRIFm1djIT37jHNIG1U0v2xIzvBUxWCL
	8vcDaAORI9lWPqowUAwfyD+3DwajlqhpkHlDjOl7x/9wqyr7/c6njwkuBw==
X-Google-Smtp-Source: AGHT+IFOFC/HYp+b/sLqshfj6fUDhVXxkvGd1k4jKO8z9uXGvrvvByGxLJkY/vukR63GyNj7W/KV9Q==
X-Received: by 2002:a05:6000:2405:b0:3a0:80b2:eedc with SMTP id ffacd0b85a97d-3a0ac3eb337mr2198218f8f.52.1746531752133;
        Tue, 06 May 2025 04:42:32 -0700 (PDT)
Received: from ho-tower-lan.lan ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae344esm13198473f8f.25.2025.05.06.04.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 04:42:31 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 00/10] perf: arm_spe: Armv8.8 SPE features
Date: Tue, 06 May 2025 12:41:32 +0100
Message-Id: <20250506-james-perf-feat_spe_eft-v1-0-dd480e8e4851@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGz1GWgC/3WNQQ6CMBBFr0Jm7Zi2IIIr72EIadop1GhLpoRoC
 He3krh0+V7y318hEXtKcClWYFp88jFkkIcCzKjDQOhtZlBCnUQpFd71kxJOxA4d6blPE/XkZqx
 rY11lG0dtC3k9MTn/2su3LvPo0xz5vR8t8mt/zfJvc5EoUGmjhK3E2Zjm+vBBczxGHqDbtu0D0
 veHVL8AAAA=
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, leo.yan@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev
X-Mailer: b4 0.14.0

Support 3 new SPE features: FEAT_SPEv1p4 filters, FEAT_SPE_EFT extended
filtering, and SPE_FEAT_FDS data source filtering. The features are
independent can be applied separately:

  * Prerequisite sysreg changes - patch 1
  * FEAT_SPEv1p4 - patch 2
  * FEAT_SPE_EFT - patch 3
  * FEAT_SPE_FDS - patches 4 - 7
  * FEAT_SPE_FDS Perf tool changes - patches 8 - 10

The first two features will work with old Perfs but a Perf change to
parse the new config4 is required for the last feature.

Signed-off-by: James Clark <james.clark@linaro.org>
---
To: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
To: Jonathan Corbet <corbet@lwn.net>
To: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oliver.upton@linux.dev>
To: Joey Gouly <joey.gouly@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Zenghui Yu <yuzenghui@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Jiri Olsa <jolsa@kernel.org>
To: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>
To: Liang, Kan <kan.liang@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: kvmarm@lists.linux.dev

---
James Clark (10):
      arm64: sysreg: Add new PMSIDR_EL1 and PMSFCR_EL1 fields
      perf: arm_spe: Support FEAT_SPEv1p4 filters
      perf: arm_spe: Add support for FEAT_SPE_EFT extended filtering
      arm64/boot: Enable EL2 requirements for SPE_FEAT_FDS
      KVM: arm64: Add trap configs for PMSDSFR_EL1
      perf: Add perf_event_attr::config4
      perf: arm_spe: Add support for filtering on data source
      tools headers UAPI: Sync linux/perf_event.h with the kernel sources
      perf tools: Add support for perf_event_attr::config4
      perf docs: arm-spe: Document new SPE filtering features

 Documentation/arch/arm64/booting.rst      |  11 ++++
 arch/arm64/include/asm/el2_setup.h        |  14 +++++
 arch/arm64/include/asm/sysreg.h           |   7 +++
 arch/arm64/kvm/emulate-nested.c           |   1 +
 arch/arm64/kvm/sys_regs.c                 |   1 +
 arch/arm64/tools/sysreg                   |  26 ++++++--
 drivers/perf/arm_spe_pmu.c                | 100 +++++++++++++++++++++++++++++-
 include/uapi/linux/perf_event.h           |   2 +
 tools/include/uapi/linux/perf_event.h     |   2 +
 tools/perf/Documentation/perf-arm-spe.txt |  86 ++++++++++++++++++++++---
 tools/perf/tests/parse-events.c           |  14 ++++-
 tools/perf/util/parse-events.c            |  11 ++++
 tools/perf/util/parse-events.h            |   1 +
 tools/perf/util/parse-events.l            |   1 +
 tools/perf/util/pmu.c                     |   8 +++
 tools/perf/util/pmu.h                     |   1 +
 16 files changed, 272 insertions(+), 14 deletions(-)
---
base-commit: 01f95500a162fca88cefab9ed64ceded5afabc12
change-id: 20250312-james-perf-feat_spe_eft-66cdf4d8fe99

Best regards,
-- 
James Clark <james.clark@linaro.org>

