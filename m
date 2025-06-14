Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD02D1DED5D;
	Sat, 14 Jun 2025 04:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749876223; cv=none; b=FbO8m4IFmS1IO/7/HDEs5a90bjZF4SQLPrJ6cVNUO73psxB1wIo2GjaTLanR2kFuTklF8vA3yFayFa4GIXmZTnGx58k49xRd1t8pmsrfbhY5ZTNt9wyNi/wAFrV+mlulGo9P0tL++cxa94d3VM0vJvoTT0aYZPSvyxixO35ixr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749876223; c=relaxed/simple;
	bh=DFaxT6+s/Nle/3us53Y5IO+wxfnupBIhNM8NsGHK2Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szbycR2Ft8uhJMbuhr9rF1annLnaA0/rp3SIIvRjzLGM6tUUuM+vVA3vaX892FtWehDin69NOcgxNQpXzdjMgQLPoqLUHZg1b6Uyxw8S6q6u18V7/I2wMghi8PvYv3PSmktVfQ4W4cyT4nLb7JNIiZrRQ3p8nsBIYwSBiVvumdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ2/ELd0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ2/ELd0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3C3C4CEF1;
	Sat, 14 Jun 2025 04:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749876223;
	bh=DFaxT6+s/Nle/3us53Y5IO+wxfnupBIhNM8NsGHK2Ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZ2/ELd0OWqTLEr7PsuRVrKG/e/JQKH3vZvMUYOWUzCZfAFX7LluuePQbm/4Bq8N9
	 jyn4IwN31i066uWSd86e+naJ782oLKITHZJyIKfHwXgCHeiJXldVPAlVbpMjEZxMVv
	 e24mvwW/GECimx52BgLhH2p/UXsOKq6wx7yVHKarn2VT1sLcygSTYUw8dAlbBCK0HF
	 RRNcl6tlrbV0YRjynMPBCDgSyO7pTGDtBa+3yn1K1dwZEyRPZDLDcnx6vaOQFBDkuP
	 AeOi9Ig6w9P4af0LEGUmu+r4clLTUSTuaFgCXJgSrMR1SgW1g9Zxktg6b4bgL5rghO
	 g06jIgsxYYXrQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Yuzhuo Jing <yuzhuo@google.com>
Subject: [PATCH v2 4/4] tools: Remove libcrypto dependency
Date: Fri, 13 Jun 2025 21:41:33 -0700
Message-ID: <20250614044133.660848-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250614044133.660848-1-ebiggers@kernel.org>
References: <20250614044133.660848-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuzhuo Jing <yuzhuo@google.com>

Remove all occurrence of libcrypto in the build system.

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tools/build/Makefile.feature            |  2 --
 tools/build/feature/Makefile            |  4 ----
 tools/build/feature/test-all.c          |  5 -----
 tools/build/feature/test-libcrypto.c    | 25 -------------------------
 tools/perf/Documentation/perf-check.txt |  1 -
 tools/perf/Makefile.config              | 13 -------------
 tools/perf/Makefile.perf                |  3 ---
 tools/perf/builtin-check.c              |  1 -
 tools/perf/tests/make                   |  4 +---
 9 files changed, 1 insertion(+), 57 deletions(-)
 delete mode 100644 tools/build/feature/test-libcrypto.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 57bd995ce6afa..bbadfb5568ebe 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -84,11 +84,10 @@ FEATURE_TESTS_BASIC :=                  \
         libpython                       \
         libslang                        \
         libtraceevent                   \
         libtracefs                      \
         libcpupower                     \
-        libcrypto                       \
         pthread-attr-setaffinity-np     \
         pthread-barrier     		\
         reallocarray                    \
         stackprotector-all              \
         timerfd                         \
@@ -150,11 +149,10 @@ FEATURE_DISPLAY ?=              \
          libelf                 \
          libnuma                \
          numa_num_possible_cpus \
          libperl                \
          libpython              \
-         libcrypto              \
          libcapstone            \
          llvm-perf              \
          zlib                   \
          lzma                   \
          get_cpuid              \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index b8b5fb183dd40..04a4aa0341aae 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -36,11 +36,10 @@ FILES=                                          \
          test-libslang.bin                      \
          test-libslang-include-subdir.bin       \
          test-libtraceevent.bin                 \
          test-libcpupower.bin                   \
          test-libtracefs.bin                    \
-         test-libcrypto.bin                     \
          test-libunwind.bin                     \
          test-libunwind-debug-frame.bin         \
          test-libunwind-x86.bin                 \
          test-libunwind-x86_64.bin              \
          test-libunwind-arm.bin                 \
