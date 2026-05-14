Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E19344DA0
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776469; cv=none; b=tbLnAK1kOEmlZ7u/Uy25kNkpfQGhAkFwyQqOOCQDh5gAmIqlycqFI6VSvmGRl9JUVoFu2l0RxPu2kbt/YxG5dt7H+uYlzRUHnWes+iU7RPC2Pb3vNllFG5FizO5PM9VyhXyLEj23lbLQJkr4NwN87nd/g/oFcJqbO5jPRna9g/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776469; c=relaxed/simple;
	bh=uqUEFNQ57AFlcZMBFJffGyxRIJA2Tz6olGf/kXvYcAU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QvOdKixnR32wkAxD8RlCuJQ8kwHX/KRbaxSPyEaoaF0y2veiYgJCns+xvalvrlYGzZldtIw9TJSN5WBidGouTws2AR0YiuCeynyUnhI8+MEoSVj2bmQ6ElqDQKEEC6FU2LCMOtqYT5xfahQZZlK6BST85KK+59iB27uzkq/gHaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o8E8BK4c; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8E8BK4c"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-132d631edaaso4165576c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 09:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778776466; x=1779381266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4CsWFZTIpHT1rxN0oH0dIIw0Lzzf2ZZoZH+mSq/1ZRM=;
        b=o8E8BK4cW9IIj/eskZh/8MDrYN/4K7f9nn4DbOKs4gvZ78bVGTrhl6uBSqLobo/kL4
         AV9Q6jZowyLZWf1ya3WLqBegCx8pbf+eyqXobrpQ0tOBc0vWlNT0Zd7+rIhbjlvMBahF
         JVOQof4PC9pD/SQkWFUYzd9JBgogwcxliJFBwUP3P3ApQruqXfT2VUgORko0KALmbT+V
         7QanfGXHrl7u5+W5yC64y3rHrZXahzmm1GEX2tN8Y3Va59jsSp48V7b+xRF5Uhfhp+xO
         /9KZCkuA/48scwRSE2ipG5Xho51fZE6dn80gnfUFxWbVaL+tKndDjE6HInq6PhWVvPzW
         lmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776466; x=1779381266;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4CsWFZTIpHT1rxN0oH0dIIw0Lzzf2ZZoZH+mSq/1ZRM=;
        b=dMsFEHbg77DhFTEPwOlF3zvHErY6snuPd73qymKcudH3oD3BdXVVcVRon9fk4lGNA7
         Y/ebqQHCyvFoimAeCjw3a2UEP8KZA4CjMWPGRH0tY53RP1sptJ8XXzw6NdLxUYpArOJQ
         Lyp6Pb5ZZTEyUUKpRkYIQvVSjGbmzB0xU6DoPDa409L4GDQafFNz99jpTVnxBqAclSuc
         vPa6zW/2WUTA8LHAmLVcRbhkCEqDEQOlkIfTmjrJ9dZn/h5cBTn8BmMjYnVj5K0zJTI/
         EOEc8k2ci/l/NKlMyMQaGlapM01NTAOqPz7rgWgF0xoY0OrKys4LsIT/fVTtIhToqcsN
         G0Rw==
X-Forwarded-Encrypted: i=1; AFNElJ/DRLaZ0kPS3jEsQ4i2Ay5vJ/D90YwRyIDTzhIq80VEI1V6/GzBVPLTJQJAMlof7xLHl1UA6r2hRTV6jDg9ik40@vger.kernel.org
X-Gm-Message-State: AOJu0YxsN/0AUN/PM9JJMSYsmU/jWCnzGZqYiO3QWNIguaGX3Fv9Zd/p
	ErsA5QRtjzEBTSbMLLftooh9E7UxxuTc5XsNCbQa61WluqfHr44En53lAWADMHJgFq5zbrJd8p0
	OBey+9RNC6Q==
X-Received: from dlbem2.prod.google.com ([2002:a05:7022:1002:b0:132:8d92:4d6e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1b08:b0:128:cf5c:5362
 with SMTP id a92af1059eb24-1342ef43500mr5598839c88.12.1778776465893; Thu, 14
 May 2026 09:34:25 -0700 (PDT)
Date: Thu, 14 May 2026 09:33:54 -0700
In-Reply-To: <20260514163409.927816-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512174638.120445-1-irogers@google.com> <20260514163409.927816-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514163409.927816-3-irogers@google.com>
Subject: [PATCH v3 02/17] tools build: Integrate libdebuginfod into test-all
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
index 2f192d3bf61b..064c75dd9914 100644
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
+    feature-$(1) :=3D $$(shell $(MAKE) OUTPUT=3D$(OUTPUT_FEATURES) CC=3D"$=
(CC)" CXX=3D"$(CXX)" CFLAGS=3D"$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))=
" CXXFLAGS=3D"$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS=3D"=
$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir) $(OUTPUT_FEATUR=
ES)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
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

