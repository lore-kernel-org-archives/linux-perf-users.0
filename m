Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8B11DF722;
	Wed,  6 Nov 2024 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895277; cv=none; b=tV5rYZO4PFClMi/Zs1KZMWrCS1GVG9GcHmKz3kT68UyAL/5VUHvilMq4hMopVsUpPnGEmsUtaRol9sBTUON0MuU5Gc/ZSU0CWpTZtDbmiDENHCkE7VSYzbqoPCT+4rW5m7P9O0+CwS7Yg40WpzJkc+/Ph3vbWdx33UziyafW15A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895277; c=relaxed/simple;
	bh=s+7ythMgvireZhHwMrelXrMJjMe+ZrPkY+vUjQgq9/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EOWvIBqRr2rhUnxretLdH1cxIbcsy3bi0zy52bWVkU+9YEOgPzJks55zYWVzm0dHqrPqLCUqPyFKWTMT4cO1beM/t0VIeZS197icKTAuxBF1EpTh7jPsA9966DfL33R2jIpbdpdXhZC1Zwk4RYTeW7nYLOC9bIKq/X5pNyKuBfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ObfifXCQ; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ObfifXCQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=WoFB7
	HdhzNakUB5i2S2RJjooXmmquq4KbFJkQtdU1wU=; b=ObfifXCQtdBwGSqO9om6S
	i9NcZqIvmxn2YhY0L1XPEvjY/bErqUP9gnhaLczkGSME+JgVxy5vroGLjRxR/hlU
	/9LqOhKTCG8U1KR4My88Iq5Mz4Ge0jnFyUK29Cf2Gy09/PJEkmoY9JcUf5CospCn
	rHih/McpEmuRnkbJ2JDNzQ=
Received: from localhost.localdomain (unknown [114.86.104.95])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD334deXStnf7GyFQ--.7977S2;
	Wed, 06 Nov 2024 20:13:19 +0800 (CST)
From: Haiyue Wang <haiyuewa@163.com>
To: linux-perf-users@vger.kernel.org
Cc: Haiyue Wang <haiyuewa@163.com>,
	Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH v2] perf tools: Add the empty-pmu-events build to .gitignore
Date: Wed,  6 Nov 2024 20:12:14 +0800
Message-ID: <20241106121254.2869-1-haiyuewa@163.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD334deXStnf7GyFQ--.7977S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrWDJFy8JryfAw4fCF48WFg_yoWfCrc_Kw
	4xWrWqvr45tr9YyrWxCF45Zr4Fqa1Yy3s8JrW7tF1rAayUG34j93Z0yrZrA3yrWa9rGw1j
	kwn8Gr18XFWxujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbF_MDUUUUU==
X-CM-SenderInfo: 5kdl53xhzdqiywtou0bp/1tbiLxmPa2crT6j3OQAAs3

The commit 0fe881f10ceb ("perf jevents: Autogenerate empty-pmu-events.c")
build will generate two files, add them to .gitignore:

	tools/perf/pmu-events/empty-pmu-events.log
	tools/perf/pmu-events/test-empty-pmu-events.c

Signed-off-by: Haiyue Wang <haiyuewa@163.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
v2: Rebase the perf-tools-next.git on branch 'perf-tools-next'
---
 tools/perf/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index 19ce1cd56f8c..5aaf73df6700 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -39,6 +39,8 @@ trace/beauty/generated/
 pmu-events/pmu-events.c
 pmu-events/jevents
 pmu-events/metric_test.log
+pmu-events/empty-pmu-events.log
+pmu-events/test-empty-pmu-events.c
 *.shellcheck_log
 feature/
 libapi/
-- 
2.47.0

