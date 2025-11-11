Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D181D358D2A
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861113; cv=none; b=tPqspBT/z3n2VwNJcM6bZgKWjjCxydj7v+15BElfZSzfQzl0HULc2B7F9OhMc5XxJiZu20hmqeCeDefHpbDHqB65j+rDKMwpWkb6M/W1/nPcCeNK+6WBoUT7HFzmaQiBFq99ZGGo0/9B9wpFPSpW74yK1IGK5xM0os7G4VlSFO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861113; c=relaxed/simple;
	bh=p+vt2lL3S9xP4IyWscwu6QjVeXIhxG41ki0RXYh2bYM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y6zalMR7sgAbqGqILbLXfavKrkjE0Hn3XNfGb4LANkPgcq5XDlHdawjg3FIChqalrq9OqFkrts/aSl9Ml/xqFMjNORAissydSYEQzakK6/il3vKQVWHPwHLqPi4KYRjHyLa6RjrT8/+64hQ/gXRJqUsIpC0qj3soCql8niwu80g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kI9QfxA1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kI9QfxA1"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4774f41628bso3348365e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 03:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762861109; x=1763465909; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ApNFjpZHiOUYvgtaOudntt1C1VCpeRhzgKLy7o9FKa0=;
        b=kI9QfxA1Hl+Ej4JZ76xrF8++DtH5w3P2Io6M/o4G0sxVKLmH9ERJPyfFSSkwMgptUX
         e0EEFNNK260E0Tqjjxm67G4JvYMXDk3XXnkn3bssxQYvazPxFfUvztLXG5Dk6okUeKKk
         wEdAz0iHoSKp/zvEOb3XTy+M1DarkD3KO+deYI0r1NJFMduShuoKuipx22y4vH5vlG7w
         En4KYD9OVE14rTTQl3XmFcPCpEMQteC/uFYSl11yMdV4zADc/cehLxt4kz5LPeVYiTo8
         FA2/dv0fcLqhD35zxb2CFf3A2fh1RfjuDYMm847IEobpB4Cn1s5N1WIK8VwlpL/xJaEL
         n6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762861109; x=1763465909;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApNFjpZHiOUYvgtaOudntt1C1VCpeRhzgKLy7o9FKa0=;
        b=WL/c2XgX9pOGxLtEI6yIqZU4ZunfK9fg5g47P5KASa/Xj+AgzmB3gySAuWAj1vh80U
         4B/e29Y9wLJzntozCTS3qagCgo7E8UpgSWh/fvQilQca5Ra1vt4bICVh9Ilx59W1UJbp
         vJDItOiQXnt0u5iPy2LuuDp/6aTCVfzgfegfDWSidgS1XHRO6bjarzcSKBuc9IjQkmMV
         4L3I9cWy5DXh0ESKMpRSy70IU7NBoIn/WlwqenIqidoHpR/a1Wj1KT49soP7tqjVSvcI
         kPt4/emvpFq+kvvZFJZq++aap53MbgTBg1yA921f85DEfL7yDa47IB7aWz214h8QHOdM
         qmjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrGNuiRMGB+4VCOifwPR7ZDw3Ov1b/r3Lt2AotSpGbgMNe2buFXazHmOPRg6hFj/TzrRjyXNcNg35jzeLrzJcY@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ae6SBqYeEUb/08kO4Jx5Ns39tuCIkeJLdSF6Vd58gNTJx5V+
	OvjiApdQ06k+Kf7I3l1br7CbuOUAAKyMIeR5Wgq6YYYBd2yaiuh90kOXH2wX/88s4eY=
X-Gm-Gg: ASbGncvj3kJejavkYFMzQcHqolBapJAPZpTmxBwqhHIHoPzs1GHJ1p9kwcPxydAKJQh
	egDD4o2LrgltIgb2wDfawOgZz8gkNzdPrlq5QqV+iU2OkgXx8SK6bxqHur205GOFLzOvdVCZFt4
	mQFMxRis5mnR+2g+QMv23upwEmNwPseiAmgdLvmzWtDy9l6Q8HNrDcf7M/yqioUYe7/RzuveCZO
	yvi0eE2XGP4V9kZms8PLioq/Mt+LtQ2a7lk5UpCCyvndC9ih7WBffnfyHTms+6fCFLMPL00Hq2X
	rHqzOf3OFiuGqULojwDEI9ebBM4Jvk8YYywqDxzAG8Om/qiQu5da9Jfy593DzJxtBO8HaEYV4FW
	iCW2PZZMHS3YGcdG0C05lEyNRZRKBusUoRdZO5kWzLRebCqdOvgW+odcaKxin+7vpChg4f8SvJe
	en2fa78IaPsZwMPBWamsA5
X-Google-Smtp-Source: AGHT+IHEHlUutl0pFeJ6Y+KwuVxOVrcZ87z0GEdb/YT/7CGKNgzL11KQ5qkLQpD/1daWqDjU8+9Wsg==
X-Received: by 2002:a05:600c:820e:b0:45d:e775:d8b8 with SMTP id 5b1f17b1804b1-47781418886mr28948915e9.1.1762861109025;
        Tue, 11 Nov 2025 03:38:29 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675cd25sm28133486f8f.22.2025.11.11.03.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 03:38:28 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v10 0/5] perf: arm_spe: Armv8.8 SPE features
Date: Tue, 11 Nov 2025 11:37:54 +0000
Message-Id: <20251111-james-perf-feat_spe_eft-v10-0-1e1b5bf2cd05@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABIgE2kC/43S20rDQBAA0F8peXZldvbuk/8hUiZ7aVe0KUkJS
 um/uxvQtMQUH2dgz9z23Ayxz3Fonjbnpo9jHnJ3KAGHh03j93TYRZZDSTQIqEBwZG/0EQd2jH1
 iKdJpOxzjNqYT09qHJINN0bmmvD72MeXPiX55LfE+D6eu/5oqjbxmf0yxao6cAUPyCEGC8d4+v
 +cD9d1j1+9qjQlQoO8DIUgL0UZpFb8Galcjzp0odOsQFoiAk2uJAmhaQGKGNKh1SBTI8Ba8S86
 CEwtIzpBBvg7JAgEpNJJDsiksIPVPSNXRTOuVEGVFtNyRniELdh3SBdKBknRWGXt7rQkyVxCX6
 5CpEBkpkkmEyi0gO0MO7oxm6/+JaIRNKNUfkPuFONw7v6v/CFEJ3TqfnLyBLpfLNz3FEttJAwA
 A
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
Changes in v10:
- Pick up Peter's ack
- Slightly clarify commit message regarding the difference between the
  data source filter and the data source
- Link to v9: https://lore.kernel.org/r/20251029-james-perf-feat_spe_eft-v9-0-d22536b9cf94@linaro.org

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
base-commit: 081006b7c8e19406dc6674c6b6d086764d415b5c
change-id: 20250312-james-perf-feat_spe_eft-66cdf4d8fe99

Best regards,
-- 
James Clark <james.clark@linaro.org>

