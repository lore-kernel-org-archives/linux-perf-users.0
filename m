Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E323EC691
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539211; cv=none; b=pwiIYqtCZScAI2nMHK4+Wdshsk+68Wc0/061riu9Zk2W9ReBuyM1fYTnyq0ezwKFQUpI0OJB2tJYpPCrcTMegRY0YjkfQeO+mWuln4X8WTbqCBRetx6XaAd0nA1pxIRTAObksllWyWSpNWDB6zTA9WlXXLOY5w6reSmuZGDCuOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539211; c=relaxed/simple;
	bh=9dORH0oEqVFA847HKvzWRovoEjk2gC7h5N3Vm9y/hYo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YfAYRf00BMj2ZhIpztXZt1fXeiaYyfzl6CAdze4Y4K4wtX2EtQNaPz6/+uy6DwZATg6OV8YdjSXbs/pga7p72cyujoS0TharLJCZjN36yO0r9+o1BAsxgfl0+vol0lgU6lu3kTU62TQ5fi4RyjJ3NgNbMJ98jBJwwnk49vX7RfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kNgHdUy8; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kNgHdUy8"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-86ab8302b54so5781305b3a.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 23:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789539208; x=1790144008; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TcdV1sgmtR2CtW3eQG4Xq1/J2URo6ZShBMv2CnVeVxw=;
        b=kNgHdUy8cn44zPRy/FLBm7qgrUMJsPuq4Cwy4eC2eSvJ9vtv73Fg4vskVyOX34nN4M
         nDP27AXkCgMzrNMaUNqxDztVJAWH+haFw8v1azbW7y2pEwjEBhYOHJAKk9yewpdce6fp
         wxhiPxiNdB8xlXxnyEn4xvvpzqLw72ml6poqBckqC6afJfnaAa8wu2XHH0dVmu+HFXiZ
         RLTDSY20gZe36AaXdiU5d6stj5kTJ9dhJZ0e+vxyAmUYyUWOOcv3/Pe7WGQA/QGsKuKU
         vAIvbQvOw7vR07VwlwTaQyr3cK+W/7ee9juuK2NbPPXhG1bbdyBvvDTwpcA6PzUNkDtA
         +nlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789539208; x=1790144008;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TcdV1sgmtR2CtW3eQG4Xq1/J2URo6ZShBMv2CnVeVxw=;
        b=p3lNQ3fQBCRL0FNSGzoHHy8UdWqjzGRlp5de3VLAScK3DE1v3/U1IlgCOVX7WRMiMt
         2m6yDKHCGaw25qaqDV5tdK19jpBbzEfmX2attjFbffXgKlFo5CaCFYQ+uMmJTleWzvkx
         ks0pzakr/f64IE4syH7RFCtJR2BZmmOvmOi14D33tNwnm547hJpJk/PoZkU/yzH8zIEP
         Q8hIvlC+hFQ2s/dl8J9VrzbbQZAOKJTGQdTDy88T1Z4PA6/2hc1sVwlMmZTFmrxb8/BG
         ql8Gfk3p0nTBjmbJUccLF5r4m4aOsFs4i9uXD9LNxY3Wq88H1n2PPy/dPE2EcYuzB7aE
         7W4Q==
X-Forwarded-Encrypted: i=1; AKwUvBztoSiDCVPQYuhTvp6A2MUTc75WUyhogYFR4GMPEXUXONcPs1qNANMZ88JPez80Fl4muUPT86KBqAq8/ZDKbAxD@vger.kernel.org
X-Gm-Message-State: AFuF++nii+EvuTF25wsh7ESbo7SMyDZRiej4nUrrizI85RkplssEaSZA
	U4/OFQyTDjlVlrk+GLPBpdrGPg6pcWXHw4oPK2qb0bk6h2uinSKQIIulsjfXXBnR4rmGwhytErJ
	rWOIlU1SEHQ==
