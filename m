Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F9B58F073
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986520; cv=none; b=cehvCjtdA+uvqesa3aT3Y4tCltu1ljXHef3ohniGGZ96+3ikO8HBxZu44XbebFrWEe8nRvMrDCQak3aD4vsVjLPTcV5gTdckFUg4vAOO1aAsqIljlhbpjOTgkyJoQjYBPXl0ZRrhHVJITlsG41McLngMfyMUK5JhfxKGXsb67W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986520; c=relaxed/simple;
	bh=dgJT3lQq+zMoY7DKPCR2Tjn/gdpC+WKaJvdn9rvd5rE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xps4zsaMFPZI7FGZdfJJg49V1r9hWIWlQBV1SBMjaGxpOqauUTWfdsuZHZMjJ7EllCJcTrBOCZycRkjU+Zx1MWEhHle3lv+IdfqdDVzTPJIqjsMChKSYz6cpaUt4LZoQcJkKMTa9EO01XRAWVWQGW0NiFSBB384WmsBmMHg/dss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uyk8POHU; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uyk8POHU"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso10322766a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Sep 2026 13:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788986497; x=1789591297; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Hjtw+jM+D0SyR9fx9bBPSqMxqN6Ns/EVNt7rCXIXoI=;
        b=Uyk8POHUNBHMzrbjTPqPNzqoCTur5XDQbgGtvmgM6wYE8wfomTyALrtZayLILEOof2
         YM0bsC0gh1MsEpqdbCSeBximsEnYVRRxsqs3mkMnKuDIYxU2oMqswfyBYXxyJmawPYm+
         zZWqbLkcfz3nGWNyEUdMm2EgFgQ1kuLKkSrUvFcKOcJA1fQq5whun5QBK6fbUeu15mCW
         9Qzuh3h+SumoshKmsIdEKQmGzM6pAhPzIN0XIIRpH6eBVGy7eaduaTjOpx1VqeMYYgXa
         QxTgz7hqTuKp/5QJWE/z9rqgYxSmo2+9fSFHi9JPqVTmA6Mv6pjmX45Nuz8Dlu8SUlJM
         Iusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788986497; x=1789591297;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Hjtw+jM+D0SyR9fx9bBPSqMxqN6Ns/EVNt7rCXIXoI=;
        b=HShRqnUKR/QSxL1zOOnYeWLNKSOOddJdNpUv371RYOv4RcpFoAZj7D/1Dp80jYJrkq
         EKI5Y5Z89EVrEF3aRBudJXiwlEZ56HQaBM5PlC7SUixgsleHSsHYI1xG9I9PkgiJZoIS
         +uvON/o0SVQ50w4Mjm3LKfoJ/j0cnyW6bSOwJ3nvLVKVXY+R8nUC7OGKFArOQXSS5ETX
         KmApdVIIMB8JLTlxIXrA6DDQd1yyasMv7oElbhV2XVKmb2/oQ9YrP9VfcPDkcNzvPLOW
         /v2nASVJDxak4gzgShtdK+ReP+R8qVEujLJl/qhiUNj7U9WO5d1jTpEhujwuuBkC1815
         9NyA==
X-Forwarded-Encrypted: i=1; AKwUvBzlYXI5UiyYzSPre9p7KKFbqDP2t5TVAuN7PTQlOQ7FvcJnhgfa58rg8brUMBbBv0eSy8p4M+2k5XC5hXCak6Fy@vger.kernel.org
X-Gm-Message-State: AFuF++lmjMHEQVLToDV7pW4zocT8isA31rE+x0cQfy2rqWF3qcy0NTXA
	nFixYVGZ44WhEIX2GPC4iaPVvJyRKLn8OHRVoEckDx42ky0NCa5kB570noFLm1jJaFYsWRC4UD5
	xdJuAhSAX7A==
