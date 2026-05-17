Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796371A683F
	for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 23:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779060542; cv=none; b=PBEeZY/dqWv8yQ5cpflO0mihgnaNWWTHPh0mB3qZjLcgDEgo+HBuQuDFChBaQWgYJiYj9Id/P8/mEhJkTcTg4zUNFsZjmPjz8t58f3zwArOu8mDz4E7J+iaM/GqnRgX1BEBA0d5Z5fsL+KuLl3L/VE5oUzh9pctd2HzqiPY200I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779060542; c=relaxed/simple;
	bh=MjAk2pVyfISn9UMRkJMVe5hZnmxUnxDrfbqrIwOpDeA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AcEOxeAGumfJAq+EdXG6S6eE//1eWLlyI3qCgFg1LdZh4TgFtiPC5bqKIn4f4QNYaMR6TkCgOfB7BJSZC3KSIABYawmdkdMMfIL4xPki9lbn3m9XmQqnFxlSCVx/+kqyjURECLT5nnOfN5aoxCXf4qh+1nbCy8lvxUdzmL5oYKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BHfj9yXt; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHfj9yXt"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ef62078ee7so2353124eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 16:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779060541; x=1779665341; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gn6gUZ1kzrECDHvopsTiCN7Lh440qhW+8dfteQX6g08=;
        b=BHfj9yXtpaZxzVU9Fnu0JV551lDufNlg37BFXiQi/7c9nbk4dfemqJCkRBkpnUKT89
         cl8cSUz64rATS7etcPbZi78ma+bDD+mOFV8f/3zQzdbL0XJjR9J0MXIKaP+rWZuxp056
         yNR75GxOz+jyvsKf40dcn8xZOA94vEe2fkhikDKG9aPVF1OuDLth8dw7ry6/N3Ji/Mro
         n0SpyMXadBmzSXGsHWZxLFcw05JQur1hYkD2KrPdXOIK4Y8fLeJ+9D1qmJqhlYlLQsIX
         hdduhlOD5+P0cgod9bVZI3QICbhnJh7uLMnxpifg6LQ2P7zWycNrhH00gngmjIzozJbR
         5Log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779060541; x=1779665341;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gn6gUZ1kzrECDHvopsTiCN7Lh440qhW+8dfteQX6g08=;
        b=iY8rkEjBrPO9JNs3zfkUyD+cWiu9DA1+y8QAMmX2ckSJckM83CcVfs2A9P3PEgENMi
         y81d814UF/9x8h34FkDc+5CCrAv6YUexABcYoK9huFhi+U8KrMqFhlWikH+kB8ddc4TV
         zBnv69XTqriPOKsyMDrVDveAzGFpU034mRfk3FOkXm8H5LeH4MCgbplOs2RX9Jr5A9nP
         6to+Z4KsrwoNl17nHz8Hu1d1/ifHIdMca1z8wWrHBJU8rn0wopcM93OaKPfNkwqmjieY
         VzkpSzTOsX468HWaGm2QCpzXjgNynslJJwCUSEtnFMkhFMAx7IPeN8CyTK3FKccacf/0
         7ClA==
X-Forwarded-Encrypted: i=1; AFNElJ/hCPNa+E19aGS1/BzIwP/jTbhe70d9fANqQ+mwHpqAl5FARUPhRbhZdCRtXpEozebqAFaGjV1XGJO0R145h+dN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4blxFJeiLKm6ICeOW8/IbQfhTH75iSte4dV6LbsRzsluxiMP3
	872udPvGi2Tb+KgNuGznKEaOzVJBtxW2nwYAhPLCfTqmM8AH+rZeNQT1QHIGlMI4RFJcdHpEcf/
	gItQpd4J03w==
X-Received: from dlbvg7.prod.google.com ([2002:a05:7022:7f07:b0:135:6c74:1840])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2315:b0:135:245e:4d14
 with SMTP id a92af1059eb24-135246db725mr2277900c88.16.1779060540338; Sun, 17
 May 2026 16:29:00 -0700 (PDT)
Date: Sun, 17 May 2026 16:28:47 -0700
In-Reply-To: <20260331185419.4085479-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331185419.4085479-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260517232849.2391357-1-irogers@google.com>
Subject: [PATCH v4 0/2] perf tests: Add uncore and x86 topdown event sorting tests
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, collin.funk1@gmail.com, 
	german.gomez@arm.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, zide.chen@intel.com
Content-Type: text/plain; charset="UTF-8"

A patch thread changing event sorting highlighted a lack of testing
for the more complicated uncore and x86 perf metric event sorting:
https://lore.kernel.org/linux-perf-users/CAP-5=fWRgDo7UnJAD4C--d=mVPRhOEWZVyU7nVM1YEp3jncAgg@mail.gmail.com/

v4: Fix malformed event group string formatting in the uncore event
    sorting test when running on AMD systems (where sysfs event
    aliases lack JSON descriptions - reported by Namhyung). Added a
    helper to strip redundant PMU prefixes and trailing slashes to
    ensure parse_events() receives valid syntax across all
    architectures.

v3: Address sashiko nits on using evsel__name and ensuring slots is injected.
https://lore.kernel.org/linux-perf-users/20260331185419.4085479-1-irogers@google.com/

v2: Address indentation and other nits from Namhyung. Add Zide Chen's
    tested-by tags.
https://lore.kernel.org/lkml/20260331165207.4016392-1-irogers@google.com/

v1: https://lore.kernel.org/lkml/20260325183045.1229502-1-irogers@google.com/

Ian Rogers (2):
  perf tests: Add test for uncore event sorting
  perf arch x86 tests: Add test for topdown event sorting

 tools/perf/arch/x86/tests/topdown.c     | 134 +++++++++++++++++++-
 tools/perf/tests/Build                  |   1 +
 tools/perf/tests/builtin-test.c         |   1 +
 tools/perf/tests/tests.h                |   1 +
 tools/perf/tests/uncore-event-sorting.c | 155 ++++++++++++++++++++++++
 5 files changed, 291 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/tests/uncore-event-sorting.c

-- 
2.54.0.563.g4f69b47b94-goog

