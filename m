Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A071DE881;
	Fri,  8 Nov 2024 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731061103; cv=none; b=WBfEBPVoViqVY3Ovhl3gPZ+sBykC0XbYuXr2wSCYNp/+s4n82OyY/ofpq+OtvG/kvsUL+M1mIGz9RzDM70B1x7LUqhBAuFFhgHG+gYDDRZA89XzYC7KalVwLyEJ9HLocSJ8xMK6gFExEjMkFfmigxDpecjoNe+wj7oJoFHWabbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731061103; c=relaxed/simple;
	bh=4v5TKhSzBBnC6/K4f+3mQQfoPYMmTVWAUa33QflKjpM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OtdTeNGjkMl6BHghe0t7Eg+WD3X6lQwERyUJLvulOeKy1rdC4uQRky5Mwu1eo+FXN2qVMSru4gVtGOZXHfxRdPE8qFrmY08mdpyLtFTscWaJzF1WK9jE9ACkvwKsDN6982rDO+VXlPfIy9/+8w//jhdxedDmGaOV+14Au4kZN2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XlFH15SGCzQs0k;
	Fri,  8 Nov 2024 18:17:01 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 1094B1400DC;
	Fri,  8 Nov 2024 18:18:11 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Nov 2024 18:18:10 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <mhiramat@kernel.org>, <acme@kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <dima@secretsauce.net>,
	<aleksander.lobakin@intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lihuafei1@huawei.com>
Subject: [PATCH 1/2] perf probe: Reset old content before processing the next event string
Date: Sat, 9 Nov 2024 02:19:08 +0800
Message-ID: <20241108181909.3515716-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

To fix this, in the loop that parses the rawlist, reset the contents of
'tev' and 'pev' to ensure it does not affect the next parsing.

After the modification,  'perf probe -l' shows the following:

  # perf probe -l
    probe:schedule       (on schedule+8@kernel/sched/core.c)
    probe:schedule_1     (on schedule:-6751@kernel/sched/core.c)

Note that 'probe:schedule_1' is displayed with line number, but the line
number seem to be incorrect. This issue is independent of the problem
fixed by the current patch and will be addressed in the next patch.

Fixes: d8f9da240495 ("perf tools: Use zfree() where applicable")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 tools/perf/util/probe-event.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a17c9b8a7a79..ec0b11f8d881 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2695,6 +2695,8 @@ static int __show_perf_probe_events(int fd, bool is_kprobe,
 next:
 		clear_perf_probe_event(&pev);
 		clear_probe_trace_event(&tev);
+		memset(&tev, 0, sizeof(tev));
+		memset(&pev, 0, sizeof(pev));
 		if (ret < 0)
 			break;
 	}
-- 
2.25.1

