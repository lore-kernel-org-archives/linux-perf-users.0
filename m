Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792701999;
	b=BmHFTpMbknWHZH5l74ksQZFU9bt8kU5+HafDYT/xGld0TIxClwIDm2aVdfI7DoMu3fiu
	 GV78n8kyMG0cct/qO6tOwulP5+rp+nXpCiVTFSSE4QuE6imKB+toH2E+k8T+Do/iDNbTX
	 OQhev4tkSt0EHdFKmVBh3UQNOnCDGI9YCIRuc2zNgnfR9ggk9aYQEYYDTSwmcOisk/31S
	 +qeyQNSrnEr2Iez7K088rkqCnZTDUSJiwP1u/C4+sxaDtR8zC5BUkp7QdRZxwUjrQzh7/
	 t7tSfajJ5y3XsTrqkJuhIaHqFHK0lX1DZ7+nCg1YuH5WZFWRygOn/RWPC+qUqI+uulg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=5EXSTLNSsguQaSynPItTzP5zk0jMq4+PZis12D7icos=;
	b=tkyyvyNnCaADhXMcTGNNrKdvkPTnREP2AoxhNKeFaCpUvWCKwIkPK/itV0jWQrBvXOuM
	 LcnWdnb+aWRxvp6LpVDgJgvhVKYNR0j5MHtPX9S+cE6aJpp8GKbuZirjONz6FEATp48Gm
	 ZJCdGvgPDPJKEkSzqs467B39Vkb2SZ6sWvGLm7WJsv+gsSYgGOKQ2kKEbIQC7alLZH8i8
	 SheWntz6EDL+d8dWc1t97r3fJr7cF8Syb7W/yxyyd7omcSa84yGFLVyVw91WaQzK8BjKO
	 A7hUs3sIfvM5dAUyGTnlIfRgz+ObMgqMe23IJdlzFWSDnn9GDpQrSs3rBx3Y0JslksA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=u33GNpRG;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF396606A325
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF396606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=u33GNpRG
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-359b81ad4e8so279803eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 13:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792701998; x=1793306798; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5EXSTLNSsguQaSynPItTzP5zk0jMq4+PZis12D7icos=;
        b=u33GNpRGviPmex4xNfgxzzF6v4zZMgm6KsvsrIONWfBx5RphfJB+KWNvkgdO9Lxnye
         V2X0kj7L0OQ/sph5Ul1MFeCAVPl3h42gPfKo2n6PpRML9pZ6X6CcKBao9hQ7k7MKz0jo
         YSCE77galjDfjLW+6ksA3yhgJ/p4go3+NR01Dpw29tPNePe+3axSy0oYAJL1iKIRg+fb
         nMnVq0uRmMzfKNjnNooz03c8yvzAaPmzlOVxD9XT0R1ncCwZ8X5Z0UAplqinyVfi6h0Z
         VoO3VMO8EWTzvD3ckHdFu/qSud+C+8i1kSbi5ThW5IG+cytozbaOOACAe0c54FQX66yG
         IedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792701998; x=1793306798;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5EXSTLNSsguQaSynPItTzP5zk0jMq4+PZis12D7icos=;
        b=daNY0bpDaF/Srbu7Z6qUMys4H/M0S8FPB9SQdfMRO1Nq1JQJqjMv70K+vZg+TDnbRJ
         MQA+a4oOdA+OYqdEnSGL9Hv6Y1CF28KL5psPXbIAt7zE6X+DfNkkCYd5f0IUbl1/ZN3m
         nFzYwVIvKz1puHnCYsZcxcQHRT9qKDoOZ+BFOiW8NBnrl1DeAux0u7Xz50q3lJMh10Gd
         WZcCZsFSPEsqICeoQD8nQlQQx0HUBTkefO4wmip5iGmRG+X6GdJGHDYmlSx69iTrrPMk
         85vgG12+Qm9Cz1e9vUJJpNCU03yeLRpOqUq02R6XXrD6qDJN8TRobHbzyofWnsf3UwqL
         5doA==
