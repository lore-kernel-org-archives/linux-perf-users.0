Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1259F1B87F3;
	Sat,  1 Mar 2025 04:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740801776; cv=none; b=C53VMjP/LNmyL0ER0R7evhoDIazv9RtO1BG7VPxb7AAkZQ9Eqcs313379NWuCLCEcwXdaQeCW+jSdG7eks/XX84c4kduExql4gYwZ0bpjhgJtv2H2aJKgHuydZycadoHUAQokkjX/WQYj8K53of4OFRt+gmWxFgHxE6XXajxYeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740801776; c=relaxed/simple;
	bh=4e5iV1jyt44+vFhgI8mzweFLermL3m37/dLdNcU2d2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAIwpRUFAp1+QWD0YUabbOKeu4uImJTbQPpQOhX8RNhql8xydbt73jDOXiSYjB+LeKElGYACdutqZG3ISKKErIYDx8RzzBxVbKT7o3HhsHTaufjOf5CZWrwcYetqkEPx42YMB574zNheUJsBFexjYvY4AKwH4SKPapRtqL7jeLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvOz6dOT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvOz6dOT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B26C4CEE6;
	Sat,  1 Mar 2025 04:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740801775;
	bh=4e5iV1jyt44+vFhgI8mzweFLermL3m37/dLdNcU2d2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OvOz6dOTQ7658+ndf+zgKMBRg26gYWGlCgFa3qPI7oWrsAvt96aGx2ljvuqP7vr95
	 sBkdEfzb1Vr6VqLD6CNEm5mT0kO9bsWPtCNfsGWjUr7vr5iemk+ssjPZ/iD+q1eI1u
	 Ji4nTlf1yUeGDXrzpktp/snr1mv60r1t/Wxxbe8BSx+NtlMivkRInY7DA7w1cVseCI
	 BkCg+rk10b/cMm0MQ2K8fUSrhqozij5HxSamDzatWpvojEEEem3pN9CT2xUAX6iacL
	 ntkhj0svisdIfDUaZJpIE1ZeZfFvdHAJ2VTgrGx9MP8AdZfAGLRApNSSIf+p5wuhib
	 TamHgA0vIVpgw==
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
Subject: [PATCH 4/4] perf test: Add trace record and replay test
Date: Fri, 28 Feb 2025 20:02:52 -0800
Message-ID: <20250301040252.1586750-5-namhyung@kernel.org>
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

It just check trace record and replay could display correct output.
It uses 'sleep' process and sees there's a clock_nanosleep syscall.

  $ sudo perf test -vv replay
  108: perf trace record and replay:
  --- start ---
  test child forked, pid 1563219
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.077 MB /tmp/temporary_file.w1ApA (242 samples) ]
       0.686 (1000.068 ms): sleep/1563226 clock_nanosleep(rqtp: 0x7ffc20ffee10, rmtp: 0x7ffc20ffee50)           = 0
  ---- end(0) ----
  108: perf trace record and replay                                    : Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/trace_record_replay.sh | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100755 tools/perf/tests/shell/trace_record_replay.sh

diff --git a/tools/perf/tests/shell/trace_record_replay.sh b/tools/perf/tests/shell/trace_record_replay.sh
new file mode 100755
index 0000000000000000..f948a84072b7a9b1
--- /dev/null
+++ b/tools/perf/tests/shell/trace_record_replay.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+# perf trace record and replay
+# SPDX-License-Identifier: GPL-2.0
+
+# Check that perf trace works with record and replay
+
+# shellcheck source=lib/probe.sh
+. "$(dirname $0)"/lib/probe.sh
+
+skip_if_no_perf_trace || exit 2
+[ "$(id -u)" == 0 ] || exit 2
+
+file=$(mktemp /tmp/temporary_file.XXXXX)
+
+perf trace record -o ${file} sleep 1 || exit 1
+if ! perf trace -i ${file} 2>&1 | grep nanosleep; then
+	echo "Failed: cannot find *nanosleep syscall"
+	exit 1
+fi
+
+rm -f ${file}
-- 
2.48.1.711.g2feabab25a-goog