X-Received: from dlii9.prod.google.com ([2002:a05:7022:4189:b0:143:1b94:eaf3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d44b:b0:396:4cbf:45bc
 with SMTP id 98e67ed59e1d1-39b26203f11mr58288051a91.16.1788986496610; Wed, 09
 Sep 2026 13:41:36 -0700 (PDT)
Date: Wed,  9 Sep 2026 13:41:19 -0700
In-Reply-To: <20260909204122.1993010-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260909204122.1993010-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260909204122.1993010-2-irogers@google.com>
Subject: [PATCH v2 1/4] tools build: Add explicitly sequenced -lzstd to libbfd
 feature fallback
From: Ian Rogers <irogers@google.com>
To: Quentin Monnet <qmo@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Tomas Glozar <tglozar@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Michael Jeanson <mjeanson@efficios.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Leo Yan <leo.yan@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Distributions like Fedora currently ship a statically compiled binutils
libbfd that natively depends on zstd to decompress sections (e.g.
undefined reference to 'ZSTD_decompress').

Extend the testing cascade in tools/build/feature/Makefile to natively
probe for '-lz -lzstd' when the basic fallback variants fail. This adds
the generic framework for referencing static binutils across all tools.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/build/Makefile.feature |  3 ++-
 tools/build/feature/Makefile | 12 +++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 99eb0ea09537..1268ac6f130e 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -121,6 +121,7 @@ FEATURE_TESTS_EXTRA :=                  \
          libcheck                       \
          libbfd-liberty                 \
          libbfd-liberty-z               \
+         libbfd-liberty-z-zstd          \
          libopencsd                     \
          libperl                        \
          llvm                           \
@@ -161,7 +162,7 @@ FEATURE_DISPLAY ?=              \
 # Declare group members of a feature to display the logical OR of the detection
 # result instead of each member result.
 #
-FEATURE_GROUP_MEMBERS-libbfd = libbfd-liberty libbfd-liberty-z
+FEATURE_GROUP_MEMBERS-libbfd = libbfd-liberty libbfd-liberty-z libbfd-liberty-z-zstd
 
 #
 # Declare list of feature dependency packages that provide pkg-config files.
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 7d165018116a..410987df3a48 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -21,6 +21,7 @@ FILES=                                          \
          test-reallocarray.bin			\
          test-libbfd-liberty.bin                \
          test-libbfd-liberty-z.bin              \
+         test-libbfd-liberty-z-zstd.bin         \
          test-cplus-demangle.bin                \
          test-cxa-demangle.bin                  \
          test-libcap.bin			\
@@ -272,15 +273,17 @@ $(OUTPUT)test-libbfd.bin:
 	$(BUILD_BFD)
 
 $(OUTPUT)test-libbfd-threadsafe.bin:
-	$(BUILD_BFD) || $(BUILD_BFD) -liberty || $(BUILD_BFD) -liberty -lz
+	$(BUILD_BFD) || $(BUILD_BFD) -liberty || $(BUILD_BFD) -liberty -lz || $(BUILD_BFD) -liberty -lz -lzstd
 
 $(OUTPUT)test-disassembler-four-args.bin:
 	$(BUILD_BFD) -lopcodes || $(BUILD_BFD) -lopcodes -liberty || \
-	$(BUILD_BFD) -lopcodes -liberty -lz
+	$(BUILD_BFD) -lopcodes -liberty -lz || \
+	$(BUILD_BFD) -lopcodes -liberty -lz -lzstd
 
 $(OUTPUT)test-disassembler-init-styled.bin:
 	$(BUILD_BFD) -lopcodes || $(BUILD_BFD) -lopcodes -liberty || \
-	$(BUILD_BFD) -lopcodes -liberty -lz
+	$(BUILD_BFD) -lopcodes -liberty -lz || \
+	$(BUILD_BFD) -lopcodes -liberty -lz -lzstd
 
 $(OUTPUT)test-reallocarray.bin:
 	$(BUILD)
@@ -291,6 +294,9 @@ $(OUTPUT)test-libbfd-liberty.bin:
 $(OUTPUT)test-libbfd-liberty-z.bin:
 	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty -lz
 
+$(OUTPUT)test-libbfd-liberty-z-zstd.bin:
+	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty -lz -lzstd
+
 $(OUTPUT)test-cplus-demangle.bin:
 	$(BUILD) -liberty
 
-- 
2.55.0.1003.g10538fe699-goog