X-Forwarded-Encrypted: i=1; AKwUvBz7EPOW8HlkPkxBKy3mMxUwjTu395A0W7yghaC7NUDIjoMoC8gwBxG7cbHGu7TTcf5zyEq1T2pZq9qKqOi9r4PQ@vger.kernel.org
X-Gm-Message-State: AFq9FYLbAFXTQh0eDR4oELciYb761lmTgbWqU+Ltra4z/uAKOf2BZlZg
	ml3xX5e0cboF3EZj8eSgpVWu3UB2frY4xB3eupnFKL0bwYgwooNnh25nqwzHVTixHcPOInEsMaF
	X1yXWtAx/xA==
X-Received: from dybfc19.prod.google.com ([2002:a05:7300:3e93:b0:359:198a:8046])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:608e:b0:35d:4e41:d2c2
 with SMTP id 5a478bee46e88-369d98bcdaemr432842eec.33.1792701997376; Thu, 22
 Oct 2026 13:46:37 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:46:27 -0700
In-Reply-To: <20261022204627.1813821-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261013231430.2163505-1-irogers@google.com> <20261022204627.1813821-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261022204627.1813821-3-irogers@google.com>
Subject: [PATCH v3 2/2] perf test make: Add BPF skeleton build tests for clang
 and bpf-gcc
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, cupertino.miranda@oracle.com, 
	jose.marchesi@oracle.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, andrii@kernel.org, eddyz87@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add make_bpf_skel_clang (CLANG=3Dclang BPF_GCC=3D) and make_bpf_skel_bpf_gc=
c
(BPF_GCC=3Dbpf-gcc CLANG=3D) targets to tools/perf/tests/make when the
corresponding compiler and BPF skeleton dependencies are available on
the host.

Include tools/build/Makefile.feature and tools/scripts/utilities.mak in
tools/perf/tests/make to reuse the existing feature checks
(libelf, zlib, bpf, libopenssl, clang-bpf-co-re, libbfd-threadsafe, and
llvm-perf) instead of open-coding compiler invocations.

Verify with 'perf check -q feature bpf_skeletons' that BPF skeleton
support is enabled for both targets and disabled (exit code 1) for
make_no_bpf_skel.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/make | 71 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 13 deletions(-)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 7524de522802..a40390ed47f1 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -54,6 +54,7 @@ srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
 endif
=20
 include $(srctree)/tools/scripts/Makefile.arch
+include $(srctree)/tools/scripts/utilities.mak
=20
 # FIXME looks like x86 is the only arch running tests ;-)
 # we need some IS_(32/64) flag to make this generic
@@ -65,6 +66,7 @@ endif
=20
 has =3D $(shell which $1 2>/dev/null)
 python_perf_so :=3D $(shell $(MAKE) python_perf_target|grep "Target is:"|a=
wk '{print $$3}')
+BPF_GCC ?=3D bpf-gcc
=20
 # standard single make variable specified
 make_clean_all      :=3D clean all
@@ -78,6 +80,8 @@ make_extra_tests    :=3D EXTRA_TESTS=3D1
 make_no_jevents     :=3D NO_JEVENTS=3D1
 make_jevents_all    :=3D JEVENTS_ARCH=3Dall
 make_no_bpf_skel    :=3D BUILD_BPF_SKEL=3D0
+make_bpf_skel_clang :=3D CLANG=3D$(CLANG) BPF_GCC=3D
+make_bpf_skel_bpf_gcc :=3D BPF_GCC=3D$(BPF_GCC) CLANG=3D
 make_gen_vmlinux_h  :=3D GEN_VMLINUX_H=3D1
 make_no_python_module :=3D NO_PYTHON_MODULE=3D1
 make_no_scripts     :=3D NO_PYTHON_MODULE=3D1
@@ -127,21 +131,49 @@ make_minimal        +=3D NO_LIBBPF=3D1
 make_minimal        +=3D NO_SDT=3D1 NO_JVMTI=3D1 NO_LIBZSTD=3D1
 make_minimal        +=3D NO_CAPSTONE=3D1
