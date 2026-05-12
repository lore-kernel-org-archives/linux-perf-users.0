Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011CF3CB2D9
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 05:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564179; cv=none; b=R7ETztqUcA6QEtCR3h0oV/PvBD/RvR7tAQ/eJoyGX3r7tJLygIkBOlk9lCWaj54FGdN/a7T4OE+0cqzxGGLKuvpbgXWGm9BOHtVhko1pJ+4KsGYBLAa8WvxjSI13LnMZ/ZNsh7v9VSRtDMnPDhLwvkzHSWCTAEH7AQAFqV4Rhtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564179; c=relaxed/simple;
	bh=eSR/2YHL7yHY1u1oa1YvO1Hm3QqYx8d5R5pe2mgYJgo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sYEw3jTS9N3Xp8I+c9HmsrNk8JbYwggX4MGx/wzX1DYcmY3hev5rDgaxrDHS0ErMYOb0ek8dXLTHRWJRzK1CWSqQgyGf0CVGIhniqsaKow80H0fs7GSTIJ8+eIbwfWrcDlDE3cg1blS3b85eOBojah4P4SqKKXlDtk/7T01t8iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S6uguPlD; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S6uguPlD"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so8258886eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 22:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778564172; x=1779168972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2I1HGOzLBMWUVYaBYmdtAHomd8EmMW7DSi+krXpfS4=;
        b=S6uguPlDR3BDHRB6xsbyb+gyEFqAV/b9ExvvujKhDKWMRIhENp3QXuzayJlV22DBPp
         I9TqnKFKW27WLEAcuE/hMjJoeKA8c05b9N6O0Q50f+S0arCp9q+eIc1fSjlvNIPncPD9
         +LxilwMdEbVJtN4CihacDnGOYfRfvfhedQqPseC1Eb6K+xHdvN2LxIKUS4cViN0d/3AI
         mTtmdRaWilrgpeV+Ot3cxYkiHO2QzYt9++4TnXYiH3lKSAcUnZC9QK34leX+DD7+nlZH
         1gJJK+l7HSIMEaM09FaHJ0VIU5nzwGdAKbtFwtMc3pGIfPbbB6QJiJUOynZpUQ8D2plT
         HlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778564172; x=1779168972;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J2I1HGOzLBMWUVYaBYmdtAHomd8EmMW7DSi+krXpfS4=;
        b=Kzgzkq6IABl8bHMlaeCl4lVszSX2/UQGW1CdZ5sclOkRyf1e8EKxvzaZgcSySMh1f9
         AUkN3e/vBltReEJxJjncUBAog16AQl0jPQRno7h3bNSoJILBC9CiZJRZWc2QexP9RBry
         ApLBW5Iz3CYUKwHWdqZ8+5nc7JsqALCram+dEnFY8BKieAssFiTSkaApTaYd6X5EZO8F
         UZyH1U4YqL9o/bDZFQG0MpKr8ev9WV3G9RQfK7blbaord4NnaJiW8hUAA69hVAIfv2BZ
         Mc7yQiFAiRY9a7dmFKJAI3AH+LtwGmBMT5fL3NScMqQw72HGKzUA+RG0VTsg+C9xoFdT
         GFjA==
X-Forwarded-Encrypted: i=1; AFNElJ9LiY6qLuFir4dZ6jUgpPSxrz2K/iqfWB9hsbY+tffAwUVux3SPrhGuibr6psvirlOo0lLZj+opPdc5o1W7F8pK@vger.kernel.org
X-Gm-Message-State: AOJu0YxyIKVbM5bXMx/jSdFi/8wTYSvIgsEkpNB6T2rP7bjYLUJ//8yV
	McrQKpGEVgTsyvYi7iT5KvTuRvaVFBhWamJBChzqGtOcHlRWKYifggMSSwnelGdoKIFXkV8dKSb
	u/j4ceG29rw==
X-Received: from dybgn2.prod.google.com ([2002:a05:7301:2502:b0:2f9:af7:5043])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:df4b:b0:2d2:129a:1694
 with SMTP id 5a478bee46e88-2f54d79b993mr13180256eec.18.1778564171470; Mon, 11
 May 2026 22:36:11 -0700 (PDT)
Date: Mon, 11 May 2026 22:35:36 -0700
In-Reply-To: <20260512053539.3410189-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512053539.3410189-12-irogers@google.com>
Subject: [PATCH v1 11/14] tools build: Integrate libdebuginfod into test-all
 fast path
