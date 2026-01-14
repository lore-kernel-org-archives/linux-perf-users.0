Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885BD3A0E9D
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406260; cv=none; b=uPZvjLT4/RqUgCajU0lkRL7XvDZoRyzFSVOoUKG6xeNTrS80ueE6MIt2ayuImQatDxr9B0bQLiqrotmhSM//V/C4Y3BNMOo7EG29vU6nKOif4FEzFjZqyGGPKXM8tCDWE2A3gAEACwxt362BB7lDQUWQS9QgZeHxw7yz/w9oFks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406260; c=relaxed/simple;
	bh=5ElnalFA8KbQGgxA9FJrrBGF6Jgk+kBQRWKPAobeSOQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JIfub6zd4aHiC11qcso8pt4O2nVqiUetBj3bw/Mh/gsiRdkDEBJ61/5+PGTyT5dwmW2ZoD93U0cTSam51kkI6D9QJ2rH+458eK1qsGHA+7+RNVLgPjiGcgV++YVORo0fCRtaJmaxESRe7FXvNcerrbyeh5TL122zLc5eXTpdDq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CYKUWHd7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CYKUWHd7"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47ee07570deso10512735e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 07:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768406257; x=1769011057; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rgx8dJXKRMSd4BK7n8pd5ssWXaRYRNm1JG7m+/we6F8=;
        b=CYKUWHd7UHjsSQNnutioLY69uWadc/u/vkxDRZpS+Rc0WSkhqGJwCUvw6Tstlr6hk3
         +uSLUk5Vo4s9EM2m7Deg3tyPoUOthiTxEuMuyY4Jxe81bBdRGyHA9LqitGxfq+aniTmR
         itgTxPQo3j+qutdFwiLWpHF1MhQRR1GoIjsNXk1GACkYJggaf2sJ3IlslcWnZuHTgbtT
         EYwyOmDza+OAl72wpx7nch71MMYfAASwXz35XEsr+EC17C9/lt+DoLUAZoIbEzMTSKEL
         nRYv4p7Y2Y2IIWIHe+QLa+tjS9FjlCm1uvckRD7IQ0NyZfPMYMU5QJXlYhoCcFZMe4Uf
         x36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406257; x=1769011057;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rgx8dJXKRMSd4BK7n8pd5ssWXaRYRNm1JG7m+/we6F8=;
        b=wtHWftUNZPqtRcZP8wIZc51Mm/D23jpl0VELwCbqBjDZn+HLRUouxrJfOmp4XMZrSc
         1ldf0hPN5Lr5gcQ/YEmJurrGmbG/iV2gc4FRGjwLowpo03TtRXpV/3CaMdMZt46HlWNr
         1w1pk8kfgCo5vYHZkCklwnhdedFOwyc/i3pOvGEEzJZpEnj5K5pQUPl+qZMKaW4L8B5L
         QiZUTDKzKQo0+1l/n0Iqyi2Aq3ZXbE0u7Mqvwng/0I5D//caqd0nf/mtmRbqOcegQLDR
         2bnUTHx90p5hIVLtTEdUp4UD1ps9EQ1kFLz2rd1zLCyDAhcD2UyEIZZcNv3/HgYQG6Zw
         +QmQ==
X-Gm-Message-State: AOJu0YylTM65Mpf4QQaM/0SAZPNkn8XwcgXFaibmAMl+7Hy3YAMiPyxv
	xl4/fkpJqlhXCi3ZLG5ilD4ZJM/ul199lrZkAVqd84TzWtYcCFh9DJkXDDlzR1to62c=
X-Gm-Gg: AY/fxX7F7Jwf1zq3yWPy3tcpQOXvm6t9LM5ynwYdOyhc2Wq6NmE3bwTJOOwVhgyo7la
	q67YGn0fCZ5NTw6Sl1mUwH/JQZKx2GaKYdnKrJQnev4Rq3r7nwkEkDQPCVU//ND8igoeU5N+33N
	VhTU6YEnUcERIk/RQMA8iugKuuILtgU6eeJe2sgXKECF+9wGrgPKgZliu5wHRCykXgTyO/QkEQO
	kOiK21UxQaD1atp+ht7VFUrd0vXEPpIGWf/Qs68dgs3In4cr+ZCYJE+MhJNJBzHwSdz+ath69uf
	daUEhIPW72g7i3+jdGRU8ubhiUJZ5CujQ1wEjjqDikR748pAqnslKf4+C1H29fSfn7QadM2bqjz
	x4anJYasQwP3mluBmN6IIDwdq7FteiDMdmT+l6FQ0AJnbwuqMTK+fGiQTU9Jmu2OkdWpsMfEYZZ
	wQiJD8sZboJcYQAMKyMXHu
X-Received: by 2002:a05:600c:3581:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-47ee3371d96mr37276685e9.28.1768406256774;
        Wed, 14 Jan 2026 07:57:36 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee85e8807sm7426475e9.16.2026.01.14.07.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:57:36 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v5 00/14] perf cs-etm/arm-spe: Remove hard coded config
 fields