=20
+override FEATURE_OUTPUT :=3D $(shell mktemp -d)
+ifeq ($(FEATURE_OUTPUT),)
+$(error Failed to create temporary directory for feature checks)
+endif
+saved_OUTPUT :=3D $(OUTPUT)
+override OUTPUT :=3D $(FEATURE_OUTPUT)/
+FEATURE_DISPLAY_DEFERRED :=3D 1
+FEATURE_TESTS :=3D libelf zlib bpf libopenssl
+FEATURE_CHECK_CFLAGS-bpf =3D -I. -I$(srctree)/tools/include -I$(srctree)/t=
ools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
+include $(srctree)/tools/build/Makefile.feature
+
 # binutils 2_42 and newer have bfd_thread_init()
-new_libbfd :=3D $(shell echo '#include <bfd.h>' | $(CC) -E -x c - | grep b=
fd_thread_init)
+$(call feature_check,libbfd-threadsafe)
=20
 # Whether libLLVM can be built, which needs the llvm-devel/llvm-dev header=
s and
-# libraries of version 13 or newer, not just llvm-config. This mirrors the
-# llvm-perf feature test in tools/build/feature/test-llvm-perf.cpp so that
-# libLLVM is only asserted below when the default compiler can really buil=
d it.
+# libraries of version 13 or newer, not just llvm-config.
 ifneq ($(call has,$(LLVM_CONFIG)),)
