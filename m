Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793585586;
	b=gMeDPUcTayIiAhacZ5mw1GxF266EluNRSJkni75tWYQUYkn9XH559jV33e+SprYSxPpz
	 0tST93zxjZMcwc/fx2Q/btyvxcj6csc9GCgt2lxRtWQyKWtwdudkoT6nvDDTjOgf3eVw4
	 owmKX2bIZemr1MiJEkffqsTdchoRwrgZVrgU5Soo5WSvzazciVbXZNMG+OdDaCxWc54nt
	 ot7bCvvt7LycPCuNCDoqLmuv4wtsQ5B0Or8gczugqSmn1FXVft5bIZawdOaDG+CZW7fT+
	 204DaibDrqC6Sn2oqKDtCms7S3zvGXGBM7Xu81VJwS8iGiVWMbIzbjShXYbs64lT8gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585586;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cU0Ay6zVnXJvrg0bXiWTHLMuHcC/T70qrKx/9BeMpik=;
	b=uR166CAvQGRi93da2eb4aadeOv1zIWZ0wv2LCACUPSUUpXRtuMtdOydBa5JYiVdLVbvL
	 9XX2ZEdIRGf7e+U5O6FjaoYhmXk4fp4751JYOPRiagF+na7dSTHZhDNVXekKo/zFJH5Xw
	 zIa4TLmgWRxnOMjexJWUr6iHCQ/dBzjWJYswt0c7kbMHyKWk0GLWLgK8dtFrMFWLjPb/e
	 YEGT/WjjPR70RmA9H5a3iVXUIUxzW5/pMQN72yj8a1Qkf1c+u6H9jHXG2bPK5mzuac1qU
	 X4tiP7Twma61KJ7T744x5gor2iVSttuZzycl71U81mAGcimeoIHb5dbaqgQMn0VAYYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XufmkUxv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C8660A3832;
	Mon,  2 Nov 2026 02:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XufmkUxv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79781F00A1A;
	Mon,  2 Nov 2026 02:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793585585;
	bh=cU0Ay6zVnXJvrg0bXiWTHLMuHcC/T70qrKx/9BeMpik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XufmkUxvHH+0MuNGZb1UEOHeg23Orzws9wTYjZTnlsTqb+VaxaQDOw7H0uxGcxDVB
	 FyZsHHPT/rHpPjo0REBCKoPCyumePNul5LVds3XLOwOEA0Vw/Riaox315tAUlkwWHf
	 MrpBzFFSNZnlIm/4VZXvUs6EhdDhTkJ9+21qQrxabjE+Al0g1wCgBQZgmkAVumVoRa
	 yxn7HuFyc6bL1EHVYIDUMs5MdgNSTKn/910yNM8wLxCx34+rIi5zkqpRy2jNkLmcGp
	 IpGv8NE8gpPrE08YXUpuwOEKqz2xN4o1J1g0ttTYR2hTd9L2BuavLtghZqx5pWawmi
	 zlIxJ7XQoUTBw==
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
Subject: [PATCH v3 4/7] tools: build perf in tools_build
Date: Sun,  1 Nov 2026 21:12:50 -0500
Message-ID: <20261102021253.2545235-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102021253.2545235-1-sashal@kernel.org>
References: <20261102021253.2545235-1-sashal@kernel.org>
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
build machine. allmodconfig and allyesconfig turn it on.

Signed-off-by: Sasha Levin <sashal@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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

