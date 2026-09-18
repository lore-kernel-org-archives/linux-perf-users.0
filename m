Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A5A4FDA78
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740450; cv=none; b=cFtv8Hu5aAziOQUmSb2Nd1R480j+s53x52VJQIuKam7fhoqy3Orn2+cFj3OTsVyHmOUlQ+Iw/lNWIoYyS5Q/hwVEQTiuqewYbrTI5sdSb6371hWFQWTzMgWaRH5TnmXffthYoBS0oCfW0NcJgD7dLY+DEq8tPWS8zFPNGPEpISQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740450; c=relaxed/simple;
	bh=l5TAbWEU6B9V61riUhgaEbX3bYek64hdeMlGHIz+XJc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oTNEupjtXxkqzoDpuv6c5LW+tEwLyuB9LvLieMBsmOXspJrXiM2sePDb7v3GZFpT/4L/jXVfuTKtCFKew1vGPmtRno4TytK4puDRhlFsf0liW+CuB8ch5svmyhRoxsmu5p1y9pRHzrdy0Ee5zpeNF8yy1IkeJBtDhtrCSc819rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CHCHBTYI; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CHCHBTYI"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dbf293831so1828362a91.3
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 07:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789740447; x=1790345247; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CQS0ArZiNsMn8IJnh7vbzYLZ5vZtatDhvYlp4Dv89Ww=;
        b=CHCHBTYIh8yV7dcdeTg1jJSz5FhoutU+E8m/mZaN9D5v52Q9Sh2+tOPvsIU1QQ6mt7
         PfewHUQUtb5W3F4qL4VW18by/7Fm11d/BMf66tq/nyV6sIt4ZWInSW+50/TfhAqb0PiH
         PZreBjnHEPQi/4fB+uRcZfj3gw9eq+MUpU7/sLE8BX7HRmpDpOsUA3rLMFDHb/HVnKnY
         MvvHzfZAjKFxat913/yx4rWYncAkp68W6UwpzHW1vdqQo5n4KcXGjU26n7+8gZZKWibd
         qjjSZ+sHalMjFrOwU754c8eW4z3MpVnTqyCG50itp1KSpbyenFNDxYPl0y+iZ9Q3WLZ0
         XvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789740447; x=1790345247;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CQS0ArZiNsMn8IJnh7vbzYLZ5vZtatDhvYlp4Dv89Ww=;
        b=UPfDi3p76jlKR57h8tT2vNT3cKq9fOech9Oo2ZewlsjNipU3Yovom64TDMhY+pySNs
         AQWqLq6R5CGfoSc7D7R6JiRJprmDnJbE97VCNrVU7b+XC44MHGe896VCLPsUJyj2N0+Z
         1sncQ2CXaWobmcSlXG4vdmxFpFze768Pu3a50XrlN9A9DkxM1lLplDxjsWxf9in3fEAu
         71h6YhF33Qoh6FLhgsQ7U63lIuc1I/t3LD6PsZwCq5++eMOMvg8QBnLZbWwVFn12wvfs
         VDUM7nWKKmRidV433oXe/YiaQbXnUg6ftOpBE6uplkcVkQhINxVdWWvCKXVa1bQuUd98
         hHwg==
X-Forwarded-Encrypted: i=1; AKwUvBweWYACx2FEE8dGoVjE5wOtHRo1tjZZ0DF18k7KbkeNE7W2asskuHIDCETR9NNw4XyodJhEW7HoQLzpWe3yPOg9@vger.kernel.org
X-Gm-Message-State: AFuF++kpz/V4XlIDArv05JuWegrrDP6FibdWpPpUvLZgeS8Yhuo/+biT
	wx/3O/BMJDAE8e2lnfTwb+wcC76GBd4ynuwADZb83Zt1UWm3dN6AqzVoadin0/6cw36P7rG6pVT
	d7M7AQO8fVQ==
X-Received: from dlag9.prod.google.com ([2002:a05:701b:2509:b0:144:cce8:29d8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:224c:b0:39d:f024:c7ec
 with SMTP id 98e67ed59e1d1-39e54ea71c0mr5714311a91.16.1789740447277; Fri, 18
 Sep 2026 07:07:27 -0700 (PDT)
Date: Fri, 18 Sep 2026 07:06:52 -0700
In-Reply-To: <20260918140659.2501976-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789662556.git.irogers@google.com> <20260918140659.2501976-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918140659.2501976-10-irogers@google.com>
Subject: [PATCH v3 09/16] perf test test_task_analyzer: Isolate in temporary
 directory and make non-exclusive
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
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
2.55.0.1082.g2b9226bbc0-goog

