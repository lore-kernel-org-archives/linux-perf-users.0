Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFA52594A0;
	Wed, 11 Dec 2024 22:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733957124; cv=none; b=C2nlFZ6u0jF50kejLmP6NHUBepcH+mDJGh0VVWc0RecCLX7UsEv4tNEeIRLUU+PYqTpad3ORFYAW9d78LNVUbViq6XDYZlmBKXjgWawurGqKh6FualAENx4QnAyiZapIq3ftvLyyzCzOlxaSot9c/UAGe2zK+j4YbkbINTPXLu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733957124; c=relaxed/simple;
	bh=oliX2ZWsSJgL44apGvDiit+a6avUCWIMKdH/FEVNQg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Anvn8ZjgmyO+yOGE9MfPbYLdyeCzRINi6/5qi6fCGYUMmX/6dVHBDB3WhUw8mXCs59SGjNY1HF19h/pq1ooSi9KM0uzeUC2yuQPYtUPRB5G2grunHCN9TNtmg6OnRuqdv9e/fjcB7qrod5CKhwa/LjyQV/LhBmIgIoGbodD+3zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVoxkqD/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVoxkqD/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF4EC4CED2;
	Wed, 11 Dec 2024 22:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733957124;
	bh=oliX2ZWsSJgL44apGvDiit+a6avUCWIMKdH/FEVNQg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PVoxkqD/vchratwBVtUL+vK9OWQfCVTfnXZ4FVOFXhAU5ZBpuiliyYJB6D4oHW4r9
	 9V6pjV3dvct2cG+qXtsaZo5suIymmqn9fu1O6tR/ioBCMa/cQCUkDpEJL+0e0gnOXg
	 tWOPO/PYWJAa5IahCxvDM81gVX9j9ViMJ1i+Ta//VTnr/1M/j90DgDE1ZobY3REXNU
	 AVcgJZVdsnqtbm3ZTnGYf4xAHCgkIQaYURP2kGqoNzMapxRtF+Y7WvJM8YzX12Q4H8
	 vWN6TaC/XVjZh3/bNTfA+AwIBYCV9ZyEyIZTvLz8tFshkBXCu/3anxA+Ubh6eYeqot
	 ErgJ5H6AV39MA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH 2/2] tools build feature: Don't set feature-libcap=1 if libcap-devel isn't available
Date: Wed, 11 Dec 2024 19:45:09 -0300
Message-ID: <20241211224509.797827-3-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241211224509.797827-1-acme@kernel.org>
References: <20241211224509.797827-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

libcap isn't tested in the tools/build/feature/test-all.c fast path
feature detection process, so don't set it as available if test-all
manages to build.

There are other users of this feature detection mechanism, and they
explicitely ask for libcap to be tested, so are not affected by this
patch, for instance, with this patch in place:

  $ make -C tools/bpf/bpftool/ clean
  <SNIP>
  make: Leaving directory '/home/acme/git/perf-tools-next/tools/bpf/bpftool'
  ⬢ [acme@toolbox perf-tools-next]$ make -C tools/bpf/bpftool/
  make: Entering directory '/home/acme/git/perf-tools-next/tools/bpf/bpftool'

  Auto-detecting system features:
  ...                         clang-bpf-co-re: [ on  ]
  ...                                    llvm: [ on  ]
  ...                                  libcap: [ on  ]
  ...                                  libbfd: [ on  ]
  ...                             libelf-zstd: [ on  ]
  <SNIP>
    LINK    bpftool
  make: Leaving directory '/home/acme/git/perf-tools-next/tools/bpf/bpftool'
  $
  $ sudo rpm -e libcap-devel
  $ make -C tools/bpf/bpftool/
  <SNIP>
  make: Entering directory '/home/acme/git/perf-tools-next/tools/bpf/bpftool'

  Auto-detecting system features:
  ...                         clang-bpf-co-re: [ on  ]
  ...                                    llvm: [ on  ]
  ...                                  libcap: [ OFF ]
  ...                                  libbfd: [ on  ]
  ...                             libelf-zstd: [ on  ]

  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature | 2 --
 tools/build/feature/Makefile | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 52600e4d33af8712..e25cdb7db40e3f3d 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -73,7 +73,6 @@ FEATURE_TESTS_BASIC :=                  \
         glibc                           \
         libbfd                          \
         libbfd-buildid			\
-        libcap                          \
         libelf                          \
         libelf-getphdrnum               \
         libelf-gelf_getnote             \
@@ -150,7 +149,6 @@ FEATURE_DISPLAY ?=              \
          glibc                  \
          libbfd                 \
          libbfd-buildid		\
-         libcap                 \
          libelf                 \
          libnuma                \
          numa_num_possible_cpus \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 043dfd00fce72d8f..cbf751b6f0f76225 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -110,7 +110,7 @@ all: $(FILES)
 __BUILD = $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.c,$(@F)) $(LDFLAGS)
   BUILD = $(__BUILD) > $(@:.bin=.make.output) 2>&1
   BUILD_BFD = $(BUILD) -DPACKAGE='"perf"' -lbfd -ldl
-  BUILD_ALL = $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd -lcap
+  BUILD_ALL = $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd
 
 __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
   BUILDXX = $(__BUILDXX) > $(@:.bin=.make.output) 2>&1
-- 
2.47.0

