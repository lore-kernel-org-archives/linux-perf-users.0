Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5921369B6
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 21:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719351683; cv=none; b=muiqIgFThXsU9cLLnhcLEaH85Fb5XCjK25Apr6S2dJTSmhS1Hm+QUgwKg2xVk+Y4tSZZqqv68+VQzaaB7DGT9rtvgX/jzheu03T7QS4qIfe1U45bOTFb8WRu2R1ju3IUr70geMTAQ5UZtVfevThSOEgtLxvK+S7pIt9fAJ4CRLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719351683; c=relaxed/simple;
	bh=mfqLJpdxWtbrpONRyXNGYHJVLRBJusHUTyGW8ZqGXds=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=RjihiBdQeTMF2P6iRA/WozdAjlqh934GLKyAgjA7F+QxTvhAcZcJuEB/RMrqEWnHv/LwPA84/UVWcwQpXiNkVmSOKobFiByJvxEh7/1BCnE8MWRF1VzUQsggcRSP4bQwzZcWXkQewOrkCfQsZxCTpCG8S/I2Cx3+9z1P6814QGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l5X43YiB; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l5X43YiB"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-646f73e4354so22751857b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 14:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719351681; x=1719956481; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pB20YctkByMbfeEqJS5b21c7qXK0FPZDELOAznW8QUg=;
        b=l5X43YiB+O598xsAqHeGiabTq6EBKWmE2d0pFcRw9R6Ktjx1Wpq6PQRTfgporYsKD4
         vPXzQ0BcP1bFlDMnJEaRSAku7iwNZsmvwsB38VFbOaL9UhXssmMn0O479aSc6x057IlZ
         vRznrIEjmeCACqQCYO8xtx/HCWZQUoyQ0KGMN8AV21nJS/EhXLuESjfWmzAqwoNqdA9H
         F53flAkPm9leo0r08bLMfAniJofbKs3CbrTfaU1UTLzd7XRYIBhEqJcvlaXgd1cvfkOc
         v/h0I94jS9lP5oK9duV8pEJrRu6PXrauu9Q8orpWRLpjLOypwLzoH9jfpNtqCjpstzSG
         dtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719351681; x=1719956481;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pB20YctkByMbfeEqJS5b21c7qXK0FPZDELOAznW8QUg=;
        b=HvEvLSQ4rfOP8y/SLMA3NkmqvFAUu8OZNs/V122Tj4r7/ffFNbv71nfbQ2sSt1JuzS
         qvqpdcVY8iL68epgdm1br7CBMNaKS2wzbdpRVklwepWjCdDHSDfMexGiE0wfUI3s8Mbf
         n7VgHM8tQi3ojU437fBP97gDpoPrVucXhIqe8BXpcReQs7JLw1AdH9kxKXwW6bHWD8Oi
         Ng20t2hV4oA6r/wQkzD/xCwGQDkRke1/OfNgL3aLJADSkRX8eKMIXDftR0r+HEvYSXVB
         O3VleRh9chi07K7Jwb/TebC4Gy4VOYdIdPYVhBIJz8T3qoHqY7QpGv1OCz6dkRfbMkww
         fA+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYWgh4+vzbOcVQ6zTZ02oxBMagEWx6DCAm0c1ebaAKZG+ozGm3jcYaPPWYhw9Nsh+QWpN4SezlPkm+EBk8nRxBzDLVXOUn1raWQp40ag91RA==
X-Gm-Message-State: AOJu0Yz+FB4aqXqTEgKs5EVKk5PNEZLyl/hqahDuZy07Xy9aupRbK64A
	KyK2WqqmpFEKJMylM2Q8vIl/8wReWqPAY3VOx2FuHRXIlK4DdXjgkiXlmUIB976XYyUN7Qx/Drm
	PL7772A==
X-Google-Smtp-Source: AGHT+IEm5+4Z5pme1l/QEMTgpR1uFk8cJ0f8ej6scwGggGs2QmMoz+HvN8CRlVBUyHSmiR719nZFZ1fB2KaU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:690c:f0b:b0:61b:e524:f91a with SMTP id
 00721157ae682-64341c235b3mr1640907b3.10.1719351680839; Tue, 25 Jun 2024
 14:41:20 -0700 (PDT)
Date: Tue, 25 Jun 2024 14:41:09 -0700
Message-Id: <20240625214117.953777-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v5 0/8] Refactor perf python module build
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
	Nick Terrell <terrelln@fb.com>, Andrei Vagin <avagin@google.com>, Kees Cook <keescook@chromium.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Ze Gao <zegao2021@gmail.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

v5: Resend with missing patch 8.
v4: Rebase past conflict with commit eae7044b67a6 ("perf hist: Honor
    symbol_conf.skip_empty") - fixes like this commit won't be
    necessary after these changes. Swap a tab for spaces for better
    consistency.
v3: Add missed xtensa directory for the util build. Remove adding the
    arch directory to perf-y as it creates an empty object file that
    breaks with GCC and LTO.
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
 tools/perf/arch/Build                         |   5 +-
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
 tools/perf/arch/xtensa/Build                  |   2 +-
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
 tools/perf/util/python.c                      | 274 +++++-------
 tools/perf/util/scripting-engines/Build       |   4 +-
 tools/perf/util/setup.py                      |  33 +-
 50 files changed, 625 insertions(+), 732 deletions(-)
 delete mode 100644 tools/perf/util/python-ext-sources

-- 
2.45.2.741.gdbec12cfda-goog

