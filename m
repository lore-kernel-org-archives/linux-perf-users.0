Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793585593;
	b=VvobIaRDk622sY2j9zmaS6PWnvCiCFvnQhsdDX+O5JE12rbsP6CX0DODY9+7EYcmaZ3k
	 BdmnDdM8e6YA9kGxw9bvsfNU8aJqa3wIDpxPuqGENhifzpaPoO/a+J0sPAW2m8qELT5P4
	 eR2UWswKlNkbAFG7AOik7Ww3CfpWQGsGdMe5ZWfAXXY/2CEs5j9x9CZLKZDq2YXWXREKI
	 rxsFihhlwT9qVdJypHbUPbdL30wZSTxJplfOj1o2fNqgBmoGS7w4hPq0UqH0GFlEE9cLe
	 kiW1jO5KlYhY6wpxur9iEhtyDVSY/cThFmB5X65d/u5C+P6mxoR9eKqhlpT4VvF5ZSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585593;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bOFxAEH+ZFyMZuI7EGvq5j1GO9KqNo7OLMLpxBG7sEg=;
	b=4x5Cu4o8PcLjtfJ/K8JlpFxPeRvHyQ7baFHwdUE3FbxuHgh/NeKbRq1j3WicoVNRK8dl
	 nWkhN3K/CwCCCelsy2Wr9q7gdmfbF3fc8gKZRCPdLrHVjQw+E7q4m+z112d6x39S5SIqF
	 Ni1ON/hkXUzu4YYVGzj35UgBLEl79r+/G5NTR3lxxVJ1+46DGZIsDkuX0a2ELLCO5TrsH
	 HX76e0OnjkrUbFFJ0Z0ooJ4cLxgSO9u7D6fJNMhghoKh3rPAJ16C+jjwp+tKeYir1n7Y5
	 Rbm/pTOXJoDIpIKqirykdg7yvGu8diHLmYGq3zzT+jx2RMnDl8bDsXnGDmYBrBDD4Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4rpLhkq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85FA60A380B;
	Mon,  2 Nov 2026 02:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4rpLhkq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7551F000C1;
	Mon,  2 Nov 2026 02:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793585592;
	bh=bOFxAEH+ZFyMZuI7EGvq5j1GO9KqNo7OLMLpxBG7sEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N4rpLhkq6waalnYUV/9lbTJRUxFTnnYd5lYWcgwsDEgl8R+80LWwjrsI5BDqyFDjh
	 F+FAWJluiHg6iUIqW+zrYdftsDeh5WcVKiAb/ur89VzklVsn259dJok2wjmc/3OKsA
	 OKO1jz6TEX8rnp2kU5ND+LFWvlfcnAL1flMrS8Tkj6pigq5gONP2e3Wwh+dH1tmz7p
	 LzgsHE63Nx8CoCSZgX7CJFcB6AmUG774Y6HJz2yPCRiAYzzIQ1Jm0coak4E84/q3ov
	 4A0UUo5o+ZUMIhvrlgNc1i77AqwizREcxBITaFgYiaqRGruxBPKUWqpQsyaAjbutrh
	 5MT4xmAZPUbxg==
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
Subject: [PATCH v3 7/7] Documentation: describe building tools with the kernel
Date: Sun,  1 Nov 2026 21:12:53 -0500
Message-ID: <20261102021253.2545235-8-sashal@kernel.org>
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

Mention CONFIG_TOOLS_BUILD and "make tools_build" in the submit
checklist, ask for libc-only selftests to be added to tools/Kconfig,
and note that USERCFLAGS and USERLDFLAGS also apply to the tools.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/dev-tools/kselftest.rst      | 4 ++++
 Documentation/kbuild/kbuild.rst            | 4 +++-
 Documentation/process/submit-checklist.rst | 5 +++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 0772525cbc627..9dc771ee185fb 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -371,6 +371,10 @@ Contributing new tests (details)
 
     TARGETS += android
 
+ * If the test builds with only a C library, add an entry for it to the
+   "Kernel selftests" menu in tools/Kconfig and to tools/Makefile.kbuild,
+   so that it is built together with the kernel.
+
  * All changes should pass::
 
     kselftest-{all,install,clean,gen_tar}
diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
index e71a692a559ac..ea48a11b513e7 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -131,12 +131,14 @@ of the same name.
 
 USERCFLAGS
 ----------
-Additional options used for $(CC) when compiling userprogs.
+Additional options used for $(CC) when compiling userprogs and the tools
+selected in tools/Kconfig.
 
 USERLDFLAGS
 -----------
 Additional options used for $(LD) when linking userprogs. userprogs are linked
 with CC, so $(USERLDFLAGS) should include "-Wl," prefix as applicable.
+The tools selected in tools/Kconfig get these options in LDFLAGS.
 
 KBUILD_KCONFIG
 --------------
diff --git a/Documentation/process/submit-checklist.rst b/Documentation/process/submit-checklist.rst
index beb7f94279fdb..9857b05824c2d 100644
--- a/Documentation/process/submit-checklist.rst
+++ b/Documentation/process/submit-checklist.rst
@@ -91,6 +91,11 @@ Build your code
      Use ``make htmldocs`` or ``make pdfdocs`` to check the build and
      fix any issues.
 
+  e) Changes to tools/ or to UAPI headers do not break the userspace tools
+     selected by ``CONFIG_TOOLS_BUILD``. ``allmodconfig`` turns it on when
+     the compiler can link glibc programs for the target (currently x86_64
+     and arm64), and ``make tools_build`` builds only the tools.
+
 2) Builds on multiple CPU architectures by using local cross-compile tools
    or some other build farm.
    Note that testing against architectures of different word sizes
-- 
2.53.0

