Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2702C17A30A
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 00:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779064643; cv=none; b=mnIFZW5oAqvvv+4CZcrufQoXn4c1C+YJ0cILhYWVXgJZYiHQWw/piTPzN1QOtX5zT8WnGC/5Axwwf8jQga5Hr25y5EE8DcFn2P9+6jY4zdJiAbukkPRjS+KXIx9sImFI1Hm8+VXjde+ZTfcO3WVl50GI/59pQiz6jziSuOnc1DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779064643; c=relaxed/simple;
	bh=fYzgQcJS8T0WyWnVIHzOphYHqFV0PE0FZKP/BKYgwP8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iiwBeKVfY6tEwM4tzES23M5yHTH5OPaZqXXo3igAHtVKvEWdutY9FRKH99RCPApeeS2U8eZ9CAuxE6XadYhcDY2onGJC3UDGciyE/KkJjFY6wc0Bu4mwGgauoAMkncp+wSTFcwu+hEYMqCGUAYJxsMwh9NBiGtKQnhZC/8H1hiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VgopxkAj; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VgopxkAj"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-132d631edaaso7048301c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 17:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779064641; x=1779669441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PxloSLG4ZhdLke49UFYR4wGr71boH/OD6G1aSURiR70=;
        b=VgopxkAjfDs9t6H37FjGryY1u2f5w3TI34Ay6ZknvSHZuFjVaO3kNQuzrXcW1pjxdi
         S93Pk8Jf1m2+nI+SOMci2zwzRU/LbQenjzokpbOtnaxo4FzjSOK3gHkLpW7UTm9Jq4sa
         ecSbTdWvDn6xs7exxtilZEEx7joEK3q5UMoutC94lMFoBKTUyXevexJUx76sKOfL21AC
         Ldlo6droYxXUe51LfXiZoGFhq9U5p6aU5zn0rwgEdJ5Vo2ULTw7uusOYJos74O2WPU8z
         KdU6e6tIXzkIJKQreJigeC6JaN4KG4bKuoSMtTlR8lFj9H+5tL6eM2JPeveKZmWhY/co
         W7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779064641; x=1779669441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PxloSLG4ZhdLke49UFYR4wGr71boH/OD6G1aSURiR70=;
        b=C3JowBZmeyNc0bd5u95zAvdFAgi5GYZ5icZe0LAVsjMp5wpJrNrBNSVzoLM7BQyFBK
         zx8v4/XVLR+P4k73Tbwrtnf4FuGivXX68lIZRTEkJIjHRS4URGxroPUly7RWfHEW314S
         UwNB0krmZ10SIHG8zEGvEDW4R2NOFn8wnY9R/20ID99bV8y6aSXbvb3IvlsCWToL7pe+
         81IQGlljD2x1e5n7nNbNU9mDGZRSneFJ+FEZL1z/1vOUY0SaQERAUBMn1MXFlZR2u98Q
         f64vZOWjWJL+hQIzpIpKfJu95uSrdJ/j0ScNa2KNeWQLlX8JVa81zlAXDOm9/KFQ1GxB
         GikA==
X-Forwarded-Encrypted: i=1; AFNElJ/M7AXk2u6SLVZxfTeixr3SMOd9LPxsirn5lMMqNWut3jmtxCrU0nG16fuGNCj8Ie8dDHVWjGuNjP4+BqYJPjbR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6YCJW7W11Xj2W2IQHYUj3XLhtlEHx3DZ0J6wtcZbc7ZPL/nIB
	0B4STYb38TCtiVIcINyXmT1teW3UcByZLwLjEKxOEC4OX2cjVoSbG7UMKML2ylnxof756uHg3vh
	ecHxpeJ4vpQ==
X-Received: from dldz5-n2.prod.google.com ([2002:a05:701b:4185:20b0:12a:c265:1a7c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6728:b0:12d:b7e5:a67b
 with SMTP id a92af1059eb24-1350451df51mr5694044c88.14.1779064640707; Sun, 17
 May 2026 17:37:20 -0700 (PDT)
Date: Sun, 17 May 2026 17:37:02 -0700
In-Reply-To: <20260517232849.2391357-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260517232849.2391357-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518003704.2434308-1-irogers@google.com>
Subject: [PATCH v5 0/2] perf tests: Add uncore and x86 topdown event sorting tests
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

 tools/perf/arch/x86/tests/topdown.c     | 148 +++++++++++++++++++-
 tools/perf/tests/Build                  |   1 +
 tools/perf/tests/builtin-test.c         |   1 +
 tools/perf/tests/tests.h                |   1 +
 tools/perf/tests/uncore-event-sorting.c | 174 ++++++++++++++++++++++++
 5 files changed, 324 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/tests/uncore-event-sorting.c

-- 
2.54.0.563.g4f69b47b94-goog

