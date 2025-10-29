Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94BD3358D4
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752801; cv=none; b=MWT0Mgi3EboAeddiW91K/YxGD+Uq0RQ4EUBzWCtyLPrE/1xTEYnKaFGPkYTmdtDpXpfZY/UalCC0j3fl8qjmcrTZqzVvgPvESCUy7KXZPTzv8254TIzxTl9QgiIMU38WUbBJKvvKsC/R3PdYYWXPa9RC0NCM0V45K9SvB3Z92Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752801; c=relaxed/simple;
	bh=1TP15azltOhFLw0Kefsw27j7zgWEijXVp/Z4E0ktb9A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MloMBipEkdrze301TIMcxyyzTcvX514MWm1qcKwtmfteEzOdUDIoGktYKfCDYhvN5D81cvnxcxEV7HbS5hgH9GYKXG6/1QBF8gMBP3xQsJolDmtYOG9KY/Vo7HbsNjVPkf7YiPHeBnMr0Or4oRpkJF0ZC/C1AE0klLW9A/X5umc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r1LB53ui; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r1LB53ui"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-475dc0ed8aeso42028795e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 08:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761752798; x=1762357598; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OYmI0eokywhHOoY+WBqC2paCFaISLNGO3jCxnQ7GNHY=;
        b=r1LB53uiShVe/HFdD091/iRELowd0zYBmPK13pV5N79xcAkJjyAzFoKeETv2Y1A7d0
         AvIsNExfZXWP4/2f2KWrFu0UPsy1jfHszM8VQrfDcUfFe0iyZ+2PNZNPAWY+UgqNpDR6
         esirPWho6bt/blvTzimoJmSZgXZM4Wgyfc4JGMNWLaCHwFDcVzoyDPkGPLb7Evb81mc/
         FFNuCx9C2tgPPs3SLc9KjUXo7VVi62f5XDvgdNBjYar0p69CcsPLyZXDBi9yLULzdZZw
         Mb+aT08nHsTCRsK3hDcqq32Z+21NYQaK7r2NP3DLcY4uVMuegQmY55H3WIA+5T6SXC2O
         HYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761752798; x=1762357598;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OYmI0eokywhHOoY+WBqC2paCFaISLNGO3jCxnQ7GNHY=;
        b=GPVDhbm32ygy72NDnwMsoAspNJWnCJ3FwbNSwLH3KtBN6NZY5CWkDTzM0gC5f0ZcaO
         kNaGOjAoddcmd8W5Fsy0Ng/6sWEC9yp81HQUFhQ2auYOBj1YUa1r+KetCAneuHse+I9H
         RPd9nvRu60ns9WzNhNycZilBgSHUbrptna9yKRSaBhLwJu8X60bXzKz9pqqXYCEfQvrG
         WCta5T+Jgm2QJAq4LIgPxaDVMzDpvaYRsrzmnIxvcqhgs1eiXVBRBipZmXrw/1IPYBlU
         p9wn7Kd55huwR9/1yyulSQ/wrxI0G5KeX8fUHmVtUEOrgjqokt7PAX0z4AuxEk3HcVai
         fI/w==
X-Forwarded-Encrypted: i=1; AJvYcCWTNEHhOS6Wn9EHXTxBJwDYsnn8lrVlFVuYM7WxtvCjHYZiivbcdllTaElfi8z5lPuMyQcdBxuix5Xk+WVm+6Jq@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm7bqSmNtBsRKY9ofWT2JKhEyH/vCNkRBYYbpFFEDvJCFk1xST
	p17iLPF+ymqB9Ysm8MEeyGdfY05vH1xf+h8a8n7bFzRgJQW7EuSPaDbM2cUHjrbxZmA=
X-Gm-Gg: ASbGncvoDP1tJ0b3cwYoflSaT8HNwV7sxt+MgURRHcx2L0FUga02hJ67AD+WpTZ5k2K
	BEj7BOpR1Pp4L5/ZbX5HCPzlaCjy33chWgSBeqFO0nSssV3BD8dooQU4Ay+j29bn7QMiV451eSD
	tHdB4gqSwVS5818FHIxk7fz3Hh9UBJ5/Ygu8huUCbZG4gGGDJ9CKiWJz0uC8KCf46Wr2MMZ4Tqt
	ZIvVnqHytGS7QhqdIorLn3uEGgGawz09gQnaPPCsGW/3VnTPLD0dthV+Ree+nGwmmi9bGykFrpZ
	H7m6FnYiVzxWlF228DzbvIDd6ZCTbagD/O/he6dGViA1SGgkur68fsG0Kv46WMJzIgyqfPE3JBn
	BEM5wU6RysMcemkTyJ3n0VTw44XfOygdV2e67/auv255pCH/RHrCABugw+nIz6mrvAujAjKZ6Lf
	cJUaPaILD0dQ==