From: Ian Rogers <irogers@google.com>
To: Quentin Monnet <qmo@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, 
	Nathan Chancellor <nathan@kernel.org>, Tomas Glozar <tglozar@redhat.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Leo Yan <leo.yan@arm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	Markus Mayer <mmayer@broadcom.com>, Collin Funk <collin.funk1@gmail.com>, 
	Howard Chu <howardchu95@gmail.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Bundling libdebuginfod into test-all.c allows Make to avoid an individual
feature check sub-make fork during AST parsing. Short-circuit feature_check
in Makefile.feature to instantly skip sub-make evaluations when a feature
was already pre-detected by test-all.

Trade-offs:
On some Linux distributions (e.g., Debian/Ubuntu), libdebuginfod-dev is
packaged separately from libelf-dev and libdw-dev. If a user installs
libdw-dev but omits libdebuginfod-dev, adding -ldebuginfod to BUILD_ALL
causes test-all to fail, falling back to individual feature tests. However,
on fully configured developer workstations, this successfully reclaims
sequential startup latency.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature   | 6 ++++--
 tools/build/feature/Makefile   | 2 +-
 tools/build/feature/test-all.c | 5 +++++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 2f192d3bf61b..d8febe5d5800 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -8,7 +8,9 @@ endif
=20
 feature_check =3D $(eval $(feature_check_code))
 define feature_check_code
-  feature-$(1) :=3D $(shell $(MAKE) OUTPUT=3D$(OUTPUT_FEATURES) CC=3D"$(CC=
)" CXX=3D"$(CXX)" CFLAGS=3D"$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))" C=
XXFLAGS=3D"$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS=3D"$(L=
DFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir) $(OUTPUT_FEATURES)=
test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
+  ifeq ($(feature-$(1)),)
+    feature-$(1) :=3D $(shell $(MAKE) OUTPUT=3D$(OUTPUT_FEATURES) CC=3D"$(=
CC)" CXX=3D"$(CXX)" CFLAGS=3D"$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))"=
 CXXFLAGS=3D"$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS=3D"$=
(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir) $(OUTPUT_FEATURE=
S)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
+  endif
 endef
=20
 feature_set =3D $(eval $(feature_set_code))
@@ -100,6 +102,7 @@ FEATURE_TESTS_BASIC :=3D                  \
         disassembler-four-args		\
         disassembler-init-styled	\
         file-handle			\
+        libdebuginfod			\
         libopenssl
=20
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
@@ -125,7 +128,6 @@ FEATURE_TESTS_EXTRA :=3D                  \
          clang                          \
          libbpf                         \
          libpfm4                        \
-         libdebuginfod			\
          clang-bpf-co-re		\
          bpftool-skeletons
=20
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 704c687ed3ad..dc828523b50a 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -115,7 +115,7 @@ __BUILD =3D $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(p=
atsubst %.bin,%.c,$(@F)) $(
   BUILD_BFD =3D $(BUILD) -DPACKAGE=3D'"perf"' -lbfd -ldl
   BUILD_ALL =3D $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=3D2 -=
ldw -lelf -lnuma -lelf -lslang \
 	      $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -ldl -lz -llzma -lzstd \
-	      $(shell $(PKG_CONFIG) --libs --cflags openssl 2>/dev/null)
+	      $(shell $(PKG_CONFIG) --libs --cflags openssl 2>/dev/null) -ldebugi=
nfod
=20
 __BUILDXX =3D $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,=
%.cpp,$(@F)) $(LDFLAGS)
   BUILDXX =3D $(__BUILDXX) > $(@:.bin=3D.make.output) 2>&1
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.=
c
index 1488bf6e6078..b6984236859f 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -146,6 +146,10 @@
 # include "test-libopenssl.c"
 #undef main
=20
+#define main main_test_libdebuginfod
+# include "test-libdebuginfod.c"
+#undef main
+
 int main(int argc, char *argv[])
 {
 	main_test_libpython();
@@ -178,6 +182,7 @@ int main(int argc, char *argv[])
 	main_test_libzstd();
 	main_test_libtraceevent();
 	main_test_libopenssl();
+	main_test_libdebuginfod();
=20
 	return 0;
 }
--=20
2.54.0.563.g4f69b47b94-goog

