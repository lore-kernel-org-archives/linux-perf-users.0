Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C6A33A70E
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621492; cv=none; b=UfhhMyp6V/3ScrPOhmEVraen5aAJLsswNwSz8gm+MZVTK1pBtNRLEOB5VxWoTsUXNcZE8Iumr//dXudFkM+Id+r2oYmQa8J6ekyUncvM29esFE4ymrf+WTl1OoJknUgvQTBxmatoO1jPMOW+yOU59/D0ErLTs6Y2BEQUEsBZtiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621492; c=relaxed/simple;
	bh=zoC1/c9+WvVSVLsjHXXqOJOvAPqRgs/hMu+estlqjkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cz0kKGE/LXAIec8Lwg2v8KHfyQrkT++lxK+g9yNaGE9XKw9ndDR7aa/z0kRT8nMgoTgAEtU4G1mhYTt+GYB/guxvfwN3gNkO6VfTz8DHJXOenjm0PmZYpEwS3LnOKt1DbMZ4oL4rvlmCNNQuO0k7ldpTLsqQX42dyP55I/H3Z/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HC7Crh5Q; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HC7Crh5Q"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 698E02008;
	Tue, 16 Jun 2026 07:51:23 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A28F3F915;
	Tue, 16 Jun 2026 07:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781621488; bh=zoC1/c9+WvVSVLsjHXXqOJOvAPqRgs/hMu+estlqjkU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HC7Crh5QHOE5GBKzwcAg5yHNHh4t1gZd9vuAR+1GhwR7PeG5VyKPks3uTBhfkIBmY
	 QVzCILU2aW4UFsG+3pDSaA2XzVnaLX/CeBXGoSGF515QBICIX4+PEwxunuko+e75M5
	 BonRGv/ZP6UHDlhY2BGvF8/d6Q2uEDLEhJcG9g6k=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 16 Jun 2026 15:51:09 +0100
Subject: [PATCH v9 1/9] perf cs-etm: Fix thread leaks on trace queue init
 failure
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-b4-arm_cs_callchain_support_v1-v9-1-f8fad931c413@arm.com>
References: <20260616-b4-arm_cs_callchain_support_v1-v9-0-f8fad931c413@arm.com>
In-Reply-To: <20260616-b4-arm_cs_callchain_support_v1-v9-0-f8fad931c413@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>, 
 Paschalis Mpeis <paschalis.mpeis@arm.com>, Amir Ayupov <aaupov@fb.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781621481; l=1380;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=zoC1/c9+WvVSVLsjHXXqOJOvAPqRgs/hMu+estlqjkU=;
 b=6MYTtSNDXguRtLAOhXEAoQkso5XmF1yaDeXIfVKys/VA8U6xPRt3APnu4eIF4p9z4du9GL+6u
 HOdWZ1FWC89DGtyHb/8ROfU29MPoiWf4gj2baJBWpd56mii3Owq0fup
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

cs_etm__init_traceid_queue() allocates the frontend and decode threads,
if a later allocation fails, the error path does not drop thread
reference that was already acquired.

Release both thread pointers with thread__zput() on the error path, so
does not leak thread references or leave stale pointers behind.

Fixes: 951ccccdc715 ("perf cs-etm: Only track threads instead of PID and TIDs")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 0927b0b9c06b15046afeafe23fe170b8248cfcc6..d484a6155c2c22fa916d0365987302f6bb9978e9 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -627,6 +627,8 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 					       queue->tid);
 	tidq->decode_thread = machine__findnew_thread(&etm->session->machines.host, -1,
 					       queue->tid);
+	if (!tidq->frontend_thread || !tidq->decode_thread)
+		goto out;
 
 	tidq->packet = zalloc(sizeof(struct cs_etm_packet));
 	if (!tidq->packet)
@@ -661,6 +663,8 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 	zfree(&tidq->prev_packet);
 	zfree(&tidq->packet);
 out:
+	thread__zput(tidq->frontend_thread);
+	thread__zput(tidq->decode_thread);
 	return rc;
 }
 

-- 
2.34.1

