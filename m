Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793766622;
	b=eeCk9bplDPmqVw/Q96dJqSq/4P4aTHGgkzkpJrd6duJ/+PTINgK8YLni/zS1bqdpNtUI
	 g4sp7X7fxGm2BVn9uyFU4u4pFCbPZPnkoI0gyptnFHwei/wJo767EfXcPCPCZwxPmUc7e
	 X+U7hsheZ4MOtJCspZX4t2FeVAYfrcmRP6trXDlMuC3EsRD8a6sjxST5EHjNla0pfs9aT
	 CIIMUYOtF0qHlCBtOLdIaZKr6D7Qvd9WNP+iCiqSYUFLTDfq4gfMWkJDycZB+zwjJwjul
	 Esxju6UuswzE+HbAK/d40MC7V48UX4itCmBpr+JUmgeMYkwWOv8UesgTfEPbxil973A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793766622;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=M5ouklrHE4cf5TDEAMF9SCkJTPVvWGYITZBVBfks0c0=;
	b=dEQhgpURd7+NsCr6F7VIfhKa1dZISEXv6BQEMu0Wyy2zmAgXNrYXxqmMaehicYjgbZSV
	 hlVlGFHR5BX5ATfYarpden0Ve7rfc5YaKZnkeaiX9W2iNQq69KSEFyDmP710CxN3bWeA/
	 EKA4cdYn329da3Rxpu+48DYm0TmEbm7elhtg9SVZqMFID0E2UXeilU/QuKEOGqL2eHw+V
	 +NcEdvaQHunYF3sKQQF5obcSXK08+fyKFjWE85IKSLRW8yRqsWjmGuvQkOuwYLt6ifBO2
	 d9Cxi+VD4zk9MIb5twgQvr2s4rjbDDIJnDSahCI2erdGrv+AEl0jXIVd1kOlHgDsrQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=czilwe2O;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE36606A326
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 04:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFE36606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=czilwe2O
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1af203073e0so605462c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 20:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793766621; x=1794371421; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M5ouklrHE4cf5TDEAMF9SCkJTPVvWGYITZBVBfks0c0=;
        b=czilwe2Odw0EpbtqJ70KyBch5voX2iTsy+BMWaReFKuQgizgGG2bviH9enO9I6b9/f
         GFFUc654HhEkI8r5+LZ32DmnV3OrFgZxzKeQB1weYfmjEY8Z+ZkozCC/ZkvCGt9zrILY
         R8W+R8hwz8YA0xw/7OZObDs72UQi/Q3Ieh8fU30l9+LNJACXudz7pHXSybvBubMt/uGd
         1qbge9uLm72l0xRzhvu0pNVhPzxyYbpx7oh1zE4rp+eYXupVJUuOFagrR4Ny+fWe1vRV
         x9ZZ2tEsaGHhCVmIus/G+mUxIL/vpx56/usCbwK8XenwjAmgInYWStRHgBh89T2T5Qs4
         PoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793766621; x=1794371421;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M5ouklrHE4cf5TDEAMF9SCkJTPVvWGYITZBVBfks0c0=;
        b=LyliC9XcfT3XF1NdMGFKw4HDikKCc4OFTmqzh+GRQ6DWLFuRR0sDIHf4a1LQ4K+BKh
         kfBs+U/JV+hGvGJu8E0XfLdFy6uBGXE7XLCrjHcFyyaunFMrX/iqJ5I7e2nooZovmlZJ
         z146xU3JGKIhHTSnmSeMHVVipfb+G3fTscR685ka98JMKk+lU3ZGtFllAoMNqkNeKivx
         JSlSSfa4//1IpSmhzrrEAcKlMTqqFNhC0lyEc+bavGgcccW5JDYMNA1lMTuiMhhOn9VK
         sojSh35x5ae962zJRWgDwWjb2eY0cBwVdsJk5TaBWeOC+WR6s2dz/agEbSc02/Pij1W4
         l0Aw==
X-Forwarded-Encrypted: i=1; AKwUvBzynzUzEUqhp1jMJchTnNBkNqJEgB1xsG0ewY/YpYCvo8rsgAlEqZOai1k6qtMD46DGMJWzQLiiLMiImrS6sHil@vger.kernel.org
X-Gm-Message-State: APuU4Z/pvQTUDsE2242COP8uHA821Ma6L9sfweuiyDXT4z0P9fXb0Ohu
	uUxjJ9jbUGwth+K3otoc6/cclZKPzAuoGaS1aEDRF8qyES1jIR90zDSE7eMKKLztwKsaW97bSGk
	q3ZpsWssQ3g==
X-Received: from dlbsi11.prod.google.com ([2002:a05:7022:b88b:b0:1b1:f02b:2321])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea57:b0:196:c1ca:3489
 with SMTP id a92af1059eb24-1ac50799c22mr20080907c88.0.1793766620259; Tue, 03
 Nov 2026 20:30:20 -0800 (PST)