@@ -244,13 +243,10 @@ $(OUTPUT)test-libcpupower.bin:
 	$(BUILD) -lcpupower
 
 $(OUTPUT)test-libtracefs.bin:
 	 $(BUILD) $(shell $(PKG_CONFIG) --cflags libtracefs 2>/dev/null) -ltracefs
 
-$(OUTPUT)test-libcrypto.bin:
-	$(BUILD) -lcrypto
-
 $(OUTPUT)test-gtk2.bin:
 	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null) -Wno-deprecated-declarations
 
 $(OUTPUT)test-gtk2-infobar.bin:
 	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null)
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 03ddaac6f4c4d..ce72e2061ac0a 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -136,14 +136,10 @@
 
 #define main main_test_bpf
 # include "test-bpf.c"
 #undef main
 
-#define main main_test_libcrypto
-# include "test-libcrypto.c"
-#undef main
-
 #define main main_test_sdt
 # include "test-sdt.c"
 #undef main
 
 #define main main_test_setns
@@ -204,11 +200,10 @@ int main(int argc, char *argv[])
 	main_test_pthread_attr_setaffinity_np();
 	main_test_pthread_barrier();
 	main_test_lzma();
 	main_test_get_cpuid();
 	main_test_bpf();
-	main_test_libcrypto();
 	main_test_scandirat();
 	main_test_sched_getcpu();
 	main_test_sdt();
 	main_test_setns();
 	main_test_libaio();
diff --git a/tools/build/feature/test-libcrypto.c b/tools/build/feature/test-libcrypto.c
deleted file mode 100644
index bc34a5bbb5049..0000000000000
--- a/tools/build/feature/test-libcrypto.c
+++ /dev/null
@@ -1,25 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <openssl/evp.h>
-#include <openssl/sha.h>
-#include <openssl/md5.h>
-
-int main(void)
-{
-	EVP_MD_CTX *mdctx;
-	unsigned char md[MD5_DIGEST_LENGTH + SHA_DIGEST_LENGTH];
-	unsigned char dat[] = "12345";
-	unsigned int digest_len;
-
-	mdctx = EVP_MD_CTX_new();
-	if (!mdctx)
-		return 0;
-
-	EVP_DigestInit_ex(mdctx, EVP_md5(), NULL);
-	EVP_DigestUpdate(mdctx, &dat[0], sizeof(dat));
-	EVP_DigestFinal_ex(mdctx, &md[0], &digest_len);
-	EVP_MD_CTX_free(mdctx);
-
-	SHA1(&dat[0], sizeof(dat), &md[0]);
-
-	return 0;
-}
diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
index a764a46292206..2b96cb5786581 100644
--- a/tools/perf/Documentation/perf-check.txt
+++ b/tools/perf/Documentation/perf-check.txt
@@ -51,11 +51,10 @@ feature::
                 dwarf_getlocations      /  HAVE_LIBDW_SUPPORT
                 dwarf-unwind            /  HAVE_DWARF_UNWIND_SUPPORT
                 auxtrace                /  HAVE_AUXTRACE_SUPPORT
                 libbfd                  /  HAVE_LIBBFD_SUPPORT
                 libcapstone             /  HAVE_LIBCAPSTONE_SUPPORT
-                libcrypto               /  HAVE_LIBCRYPTO_SUPPORT
                 libdw-dwarf-unwind      /  HAVE_LIBDW_SUPPORT
                 libelf                  /  HAVE_LIBELF_SUPPORT
                 libnuma                 /  HAVE_LIBNUMA_SUPPORT
                 libopencsd              /  HAVE_CSTRACE_SUPPORT
                 libperl                 /  HAVE_LIBPERL_SUPPORT
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 1691b47c4694c..376929c15b989 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -132,12 +132,10 @@ ifndef NO_LIBUNWIND
   FEATURE_CHECK_LDFLAGS-libunwind-aarch64 += -lunwind -lunwind-aarch64
   FEATURE_CHECK_LDFLAGS-libunwind-x86 += -lunwind -llzma -lunwind-x86
   FEATURE_CHECK_LDFLAGS-libunwind-x86_64 += -lunwind -llzma -lunwind-x86_64
 endif
 
-FEATURE_CHECK_LDFLAGS-libcrypto = -lcrypto
-
 ifdef CSINCLUDES
   LIBOPENCSD_CFLAGS := -I$(CSINCLUDES)
 endif
 OPENCSDLIBS := -lopencsd_c_api -lopencsd
 ifeq ($(findstring -static,${LDFLAGS}),-static)
