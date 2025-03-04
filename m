Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AC51B6CE3;
	Tue,  4 Mar 2025 02:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741055320; cv=none; b=htMTcuGFclLaK2mcPVSLZ0br8tPfqIvDtrRue4p/ye1hGvVCnScu4iRMgDIVQdDVHbGePDwN1Zr4/LDjYWGuT8yEpZxk6Q3hVkETZWniNNhjsuRG4JZMT95so6blW+YIUFQlabebeoEHCqWrfUT1mAqRYRetpjY9AFwPMlUNbxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741055320; c=relaxed/simple;
	bh=v/m0g5WAqn0xy20K/5YA8hgY9gL9rBWO0n5tLPllelU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKWOleH/Jy4djkFbbGuczFixzRR4i0tHDyfF5E6cBgxBOEk/4UbQvBNOf445L/mJD4dBZwYrzI1BRUdb6uRGAA11FPONkh+uM/JuUM+BGyg69Pb5q+j+XVuLxUsy7V3npM46zMc1t3cfZMoF1oYv6gCrYVSiPtp+4IZte7CuXBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z67uQwUS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z67uQwUS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DC9C4CEE8;
	Tue,  4 Mar 2025 02:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741055319;
	bh=v/m0g5WAqn0xy20K/5YA8hgY9gL9rBWO0n5tLPllelU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z67uQwUStvTTTUz9xHh4XU1nlQVVxEd/7qnrrFb+8mR4YlauK3j2uQ9A/aQhDyvZV
	 txH4bYRRSZGQ9q0HUppvSjMBEwYST+eC8K34ywcIk27nwblhAUbHZt5i/8kuTHCDXK
	 1PrTQebPnviHaUwWrs1izLzhWf/feveFeL2obV6DAsNoP+m9HRi8lxN8HyJKU4m4xs
	 y7zUghTjGRj6cZpmvp2WuiRPr2Epzy9qVraggvRyfQxcMBRMxjjt9Rq/W7fePXD91p
	 AR1GtU2YxmbFUsz+d0hXSbgCw0MIlPT/8mO7vDX4s1YF+a0Wms1bw6Zo0bbJlYTUnB
	 EX/fx0lRPLnhQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v2 3/6] perf test: Skip perf trace tests when running as non-root
Date: Mon,  3 Mar 2025 18:28:34 -0800
Message-ID: <20250304022837.1877845-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250304022837.1877845-1-namhyung@kernel.org>
References: <20250304022837.1877845-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf trace requires root because it needs to use tracepoints and BPF.
Skip those test when it's not run as root.

Before:
  $ perf test trace
   15: Parse sched tracepoints fields                                  : Skip (permissions)
   80: perf ftrace tests                                               : Skip
  105: perf trace enum augmentation tests                              : FAILED!
  106: perf trace BTF general tests                                    : FAILED!
  107: perf trace exit race                                            : FAILED!
  118: probe libc's inet_pton & backtrace it with ping                 : Skip
  125: Check Arm CoreSight trace data recording and synthesized samples: Skip
  127: Check Arm SPE trace data recording and synthesized samples      : Skip
  132: Check open filename arg using perf trace + vfs_getname          : FAILED!

After:
  $ perf test trace
   15: Parse sched tracepoints fields                                  : Skip (permissions)
   80: perf ftrace tests                                               : Skip
  105: perf trace enum augmentation tests                              : Skip
  106: perf trace BTF general tests                                    : Skip
  107: perf trace exit race                                            : Skip
  118: probe libc's inet_pton & backtrace it with ping                 : Skip
  125: Check Arm CoreSight trace data recording and synthesized samples: Skip
  127: Check Arm SPE trace data recording and synthesized samples      : Skip
  132: Check open filename arg using perf trace + vfs_getname          : Skip

Cc: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/trace+probe_vfs_getname.sh | 1 +
 tools/perf/tests/shell/trace_btf_enum.sh          | 1 +
 tools/perf/tests/shell/trace_btf_general.sh       | 1 +
 tools/perf/tests/shell/trace_exit_race.sh         | 1 +
 4 files changed, 4 insertions(+)

diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 708a13f006353611..60fccb62c5403ee9 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -15,6 +15,7 @@
 
 skip_if_no_perf_probe || exit 2
 skip_if_no_perf_trace || exit 2
+[ "$(id -u)" = 0 ] || exit 2
 
 . "$(dirname $0)"/lib/probe_vfs_getname.sh
 
diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
index 8d1e6bbeac906843..60b3fa254cf6c7bc 100755
--- a/tools/perf/tests/shell/trace_btf_enum.sh
+++ b/tools/perf/tests/shell/trace_btf_enum.sh
@@ -13,6 +13,7 @@ TESTPROG="perf test -w landlock"
 # shellcheck source=lib/probe.sh
 . "$(dirname $0)"/lib/probe.sh
 skip_if_no_perf_trace || exit 2
+[ "$(id -u)" = 0 ] || exit 2
 
 check_vmlinux() {
   echo "Checking if vmlinux exists"
diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
index e9ee727f3433eaba..a25d8744695e6fef 100755
--- a/tools/perf/tests/shell/trace_btf_general.sh
+++ b/tools/perf/tests/shell/trace_btf_general.sh
@@ -76,6 +76,7 @@ trace_config() {
 
 skip_if_no_perf_trace || exit 2
 check_vmlinux || exit 2
+[ "$(id -u)" = 0 ] || exit 2
 
 trace_config
 
diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf/tests/shell/trace_exit_race.sh
index fbb0adc33a889516..1e247693e756d439 100755
--- a/tools/perf/tests/shell/trace_exit_race.sh
+++ b/tools/perf/tests/shell/trace_exit_race.sh
@@ -10,6 +10,7 @@
 . "$(dirname $0)"/lib/probe.sh
 
 skip_if_no_perf_trace || exit 2
+[ "$(id -u)" = 0 ] || exit 2
 
 if [ "$1" = "-v" ]; then
 	verbose="1"
-- 
2.48.1.711.g2feabab25a-goog

