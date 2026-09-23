Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387A046C822
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147688; cv=none; b=DocH9IgrTPkGk+rHG+TuKczLNFx+AMcPQsyFwNjRYYQkV3jEznw96t6v9j+AiLN8W67f2QSnEqMIkWQbBNBnH6ZO1mccXLXK+j8ZhqC5kKwBEonIZWLdEIYw6+HOFxwCzTOAzKfUEiaaNR43i0kM8cT4S6PS/sftvDjt5k7oTO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147688; c=relaxed/simple;
	bh=HGRs9eE+a+hJaFRu3Ek+1Q83wFRO/38c+2fbh/2XvQk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GthaWPNAofh65LgeS8BBqx36peNOQUMhO1//H3Vv7Z5VOwrnNfGxb3xz7fTb1S0sCUQjrX+Og35PYCi+Y8sCpUUJhCZmxFeXhr0JxuNsP0NnwrnNxbuCcTGJN/X3uSAppwTLydyfbdb1SpSFJ9ERwXTTiJ4R3h/U2+xM9wJCtvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wN84PSaf; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wN84PSaf"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-334f782d1abso2068022eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 00:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790147686; x=1790752486; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ooYn38WMvkypRVHD0ux8njXnA46P1bfoYCxR163N8YI=;
        b=wN84PSafdXlQth9tSB3bJAm19smY1IIkn2oiZghDfX7AX4mSXtGd42dSJ1wRC2qrBf
         J4ms85OM6T70zKNiRetocGBFUhOH1YWIn9tXn5I8w0QI9HGWqnZ+6xZWZutEi6UYjo/o
         0+ZjoSgfjnK9XB82B7pHG7n4H/v0BUwLwE2ew3x6ZnX/xgH/FgtWG6OWmlHhYQmF7Lbe
         C0Svu5SaF7Hg0Hs64pMPTonS+sFDJb50VX/s91lHJmhj42s0EuGrF6zKpem4nHdOU4NS
         mqGdFDPjRq6dDW2hEE9zQz86Mbc/AYam6FFcIQXhgNdsIW2n2mkJJzO+hyw1wtLE0ffk
         Ym6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790147686; x=1790752486;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ooYn38WMvkypRVHD0ux8njXnA46P1bfoYCxR163N8YI=;
        b=ttFpfnR7eBcu8Dm2bcNNdFx2BoJWfr3SgeWF+qxoxHf4fRVAcdqNbT1hg9z2wWz18s
         GKCqhBKMzLm7x2we46v/bR6yr+ENdAAblnQ1A1zLPgF5qEbyVSjnMrNzMkL2vMoZN7Mg
         pkzuVd9XZsFdh+Xn8BqlogDs6vcuUQTJOijmcPXuTOo1UiV7Xu27uvbRZgoa8jl6cNlJ
         yxqw4Pjtz/V84ND3bwA9KyBBnjRgpu/Cb/f28Jy17Fr3qNYceoPvPucwYeiJ+BEiePZV
         X6w1v0CrDmldxZJjDHEXNSxtilSCaZCvZt+8vRfjvz5ISo5RHjTMyzdI6a2nf97585AI
         oCUw==
X-Forwarded-Encrypted: i=1; AKwUvBz6yLluFksjpJW2Pu6X3l7I4JoyWMAkx3hdv7hSHDV/ieTJzCvNBSZdSrQQRzaLuoEkHMxIJ4HmVFHag4tMsOrO@vger.kernel.org
X-Gm-Message-State: AFuF++nPCChpTfiCDL0PQl5vBI8AvKzp/BAqEuX80B3p5eo3zIn99yI0
	sdXtotFmXMqxKtTCR9e1B4/gqOxVVQcy/qnLNUftXC3cBSzug9XlnCg1hiraYgulPtYZxxEu+XN
	xu2oTM5lQeg==
X-Received: from dli6-n1.prod.google.com ([2002:a05:7022:286:10b0:144:e53d:6fa6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b903:b0:144:ed03:7c6a
 with SMTP id a92af1059eb24-144f90c371fmr2036646c88.15.1790147683855; Wed, 23
 Sep 2026 00:14:43 -0700 (PDT)
Date: Wed, 23 Sep 2026 00:13:56 -0700
In-Reply-To: <cover.1790145937.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <d3f26f77e5aabb9776c9a4775ca650f6d90b0136.1790145937.git.irogers@google.com>
Subject: [PATCH v5 16/23] perf test test_task_analyzer: Isolate in temporary
 directory and make non-exclusive
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, howardchu95@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
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
 tools/perf/tests/shell/test_task_analyzer.sh | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/tests/shell/test_task_analyzer.sh
index 0314412e63b4..443b88957b17 100755
--- a/tools/perf/tests/shell/test_task_analyzer.sh
+++ b/tools/perf/tests/shell/test_task_analyzer.sh
@@ -1,8 +1,18 @@
 #!/bin/bash
-# perf script task-analyzer tests (exclusive)
+# perf script task-analyzer tests
 # SPDX-License-Identifier: GPL-2.0
 
-tmpdir=$(mktemp -d /tmp/perf-script-task-analyzer-XXXXX)
+# Resolve the source directory before changing the working directory below,
+# $0 may be a relative path and would no longer resolve from $tmpdir.
+perfdir=$(cd "$(dirname "$0")/../.." && pwd)
+
+tmpdir=$(mktemp -d /tmp/perf-script-task-analyzer-XXXXX) || exit 1
+# The cleanup trap is only installed further down, once the functions it
+# calls have been defined, so tidy up by hand if this cd fails.
+cd "$tmpdir" || {
+  rmdir "$tmpdir"
+  exit 1
+}
 # TODO: perf script report only supports input from the CWD perf.data file, make
 # it support input from any file.
 perfdata="perf.data"
@@ -11,7 +21,6 @@ csvsummary="$tmpdir/csvsummary"
 err=0
 
 # set PERF_EXEC_PATH to find scripts in the source directory
-perfdir=$(dirname "$0")/../..
 if [ -e "$perfdir/scripts/python/Perf-Trace-Util" ]; then
   export PERF_EXEC_PATH=$perfdir
 fi
@@ -20,8 +29,9 @@ fi
 export ASAN_OPTIONS=detect_leaks=0
 
 cleanup() {
-  rm -f "${perfdata}"
-  rm -f "${perfdata}".old
+  # Step out of $tmpdir before removing it. The removal uses an absolute
+  # path and works from anywhere, so a failure to cd must not skip it.
+  cd "$perfdir" || cd / || true
   rm -rf "$tmpdir"
 
   trap - exit term int
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

