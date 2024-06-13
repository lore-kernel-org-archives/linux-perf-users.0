Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF3C12FB39
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Jun 2024 18:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303556; cv=none; b=stFhtHIVWqGS+xGiA9f2oWJu1/k8RMZVr9UtNDJDfyZN30/QsAuKpv/stgIRSadzsPc7f2WDzGKHp0BNhIuC1726uLCkmig06Drfdb8hyqHRg0bhW4MX8lHVaaZ0row0MsjCA418JDMrIa6W+dsvP+8nOB98Ugqc/0lwYk4KL80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303556; c=relaxed/simple;
	bh=cpWXRE0Fqv7sRk4O6Nqc1zzeKbf0oJzhfcWUtE6IajI=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=kJ7BQ/YlxmJTW9yaFLYkeY60iLNsT4MziFhU3n7vSNYw7jxvYNZ0cienNPZFOC8145rGarmlg7aNQRSdu6VqSazsAZMtVFtMrqcKBp0WrdBbrdFxjUA9muO8Gg5XOffmP8sy1UnyjHzng1sUYVDj5CzvFPvDfYyvx8nWJq/laz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b5I7xaDD; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5I7xaDD"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62f8a1b2969so24022047b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jun 2024 11:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718303552; x=1718908352; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GvTiDUv73PJ62h8lVRQjJMyYJyL2LnE71Yt7gAeiVUY=;
        b=b5I7xaDDVvMVpUx7EqIVDeOgfWfgisBFajzaYmgNAGbFr4kxgU9gGChSrfAK28NpZJ
         uSwHHMPPZPsmCwrLflIizmd7DQiderD9JAFVCjZ7z02cfKwCWiit9SUJrZqHinVM5Hv7
         EDOmqPY3iSNyWYqaxvVb5kNhSTIAaBflCkTiR2uxsRndxagBfasdgT0f/fSm+cPKnnXv
         dLnfNaJ6iMKKUZgnQO11upAnFWgGNOlXzUHHAUoXs6GBbY5W3mT0+AC//GV+PO8Wny2N
         UCG048IRKI6KyPpirMbcupitGtVspx3//oMP1Dt2Hd7axc65RORCEw/RT87VWeOnkgxA
         RXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718303552; x=1718908352;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GvTiDUv73PJ62h8lVRQjJMyYJyL2LnE71Yt7gAeiVUY=;
        b=EnRX7qjX4pn2vZaydTUKsxcFDRW7/Wv+LxwvGSii6BvBRKPluoBttjZA7wlBu15Qgc
         EZzgpuL6WVWSrU/11NzxSluXIxy94xV0HBsH+WiaPt/eFp5RUbcVecd/3+uJ+2AFjZFd
         z8yRCXQEmRdrYLX/l9a1+Yr5W6UlohKnHxim/YZgrvU+S/befRQS/2c2uKmLOBiSNG8a
         hZNjAeZzWON51nQEV6I3FniUz/9LMKaSN4c9PttHbSbHcFhZDPam3aKShDXmh8pqJNh/
         BMnbv6RCJUGKPjMpWtLBO54muJGmKdVhNZC84bQHmZVV87d5YcPKaJ3bnkOLLreA8985
         UKZw==
X-Forwarded-Encrypted: i=1; AJvYcCXPSf2xm+KfiwULxi4Gg1n3QGCW3UtY94wxVIyQunKJ/jfRO8kdEAKotJeJsuzDJu6/0vPNuK/bbGyeaM3KQn6oBISiT/hLgdfbVmaGxgtuEw==
X-Gm-Message-State: AOJu0Yz7D/A9lFloeAXxafvZfKZ+w4fukF9W9o9NL9aXkZFf62QFov+r
	BS0GIjwPcBKdC9Hh5PmV/tJmdaRs8+sKnBgXkW6TvO6ycRnFiaO/Y0sLCbUHf1g7CzsAIFw8uG8
	cjOPheQ==
X-Google-Smtp-Source: AGHT+IF2KkrgoY57dGWdPw77kXn2zBaD+Uy2G1hRssubmTdIuyA2t/vU2zQn1FmdaIlmDTTWb1i59wcVKt0o
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:96dd:26a6:1493:53c8])
 (user=irogers job=sendgmr) by 2002:a05:6902:2988:b0:dfa:4b20:bdaf with SMTP
 id 3f1490d57ef6-dff15470dfdmr25437276.13.1718303552539; Thu, 13 Jun 2024
 11:32:32 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:32:16 -0700
