Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6582943C7DB
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 06:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627381; cv=none; b=TlPdm1+JWqs1U04oxgAH+MtWB+Mt2O88nRPCMufBdUm7XzcMAcx+YqtxPoGOec4ZQwZyoqA2um359U4+JDGcCbkGQ8ZVJi/hUJ0g+7D+A26IAZAuptUPcmj026AldLVloGFRC9inxdx+vPIRF6jqk0lrXvXKG68nJCS9IX8DaQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627381; c=relaxed/simple;
	bh=ijr3LP2P40ZUq1DuBNqRk+AgK81THBcVB9Y2LVWBVcs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Taw34hrFumjMFElfk578MhOc1eiFt9ariLwh+zk7aoDOE1TzkkGNef7qV/vAhDM9wYUV8ZjQQ732C1Knzp4aNKfjmql9baw1uDqlbAjI6A7aa2u59IAhnNWkpZ67kZSbMNCoYJdm0F481CEF8fxPOqtHf0cpUlpzuLkkS2x7otI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g1QZU5l9; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g1QZU5l9"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1a439db36so470638a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789627380; x=1790232180; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1MnZowd6oTOfaxXZbzT35kcRhO2jRSIVNLLWdFtgUAI=;
        b=g1QZU5l92FrF56BSE5S8NYmAqQe6Vu9k9YZy5n0saBB26zvahaStdb+/WmCykdutvs
         VkcYbFWZrq4L3YfS+CniXX2sgKAtzXogN+cid04uPF4JXxMmXty0HJGVDBXSdjvCPK4s
         ln3wHkFxPQpduckgQNyON3Les6mkZ9ulYb8Rgs8+GIaQiN6QnSC/8dG6znEz155cM+Ic
         ++H/KZN8CYBqUIZNju/QLLxG8J+3OLMeNJaefZm8eGnJ0VAxaW4PkHcUMsI8Pft2Gktz
         T07Io4BxshRdCYFLYn1rFquCOddwL1TEuPu/Tr6Rsxi9J8ivpQaubtsnO6wdtfJKWzGl
         r1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627380; x=1790232180;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1MnZowd6oTOfaxXZbzT35kcRhO2jRSIVNLLWdFtgUAI=;
        b=wYdlVQvEqFvgAfIRN3OtXnR1PkRrB7gx1CkzhD7l275vBJKXy37DSXerLw1xzdqrta
         u70deGL3d0e7Zv5oAK0w/5elMnlKC399QuL2ZLC1bEnT46gq/Irx//xXaGAd4eeJZ6zq
         nZTrLI/8mm9rUma3lgYqeTUTfbVsMELKGQd2ZUYS+c+/h4L6fAvN2fdBL5jCAJAHeIEA
         NQ/H8dy4X5HGUm3wgQPhtSqZwh9CcGxE69BF9Z3G4n2Lv07WgSB5n9YgP5oe+P/B73yn
         MFe07kxSAJRDgCW0+jtEC8YTEk/hp+6z+uoCkeT4zNDuS4CHyoEbCwOtPs6UWPj0LhlK
         J8SA==
X-Forwarded-Encrypted: i=1; AKwUvBzX8qN35JHGQArklxhYPuGB0K32IjzhukN6hxrC1uWmCjSIpuFNDyLIOWoCReOrFhYpRS5uahfLMTQx/XoqUQS6@vger.kernel.org
X-Gm-Message-State: AFuF++ljf2YOt6JIGCnoRQOhOD2MklRhGipkPDG5ndxW4E/NL0F1anwa
	NG3toaYahSa441AKEDK4HgX8hQ/rTMu0Xt4+4Zbv5u2oyG/2cxJRs9SH+CBajQ2IUZGQQRjbuK4
	bOSKdQTZDMQ==
X-Received: from dleb1-n2.prod.google.com ([2002:a05:701b:4241:20b0:144:4896:d41])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a0b:b0:3d3:ae1f:d7f3
 with SMTP id adf61e73a8af0-3dd5f73ef30mr14251445637.19.1789627379362; Wed, 16
 Sep 2026 23:42:59 -0700 (PDT)
Date: Wed, 16 Sep 2026 23:42:28 -0700
In-Reply-To: <cover.1789626977.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789626977.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <d1ed9832b1d73eb04405a78425a1aa4afa4a8cb6.1789626978.git.irogers@google.com>
Subject: [PATCH v1 06/13] perf test test_task_analyzer: Isolate in temporary
 directory and make non-exclusive
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

test_task_analyzer.sh writes perf.data and temporary files directly into
the current working directory, causing collisions when running tests in
parallel.

As a temporary measure until `perf script report` supports an input file
option, resolve perfdir to an absolute path, change directory into $tmpdir
for the test duration, and clean up in the exit trap. Remove the
(exclusive) tag so the test runs in parallel.

perfdir is derived from $0, which may be relative, so it has to be
resolved before the cd into $tmpdir, otherwise both PERF_EXEC_PATH and
the cleanup trap point at paths that no longer exist.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/test_task_analyzer.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/tests/shell/test_task_analyzer.sh
index 0314412e63b4..6f729d9508f8 100755
--- a/tools/perf/tests/shell/test_task_analyzer.sh
+++ b/tools/perf/tests/shell/test_task_analyzer.sh
@@ -1,8 +1,13 @@
 #!/bin/bash
-# perf script task-analyzer tests (exclusive)
+# perf script task-analyzer tests
 # SPDX-License-Identifier: GPL-2.0
 
+# Resolve the source directory before changing the working directory below,
+# $0 may be a relative path and would no longer resolve from $tmpdir.
+perfdir=$(cd "$(dirname "$0")/../.." && pwd)
+
 tmpdir=$(mktemp -d /tmp/perf-script-task-analyzer-XXXXX)
+cd "$tmpdir" || exit 1
 # TODO: perf script report only supports input from the CWD perf.data file, make
 # it support input from any file.
 perfdata="perf.data"
@@ -11,7 +16,6 @@ csvsummary="$tmpdir/csvsummary"
 err=0
 
 # set PERF_EXEC_PATH to find scripts in the source directory
-perfdir=$(dirname "$0")/../..
 if [ -e "$perfdir/scripts/python/Perf-Trace-Util" ]; then
   export PERF_EXEC_PATH=$perfdir
 fi
@@ -20,8 +24,7 @@ fi
 export ASAN_OPTIONS=detect_leaks=0
 
 cleanup() {
-  rm -f "${perfdata}"
-  rm -f "${perfdata}".old
+  cd "$perfdir" || cd /tmp || exit
   rm -rf "$tmpdir"
 
   trap - exit term int
-- 
2.55.0.1082.g2b9226bbc0-goog

