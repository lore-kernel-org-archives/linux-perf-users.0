Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCF846C840;
	Sun, 11 Oct 2026 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791761821; cv=none; b=UERgJfJVo4ALFLNRf2HT2Gq5LUOEF7uz93rQbs7CdYCQW9SuqpRoYQ0G0fBsXr+9cvMcX8jK74mOW5NbiBa57Ix1eZfgYPybSWpVSE4XwOEs539cOUjf4WHwKMeHSRoYwRrniHZZoaCupfSbJKjfQ0CQwMSWU97f+nGyhQE4aZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791761821; c=relaxed/simple;
	bh=FBfaI0cmoDsi8R69uUeDrIYyoOXNUDuV7jIj7az660k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMfZLQ3E54Kc50TgWTqmxXYjlV2oHXmRQA46AY6xzYUNf+dKLg0WmQ+L6hSMNnJs9Gfzeg3Zz6pRWXaD7m14EoIidf2z8Absq/lbYbbtakdAx6SEsGVI2rnOs/9jy/jmLAoV7ieJ3F8LZPMPzWKROifNpEfs0WqIh0rWpEJJsl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReMBvRhI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReMBvRhI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869EC1F0089C;
	Sun, 11 Oct 2026 23:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791761819;
	bh=Hhwt7NcqlK2UG3MHM+AwzpIyGFQ3Rmp336tlJmGcn88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ReMBvRhIiypYU7sn9qiRgDIK4TXAt7b8wkePMzbSb/OfBM03rfkmP2FCdxl3RFW6n
	 ur8VsZPIN5QsyGJ/mhCz/KRjIyh4LgjZVhwyFE6trZ5KKmmwol9hGebiWADHk/zU7g
	 di8aTQdfEzOnkAuf17JtPiAtJ39KU9+QE3Iue9o5LoCyZpD4ST/Z3kgKxr29uMsHVJ
	 6G7mP4h6e+n73I1x/ZlkV5/muyKKP3oo1xeEGsJHSuaCUFzt8XB2Mqv2dA01xh2+jw
	 6ejXPGvpKRQHPsCAgyDNc35WeTk+udOGzOYKgkh34N/SSpr+OKu9Y0cVKpogFGx5D2
	 CCWZooqelbwFg==
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
	Sasha Levin <sashal@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [RFC PATCH 6/6] Documentation: describe building tools with the kernel
Date: Sun, 11 Oct 2026 19:36:45 -0400
Message-ID: <20261011233647.2454648-7-sashal@kernel.org>
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

Mention CONFIG_TOOLS_BUILD and "make tools_build" in the submit
checklist, ask for libc-only selftests to be added to tools/Kconfig,
and note that USERCFLAGS and USERLDFLAGS also apply to the tools.

Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/dev-tools/kselftest.rst      | 4 ++++
 Documentation/kbuild/kbuild.rst            | 5 ++++-
 Documentation/process/submit-checklist.rst | 5 +++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 64c0ec7428a27..407d539e49b01 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -315,6 +315,10 @@ Contributing new tests (details)
 
     TARGETS += android
 
+ * If the test builds with only a C library, add an entry for it to the
+   "Kernel selftests" menu in tools/Kconfig and to tools/Makefile.kbuild,
+   so that it is built together with the kernel.
+
  * All changes should pass::
 
     kselftest-{all,install,clean,gen_tar}
diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
index 5a9013bacfb75..3e8e076a262fa 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -114,12 +114,15 @@ Additional libraries to link against when building host programs.
 
 USERCFLAGS
 ----------
-Additional options used for $(CC) when compiling userprogs.
+Additional options used for $(CC) when compiling userprogs and the tools
+selected in tools/Kconfig.
 
 USERLDFLAGS
 -----------
 Additional options used for $(LD) when linking userprogs. userprogs are linked
 with CC, so $(USERLDFLAGS) should include "-Wl," prefix as applicable.
+The tools selected in tools/Kconfig get these options on the compiler
+command line.
 
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

