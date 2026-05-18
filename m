Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26021CAA6C
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 06:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779085752; cv=none; b=YGvFsDIqdHx+wC2YIdDh3e+FcX4fdT3q0KdsNWumand3I7OT9toyRSzdbP+gzDDpVWcbx5qi/Kr9EuLO47XHH0LrsAdGD8dV53a13DIjqCYzY8cuAfrFOv0DkoRhXpG0yKRxnivlPI+uJJsElT7c8qL5LJw3eYhufAVYvXRdMio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779085752; c=relaxed/simple;
	bh=ZMJcLPonl5Fjt6Kl9dyStnZ+/a9xfPxAKm8hoUribt4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h1q745uYELgaIVlxGL95X06RoRfeGwn5oyLtKf8qvcw99rMoQfDi0bcngkuw2dzS5ANuOEpmjrANITHSLKoq2o7vzlet3T7pjoPHUKzyE9TsmgaHUp0I9JsS5E/ztCo0ILR4FKopHzvQWPI1dEp3UpjOyLjJnjaCrDHCSETE3SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fq9xu8t7; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fq9xu8t7"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ee1da7a13fso2373308eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 23:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779085748; x=1779690548; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QAUuUriJFfl0tWxGycaguzlNA3FAkEjcZ0ZaxCBBpfI=;
        b=fq9xu8t7xn3qKlI7rPvYeGft1enkkBVLvBNS6bknkV5QWW9vjb9gQhM+L+rhZHoWuY
         EiWhbOKKO2k3GF6UL0AhLtiHKYc1njWjIxWWVmV4y0Mr44G+ztm3Kd/wJMr6K6KelQCB
         d19Yn6Un5Yg0IS1t8oKTV5WTdzCV4czPIQKrJQ+EEagE6YBx53wzKCQQ8nlfANr0WekY
         Gg3wwzN8kKL5y57HaMb2c+M9t0+z4sxr9jwwZ8LHlwmhtfoFz90QdZGLxuzR7jnnYLbN
         IvZKyYs/05b3sj4Jxh3sJ+zpgKG54Q37CX5ccpWelEL1OJmFSZsFERsxpDs3Y8x/CZBM
         Noog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779085748; x=1779690548;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAUuUriJFfl0tWxGycaguzlNA3FAkEjcZ0ZaxCBBpfI=;
        b=dm78oeElFi5frmBac+sJKM1ga5OePoF0ow3yf2Xm7H9O9uNU0RlJFEC+/YA8bKFFgp
         2yzUmwhY+phBUJ3k//F40ix+pxdT+rQtAD8WKV0A2ZiBPcA1ZYT7C0+YI1SQupg1/RKJ
         a3rxZP+aqUk36LBM82eNhPwnm1m03GB5EF9yFOWpy9KAiTnqy0sTzEfwmsxi4J6QFdhl
         xZBmW7eKD4w1ae9G/+2t5ffUFZ19Ho/1n4Y05gpvp8dTJE+wWsRUKhtZT0wV5N2yS5AJ
         /vDn1nQ+6jpuikGka/6tZ0gYTsjslWjpgD/U8Q6BKOMt7ESM1PevRannYMcNlI5/wW51
         UM9A==
X-Forwarded-Encrypted: i=1; AFNElJ/Oh4nWi/ef1Ra0+wVTQjkmFcmJDyeShIj2Q8AaY234dwi0MaysJFld3oMqkfIZ3QMfRkoXP9P4BU11KqTrZ3v/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2jBJBDELoedeDulcAzMyyh617tqghEmZd81uJ/iWrTLXkwG5q
	oE0jZaZA7x3BWf2jGTSNCBNqzgLTR56DnI3y2boQjXIG80snEfsdsIalon5kL+Sa361lVX4NeVl
	bZ8lvo3RJGw==
X-Received: from dygg14.prod.google.com ([2002:a05:693c:80ce:b0:2ee:3abb:9c9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:478f:b0:2e1:e3e6:2909
 with SMTP id 5a478bee46e88-30398167fccmr5374992eec.9.1779085747893; Sun, 17
 May 2026 23:29:07 -0700 (PDT)
Date: Sun, 17 May 2026 23:29:02 -0700
In-Reply-To: <20260518043140.2522141-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518043140.2522141-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518062904.2591616-1-irogers@google.com>
Subject: [PATCH v8 0/2] perf tests: Add uncore and x86 topdown event sorting tests
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

v8: Simplify event_cb in the uncore event sorting test by removing the
    unreachable dead-code else block (reported by Sashiko).

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
 tools/perf/tests/uncore-event-sorting.c | 176 ++++++++++++++++++++++++
 5 files changed, 344 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/tests/uncore-event-sorting.c

-- 
2.54.0.563.g4f69b47b94-goog

