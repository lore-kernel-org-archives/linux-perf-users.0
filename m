Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D58234388F
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939067; cv=none; b=XNWGuMAuoxQF35AwvqIp41LQv9OHj0ZkUL2vlA2umFi1WEfEJxVyh8co6QiA6cipltwGye68w23sHs26sdQ8f+juc2CnPHlzFwV4HBrvUSNVYxYQVhaf5HRuefKZhkwfXRJQRORcnQylcvZOsPZP+C/BKBrMtYPuLp3wGZCWW1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939067; c=relaxed/simple;
	bh=xka5UItDIrEJnIvKmqLwmmfEobjfMvpvaTiygYgaFd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mYR/DRH9JVvKAKDqPwp80nj492Pa3M+YgqaFLx2kOEvioa0dYZZ142buuqvJLJkHOdVNLgE+v9JPK0hIl0ob2WUyp96Ko/7DVNu2UFDhW/jciVs6teTyBAHAVXawqgtBgjnueZn9nDX1hB0/Zh+a69YQznBdtgnChYUzON/TYIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SQZiJkp7; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SQZiJkp7"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so41911995e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 04:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790939061; x=1791543861; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GEiJjq6Jc7fnijCf7RLJfnGkUIPBSRhorQ+d3FhIqF8=;
        b=SQZiJkp7fBStqZixS8tMJsuj+qXSUB6WIJpq3hCFZ/SUsXabR/BfZnBO/ETf/MmEmJ
         bPD0nltp+40tWONGUKzj3KBCBJYiwy8Ul2tLcAvze2gCDt0mLDBTXi7pTLpXtQeD1KeU
         kevqc0HtCTeupn/fGA+hsooU+IaWEc0J1WAWF+GSNxXtg8SLobAtovzUzhObtvdNpBUE
         zPQhXRm0uhfyqK1YhBzhLFZr+go1OafN5Wx4Y4/ZhbNXJppBeVDa7Soa4kQBq4Ag/JUO
         y37TdsKgYvYbCyQ2411fxDUpMDvXpdFuczQSyIEL1qb60t0tifsi7Y/cUK4klOQd1IDI
         gMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790939061; x=1791543861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GEiJjq6Jc7fnijCf7RLJfnGkUIPBSRhorQ+d3FhIqF8=;
        b=IvJWinnErk7VaO7rmPCIINHVGMNlLYrrwg51FntzQvsptf5s4hVdiy9RC24F2Wxznf
         Lx1wDkHr+m4SBHBj1QoICdOcifYfp+2jaBi7oLv6LXu+RUzYm3ZPa62Y4R4V74+UwRS0
         mMHY/+LzImGoDmPKxgWLT3H0/OP0CptmgXRxmbn/EpK8ODxaYzzTXlTNcJdlDwCYb5Tl
         LTrNI15duCBSJClHA7ODqDVEIuFlgDKzhCVBzdIO5c33vGK7JS/ecbY7ECtTqItruhW7
         jMgKZ7nfWHVthyAXEVxnv4f5hT+TAEIcSADcDjZBOlhoHodPlCvzmF7ct2Th3wNSM+Cy
         uCoQ==
X-Forwarded-Encrypted: i=1; AKwUvByuwfbKegiy4yTfvnPdOc23Cl/eB/CXggZJmLc0zTyXjqheQaP16OpojJOXtwQv9SmB+kNmD/d4VscZ5h+5BAjw@vger.kernel.org
X-Gm-Message-State: AFuF++lHcrH1sk9AlgbsaMxHDFcnrjBnBzT+sSKOE/mGDwWrda2wZ1Ep
	tCLt1Tk7PUSMeiAPNs33XLeCjOP9TA1DzjQBl6iBg3WBJmkZEL0al3xduLOewohvLDQ=
