Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513281;
	b=dcv+s5bsXSAUMa2Uob0QmdEV2oWVZR1yrQ3/SQVMHECso6etideCXgbvKkgv2lzF8+ID
	 GVwDjuCjH/tFCoiQqUMWINw0FsegVK0GDgxWsPnp7YjLi1OSlTvpKM8zWhH7lJj3uCpaT
	 SE4Ac6ahtrS8ysAqD2jeW3PVonFBIKc63pFIa7QThy3EXZFVWLy+MAC/5o2E1KtwW6QNm
	 vSCFj+pjlKqpxaVrIkMEdOcUnqZNAMhpeWdtA/7D7/+Tn1FFfgPZsvfHJFoMzW4BupdDE
	 Qdct+Qqi23dupqgEQcWLncrHZMfHTPFRfpzxXjpyNwjtizA4sEkGpaUOeEGbjaSeboA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513281;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PCbsGzUyUB8AWMnJq1N4jW5jiQ/skDGubkrF1//8Tzg=;
	b=TJ+DCNdVxXfJJFVZxOZiS8z5mOmjX7vgvhkh4R1ccWg7q2f3i3q1ALIdg1SEyu2xMyHi
	 VaHYJ7mQpAji4PsweNN8bLEbbiN6PTfnoXnN5eAENIIyN5xrnP8E/MS8MYySP5cxvpCDE
	 Zdr07JpYitB8muJCkBXK96Te5UKtDAEwR1c65cMSHpkR5GoMdetiWea+/ul9NlBxfV10t
	 RhmWsbCl/jMkGVCaJ6+Sy4IV9v+PxLeLKqfBaSn/mpqYO1tRDENKW5Wbyidt7cUUFKXpY
	 F1tSLWUZUbNowOqdfkC75TlwlLg0mlWes/pymZIPbeEl+3ZEpJdK6z28Vp4CwGoldwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HjvLPOku;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE8960A262F;
	Thu, 12 Nov 2026 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HjvLPOku
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5D21F000C7;
	Thu, 12 Nov 2026 19:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794513281;
	bh=PCbsGzUyUB8AWMnJq1N4jW5jiQ/skDGubkrF1//8Tzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HjvLPOku4Ev5Lb8ooa+PX+Uv9m69OSVEkyfweKRMPZg99aqc9Z4KzaUSCI9mCSPaZ
	 8VJVj17Yj6ulLNB+M5WDHnGJofkxuasvAdrZ6BUoZrpUp4wyOi2V1Db+1nvjEfY7ik
	 NALifWrVG+0makCou4b89N82cqaDsM5Xfb9O0YtlBFwEhyIf9q66sU5rhHLohhOrlR
	 vwAKdvjLt/+Sdoj6Q7fPewtu8Aoe0o0RscueHRt5tdT90VKzHyivEWlSZKOcKhqyo2
	 MpSyhoZZWLJjq+2xBru665fie8HpUOJcMNreA9zSN3j82Przq+uAf4L4n++jIUTLJX
	 7Glyeoi16aZ+w==
From: Sasha Levin <sashal@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	linux-kbuild@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/7] tools: build perf in tools_build
Date: Thu, 12 Nov 2026 14:54:24 -0500
Message-ID: <20261112195427.3411746-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112195427.3411746-1-sashal@kernel.org>
References: <20261112195427.3411746-1-sashal@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CONFIG_TOOLS_BUILD_PERF. perf is built as it is built standalone,
with optional features enabled when their libraries are installed, and
with perf's WERROR setting following CONFIG_WERROR. The feature table is
left out of the kernel build log.

CONFIG_TOOLS_BUILD_PERF_MINIMAL builds it with MINIMAL=1 instead, which
turns every optional feature off, so the result does not depend on the
build machine. Without MINIMAL=1 perf does not build when pkg-config,
libelf or libtraceevent is missing, so the option can only be turned
off when Kconfig finds all three for the target, and never with
CONFIG_COMPILE_TEST. A build test, randconfig included, then does not
fail over a library the machine does not have.

Signed-off-by: Sasha Levin <sashal@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/Kconfig         | 24 ++++++++++++++++++++++++
 tools/Makefile.kbuild | 10 ++++++++++
 2 files changed, 34 insertions(+)

diff --git a/tools/Kconfig b/tools/Kconfig
index 04896e6b0ca51..ab1e15beb9fe3 100644
--- a/tools/Kconfig
+++ b/tools/Kconfig
@@ -60,6 +60,30 @@ config TOOLS_BUILD_IIO
 	help
 	  Build tools/iio (lsiio, iio_event_monitor, iio_generic_buffer).
 
+config TOOLS_BUILD_PERF
+	bool "perf"
+	help
+	  Build tools/perf. As in a standalone perf build, optional
+	  features are enabled when the libraries they need are installed.
+
+# What perf does not build without, unless it is built with MINIMAL=1
+config TOOLS_BUILD_PERF_LIBS
+	def_bool $(success,command -v $(CROSS_COMPILE)pkg-config || command -v pkg-config) && \
+		 $(success,echo 'int main(void) { return 0; }' | $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag) `$(CROSS_COMPILE)pkg-config --cflags --libs libtraceevent 2>/dev/null || pkg-config --cflags --libs libtraceevent` -include libelf.h -include trace-seq.h -x c - -o /dev/null -lelf)
+
+config TOOLS_BUILD_PERF_MINIMAL
+	bool "Build perf with all optional features disabled" if TOOLS_BUILD_PERF_LIBS && !COMPILE_TEST
+	depends on TOOLS_BUILD_PERF
+	default !TOOLS_BUILD_PERF_LIBS || COMPILE_TEST
+	help
+	  Build perf with MINIMAL=1, which turns off every optional
+	  feature, so that the result does not depend on which libraries
+	  the build machine has installed. This is always on when
+	  pkg-config, libelf or libtraceevent is missing for the target,
+	  as perf does not build without them otherwise, and with
+	  COMPILE_TEST, which keeps build tests such as allmodconfig the
+	  same on every machine.
+
 config TOOLS_BUILD_SPI
 	bool "SPI tools"
 	help
diff --git a/tools/Makefile.kbuild b/tools/Makefile.kbuild
index 7a26e7c3d5769..5cf8441989fac 100644
--- a/tools/Makefile.kbuild
+++ b/tools/Makefile.kbuild
@@ -79,6 +79,16 @@ PHONY += $(tool-targets)
 $(tool-targets): tool-%: FORCE
 	$(call build,$(outdir)/$*,-C $(toolsdir)/$* O=$(outdir)/$* CC='$(call escsq,$(tools-cc))',,TOOLS_BUILD_$(shell echo $* | tr a-z A-Z))
 
+# perf, without the feature table in the kernel build log
+perf-flags := CC='$(call escsq,$(tools-cc))' FEATURE_DISPLAY= WERROR=$(if $(CONFIG_WERROR),1,0)
+perf-flags-$(CONFIG_TOOLS_BUILD_PERF_MINIMAL) += MINIMAL=1
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

