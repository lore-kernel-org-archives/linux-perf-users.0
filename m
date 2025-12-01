Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCD433506A
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607307; cv=none; b=YE1YOWGgR1e7++pQlaREwVOp/vgeaf23nyT7/NMQXq1Cp9/h4vKLMGN4F14Y0nPf6cclbivvwDM+DglcziwiWxXvHNLVg5Zb+NlrkdDczLLEhKWoA0K9giyISVszx2Z/FL0EdwC8UNTdC06nrYqb0E09d4O1qxLwUGQ+zKdhrRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607307; c=relaxed/simple;
	bh=huoMrzKi9FJ3Vo39sk52zs8CDdRM/kZ4vA9UXght7ko=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aLcrsYzxl3290KGKqkM2E8LPY2MS6lKtoqjafAT6kbOHJsgLwIHjK85IUuY3pYJVfeqCKxO0MMNHSboMPLFHuLdPoRjWKIY6lXGMxPTNchb+b1FFVQ0AJvpS2hy1iVDMskSmIrBRb46BPlgvYwnEfwYrEKB8lXQW1EzRcJC8DcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R39c6Vhb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R39c6Vhb"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779d47be12so35822395e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 08:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764607303; x=1765212103; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X8CXO9OJfojSeFF+UUsnSSZI1P/+BX3oz+61rBzG6wc=;
        b=R39c6VhbzyOQ4ePC+qgsvlfxYugKIQe17NbcvtXk+1WpPWGm5yeEooORzb0DjjdB4J
         1yhLFdeyOOVXgqPWrv1O9ZnvxWi/6zEdlwt0ZjjNJ+3+rZx3JbnDu1hY2o7VaRJ7mDHg
         +FitHFTB9kMOf4Z9/WeGj1sTofigRh5H8pKzdMJRPIVwDfZ2MwKA/9mgG2r6O9eIDoMg
         rUbHb5Mzuc5bPu88zIhyjP4BGjM3MMmT8HYldpKwfbyzLOXwM2r8p94p38/0G7X1rVr4
         Y7Z7oZRMFnPW18foNqvqXT99OZVerzd0aza0z9nJnF+6bw//Q2Lx+F0cT65lREJuxmwL
         IU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764607303; x=1765212103;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8CXO9OJfojSeFF+UUsnSSZI1P/+BX3oz+61rBzG6wc=;
        b=tfP+jF720+otayhoFLrha+2FyudToZzNDaieDiPNBxwKiWa8gD+TME+rkNt9gC12Fo
         JFgFh9cZBDQLIcAc42z9FmdewCKPu1wGvUHC+oOU2n8TJK0S6HODxSWvT60Hjts+zaIQ
         tGUqQ1cWre2ejnk3CgKfz682gvRejN5mFR2j0Ulu/lKRdMVUlnhW5Imp7/lEcY8Pi/rM
         XvMP/1U+3vkLpAfHzPafqtZrV7AxMnf/d5R4wkDFzl+GltvnjgIMXItewRKRLDxZiF30
         tvfV0Ygc56FVQDGRAlvtyeQrbL1w3LPZpomRxp6tOmDMRcY5u7Ls/kwqPBooXvPOrPkp
         2NZw==
X-Gm-Message-State: AOJu0YxpPmsHrlahulDaR+mewLs9ohC0jLiqplQCaZ2u03sNHbaaevoO
	BwVnnguwBikRyGgpr065ybYOh9htpno9VlfcQpquKY6WoEFI9uwnYQEFGHt5HrPLpzk=
X-Gm-Gg: ASbGncvH39vfovjygnetRQ11tViGZP2rMeUrjoXHWd9rv4yyae10Yq6X5qydIJmXH+x
	WQNpN9B5PN9CtPJBoss1JyeY2tSRzGL9Z6hD9VFngfNFfjjFjFvg6GQuWSxzWDhhnHEGgk01BmV
	jNFfymeA59cruYRTtP3aWzN6xAFaX20+ZrJ8URsrkJSvNyvho5Zq9arVjmizRF1+8HvcxxcndHe
	B09HgI6JpZG8nddKWFdMrxFRGXRM9dMOLJdiALCohQpw/zgf7JxfHS2Z+RJouhNp9kPPCouuZ6D
	8E/2KCjzPvBckJQqvJWLfTRxOTkckBpWz4KQjYOXBCQRbFCKk6eb68QHcW70YwMdLnO3Nr+HMWN
	xd9Ji7UcInFMFUodvDOweC+lCwZC5bhu35vP0H6Eb/5ZYS3d6R1v7mRqlqk+VTkBW1wVB1oq7J0
	RaSk6fHD0DzvWPYWZ5PlWB
X-Google-Smtp-Source: AGHT+IFpklz6cl1AMJUqVSGcZRb3Pn6NfQxw4c1mN9dYuQ9p6NjC0krJoPGjNKaFKqqo6n/s5CfyHA==
X-Received: by 2002:a05:600c:3595:b0:477:755b:5587 with SMTP id 5b1f17b1804b1-477c0184b34mr418552785e9.8.1764607302915;
        Mon, 01 Dec 2025 08:41:42 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791164d4f3sm255901275e9.13.2025.12.01.08.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 08:41:42 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/7] perf cs-etm/arm-spe: Remove hard coded config fields
Date: Mon, 01 Dec 2025 16:41:03 +0000
Message-Id: <20251201-james-perf-config-bits-v1-0-22ecbbf8007c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB/FLWkC/x3MQQqDQAxG4atI1gaSgVrwKqULtX80BUeZFCmId
 +/Q5bd476RAcQT1zUkFh4dvuULbhqZlyDPYX9WUJN1UNfF7WBG8oxhPWzafefRP8AjcVToTE6E
 a7wXm3//48byuH8jI9ZRoAAAA
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

The specific config field that an event format attribute is in is
consistently hard coded, even though the API is supposed to be that the
driver publishes the config field name. To stop this pattern from being
copy pasted and causing problems in the future, replace them all with
calls to a new helper that returns the value that a user set.

The existing evsel__set_config_if_unset() also has a similar problem
that it hard codes attr.config, so fix that too.

There are no functional changes here because all the fields touched are
in attr.config and not config1 or config2 etc. Although this may not be
the case for new fields.

Signed-off-by: James Clark <james.clark@linaro.org>
---
James Clark (7):
      perf tools: Track all user changed config bits
      perf tools: apply evsel__set_config_if_unset() to all config fields
      perf cs-etm: Make a helper to find the Coresight evsel
      perf cs-etm: Don't use hard coded config bits when setting up ETMCR
      perf cs-etm: Don't use hard coded config bits when setting up TRCCONFIGR
      perf cs-etm: Don't hard code config attribute when configuring the event
      perf arm-spe: Don't hard code config attribute

 tools/perf/arch/arm/util/cs-etm.c    | 202 ++++++++++++++++++++---------------
 tools/perf/arch/arm64/util/arm-spe.c |  15 +--
 tools/perf/util/evsel.c              |   6 +-
 tools/perf/util/evsel.h              |   2 +
 tools/perf/util/evsel_config.h       |   6 +-
 tools/perf/util/parse-events.c       |  89 +++++++--------
 tools/perf/util/pmu.c                |  93 +++++++++++++---
 7 files changed, 251 insertions(+), 162 deletions(-)
---
base-commit: 834ebb5678d75d844f5d4f44ede78724d8c96630
change-id: 20251112-james-perf-config-bits-bee7106f0f00

Best regards,
-- 
James Clark <james.clark@linaro.org>

