Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C222DF3EF;
	Wed, 25 Jun 2025 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750883082; cv=none; b=DwkTq8OzFx0dDnmc68D5M96CLMkrCGzP+56v1wcfYGj3foBYOAk2uD1SDny9R/GRmrROtgdEBLX7N3L18GJB5+S7Rjy62Te6UcoBrhvLkPcOchMKXNsdlE9vLxSui7crRxzuIVDiMWlnGclG7ZCsywlFuRt8qRFe+jC60DWNvk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750883082; c=relaxed/simple;
	bh=AeGCF5QSxq0iTaxJ9oYqD/TZZRHC37rqUGBxrhBVgwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+FLkYAZBTI+sac25l1VbaeoCNXy331o0tfDF67OR5luvQD7Q59iQC6k6FFoJhane36emY4D2EnW6k/pM8zbJ4wYaDRtmX0MSeGywFnkUafIa3llNvR0Ymsdpo+D0me9A50e1L7kAyDaqmJJJkXc+poEXM8MLdnIXlMXkciDJIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXbMYssn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXbMYssn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3B0C4CEF5;
	Wed, 25 Jun 2025 20:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750883082;
	bh=AeGCF5QSxq0iTaxJ9oYqD/TZZRHC37rqUGBxrhBVgwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mXbMYssn0/O3WnhghJ0LGpgwYPJCrMXih4v5FpyFvAUU0mvtssImITPzEdhRRzHOZ
	 txsrdwO9IYykMu3ibh5gM+cqOiJd+EzXtHLZ+mUEmdL8oVKQoZA4dyR5mfJ8vdGfQi
	 dmgJOdYuLIpsYpQ/kEj8DNixaI8VGDL8P2Yi4dwQL0fW6H8ii48G1O33jpwOJuH23P
	 s63BW2zcynWRZB5i81cC33Godpd1LWeg8o+1cctdIlAexrfMibtTvo/+28Bz5AvvTG
	 TjMAi/tLP3Aw3X4uqiZB076n0uXJ8YoMKuCL8krSnSfQoNLP4blrRDe0VAxW9eGCPg
	 lcmmxYmo9GBAQ==
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
	Yuzhuo Jing <yuzhuo@google.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v3 4/4] tools: Remove libcrypto dependency
Date: Wed, 25 Jun 2025 13:23:11 -0700
Message-ID: <20250625202311.23244-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625202311.23244-1-ebiggers@kernel.org>
References: <20250625202311.23244-1-ebiggers@kernel.org>
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
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
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
index 2e5f4c8b65476..649c5ab8e8f26 100644
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
@@ -145,11 +144,10 @@ FEATURE_DISPLAY ?=              \
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
index 0c4e541ed56e8..b41a42818d8ac 100644
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
@@ -245,13 +244,10 @@ $(OUTPUT)test-libcpupower.bin:
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
index 1010f233d9c1a..4419fb4710bd1 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -128,14 +128,10 @@
 
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
@@ -186,11 +182,10 @@ int main(int argc, char *argv[])
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
index 799982d8d8687..ee92042082f73 100644
--- a/tools/perf/Documentation/perf-check.txt
+++ b/tools/perf/Documentation/perf-check.txt
@@ -52,11 +52,10 @@ feature::
                 dwarf-unwind            /  HAVE_DWARF_UNWIND_SUPPORT
                 auxtrace                /  HAVE_AUXTRACE_SUPPORT
                 libbfd                  /  HAVE_LIBBFD_SUPPORT
                 libbpf-strings          /  HAVE_LIBBPF_STRINGS_SUPPORT
                 libcapstone             /  HAVE_LIBCAPSTONE_SUPPORT
-                libcrypto               /  HAVE_LIBCRYPTO_SUPPORT
                 libdw-dwarf-unwind      /  HAVE_LIBDW_SUPPORT
                 libelf                  /  HAVE_LIBELF_SUPPORT
                 libnuma                 /  HAVE_LIBNUMA_SUPPORT
                 libopencsd              /  HAVE_CSTRACE_SUPPORT
                 libperl                 /  HAVE_LIBPERL_SUPPORT
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 70a3e771c7c08..5a5832ee7b53c 100644
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
@@ -782,21 +780,10 @@ endif
 
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
index 4f292edeca5a8..62697d62f7060 100644
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
index f4827f0ddb471..b1e205871ab17 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -43,11 +43,10 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("dwarf-unwind", HAVE_DWARF_UNWIND_SUPPORT),
 	FEATURE_STATUS("auxtrace", HAVE_AUXTRACE_SUPPORT),
 	FEATURE_STATUS_TIP("libbfd", HAVE_LIBBFD_SUPPORT, "Deprecated, license incompatibility, use BUILD_NONDISTRO=1 and install binutils-dev[el]"),
 	FEATURE_STATUS("libbpf-strings", HAVE_LIBBPF_STRINGS_SUPPORT),
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
2.50.0

