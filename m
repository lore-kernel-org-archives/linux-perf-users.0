Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CD03FD4;
	Thu, 17 Apr 2025 02:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744856340; cv=none; b=nIgW57VoZcGV2EWiAXcNiBrKxcL1oFf6S/xm0BLe0nTFwY3pL4h+O7EZF39ys+D5ykIukWJ7RQ1Pfq6ZxTyGuMEZrkhJwq6rASEheR2nGsdhPFImzliD4k708+WokGhMiXnXFzq2NhbEw0OjxpVg1tHSYQHigDqsRM0k4HN7xVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744856340; c=relaxed/simple;
	bh=16Oa1q9y+9XkxlsV4Oxqr1zIWMw7KbWTyGMYkvFZyxw=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V7hLjCl60pAhFb2FViaPj5RaDJ4yITEDjd3xztworNDiZ81jFMllE6VqTzqIaUQPe448o/dC5Gp57CJ7l191FDX4NyzrBwoFnYK3YFSpwtpvKvI3rLXVhwi1wkpXlhjh+ip/FXQk7lfDjJfdjBtuzbuqVDSaQ4NUAPePs2EOSKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqkVWNJy; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqkVWNJy"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-227a8cdd241so3767255ad.3;
        Wed, 16 Apr 2025 19:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744856338; x=1745461138; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C8p7/NM2DCHM9rmByNHzZ+tqh5X5fRWqqOeEIB2TbDY=;
        b=lqkVWNJyP/OzwCsZgVuYK8/cc3fB1JMjpnVUgWV0eZ1XpxcBLlLpZTdnfQxtXyjRD7
         9C+AJWUABci+hH1k5sPfwDYyG3Z1jfG0Wq+cSgFNFEQopTHBzWoCEysIdJvFwQXg1B3F
         5WkbiBMdT/IZSoSEIYaqA/8qgStTiX8V+Uey8T8cMZEckSrR4wph6LDe0WiCaI1StRrB
         RjN1b/dP2qt9yRdONVuRm0XQAF2jvovRs617GNpT2MLv/Mf4oXPaBt3tIUXPPJzAJSM6
         J/BU1V/TMb2PjrAXdKOKODxdIm1NpkI3lMzxdV6rJOwK8saQsKmNG4kyEk8aixxiLOTN
         pEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744856338; x=1745461138;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8p7/NM2DCHM9rmByNHzZ+tqh5X5fRWqqOeEIB2TbDY=;
        b=TU/kFEBtQCxN4tud5ka9tSQMs6IXZXvcI+QesDlNAYeEof9YExkTAuaImBE0bPRld/
         dqQwdld4dYz/Z7KR+v5ppMNNthJeYl3QsGuk4SyI4JuWciwsVcd1/u1NezDLzl6MLRRf
         oFUZ12aVeyQVG3q/yk9vzwKmJoTP1d5pw2V8Z0LhDSzDly4DcKTtZOu4KogQKmfD26AX
         o7+AhLQv7ohqTsvqYaVL9xNvJXZzE1FcPuiWOamDpizjvqakY3sa8RF/7IbicnWXO/9W
         wW771piFGBYAqUxdXJF7cpmd33ztpFRBqvuJETptvjcLkjj/tFHyJiwfgQPg8gwT2nsy
         NSgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTwJ6KafbqBJm05zm9ldD4VnuzTKEBemldtmjSFHKWN6/+sLDKiedT8uKu3idMqvQdC10CgQ+kZICC2dY=@vger.kernel.org, AJvYcCWc/0Dh7QXZaK9OsSUYX/rxoKoBrDQAAvcwbxpvfZ78oIQ1lm0twfkWEccyOMT5KxI7EXMdwp85MnZ9zRebOKrUKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXipodZm1HqvKu3Jya0VzW8dHQpxwW0DUzzPexBQIXb8LmbpVS
	iHWPgcMh9nykQqM7bLCTLHi7WsyXBWEX3xhU48weuqKiKKI8m1TX
X-Gm-Gg: ASbGncuVAVT51x13IaXrJ0p4joAJbzFvC6nfuTn1LahUMzYfPssA5aeva6drCJ3CM+m
	4yRfRp1T5bpYGLXRXyiHsYmxZPCMw8eobgaRsp9H7zjbA2zdcNQ9b/pVAU1BZisEV+xWGZEdasA
	ZlVfMqUjreTH8I8YbbNA8uVEaNhr3QC+0jKXQXKwDO6XXGmpLCqam4ohXblJUm/zma5qbJZZjpU
	hEAgVTMwLBlqszQs/ospPryoU4Fh04IjL+n5IBhMoOCsvxnWp1LaboOeeTdC+KoopMnCwHS44Vf
	tUBnJbPoGbXYSckg3VHVMoa9HgtAIKm+Lv9Q87M=
X-Google-Smtp-Source: AGHT+IG+yCgFBeh9vlR+BFs229WzadUXdK+fn/TPcOb8QzgLTfWNM8G/X+74i9tJPATHhVAQaZ3ByA==
X-Received: by 2002:a17:903:2a8e:b0:21f:b483:2ad5 with SMTP id d9443c01a7336-22c358db5edmr55632345ad.20.1744856338108;
        Wed, 16 Apr 2025 19:18:58 -0700 (PDT)
