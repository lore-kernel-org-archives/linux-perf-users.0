Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A3739795E
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788977444; cv=none; b=hhh3tQX2+9JVnr0V/1vU8GDuVyjnqiVj9WNuO5YKbJ//0xE9iVVb+7ouuGVRfUBucU+sZcm9VGsrUpo7dHOt5ddXD4h+aV1puOC3izy+CdvvoeG88bHgBg7W7NyiT8f3oC0acpeKKIXA3HhEL8a2MIsZ+pKvcZdKe4dJe5JF/tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788977444; c=relaxed/simple;
	bh=TRy9Gliv/FzTpN1SrKHqnFfZhY0XCIQdEdLMOrMQR1g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Zi8A9Tt2fLJLEHperUWI7tJni7jLBZvwilW7TI1x5Sg46vN2yRIwShVN39s4GjERiKSEpkcSxgUpkO6x97+2oZ3dYY7JshXLgbOHdeke37Cl1tC/2cxTM+0pJAZxV+WTybozAoQnea35aa8FhlZ5al4N++Dw7qOt+4BPF4FN4jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DPvQ3rgH; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DPvQ3rgH"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cf7dd9fd91so60196175ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Sep 2026 11:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788977440; x=1789582240; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jjnxEfr3Uzi7pXtCU8OB5Dtvf84yJ4YLU6mP71jvHvQ=;
        b=DPvQ3rgHEitp4diGzRBZwQCYemUQsc4DZ/b3ZsSZxM5bXJUmTDbASs5UZOzeSGHj+b
         SJmZA6rXjNH9WhG04AhW64C5KgSYjEXlFQ0aN5v4A3AUfqDK1Mlx8M5ZkipFQrW74q74
         tbEr5aeLbEIKWL5YWtENPBFoYbmJENAH+pJK1RpodYPQlS/0GSJLloQrg54E1YqOixW8
         kYbwl7pB6yPjpA1iR79rQMLhQNUXniF8WfCPAClnsrtCudDPq44sP7nmUf/u3w5+xopr
         2a9oChPV4kKRli1BMcY9CWdCjwLW01Fkkgm0m8jzLVfbPkU0iCS4oPR/qmyjRhpkM5T8
         Nm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788977440; x=1789582240;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jjnxEfr3Uzi7pXtCU8OB5Dtvf84yJ4YLU6mP71jvHvQ=;
        b=n7KuHyjki2wA06Ygt0DJioAujq+nsoP143q6pj4TGyWnLxnjjkS+QmuAAIlvP8n4Er
         O70xFSIM8i9DV5KDk9YFUtHl+VJy0TisMgx9nxMgxQ3vTaQT3h6mexIIu6GQrELhMkpJ
         7gOm0DCpSahfCwMwvJPojPGwGj19ioWQVF3yMEfclr+Q6BaM3wW0M/hQg3p7lpsxTKl0
         cPawn7Ix6MG+nGjjzl/kiEc0P2NrCKgBJJ4NjNh1Mzjl59dHhF8LiDzrKpAZEqiMNq09
         GUaputoMui3W7WMalt8Py3obQyUbcLL6Hnd3su7Sr2UWRtLThoQiG17J5t2YcuMRvWI/
         wPsw==
X-Forwarded-Encrypted: i=1; AKwUvBw61JpAtl3Z3zyQZGIM1qmKASaueOP+kwNeUFsTBawCaW6qnR+LSbe6Kxazi+YBpXEphPa0G4qT8qUBCC/BD49v@vger.kernel.org
X-Gm-Message-State: AFuF++miP0nj0xm0dA1KvesxhpNgu4ZLIupx+J/mIkUHDJrK2INaAVXt
	MFL6OIc0R8nuaZy2uPqMrxgtnieKdgkOKg4s4wnr7TlBh3gCN/duOhfzebn9nEpi1Vz/sGLISZ5
	pQLq8tRqtEQ==
X-Received: from dlbrj9.prod.google.com ([2002:a05:7022:f409:b0:140:f3bd:b2fa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f87:b0:38e:250b:122f
 with SMTP id 98e67ed59e1d1-39b261e75femr54573828a91.16.1788977439844; Wed, 09
 Sep 2026 11:10:39 -0700 (PDT)
Date: Wed,  9 Sep 2026 11:10:30 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260909181030.1870496-1-irogers@google.com>
Subject: [PATCH v1] tools build: Add explicitly sequenced -lzstd to libbfd
 feature fallback
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, Tomas Glozar <tglozar@redhat.com>, 
	Michael Jeanson <mjeanson@efficios.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Leo Yan <leo.yan@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Distributions like Fedora currently ship a statically compiled binutils
libbfd that natively depends on zstd to decompress sections (e.g.
undefined reference to 'ZSTD_decompress').

Since libbfd generally does not reliably distribute a .pc file for
pkg-config (e.g. 'binutils-dev' evaluates missing on standard PKG_CONFIG_PATH
checks), perf historically supplements manual linker flags in fallback
chains (-lbfd -ldl -liberty -lz).

Extend the testing cascade in tools/build/feature/Makefile and
tools/perf/Makefile.config to probe for '-lz -lzstd' when the basic
fallback variants fail, natively supporting statically compiled binutils on
recent distributions.

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/build/Makefile.feature |  3 ++-
 tools/build/feature/Makefile | 12 +++++++++---
 tools/perf/Makefile.config   |  2 ++
 3 files changed, 13 insertions(+), 4 deletions(-)

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
 
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 4d5993da9f94..24a99545c9bc 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -906,6 +906,8 @@ ifdef BUILD_NONDISTRO
     EXTLIBS += -lbfd -lopcodes -liberty
   else ifeq ($(feature-libbfd-liberty-z), 1)
     EXTLIBS += -lbfd -lopcodes -liberty -lz
+  else ifeq ($(feature-libbfd-liberty-z-zstd), 1)
+    EXTLIBS += -lbfd -lopcodes -liberty -lz -lzstd
   endif
 
   CFLAGS += -DHAVE_LIBBFD_SUPPORT
-- 
2.55.0.1003.g10538fe699-goog

