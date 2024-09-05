Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A54C1991D0
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533480; cv=none; b=VPG/qLJdzHMJ4TfdEeDNYbBudiQGtqGNXqWhkw5B/eGjLNytKkbY788t1D6ECvgeAWGipLwdx8RvcCIikm86s4ZcKeC0/xKp5KNs9jN+rJiC2sq13V6b3oZvczv61hDChYP93YdBQio4EuJa6NaMHfmzZUkUsMBOqf0cakHHpUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533480; c=relaxed/simple;
	bh=wzk9SyvQfKoXUMQnerIZ1e1CQ5nCLvLIdMZfnrTV2M4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GtIs+JbafgmfBxCbtjvFiuvSyarZRNjOdyMNuEs1xZVSHYnauQT9Y9ks//aKmOFxOh/PzMG3GlEwwLngucwcbMQDLozcxmEP5lrNdIeAScHmw7P+BxhJmvHmYsMAxmWvQSpvaDgehtHhApkfOZ5rTJ10EaXAU7xUWoExlep0rAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pc6TCSp+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pc6TCSp+"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42c828c8863so4946625e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Sep 2024 03:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725533477; x=1726138277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVd4bq0YTjw4v+0IMoc3Cm2fVjGVCOS4YTrWYkTu6OE=;
        b=Pc6TCSp+cTes7yo7UyKK3TevcHf8sJSDNfpAsOdR9e4qZfGoZE5DXQH0ET2KGR8L7E
         INXVbVF17E7U1u1/OrzU60XPxHaNb15crUe4AM7NcbG5YcWDYNSv4+i4x55JfkilsjnQ
         7YjbSFJGny392eUMct6wtAl6lUCa5Cb9DNC7+HSP85I6jc4D70nXTqLUhweXBKsjSHNT
         lyLheFtrLrumKS9NnSURNrprKERngMf6nGMoJLkbd0uMreLXXBPuh8iUWnSkt3bhW3IB
         MBB30eJtRyUtorbdzBXE04diK9q4/nIIQcbX8kqxgH38ovRlqWXRukqLSNmmzHtaS8fN
         44lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725533477; x=1726138277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVd4bq0YTjw4v+0IMoc3Cm2fVjGVCOS4YTrWYkTu6OE=;
        b=kKQKXyBGj7RZ+Kk8zMxR5vBvke5RnNbLQP+jrl0P1N2u5f52v5H3bbNVMrE5eWx/JE
         r7Ag0lGRpCuu1+101VNUdALaS1UOA1Tc8ap2JV1Q4+l2msz8qA64usP4E2Bgu1wAcYYl
         E9nvVcVy20txJtabL+NMO9A8Hh7ncj/T+czPRwPq7xrEkTUv8SpZSv3z7CvrX6quZnCp
         l//d6vMnykp1YXgScXtz4cX8Dil4DUwtRG4DQb4vzVsa1ZB51rUgG5A1/57g9K9fI2fo
         D04xtxrawMJgFcNMAgRX5sXnKwHPlcECoK1j1le0QlRSKkN00VmTAOJfm+R0COmqdT2w
         26CA==
X-Gm-Message-State: AOJu0YzTkz4SqTCIYMKYRvL8JLahp/DP+jN5sfVcNNcSqIpp4FB80vH3
	IHNo7BCSoZl5WQkJgBkBc7Bsy5oc2aHzxx1BXKEAeesdUrBgJ/6aSt8OhOHzDeqmrglDQIuJVmU
	zvk0=
X-Google-Smtp-Source: AGHT+IHLKD1lksVjuCFdRAy71VLeSYs/LO7EW6oQprwBpHDtYZTrW3t9QhBgsgUf6sAqeRl0YMfHGA==
X-Received: by 2002:a05:600c:3584:b0:42b:afd8:7568 with SMTP id 5b1f17b1804b1-42bdc64e498mr125056915e9.23.1725533477165;
        Thu, 05 Sep 2024 03:51:17 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0dbcsm231089965e9.17.2024.09.05.03.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:51:16 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	gankulkarni@os.amperecomputing.com,
	coresight@lists.linaro.org,
	leo.yan@arm.com,
	scclevenger@os.amperecomputing.com
