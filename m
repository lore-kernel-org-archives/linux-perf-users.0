Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373225;
	b=PXNE1wEv5kBPs/A+aQy1Tf2C/E8yMFjBNo+tSJwapO/Byoml7jgifd/xjNBZYEwxirCK
	 rHgWbUyGR7ymwJxV4adxe+5FpMmB2rbSphDFncYnkYm72AsYZoLOcRyINeXlRM4SP/GBf
	 l8Rx16PHdgsI+gv+wwuJTef9pMJSCVVi3Y7j2kVJxYo87qOAEGjXxhB43j1rVI3YnSD3v
	 uObvidMHPdl35TmDspdzjVNDxMKMJHH8jaLSltqqWfjuvV3rmd/vWG30m8xr/pMOvmYy1
	 vX1/VAuFAn6fA7jIFNsMb21lTnEx86wKWs/JmMqbIR6T15MDKA9RWPV1Z+3SOhH6KGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373225;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=Z/JkJFn3iNXlj+hylhO5vD2ySOIyXSjdmt7nMHVIP/g=;
	b=w59+EQ3iO5uXK1uDy9CGGwtRHDr22qxN8rMX74SZYPc7ZBrd4og0fCqCG3PqQuhpJNa0
	 qwKhlJ7zJSFjNb6LXqmURMfZtjioc3hNpkJ0gy43mTp2wtBlxgMQ8GjSw5u9mXFEP6bCS
	 YEcegJWFaIOovE0VHLizIT5vMplJ4Zd7zXGPB1qyMyw3SooLnJhSlp6EeKrrxYuUilBkC
	 IcZ7ihfoloFgLzU/insxOy4/icO9uVCloPQdIleFrzYW8cI2pjpKhIXZfy4cOS4qYWouM
	 PPIV9p1QvNTEGr16PVM/rV3sOt2PTTBCd9sqeJjYQGs+0+fGJs16piUfHKanq7S2EEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=kJxYh7Nk;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F7960A3823;
	Fri, 30 Oct 2026 15:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13F7960A3823
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=kJxYh7Nk
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 555C41BD0;
	Fri, 30 Oct 2026 08:13:41 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A9503F59E;
	Fri, 30 Oct 2026 08:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793373224; bh=1iaBBxv3MQipWDQGfSjrcrLtzg9MkTp0MuLNDczftss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kJxYh7NkUbd7QxmrH2nBHML3P8pBB6vPomg/60+Geahv/IdBKVICTFYjot6nbScFj
	 qn342vnyulPYLHP6kNibX3sS5YBRFprYfgmyOFmBAs812IXHugEcSqsfh85LaVSxgz
	 fAmnKLxtUdXCtSh9QyNi8FCEE9YFKYzWhvMwc8qo=
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 30 Oct 2026 15:13:15 +0000
Subject: [PATCH v3 08/14] perf cs-etm: Centralize branch sample synthesis
 checks
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-perf_cs_etm_fix_non_taken-v3-8-7629b52ab047@arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Suyash Mahar <smahar@meta.com>, 
 Amir Ayupov <aaupov@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793373201; l=2339;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=1iaBBxv3MQipWDQGfSjrcrLtzg9MkTp0MuLNDczftss=;
 b=Tum2smZhTSN9E8hph4v7mvbz1K3bCrimDPGbCjYyE5at4ZgvSjislf3XCEzYP/ok34GXwvAzC
 sm/a12w2yX+A6jbcBVHXpR5oOHqwTrnf8cgBwWZ6+LMrk8y/+rZNWaY
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Move the branch-synthesis option and packet checks from cs_etm__sample()
into cs_etm__synth_branch_sample(), alongside the existing branch filter.
Call the helper directly from cs_etm__sample() and cs_etm__flush().

Accept trace-start and trace-end flags, this preserves boundary samples
without a taken branch.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 9abbbc28dd1e2a66eadd663ce18217cd62deb390..a9191c06060a2455e8bf1cd5f00fb9e92904eefa 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1768,6 +1768,14 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	} dummy_bs;
 	u64 ip;
 
+	if (!etm->synth_opts.branches)
+		return 0;
+
+	if (!cs_etm__packet_has_taken_branch(tidq->prev_packet) &&
+	    !(tidq->prev_packet->flags & (PERF_IP_FLAG_TRACE_BEGIN |
+					  PERF_IP_FLAG_TRACE_END)))
+		return 0;
+
 	if (etm->branches_filter &&
 		!(etm->branches_filter & tidq->prev_packet->flags))
 		return 0;
@@ -2007,23 +2015,9 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		}
 	}
 
-	if (etm->synth_opts.branches) {
-		bool generate_sample = false;
-
-		/* Generate sample for tracing on packet */
-		if (tidq->prev_packet->sample_type == CS_ETM_DISCONTINUITY)
-			generate_sample = true;
-
-		/* Generate sample for branch taken packet */
-		if (cs_etm__packet_has_taken_branch(tidq->prev_packet))
-			generate_sample = true;
-
-		if (generate_sample) {
-			ret = cs_etm__synth_branch_sample(etmq, tidq);
-			if (ret)
-				return ret;
-		}
-	}
+	ret = cs_etm__synth_branch_sample(etmq, tidq);
+	if (ret)
+		return ret;
 
 	cs_etm__packet_swap(etm, tidq);
 
@@ -2091,12 +2085,9 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 	if (err)
 		return err;
 
-	if (etm->synth_opts.branches &&
-	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
-		err = cs_etm__synth_branch_sample(etmq, tidq);
-		if (err)
-			return err;
-	}
+	err = cs_etm__synth_branch_sample(etmq, tidq);
+	if (err)
+		return err;
 
 swap_packet:
 	cs_etm__packet_swap(etm, tidq);

-- 
2.34.1

