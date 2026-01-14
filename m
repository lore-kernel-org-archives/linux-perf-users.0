Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0946F3A1A3A
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406273; cv=none; b=IcyXh+ZX+p1eccn1u4TGZx5udovxCqoPS4YtQywoxhJhkyjR6eBbpxOwxUGGD1C62vJSczw3RP6lwb646ssXELXyae4QO48zoY4BZBz33fQEIQzxpDdvq34UbQKvdEBcFJfP7zBBSbdlNb79FUIGWhRkd46jKzDldT70lnyjWwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406273; c=relaxed/simple;
	bh=7YYoqOIAjjMEaf57v2iXEXgdQFmEmn/LvBsi7H9riRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jaQ5bCS39fxjImpn6qCE6DPtDGofwDZDV1t0Xc19Ji7QyHaU5BI9UGrG4WnrlsqRa6meT8WuDy53mwy0LM7DVdLqcMxZxzTtxlJlCFfN3dzE4yGXZl+mfBS/hR61WmNA43DkuUdD826qraD6nI9SxPSRbvyRXAplx4fOSxSZr00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xbHr3vqs; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xbHr3vqs"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so66071205e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 07:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768406267; x=1769011067; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxU1vsfrqBADbCFBEcH8TNvakDJOOuWqCmLiru2LKyg=;
        b=xbHr3vqsvyaAt2sPVLgT0OQjWL38MZ3mBPBfulhizIzNjP3Cgfvgerku7PF4Mpne/F
         7r2eJDaZEnq/BlYywQAY52R4FDWgU/WGqfE+cc8ZGo0vWoJQKc+Mq+Fc391+R+9dQwBf
         ijtGyVR75N34TDXiCViDHX8++sKI3GXb7xJ0RyE+iJJPvn1D0ChduAcci8nt8gzUk5mY
         RIzeb/D6rS/OzEBpcL0+z7mTEU3dStSgvAOOyzLgqi2UELQYEcw3/cZfMYAYgBoiYZRh
         2HlYHkPR7DN97Jqczc6nOave0OfPYRiLDWhuc4nPkRx629YjwlxxKQCOMBHKVy9PaV3/
         hhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406267; x=1769011067;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zxU1vsfrqBADbCFBEcH8TNvakDJOOuWqCmLiru2LKyg=;
        b=sKxxN2qo0Re/0SHLcAkCjUSIWzdHCYeTVYLCahpt6KLBHoRZv+CqtiIwpqrvQ89Uqy
         CWy9gPY+AwZXU3Jg4I+sM+SjOactxCDpTKp39r2YXQeObKvuTdchVT9BDNrP4woGWwYU
         BbgIvpDR/ytL4Vu/btmdYZr/vfVwJGb8RMCp5naQwYeAMdR4qzk3WGnSUGtYUfC4hYCO
         4HYCM730o54oqzV7FbGoD33iX95GXhNTQxW4swqD/5RT3bIAUWLutKS3lJrV90oh/QFa
         H+toIU+HDX+q0p/qiepxXNesr5/vm1bJa2LV9roWg1YN7H0W9SJIZT3OIUWZ6l9w5ukb
         zh1g==
X-Gm-Message-State: AOJu0YxHLOOc9DkP7zSC664e/OmxQOi5W/uYJ3oDScsretZ1kiekFQLD
	bCwBsyqCCgOccegVD3OZqk4K5OX5vvNb3jRStPb/tAufVdSRiEd9q6Ld6j/Og2zwyFk=
X-Gm-Gg: AY/fxX6jOqq2Ujc7kyAmw70MaGTFhLw5F06ZFpV8ijS3m4mXG6o9amPzfPOSFsM+Bh8
	GEhfh8Mrj6yvIf6Nki4Xy4/yk5R4ssaIF8oC/tgVSfIx8+BDzbOuIIa46BKLcPHQvcnG4y/4Amp
	lfBmoyjB5ho1TegTniKWIq/HgXlQtqAsz1Kof/C4cQqy39P8xH7t0b7mD9y9gcBjMJ4y8OeYwIy
	9YYeRkvYKhHI7DMqzZX2hPrWuLYrsH7JFshauNr4HwZ+QaFhQspYuJy7Lb93j4ywy1GebFRpBd7
	fUYofHtbK6GrzL8WW7eGvHgVd3y9RBfREGDut+lKr4UQ5pC/JdTbWhlGTuoDsGknhqSXUSaPI5Z
	Squk8yJ+kcW44SHodZHyILBXoDn5pJBwQ8JIFJOALoQKkuoQZx1nc6V/SMfvzyJmR8uCpR3+oTr
	MXXOJvEuIcqau/nNyuji13IBFv7uffKVU=
X-Received: by 2002:a05:600c:3544:b0:479:2f95:5179 with SMTP id 5b1f17b1804b1-47ee335494fmr40564695e9.15.1768406267278;
        Wed, 14 Jan 2026 07:57:47 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee85e8807sm7426475e9.16.2026.01.14.07.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:57:46 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 14 Jan 2026 15:57:20 +0000
Subject: [PATCH v5 08/14] perf parse-events: Always track user config
 changes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-james-perf-config-bits-v5-8-0ef97aaf1ac0@linaro.org>
References: <20260114-james-perf-config-bits-v5-0-0ef97aaf1ac0@linaro.org>
In-Reply-To: <20260114-james-perf-config-bits-v5-0-0ef97aaf1ac0@linaro.org>
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
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Requiring the 'pmu->perf_event_attr_init_default' callback to be set to
track user changes is a bit of a trap to fall in. It's hard to see that
this is required when depending on the user change tracking.

It's possible to want all 0 defaults so not set it, but at the same time
still do some programmatic setting of configs with
evsel__set_config_if_unset(). Also if a PMU reverts to 0 defaults and
deletes its existing callback, it will silently break existing uses of
evsel__set_config_if_unset().

One way to fix this would be to assert in evsel__set_config_if_unset()
if the changes weren't tracked, but that would be a possibly untested
runtime failure. Instead, always track it as it's harmless and
simplifies testing too.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/parse-events.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 1f6e2213326d..c8f2962a06c7 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1528,12 +1528,8 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 		return -ENOMEM;
 	}
 
-	/*
-	 * When using default config, record which bits of attr->config were
-	 * changed by the user.
-	 */
-	if (pmu->perf_event_attr_init_default &&
-	    get_config_chgs(pmu, &parsed_terms, &config_terms)) {
+	/* Record which bits of attr->config were changed by the user. */
+	if (get_config_chgs(pmu, &parsed_terms, &config_terms)) {
 		parse_events_terms__exit(&parsed_terms);
 		return -ENOMEM;
 	}

-- 
2.34.1

