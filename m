Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7C93E9584
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539195; cv=none; b=Ul0lpXDQJiroQWaJWhhaUIT8Uxbx1ObKRCrnwtfFeUxOl5suloCkK2sVAhRtiW0rio2onty06cCi9vrThk/i2isvU9UeYQqpJRNx7kx+FZ3ONgSGb7zMKAbU7E5i+4U5eHBzBO5MXb8RksDtiXGhBFcGECAPCk+ieV6qN5k+oBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539195; c=relaxed/simple;
	bh=TEbjILTlqP5+wNeef4mS8EvMHIo70lOdoxdQcbkBb8Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Uze8JLIVossjjXbU3tUNZ1VLkT6w6RoVmZJ6uKvibow8r/k9KtT2Bb1qIGhfoTgUb1LF6Fxgo/mPEztZmZVGjz1hv/5jeUxwoQ49EcW8NIAhFkCo6ZKLP4Pi7hN1ASG8PqdLAPDQogpfzNe4KYD0MMBOJhYiHXClzeiygLIOv9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pIlVuQ3d; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pIlVuQ3d"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc42a07d04aso4501682a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 23:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789539193; x=1790143993; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1APpipDUKkY/l/gg/4YwrZIApoh7aNB+mSUpOsNMMdo=;
        b=pIlVuQ3dT/V2YU1XcDO9zK6q+sVb5SowjUIjG+lmRH4E58pj8HbkPTfsu4cWqVsFKz
         S8QcxLQ9myjpFDkeZdJgp/OkaFqRXOnmaXMbFqYpMz9lgbIFue5HBDOkODGym8RWllwO
         7VPtlOS76WP0P/C6ZkDQW7sMOXFdTEAo8WzizKCJ1sQFITbo0nSU3FpaJWBag+1qCQI6
         f5TCcDcIiEQRFui1HawHuj8PEE3BsHFdXuIn+B1Rgj3xZDPZe1GZmscMZ/kQRSpdhTlt
         xqQ2kbMs/VGqhBXCgngIspAqxFyZAkvROSk/Qpev+vppkkLkAQ391GR51aTM9QuJ5GPO
         Bi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789539193; x=1790143993;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1APpipDUKkY/l/gg/4YwrZIApoh7aNB+mSUpOsNMMdo=;
        b=xp2uwaSAjYt8E0N6WDuKwyMD6nrU0JnRhbSsqRgLZcEmC/IWJWwBrcsAnlZxlHCeoE
         SkHicNAXvaNRklKMVPIBVPzzyasIWmyBVAQ5FiS+b694yXnBjaE9Wng5JINMKS9v0ltN
         +NFPQ7pqyW2hHI4WHYuvR9VZVK0CIC97m8UorlQobGHzCI6T6c3JpbdMtHALFcm3Lbgj
         NKJRggRaUxI5XseF79AdJ6NWHpWbL7mxv2DGJL7l3PhAIToXPFDgJRIZugbrSKFKjjTp
         7cj+wmRmZltcTqzxogOa601qiWNMk/OK8NVb71UDSf29UyfJ8Z8uaLVGscokVww/2+xJ
         qbkQ==
X-Forwarded-Encrypted: i=1; AKwUvBwRlVCowKffDxjYGAbxJV2NyXqJYIGXL89GB7b/qIWVy2S+DhNlw1F3GxItGT3/8SQEwhhBKXRbADxL+7Hp0Ru6@vger.kernel.org
X-Gm-Message-State: AFuF++lz4i6CdsoeIEHk9AmKaBtY+8jWZdTWaS05kjR+jQgw2/kX1hlY
	vbhO31eTSimS2yHMHXBUBz2Myf+Ke4yfUWLe//Fgymr5xNJ06xszBpxzg3q+ynBOMd3MNWGck60
	jNgP5qwmyxA==
X-Received: from dlbrn14.prod.google.com ([2002:a05:7022:150e:b0:143:8ccf:e704])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d07:b0:39e:194b:fb2b
 with SMTP id 98e67ed59e1d1-39e1e572ba7mr3226270a91.22.1789539192287; Tue, 15
 Sep 2026 23:13:12 -0700 (PDT)