X-Received: from dyau26.prod.google.com ([2002:a05:7300:601a:b0:335:65c3:a0a9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7703:b0:3cc:917f:f302
 with SMTP id adf61e73a8af0-3dd5f455cd6mr3886426637.9.1789539208331; Tue, 15
 Sep 2026 23:13:28 -0700 (PDT)
Date: Tue, 15 Sep 2026 23:12:18 -0700
In-Reply-To: <20260916061218.3061216-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916061218.3061216-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916061218.3061216-10-irogers@google.com>
Subject: [PATCH 9/9] perf test: Add build tests for clang and libbfd demangling
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Three build configurations broke recently without the build test suite
noticing, as none of them were covered:

  - "CC=3Dclang" on its own. CXX is only set to clang++ by "make LLVM=3D1",
    so CXX stays as g++ and used to be passed clang's flags.
  - "CC=3Dclang BUILD_NONDISTRO=3D1", where libbfd.c failed clang's
    -Wthread-safety analysis.
  - "BUILD_NONDISTRO=3D1 NO_DEMANGLE=3D1", the only combination that
    compiles the libbfd demangling in symbol.c, which referred to
    identifiers nothing declared.

Add the three. The clang ones need clang installed, and the libbfd ones
reuse the existing binutils check.

Testing that perf was built isn't enough for the first one. Feature
tests are allowed to fail, so a broken C++ compiler command line doesn't
fail the build, it silently turns off every feature needing a C++
compiler and the build still produces a working perf. Check that libLLVM
is still built in, which is the C++ dependent feature perf can report
on, so the test fails instead of quietly producing a perf with less in
it than the default build has.

Only make that check when libLLVM can be built in the first place. The
llvm-perf feature test compiles and links against the llvm-devel/llvm-dev
headers and libraries and needs version 13 or newer, so the presence of
llvm-config on its own says nothing. Probe the same way the feature test
does and fall back to only testing that perf was built when the probe
fails, rather than turning a machine without the LLVM development files
into a spurious failure.

For the same reason the clang tests must not reuse a feature dump made
with the default compiler, so exclude them from REUSE_FEATURES_DUMP.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/tests/make | 47 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 608470ff9c10..8e55ff1aecbd 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -71,6 +71,9 @@ make_clean_all      :=3D clean all
 make_python_perf_so :=3D $(python_perf_so)
 make_debug          :=3D DEBUG=3D1
 make_nondistro      :=3D BUILD_NONDISTRO=3D1
+make_nondistro_no_demangle :=3D BUILD_NONDISTRO=3D1 NO_DEMANGLE=3D1
+make_clang          :=3D CC=3Dclang
+make_clang_nondistro :=3D CC=3Dclang BUILD_NONDISTRO=3D1
 make_extra_tests    :=3D EXTRA_TESTS=3D1
 make_no_jevents     :=3D NO_JEVENTS=3D1
 make_jevents_all    :=3D JEVENTS_ARCH=3Dall
@@ -128,6 +131,18 @@ make_minimal        +=3D NO_CAPSTONE=3D1
 # binutils 2_42 and newer have bfd_thread_init()
 new_libbfd :=3D $(shell echo '#include <bfd.h>' | $(CC) -E -x c - | grep b=
fd_thread_init)
=20
+# Whether libLLVM can be built, which needs the llvm-devel/llvm-dev header=
s and
+# libraries of version 13 or newer, not just llvm-config. This mirrors the
+# llvm-perf feature test in tools/build/feature/test-llvm-perf.cpp so that
+# libLLVM is only asserted below when the default compiler can really buil=
d it.
+ifneq ($(call has,$(LLVM_CONFIG)),)
+have_libllvm :=3D $(shell printf '#include <llvm/Support/ManagedStatic.h>\=
n#include <llvm/Support/raw_ostream.h>\n#if LLVM_VERSION_MAJOR < 13\n#error=
 "llvm-devel/llvm-dev version 13 or greater is required"\n#endif\nint main(=
){llvm::errs()<<"";llvm::llvm_shutdown();return 0;}\n' | \
+	$(CXX) -x c++ -std=3Dgnu++17 -I$(shell $(LLVM_CONFIG) --includedir 2>/dev=
/null) - -o /dev/null \
+		-L$(shell $(LLVM_CONFIG) --libdir 2>/dev/null) \
+		$(shell $(LLVM_CONFIG) --libs Core BPF 2>/dev/null) \
+		$(shell $(LLVM_CONFIG) --system-libs 2>/dev/null) >/dev/null 2>&1 && ech=
o y)
+endif
+
 # $(run) contains all available tests
 run :=3D make_pure
 # Targets 'clean all' can be run together only through top level
