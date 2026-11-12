Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513288;
	b=OcDC5QwRgITzIVvr4BuqODYwvLFTLg9KJMgw8aAlRusBzR9lof/MGdhWRxRNAaOZR/o6
	 t3saf6Lb3AYlXL/PYSYewsRIq+kZ/gtAIrKUuNoQCVp0NOkM0G3KfUL3elL/qkd71+4g5
	 C3Nev63FlZctprc6/LfWdpcb2EJqvcp/F7/HRc0RonDN5Siw9EwN0zG7Cy0wW4YnyVF3l
	 aOjO9EWYWUsCuX6rvMJdREj9sV+Gx1b4D/UoZ7JnWwIwHDU07UdpWNiOTsRYK89HlY/zR
	 UJ6T51kZsd/up1ymXB2uMsYHLIL09Ab3ad+RJFAKCPyBDxhlwIvz69gDbbrS4hamHuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513288;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bOFxAEH+ZFyMZuI7EGvq5j1GO9KqNo7OLMLpxBG7sEg=;
	b=EX2JeqbRNpX5MiZ/a6kx1A34edPLrrbZdUsAzWenw74qNP/oomReRxVUx1hDNp87RnY3
	 JbYPQ/pVwoNJxSG2QMPkyn2tAGDSHfuge9B7UH8b+aDypsvc09AleZlhXKcCx4rjYDzNq
	 inzww5Cqmgb6QxrW9KBwqPJlRxr1+0FZ7rR9rW1su6tHypGiA0IgLmZGzcVG4s4RHhfvH
	 8iZV+6MhAy+Hkf9eFFzWw3z8p4Xsi93H2dwwgIZUSXmMfSfEJwdCh/UUzbyR31qtt44uh
	 G0/7Ek3mpZnCh6VEN4C/Lyf8EHI4CoXZDWZUP+F1ng5/dDz+FGOfgGzoyiUs5+Op1zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WCf3ht8/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC07360A261C;
	Thu, 12 Nov 2026 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WCf3ht8/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D2D1F000C4;
	Thu, 12 Nov 2026 19:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794513288;
	bh=bOFxAEH+ZFyMZuI7EGvq5j1GO9KqNo7OLMLpxBG7sEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WCf3ht8/FX6+PzTTddT2PL+dn7f9og/tJOOz6nR21Q7GYLgWi9mKhKcXdxU3aJkB/
	 takoahnDc5RbHTq4CsDtrBe3ZDuBhflGB4wkuF2zQhG41QkOAQOgleaXXX8OxIvOUI
	 nHF+16ihnYkoZDC28ed1tjBak4relM3eeYYxKevTNCSpfzItFIMynPTDrSligoxoru
	 sO4VXQiT9Ia4Db7QI/AWtPHbAQ1WLbqBzeLX9jom8xD+K3DA4LWT4mnT5kjPad7mLe
	 rAg/TkbJevq68JqhES/xTAtD+SKM32IsJiJqJPYm44jT+HK3fgtXlnVHGZTh9jXtFK
	 KiMAtXrmsRjhA==
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
Subject: [PATCH v4 7/7] Documentation: describe building tools with the kernel
Date: Thu, 12 Nov 2026 14:54:27 -0500
Message-ID: <20261112195427.3411746-8-sashal@kernel.org>
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

