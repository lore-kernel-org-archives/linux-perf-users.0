Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E9E215F5C
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Feb 2026 12:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770553375; cv=none; b=IAsLcoWEnyiFWWhikelZndbjvgk+P7UVk/aZaKirCyxBCXENHomXkYHLGYvqwDhkwN1SV6Og2KSvKt9f+GobyBLXFbzHXTIB6kw1uqBec5j6X7ctFsiTODQZks7htkOXTx1umf7hNBVtWGjLRlVzBJXXiiFCXWB3h3H8JJs6F78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770553375; c=relaxed/simple;
	bh=OK+PuVd9l77LQCmkyTiKMXsFhn+urBzlKuHVgU2X5Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIkIV/QyEACa50+H7ha25t8JFkbFiizjfdZSUdUHGxWCOcSPI2+Xvzj/tTsNmlwxubmtmTDu7ItWSW782S6Mf8Tu8U34hGBSK94/YgmTW9y1KJ1UuhG/F03jx0gXvTjZbqAntLBQs7QIPzIxhh2dHki8O2BPtZB1n0aBoScCjJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpcmnYy8; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpcmnYy8"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8e9c8ada38so591962566b.0
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Feb 2026 04:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770553373; x=1771158173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBpHWwV80aiTtzAL3oJkNrJGKZzlKV+MvXTqCo+Ts3c=;
        b=dpcmnYy8q9DjWnDBbJBKKzOAWlBfHhFlF4RF0t/JBVblOzIdGEnS3TqMMwy3wYCMtQ
         HfASx2Qd/i8qQ0u3dmlHkXlZseAbaIa2gn2VElb0zSeKprWEzus+PbZxZCI6bLgmvIKm
         1+vIg2RdjT4m+Ddl6qCzTJ6yOKWxJf6YEndbX3TZ065nPxxEr0ZxtU4LCtjIKt/jXrGh
         PVARMNp2il9dy4EX+WtvLH16KbNjMhkEZde2KVHlmJtxhxyE0yqofQcahjUO/e6DO5qC
         uHwYGAhy122zxGbLiVRzRzwPWuQPrC3vkzcRKgUdhjVwSc2i1QcoprJyuffomZQFBPlf
         QFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770553373; x=1771158173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qBpHWwV80aiTtzAL3oJkNrJGKZzlKV+MvXTqCo+Ts3c=;
        b=ZGjuUmG/1qtAara4WiNkD3YH8rohac8FFD2q/rVWGvpY1DZ8hDIhF0yoFMZVzrZuj5
         UZGhfGu4HFAgVdT3Xn+CupVQDHE3LY3c9u1pNPpYpAqlyM6iQqe1uvcPYCVxSdswM3fh
         Imj3al9p/1fapwKWRu4VdSdTG2pAyTSGTHsEEehhTKkogkNroliNEJAyW62tSJll8oH6
         yuDJzjUElpz3FFJ5b8ABcRzp5pFYPv6KBDGwRepf/jE5e3k9eaaiRCkkyoN+4jZwJCdE
         JYYZazPDQWFZsKDNdCGuerHpnV9kMyZT98Jx01cO1dkzKzEzc8kpGLQF78/cDtO0m6hn
         d1EQ==
X-Gm-Message-State: AOJu0Yy+uUKH554YpYNwhNDrGA0nglNfHuJ4s6J3HlmyF+L7005JyPJR
	fLMv5784kGunitHroE4fyzSYvk/lC59PFtu2Q7ILLD41+EeF5Qb1fGW/Z7b61Q==
X-Gm-Gg: AZuq6aLJfD0qaezY4iVFhPUyLMR8bN/vcyHXS23sNCPZLN5KeU+yhPMQERAaxfPPtDU
	x/YiYqHN1hUFOiGHlTpeTB5nMgAAlVFleK1gt3RLrfPk0QspR3IitRDpELgce8QgBtfh8nejlL4
	xF1Dt+0Ur4mfSIHzBxqwEdXbfzkCrwe6wh6il9ZOdU1V829N2toRZS9INYcqfkjqWcS01ovsdnl
	cS4JM5fC2sXtWp75G3vmrMw/icjjzQabNsrlePq9xmmWVWeICmi8OKWa+uGBivgV5p0Ml0BaoyK
	09EULgXBmYy06O2TG1Qi2dwyCp/J7rgkVT+btS2o/eXu7hXyGbYmF+K/BmtV4bUgsJ/kA34Csl+
	moLJ7a5S6uKweXh+iigWgI6Z+OhNO6/TUgxrPmkX1EINbNHDVUD/fjLV0UuqJ2z+GaqHp7YxZeb
	YqnmPp1qPEKOQYunX693i5V0D3AJJ5ounpeViNmYtqsOH9yUdkzttJuQjAdsdu7stCf7EFiDCyB
	nlhUIqrvkHdGYlZTdA=