X-Google-Smtp-Source: AGHT+IFwHWp3z0WfR5BEyLr3nsy+4DqHZJcjqlkJZW93LcT7e+RtCP65cMKCJuN+XEYyyExdOCX9Iw==
X-Received: by 2002:a05:600c:3109:b0:477:19bc:1fe2 with SMTP id 5b1f17b1804b1-4771e1740f8mr35479835e9.6.1761752798296;
        Wed, 29 Oct 2025 08:46:38 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3b9994sm53745535e9.16.2025.10.29.08.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:46:37 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v9 0/5] perf: arm_spe: Armv8.8 SPE features
Date: Wed, 29 Oct 2025 15:46:00 +0000
Message-Id: <20251029-james-perf-feat_spe_eft-v9-0-d22536b9cf94@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALg2AmkC/43S3UrDMBQH8FcZvTZy8n3ile8hMs6Sk62i60hHU
 cbe3bQgnZYOL/+B/M5Hcml6Li33zdPm0hQe2r7tjjWEh00TD3Tcs2hTzY0CZUFLJd7og3tx4pJ
 FZjpv+xNvOZ+FczFlkzBzCE29fSqc289Jfnmt+dD25658TYUGOZ7+mHrVHKQAoSgqSAZ8jPj83
 h6pdI9d2Y81JsCCuw+kZBAY2aCVt8DY1aDmTqwK65CqEIGksCNK4GgB6RlyYNchXSEvdxBDDgh
 BLyAzQ17JdchUCMgqbyRkzGkB2X9CdhzN76LVuq6IljtyM4SA65CrkEuUTUDr8fdrTZC/gaRZh
 /wIkTc6+0zKhgWEMxTgzmg4/h9WXmNWxv6BrtfrNyPHp0D/AgAA
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
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Support SPE_FEAT_FDS data source filtering.

---
Changes in v9:
- Fix another typo in docs: s/data_src_filter/inv_data_src_filter/g
- Drop already applied patches for other features. Only the data source
  filtering patches remain.
- Rebase on latest perf-tools-next
- Link to v8: https://lore.kernel.org/r/20250901-james-perf-feat_spe_eft-v8-0-2e2738f24559@linaro.org

Changes in v8:
- Define __spe_vers_imp before it's used
- "disable traps to PMSDSFR" -> "disable traps of PMSDSFR to EL2"
- Link to v7: https://lore.kernel.org/r/20250814-james-perf-feat_spe_eft-v7-0-6a743f7fa259@linaro.org

Changes in v7:
- Fix typo in docs: s/data_src_filter/inv_data_src_filter/g
- Pickup trailers
- Link to v6: https://lore.kernel.org/r/20250808-james-perf-feat_spe_eft-v6-0-6daf498578c8@linaro.org

Changes in v6:
- Rebase to resolve conflict with BRBE changes in el2_setup.h
- Link to v5: https://lore.kernel.org/r/20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org

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
James Clark (5):
      perf: Add perf_event_attr::config4
      perf: arm_spe: Add support for filtering on data source
      tools headers UAPI: Sync linux/perf_event.h with the kernel sources
      perf tools: Add support for perf_event_attr::config4
      perf docs: arm-spe: Document new SPE filtering features

 drivers/perf/arm_spe_pmu.c                |  37 +++++++++++
 include/uapi/linux/perf_event.h           |   2 +
 tools/include/uapi/linux/perf_event.h     |   2 +
 tools/perf/Documentation/perf-arm-spe.txt | 104 +++++++++++++++++++++++++++---
 tools/perf/tests/parse-events.c           |  13 +++-
 tools/perf/util/parse-events.c            |  11 ++++
 tools/perf/util/parse-events.h            |   1 +
 tools/perf/util/parse-events.l            |   1 +
 tools/perf/util/pmu.c                     |   8 +++
 tools/perf/util/pmu.h                     |   1 +
 10 files changed, 170 insertions(+), 10 deletions(-)
---
base-commit: ab29ff9f6fe06d23c16b5565fcae96bad21be900
change-id: 20250312-james-perf-feat_spe_eft-66cdf4d8fe99

Best regards,
-- 
James Clark <james.clark@linaro.org>

