Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124F91B87E9;
	Sat,  1 Mar 2025 04:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740801776; cv=none; b=X/binHy4MgBGSQ1RT9JdIeLaPQyei/2R0Z8En82D3xURTM14MwlSeVLqajkd6zh75QdJP5B7fMCAnJP7lfekLn/8Mn1djjv62C00a5RJf1YXNa1ha02WYvsMt8TKx67Sg/ozZM2ILIIWLNlT24dOuCrFKvY+wCh5928ZLIhMZnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740801776; c=relaxed/simple;
	bh=/tAtFCekLIQIOE0oqyYQAhRFugV1278wNpYABUitf9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3DlhHQufexyf4xsKOYjPizR2kt+j5S7z+yd5NE8hScHtnadyDJlabWGnFBHmOUa0GPWFMTXO+zQQCs74WsYpj3txUSK/2Ykok/pGzpSJL+UVXhbp10OT1PIyOVaHPn1DhFP8RCStJU/VLCZtVeusheobgz8e+dXkSw/WQ+NoZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+pGHfc2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+pGHfc2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3176C4CEE8;
	Sat,  1 Mar 2025 04:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740801775;
	bh=/tAtFCekLIQIOE0oqyYQAhRFugV1278wNpYABUitf9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b+pGHfc28PCHUQ9VXq+WMysfU83hlI35Ph2xFfugTpJrNqm8GjS11luxp/3ZwnJsg
	 dL+QbPqctyZUKFkE0SyVg+x6h4jB6SGFRwh391bjlfK4C21jNLcQ913ydQZkiOvHSH
	 5++JUjGj2dyAheI/7IktT/+qOh82USVxoL9ADUcifyPO7EC+fBGuZBeQ4ezoF2wvXN
	 QYfVYN6SLYpAnHh7Hy3Gow/V/kDmYJbP/8Yv0brmDCgbBKLR//xw2DBW/kJ7LWCRA0
	 M/zTHJPLf2qD8TCBE+FrOfZb6HtvcHm5LSRRCnN4MAHYEA8RZ5gyJWZ4Sdw3m6vPIw
	 ZJVn6m5Qp0fqQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 3/4] perf test: Skip perf trace tests when running as non-root
Date: Fri, 28 Feb 2025 20:02:51 -0800
Message-ID: <20250301040252.1586750-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250301040252.1586750-1-namhyung@kernel.org>
References: <20250301040252.1586750-1-namhyung@kernel.org>
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

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/trace+probe_vfs_getname.sh | 1 +
 tools/perf/tests/shell/trace_btf_enum.sh          | 1 +
 tools/perf/tests/shell/trace_btf_general.sh       | 1 +
 tools/perf/tests/shell/trace_exit_race.sh         | 1 +
 4 files changed, 4 insertions(+)

diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 708a13f006353611..cd64408043ccc89f 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -15,6 +15,7 @@
 
 skip_if_no_perf_probe || exit 2
 skip_if_no_perf_trace || exit 2
+[ "$(id -u)" == 0 ] || exit 2
 
 . "$(dirname $0)"/lib/probe_vfs_getname.sh
 
diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
index 8d1e6bbeac906843..02da49af1f4ec71f 100755
--- a/tools/perf/tests/shell/trace_btf_enum.sh
+++ b/tools/perf/tests/shell/trace_btf_enum.sh
@@ -13,6 +13,7 @@ TESTPROG="perf test -w landlock"
 # shellcheck source=lib/probe.sh
 . "$(dirname $0)"/lib/probe.sh
 skip_if_no_perf_trace || exit 2
+[ "$(id -u)" == 0 ] || exit 2
 
 check_vmlinux() {
   echo "Checking if vmlinux exists"
diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
index e9ee727f3433eaba..a89dc4a6cfd1b1a5 100755
--- a/tools/perf/tests/shell/trace_btf_general.sh
+++ b/tools/perf/tests/shell/trace_btf_general.sh
@@ -76,6 +76,7 @@ trace_config() {
 
 skip_if_no_perf_trace || exit 2
 check_vmlinux || exit 2
+[ "$(id -u)" == 0 ] || exit 2
 
 trace_config
 
diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf/tests/shell/trace_exit_race.sh
index fbb0adc33a889516..7187ebc16c96b5ee 100755
--- a/tools/perf/tests/shell/trace_exit_race.sh
+++ b/tools/perf/tests/shell/trace_exit_race.sh
@@ -10,6 +10,7 @@
 . "$(dirname $0)"/lib/probe.sh
 
 skip_if_no_perf_trace || exit 2
+[ "$(id -u)" == 0 ] || exit 2
 
 if [ "$1" = "-v" ]; then
 	verbose="1"
-- 
2.48.1.711.g2feabab25a-goog

