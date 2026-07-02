Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08681250BF2
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Jul 2026 19:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783021927; cv=none; b=YRIfjHfSt9lWFhOpF7z8N7a3fDD2XfzlZjEd9pLnMsuJJN6LNyydIXn/S3wuPtfQzN1vdgud5ATxpRO2inov0ENKCqtJz3k2hIYCpPtH27QWHhI18S+QUT4A4aDWhmopgyizc9/DtASJmdpQCgS70GzWHNQEDMJHgewQIbZ7Xs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783021927; c=relaxed/simple;
	bh=y002zKxyZB0uXe6NnnbJmRPydE3S8YZiuy6SoqsWzTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rkaT21QXqcbLosZgqw2Xli2qezgfSbAntdT8peVXdlIJh3cZzrKnaXf1QAkXUMhJEExG3zfUi2+9ExlWgjmod3GbAFJzmBl9w3ybLE0FSGexWbiNfx4i8Ml7BHJCoGJ+5mzN+gYOJVkQ24a0vL7npI9fW+NBxyNGHDgeDvxY6oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jRjjvEha; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jRjjvEha"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03C6235B7;
	Thu,  2 Jul 2026 12:52:01 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72BFA3F673;
	Thu,  2 Jul 2026 12:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783021925; bh=y002zKxyZB0uXe6NnnbJmRPydE3S8YZiuy6SoqsWzTc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jRjjvEhacZ44t2JA5R6t1xXtRZk3PYY1jrubF29h6YqDb8q9vt0/lIbrAKJjNXkU2
	 CJ/Vh5l6P3mIxrSbtY+FzvaZzZ/wJCaIeFZc5TPRVbRG74/3eYhugLipIVHpersgH6
	 KJ+YqAYLIqppHGq5Zq9LEKc0JtzwG7IqRQY7srSg=
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 02 Jul 2026 20:51:36 +0100
Subject: [PATCH v11 1/9] perf cs-etm: Fix thread leaks on trace queue init
 failure
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-arm_cs_callchain_support_v1-v11-1-846abbf600d7@arm.com>
References: <20260702-b4-arm_cs_callchain_support_v1-v11-0-846abbf600d7@arm.com>
In-Reply-To: <20260702-b4-arm_cs_callchain_support_v1-v11-0-846abbf600d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783021918; l=1431;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=y002zKxyZB0uXe6NnnbJmRPydE3S8YZiuy6SoqsWzTc=;
 b=Z/BvdumWWPfxasbe4TeuHwYB0CKly+wYh4/2TbuBf1kcNwPxa3dM9szZ9bzaILVX9LSqDspw0
 D82Gg2aHk5ND33J8ikZw9LUmbcW/AvFW+LP4IIoE4zJBxHgu9y2A91D
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

cs_etm__init_traceid_queue() allocates the frontend and decode threads,
if a later allocation fails, the error path does not drop thread
reference that was already acquired.

Release both thread pointers with thread__zput() on the error path, so
does not leak thread references or leave stale pointers behind.

Fixes: 951ccccdc715 ("perf cs-etm: Only track threads instead of PID and TIDs")
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 2284cda78abe1341d3823d2cfed027e711ff7e62..deca07d57282e431ff4d86350e222092930d330f 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -645,6 +645,8 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 					       queue->tid);
 	tidq->decode_thread = machine__findnew_thread(&etm->session->machines.host, -1,
 					       queue->tid);
+	if (!tidq->frontend_thread || !tidq->decode_thread)
+		goto out;
 
 	tidq->packet = zalloc(sizeof(struct cs_etm_packet));
 	if (!tidq->packet)
@@ -679,6 +681,8 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 	zfree(&tidq->prev_packet);
 	zfree(&tidq->packet);
 out:
+	thread__zput(tidq->frontend_thread);
+	thread__zput(tidq->decode_thread);
 	return rc;
 }
 

-- 
2.34.1

