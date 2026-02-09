Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEA738885B;
	Mon,  9 Feb 2026 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658068; cv=none; b=ifKnKla5HjSvunFSh9Q00Esz/nzdLiPJ9hmQLLV8kPP2+JujT/QzYdbU07gPi/PQQSttS92yLbEMMe5XNJpw3qYpHTLdt+sUdTefFPEzjpB08SzrLRpzoFqqJ5IUp2tSm4FPLWlKmyg9z0cL/oPhCuljIcDjppd7Yz3yAt/HQ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658068; c=relaxed/simple;
	bh=pwMAAfFbeaAQQa4FoFtSXgK4zrb8LBy95FgN34t3aJE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mYCA9Nh2kfA27pZXN5BwyoJoLvtTIRq26hRHRJD21VVDzRlNW/vdFBWTckECi2aOxLcrUosgBLdLq2aZ8QT2pt01xfvdyQgY5lBKC+hADOeEcMMm9jhphK6Z4g902I2uoPU5RuUqzYgCvUwwUVqpqpP6Ulro+J60ti+ED0hP6fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqII8Q7t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqII8Q7t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14324C116C6;
	Mon,  9 Feb 2026 17:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770658067;
	bh=pwMAAfFbeaAQQa4FoFtSXgK4zrb8LBy95FgN34t3aJE=;
	h=Date:From:To:Cc:Subject:From;
	b=JqII8Q7ttJp4Ox5yXsC8crNSU9oaWruzQe9zWV+ldbsc4JQcuEg1bCkqU0j4U34wI
	 Dd38//0TPi0xvG8Rf9P7kKn17HSTk2KyIklXU/NwJgTjmqcLzfWMJWjK4jLSLWf5uO
	 OXC0zfr7GsCdLxuZjXP52yEhuLn5w2CoafmVTKQ/yin/pnzjZgG7RVcBRF3asrJmkM
	 XLWbKR64iIrJgtjh5q2b1QE1No+EZo7uZjcXoRSbcKOeCjsTw9CBvIXR/e/wmUtuYw
	 4/qPUefcue0fQo2v/76TQiIof2KqZxWh1i8OEjZJsG08QNrpPGvsiv3iD1UvDXTwIu
	 cV8AKMgM1pejg==
Date: Mon, 9 Feb 2026 14:27:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] tools build: Fix rust feature detection
Message-ID: <aYoZD1onJLsnlrV3@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Features in FEATURE_TESTS_BASIC will be set as being available if
test-all.c builds, so since the rust test isn't included in test-all.c,
we can't have 'rust' in there, remove it from FEATURE_TESTS_BASIC and
use feature-check so that it tries to build test-rust.bin, doing the
actual feature detection.

On a system lacking a rust compiler:

  Makefile.config:1158: Rust is not found. Test workloads with rust are disabled.

  Auto-detecting system features:
  ...                                   libdw: [ on  ]
  ...                                   glibc: [ on  ]
  ...                                  libelf: [ on  ]
  ...                                 libnuma: [ on  ]
  ...                  numa_num_possible_cpus: [ on  ]
  ...                               libpython: [ on  ]
  ...                             libcapstone: [ on  ]
  ...                               llvm-perf: [ on  ]
  ...                                    zlib: [ on  ]
  ...                                    lzma: [ on  ]
  ...                                     bpf: [ on  ]
  ...                                  libaio: [ on  ]
  ...                                 libzstd: [ on  ]
  ...                              libopenssl: [ on  ]
  ...                                    rust: [ OFF ]

  $ cat /tmp/build/perf-tools-next/feature/test-rust.make.output
  /bin/sh: line 1: rustc: command not found
  $ file /tmp/build/perf-tools-next/feature/test-rust.bin
  /tmp/build/perf-tools-next/feature/test-rust.bin: cannot open `/tmp/build/perf-tools-next/feature/test-rust.bin' (No such file or directory)
  $
  $ perf -vv | grep RUST
                  rust: [ OFF ]  # HAVE_RUST_SUPPORT
  $

And after installing it:

  ...                                    rust: [ on  ]

  $ cat /tmp/build/perf-tools-next/feature/test-rust.make.output
  $ file /tmp/build/perf-tools-next/feature/test-rust.bin
/tmp/build/perf-tools-next/feature/test-rust.bin: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=9c416edf673ee3705b97bae893a99a6fcf1ee258, for GNU/Linux 3.2.0, with debug_info, not stripped
  $
  $ perf -vv | grep RUST
                  rust: [ on  ]  # HAVE_RUST_SUPPORT
  $

Fixes: 6a32fa5ccd33da5d ("tools build: Add a feature test for rust compiler")
Cc: Dmitrii Dolgov <9erthalion6@gmail.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature | 3 +--
 tools/perf/Makefile.config   | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 64d21152fc81aad6..0b7a7c38cb88a7d0 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -100,8 +100,7 @@ FEATURE_TESTS_BASIC :=                  \
         disassembler-four-args		\
         disassembler-init-styled	\
         file-handle			\
-        libopenssl			\
-        rust
+        libopenssl
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
 # of all feature tests
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 94aecfe38b95f716..a8dc72cfe48eec52 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1154,6 +1154,7 @@ ifneq ($(NO_LIBTRACEEVENT),1)
 endif
 
 ifndef NO_RUST
+  $(call feature_check,rust)
   ifneq ($(feature-rust), 1)
     $(warning Rust is not found. Test workloads with rust are disabled.)
     NO_RUST := 1
-- 
2.53.0

