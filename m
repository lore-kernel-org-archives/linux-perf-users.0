Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE8534DCCD
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 04:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779078710; cv=none; b=BpdpicpwR/7BwycE4xTJLW71j2FuocY2GgDTSHcNZA30ukYPOpm/8XvESkn1VNgBTi34bFaGHf6f7+VHAjhLKPMGo4b94SPDpCx6AqCDVyoGak8shMSoVDVnfMgOiCgVJH72hipzzYxiFcjZj9G1wEZhelzQpr4aI/8EJeTKgvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779078710; c=relaxed/simple;
	bh=uQJFJhyacxHhZwRQj/Pk9KxvxYcboI03G3spL3wdlsY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qFGjHOSs09LZVe98bi5pIvJuAf/XFAcuC9ohxzwAl9DOvIfb2iv/r/RHF7HuqWkiQTaC1XI4Zo9EtmHpedG4ZiuaR6jP9FXE9ghXNkbe+UpKtqxOGcoreqDcjDTEPPqeHbXyGbWvtCis1UIRMinIqVUSYlyQ5kN5kBSQKTBKn4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lnJzCSjE; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lnJzCSjE"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2efc342ef15so2466453eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 21:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779078707; x=1779683507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z9vqIR0aflSq/ct5y0jd0ZZSs5YcXS5QQDEh6gyXKYY=;
        b=lnJzCSjEO9VAkKU8qTLr/aSckCEFJCVdA6vlUs7AmWtm8LNZWJFE6ddwgimD5SvXX6
         iRPjC/28MsxVE7OJ+D1BnYFGXv2d2kb44wYehd+5Dxy+jACw5V2ESkgQpood20pkQ5Px
         odtidNmBExsrGTb5X18E4JlIGfOeLuEwkXVf6MlqhZOR1yqbjZo4f/AsZIQWWKv5lV3C
         lCOU/h8dyaxX2vMTouLvAEwKS8DEYYemJhJPV6CCtEimZhe10R6UchMGDqspINUH8rvK
         L4ygmDWkh6WpqIvM53URKXs8VPdxHiEdGLWFboJitkxSYsBkR6NoHG8hLn2xVo0ED4Kd
         8ThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779078707; x=1779683507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z9vqIR0aflSq/ct5y0jd0ZZSs5YcXS5QQDEh6gyXKYY=;
        b=C9rBIoCZnuYCVlK0IfUSKmQpM7b4hGbvgXcy0x8XsQWwKUMgTQQNyTHte7x038wQHR
         mDS/v5q5ksLIGqEcUMuvFNo9Cdj7x94GEcKUDer00Pnv+pkO4dIPmZLVocB4a4TfLdK5
         /4Ij3W+QaAYtBTMaVW9Mb1am29+nh/HzQtIfIs8lh6Or54RIsdPaztObLQJi/LaLL1bC
         iggAP6YYexGQmCDJSFC15I12jeUb+KTLj5iCPs7NvBNXaDpcNFzeV/Dqfx8zoBrr5gZk
         q28oNrazv8QIS8FA/z/V95BHIlgb/Y7pc+TorxW1x63A7Xpqc63b6iDXHNdeFTUXnvgP
         Mfjw==
X-Forwarded-Encrypted: i=1; AFNElJ8xF8VIJe9jyPdffQ5aq7hTardo0uWsDoJfMktLEpqIYgposzGmKrd2yEqUKsivWLJoN+IiWHLGNttxyUjN095x@vger.kernel.org
X-Gm-Message-State: AOJu0YwPTj4k5R5ebMyYIB4h5fvsXZziY+ipW+wxoGLNnkBk3I/3Ruyo
	JOzpxQ8V7NG5yNErazs2Dq3BOxvkqPjdcdhCm5pxP8s2kj2AanFc6CK8eBunTPT2Z8HLfKysc07
	jKygid0M66g==
X-Received: from dydz30.prod.google.com ([2002:a05:7300:22de:b0:303:93ec:5fc5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d706:b0:2d9:f0b3:1d98
 with SMTP id 5a478bee46e88-303982860f0mr5506803eec.7.1779078707187; Sun, 17
 May 2026 21:31:47 -0700 (PDT)
Date: Sun, 17 May 2026 21:31:38 -0700
In-Reply-To: <20260518023225.2472122-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518023225.2472122-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518043140.2522141-1-irogers@google.com>
Subject: [PATCH v7 0/2] perf tests: Add uncore and x86 topdown event sorting tests
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

v7: - Prevent double-free of m.event1 and dangling pointer access upon
      PMU scanning loop termination or early continue in the uncore
      event sorting test by utilizing standard perf zfree() helpers
      (reported by Sashiko).
    - Document Intel Hybrid CPU architectural invariants in the x86
      topdown test to clarify why instructions correctly leads a group
      of 2 on E-cores (cpu_atom) where slots is unsupported and
      filtered out (reported by Sashiko).

v6: - Ensure robust error initialization and resource cleanup in both
      uncore and topdown tests by initializing evlist to NULL and
      parse_events_error at function entry, preventing uninitialized
      stack access or resource leaks on early return paths (reported
      by Sashiko).
    - Prevent double evaluation and duplicate debug logging upon test
      assertion failure in the x86 topdown test by caching test_sort()
      return values into local variables (reported by Sashiko).

v5: - Strengthen uncore event sorting test assertions to require at
      least 4 total events (>= 2 groups of 2 events) instead of > 0
      events, guaranteeing that multi-PMU wildcard expansion is
      genuinely exercised across multiple sibling PMUs (reported by Sashiko).
    - Fix memory leaks on assertion failure across both uncore and
      topdown test suites by replacing standard TEST_ASSERT macros
      with local CHECK macros that correctly branch to out_err cleanup
      handlers (reported by Sashiko).
    - Fix test_sort() in the x86 topdown test to correctly return TEST_FAIL (-1)
      instead of parse_events() internal error codes (e.g., -EINVAL) when event
      parsing fails (reported by Namhyung).
  
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

 tools/perf/arch/x86/tests/topdown.c     | 166 +++++++++++++++++++++-
 tools/perf/tests/Build                  |   1 +
 tools/perf/tests/builtin-test.c         |   1 +
 tools/perf/tests/tests.h                |   1 +
 tools/perf/tests/uncore-event-sorting.c | 178 ++++++++++++++++++++++++
 5 files changed, 346 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/tests/uncore-event-sorting.c

-- 
2.54.0.563.g4f69b47b94-goog

