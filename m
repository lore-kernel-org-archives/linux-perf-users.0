Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF96171AF;
	Sat, 11 Jul 2026 00:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783728262; cv=none; b=ols149J7XnxsgBqJGlkf64q8gFdJ60F06mOSK96NhLohgY39b5I03D/koKFv3KQ+cdllYHyjARRgOzSi9VHsWpmQrJ9tkhEYWUaahgJUdWqq0m8qCwFqS0Zwl4HNsaRzwNNC44IRzWcomFwXYTJ5u4HKVWOKEVI3IE6u/aobQUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783728262; c=relaxed/simple;
	bh=t0zCdJPCY0umKlabiK4k//u874o+EtTpNNaRW/V8txY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7ND/oMu5AyhKr61O0p4dKz7VMvLog2aq4V8e/n77+C01sevZzsrP3zj9NRzt63jmoSB+aETiWzH+Sx27efbZO3Yftt3zKy8Fc7aQtCJ07gSgIEZ3tMkBP3+03qYMBCy92rADFzmOr3mkpotL8RzPaYhC18/3XFFFURUBVGS0T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KR02H16U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KR02H16U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF05E1F00A3F;
	Sat, 11 Jul 2026 00:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783728261;
	bh=///HlrNtKGOHMcGboCUDcGbIyE6v6Cl86N7NMA5FY+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KR02H16U83bvA6O5+/ghzuhNDQxZdRSi4Lzml1d3+WbZJsX2Yz1JAVBY6OIfF9Cj0
	 4lglWylK5Vv9AP074upA1243ZIUpEJLmR45XSPkTGB/CCp7vy1Z9o2CSA1GiHnGh8T
	 0A9HoWeX/+1DXLWWVt8LvuKNIz20volYnO7Z2jmeRTSA/TiSF3GOhSTHj4s4HdKuH/
	 qIk98n1W7Cjhr2LRlDp7OwDaduaODuxHFkQikBMK0NUA3CQZbt0pXQIslnNodKbbWs
	 7vD8pwM0kkbpobqXpM4TmKJIDDSWoDvnqonVr3WoyHqZY8W/Sc35PSOrvhawVEqTwt
	 c8PBfrmwXByiA==
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
Subject: [PATCH v3 4/4] perf test: Update test for --for-each-cgroup option
Date: Fri, 10 Jul 2026 17:04:19 -0700
Message-ID: <20260711000419.1949161-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260711000419.1949161-1-namhyung@kernel.org>
References: <20260711000419.1949161-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To simply check the number of output lines with and without the option.

Before this series, it failed like below:

  $ perf test -v 125
  125: perf stat --bpf-counters --for-each-cgroup test:
  ---- start ----
  test child forked, pid 1941516
  Normal output has 22 lines, but it now has 54
  ---- end(-1) ----
  125: perf stat --bpf-counters --for-each-cgroup test         : FAILED!

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v3 changes)
 * use default events and metrics  (Sashiko)
 * update the commit description

 tools/perf/tests/shell/stat_bpf_counters_cgrp.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
index ff2e06c408bc6be1..febe3af0644157f3 100755
--- a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
@@ -58,9 +58,24 @@ check_system_wide_counted()
 	fi
 }
 
+# Missing flags in evlist__clone() resulted in different output.
+# Just check the number of output lines for simple verification.
+check_evlist_expand()
+{
+	normal_output=$(perf stat -a -x, true 2>&1 | wc -l)
+	expand_output=$(perf stat -a -x, --bpf-counters --for-each-cgroup / true 2>&1 | wc -l)
+	if [ "${normal_output}" != "${expand_output}" ]; then
+		if [ "${verbose}" = "1" ]; then
+			echo "Normal output has ${normal_output} lines, but it now has ${expand_output}"
+		fi
+		exit 1
+	fi
+}
+
 check_bpf_counter
 find_cgroups
 
 check_system_wide_counted
+check_evlist_expand
 
 exit 0
-- 
2.55.0.795.g602f6c329a-goog