Cc: James Clark <james.clark@linaro.org>,
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
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>,
	Ben Gainey <ben.gainey@arm.com>,
	Ruidong Tian <tianruidong@linux.alibaba.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/8] perf cs-etm: Remove cs_etm__flush()
Date: Thu,  5 Sep 2024 11:50:34 +0100
Message-Id: <20240905105043.160225-4-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905105043.160225-1-james.clark@linaro.org>
References: <20240905105043.160225-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is only called on a discontinuity, and it generates a normal
sample and then clears the branch buffer. I'm not convinced that any
of the subtle differences between cs_etm__flush() and cs_etm__sample()
weren't actual bugs or potential sources of them.

Replace it with a call to the existing sample function and then a clear
of the branch buffer.

One obvious difference is that it now generates a range of instructions
based on instructions_sample_period, rather than only a single
instruction sample. I think this is actually the correct thing to do.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 62 ++++------------------------------------
 1 file changed, 5 insertions(+), 57 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 602e791ff5ba..cdda8403af2b 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1908,60 +1908,6 @@ static int cs_etm__exception(struct cs_etm_traceid_queue *tidq)
 	return 0;
 }
 
-static int cs_etm__flush(struct cs_etm_queue *etmq,
-			 struct cs_etm_traceid_queue *tidq)
-{
-	int err = 0;
-	struct cs_etm_auxtrace *etm = etmq->etm;
-
-	/* Handle start tracing packet */
-	if (tidq->prev_packet->sample_type == CS_ETM_EMPTY)
-		goto swap_packet;
-
-	if (etmq->etm->synth_opts.last_branch &&
-	    etmq->etm->synth_opts.instructions &&
-	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
-		u64 addr;
-
-		/* Prepare last branches for instruction sample */
-		cs_etm__copy_last_branch_rb(etmq, tidq);
-
-		/*
-		 * Generate a last branch event for the branches left in the
-		 * circular buffer at the end of the trace.
-		 *
-		 * Use the address of the end of the last reported execution
-		 * range
-		 */
-		addr = cs_etm__last_executed_instr(tidq->prev_packet);
-
-		err = cs_etm__synth_instruction_sample(
-			etmq, tidq, addr,
-			tidq->period_instructions);
-		if (err)
-			return err;
-
-		tidq->period_instructions = 0;
-
-	}
-
-	if (etm->synth_opts.branches &&
-	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
-		err = cs_etm__synth_branch_sample(etmq, tidq);
-		if (err)
-			return err;
-	}
-
-swap_packet:
-	cs_etm__packet_swap(etm, tidq);
-
-	/* Reset last branches after flush the trace */
-	if (etm->synth_opts.last_branch)
-		cs_etm__reset_last_branch_rb(tidq);
-
-	return err;
-}
-
 static int cs_etm__end_block(struct cs_etm_queue *etmq,
 			     struct cs_etm_traceid_queue *tidq)
 {
@@ -2457,10 +2403,12 @@ static int cs_etm__process_traceid_queue(struct cs_etm_queue *etmq,
 			break;
 		case CS_ETM_DISCONTINUITY:
 			/*
-			 * Discontinuity in trace, flush
-			 * previous branch stack
+			 * Discontinuity in trace, generate a sample then
+			 * clear the branch stack.
 			 */
-			cs_etm__flush(etmq, tidq);
+			cs_etm__sample(etmq, tidq);
+			if (etmq->etm->synth_opts.last_branch)
+				cs_etm__reset_last_branch_rb(tidq);
 			break;
 		case CS_ETM_EMPTY:
 			/*
-- 
2.34.1

