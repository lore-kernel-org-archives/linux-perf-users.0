Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B66427FD76
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Aug 2025 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163561; cv=none; b=qLrhyLixDQpzx+2to2/FGUukKIyrNHB4jmz0dKGnqdtaQWm7Bj5AN7HV6eOJog9wXiCDqg8Zic7CQuJpBPkcTklahXGHd+SaazjhUc9jIkdxf+hsNMSXj6t3HIENI/M1nR6sn163sT0xIQDFnBfLnxMpDlWqPsuDVv6UGG1o6U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163561; c=relaxed/simple;
	bh=vZt4y1xzXM2B0r7bPL4MAJjGUGj9Xtb3vhQWkxkwSiA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ayY2adtdVhTH+CgjVDH6jAu4SC03923988nha7efR+tqOZCvkK+P03s4cDs232Awk1MshW47Umw7+OBk72MRIHce3OEg3iyACMqgGQ63djKOtoX5dmVhjMFfQkGg+7tOZ/RRhpLwGlia0iu2EFBEJfr/suSwEaMHHg9mU5u5fi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e1/GBGIt; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e1/GBGIt"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b066b5eso3225125e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Aug 2025 02:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755163557; x=1755768357; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=caKBHp5j7/gqOP8pJYBB+m+OwHzfEzblmPGpxjdh1VA=;
        b=e1/GBGItkOPuB/BOxvbBsSA+3Mp/+EGDKezCfzDumtsfOnDymU1qQsuqp1h3m4ins/
         uSwWVQWecGGmv4gRfnTPnD52WrHG6pl12jc2dww6h8dXvs6+DbBCFiiHTotynHsyCQLy
         T+U9BRpjk70eW33WGkk8KnWzOdzn0GHFm73b8MqOAg+FYPpoWdUKLemeWZXGaSd7ZqOL
         vq4d8OaJ1Sl1vQAORBl6dCI1UycWjppSi2/8eUl2y7eDImUovShwkaQK7pRQTPDr7mQ0
         Z18IC69loFOlgKsNGhX04LR8ySiSB4ocxzFkVtePP8567M1FYp6yXTMR4Zz8EhfzhTJE
         euxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163557; x=1755768357;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=caKBHp5j7/gqOP8pJYBB+m+OwHzfEzblmPGpxjdh1VA=;
        b=ZMQqf6IUrsCiK7zEDENjurGiusJqCetJTkQYwVxYFegr56Xt2S/OQm6gkbQ2bPu4HS
         e/hOpZ7EL9VO8e3JczElTGV19yBVjaPX0+vJGncZmZVdezl413HWhn20KueRL7blSwXf
         t/d5ZqN0sseb5hG212AJ7G9SfbCaHt1CyX8LcOELwnkH6oFOcqLSHwyYvEMqF4On8UUZ
         nGrMI3Iqf16HgV9uz7whR1N1Riqw27UDnQKqYFPlMtWxz2Okz4JBtTn53xMc3wtEdMxL
         +jUEOl3XtzCO4fbig8isN9/OO08kK13J0BQIl7XtGfgA3pBsgdIlGWJU8rwTcl0oFO5T
         3+iw==
X-Forwarded-Encrypted: i=1; AJvYcCW+tl29iUplTTgxKTSGtwyew9HiZlNOWri6gyr+9R3FRxoaST/tD84+0ABRzOLJf0/D49cegIGcKYyuU2t69SA5@vger.kernel.org
X-Gm-Message-State: AOJu0YyjkLpUIUvQKa9Hc/dUxSR6szgQnbo1KRhsoA3X/N1hpGZnu4v3
	zOQtE5MxIkOFJa5n7aBpTGoeB2sCz3F4qv+/PTpfM5VIuhAxRzObNG2rW2ahQ1Sj90I=
X-Gm-Gg: ASbGnctapSn7QJwAl7kGhEqGv+zBEah4tfC7Ayus8anMxjjKyuMi1VfTjRBIuGJa/PW
	FlYIhWlQTcjRiR4bNjZZ3+ww6ydvjFUq7zwE0CRa0edTUUha1iw6iGSY/XgxcWgNrtXhFT1m75f
	ZG7p4O7oqHUFHznQjNVZiJ9EVErB87KEGkOog2/sSqNI89W7XvXBAGtJSh+LGH+DqriT0tFpPhK
	cFG14eoLiPSVErf1KEwiaepKcUAkH4+LW2T54xJLaf3QJ3RwAtBNrIv6OUlrQ4oSU/VXw/IcSkr
	xtoHRKSYng5czTCCkuym/OFa6lyEx3ZtJr0kzWQzA+f3sEeKaaanfLFVn6axarrzBsj5DYFggt3
	c1T6TANpV7cYBIx1bMXCqKkdke+F7lXU=
X-Google-Smtp-Source: AGHT+IFFjX/pyxO97kvg4fUgCnvfBjzIV9RmUUCrFRLJzwl3KMUkNYunWOuq124cI/SZDDfNBj88iQ==
X-Received: by 2002:a05:600c:450e:b0:456:496:2100 with SMTP id 5b1f17b1804b1-45a1b6753a2mr19665655e9.31.1755163557196;
        Thu, 14 Aug 2025 02:25:57 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c76e9basm14536775e9.21.2025.08.14.02.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:25:56 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v7 00/12] perf: arm_spe: Armv8.8 SPE features
Date: Thu, 14 Aug 2025 10:25:22 +0100
Message-Id: <20250814-james-perf-feat_spe_eft-v7-0-6a743f7fa259@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIKrnWgC/43R20oDMRAG4Fcpe21kck688j2klGkyaSO6uyRlU
 Urf3WxBVllWvPwD880h165SyVS7p921KzTlmoe+Bfuw68IZ+xOxHFvuBAgNkgv2iu9U2UglsUR
 4OdSRDpQuzJgQk4oukfddqx4Lpfxxl1/2LZ9zvQzl895o4vPrtyk3zYkzYAKDgKjAhuCe33KPZ
 XgcymnucQc0mL+BGJUDcqSc5j+BeapJLJNo4bch0SAEjv6IGMHgCpILZEBvQ7JBlh8h+OQdeLm
 C1AJZwbch1SBALazikFyKK0j/E9LzavYYtJTtRLi+kVkgB24bMg0yEZPyTlv3+7f2t9vtCzTYw
 CptAgAA
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
Changes in v7:
- Fix typo in docs: s/data_src_filter/inv_data_src_filter
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
base-commit: 0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9
change-id: 20250312-james-perf-feat_spe_eft-66cdf4d8fe99

Best regards,
-- 
James Clark <james.clark@linaro.org>

