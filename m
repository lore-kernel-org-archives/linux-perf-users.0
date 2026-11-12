Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446131;
	b=dVCS6qRDELCf8Kou5MHmnsBtOWSJGk5TWvhaSkBXtZKmT72wtEH2+rFvu7SlaS0BCKf2
	 TXrK98gwiP2PdRjFz5+sr5byr/bbSMOpWAsaOJsZAHJETAhOETYjVx+9Sk4mg9NNed/fY
	 iSJcTwFTrPheUBdVBMxsGAgwRnWH38Heq31yKTAJhXeguPuXl5bKC7yMCiLF0Qqn3Jcnv
	 p4XRfTjKwxzs7fDfVOn4RM44i94qU5dNo9VhBhJvXCP8EC0asFxKExtSY3jgl6JlX/Uvn
	 xT8WpudfLYtZIhvUTOD5Va8DxnQWYbBLxmJChGLr1bhUOyCtlokCG3lehtg04ESl7yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446131;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=LrRknaVYbPaxzhmnJjUbIyT0B1cZr9C8gaGVGD3nWJU=;
	b=wnesNNwNWkySyTfD+Q0/01WpvHfI66S+yo2FJyBILiW2JuRXmONWzNxNAbKwYa/2CjDT
	 QBFnbrxvHibsTASaKnekPPAN/gznNvZRAo5/lnhls0omfue1KBfkJTl2kK6Sg+JiAiRFC
	 ebQPZg8ngtexB9JgVvrcwqxN4gh/JZIWTMmJiAgV9YxB4lEz0mF33Fvi2MzgkY1HlF+uH
	 PaThSq7Z+11+VXmJy4cWHkGBrTpgbLSyyyAGX8nCildKwpJsHf88G+IOlOYUaAsJM5bFk
	 6Zg+4LDe39T/epjpW4wIDoLzNJMrChNTFCX6EGJ0kVWaKEdw+MGw6LJQep4s3PFF3yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=itLw3BhB;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AFA606A8AA
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 01:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44AFA606A8AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=itLw3BhB
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bcb065bfdso6054827eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 17:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794446130; x=1795050930; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LrRknaVYbPaxzhmnJjUbIyT0B1cZr9C8gaGVGD3nWJU=;
        b=itLw3BhB8puFABnIH/Xb84EDMxTBaKjlqAycjAe8b/w1/sjwCSiqwKJz54fKO/lrTU
         BQu8mWRpC1ypWU+yUZzIUOTyROj+K3CfKI9vPc2IPFmXtr+//eTvkei4wx0Eh+mSEcoK
         x3Kkr3zbkJgCxu0yLq0wShSAco/vyZws4HB94rZPeLakZiaT8rk7PYOUdd3ze2FvKfiz
         f/VDDkbwd2b6fntvYkLBIqrwX5VkhwyDsTz2FZtb67soJD859rT53OscLTFRiE7/ifmK
         CoSwqx45dLG8va4Z3MxcK3QuGAAPOBtoNPSpQjpDHRV+N3ikdm8grXsOOOUdvqaSYqLd
         QJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794446130; x=1795050930;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LrRknaVYbPaxzhmnJjUbIyT0B1cZr9C8gaGVGD3nWJU=;
        b=RjhduYYavjjV83EpKFqJIiWKTOXq2ZBQXkJ9wZmWXKTg7TMuus5e00WGY2zPpAkvVX
         W8SDm1T7sWqXymURirLGLiDRxNx5CRnJjHoejr37+DRAhGV+v5SyJx0kgW3PgDfwhXG9
         kMTkml1w+ldSCN9APCndHJORyHXPglW4wKHWgHb7R7wzhus6yE+tSD0+fcVtLVrJryk4
         okTBYjVbPkb7hR9M2CcTZETc41aLUh2JDpNba3HmPmzNxhV36No3POo16jYb6+khoOm0
         qfFnwCL2BomY5yNkuDOLWn0UYXc4Rd8FYIMFVn+Od7GvqC1Kl1q+fX9xEaNfyQS202f+
         k42g==