Message-Id: <20240613183224.3399628-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Subject: [PATCH v2 0/8] Refactor perf python module build
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Nick Terrell <terrelln@fb.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Kees Cook <keescook@chromium.org>, Andrei Vagin <avagin@google.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, 
	coresight@lists.linaro.org, rust-for-linux@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Refactor the perf python module build to instead of building C files
it links libraries. To support this make static libraries for tests,
ui, util and pmu-events. Doing this allows fewer functions to be
stubbed out, importantly parse_events is no longer stubbed out which
will improve the ability to work with heterogeneous cores.

By not building .c files for the python module and for the build of
perf, this should also help build times.

Patch 1 adds '*.a' cleanup to the clean target.

Patches 2 to 6 add static libraries for existing parts of the perf
build.

Patch 7 adds the python build using libraries rather than C source
files.

Patch 8 cleans up the python dependencies and removes the no longer
needed python-ext-sources.

v2: Add '*.a' cleanup to clean target. Add reviewed-by James Clark.

Ian Rogers (8):
  perf build: Add '*.a' to clean targets
  perf ui: Make ui its own library
  perf pmu-events: Make pmu-events a library
  perf test: Make tests its own library
  perf bench: Make bench its own library
  perf util: Make util its own library
  perf python: Switch module to linking libraries from building source
  perf python: Clean up build dependencies

 tools/perf/Build                              |  14 +-
 tools/perf/Makefile.config                    |   5 +
 tools/perf/Makefile.perf                      |  83 +++-
 tools/perf/arch/Build                         |   4 +-
 tools/perf/arch/arm/Build                     |   4 +-
 tools/perf/arch/arm/tests/Build               |   8 +-
 tools/perf/arch/arm/util/Build                |  10 +-
 tools/perf/arch/arm64/Build                   |   4 +-
 tools/perf/arch/arm64/tests/Build             |   8 +-
 tools/perf/arch/arm64/util/Build              |  20 +-
 tools/perf/arch/csky/Build                    |   2 +-
 tools/perf/arch/csky/util/Build               |   6 +-
 tools/perf/arch/loongarch/Build               |   2 +-
 tools/perf/arch/loongarch/util/Build          |   8 +-
 tools/perf/arch/mips/Build                    |   2 +-
 tools/perf/arch/mips/util/Build               |   6 +-
 tools/perf/arch/powerpc/Build                 |   4 +-
 tools/perf/arch/powerpc/tests/Build           |   6 +-
 tools/perf/arch/powerpc/util/Build            |  24 +-
 tools/perf/arch/riscv/Build                   |   2 +-
 tools/perf/arch/riscv/util/Build              |   8 +-
 tools/perf/arch/s390/Build                    |   2 +-
 tools/perf/arch/s390/util/Build               |  16 +-
 tools/perf/arch/sh/Build                      |   2 +-
 tools/perf/arch/sh/util/Build                 |   2 +-
 tools/perf/arch/sparc/Build                   |   2 +-
 tools/perf/arch/sparc/util/Build              |   2 +-
 tools/perf/arch/x86/Build                     |   6 +-
 tools/perf/arch/x86/tests/Build               |  20 +-
 tools/perf/arch/x86/util/Build                |  42 +-
 tools/perf/bench/Build                        |  46 +-
 tools/perf/scripts/Build                      |   4 +-
 tools/perf/scripts/perl/Perf-Trace-Util/Build |   2 +-
 .../perf/scripts/python/Perf-Trace-Util/Build |   2 +-
 tools/perf/tests/Build                        | 140 +++----
 tools/perf/tests/workloads/Build              |  12 +-
 tools/perf/ui/Build                           |  18 +-
 tools/perf/ui/browsers/Build                  |  14 +-
 tools/perf/ui/tui/Build                       |   8 +-
 tools/perf/util/Build                         | 394 +++++++++---------
 tools/perf/util/arm-spe-decoder/Build         |   2 +-
 tools/perf/util/cs-etm-decoder/Build          |   2 +-
 tools/perf/util/hisi-ptt-decoder/Build        |   2 +-
 tools/perf/util/intel-pt-decoder/Build        |   2 +-
 tools/perf/util/perf-regs-arch/Build          |  18 +-
 tools/perf/util/python-ext-sources            |  53 ---
 tools/perf/util/python.c                      | 271 +++++-------
 tools/perf/util/scripting-engines/Build       |   4 +-
 tools/perf/util/setup.py                      |  33 +-
 49 files changed, 624 insertions(+), 727 deletions(-)
 delete mode 100644 tools/perf/util/python-ext-sources

-- 
2.45.2.627.g7a2c4fd464-goog

