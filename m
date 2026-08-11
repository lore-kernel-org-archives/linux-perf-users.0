Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06633ACA6F;
	Tue, 11 Aug 2026 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461563; cv=none; b=UOiqxSZhh6iolZik1XkLGsud98/CROd1/2ZC+f7aEqVA51VsjAaOJ1xyZcGPg8lFwGssBpJJWhNJCgCv4+1jNs8Qx3Z8qXfECqkjLjw5iuaQbySznfNfwkQKF59yfH7Lpe1bQJifA4gAgJoLFJhPc23ZRenu3IUQ9NMzhvf8BA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461563; c=relaxed/simple;
	bh=JbkZYWF3YrS5ed+x8ko0iubFS9qlgph09duWKgdhvCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJda6DddPzr+Uvqnvh/+wMpher3y+vlqTMBwfbVR9V0I4eJbI0juKOebtsX7yKAfEjyJX4k67QzgPw3L6lqeBk8o9i9I2GW0VMZwQFa2jh+FueDN5O/rL8KUuadpeu8YF7AKmMKa9NTQunMXP4pyspUIFJqj1vTJYVnjhJSG9AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNztm7rp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNztm7rp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98131F00A3A;
	Tue, 11 Aug 2026 15:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786461562;
	bh=FBgcyj6h3jr6VBBfGkjg60PGflAnYXMQ4oRUuFnpGqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LNztm7rpuNAezorpLNVVoOJOZDiLrXPhDnrCL5k+7imp35sTmFiMgjvc6svd9drNB
	 4Rf2jvtXVmPF20HkQcyMYgUj5iiCvL1JUJ1JGiK44/nSsirovU/r2JCACaJfpi1W+b
	 shbsNNqI4sP+PvPfFES517n9+BzV4vsXejeR1nMjR7MnJaIOVBny4ySalPtDRjfPa2
	 Kf2oXZxJtkdELA3z3CT6s/MYE1EY8qeG5KMDc0QdIih9Yg/+NSY9jrtvW8KBBr9nUn
	 pG28e/1jNemsw4sRwUWGGiF8S4kHD4H4buIsY6w4uPxelDIV8HCL96vL1wlpIy45+f
	 /7n5UEoEoRkbw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 1/7] tools build: Only probe the compiler at parse time when it is installed
Date: Tue, 11 Aug 2026 12:19:06 -0300
Message-ID: <20260811151912.9294-2-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811151912.9294-1-acme@kernel.org>
References: <20260811151912.9294-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Two parse-time probes still invoke $(CC) unconditionally:

- LP64 in tools/scripts/Makefile.arch, probing with
  $(CC) -E -x c, pulled in twice by tools/perf/Makefile.perf;
- CC_NO_CLANG in tools/scripts/Makefile.include, probing with
  $(CC) -dM -E -x c /dev/null.

In the corner case where gcc is not yet installed, the very setup
the install-build-deps target, added in the next patch of this
series, is meant for, these probes make even targets that never
compile parse-time spew errors like:

    /bin/sh: 1: gcc: not found
    /bin/sh: 1: gcc: not found
    /bin/sh: 1: gcc: not found

Guard both probes with 'command -v' using the first word of CC so
a missing compiler is handled silently with the same result as a
failing probe (CC_NO_CLANG and LP64 unset/0), and with no behavior
change when the compiler is installed.  Only the first word is
consulted because CC may carry arguments such as 'ccache gcc', and
shell implementations differ in how 'command -v' handles multiple
words (dash only checks the first, bash any of them), so validating
the whole CC value would silently disable both probes on some make
SHELLs.

Assisted-by: opencode:deepseek-v4-flash-free
Signed-off-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/scripts/Makefile.arch    | 2 +-
 tools/scripts/Makefile.include | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/scripts/Makefile.arch b/tools/scripts/Makefile.arch
index eabfe9f411d914b9..e0bca6808ec44ed8 100644
--- a/tools/scripts/Makefile.arch
+++ b/tools/scripts/Makefile.arch
@@ -38,7 +38,7 @@ ifeq ($(ARCH),loongarch64)
        SRCARCH := loongarch
 endif
 
-LP64 := $(shell echo __LP64__ | ${CC} ${CFLAGS} -E -x c - | tail -n 1)
+LP64 := $(shell if command -v $(firstword ${CC}) >/dev/null 2>&1; then echo __LP64__ | ${CC} ${CFLAGS} -E -x c -; fi | tail -n 1)
 ifeq ($(LP64), 1)
   IS_64_BIT := 1
 else
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 46a3872b87624a7b..fff453aac187536e 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -98,7 +98,7 @@ else
   $(call allow-override,LLVM_STRIP,llvm-strip)
 endif
 
-CC_NO_CLANG := $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang__"; echo $$?)
+CC_NO_CLANG := $(shell if command -v $(firstword $(CC)) >/dev/null 2>&1; then $(CC) -dM -E -x c /dev/null; fi | grep -Fq "__clang__"; echo $$?)
 
 # Some tools require bpftool
 SYSTEM_BPFTOOL	?= bpftool
-- 
2.55.0

