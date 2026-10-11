Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9125946C83D;
	Sun, 11 Oct 2026 23:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791761815; cv=none; b=TcqC55u8xEh5AGjzW08nh8PLU6wC7GUKwFBmbJLn45IMZsi2NQCCRUmgAiKsp5VwynWhXEEFo65+tjH3dNjz3YZYjMxJ+W/TNN/dvddjP8n6ssChaKyrTzhTA0VJMo+R/EL3a+q5GhPsAeoJImDUYiP/4VHhre0aYeuncj6kkbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791761815; c=relaxed/simple;
	bh=hZoKFJEnTElFskzRPLL7AxdIFjEr4MjH/swxWsGlZT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0GEKKGrm0NbqgNv5kfekg4ALWjmUcKPzEQevC2PpYNfAPBDu7piSve9qKyqgQ46HfcmcGIX7X7ntqhgeHXb2RNvShK0+uzB1N6OPW9MWHXxuMK1Vl0LM4IzasuYWa+h3hH/W8xHy4P9Bze2zcVcL1XZJxsbI2jweWPpxgQg1Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQ+W5/p8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQ+W5/p8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C971F0089C;
	Sun, 11 Oct 2026 23:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791761814;
	bh=LJ12yYMPBoOMJoNeWTi+XwbM+nB2kB+XOopAW/+af6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VQ+W5/p8/mZJjPBb23g3Qz6FdpOl2VgXOr5uGbR5yIH4MI5VFQlu8eL7EHuUYzPMg
	 fQCNV50wH8Kw7ZOSDkjNhxRRjmwpEb7XIKf/VjkJqs0MS/loQsGs+RB2SXG7cpS3nM
	 aNHMeuLpkVL+lrR+73MkIORSriYjQPiTWJ8KZn90K4TMc2q5fAX7v7Sc0HR7ooDDrv
	 kiQzMi2JP6yQkyDjZwoFKWpRYg9vTUJVN7LDBhDGFmB7YIHGlFj3iX/N6F2VJz5Zrc
	 pZJLEUO+4UNpU69Z/bWL/xm06+og2n72GeMK0xH3xjKmu7rkadpuRH9lxubJEJLWJ7
	 B4vcFkRwbJHjw==
From: Sasha Levin <sashal@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	linux-kbuild@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH 3/6] tools: build perf in tools_build
Date: Sun, 11 Oct 2026 19:36:42 -0400
Message-ID: <20261011233647.2454648-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011233647.2454648-1-sashal@kernel.org>
References: <20261011233647.2454648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CONFIG_TOOLS_BUILD_PERF. perf is built as it is built standalone,
with optional features enabled when their libraries are installed, and
with -Werror following CONFIG_WERROR. The feature table is left out of
the kernel build log.

CONFIG_TOOLS_BUILD_PERF_MINIMAL turns every optional feature off
instead, so the result does not depend on the build machine. allmodconfig
and allyesconfig turn it on.

Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/Kconfig         | 15 +++++++++++++++
 tools/Makefile.kbuild | 19 +++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/tools/Kconfig b/tools/Kconfig
index bf0643b39b86e..488f439592150 100644
--- a/tools/Kconfig
+++ b/tools/Kconfig
@@ -59,6 +59,21 @@ config TOOLS_BUILD_IIO
 	help
 	  Build tools/iio (lsiio, iio_event_monitor, iio_generic_buffer).
 
+config TOOLS_BUILD_PERF
+	bool "perf"
+	help
+	  Build tools/perf. As in a standalone perf build, optional
+	  features are enabled when the libraries they need are installed.
+
+config TOOLS_BUILD_PERF_MINIMAL
+	bool "Build perf with all optional features disabled"
+	depends on TOOLS_BUILD_PERF
+	help
+	  Turn off every optional perf feature, so that the result does
+	  not depend on which libraries the build machine has installed.
+	  allmodconfig and allyesconfig turn this on, which keeps their
+	  builds the same on every machine.
+
 config TOOLS_BUILD_SPI
 	bool "SPI tools"
 	help
diff --git a/tools/Makefile.kbuild b/tools/Makefile.kbuild
index 820a2d9a3893b..62fd494253eca 100644
--- a/tools/Makefile.kbuild
+++ b/tools/Makefile.kbuild
@@ -73,6 +73,25 @@ PHONY += $(tool-targets)
 $(tool-targets): tool-%: FORCE
 	$(call build,$(outdir)/$*,-C $(toolsdir)/$* O=$(outdir)/$* CC='$(call escsq,$(tools-cc))',,TOOLS_BUILD_$(shell echo $* | tr a-z A-Z))
 
+# perf, without the feature table in the kernel build log
+perf-flags := CC='$(call escsq,$(tools-cc))' FEATURE_DISPLAY= WERROR=$(if $(CONFIG_WERROR),1,0)
+
+# Every optional feature off, so the result does not depend on which
+# libraries are installed
+perf-flags-$(CONFIG_TOOLS_BUILD_PERF_MINIMAL) += \
+	NO_LIBELF=1 NO_LIBTRACEEVENT=1 NO_JEVENTS=1 NO_LIBPYTHON=1 NO_LIBDW=1 \
+	NO_LIBBPF=1 BUILD_BPF_SKEL=0 NO_SLANG=1 NO_GTK2=1 NO_AIO=1 \
+	NO_BACKTRACE=1 NO_DEMANGLE=1 NO_LZMA=1 NO_LIBZSTD=1 NO_ZLIB=1 \
+	NO_LIBNUMA=1 NO_LIBUNWIND=1 NO_LIBLLVM=1 NO_CAPSTONE=1 NO_LIBPFM4=1 \
+	NO_SDT=1 NO_JVMTI=1 NO_LIBDEBUGINFOD=1 NO_BABELTRACE2=1 NO_RUST=1 \
+	NO_SHELLCHECK=1 NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1
+
+__tools_build: $(if $(CONFIG_TOOLS_BUILD_PERF),perf)
+
+PHONY += perf
+perf: FORCE
+	$(call build,$(outdir)/perf,-C $(toolsdir)/perf -f Makefile.perf O=$(outdir)/perf $(perf-flags) $(perf-flags-y),,TOOLS_BUILD_PERF)
+
 PHONY += FORCE
 FORCE:
 
-- 
2.53.0

