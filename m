Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAAA2D5A0A
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102453; cv=none; b=W3CRbHp7TlQuXrsQJjUNk5lVfg3PMqMX+nVVqWQPjhjZvW4+WmbtBkuodXdquDTxkmdPCi/7/CuCCo8ce7EVIBd3fPYrXBWV7w0GUxGvzn4kw6++acTuOORUr4stVOVdOHpbJIMMwTPNvYJ9COMIZZKJVWgzBqMNzszZBvxiinI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102453; c=relaxed/simple;
	bh=IYflScU15MERC9Zz540UEVqxU+WBZjscCwzjZiN7B14=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qNUXwMNtSuPLOzeRPK0dcX96CyJjbeyfAP/4JWvXW/q+YeAtcJt4p6cFYLoA4vLudMfWrNfNeYVemts15OpT5egjhnJbkub9tKT76dks1vAEHW8+oT2sDd4TUW+jpvixclkolDKOy5hBaKFZK4h23agWevfX/MgybuAwLVhYww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fqwhn53n; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fqwhn53n"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45629702e52so18236165e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 05:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753102450; x=1753707250; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dh0ufcKS18VIeF3hRD5OYNulmhznnE/kIuknIcgeqYI=;
        b=fqwhn53ncOhWr7EEcaa8xz+1L1Ry/5tuGqxCHD/mu9pTgQPz7y6/QklIp8reTbcM8c
         ICzcvU5SSdY+b+wQYXLjTcvF9PGRHMHpo+at3iFDAj42+q2sjno+DCTqIbckQ2ULAXIr
         FRtUTB9CQZOnkhCLpOwPlyWXUgjzL5UoafLAER+rKJiqLi1HZlMwsAknSWpLRIx2NPJA
         8yk+AbaShpY7xdilCKhluNkRLxQcNWzOKUl0Cri+5YkWN1VKGfN5PJZoUyYoe82HRXON
         omGEzGNjX6C+MsHDyIeO9+pfvg+6MCF4EjII6DLVZilrQ8XcdQ7d11Go+kdJAIYQf36j
         0smQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102450; x=1753707250;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dh0ufcKS18VIeF3hRD5OYNulmhznnE/kIuknIcgeqYI=;
        b=GCQuiNKz1K8jJYB6co30oFxFsMu3nXGnv5CHzvx2YA3xGxcI1/PuHDIkZLYXLQLeEF
         ozyoQK3VvBQ79ogi5/DAbKdsawFYBqQc2UoFYHLewfCRUAG4aCEHO8YP/X41426ZazAH
         NQUEQ6bL63b+xw8iGJnsmMBFoBE7Ow+oBBVqCvZHraWO4U5LnaUE26ZjNZwChhP9b1j3
         f3JX7HpCaqNAVtWyIqvs27g1wmF8k+DMY0J8qA3cBVHsina45ZmQ9OLn3F8w0Yvozn+j
         xLUSjbnf9Ccz09hNIvl72mz8ua2yUtAKpQnaRKCsnu1+ZGiGP8kyUQxTpoBwS7bmPRON
         IC+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWc+c0EUYmgdJoFchxRii5QFA5rYrnDQbQ+fQdB1QEnMiJJV5GfSFfcGRQpzUWydfssajBACfXTW3LHtcx+CdCL@vger.kernel.org
X-Gm-Message-State: AOJu0YxVF55Pgctjx7MPOPu43I8vjlbfHf4mTbH3ZK56qq/c7UXghdVF
	Elh9b25L96asUaR/NWm9Zd8YeSIgDf8WNjEiQtEn5zhZgAEiZ/np/gAQbG1GrPbRp9Y=
X-Gm-Gg: ASbGncsSfQxD79ZmHwZqmL60+kjllCNuTTqqB+4HNzcknP+NV+33255/MCyOnwiepM8
	qiLRop+Inp9NM1t2Fq625xlpKb6usWB3IPAeGeqD2qupwzRpuvMsb0Dfsk49qp5MwZKmc1xA2gS
	fM8LCri17p9Dz6nmmtbhJLBje9GU7OSz2yxQFZZhPtuzb7aq/AfyREYqPAUuDgOS+4sR3nq7UQA
	dxUGUIYHwMwGWjYU5aO2JeDmLPsQzjVlXAqYBCHm2riJeeW+rFr2aTRBy0ufULswthh/stQ7RZX
	2F1z+CAq/EcORwtfAzcDELOWt/zpieRc8MrOcsvwg84WcbvqmEYBt2YxFy9/NPiZzeZ6tojZKz6
	g8RB7/KCiT8aQ1AmnJBD0MadIFUGjT6c=
X-Google-Smtp-Source: AGHT+IFUoGCCuAibze/2hAjDtbuuTcPZpLvl7q6yRHYVPgV8MyrgagaFMVGFjW5NAfaFTq5/JkuhlA==
X-Received: by 2002:a05:600c:3acf:b0:456:e39:ec1a with SMTP id 5b1f17b1804b1-456348e70f4mr173638145e9.14.1753102450039;
        Mon, 21 Jul 2025 05:54:10 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b75de26sm98995225e9.33.2025.07.21.05.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 05:54:09 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v4 00/12] perf: arm_spe: Armv8.8 SPE features
Date: Mon, 21 Jul 2025 13:53:31 +0100
Message-Id: <20250721-james-perf-feat_spe_eft-v4-0-0a527410f8fd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEs4fmgC/33OTWrDMBAF4KsErasy+o3UVe9RSphIo0SlsY1kT
 ELw3SsbSlqKu3wD8713Z5VKpspedndWaMo1910L+mnHwhm7E/EcW2YSpAElJP/AC1U+UEk8EY6
 HOtCB0sitDTHp6BJ5z9r3UCjl6yq/vbd8znXsy20tmsRy/TbVpjkJDlxikBA17ENwr5+5w9I/9
 +W0dKyAAfs/EKN2QI60M+InsKya5GOJkX4bkg1CEOiPiBEs/oHUA7JgtiHVoL04QvDJO/DqFzT
 P8xf8IelskgEAAA==
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