Date: Tue, 15 Sep 2026 23:12:09 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916061218.3061216-1-irogers@google.com>
Subject: [PATCH 0/9] perf build: Fix builds with clang and BUILD_NONDISTRO
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Several perf build configurations are broken, and stayed broken because
the build test suite doesn't cover them.

Three of them fail outright:

  $ make CC=clang BUILD_NONDISTRO=1
  util/libbfd.c:56:1: error: mutex 'bfd_mutex' is still held at the end
  of function [-Werror,-Wthread-safety-analysis]

  $ make BUILD_NONDISTRO=1 NO_DEMANGLE=1
  util/symbol.c:2714: error: 'DMGL_PARAMS' undeclared

  $ make CC=clang-19
  *** Specify CROSS_COMPILE or add CLANG_TARGET_FLAGS for x86_64

A fourth is worse for being silent. "make CC=clang" appends clang's
--target= and -fintegrated-as to CXX, but CXX is only set to clang++ by
"make LLVM=1", so it is still g++ and rejects both. Feature tests are
allowed to fail, so nothing is reported: the build succeeds and just
quietly drops libllvm and C++ demangling support.

  $ make CC=clang && grep LIBLLVM .config-detected
  (nothing, whereas a gcc build reports CONFIG_LIBLLVM=y)

The patches are grouped as:

  1-2  Fix the two build failures, in libbfd.c and symbol.c.
  3-4  Include the headers that are used directly rather than relying
       on other headers to drag them in. No functional change.
  5-7  Fix the clang handling in Makefile.config: don't give clang's
       flags to a non-clang CXX, and use the CC that was asked for
       instead of hard coding "clang" when picking the target triple
       and when testing the compiler version.
  8    Remove three build test entries left behind by the removal of
       the options they tested. None of them define what to build, so
       each silently repeats "make_pure" and the suite spends six
       builds appearing to cover options that no longer exist.
  9    Add build tests for the configurations above, so they don't
       break again. As a build that loses a feature still succeeds,
       the clang tests also check that libLLVM is still built in.

Testing:

 - 13 build configurations (gcc, clang, versioned clang, LLVM=1,
   BUILD_NONDISTRO, NO_DEMANGLE, NO_LIBDW, NO_LIBELF, DEBUG, asan,
   refcount checking) pass, where two failed before the series.
 - Every patch builds on its own, so the series stays bisectable.
 - Each fix was confirmed by reintroducing the bug and checking that
   the test added in patch 9 fails:

     CXX flags given to g++     make_clang             fails on libLLVM
     libbfd thread safety       make_clang_nondistro   fails to compile
     symbol.c demangling        make_nondistro_no_demangle  likewise

Ian Rogers (9):
  perf libbfd: Fix the clang -Wthread-safety build failure
  perf symbol: Fix the build when demangling with libbfd
  perf libbfd: Include the headers that are used
  perf pmu: Include the headers that are used
  perf build: Only pass clang flags to CXX when CXX is clang
  perf build: Use the given CC rather than clang in clang builds
  perf build: Check the version of the compiler that is used
  perf build: Remove leftovers of removed build options
  perf test: Add build tests for clang and libbfd demangling

 tools/perf/Makefile.config | 13 +++++++---
 tools/perf/Makefile.perf   |  3 ---
 tools/perf/tests/make      | 50 ++++++++++++++++++++++++++++++++++----
 tools/perf/util/Build      |  2 +-
 tools/perf/util/libbfd.c   | 41 ++++++++++++++++++++++++++-----
 tools/perf/util/libbfd.h   |  9 +++++++
 tools/perf/util/pmu.c      |  5 +++-
 tools/perf/util/symbol.c   | 18 +++++++++++---
 8 files changed, 119 insertions(+), 22 deletions(-)


base-commit: 91b0782fc9e9d2f0a40b5256146e014802fdbb36
-- 
2.55.0.1032.g73a4cd73de-goog