X-Received: by 2002:a17:907:96aa:b0:b88:dc6:3967 with SMTP id a640c23a62f3a-b8edf340f9amr529036466b.40.1770553373094;
        Sun, 08 Feb 2026 04:22:53 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.local (dslb-002-207-075-089.002.207.pools.vodafone-ip.de. [2.207.75.89])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65984024e11sm2011658a12.32.2026.02.08.04.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 04:22:51 -0800 (PST)
From: Dmitrii Dolgov <9erthalion6@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [RFC PATCH v2 1/4] tools/build: Add a feature test for rust compiler
Date: Sun,  8 Feb 2026 13:22:23 +0100
Message-ID: <20260208122227.3524-2-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260208122227.3524-1-9erthalion6@gmail.com>
References: <20260208122227.3524-1-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a feature test to identify if the rust compiler is available, so
that perf could build rust based worloads based on that.

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 tools/build/Makefile.feature     |  6 ++++--
 tools/build/feature/Makefile     |  7 +++++++
 tools/build/feature/test-rust.rs |  4 ++++
 tools/perf/Makefile.config       | 11 +++++++++++
 tools/perf/builtin-check.c       |  1 +
 5 files changed, 27 insertions(+), 2 deletions(-)
 create mode 100644 tools/build/feature/test-rust.rs

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 7f119eafc7c..64d21152fc8 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -100,7 +100,8 @@ FEATURE_TESTS_BASIC :=                  \
         disassembler-four-args		\
         disassembler-init-styled	\
         file-handle			\
-        libopenssl
+        libopenssl			\
+        rust
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
 # of all feature tests
@@ -149,7 +150,8 @@ FEATURE_DISPLAY ?=              \
          bpf			\
          libaio			\
          libzstd		\
-         libopenssl
+         libopenssl		\
+         rust
 
 #
 # Declare group members of a feature to display the logical OR of the detection
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 5c15572d505..9ae69d85716 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -112,6 +112,9 @@ __BUILD = $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.c,$(@F)) $(
 __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
   BUILDXX = $(__BUILDXX) > $(@:.bin=.make.output) 2>&1
 
+__BUILDRS = $(RUSTC) $(RUSTC_FLAGS) -o $@ $(patsubst %.bin,%.rs,$(@F))
+  BUILDRS = $(__BUILDRS) > $(@:.bin=.make.output) 2>&1
+
 ###############################
 
 $(OUTPUT)test-all.bin:
@@ -388,6 +391,10 @@ $(OUTPUT)test-libopenssl.bin:
 $(OUTPUT)test-bpftool-skeletons.bin:
 	$(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons' \
 		> $(@:.bin=.make.output) 2>&1
+
+$(OUTPUT)test-rust.bin:
+	$(BUILDRS) > $(@:.bin=.make.output) 2>&1
+
 ###############################
 
 clean:
diff --git a/tools/build/feature/test-rust.rs b/tools/build/feature/test-rust.rs
new file mode 100644
index 00000000000..f2fc91cc4f6
--- /dev/null
+++ b/tools/build/feature/test-rust.rs
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+fn main() {
+    println!("hi")
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b683aab3ab9..94aecfe38b9 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1153,6 +1153,17 @@ ifneq ($(NO_LIBTRACEEVENT),1)
   endif
 endif
 
+ifndef NO_RUST
+  ifneq ($(feature-rust), 1)
+    $(warning Rust is not found. Test workloads with rust are disabled.)
+    NO_RUST := 1
+  else
+    NO_RUST := 0
+    CFLAGS += -DHAVE_RUST_SUPPORT
+    $(call detected,CONFIG_RUST_SUPPORT)
+  endif
+endif
+
 # Among the variables below, these:
 #   perfexecdir
 #   libbpf_include_dir
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index d19769a8f68..27a41beeadd 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -60,6 +60,7 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("numa_num_possible_cpus", HAVE_LIBNUMA_SUPPORT),
 	FEATURE_STATUS("zlib", HAVE_ZLIB_SUPPORT),
 	FEATURE_STATUS("zstd", HAVE_ZSTD_SUPPORT),
+	FEATURE_STATUS("rust", HAVE_RUST_SUPPORT),
 
 	/* this should remain at end, to know the array end */
 	FEATURE_STATUS(NULL, _)
-- 
2.52.0

