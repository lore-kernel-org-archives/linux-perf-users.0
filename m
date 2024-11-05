Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D9076C61;
	Tue,  5 Nov 2024 05:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730784357; cv=none; b=oATurcbmxXgvBfgheFyoDb5hyvkwj4n/zieE+joeMy3ZNs30KhmfCcRSFoxgrXLzZ+r/b9yACJ9Qa9+9uLnLsDM1tni0VH7ClUKQjvKoOUYNi/H5fx87AtJR/xPcnh1KdNFsbd7vgDQvtg1WZ9AECS8MpYb7r+6wOo/s03Aezig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730784357; c=relaxed/simple;
	bh=Mm+fZahzjtAt05oPTf2ol5MxaqohzF9B19BPS25AXMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kzCvA/vXH+hbipAC+wX3fLh5IrwLtfVe2u7C5PXuYdGIeDEugzLbCQg4X/1uht3wTkhAsSCoaGuBkCYFXNgedoKr5SfkJqjV6Bjs9ZoxQwva3drxrSorUiaONQBwXdu7T/uPO6uzAniyLtdMPfV2I3VgNhKygdVAmhOnC5ST6n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XoA7ggLs; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XoA7ggLs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=DFv3e
	ZrYxuDxMVSrDe8nMHgcYuyOHJe7Z8E9ycfSa6A=; b=XoA7ggLsrGsqgSkAlhIul
	s5/pzPpcnMfgXlwKTVgxhHLz68tdaJpyusyjpJfszvKbyQ6jWvEmo5IqmYAlIKpW
	PnHYfKX+N8En+viTZ8NaZ+bEeejWfTMEAsdTRtB08SElxd3vSpKo/wFXYkTH7TsN
	XXbFgWK+cpV5sDYS+T4fiE=
Received: from localhost.localdomain (unknown [114.86.104.95])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDXnxcRrClnHzxmDQ--.3311S2;
	Tue, 05 Nov 2024 13:24:34 +0800 (CST)
From: Haiyue Wang <haiyuewa@163.com>
To: linux-perf-users@vger.kernel.org
Cc: Haiyue Wang <haiyuewa@163.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH v1] perf tools: Add the empty-pmu-events build to .gitignore
Date: Tue,  5 Nov 2024 13:24:05 +0800
Message-ID: <20241105052409.7783-1-haiyuewa@163.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXnxcRrClnHzxmDQ--.3311S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrWDJFy8JryfAw4fCF48WFg_yoWfGwb_Kw
	4xGrWv9FWrtrnYyrWxCF45Ar4Fqa15A3s8JFW7tF1rA3yUGa4j9as0yrZrA3yrGay7Gw12
	kwn8Gr18XFWxujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbwvtJUUUUU==
X-CM-SenderInfo: 5kdl53xhzdqiywtou0bp/1tbiYAKNa2coDJX2FgABsz

The commit 0fe881f10ceb ("perf jevents: Autogenerate empty-pmu-events.c")
build will generate two files, add them to .gitignore:

	tools/perf/pmu-events/empty-pmu-events.log
	tools/perf/pmu-events/test-empty-pmu-events.c

Signed-off-by: Haiyue Wang <haiyuewa@163.com>
---
 tools/perf/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index f5b81d439387..51713b655f62 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -39,6 +39,8 @@ trace/beauty/generated/
 pmu-events/pmu-events.c
 pmu-events/jevents
 pmu-events/metric_test.log
+pmu-events/empty-pmu-events.log
+pmu-events/test-empty-pmu-events.c
 tests/shell/*.shellcheck_log
 tests/shell/coresight/*.shellcheck_log
 tests/shell/lib/*.shellcheck_log
-- 
2.47.0

