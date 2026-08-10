Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49223264614;
	Mon, 10 Aug 2026 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786398401; cv=none; b=CeknqJdRVoc62cFElsgGs/vpRwp/zNF80eJqf/qKQknlraxiA0ODITTx0l2/qSkhjp3MR99QLg1lbOdK7W0blikLE5x36BjaAcA56Q1cd0UdTbLhveAzt9KA1q2Ata5sVXwFqZ6qfiGedc/TBNdH35vw6WhmHC5VEXAYwkFwyoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786398401; c=relaxed/simple;
	bh=tFUymGdJQaUPpsR7ZYLmVXNygMm94MrVL2actGnijB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1Xoi5IapLgX8BODdGsbDTCpfuZfRbBG711iNM0fOc7JJcayoAE+zR5BmgCaKhU3u4uuU9vKnOQK2IYMQpDucwbr7jjMFw5YFcf0r5xP4P53apNP/AMhmHnvvF4tZvywgp0mmgrK9EiqD5Zei9QX/cKeEjy/PLkeLJIj5FRSCCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGKgD+dp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGKgD+dp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411B51F00A3A;
	Mon, 10 Aug 2026 21:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786398399;
	bh=rJXebWkyZIpKnxgtf+jpUGGA9PWTzBxkQpSwEWTJrIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DGKgD+dp6nWKP/gukxT5nszZmk73iufO/nVsoi0G8DPyeMsSLcYjeFIEiJEgJe//d
	 A6uYmqu88HFMviCvr+r6Oa9ZsXpF34gPgmgmahnW1tCvZBCaOr17hxkqBy0jFzE3uh
	 U8xuzo8Lz2z9sF8xempvz9m187hAOYjbhaMH3ZG4ELcR6g5Cok7Lb4MU38LRFTreAC
	 BCXcoF+bS7AbN7txMVc8Bm/wiCWn7DiKeYYvL24OkaSL4Zwr/reKR/0ng70NKn6//o
	 Fxq9TN5mR2e0saHIJHUl/Q4rzG7nfRebGZQt6mtWQ2gwWgDuKtXHeumdp4Fbt/JOYw
	 1ISdcRDD0aIsA==
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
Date: Mon, 10 Aug 2026 18:46:18 -0300
Message-ID: <20260810214624.21156-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810214624.21156-1-acme@kernel.org>
References: <20260810214624.21156-1-acme@kernel.org>
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

