Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EBD4EE870;
	Fri, 16 Oct 2026 14:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161116; cv=none; b=MEWN/K82XB3t1Uyu6lyv3u6WldD2LP+Dw2CRpMTUCibVSA4V8n1pE4gP63QWEhqanbBITbWZWGpfoMXsjS1txYdcYz+Lb6l2s4AdFHdilypap4xOOhqGFlNmSvW9oi0YbmlZhKuItjrCKfG6JmYUuElUh3QTWaRPDSmd/0F9aCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161116; c=relaxed/simple;
	bh=7P1OuuOX+0H+Yno4UUVvdgpkQhC4ItGmkhlU+zaQ3go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uy9McW+b50yucmSW8SwfJBd9Y+JUtLUZEinzaimZNaB3TfMxoYr2FQAcD6qdtpGhfdWw5OrgugGrSbPaylle5+R7u5Tk5NePCgP7g3eAte5gzHtE3Z6RHc0Dsn7ez/o7VNns7lpC+g4xyoFzD+elsXBd2acg29r+4sEAd6snudk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmq0aqDo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmq0aqDo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27161F000C5;
	Fri, 16 Oct 2026 14:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792161114;
	bh=G7GfiDN0QmrwjOjySuQeD9nlMuYz0TjfWW1h6N/ALxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mmq0aqDo7aRJ8B+IpjISS/jnAgNi2VnUok2BeQ90V6hHQq1OwsKG3knASUNEVIn3+
	 Hp6eXJ7xu2dArpN19m7fjpyLx0eqcBgKfkMd6+52vioxC13Y3Jwy3L19d3raHqeHtE
	 YJU4v68RdVPNkkDZ+hhcCWBRYC8jG5uC7Q/ruXVbfW4fSCesPe+6p/sPDVbhEiBFNS
	 EoWXf3Vr8P29hb1lgHiopGPzjL5224Dw7aORLfPPfT859Z0TlJOw8MU4jx46WSP6fB
	 VQ6Qfpy3NIvAxSo7tRo87aa+MO0xUqc9URtaftjZQhu0X4lj06iEMvH/DgK0FtPjTS
	 kpixGaILEH03Q==
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
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 4/7] tools: build perf in tools_build
Date: Fri, 16 Oct 2026 10:31:40 -0400
Message-ID: <20261016143143.3613501-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016143143.3613501-1-sashal@kernel.org>
References: <20261016143143.3613501-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CONFIG_TOOLS_BUILD_PERF. perf is built as it is built standalone,
with optional features enabled when their libraries are installed, and
with perf's WERROR setting following CONFIG_WERROR. The feature table is
left out of the kernel build log.

CONFIG_TOOLS_BUILD_PERF_MINIMAL builds it with MINIMAL=1 instead, which
turns every optional feature off, so the result does not depend on the
build machine. allmodconfig and allyesconfig turn it on.

Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/Kconfig         | 16 ++++++++++++++++
 tools/Makefile.kbuild | 10 ++++++++++
 2 files changed, 26 insertions(+)

diff --git a/tools/Kconfig b/tools/Kconfig
index 2d05c8e593e21..4f13e3b104377 100644
--- a/tools/Kconfig
+++ b/tools/Kconfig
@@ -60,6 +60,22 @@ config TOOLS_BUILD_IIO
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
+	  Build perf with MINIMAL=1, which turns off every optional
+	  feature, so that the result does not depend on which libraries
+	  the build machine has installed. allmodconfig and allyesconfig
+	  turn this on, which keeps their builds the same on every
+	  machine.
+
 config TOOLS_BUILD_SPI
 	bool "SPI tools"
 	help
diff --git a/tools/Makefile.kbuild b/tools/Makefile.kbuild
index 8cfa7f80039cd..4b3ea73bc8ab9 100644
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