@@ -143,6 +158,17 @@ run +=3D make_python_perf_so
 run +=3D make_debug
 ifneq ($(new_libbfd),)
 run +=3D make_nondistro
+# Demangling with libbfd is only built when the C++ ABI's __cxa_demangle
+# isn't available, so it needs a build of its own to be compiled at all.
+run +=3D make_nondistro_no_demangle
+endif
+# CXX is only set to clang++ by LLVM=3D1, so a CC=3Dclang build has to cop=
e with
+# a C compiler and a C++ compiler that don't match.
+ifneq ($(call has,clang),)
+run +=3D make_clang
+ifneq ($(new_libbfd),)
+run +=3D make_clang_nondistro
+endif
 endif
 run +=3D make_extra_tests
 run +=3D make_no_jevents
@@ -278,6 +304,17 @@ test_make_install_pdf_O  :=3D $(test_ok)
 test_make_libbpf_dynamic :=3D   ldd $(PERF_O)/perf | grep -q libbpf
 test_make_libbpf_dynamic_O :=3D ldd $$TMP_O/perf | grep -q libbpf
=20
+# Feature tests are allowed to fail, so a broken C++ compiler command line
+# doesn't fail the build, it just quietly turns off everything that needs =
a
+# C++ compiler. Check a feature that does, otherwise these tests would pas=
s
+# while producing a perf with less in it than the default build has.
+ifneq ($(have_libllvm),)
+test_make_clang               :=3D test -x $(PERF_O)/perf && $(PERF_O)/per=
f check -q feature libLLVM
+test_make_clang_O             :=3D test -x $$TMP_O/perf && $$TMP_O/perf ch=
eck -q feature libLLVM
+test_make_clang_nondistro     :=3D $(test_make_clang)
+test_make_clang_nondistro_O   :=3D $(test_make_clang_O)
+endif
+
 test_make_python_perf_so_O    :=3D test -f $$TMP_O/python/perf.so
 test_make_perf_o_O            :=3D test -f $$TMP_O/perf.o
 test_make_util_map_o_O        :=3D test -f $$TMP_O/util/map.o
@@ -407,8 +444,14 @@ $(FEATURES_DUMP_FILE_STATIC):
 	echo "- $@: $$cmd" && echo $$cmd && \
 	( eval $$cmd ) > /dev/null 2>&1
=20
+# The clang tests exist to run feature detection with a compiler other tha=
n
+# the default one, so they have to do their own and are left out of both t=
he
+# dependency and the 'FEATURES_DUMP=3D' append below.
+no_features_dump :=3D make_clang make_clang_nondistro
+no_features_dump +=3D $(addsuffix _O,$(no_features_dump))
+
 # Add feature dump dependency for run/run_O targets
-$(foreach t,$(run) $(run_O),$(eval \
+$(foreach t,$(filter-out $(no_features_dump),$(run) $(run_O)),$(eval \
 	$(t): $(if $(findstring make_static,$(t)),\
 		$(FEATURES_DUMP_FILE_STATIC),\
 		$(FEATURES_DUMP_FILE))))
@@ -416,7 +459,7 @@ $(foreach t,$(run) $(run_O),$(eval \
 # Append 'FEATURES_DUMP=3D' option to all test cases. For example:
 # make_no_libbpf: NO_LIBBPF=3D1  --> NO_LIBBPF=3D1 FEATURES_DUMP=3D/a/b/BU=
ILD_TEST_FEATURE_DUMP
 # make_static: LDFLAGS=3D-static --> LDFLAGS=3D-static FEATURES_DUMP=3D/a/=
b/BUILD_TEST_FEATURE_DUMP_STATIC
-$(foreach t,$(run),$(if $(findstring make_static,$(t)),\
+$(foreach t,$(filter-out $(no_features_dump),$(run)),$(if $(findstring mak=
e_static,$(t)),\
 			$(eval $(t) :=3D $($(t)) FEATURES_DUMP=3D$(FEATURES_DUMP_FILE_STATIC)),=
\
 			$(eval $(t) :=3D $($(t)) FEATURES_DUMP=3D$(FEATURES_DUMP_FILE))))
 endif
--=20
2.55.0.1032.g73a4cd73de-goog

