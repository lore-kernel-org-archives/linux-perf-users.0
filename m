Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AEC3BBF1
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Apr 2024 06:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248146; cv=none; b=ra2xu5s16JyMBMMcvwNhydsAw9s2yu1JYgOi2yLMBvGFXDgxuQBzBqTuVtqx0luaUam470sMNAVar/J262w8a2AGdGn02uxKtOl59u2Lk4bGrC+nTLoZpfPiCBmBUVgNhDsoVllQLWMWbmJtUDyhkyqr8z3PX7DkQ+tOI+JktsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248146; c=relaxed/simple;
	bh=4jPYXab6p6VLgWMH/RuxotfZX+DXM3OFg+TT8Arejkc=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=EFFC3FwJSMY8Jdyyw0FinU4TxZ/Q9RrZFoOmSeT0JaUTjWDbDpt5QCnOixEQ9thb/aWHHC5nGBl2Lvo3+rAFKRehdB6lVGEl0rS/q7JRUFpNubucvkCvgSipUM+S2x7hSP6IidDH1RGpk9cpVsglKEWwfWrhJY8wjSyaGmSdVIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QU8zkirR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QU8zkirR"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-610b96c8ca2so67231287b3.2
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Apr 2024 23:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713248144; x=1713852944; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1L5nQxmaIBseTv3eUkvLYgl4v+fhf+bdZ7bLGNPrKqs=;
        b=QU8zkirRLFa/J+XFgK13oEFZ9QTZcG8t9yzs/QfYgDX/9SxvIUPyuGMs2shh1hWZV+
         FPNcFgp33pl6sYaLd4GiQSmLugE9vNK4+/zpZycJm4R/qL6C9XGaQL48zCTBbsYu4/tZ
         rSCrkmpkQy4CikqLIvFXX3BpOWTyYwG/LM6ZxfRz1afbVouUgIxzv+gVCnPdxVFlDE51
         pPOEhLratWiTWncNs7e6ItAZnnmcD7CT4KC85dx6dR2nWPp78eOt9vzVrJN59VHTHfir
         1eCPh3xw0/+W0LtFVrFSKwRLr6L13JZ9C7Dmi5cYTamRXx/0rg1rDZOC4Jvxme1l40+U
         uXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248144; x=1713852944;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1L5nQxmaIBseTv3eUkvLYgl4v+fhf+bdZ7bLGNPrKqs=;
        b=AlUhqPZuOcGTKzMtiYT9MtuviVxcp0+tNu0OD1fnyXvKFqiFhj87FjqF7ID/PMnT8g
         2S8CB6xAyDyTBCQtyfVT5nbcZz/l/PKhEYX4ng9J3MPWJQ/6DCF//Np9YmP82h0LMJ4r
         yyHL1tbK5QYjG2vigy78GXSGnBjtc5IXwYl3bdyYlzXIBX+dUaeu+7jRrf/4p9r+Rv+a
         1B4RmeXUcBcAheD9RXq0E0BihfKNQwn1wC2EM/aWj757k+uUJmDO8AZlh4qZYxh0cokO
         i9hB5H0uyGxM/uimQuaeFT+b7hQiLvbzn/NImXn18+ZBz86RuJbi67ox7u7Fd2b0/0Bm
         f7Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXv9N6AqTR7uAHx62E9uG1xnvlH6PH+SeutZlAIf6zNktKfwCeviEKvFDf2mMogW7Ov8UBn2yZXB5W57h/jocdnVJmXii/vrdbP1AIfy7JCmg==
X-Gm-Message-State: AOJu0YxfsdoR0KRGUEOocg294H+Vs2M0ZL6+uFUJh1BcXkbTTuuecQT0
	kS48rDJTkpDgNoJcp+b4W0lXbLeZfdwutGWF1jcru0OFfMsjhIm8QeiIZxqTtf8PxvLWz8k77c+
	QmVKs0A==
X-Google-Smtp-Source: AGHT+IEA3B55PHeFnorQTRTaPmQGXFGj867ryFo0kz7N/R3DDO6sXqkF9UwTo2cE7HmZ5sd27AE/abgmLPXz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:30c8:f541:acad:b4f7])
 (user=irogers job=sendgmr) by 2002:a0d:d74e:0:b0:611:747a:daac with SMTP id
 z75-20020a0dd74e000000b00611747adaacmr3417811ywd.0.1713248144106; Mon, 15 Apr
 2024 23:15:44 -0700 (PDT)
Date: Mon, 15 Apr 2024 23:15:16 -0700
Message-Id: <20240416061533.921723-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v2 00/16] Consistently prefer sysfs/json events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Beeman Strong <beeman@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

As discussed in:
https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.com/
preferring sysfs/json events consistently (with or without a given
PMU) will enable RISC-V's hope to customize legacy events in the perf
tool.

Some minor clean-up is performed on the way.

v2. Additional cleanup particularly adding better error messages. Fix
    some line length issues on the earlier patches.

Ian Rogers (16):
  perf parse-events: Factor out '<event_or_pmu>/.../' parsing
  perf parse-events: Directly pass PMU to parse_events_add_pmu
  perf parse-events: Avoid copying an empty list
  perf pmu: Refactor perf_pmu__match
  perf tests parse-events: Use branches rather than cache-references
  perf parse-events: Legacy cache names on all PMUs and lower priority
  perf parse-events: Handle PE_TERM_HW in name_or_raw
  perf parse-events: Constify parse_events_add_numeric
  perf parse-events: Prefer sysfs/json hardware events over legacy
  perf parse-events: Inline parse_events_update_lists
  perf parse-events: Improve error message for bad numbers
  perf parse-events: Inline parse_events_evlist_error
  perf parse-events: Improvements to modifier parsing
  perf parse-event: Constify event_symbol arrays
  perf parse-events: Minor grouping tidy up
  perf parse-events: Tidy the setting of the default event name

 tools/perf/tests/parse-events.c |   6 +-
 tools/perf/util/parse-events.c  | 482 ++++++++++++++++----------------
 tools/perf/util/parse-events.h  |  49 ++--
 tools/perf/util/parse-events.l  | 196 +++++++++----
 tools/perf/util/parse-events.y  | 261 +++++++----------
 tools/perf/util/pmu.c           |  27 +-
 tools/perf/util/pmu.h           |   2 +-
 7 files changed, 540 insertions(+), 483 deletions(-)

-- 
2.44.0.683.g7961c838ac-goog