Received: from localhost ([189.89.54.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1c1e6sm21851005ad.63.2025.04.16.19.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 19:18:57 -0700 (PDT)
From: arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Wed, 16 Apr 2025 23:18:55 -0300
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Quentin Monnet <qmo@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] tools build: Remove libbfd from the set of expected
 libraries to build perf
Message-ID: <aABlDyhAYz95vOM1@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The tools/build/feature/test-all.c file tries to build with the most
common set of libraries expected to be present to build perf, and these
days libbfd (binutils) isn't one since it was made opt-in via
BUILD_NONDISTRO=1 on the make command line as it has license issues.

Fix this by removing the tests from there.

Fixes: dd317df072071903 ("perf build: Make binutil libraries opt in")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature   | 12 ------------
 tools/build/feature/Makefile   |  2 +-
 tools/build/feature/test-all.c | 19 -------------------
 tools/perf/Makefile.config     |  1 +
 4 files changed, 2 insertions(+), 32 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 57bd995ce6afa318..da025a8040a9a154 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -42,17 +42,12 @@ endef
 #
 #   All the others should have lines in tools/build/feature/test-all.c like:
 #
-#    #define main main_test_disassembler_init_styled
-#    # include "test-disassembler-init-styled.c"
-#    #undef main
-#
 #    #define main main_test_libzstd
 #    # include "test-libzstd.c"
 #    #undef main
 #
 #    int main(int argc, char *argv[])
 #    {
-#      main_test_disassembler_four_args();
 #      main_test_libzstd();
 #      return 0;
 #    }
@@ -60,7 +55,6 @@ endef
 #    If the sample above works, then we end up with these lines in the FEATURE-DUMP
 #    file:
 #
-#    feature-disassembler-four-args=1
 #    feature-libzstd=1
 #
 FEATURE_TESTS_BASIC :=                  \
@@ -71,8 +65,6 @@ FEATURE_TESTS_BASIC :=                  \
         get_current_dir_name            \
         gettid				\
         glibc                           \
-        libbfd                          \
-        libbfd-buildid			\
         libelf                          \
         libelf-getphdrnum               \
         libelf-gelf_getnote             \
@@ -102,8 +94,6 @@ FEATURE_TESTS_BASIC :=                  \
         setns				\
         libaio				\
         libzstd				\
-        disassembler-four-args		\
-        disassembler-init-styled	\
         file-handle
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
@@ -119,8 +109,6 @@ FEATURE_TESTS_EXTRA :=                  \
          hello                          \
          libbabeltrace                  \
          libcapstone                    \
-         libbfd-liberty                 \
-         libbfd-liberty-z               \
          libopencsd                     \
          cxx                            \
          llvm                           \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index b8b5fb183dd40693..76724931f68e1b92 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -110,7 +110,7 @@ all: $(FILES)
 __BUILD = $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.c,$(@F)) $(LDFLAGS)
   BUILD = $(__BUILD) > $(@:.bin=.make.output) 2>&1
   BUILD_BFD = $(BUILD) -DPACKAGE='"perf"' -lbfd -ldl
-  BUILD_ALL = $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd
+  BUILD_ALL = $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -lz -llzma -lzstd
 
 __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
   BUILDXX = $(__BUILDXX) > $(@:.bin=.make.output) 2>&1
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 03ddaac6f4c4dfa2..1010f233d9c1ad49 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -66,14 +66,6 @@
 # include "test-libslang.c"
 #undef main
 
-#define main main_test_libbfd
-# include "test-libbfd.c"
-#undef main
-
-#define main main_test_libbfd_buildid
-# include "test-libbfd-buildid.c"
-#undef main
-
 #define main main_test_backtrace
 # include "test-backtrace.c"
 #undef main
@@ -158,14 +150,6 @@
 # include "test-reallocarray.c"
 #undef main
 
-#define main main_test_disassembler_four_args
-# include "test-disassembler-four-args.c"
-#undef main
-
-#define main main_test_disassembler_init_styled
-# include "test-disassembler-init-styled.c"
-#undef main
-
 #define main main_test_libzstd
 # include "test-libzstd.c"
 #undef main
@@ -193,8 +177,6 @@ int main(int argc, char *argv[])
 	main_test_libelf_gelf_getnote();
 	main_test_libelf_getshdrstrndx();
 	main_test_libslang();
-	main_test_libbfd();
-	main_test_libbfd_buildid();
 	main_test_backtrace();
 	main_test_libnuma();
 	main_test_numa_num_possible_cpus();
@@ -213,7 +195,6 @@ int main(int argc, char *argv[])
 	main_test_setns();
 	main_test_libaio();
 	main_test_reallocarray();
-	main_test_disassembler_four_args();
 	main_test_libzstd();
 	main_test_libtraceevent();
 	main_test_libtracefs();
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 9f08a6e96b351707..7e9aa3d910c2cdcc 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -917,6 +917,7 @@ ifneq ($(NO_JEVENTS),1)
 endif
 
 ifdef BUILD_NONDISTRO
+  $(call feature_check,libbfd)
   ifeq ($(feature-libbfd), 1)
     EXTLIBS += -lbfd -lopcodes
   else
-- 
2.49.0

