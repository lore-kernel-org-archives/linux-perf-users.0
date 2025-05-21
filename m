Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5059C22B8D5
	for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 05:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747804841; cv=none; b=Gdu4F43YrUjqFsyVT6ZlPaBMkSw/hgELo2K+i0f5NF3XMJqC85E4jpCp7eoosJIXJnq/14IGE+pXwiHQgVFeURULhT2T9WD+QlL24+/u4ZtFel8NQ7dNRvGOt6Tl8eqindLDQ8QXzGfYzJCaNoF0RSZAhGgl45ZL3fh485veRG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747804841; c=relaxed/simple;
	bh=DbjNRHAddfYswahlJ5OlrQs2EuQdDjt4sx3QNUqNnmM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=TslDTos89TpMcINGVL/KoyH04wNqFHTVs1zvBeB4mbminfftMLDvx2v+i99tJjr4eXV06HdhcNf/SZEcLgJCio4gO/TuyqVePmEqznx/I9M9wSDbWlyc1803tr+KJqLHxZGeLdVGsf8OdrXCqNzPb5qXQ//3N6pEmtecKHZ2YUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mLX+5gXo; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mLX+5gXo"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23201f062afso31070115ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 20 May 2025 22:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747804839; x=1748409639; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ILcaj/2kHUB6wUpDHcSBb10ICw09s8EvCijtgSr1pxg=;
        b=mLX+5gXoJGvvmPjAO5zpU/tmnpCjbesAiqWHjkazdpQebGDDdrxyI0AszwCR6ErnK6
         a2mkepE7LrRndqxelODaJzqxq2k7ALV4DcCzBS4YLOHfl7ILaAZv/T7TTkRO4BvaYOuI
         GASfmALAgT1hmwL37C2YaXSgSWymI1qyKOfxYQvDrw6xRW7jmD7GknSNsdzQ+XZW4jpK
         mCMKZ5Z72JKk7L9LFD3e7B+7Wwj16aL7urID+Cqu10X+A0sZmndKRP9ILflfdHPYiMV5
         6FRCkKPS9gZHyzBaqLNySbakXsogO3ALgjwq7rsxu/QNLqcW7vkkVQJgKKsBc5I/7SiU
         JgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747804839; x=1748409639;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ILcaj/2kHUB6wUpDHcSBb10ICw09s8EvCijtgSr1pxg=;
        b=EdqMiYDcMKwaPVNcWjrJx+1Vo1PXjHBNWEX6o1RXU4ePi4X+q2zc00J3lrp1J0yVet
         KwheJ/YyITR3RkG30JOL2FGxMaSTItRr01mlD8teT7y3I81MOKC18Jvc4gIVnaNnGQOs
         gIHDijSflsrVZvMuIlT0jYkm3QAbbnwD25R244jGTot/OSoZ7X/AHxbzDrfYK5N27OIr
         GU6CAj/JE4+9GmFH+xe4AZVtHp5+sL2/h5+bGgYscMdUlqrI9VUQyKtMG2wbX88G6+va
         ZOoMjOcpdjbX8mb5kU4bgiEn9xc7z2jtOZdd9vpL1AfBwOz5Gqv5HaneUiw8Rxx6WQBg
         Uwdw==
X-Forwarded-Encrypted: i=1; AJvYcCWUFyKR7CE255nt3L3kcCzTZ2AH7w9eSh6LlLUTo2kFvu3Vy+WhqakSs870f9D7eyYioFozWG42awM9Fzo/eDsH@vger.kernel.org
X-Gm-Message-State: AOJu0YyysABtLeym61Orr8MOT7Lll7f8uwoHnYJkIOoRcPCmvd9CNnrZ
	Hrtjh9Z5UyuRXqbtQtllGyixjHkQl76sCLWp/Wn7ev6w4jKXANKrPLWGSReSqvJW6wQJkBH+GdC
	Z/lHEr5d6pA==
X-Google-Smtp-Source: AGHT+IG9Ixfpj3XKJogkh2nfyoZjlb8nZ1aI7qy9/NwWxDmzSKqAaYJwTSLXXoP3KEgTZGW2tm4v9GuAk3Zf
X-Received: from plblm4.prod.google.com ([2002:a17:903:2984:b0:22f:b333:1bd9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c2:b0:232:59b:5923
 with SMTP id d9443c01a7336-232059b5ca8mr218231555ad.23.1747804839452; Tue, 20
 May 2025 22:20:39 -0700 (PDT)
Date: Tue, 20 May 2025 22:20:26 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <20250521052029.658800-1-irogers@google.com>
Subject: [PATCH v1 0/3] Generic weight struct, use env for sort key and header
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Chun-Tse Shao <ctshao@google.com>, Ben Gainey <ben.gainey@arm.com>, Song Liu <song@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The arch directory is a barrier to cross-platform development as files
and behaviors within it are inherently platform specific. Sample
parsing should be generic but the PERF_SAMPLE_WEIGHT_STRUCT handling
was only present if building for x86 or powerpc. The sort key and
headers should be specific to the session that is being executed and
not to the machine perf is being run upon. These patches clean this
and associated code up.

Ian Rogers (3):
  perf sample: Remove arch notion of sample parsing
  perf test: Move PERF_SAMPLE_WEIGHT_STRUCT parsing to common test
  perf sort: Use perf_env to set arch sort keys and header

 tools/perf/arch/powerpc/util/Build         |   1 -
 tools/perf/arch/powerpc/util/event.c       |  60 ----------
 tools/perf/arch/x86/include/arch-tests.h   |   1 -
 tools/perf/arch/x86/tests/Build            |   1 -
 tools/perf/arch/x86/tests/arch-tests.c     |   2 -
 tools/perf/arch/x86/tests/sample-parsing.c | 125 ---------------------
 tools/perf/arch/x86/util/event.c           |  46 --------
 tools/perf/builtin-annotate.c              |   2 +-
 tools/perf/builtin-c2c.c                   |  53 +++++----
 tools/perf/builtin-diff.c                  |   2 +-
 tools/perf/builtin-report.c                |   2 +-
 tools/perf/builtin-script.c                |   2 +-
 tools/perf/builtin-top.c                   |  16 +--
 tools/perf/include/perf/perf_dlfilter.h    |   2 +-
 tools/perf/tests/hists_cumulate.c          |   8 +-
 tools/perf/tests/hists_filter.c            |   8 +-
 tools/perf/tests/hists_link.c              |   8 +-
 tools/perf/tests/hists_output.c            |  10 +-
 tools/perf/tests/sample-parsing.c          |  14 +++
 tools/perf/util/dlfilter.c                 |   2 +-
 tools/perf/util/event.h                    |   5 -
 tools/perf/util/evsel.c                    |  17 ++-
 tools/perf/util/hist.c                     |   4 +-
 tools/perf/util/hist.h                     |   2 +-
 tools/perf/util/intel-tpebs.c              |   4 +-
 tools/perf/util/sample.h                   |   5 +-
 tools/perf/util/session.c                  |   2 +-
 tools/perf/util/sort.c                     |  67 +++++++----
 tools/perf/util/sort.h                     |   5 +-
 tools/perf/util/synthetic-events.c         |  10 +-
 30 files changed, 151 insertions(+), 335 deletions(-)
 delete mode 100644 tools/perf/arch/powerpc/util/event.c
 delete mode 100644 tools/perf/arch/x86/tests/sample-parsing.c

-- 
2.49.0.1112.g889b7c5bd8-goog

