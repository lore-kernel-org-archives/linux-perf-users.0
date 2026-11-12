Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513286;
	b=4iZPp98xC/PrPYuOoxQifROB1aYfmJSIAFUwdMo+h2qUb28UAxxo8z3O20Fq4izm/YO4
	 RVK02pXAorJe/ut0INL7vQA7W+g1EkV4bnba+7xiCcGD1utUM10Mw1tIUKHB6DHHj7dSp
	 fvdxC78mhgfRbzbTwWdlEFvNopaYuGcdsbxAVIL90qoRxRNgnVMm24TLBfqiNGTQ2M6oC
	 wp4Yq5Bt3RP/CWq91X8aO9IAFoSHi83Xs1oBE7iywcMFuwqv4qjmKWaU9LA73NKCr2Ifo
	 MPUIsqRFMJd1P+vrRIykpMmJ8PA7zGCclTX1/Y97Iu2hxdJ5DM/s7u+SxM4f9G5ihfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513286;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Gb8+2Cm7VYc21mGqZ8Jc3XFCiBtua3HpjtI5IyisGDE=;
	b=woUHlpynZ83afCoVDeoNselza/rynxBHJSIfopvIC7Bh/llt4rkk1vtb/FnPp8VzTpsK
	 qKkMr+n2Z2XJbrIpnzjWuMEqWJis6JNpI/uAywyi+7Nmi2pIlT0Tg6d9WYg2zt1vq7NAE
	 zdGUDQ6VVUZmHwHygVUcIUlnHEyasZOKefXd0dJ17taSLV1hgkKaJegL2fvUC4QvcYZnR
	 bBTbM6Qr69uDzSg0v9m8DPDm1DyaclykHK7U7FsTdGkol5sRh2Mx1j0dIq1c2f0SmCaeI
	 wrP23AB/7QcKSDA0zGRNZ/miaXgeNa7TsUfA0OyvLfK7VlhhRi8/r6k7FUxMIqXH0Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="l0X/jShM";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D61160A381F;
	Thu, 12 Nov 2026 19:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l0X/jShM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C821F000CF;
	Thu, 12 Nov 2026 19:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794513286;
	bh=Gb8+2Cm7VYc21mGqZ8Jc3XFCiBtua3HpjtI5IyisGDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l0X/jShM4aZV4JNPtinWFqnAEJJympiIQSjCOR6Mmea3Jhc3B3AaFA0JdHjKezBWt
	 Ft3yAfDq6aGm+OvGkvv63AchphMYieK91+fL9fJyj9DdxYTc+wyOtcxi2ceig3xrAA
	 hrYkzBQM/l1Nk8OKYOr1oI+Q0uKiAO21FYrU3JHbTpFQS3I8IuUVWWVmMDVkqJFJnd
	 axJCYNaAI2rxLjFajRxNI7DLEfQyQMh+nv3tipWTXVWO1sL/h8OQh9kU40kzYdtpSw
	 sMaBwk73UM3uink4e8ddhDHwypa3sRSNoGKI0qk9rfyur7YKI+WGgx//24QCttj7z7
	 SQlus7LfK407w==
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
Subject: [PATCH v4 6/7] kbuild: build the tools selected in tools/Kconfig as part of "make all"
Date: Thu, 12 Nov 2026 14:54:26 -0500
Message-ID: <20261112195427.3411746-7-sashal@kernel.org>
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

With CONFIG_TOOLS_BUILD set, make "all" depend on tools_build, so the
selected tools are built with every kernel build, and allmodconfig and
allyesconfig builds catch changes that break them.

"make vmlinux", "make modules", single target and external module
builds are unaffected.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 7919263484f0a..2a69f4c73a641 100644
--- a/Makefile
+++ b/Makefile
@@ -1650,6 +1650,10 @@ PHONY += tools_build
 tools_build: headers
 	$(Q)$(MAKE) -f $(srctree)/tools/Makefile.kbuild
 
+ifdef CONFIG_TOOLS_BUILD
+all: tools_build
+endif
+
 # ---------------------------------------------------------------------------
 # Kernel selftest
 
-- 
2.53.0