Date: Tue,  3 Nov 2026 20:30:03 -0800
In-Reply-To: <20261104043006.1199857-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104043006.1199857-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261104043006.1199857-2-irogers@google.com>
Subject: [PATCH v3 1/4] tools build: Add explicitly sequenced -lzstd to libbfd
 feature fallback
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Quentin Monnet <qmo@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, James Clark <james.clark@linaro.org>, 
	Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Distributions like Fedora ship a statically compiled binutils libbfd
that depends on zstd (along with libiberty and zlib) to decompress
sections (e.g. undefined reference to 'ZSTD_decompress').

Commit 89d001d48ec7 ("tools build: Add zstd to the binutils library
feature tests") added '|| $(BUILD_BFD) -lzstd' directly to
test-libbfd.bin, test-libbfd-threadsafe.bin, and
test-disassembler-four-args.bin. However, static libbfd requires
'-liberty -lz -lzstd' together, and setting feature-libbfd=1 when extra
libraries are needed causes callers (perf, bpftool) to link only '-lbfd
-lopcodes' without '-lzstd'.

Restore test-libbfd.bin to test only $(BUILD_BFD), add the
test-libbfd-liberty-z-zstd.bin feature test and
FEATURE_GROUP_MEMBERS-libbfd entry, and append the '-liberty -lz -lzstd'
fallback to test-libbfd-threadsafe.bin, test-disassembler-four-args.bin,
and test-disassembler-init-styled.bin.

Fixes: 89d001d48ec7 ("tools build: Add zstd to the binutils library feature tests")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature |  3 ++-
 tools/build/feature/Makefile | 19 +++++++++++++------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 4d37d11f674c..c010049d9720 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -121,6 +121,7 @@ FEATURE_TESTS_EXTRA :=                  \
          libcheck                       \
          libbfd-liberty                 \
          libbfd-liberty-z               \
+         libbfd-liberty-z-zstd          \
          libopencsd                     \
          llvm                           \
          libbpf                         \
@@ -160,7 +161,7 @@ FEATURE_DISPLAY ?=              \
 # Declare group members of a feature to display the logical OR of the detection
 # result instead of each member result.
 #
-FEATURE_GROUP_MEMBERS-libbfd = libbfd-liberty libbfd-liberty-z
+FEATURE_GROUP_MEMBERS-libbfd = libbfd-liberty libbfd-liberty-z libbfd-liberty-z-zstd
 
 #
 # Declare list of feature dependency packages that provide pkg-config files.
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 10340a537224..359da8b98bc5 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -20,6 +20,7 @@ FILES=                                          \
          test-reallocarray.bin			\
          test-libbfd-liberty.bin                \
          test-libbfd-liberty-z.bin              \
+         test-libbfd-liberty-z-zstd.bin         \
          test-cplus-demangle.bin                \
          test-cxa-demangle.bin                  \
          test-libcap.bin			\
@@ -249,18 +250,21 @@ $(OUTPUT)test-python-module.bin:
 	$(BUILD) $(FLAGS_PYTHON_EMBED)
 
 $(OUTPUT)test-libbfd.bin:
-	$(BUILD_BFD) || $(BUILD_BFD) -lzstd
+	$(BUILD_BFD)
 
 $(OUTPUT)test-libbfd-threadsafe.bin:
-	$(BUILD_BFD) || $(BUILD_BFD) -lzstd || $(BUILD_BFD) -liberty || $(BUILD_BFD) -liberty -lz
+	$(BUILD_BFD) || $(BUILD_BFD) -liberty || $(BUILD_BFD) -liberty -lz || \
+	$(BUILD_BFD) -liberty -lz -lzstd
 
 $(OUTPUT)test-disassembler-four-args.bin:
-	$(BUILD_BFD) -lopcodes || $(BUILD_BFD) -lopcodes -lzstd || $(BUILD_BFD) -lopcodes -liberty || \
-	$(BUILD_BFD) -lopcodes -liberty -lz
+	$(BUILD_BFD) -lopcodes || $(BUILD_BFD) -lopcodes -liberty || \
+	$(BUILD_BFD) -lopcodes -liberty -lz || \
+	$(BUILD_BFD) -lopcodes -liberty -lz -lzstd
 
 $(OUTPUT)test-disassembler-init-styled.bin:
-	$(BUILD_BFD) -lopcodes ||  $(BUILD_BFD) -lopcodes -liberty || \
-	$(BUILD_BFD) -lopcodes -liberty -lz
+	$(BUILD_BFD) -lopcodes || $(BUILD_BFD) -lopcodes -liberty || \
+	$(BUILD_BFD) -lopcodes -liberty -lz || \
+	$(BUILD_BFD) -lopcodes -liberty -lz -lzstd
 
 $(OUTPUT)test-reallocarray.bin:
 	$(BUILD)
@@ -271,6 +275,9 @@ $(OUTPUT)test-libbfd-liberty.bin:
 $(OUTPUT)test-libbfd-liberty-z.bin:
 	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty -lz
 
+$(OUTPUT)test-libbfd-liberty-z-zstd.bin:
+	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty -lz -lzstd
+
 $(OUTPUT)test-cplus-demangle.bin:
 	$(BUILD) -liberty
 
-- 
2.56.0.385.gac671c819a-goog

