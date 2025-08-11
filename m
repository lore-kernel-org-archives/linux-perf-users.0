Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED232E8882
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Aug 2025 18:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936333; cv=none; b=myArvbHPXzI8hU6qDOVZBIQqJEUGRPUTbqDjfEUN3gzwUxa+8JeA59dOe+kNQOZAlvZmG3XIsb3F5C7BjNtPLZMFIKMpWZAEdj9laFhg5GMrKdvWtBcFMPgAXVNd+lGS5OqE86kPCMxOsejz4KnufzT2JbyvsiZ33CwiHyuHk6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936333; c=relaxed/simple;
	bh=C+7n0IjmcMmLKd/Szc/G9DbwWG0qsCK8b/b02dPy2Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RM5NhhIVDtKn9p2kCjLJ/D7Ai3KvMKozKaFe4P6rRE7DW3Te6C9tL2HFTlaTpGTm1UV0lhXasW+yKdP3m5ks1KxOiYlYo/Yj2mn3Rqic98XfKxKs6UFwvZBT0NmJFxeXI47CHWkF4mYR0ExwlncDPxDvLhB0KPXjhl+kxDgXZ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bpU6Vyj1; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bpU6Vyj1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754936329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TkTc44JI4zDg+YVIapfB2t3E3nAxyECO9is12fjWfMY=;
	b=bpU6Vyj1lUEZL2TLJkB7oz99xDoPEWP7o/yDjigqMYhVN9w+PPqSZIO+xycwi5rKdJIqYu
	uIbj+q1tyOPxYpBwKf9fsSawvDVfDkL8xcgYzBoX5Dwa5b85olWzcLrZ36g9s3jYBXk8WK
	Vun6dojR38lC69mp8Ynqw64mvCgRVyU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf/core: Replace memset(0) + strscpy() with strscpy_pad()
Date: Mon, 11 Aug 2025 20:18:03 +0200
Message-ID: <20250811181802.72970-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace memset(0) followed by strscpy() with strscpy_pad() to improve
perf_event_comm_event(). This avoids zeroing the memory before copying
the string and ensures the destination buffer is only written to once,
simplifying the code and improving efficiency.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Keep strlen() as we're not checking the return value of strscpy_pad()
  for string truncation
- Link to v1: https://lore.kernel.org/lkml/20250811091637.4492-2-thorsten.blum@linux.dev/
---
 kernel/events/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8060c2857bb2..414212b02d54 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8981,8 +8981,7 @@ static void perf_event_comm_event(struct perf_comm_event *comm_event)
 	char comm[TASK_COMM_LEN];
 	unsigned int size;
 
-	memset(comm, 0, sizeof(comm));
-	strscpy(comm, comm_event->task->comm);
+	strscpy_pad(comm, comm_event->task->comm);
 	size = ALIGN(strlen(comm)+1, sizeof(u64));
 
 	comm_event->comm = comm;
-- 
2.50.1