-have_libllvm :=3D $(shell printf '#include <llvm/Support/ManagedStatic.h>\=
n#include <llvm/Support/raw_ostream.h>\n#if LLVM_VERSION_MAJOR < 13\n#error=
 "llvm-devel/llvm-dev version 13 or greater is required"\n#endif\nint main(=
){llvm::errs()<<"";llvm::llvm_shutdown();return 0;}\n' | \
-	$(CXX) -x c++ -std=3Dgnu++17 -I$(shell $(LLVM_CONFIG) --includedir 2>/dev=
/null) - -o /dev/null \
-		-L$(shell $(LLVM_CONFIG) --libdir 2>/dev/null) \
-		$(shell $(LLVM_CONFIG) --libs Core BPF 2>/dev/null) \
-		$(shell $(LLVM_CONFIG) --system-libs 2>/dev/null) >/dev/null 2>&1 && ech=
o y)
+  $(call feature_check,llvm-perf)
+endif
+
+ifeq ($(feature-libelf)$(feature-zlib)$(feature-bpf)$(feature-libopenssl),=
1111)
+  ifneq ($(call get-executable,$(CLANG)),)
+    CLANG_VERSION :=3D $(shell $(CLANG) --version | head -1 | sed 's/.*cla=
ng version \([[:digit:]]\+.[[:digit:]]\+.[[:digit:]]\+\).*/\1/g')
+    ifneq ($(call version-lt3,$(CLANG_VERSION),12.0.1),1)
+      $(call feature_check,clang-bpf-co-re)
+      ifeq ($(feature-clang-bpf-co-re),1)
+        have_clang_bpf :=3D 1
+      endif
+    endif
+  endif
+  ifneq ($(call get-executable,$(BPF_GCC)),)
+    BPF_GCC_VERSION :=3D $(shell $(BPF_GCC) -dumpfullversion 2>/dev/null)
+    ifneq ($(BPF_GCC_VERSION),)
+      ifneq ($(call version-lt3,$(BPF_GCC_VERSION),14.0.0),1)
+        have_bpf_gcc :=3D 1
+      endif
+    endif
+  endif
 endif
=20
+$(shell rm -rf -- "$(FEATURE_OUTPUT)")
+override OUTPUT :=3D $(saved_OUTPUT)
+
 # $(run) contains all available tests
 run :=3D make_pure
 # Targets 'clean all' can be run together only through top level
@@ -155,7 +187,7 @@ MAKE_F :=3D $(MAKE) -f $(MK)
 endif
 run +=3D make_python_perf_so
 run +=3D make_debug
-ifneq ($(new_libbfd),)
+ifeq ($(feature-libbfd-threadsafe),1)
 run +=3D make_nondistro
 # Demangling with libbfd is only built when the C++ ABI's __cxa_demangle
 # isn't available, so it needs a build of its own to be compiled at all.
@@ -165,7 +197,7 @@ endif
 # a C compiler and a C++ compiler that don't match.
 ifneq ($(call has,clang),)
 run +=3D make_clang
-ifneq ($(new_libbfd),)
+ifeq ($(feature-libbfd-threadsafe),1)
 run +=3D make_clang_nondistro
 endif
 endif
@@ -173,6 +205,12 @@ run +=3D make_extra_tests
 run +=3D make_no_jevents
 run +=3D make_jevents_all
 run +=3D make_no_bpf_skel
+ifeq ($(have_clang_bpf),1)
+run +=3D make_bpf_skel_clang
+endif
+ifeq ($(have_bpf_gcc),1)
+run +=3D make_bpf_skel_bpf_gcc
+endif
 run +=3D make_gen_vmlinux_h
 run +=3D make_no_python_module
 run +=3D make_no_scripts
@@ -306,13 +344,20 @@ test_make_libbpf_dynamic_O :=3D ldd $$TMP_O/perf | gr=
ep -q libbpf
 # doesn't fail the build, it just quietly turns off everything that needs =
a
 # C++ compiler. Check a feature that does, otherwise these tests would pas=
s
 # while producing a perf with less in it than the default build has.
-ifneq ($(have_libllvm),)
+ifeq ($(feature-llvm-perf),1)
 test_make_clang               :=3D test -x $(PERF_O)/perf && $(PERF_O)/per=
f check -q feature libLLVM
 test_make_clang_O             :=3D test -x $$TMP_O/perf && $$TMP_O/perf ch=
eck -q feature libLLVM
 test_make_clang_nondistro     :=3D $(test_make_clang)
 test_make_clang_nondistro_O   :=3D $(test_make_clang_O)
 endif
=20
+test_make_no_bpf_skel         :=3D test -x $(PERF_O)/perf && ($(PERF_O)/pe=
rf check -q feature bpf_skeletons; test $$? -eq 1)
+test_make_no_bpf_skel_O       :=3D test -x $$TMP_O/perf && ($$TMP_O/perf c=
heck -q feature bpf_skeletons; test $$? -eq 1)
+test_make_bpf_skel_clang      :=3D test -x $(PERF_O)/perf && $(PERF_O)/per=
f check -q feature bpf_skeletons
+test_make_bpf_skel_clang_O    :=3D test -x $$TMP_O/perf && $$TMP_O/perf ch=
eck -q feature bpf_skeletons
+test_make_bpf_skel_bpf_gcc    :=3D test -x $(PERF_O)/perf && $(PERF_O)/per=
f check -q feature bpf_skeletons
+test_make_bpf_skel_bpf_gcc_O  :=3D test -x $$TMP_O/perf && $$TMP_O/perf ch=
eck -q feature bpf_skeletons
+
 test_make_python_perf_so_O    :=3D test -f $$TMP_O/python/perf.so
 test_make_perf_o_O            :=3D test -f $$TMP_O/perf.o
 test_make_util_map_o_O        :=3D test -f $$TMP_O/util/map.o
@@ -445,7 +490,7 @@ $(FEATURES_DUMP_FILE_STATIC):
 # The clang tests exist to run feature detection with a compiler other tha=
n
 # the default one, so they have to do their own and are left out of both t=
he
 # dependency and the 'FEATURES_DUMP=3D' append below.
-no_features_dump :=3D make_clang make_clang_nondistro
+no_features_dump :=3D make_clang make_clang_nondistro make_bpf_skel_clang =
make_bpf_skel_bpf_gcc
 no_features_dump +=3D $(addsuffix _O,$(no_features_dump))
=20
 # Add feature dump dependency for run/run_O targets
--=20
2.56.0.307.g5fe7bd680c-goog

