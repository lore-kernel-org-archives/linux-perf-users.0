Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71369415B88;
	Wed, 23 Sep 2026 21:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200377; cv=none; b=IcPz/uWhW4TgU3KgUOrRCPJzLR8GtdPIeN85PzhO67+DAompIYcyJjCGI43wtosah0Sy8Y+UFY3xqlip39IbBVylkgvyPtyySLmktFsasvfl3it/E5unIJhIv6KZtr9NX3v65BNgHvVdyJIYlInS1XwzP7O3WjQaml9lAUWHRMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200377; c=relaxed/simple;
	bh=l7OglEAwSt1jLoJHVasM2M4VYyJDcxs1XC34NEAgoeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gp4THBugRurHhUqyt1vKZEPfyyEiT5pJ4Mnrn1posdF247cZw92sTyspiCSoTV3ERkGnBI1zbJZMGZ2NO1pfkQP6T9uCvdnIFgH2fsLfPFwg0m3GKV0MsqfhAs6mArXx28rgjZ0+UfQ6U9XNlp8AoCNFWRCBW0tjTjsRSJTJTvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTDaGOIU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTDaGOIU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A774C1F000FF;
	Wed, 23 Sep 2026 21:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790200375;
	bh=HvJdXodZ17I1ZVdgvf5P2EpOwG/2qJMagSy/Sq4OorA=;
	h=From:To:Cc:Subject:Date;
	b=kTDaGOIUop6gb/+fHhZi0eXr1ubw46hBwQOnI/XgYmcP+6bDdlUsIAPQQJpLkFOeH
	 6B4s8jZCl3qzuaIx/MLIJKy4UN+G7Ii/FQYAp2bILOFXWGSdKi2KpZDrAFhIOYD6Ly
	 +wpE03W3dunCx25Zfl0dK24cT7jRSP6bT6Tek/jxCOH41YsGibtpYru0UQfDkvIPJ0
	 c41orRE+OEDx50xAVF1lY6zEKrJpcKDHWteydYmIkbD57xUkGhZZWo6/i9mw0+Y3K9
	 Qzwvl8UepyC+ga+68AtZSvkvG44lczFRlU4knabisgnfFVRIpcun01MvDZ0tI0wjyn
	 UtlcuApbO61xw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/3] perf test: Fix errors when deleting data in perf record tests
Date: Wed, 23 Sep 2026 14:52:53 -0700
Message-ID: <20260923215255.3329181-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf record with multithreads would create a data directory instead of a
file.  But the cleanup and retry logic expect a file and try to delete
them with 'rm -f' which would fail.  Add '-r' flag to remove directories.

  rm: cannot remove '/tmp/__perf_test.perf.data.ZVHTw.old': Is a directory

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/lib/perf_record.sh | 2 +-
 tools/perf/tests/shell/record.sh          | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_record.sh b/tools/perf/tests/shell/lib/perf_record.sh
index 2b9e11b66dc7a801..a95fafb8b6fa8b40 100644
--- a/tools/perf/tests/shell/lib/perf_record.sh
+++ b/tools/perf/tests/shell/lib/perf_record.sh
@@ -30,7 +30,7 @@ perf_record_with_retry() {
   fi
 
   for duration in 0.01 0.1 0.3 1.0 2.0; do
-    rm -f "${perfdata}".old
+    rm -rf "${perfdata}".old
     ${cmd_prefix} "$@" -o "${perfdata}" ${testprog_base} ${duration} > "$logfile" 2>&1
     local record_exit=$?
 
diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 4a4931cb5ba91849..cf8ba3d3411b0bcc 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -39,8 +39,8 @@ default_fd_limit=$(ulimit -Sn)
 min_fd_limit=$(($(getconf _NPROCESSORS_ONLN) * 16))
 
 cleanup() {
-  rm -f "${perfdata}"
-  rm -f "${perfdata}".old
+  rm -rf "${perfdata}"
+  rm -rf "${perfdata}".old
   rm -f "${script_output}"
   perf_record_cleanup
 
-- 
2.56.0.rc1.310.g51773c2048-goog