Date: Wed, 14 Jan 2026 15:57:12 +0000
Message-Id: <20260114-james-perf-config-bits-v5-0-0ef97aaf1ac0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANi8Z2kC/3XPwW4CIRAG4FcxnIuZGZBFT76H6QHosNK0iwFD2
 ph996K9rDF7/CeZ789/E5VL4ioOm5so3FJNeeph97YR4eymkWX66FkQ0A4RSX66b67ywiXKkKe
 YRunTtUrPPCCYCBFA9OdL4Zh+HvDpvedzqtdcfh89De/Xf5IA18iGEiQRB++jBRjC8StNruRtL
 qO4m42Wjl11qDvaBSCL+73y8OKohbM+sanuOKeM01abYTAvjl44tO7o7oABq5VFa+Lzrnme/wB
 SeFZilQEAAA==
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.0

The specific config field that an event format attribute is in is
consistently hard coded, even though the API is supposed to be that the
driver publishes the config field name. To stop this pattern from being
copy pasted and causing problems in the future, replace them all with
calls to a new helper that returns the value that a user set.

This reveals some issues in evsel__set_config_if_unset(). It doesn't
work with sparse bitfields, which are an unused but documented feature.
And it also only writes to the attr.config field. To fix it we need to
start tracking user changes for all config fields and then use existing
helper functions that support sparse bitfields. Some other refactoring
was also required and a test was added.

---
Changes in v5:
- Use bitfields wherever possible instead of converting to a u64. This
  is more consistent with the existing format helper functions and
  fixes a build error on i386 where unsigned long is 32 bits.
- Link to v4: https://lore.kernel.org/r/20251222-james-perf-config-bits-v4-0-0608438186fc@linaro.org

Changes in v4:
- Constify some function args (Ian)
- Move some evsel__* functions to evsel.c and make some pmu.c functions
  public to support this (Ian)
- Drop pmu arg where it can be fetched from evsel->pmu (Ian)
- Link to v3: https://lore.kernel.org/r/20251212-james-perf-config-bits-v3-0-aa36a4846776@linaro.org

Changes in v3:
- Fix uninitialized variable warning on GCC
- Fix leak of evlist in test
- Confirm no type punning issues with ubsan (Ian)
- Link to v2: https://lore.kernel.org/r/20251208-james-perf-config-bits-v2-0-4ac0281993b0@linaro.org

Changes in v2:
- Remove macros in get_config_chgs() and some other refactoring.
- Support sparse bitfields in evsel__set_config_if_unset().
- Always track user changes instead of only when
  'pmu->perf_event_attr_init_default' is set.
- Add a test.
- Don't bail out in cs-etm.c if any format fields are missing (Leo).
- Rename 'guess' to 'synth' (Mike).
- Link to v1: https://lore.kernel.org/r/20251201-james-perf-config-bits-v1-0-22ecbbf8007c@linaro.org

---
James Clark (14):
      perf parse-events: Refactor get_config_terms() to remove macros
      perf evsel: Refactor evsel__set_config_if_unset() arguments
      perf evsel: Move evsel__* functions to evsel.c
      perf evsel: Support sparse fields in evsel__set_config_if_unset()
      perf parse-events: Track all user changed config bits
      perf evsel: apply evsel__set_config_if_unset() to all config fields
      perf evsel: Add a helper to get the value of a config field
      perf parse-events: Always track user config changes
      perf tests: Test evsel__set_config_if_unset() and config change tracking
      perf cs-etm: Make a helper to find the Coresight evsel
      perf cs-etm: Don't use hard coded config bits when setting up ETMCR
      perf cs-etm: Don't use hard coded config bits when setting up TRCCONFIGR
      perf cs-etm: Don't hard code config attribute when configuring the event
      perf arm-spe: Don't hard code config attribute

 tools/perf/arch/arm/util/cs-etm.c    | 201 +++++++++++++++-------------
 tools/perf/arch/arm64/util/arm-spe.c |  17 +--
 tools/perf/arch/x86/util/intel-pt.c  |   3 +-
 tools/perf/tests/pmu.c               |  91 +++++++++++++
 tools/perf/util/evsel.c              | 120 ++++++++++++++++-
 tools/perf/util/evsel.h              |   6 +-
 tools/perf/util/evsel_config.h       |   7 +-
 tools/perf/util/parse-events.c       | 248 ++++++++++++++++++++---------------
 tools/perf/util/pmu.c                |  95 ++++----------
 tools/perf/util/pmu.h                |  34 ++++-
 10 files changed, 537 insertions(+), 285 deletions(-)
---
base-commit: 54a23bff770961e024e2c61cd1f46888190c3e79
change-id: 20251112-james-perf-config-bits-bee7106f0f00

Best regards,
-- 
James Clark <james.clark@linaro.org>

