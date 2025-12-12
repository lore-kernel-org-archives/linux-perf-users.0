Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD6C281341
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765553562; cv=none; b=OBrLYCb8UbLFwrmtNQtTFZPVfXQWZq2qJ7d7N6MXCE+fEIHXnaowU2LMkpovOlInO8IRrRwaQfug4Yk3nnO3QtMpmJpQn4B8qDftQhyi8ZVjo7WROfqLUO96Q3boSzkUaBvOANKdlr8+9TdrNW3lRSiG0TdxqWbCSiaT6ta0Y+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765553562; c=relaxed/simple;
	bh=BK+Qouv1DIQp0jA2abm0FO9vkQ/3kfw18gR0j0YrKTo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ErxVARfWsoZ3uzi4Iq9j1SoojU3B0M+mzURRqgP43BWvhudwSm9ORHqBOp4yQMFWCH2QfDsVIQ+NEcoYdbAfUpjZA9Zpe9c2JCQGpLU5VazF1REwl4KCtQ9fbiG+DMUFE3RiZTUToZaNicpSvJ/Ve0OzgTxnDPeNQ26m3OfxuTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mf5BN57W; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mf5BN57W"
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b79f98adea4so209764266b.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 07:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765553559; x=1766158359; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6wTVU0HQcML/U5Ma12iYvsQExc4mXY0n/RGu05cTBVU=;
        b=Mf5BN57WwQrc4h/bZiPGPtFPtiVFke4/+3iM6cMw7lhiy7es3roqH6kuylhm4/uPxU
         1y3Bb44i7tMfC2i+8HEMC5yIZjPaA8DcNFd9tcu/UxUFxZT5y56+YtSRqK1Dq3kLUwly
         Qg6duGOxOA4c4+kI3lXjEcYcPxqd8904klUGXgnNkc2/VTCu4vjQzdukVlJDeeJdlFEQ
         J45wTl6OD8NXtaOtamnzaJWfjQjMeoFMxchaK4TYOT2vt7NIkx5Yf1ezHo6K6cp1Wjrq
         ZD+GAy8e9eLrT1EQ4YoGi/QvjRJQB9+EU/9BVtbPELjtcr+mNVsh/pQ3tHGZ69Cy+pQB
         A4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765553559; x=1766158359;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wTVU0HQcML/U5Ma12iYvsQExc4mXY0n/RGu05cTBVU=;
        b=bc7TuztNI/Ef/Gz8jBrJ3eWvsi0Xf+XFAoyP8mZZbpXBo2wTpNlKlCR/mPuiyqKK5z
         pWEREZhjYFNft960d8/7ttyprxuHAoslqPiY5/6zXPIo0iT77mw9XmB/60keWl0IYsSc
         rsiCyl/asGs/FWPRduvHBUhmjq2PdNU1x1fRL4W3fhNksoVmcB/Pyh6AsuHmDM7TTkmw
         9SwRj/yuAUs8+zmY58EoF9W/H3weAUEkbtkHn1qTy29aTJEvWdshRXFTY/L4u+GXdxnd
         dkYTJQ7D8tT77rrddttpTuy152T5/bVqu9eID9NceA2CklKKyGfWzrMXsCOvVrFWrN+C
         iI9A==
X-Gm-Message-State: AOJu0YwWwAGOsIXpXkh66vnUU+emRt8qJylbbeL8B0V/S4Y/g/yzKuhM
	2xpuXM23xYWuDJlgjT188O5UR7fwUEq8GnIAAknhtficFM513ExJnttsc9sffHs5e+s=
X-Gm-Gg: AY/fxX4dByzreZSAgU+cbAin45Y6q5NjEoeWaA2+7ZJl2P0a4jtzV9hRHaAfZRggKwV
	G5ccDA5NVaEloV/BaXcefHrilLESMXxv75+KdDvRe9kU5ljwAl3X4lZEV7NtoznoI4eEIwcsUU1
	wptUGMaSArXYujurZACxuV3EX+sr8HJuCtAv8kSlsrPog0QbEtE7y4X3ofZUJpTGMfwafkmfb1f
	gn2lOgnoA3mnSDhehDh5my2Oavqkz7u9mzWRj19EHZJbRGF2uxpiMBiygytvp+z/zZpMhhoKkUl
	vwScb0kMFc+2xpsNAxtKEcxV3zbaghwDIeIs3WMiLSlPM1OC+PeyIZPpEA9hPSpwXahRZovgFpf
	tvSkHuNR3Pnr1wT4pQB/eSD7twsbv4K+2MOA+DY8GUvno97R08EgjbLpRuNNikL0EPIwJkqoOhf
	9eTSJXFyk9y6yDzHn3LGF7
X-Google-Smtp-Source: AGHT+IHM3bNfdM96Kzos3FUn4XqLiaZCJ92JSG8XKa4CBCiU4GR8q36GeeQKRgso6l4CDG9nSZC8CQ==
X-Received: by 2002:a17:906:7312:b0:b76:23df:c997 with SMTP id a640c23a62f3a-b7d23cda902mr264214666b.54.1765553559136;
        Fri, 12 Dec 2025 07:32:39 -0800 (PST)
Received: from e133063.arm.com ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498210ed32sm5433234a12.29.2025.12.12.07.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:32:37 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v3 00/12] perf cs-etm/arm-spe: Remove hard coded config
 fields
Date: Fri, 12 Dec 2025 17:32:17 +0200
Message-Id: <20251212-james-perf-config-bits-v3-0-aa36a4846776@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIE1PGkC/3XNQQ6CMBCF4auYrq2ZDirgynsYF7ROYYy2pCWNh
 nB3C250wfJ/yXwzikiBKYrTZhSBEkf2Lkex3QjTNa4lybfcAgEPSimU9+ZJUfYUrDTeWW6l5iF
 KTVQqOFqwACIf94Esvxb4cs3dcRx8eC9/kprXL4mg1sikJEhEMlrbCqA05we7JvidD62YzYS/T
 rXqYHb2jQGsVF0XGv6caZo+BYY0pAUBAAA=
X-Change-ID: 20251112-james-perf-config-bits-bee7106f0f00
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
X-Mailer: b4 0.14.2

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

Signed-off-by: James Clark <james.clark@linaro.org>
---
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
James Clark (12):
      perf parse-events: Refactor get_config_terms() to remove macros
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

 tools/perf/arch/arm/util/cs-etm.c    | 193 +++++++++++++++------------
 tools/perf/arch/arm64/util/arm-spe.c |  15 ++-
 tools/perf/tests/pmu.c               |  91 +++++++++++++
 tools/perf/util/evsel.c              |   6 +-
 tools/perf/util/evsel.h              |   2 +
 tools/perf/util/evsel_config.h       |   7 +-
 tools/perf/util/parse-events.c       | 248 ++++++++++++++++++++---------------
 tools/perf/util/pmu.c                | 112 ++++++++++++++--
 8 files changed, 460 insertions(+), 214 deletions(-)
---
base-commit: 2eeb09fe1c5173b659929f92fee4461796ca8c14
change-id: 20251112-james-perf-config-bits-bee7106f0f00

Best regards,
-- 
James Clark <james.clark@linaro.org>