@@ -774,21 +772,10 @@ endif
 
 ifneq ($(NO_LIBTRACEEVENT),1)
   $(call detected,CONFIG_TRACE)
 endif
 
-ifndef NO_LIBCRYPTO
-  ifneq ($(feature-libcrypto), 1)
-    $(warning No libcrypto.h found, disables jitted code injection, please install openssl-devel or libssl-dev)
-    NO_LIBCRYPTO := 1
-  else
-    CFLAGS += -DHAVE_LIBCRYPTO_SUPPORT
-    EXTLIBS += -lcrypto
-    $(call detected,CONFIG_CRYPTO)
-  endif
-endif
-
 ifndef NO_SLANG
   ifneq ($(feature-libslang), 1)
     ifneq ($(feature-libslang-include-subdir), 1)
       $(warning slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev)
       NO_SLANG := 1
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d4c7031b01a77..9246c94656e03 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -59,13 +59,10 @@ include ../scripts/utilities.mak
 #
 # Define NO_LIBNUMA if you do not want numa perf benchmark
 #
 # Define NO_LIBBIONIC if you do not want bionic support
 #
-# Define NO_LIBCRYPTO if you do not want libcrypto (openssl) support
-# used for generating build-ids for ELFs generated by jitdump.
-#
 # Define NO_LIBDW_DWARF_UNWIND if you do not want libdw support
 # for dwarf backtrace post unwind.
 #
 # Define NO_LIBTRACEEVENT=1 if you don't want libtraceevent to be linked,
 # this will remove multiple features and tools, such as 'perf trace',
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 9a509cb3bb9a0..ad49f2564aae2 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -42,11 +42,10 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("dwarf_getlocations", HAVE_LIBDW_SUPPORT),
 	FEATURE_STATUS("dwarf-unwind", HAVE_DWARF_UNWIND_SUPPORT),
 	FEATURE_STATUS("auxtrace", HAVE_AUXTRACE_SUPPORT),
 	FEATURE_STATUS_TIP("libbfd", HAVE_LIBBFD_SUPPORT, "Deprecated, license incompatibility, use BUILD_NONDISTRO=1 and install binutils-dev[el]"),
 	FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
-	FEATURE_STATUS("libcrypto", HAVE_LIBCRYPTO_SUPPORT),
 	FEATURE_STATUS("libdw-dwarf-unwind", HAVE_LIBDW_SUPPORT),
 	FEATURE_STATUS("libelf", HAVE_LIBELF_SUPPORT),
 	FEATURE_STATUS("libnuma", HAVE_LIBNUMA_SUPPORT),
 	FEATURE_STATUS("libopencsd", HAVE_CSTRACE_SUPPORT),
 	FEATURE_STATUS("libperl", HAVE_LIBPERL_SUPPORT),
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 0ee94caf9ec19..e3651e5b195a4 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -89,11 +89,10 @@ make_no_libnuma     := NO_LIBNUMA=1
 make_no_libbionic   := NO_LIBBIONIC=1
 make_no_auxtrace    := NO_AUXTRACE=1
 make_no_libbpf	    := NO_LIBBPF=1
 make_libbpf_dynamic := LIBBPF_DYNAMIC=1
 make_no_libbpf_DEBUG := NO_LIBBPF=1 DEBUG=1
-make_no_libcrypto   := NO_LIBCRYPTO=1
 make_no_libllvm     := NO_LIBLLVM=1
 make_with_babeltrace:= LIBBABELTRACE=1
 make_with_coresight := CORESIGHT=1
 make_no_sdt	    := NO_SDT=1
 make_no_libpfm4     := NO_LIBPFM4=1
@@ -120,11 +119,11 @@ make_static         := LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX3
 # all the NO_* variable combined
 make_minimal        := NO_LIBPERL=1 NO_LIBPYTHON=1 NO_GTK2=1
 make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_BACKTRACE=1
 make_minimal        += NO_LIBNUMA=1 NO_LIBBIONIC=1
 make_minimal        += NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1
-make_minimal        += NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
+make_minimal        += NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
 make_minimal        += NO_LIBCAP=1 NO_CAPSTONE=1
 
 # $(run) contains all available tests
 run := make_pure
 # Targets 'clean all' can be run together only through top level
@@ -158,11 +157,10 @@ run += make_no_libcapstone
 run += make_no_libnuma
 run += make_no_libbionic
 run += make_no_auxtrace
 run += make_no_libbpf
 run += make_no_libbpf_DEBUG
-run += make_no_libcrypto
 run += make_no_libllvm
 run += make_no_sdt
 run += make_no_syscall_tbl
 run += make_with_babeltrace
 run += make_with_coresight
-- 
2.49.0

