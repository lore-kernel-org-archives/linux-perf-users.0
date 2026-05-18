Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5263737A488
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 02:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779071553; cv=none; b=szDMWMEjmb+vdRrTcOxnIqAZjGo99htInjcXaWdIyO+9sFT03tz6RKwGF3NtdUWH1z6v5oSglgbs3mciwn0dh7gqRwygveTS9NDy25BreIlG4e08ZfCCBO+VZzSrJUCiGsV/u6nkbzlqhV1UPGlNDXxafXDAsDprS8BebqWEHQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779071553; c=relaxed/simple;
	bh=NKVvsTDB5Vc2tFx25pEGHaQIO7Z4ckfKObY3QvprsNI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MQN41jZAjo9hW1ohCXe1wShABLAho3SB9LePJdwNaYdQixpQVlUSjF8ltihj0Zf6j/Dt73ynqqkLo6PJ8/DPcXP8J/TrlJBpUOpDK61ueqpBgeVT+kgGsJy2A7KXvc1wyEbl9ymHPShaQYpag+dB5Zw27am4N/6cbTheACaCGos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qm3Ya6RJ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qm3Ya6RJ"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2eebb099efbso5642355eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 19:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779071549; x=1779676349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=loLywN1PuBHxxj8GyVOfyJnFdqCWrCuMqC8r57AC3J8=;
        b=qm3Ya6RJDwTXgEqTm12qvYe1YBXxJpLN6rlycEQT8j2E71dqxd0y2t5ZuLV22LQuxK
         ZWkkaQCRcHdFgmEn8M3QKMF42quoBwDopIjtY4X1qsBVs/6Z3jQ27h38ueHSBPUr+f8/
         tk0J0IgIJR2saO7UHawGs6aacHTT8Wj2za4+LNMx2MKVfHrJCMZc3Ncy0ORr1eucX11V
         vZAReRQkVX1EGyji4k94zQw0oY3jGzy7e/e55vTU38iJgt3ZTJr9udOpHM/Bjy//R9Oc
         Nrhruif0Ca7rM0eYk8V/KyxxSZyJZaDhVbNpCrndSII2xeA7t/UtPX5vJVWDLF0ifLfA
         PfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779071549; x=1779676349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=loLywN1PuBHxxj8GyVOfyJnFdqCWrCuMqC8r57AC3J8=;
        b=Zehmi5vq/bCaFMXx/B/DW/HcNkhRtsH9FvhznCl9aVFHil1SYJV1wZMWjrZ7340ECR
         CcnmFA4gNLQNsH7r+rhdrPHZTSAEuTesdNlgD4Rs44eLOMNPXRtIvENK3yAF/PqKmjUJ
         vVNSUZf7O8zCaYjYyhLE4K1qJ0TBlBSsTyboX5SP+5YkKJ4BzFQdhTLSX05KdVJp9UtA
         KqZxSATjP5U2N5kAxMQ099eYWAy2odjXs3fk8gZ6eF7sWelHJXlhwUpvB0aJAOCaha2M
         Gdgk+PMQPwdCm89sFmmRs3W6Kiu5RT86IvotIXD7XwRCuGKhRcZqz3rcgxw79Kk1CpjU
         VRyA==
X-Forwarded-Encrypted: i=1; AFNElJ9siju8+d5KIpJewGOmyhJkq0f9Ey/jD/usKH5fTuegoBbvGaBBjP7q59fCcohbyuRo6cyzA7UMZz1L6Rxt1sTD@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz3tlde2g15m0ETcUblzI5sYJ5yXDwzuWRy0YA2A1WevFV0kG5
	n/31aw5CaGpLPGLz3mXu3MoZtms7UXr4aw0G3t7RGU6IggN3aXFlNPjr8xavSNsyqN9OWxb8fyi
	1QdbyTQakIA==
X-Received: from dycpv9.prod.google.com ([2002:a05:7300:de09:b0:2ed:8f25:961b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e6c6:b0:2dd:c066:bf7
 with SMTP id 5a478bee46e88-303982b11bbmr5474353eec.11.1779071549230; Sun, 17
 May 2026 19:32:29 -0700 (PDT)
Date: Sun, 17 May 2026 19:32:23 -0700
In-Reply-To: <20260518003704.2434308-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518003704.2434308-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518023225.2472122-1-irogers@google.com>
Subject: [PATCH v6 0/2] perf tests: Add uncore and x86 topdown event sorting tests
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

 tools/perf/arch/x86/tests/topdown.c     | 159 ++++++++++++++++++++-
 tools/perf/tests/Build                  |   1 +
 tools/perf/tests/builtin-test.c         |   1 +
 tools/perf/tests/tests.h                |   1 +
 tools/perf/tests/uncore-event-sorting.c | 178 ++++++++++++++++++++++++
 5 files changed, 339 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/tests/uncore-event-sorting.c

-- 
2.54.0.563.g4f69b47b94-goog

