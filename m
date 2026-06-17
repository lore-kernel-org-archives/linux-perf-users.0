Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF21747CC79
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708948; cv=none; b=hJFg/8XO5U0ocVlxuQ93+DkSSpsQ2nzlpQ4oXUr0yfjzN2ss/G/EtdCR2EgTazWhlop5+TzKqApu8LYp0RXgnaipwUgJJmri4fKWqMXlHt9QQqMhmoGr1MN/7GVY7fTZ17Ty12yB2fxMUlwJ2M4/FnuIHrTrB3DXCcFmHiGSCjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708948; c=relaxed/simple;
	bh=SEQP8cUTewgR2t1D8MbvH0bOXeNY4tGhibdYmhPsYDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hBG8+RJJcbSDkbsI/vK6erLaN23t3LLfenrwNwxi0Kv4DWVBLJX52BShrpotI2Answy/38jokmu8Yfv0Siq3+r7ImKOQw+FbEY9ceGGsXOrHdGsPRg26xv1GOvAEjOv8DjzekFQNx3GkA6m+zqGLU1m1WcJvVOiP6X2Dr46c1G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BGiPzZme; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BGiPzZme"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F02932AB;
	Wed, 17 Jun 2026 08:09:01 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EC823F915;
	Wed, 17 Jun 2026 08:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781708946; bh=SEQP8cUTewgR2t1D8MbvH0bOXeNY4tGhibdYmhPsYDo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BGiPzZmef6gUXCw3UVAv+1fSXxDg+4qEw8u/XkP1W9Bz0mznxzZ8Hm6Hl49/TdQkI
	 FMZsXUxaw2w1dn8gBgd13sQmEf6eJfOeBW54iV1P7mcsJMtXCBh1/VixbGux0SXIxk
	 f6g2yfl64sQFH2fQcSKCG6HKerp+4zI6QE9RHG3M=
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 17 Jun 2026 16:08:52 +0100
Subject: [PATCH v10 1/9] perf cs-etm: Fix thread leaks on trace queue init
 failure
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-b4-arm_cs_callchain_support_v1-v10-1-e8b6e5d63db5@arm.com>
References: <20260617-b4-arm_cs_callchain_support_v1-v10-0-e8b6e5d63db5@arm.com>
In-Reply-To: <20260617-b4-arm_cs_callchain_support_v1-v10-0-e8b6e5d63db5@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781708939; l=1431;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=SEQP8cUTewgR2t1D8MbvH0bOXeNY4tGhibdYmhPsYDo=;
 b=szdnFKpu+a5edVhGzTI5DpXS4MSyVIG8YINkytaomJc53VDefMylkJnXRFOVnqAA/HdTpYenA
 yb6IaoAl4LID9HLM0xAdFM5b9JFfk6+8B3Y1yvSqYELhJ3tsRfWc5a7
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