X-Forwarded-Encrypted: i=1; AL+hErFqKkgyyEBrZZ2QGEP4IhB8XWPSuTtqTStL21b0GgS0zo1ET703xCJmeWQh61aEOXzn/MZwTBNSYyxmj6h3Mw0c@vger.kernel.org
X-Gm-Message-State: APuU4Z8r9aQvldJ+1B37q2eIC4N4bDsNHdLsjeUH/wGYDBPlru4r4jet
	TF4GLWF5/8jdrWFwa0z+yMx5hpSa7RqfA4sJSeKEtbHfQE7KPNIzecT/PlvaSqQR67fqjVQdwXV
	oQ1CER/rV4w==
X-Received: from dyrp7.prod.google.com ([2002:a05:693c:69c7:b0:369:a832:e377])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4208:b0:36a:5126:a8aa
 with SMTP id 5a478bee46e88-37686180350mr4477826eec.27.1794446129939; Wed, 11
 Nov 2026 17:15:29 -0800 (PST)
Date: Wed, 11 Nov 2026 17:15:13 -0800
In-Reply-To: <20261112011514.4032822-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022204627.1813821-1-irogers@google.com> <20261112011514.4032822-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112011514.4032822-5-irogers@google.com>
Subject: [PATCH v4 4/5] perf test make: Reuse Makefile.feature for libbfd and
 llvm probes
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, andrii@kernel.org, cupertino.miranda@oracle.com, 
	eddyz87@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	jose.marchesi@oracle.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Include tools/build/Makefile.feature in tools/perf/tests/make (using a
temporary OUTPUT directory that is removed immediately after probing)
and replace the open-coded new_libbfd and have_libllvm compiler
invocations with the existing libbfd-threadsafe and llvm-perf feature
checks.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/make | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 7524de522802..805d1074cfa8 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -127,19 +127,31 @@ make_minimal        +=3D NO_LIBBPF=3D1
 make_minimal        +=3D NO_SDT=3D1 NO_JVMTI=3D1 NO_LIBZSTD=3D1
 make_minimal        +=3D NO_CAPSTONE=3D1
=20
+override FEATURE_OUTPUT :=3D $(shell mktemp -d)
+ifeq ($(FEATURE_OUTPUT),)
+$(error Failed to create temporary directory for feature checks)
+endif
+saved_OUTPUT_origin :=3D $(origin OUTPUT)
+saved_OUTPUT :=3D $(OUTPUT)
+override OUTPUT :=3D $(FEATURE_OUTPUT)/
+FEATURE_DISPLAY_DEFERRED :=3D 1
+FEATURE_TESTS :=3D
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
+$(shell rm -rf -- "$(FEATURE_OUTPUT)")
+ifeq ($(saved_OUTPUT_origin),undefined)
+override undefine OUTPUT
+else
+override OUTPUT :=3D $(saved_OUTPUT)
 endif
=20
 # $(run) contains all available tests
@@ -155,7 +167,7 @@ MAKE_F :=3D $(MAKE) -f $(MK)
 endif
 run +=3D make_python_perf_so
 run +=3D make_debug
-ifneq ($(new_libbfd),)
+ifeq ($(feature-libbfd-threadsafe),1)
 run +=3D make_nondistro
 # Demangling with libbfd is only built when the C++ ABI's __cxa_demangle
 # isn't available, so it needs a build of its own to be compiled at all.
@@ -165,7 +177,7 @@ endif
 # a C compiler and a C++ compiler that don't match.
 ifneq ($(call has,clang),)
 run +=3D make_clang
-ifneq ($(new_libbfd),)
+ifeq ($(feature-libbfd-threadsafe),1)
 run +=3D make_clang_nondistro
 endif
 endif
@@ -306,7 +318,7 @@ test_make_libbpf_dynamic_O :=3D ldd $$TMP_O/perf | grep=
 -q libbpf
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
--=20
2.56.0.567.gdb80ae8cd5-goog

