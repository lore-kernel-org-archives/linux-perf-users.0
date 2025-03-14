Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C07F510
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Mar 2025 03:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741921282; cv=none; b=YRKQar5Y5rg4yaj5OLk5mVOIVm1X5uGnmDG17LphUjWKlARfjUxABtx7lFFQsWnQk8X1qG4mvHuA1syPgvFmQBhkWbt2m9lfyAYfyGzOQt1bTf3tFr8chCHA2KrhhfXbxsNjHQaNbBBn8MJRjVs0pgd2UZY6pFjhFwnYhCwa+l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741921282; c=relaxed/simple;
	bh=OVSXdn/stpqtpu4N4hx38/r4z7BrOycAmkDikymqOv0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Oq3QkckLgkreLjwr29LVS4MCdzgkMmA2FY23c/hhqq6KpncMv0ADq6O1etkwrUSvqi1KWotU1E7APO0llDs/xummzkMlJgYek5hrksoiDTIHbb8q7zy6vXNMG3T8WepeYOFC3t1g1eTizoH/rH/T0mjOG3/bxS+ptfWA7D54Lr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fNp/Onr+; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fNp/Onr+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741921268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ddR8PbHunJyeTeHkWYEZbpc6P3czHJwK0VLQdq1QbFQ=;
	b=fNp/Onr+uFnhbtZEwrh/PT51whjc6k3oCPRsPIjAvLsXyeyYhyeGR9hE2ogBh+poixemQl
	ve4UoO496/8n7CajD90O3h1vlSCKATtliR80xeEe8ivx+hqQQNavQE6luQ/7/FMlBMy0/x
	P+Ytho8tSYNKgySaQM7mCFdFJcVO3fQ=
From: Tao Chen <chen.dylane@linux.dev>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	fweisbec@gmail.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH linux-next v2] perf/ring_buffer: Add EPOLLRDNORM flag for poll
Date: Fri, 14 Mar 2025 11:00:36 +0800
Message-Id: <20250314030036.2543180-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The poll man page says POLLRDNORM is equivalent to POLLIN. For poll,
it seems that if user sets pollfd with POLLRDNORM in userspace, perf_poll
will not return until timeout even if perf_output_wakeup called, whereas POLLIN
returns.

Fixes: 76369139ceb9 ("perf: Split up buffer handling from core code")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/events/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Change list:
- v1 -> v2:
    - add changelog
- v1
  https://lore.kernel.org/all/20250313051047.2436098-1-chen.dylane@linux.dev

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 59a52b1a1..5130b119d 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -19,7 +19,7 @@
 
 static void perf_output_wakeup(struct perf_output_handle *handle)
 {
-	atomic_set(&handle->rb->poll, EPOLLIN);
+	atomic_set(&handle->rb->poll, EPOLLIN | EPOLLRDNORM);
 
 	handle->event->pending_wakeup = 1;
 
-- 
2.43.0

