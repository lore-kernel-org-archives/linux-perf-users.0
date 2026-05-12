Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AD84C77AA
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 17:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608017; cv=none; b=b3S5wMcKO0veof2Rfe4mc4M5/77fWfXPZZprLUrJiFyVvjjXpIc8eL5Tqq5gIueL+pVgCflwd25oOQAzVIwkVOd1xyGMa30OmglHw7IjExnzjmAoTgjrGsFZtTNzEggi5tCg9vu4DlXRYiNeZF81bQ3SovVLhGLmt4v3U4RWLx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608017; c=relaxed/simple;
	bh=+nYwJiA0bJhsQqP8J103mMLWgw1LSQxAQSclczxtcVI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XyjDe5gRh52kgTXvgAW9GZ6TuUkHTToVPZ0fNxbpyoHo4e3HWH7jQNbUf/O73Px48P/4Cilq2rtQ6C15mPT8PzcyQATFAecvFSQ08SehME0U5XUW5L4AdSRDmfPDPO2Lu9IyL5e6txztQNL5KUGQ1Vh7rX4PtT1DwvOPHLRJWSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M/sq6PXA; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M/sq6PXA"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso4692681eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 10:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778608015; x=1779212815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48Gda8O0cS2ktC9kVwU4XlytikI6HiStHpxBe0cBwCQ=;
        b=M/sq6PXAGAr388AEV3OXdYhA2MGXd1ddCqYmYeqrGHtwSvr4eq3mif/77BFpkv9j6q
         1NF7on9CxHaKb/FjSPtmAqIyk7LdwLTZMZ6lc/qk07u/qRL9IbPhu3brSXVOwkQ36f/z
         2oF1Bmu4BHoilWakMP85YJRB2B/dkXyIt67KtkaSX7a7c3R6Idd0TyGUqIH33sw86RnW
         kVXpydH+HHx4/hlgh2z8AZESzenFHkvA781SCuv8Cq4HpNpjajUxdppLJufmb1HBkZLo
         M9Nb0fHBNpq85VhZRGUit4PyK+xknHV5GUvc2bvJ7oHha1gBftjVvQBiFTlMB5F1P39L
         T32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608015; x=1779212815;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=48Gda8O0cS2ktC9kVwU4XlytikI6HiStHpxBe0cBwCQ=;
        b=tDET4YGlYw/zulJS+so6ngHGmGl+JoUHAXkKpe0pWTu9JmLjK3afkkA/4AMDE4kTPK
         idQ3UyeoI7cU4DJBZEIb3x6xgsXzaueQhIN1u3j1EcfPy3gIseckQ34EwCfJaunh3j9s
         SQI50tqucogj3seEWY8WfwoW/DFoYvMI3b5MR2vNhXeklvS7qAAqBJWQxXWbvOp4e+1B
         4/6Az4q8Iy/lo83XHNm+U3GMqfgyJV+L3VVzMfYJZ6w3ym7oZJHb9/KGHcEubhkVuF5Z
         3i9/PfN8lXVVkmwwyBCBmiApuqDnn23GYld3TBjDMMvChgji8Rxjijpna3T2Gr/UFov2
         DP7w==
X-Forwarded-Encrypted: i=1; AFNElJ/mnCex59OFHhVgbh636I7fWe7RJ4ZhgSmtWdUHdMRnHtX5Ald+I1pln3BwXTm24hiRedaTLH09LAcMMapm5PWG@vger.kernel.org
X-Gm-Message-State: AOJu0YyMO8fmzN7HRQFi0ZzuR7F5M0BHOMc8b2UDIySYcUAEpxA3+5j3
	AFz1uha2Ync+RoQC18gTXFYi+EgBkuqLgQEJ2JwwTt3FH+lLh702b5wARP9qR+PcPMf0useC/qq
	tagFCZxDYvg==
X-Received: from dyz23.prod.google.com ([2002:a05:693c:4097:b0:2d8:d251:f7ba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e78d:b0:2fc:9aa8:83da
 with SMTP id 5a478bee46e88-3011a369aa2mr27082eec.29.1778608014915; Tue, 12
 May 2026 10:46:54 -0700 (PDT)
Date: Tue, 12 May 2026 10:46:22 -0700
In-Reply-To: <20260512174638.120445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-15-irogers@google.com> <20260512174638.120445-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512174638.120445-3-irogers@google.com>
Subject: [PATCH v2 02/18] tools build: Integrate libdebuginfod into test-all
 fast path
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, james.clark@linaro.org, 
	namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	mingo@redhat.com, mmayer@broadcom.com, nathan@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me, 
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
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

Tested-by: James Clark <james.clark@linaro.org>
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

