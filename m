Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB35737DABD;
	Tue, 11 Aug 2026 18:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786472958; cv=none; b=X+MJklErAC+6xng+N7615Gr5NEs5Te3XOYOFQ7hrl4eCvgHdGd3KVrGHTI5mRzHrrw8x/kEUvAvWa+um0aAr/LinQxWPEy5P4tF05f3ZMS0kd0BsvZDrICxoh5BMvHXci4aTuise/k0KujMSD3Ds/3Zh67nA9UOLHqYzspIu90Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786472958; c=relaxed/simple;
	bh=tpGtwYZ145YqUkXgN1heb52ddn3Lp2WW7a/b2a4GalQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIKwcrszOcsoVTu0fdLr0YfEMd/1qcySy17Cb2aUS8PGaBQvHd3uzMrj1cxu168WrFNjzcmHvgDzEH1aTBXWz8nVRLLwtNNuVGZeulS1v7OumQCutsBdnJKXtpW0DxLwq2ddZIssFX0Ix0/40ckWLlPcqRu9YwtuVONLIOwuZIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJLrsa2S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJLrsa2S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B961F00A3A;
	Tue, 11 Aug 2026 18:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786472956;
	bh=UxQMLD9BxGWhyYllynrzfLFDhx4GP1OBZQcL24YtVjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lJLrsa2SorDUsX3+IB97vf/pPyBr0yhxcvIWweC/Y2a+Cg7MFICeNsWTxZNNyTpPj
	 aegzQfyC9HSy/lOe+jUOdhD15dNSQeDDXrzkxiCfy0ObTKEjRT0pc4HSBy+pQ0c/wx
	 n9hXc1Seyw+zOu8iy7fZ0AChwPI9dlQq8oE5tQq7MDhl6luhtxbkpGUDOiqbzLwQMw
	 1XpKAhrL+i9w8JJOjaGTGzUqEINw5otO/Qd4nhHr6d/4BH0+vzH42CF/iiXXGu8tZQ
	 ldLd8XZeZVAYNajcgXIguq5/5c1u5g5xy+fnZ+VY9M98AVkJjYspS1GC5+VQGYHYur
	 LY9gbrQphU9SQ==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/7] tools build: Only probe the compiler at parse time when it is installed
Date: Tue, 11 Aug 2026 15:28:54 -0300
Message-ID: <20260811182900.27063-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811182900.27063-1-acme@kernel.org>
References: <20260811182900.27063-1-acme@kernel.org>
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

In the corner case where gcc is not yet installed, the very setup the
install-build-deps target, added in the next patch of this series, is
meant for, these probes make even targets that never compile parse-time
spew errors like:

    /bin/sh: 1: gcc: not found
    /bin/sh: 1: gcc: not found
    /bin/sh: 1: gcc: not found

Guard both probes with 'command -v' using the first word of CC so a
missing compiler is handled silently with the same result as a failing
probe (CC_NO_CLANG and LP64 unset/0), and with no behavior change when
the compiler is installed.

Only the first word is consulted because CC may carry arguments such as
'ccache gcc', and shell implementations differ in how 'command -v'
handles multiple words (dash only checks the first, bash any of them),
so validating the whole CC value would silently disable both probes on
some make SHELLs.

Assisted-by: opencode:deepseek-v4-flash-free
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/scripts/Makefile.arch    | 8 +++++++-
 tools/scripts/Makefile.include | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/scripts/Makefile.arch b/tools/scripts/Makefile.arch
index eabfe9f411d914b9..ed5f008d400ed238 100644
--- a/tools/scripts/Makefile.arch
+++ b/tools/scripts/Makefile.arch
@@ -38,7 +38,13 @@ ifeq ($(ARCH),loongarch64)
        SRCARCH := loongarch
 endif
 
-LP64 := $(shell echo __LP64__ | ${CC} ${CFLAGS} -E -x c - | tail -n 1)
+# Probe for __LP64__ only when the compiler is installed: this runs at
+# parse time for every target, including ones that never compile, e.g.
+# install-build-deps, and would otherwise spew "gcc: not found" when the
+# compiler is not yet installed. Only the first word of CC is consulted,
+# as CC may carry arguments, e.g. 'ccache gcc'. When the guard fails it
+# prints nothing, leaving LP64 unset, as if the probe had failed.
+LP64 := $(shell if command -v $(firstword ${CC}) >/dev/null 2>&1; then echo __LP64__ | ${CC} ${CFLAGS} -E -x c -; fi | tail -n 1)
 ifeq ($(LP64), 1)
   IS_64_BIT := 1
 else
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 46a3872b87624a7b..378387f629603e92 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -98,7 +98,13 @@ else
   $(call allow-override,LLVM_STRIP,llvm-strip)
 endif
 
-CC_NO_CLANG := $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang__"; echo $$?)
+# The CC_NO_CLANG probe also runs at parse time for targets that never
+# compile, so guard it with 'command -v': when the compiler is not yet
+# installed, e.g. the first install-build-deps run, it would otherwise
+# spew "gcc: not found". Only the first word of CC is consulted, as CC
+# may carry arguments, e.g. 'ccache gcc'. A missing compiler leaves
+# CC_NO_CLANG at 1, as if the probe had failed.
+CC_NO_CLANG := $(shell if command -v $(firstword $(CC)) >/dev/null 2>&1; then $(CC) -dM -E -x c /dev/null; fi | grep -Fq "__clang__"; echo $$?)
 
 # Some tools require bpftool
 SYSTEM_BPFTOOL	?= bpftool
-- 
2.55.0

