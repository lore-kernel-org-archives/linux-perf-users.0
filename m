Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6679C4FC35B
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663179; cv=none; b=tWaD8sF/HXM05cdOV5qBniMO9sj4cXkQQasNvoReMMQaDnURCpMW7eGX/1wnvnAN1jU/I8hAtGgHva6jBkkXFsRiOz+no5DenUTIZtioe8Xc7LWwrfU3DfoPXvF35SdFvpe5PGqKBCZhThvQfEAo5BKQKJHExaZhFOO58nkQlNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663179; c=relaxed/simple;
	bh=72UnNtirGz1RIAJKdMUUSqZO5rNnsrTlzyJxWunYb7o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tIzlIuklbRhb3/BQwvWkC1/s0L+C0lWTqAA7H5JwqklCzKE5mJqYSsSC88IYrHpQmz6DR5/cb+sokNVRkXGD3o2IXQLQPOvKZktbtulyuQh1nlkpAjtRepCEMAPZ7MhhyPRqElAETsfm5G1eF4CZzgkZiMnzb4kKF1tzfkVQcI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z7IJcmYa; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z7IJcmYa"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-398dcfabbf8so2977681a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 09:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789663177; x=1790267977; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H5lF7GheK4MKeiXXkG5j+7GcvRK/G8aAxN+zH0dXNwI=;
        b=Z7IJcmYaWEUT8GgtbIdK/SACGZFcmAFSpFqKrBhGMaFk5bKov2pg7QTJAZmLahUF+1
         Kci8MmQYCtzcnTGpDNUi4XGjRaU33HpGd3Jkev2/TvYjaDd9mFUgQ8HtDwHnf9k6bC6+
         m2Jyvgt5KMliccEa7kDTsDOhXjwuRCjRk6SEZSBGzeIRdNw9EEiUVtnWb6bgG1CeYeAb
         c0UsbB0b4ZlinFnRrzuFZBmhGG5FOjzZH38e/tD2QHooOIfhW8gM82chyoqXjSgOonUX
         Oh93orXbAHLmbmU6H3kNmnoN8Cwz04iwxLqGSd/8QTvmvmzom/MN7Y+AcH2/qlXQpalt
         uF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789663177; x=1790267977;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H5lF7GheK4MKeiXXkG5j+7GcvRK/G8aAxN+zH0dXNwI=;
        b=j0bkhf44R0qbjni6v+H27m5/xNj2WwvQu99XDp/ESlfftsO3ocDgOkBbX0VatLd1yT
         d6zu4TGYKB3AECKfZl8EdvCcRiZ2TexBaOOIz8dKcmdmXKMCu8am5Y5d9mWVbMuwIXau
         OD6XjdAqkQmszg3iOLW6E0q/ZanOoxyk3gVv2CZtThOW/l9jdx8ekMo1s6L5CeuTqHAO
         1ADmqvQla2RyupZ9Bm2RgqdL0kfop2DoTz32nZm6uMavf3SmQtTekubrVEpftWDb6poA
         Fe5Dlr2gBpljdKNXKDiu5usukLgF1YirEFOQL/e8yN6YOWj8h91MaPBajcYgBly1in/b
         73WQ==
X-Forwarded-Encrypted: i=1; AKwUvBz67FAoZzJ4TICmBRx+Hbk8TCwPQAZscI4DBkYcqp4KA93x+sZNZr2x4geMC1n9iSuonlc1Fp7z/EOtlfz+Fm31@vger.kernel.org
X-Gm-Message-State: AFuF++nEC0EYgP5WerrnwIZ1dpv6DQV7v1SusVex8Fe04EbZyZR6sE6x
	PI5y+8r4Wu3mcAqvyYS52Qw+ar6CI+IpwYdhrIvIZg1W8/lt5ARIlv4thJUp3Qqz2EpBZzOTJSV
	z79RkZ91fXA==
X-Received: from dlef13.prod.google.com ([2002:a05:7022:b0cd:b0:143:77d0:b6d4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a51:b0:39e:14db:437c
 with SMTP id 98e67ed59e1d1-39e1e27a33amr14789183a91.4.1789663176613; Thu, 17
 Sep 2026 09:39:36 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:38:55 -0700
In-Reply-To: <cover.1789662556.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789662556.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <a42dfdda29f2c43bf6760294cd324a8418acd917.1789662556.git.irogers@google.com>
Subject: [PATCH v2 07/14] perf test test_task_analyzer: Isolate in temporary
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
 tools/perf/tests/shell/test_task_analyzer.sh | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/tests/shell/test_task_analyzer.sh
index 0314412e63b4..76df8af3312d 100755
--- a/tools/perf/tests/shell/test_task_analyzer.sh
+++ b/tools/perf/tests/shell/test_task_analyzer.sh
@@ -1,8 +1,18 @@
 #!/bin/bash
-# perf script task-analyzer tests (exclusive)
+# perf script task-analyzer tests
 # SPDX-License-Identifier: GPL-2.0
 
+# Resolve the source directory before changing the working directory below,
+# $0 may be a relative path and would no longer resolve from $tmpdir.
+perfdir=$(cd "$(dirname "$0")/../.." && pwd)
+
 tmpdir=$(mktemp -d /tmp/perf-script-task-analyzer-XXXXX)
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
@@ -20,8 +29,7 @@ fi
 export ASAN_OPTIONS=detect_leaks=0
 
 cleanup() {
-  rm -f "${perfdata}"
-  rm -f "${perfdata}".old
+  cd "$perfdir" || cd /tmp || exit
   rm -rf "$tmpdir"
 
   trap - exit term int
-- 
2.55.0.1082.g2b9226bbc0-goog

