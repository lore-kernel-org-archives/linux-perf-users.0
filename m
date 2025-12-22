Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696C62F5492
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416490; cv=none; b=WbFiZ6JG9H2NLIVi+Rn6FE3JsE+x7sL7GUlrBkBqDcTDxpsgiE8A57jqco+V1DVhVFhIVlD34ws670NQ3sPoaxq2ad3QiRBMK8XTxYGah8kh6L1wBYxCNtEMrQ5ywacu5foFlZHjnc3ZW+5lLG3Bova1M/cFY9sl3xZ7qcgpPQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416490; c=relaxed/simple;
	bh=53i3a6LzQqYU8Q1kaLrIZuILze95GhG1zWxaH3cgDvs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uPBZmgkwXYeoLmI0v32KDyCa6vMTd/NSeejv+YmfHr0idQxBC++PBOqaylyX8g67QcTzEOgWPpcNYTpZ3XnYnC2jKXamwh1IJ2Nn2ILGTXoamGfkhBCUZu+RPWrUFskSl/HrFd4hYhVdF8HYPHGf674DBWrDWF67QkcNrC7dy8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x98pz46D; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x98pz46D"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fb03c3cf2so2105121f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 07:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766416487; x=1767021287; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9LJhS2nq8ZHS6T/QvSCJ9XFnbSCF5NsF3Smsb7IoFAo=;
        b=x98pz46DxOgy1mgqZePFKIPPtbMcFf7fuqfPV8y6zRrQLw9IBLQ25/9Bo41lePym72
         JfLEE6k+fClxTO/PF7/3n8o9Ven08mHxAyMbDhb6ya+rW4nromAG6k/bBtX/sItm3QfA
         6pygUO/JtcCD9zWteJrWo2FXlBdC6WLdVg8KYLqbWm7TrlyFD37xhDi3I5BeRoQ/aGWu
         VQfgeKgrD4/8v7ic9geXjs0Ao54+iArBefKKACXQpyAmYQ9KAWou/q830O6an6bF9MxN
         sQIQIYaVN8NvNf6uRYeWznPPfXu07xnvGir/S4DXclq8sR+2SfeViuO9Yvld378P1JGX
         0GCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766416487; x=1767021287;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LJhS2nq8ZHS6T/QvSCJ9XFnbSCF5NsF3Smsb7IoFAo=;
        b=h5VJicQBPgi2WKxFSmlHcrWhhecuI0exNRxax8H/Av/oXQrR2Ul8XMLimAl77qvOQy
         SOt3DW7EM3vJh7sgJBKhuZrKc4r3x1qMTeZAkZPAVCt9W1WJFNyhpiU4azFaNkDgpm5y
         TgGFn6+fzNG3Cy3s2whVECgJHH33babnXjNGt3G5TLcpgBbMfS+fKCywIKphFANg2o1J
         x4KZ8YCvPS8hEk0X6VufOM/+2MEVGLHMT9hcXsjSBZuGyUjdhhgQjbGIH8Am1ZLqq65f
         LyCq5OdZtbZ7e6/Rff9KABPOgWN3Z3IO2esdBOmO1HsOCjvDM/mWwlPhAuW/OJQWBMX1
         0g6w==
X-Gm-Message-State: AOJu0YyxwI+JtKjDvqSl0szfFZtJjJA8pGhhXNvAF2jYWQqkrjaZA4HF
	GkbX3zijtAexhO2iW4UGy7ymAfbHhtSKvRvvGau3pOYdjgLLPMvF86P+bWlEtu44f+0=
X-Gm-Gg: AY/fxX6bLo1RkSEsj6Vp5s6+1l2awICrtYe3vUxuiLYWEE+cWFRLdzDCmmZRr74u6p+
	nfRACbGsHJF7yk9k0K+wobxwZdsEi5iRsd+2ObcWX6dpJ3u/L5u9gThxD7OP3c78gfEJihM74n0
	Vb0dkpirIma3/Q77QWEeOwNoZzzyVQcA47kh62RrFXIuHmYXp4PjlA1cMCSueNdndA9yZijSlf+
	vUdSjd1bVYwNe7xjlSXo9huCn2uZ6vG9r2qT/60j+3tEky8zikcP96CukQihhP33/38TgdjsyrA
	qmZg9UqWQ+09x9RXtdutP33Cec3tbr5g2h3uTG85ziuzmTYRy5mGJ2Eqm/Yr0RVxLr7ybxql1Un
	D4LJBS+sgR5PZtPnI3PgWAwGHDT+WVyatUIaxWBL+SB34kCoOO4BnF++V1D2zmjG+AJa2Q8ulmA
	oaRo1csCUX5UK8SNquQW0T9dPPuMoz02w=
X-Google-Smtp-Source: AGHT+IFn92lYsDgvK7tpXNAPQ0WsUj1chzC1o/mtl8WTQxCYBCBN4igonzXBapuvSBdZM9yNW4+VSA==
X-Received: by 2002:a05:6000:144d:b0:431:74:cd5 with SMTP id ffacd0b85a97d-4324e50b758mr14849127f8f.45.1766416486681;
        Mon, 22 Dec 2025 07:14:46 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830fesm22750093f8f.20.2025.12.22.07.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 07:14:46 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v4 00/14] perf cs-etm/arm-spe: Remove hard coded config
 fields
Date: Mon, 22 Dec 2025 15:14:25 +0000
Message-Id: <20251222-james-perf-config-bits-v4-0-0608438186fc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFJgSWkC/3XPzQrCMAzA8VeRnq2k2dyHJ99DPLQ13SK6jnYUR
 fbuVr0osuM/kF/IQ0QKTFHsVg8RKHFkP+Qo1ythez10JPmUWyDgVimF8qyvFOVIwUnrB8edNDx
 FaYhqBZUDByDy8hjI8e0NH465e46TD/f3naRe0w+JoJbIpCRIRLLGuAagtvsLDzr4jQ+deJkJv
 51m0cHslNoCNqptCwN/TvHlLL+YiuxoXVS6bMqqrqsfZ57nJ3S9Q8RNAQAA
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
 tools/perf/util/evsel.c              | 112 +++++++++++++++-
 tools/perf/util/evsel.h              |   6 +-
 tools/perf/util/evsel_config.h       |   7 +-
 tools/perf/util/parse-events.c       | 248 ++++++++++++++++++++---------------
 tools/perf/util/pmu.c                |  95 ++++----------
 tools/perf/util/pmu.h                |  34 ++++-
 10 files changed, 529 insertions(+), 285 deletions(-)
---
base-commit: cbd41c6d4c26c161a2b0e70ad411d3885ff13507
change-id: 20251112-james-perf-config-bits-bee7106f0f00

Best regards,
-- 
James Clark <james.clark@linaro.org>

