Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DBC3ED3CC
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539204; cv=none; b=XT2y9Il89BrscrhuWz+saqBLlN9t9I5hlarvpPg8gfJUy+msd9kbbU+daihQXYyOJAaa4keLoPkw950rgZXsA9iz3KSglqvvEIGg5ThH5SboGgsHRmcGArIDn04yYX1CSyYtficiSRRv9IDG8VXBmW6qQcJamEVOyDKBQCp74A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539204; c=relaxed/simple;
	bh=MTfU2kBykGvEc78KQu6zbFfBgjtLSKZO3O+KoOcIBeQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GtQla/APHdq4QOxIkDucqxfv7I9+J263qnzCxjgVXikLeFUKvy1B+MBjpDq7G9NlC0tK2ibDb/NApbPnG5LmuXidDOJRnj4Y0yy5234ET55cEdouh0sW4zTwGs755HCG37p3I3a4YZ4fK7Xc6cUpm4Agoa/W+bOEUzTLs4OY8hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zs3K26EY; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zs3K26EY"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f283baf1fso6082357a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 23:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789539201; x=1790144001; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=upDmXP3yIXwPcisrFXwSlmDbZrrJ3hkk6zyR7leCdIo=;
        b=Zs3K26EYYnHU8VNOL1UNiKx1Wg3Rvf5T5UAGqVCNI0CSRX8jxDfkB12Yq7WYsKugah
         7qI9Ng1r/L8OxZyP8yaa+Eh+/xW7nuC746cWTy+Tn6j66BKN20Ze191cKItXQVACl+CS
         KgDDR+w6jCw4fr38rt/TJ7v6tHu7XvXhhduQVIlPLDp9EcEAm9m/QGFQ0LVCQWVqXO1t
         7ybgyIoMvkf1065zGMyKf8MPkqEpbMuPtZei/xtNGgD2BdRcmf/becLaCG7A37xzd6MZ
         0eDZDmlGu9cVHVdCDkWxRB/T5FTk08x2D17hzXZfTBQd4Y/0l/HmlI/0kTUZzBlR94QY
         vVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789539201; x=1790144001;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=upDmXP3yIXwPcisrFXwSlmDbZrrJ3hkk6zyR7leCdIo=;
        b=ndUKrl0hNomhHAb82p0mpmIk7H6qfWLlsw8wnnLoxYJ/d3SSB7XU2KCME9NDVhV4a0
         10PNx4piSBRmzGN/SFkXr2WY/gBks41npknIYr0ARRa8shIzUBwJujBPJOP1wqKr1ay1
         DNgyyWkNJsF/8XYRAuz1i+CzdP7OdbtK5gJEfTCW+15DaHnvlqcsrvRZtBQm+tzHzv0Y
         3WLSe1E7CQA8TAwSLwaB9b1xq/gPhZeatHRO5LOQK+TJni33yTa6zKIw5dJo7ONBdyXr
         N5O2CDWJpTzrBcazRSnsZuHs5lf6VW2J/J969mJPtrKOKZCQH5KbWNpkDTpoWAcGZA2l
         ZiLA==
X-Forwarded-Encrypted: i=1; AKwUvBz8tgLi7MeoTAQVoLe0/CKHjnDgVGbAlShZ5ekY2TMPdKuxDYjzjYhj9OJr1N9MJGijVF9sRs6EMTjTodoCSHoC@vger.kernel.org
X-Gm-Message-State: AFuF++kYTpNIs6OS+gm8TLiJy/3pEcqVyHpIPXxsT0jNsaIPSDYzS8KV
	Cj3Meg9jslEF8Cj36VjpIkkfVStDiJXZsv3ke3lnhSDAd1citP2XhMwJPfl8R1VBh8JuTLv1ooh
	3dWPJ8xWG2A==
X-Received: from dlep8-n2.prod.google.com ([2002:a05:701b:4588:20b0:143:6b62:db2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1845:b0:39d:f259:3363
 with SMTP id 98e67ed59e1d1-39e1e491d27mr3698619a91.12.1789539201213; Tue, 15
 Sep 2026 23:13:21 -0700 (PDT)
Date: Tue, 15 Sep 2026 23:12:14 -0700
In-Reply-To: <20260916061218.3061216-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916061218.3061216-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916061218.3061216-6-irogers@google.com>
Subject: [PATCH 5/9] perf build: Only pass clang flags to CXX when CXX is clang
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Building with "make CC=clang" appends clang's --target= and
-fintegrated-as to CXX, but CXX is only set to clang++ by "make LLVM=1".
With just CC=clang, CXX is still g++ and every C++ feature test dies:

  g++: error: unrecognized command-line option '--target=...'
  g++: error: unrecognized command-line option '-fintegrated-as'

The failures are silent, as feature tests are allowed to fail, so the
build quietly loses libllvm and C++ demangling support:

  $ make CC=clang && grep LIBLLVM .config-detected
  (nothing, whereas a gcc build reports CONFIG_LIBLLVM=y)

The block is entered when CC_NO_CLANG says CC is clang, which says
nothing about CXX. Probe CXX the same way tools/scripts/Makefile.include
probes CC, and only add the flags when CXX really is clang++.

Mixing a clang-built C with a g++-built C++ is fine here, the C++ code
is linked with -lstdc++ already.

Fixes: 4772e66cb45e ("perf build: Support build with clang")
Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/Makefile.config | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 4ee7393a39f9..31e4cbe192b9 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -54,7 +54,14 @@ ifeq ($(CC_NO_CLANG), 0)
   endif # CROSS_COMPILE
 
   CC := $(CLANG) $(CLANG_FLAGS) -fintegrated-as
-  CXX := $(CXX) $(CLANG_FLAGS) -fintegrated-as
+
+  # CC being clang says nothing about CXX: "make LLVM=1" overrides both, but
+  # "make CC=clang" leaves CXX as g++. Probe CXX the way Makefile.include
+  # probes CC rather than assuming the two match.
+  CXX_NO_CLANG := $(shell if command -v $(firstword $(CXX)) >/dev/null 2>&1; then $(CXX) -dM -E -x c++ /dev/null; fi | grep -Fq "__clang__"; echo $$?)
+  ifeq ($(CXX_NO_CLANG), 0)
+    CXX := $(CXX) $(CLANG_FLAGS) -fintegrated-as
+  endif
 
   # Enabled Wthread-safety analysis for clang builds.
   CFLAGS += -Wthread-safety
-- 
2.55.0.1032.g73a4cd73de-goog