X-Gm-Gg: AYBFou1m52Aao9ztLlOgfSQEpd2yc+o9dVfwUv7fPwmc32zVhHY0T/C170i2e6ISvm/
	17rNIUsuKhTpr4JNq7tQpxIXcj58A31+Z9E306wyVFpcXn8KOnohmPwqTdR/rlfS2yDpdFvlZ4T
	MGMboLYlRYGSE3PLDbifA7AzekvHOBWpn3FSIvnH1V5OyJrc/36vFLmG46dzjLg7LH9iM4j58v3
	RZ0wRdGm16gpLQXkRcrgdZFriO7R/Cx/0Lalq1Adk7oP16WwXyGxsqRgCLRx493RDBpoJp2EhAW
	gTtKEkM+cnYiSC+KLQ90eszMg1fVpDyPZzqE4Jt57lKfBCntacISSpQcVnxwBe8oGtpbw66BifZ
	EhM+5HhkOFfMqFoMai9SaAfGn/+4oScFShaIosXRLWe6ufyFn55uCJr+HWV5n9ldclnJXjHsb0f
	oBHwf8fWpB9mp9sGNoTzUhNXgt65FDJJso7FFaybDQmDOTFVmyBM5oLS6GqjoJr0eY1JdTK1RZn
	A==
X-Received: by 2002:a05:600c:350a:b0:4a0:1f51:ba2d with SMTP id 5b1f17b1804b1-4a02769cf7fmr40489485e9.22.1790939060892;
        Fri, 02 Oct 2026 04:04:20 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280c6597sm75669465e9.9.2026.10.02.04.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 04:04:20 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 02 Oct 2026 12:03:53 +0100
Subject: [PATCH v2 1/4] perf: cs-etm: Don't add global v0 HW_IDs to
 unformatted queues
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-james-cs-hw_id-output-failure-v2-1-7a194aa61173@linaro.org>
References: <20261002-james-cs-hw_id-output-failure-v2-0-7a194aa61173@linaro.org>
In-Reply-To: <20261002-james-cs-hw_id-output-failure-v2-0-7a194aa61173@linaro.org>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@linux.dev>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

In the case of mixed formatted and unformatted trace with v0 HW_IDs, or
no HW_IDs at all resulting in the cs_etm__map_trace_ids_metadata()
fallback, formatted queues will write their HW_IDs to unformatted
queues. This will result in an assert because of multiple decoders on an
unformatted queue.

Fix it by not inserting trace ID nodes on other unformatted queues. This
isn't an issue for v0.1 HW_IDs because they aren't global so will only
add to their own queue.

Fixes: 19c3e4db38c5 ("perf: cs-etm: Create decoders based on the trace ID mappings")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 2d1ab34f7b6b..fda6b6c02e26 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -309,27 +309,27 @@ static int cs_etm__map_trace_id_v0(struct cs_etm_auxtrace *etm, u8 trace_chan_id
 {
 	struct cs_etm_queue *etmq;
 
-	/*
-	 * If the queue is unformatted then only save one mapping in the
-	 * queue associated with that CPU so only one decoder is made.
-	 */
 	etmq = cs_etm__get_queue(etm, cpu_metadata[CS_ETM_CPU]);
 	if (!etmq)
 		return -EINVAL;
 
+	/*
+	 * If the queue is unformatted then only save one mapping in the
+	 * queue associated with that CPU so only one decoder is made.
+	 */
 	if (etmq->format == UNFORMATTED)
 		return cs_etm__insert_trace_id_node(etmq, trace_chan_id,
 						    cpu_metadata);
 
 	/*
 	 * Otherwise, version 0 trace IDs are global so save them into every
-	 * queue.
+	 * formatted queue.
 	 */
 	for (unsigned int i = 0; i < etm->queues.nr_queues; ++i) {
 		int ret;
 
 		etmq = etm->queues.queue_array[i].priv;
-		if (!etmq)
+		if (!etmq || etmq->format == UNFORMATTED)
 			continue;
 
 		ret = cs_etm__insert_trace_id_node(etmq, trace_chan_id,

-- 
2.43.0

