Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2661E47B7;
	Thu, 14 Nov 2024 02:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731552836; cv=none; b=jBTkeTIl+VAYT4qAu76pD85EMrYpRmv3Npsdx9ZVnFepZge7cxHmVn2mALyv/GRCAEphr1r1isDZFimvWCtCvofss34dERq1RtABPHjPRA5v7zz8EhQ+/rVkXIWt39FMEfK55VirMQ3HupXu3OjEI7tpisTinCYvUjt3BryWfu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731552836; c=relaxed/simple;
	bh=WDRkDkpMmqAR9S0KX5La2MDsQ7XXWKD6bIns0ecHREM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jLo9kh6gjKkbvg8XjE7OsMp2F95D3ZEWr/MjPDsbloGtX8lx74gjXfHuUuNZPJyvqzBxNHwi0A5FlwZTfWf4cCj8YFTFWHLatvskMB1dj0mX0hCB8CB/9YABBgLzNcJL16tMglw3xsecIu8ZojY+Bm6Z4CIoy5Yr7vpH46uvUD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Xpl6l64txz1T4kZ;
	Thu, 14 Nov 2024 10:51:59 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D1491A016C;
	Thu, 14 Nov 2024 10:53:51 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Nov 2024 10:53:50 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <mhiramat@kernel.org>, <acme@kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <dima@secretsauce.net>,
	<aleksander.lobakin@intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lihuafei1@huawei.com>
Subject: [PATCH v2] perf probe: Clear all structure fields in clear_perf_{probe, trace}_event()
Date: Thu, 14 Nov 2024 18:54:51 +0800
Message-ID: <20241114105451.90273-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf500004.china.huawei.com (7.202.181.242)

I added two probe events:

  # perf probe -f -a schedule+8
  Added new event:
    probe:schedule       (on schedule+8)

  You can now use it in all perf tools, such as:

          perf record -e probe:schedule -aR sleep 1

  # perf probe -f -a schedule+20
  Added new event:
    probe:schedule_1     (on schedule+20)

  You can now use it in all perf tools, such as:

          perf record -e probe:schedule_1 -aR sleep 1

However, 'perf probe -l' shows the same offset:

  # perf probe -l
    probe:schedule       (on schedule+8@kernel/sched/core.c)
    probe:schedule_1     (on schedule+8@kernel/sched/core.c)

__show_perf_probe_events() does not clean up the 'pev' content when
parsing the rawlist. If the 'pev->offset' is not set while processing
the next probe event string, the offset value of the previous event will
be used.  After adding debug information, it was found that indeed there
was line number information when processing 'probe:schedule_1', so the
offset was not set and used the offset from 'probe:schedule'.

To fix this, clear all the fields of the structures in
clear_perf_{probe, trace}_event(). not just the allocated fields.

Fixes: d8f9da240495 ("perf tools: Use zfree() where applicable")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
Changes in v2:
 - Do the cleanup in clear_perf_{probe, trace}_event().
 - Refine the subject and the commit log.

v1: https://lore.kernel.org/lkml/20241108181909.3515716-1-lihuafei1@huawei.com/
---
 tools/perf/util/probe-event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a17c9b8a7a79..47903bb56fc6 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2376,8 +2376,8 @@ void clear_perf_probe_event(struct perf_probe_event *pev)
 			field = next;
 		}
 	}
-	pev->nargs = 0;
 	zfree(&pev->args);
+	memset(pev, 0, sizeof(*pev));
 }
 
 #define strdup_or_goto(str, label)	\
@@ -2475,7 +2475,7 @@ void clear_probe_trace_event(struct probe_trace_event *tev)
 		}
 	}
 	zfree(&tev->args);
-	tev->nargs = 0;
+	memset(tev, 0, sizeof(*tev));
 }
 
 struct kprobe_blacklist_node {
-- 
2.25.1

