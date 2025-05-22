Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3FA1F09B3;
	Thu, 22 May 2025 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747923954; cv=none; b=oTcxJMjaGwvQYuCwegQOzyRFxycn8VpT4x6G6Gi4rQvg2wmEbqnpkosmfehInb8+YqWdo/fXjGzUdCq1zbygp5UTObQKYUgKhyXjF9+J99rBYxcdikadUGwMfcKSWKWMCbP43GW/B4NO6WMMNIzZDGkJhJNPXkYkb4toSbe0pJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747923954; c=relaxed/simple;
	bh=1eJ9J765R5tyRsXLnm+TwMNSyo0VRZ0U8HpB0OhgEQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RcuSw9qqAJypBcEqSAHvIMIicCprlctQHqzb8981mppJIbdZobIrueS66SJ8r8iwSy2j4ICwEiHWcYcNAyxmGi90oI9vchX27v2vZunl5AJxKkS/ogsqCtNmev8hPBs8qbDMGoT5FuQVXlRQXB7P/xytbLqejpRi3VbzhgsjpTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueuw+7fH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueuw+7fH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5479EC4CEF0;
	Thu, 22 May 2025 14:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747923953;
	bh=1eJ9J765R5tyRsXLnm+TwMNSyo0VRZ0U8HpB0OhgEQE=;
	h=From:To:Cc:Subject:Date:From;
	b=ueuw+7fHs0dS7a/yEQcIsgOMNq4LX09kX86tfOAkTZpvDIfAypLnM0gR6OktsOuSR
	 qSfWlKFXxIiyTHHqT10h4r2tiQwrIf0K+vpEtszrDYvOex6zGe1Tg9ktCCBLTfO9UC
	 DXdbqgeN54V3pAlso0Yl7xncs4WgDsmEE8ET1+DNkINMJ3vF23hmL0S1D0V3gV5pjX
	 kBNM/MFu57+hNW6te2UoU3zGoYFJOIVeHBgQdLRkYNQp24SjgsuOsCXp2rP5xjqes7
	 B0bitUqfdSrQAQdUyVOIQWNmcTSPwMv10MrDfr5gEDoeGnY6re89yWh8ilmFFVV47X
	 gECAU5uHy9KzQ==
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
Subject: [PATCH] perf test: Add cgroup summary test case for perf trace
Date: Thu, 22 May 2025 07:25:51 -0700
Message-ID: <20250522142551.1062417-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.1164.gab81da1b16-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  $ sudo ./perf test -vv 112
  112: perf trace summary:
  --- start ---
  test child forked, pid 1018940
  testing: perf trace -s -- true
  testing: perf trace -S -- true
  testing: perf trace -s --summary-mode=thread -- true
  testing: perf trace -S --summary-mode=total -- true
  testing: perf trace -as --summary-mode=thread --no-bpf-summary -- true
  testing: perf trace -as --summary-mode=total --no-bpf-summary -- true
  testing: perf trace -as --summary-mode=thread --bpf-summary -- true
  testing: perf trace -as --summary-mode=total --bpf-summary -- true
  testing: perf trace -aS --summary-mode=total --bpf-summary -- true
  testing: perf trace -as --summary-mode=cgroup --bpf-summary -- true
  testing: perf trace -aS --summary-mode=cgroup --bpf-summary -- true
  ---- end(0) ----
  112: perf trace summary                                              : Ok

Cc: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/trace_summary.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/trace_summary.sh b/tools/perf/tests/shell/trace_summary.sh
index 4d98cb212dd9de0b..bb350dfabdc2bf5e 100755
--- a/tools/perf/tests/shell/trace_summary.sh
+++ b/tools/perf/tests/shell/trace_summary.sh
@@ -62,4 +62,10 @@ test_perf_trace "-as --summary-mode=total --bpf-summary"
 # summary with normal output for system wide - total summary mode with BPF
 test_perf_trace "-aS --summary-mode=total --bpf-summary"
 
+# summary only for system wide - cgroup summary mode with BPF
+test_perf_trace "-as --summary-mode=cgroup --bpf-summary"
+
+# summary with normal output for system wide - cgroup summary mode with BPF
+test_perf_trace "-aS --summary-mode=cgroup --bpf-summary"
+
 rm -f ${OUTPUT}
-- 
2.49.0.1164.gab81da1b16-goog

