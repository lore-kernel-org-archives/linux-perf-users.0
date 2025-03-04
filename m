Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755AE1C9EB1;
	Tue,  4 Mar 2025 02:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741055320; cv=none; b=qDTZiZ9BIrqadpKg1cgkHzVzl2mMZd1XhRdwTrVmkeCDQ/4MTw84g7KPx41s78LM6FJ5WPh3yknvRXYEJlzE/pPLUgBru5EZPj9h3MqOC41qMSSu2QleG21hXNdcWWeH88vt6fAaPwcFfjfgcvgMVB7zIGYRcSdnecOzIwQK3ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741055320; c=relaxed/simple;
	bh=2+lUnkmbSZWMXynR8WLp8OihqPqjBEgZ2igI4ntPbQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4KCSAKC+vAgSKlif4cfqvx4PdVYeEvy8VzY6eeTKo0xu8nNLhDQCN1XbGDOUpfeSgI16Apt+faPbChUg6n9JEliLN49DJMoufXj5BXpaJ8kMhhSEZTvbv1ctN1pAiGJJppbx5Aepk+cZMW2GPlIpQv4URsXqlLTRyBtcVZe4yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEE2O4Ei; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEE2O4Ei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE1AC4CEE4;
	Tue,  4 Mar 2025 02:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741055320;
	bh=2+lUnkmbSZWMXynR8WLp8OihqPqjBEgZ2igI4ntPbQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YEE2O4Ei5bxGyEniOApmULtTbP8YS5/DcDg/ZZ5rpCbuvJPKwN1Wd3psb1DYwpaqJ
	 M4W3K1lcEFi7Wb/qrEIILqixyyJ7qYu0Yyc9em/IfVAAVqN2lyMl/xBHtMmH4PIvhL
	 o9D15xvYxcJ1tBcxyxsgS35hBCkAh5mJS3wJ0/DsYidtwra4noCdih1IQHpPH7dZzQ
	 8ZNzs046WO07MClq6jitU2YIZIg3SQXWYcqYAJoKcNp2hyDX1zLH6iY1eV5Ppff9Cr
	 F17RA7M17nEkGPJphgqC5G7YodF8wl4SO9vUm0v6JnV5G1PwOWbz730qKO7+uosPRt
	 voJQuVamPMRLw==
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
Subject: [PATCH v2 4/6] perf test: Add trace record and replay test
Date: Mon,  3 Mar 2025 18:28:35 -0800
Message-ID: <20250304022837.1877845-5-namhyung@kernel.org>
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

Cc: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/trace_record_replay.sh | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100755 tools/perf/tests/shell/trace_record_replay.sh

diff --git a/tools/perf/tests/shell/trace_record_replay.sh b/tools/perf/tests/shell/trace_record_replay.sh
new file mode 100755
index 0000000000000000..6b4ed863c1ef8679
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
+[ "$(id -u)" = 0 ] || exit 2
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

