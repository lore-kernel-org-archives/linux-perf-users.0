Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE5B4F85D0;
	Fri, 16 Oct 2026 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161122; cv=none; b=DN4IF532GT9z4n5LmvbdWWSuW8b+d9LWj+mE7vP223o2n1fMYr+Exc3mZ4JUpMrOYxqSe4Vsn5PlBTsINzxYT0EO0YQorXZZT63Kz0D3n5tPNSW8E5JD1lUp4ksgM0VmmgIitRaf4PkpvEZmFFINjSCNh4qBwIHGZFYEAKvbwn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161122; c=relaxed/simple;
	bh=DKg0vClEQiXw3JhhcDZ2p/iKrKj7KxrJ/WWyyMYftbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RcuihDXMThTFpBCoEvuQpYGlEMSvZmyFigl4Kr7s9K2BuWdaDOoee2VOr6383at/V7KM+pVXWWN8kCuH6aio4LOObhPGd6G28afGux0gL56zNaVZFUSsv8cv9HJ65UcXY4IZ118aHDo1/ydV0rOwBZFUopTyk+VzpU7jckQeKLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXJXsPip; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXJXsPip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2E21F000C5;
	Fri, 16 Oct 2026 14:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792161121;
	bh=kd/73Q9Hgd2llB+WLK9Lex9iXlTyPC+WwzSuKxv5YwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BXJXsPipB61XtIRlj8v6GY/3wTjBT7VhrltR45hNLRNpErr4vmAWJzMMfwc9bvXYN
	 15yO+oCZJxNLcRMGuqyzR93Gon9pbevS+e9oXtg3awyKLPQMK/bebi1YyvPH4e4kS5
	 oPaI8yMGddfrNBMmrvYc4AViNC/0WNwwZNVIUxojaF8Zx35C/VZRQb5/RRPelo5nnV
	 t+5G2ZNVZasjB5OdmG/blzLAoXH06IH03GcZ68CYIhjcu5EWBTHsChcrOpjpqxtPdO
	 4uG7iOrLPEUBAwqGsZ/+01/mpgKzurJ2VsLR5geliOzx4AQEe2q7aXiS3nZApLN8+v
	 9zIxdbmqvz3xA==
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
Subject: [RFC PATCH v2 7/7] Documentation: describe building tools with the kernel
Date: Fri, 16 Oct 2026 10:31:43 -0400
Message-ID: <20261016143143.3613501-8-sashal@kernel.org>
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

Mention CONFIG_TOOLS_BUILD and "make tools_build" in the submit
checklist, ask for libc-only selftests to be added to tools/Kconfig,
and note that USERCFLAGS and USERLDFLAGS also apply to the tools.

Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/dev-tools/kselftest.rst      | 4 ++++
 Documentation/kbuild/kbuild.rst            | 4 +++-
 Documentation/process/submit-checklist.rst | 5 +++++
 3 files changed, 12 insertions(+), 1 deletion(-)

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
index 5a9013bacfb75..84da035fc66f6 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -114,12 +114,14 @@ Additional libraries to link against when building host programs.
 
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

