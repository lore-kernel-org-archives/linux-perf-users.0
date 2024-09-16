Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C08515957E
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Sep 2024 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495108; cv=none; b=d6sVnwj+F+kYjUo2Qknu8EKdaRVoUIJ/i8bbEBYzPPCALci5fP8NZJrKdugnMTG9FwVf1fxzuvD2cWGxCL3ZtW9mZ5z7v32YtS0DlN50DKxWmarH0MWoXTwLy901FnfZX6G0jgs8v+qTwYUz+5UlfoN5anArv0jWB6OO/pcKPrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495108; c=relaxed/simple;
	bh=xqzKWqo2N+qrwkny8IWgiAeXyj7BCHbJKMyWllqHEio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l8OCAGUZskQO3366DThigq0nLvON3MrPe2DpcsrFjSZH64zuN4/A7eHKAMS6y7KP204/ZqPQhHhHlBB9pMPT0q7RpkKch82uLMbuxEuSUKxs54TdAGpaoLd0ODPoLJUYNyFz9mt8Rmj0+0W2ng+wc7SYpYTwxdK/SvpHAhNn0FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g5C5ZQx0; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g5C5ZQx0"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3780c8d689aso3383000f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Sep 2024 06:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726495104; x=1727099904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umuEtd6TXriWmaesvaUlkUkqPg9JblHlWbB3iYtKN0A=;
        b=g5C5ZQx0M7PIZ6SlEBGVHMTTHJKcU62m7BbcgxnwSCglj+DPjZZV42A9m9projAnT3
         c4dI//kdmAQYHB+iW5NlCsNVrUl63OUte48j8fi1KYUo9Hz6qbl5AwTued/YztOAxvEc
         /GHAuyBTdoRYwtrmKCLknLRL0uWeNUBFTQsQUCPfoNaGpNFmBhLHq4ZikkfhCEBtX1d2
         yMhm0zMfVNmq5FpiPMmZL2I8gQh+1LbRxSAIT3lweSHEP9OaI3mJm5jdGWHWubSEsEfG
         5QMn75jw0UQ6S4KmtBY6G+jh7cKrPQPeZ7FVbS3n9AMOmwvAXHzDkL6g6xRywu35QFpe
         8i8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726495104; x=1727099904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umuEtd6TXriWmaesvaUlkUkqPg9JblHlWbB3iYtKN0A=;
        b=XHTT+opJX4tg93SDNYy1iY/90FSG86O8jlqrQPy74vtw8DgzJ5e4BEysNAvMLH2K5Q
         WnjTmahj3FJGVANXXzLVrGGCo0KeKRz0/iMq+7tUjuYXpcdtc3ukuhCyMDdVmtkeu5F4
         bwo+sVvRToPRgSv3J55C6G/vPvglwjJhLJEFvbwTLOqi4ZCD/6m9N6TdqVMzwmUCIawR
         IrA+qFnD5ZlbM9UhqMDgh3/EAPBjreO8oeodgGy+lJHfxyvtnwyD3VNPUHwXcA0JHWUQ
         e8hKzhh2jxuHGEqnuFCJ48z5CMzkJVf4lKVyc6lpMal7aTBEnDQ5pbGrKMMEF/IXRIIj
         xO+A==
X-Gm-Message-State: AOJu0YzZJheBe6kFn076DkkRGswma7/0NYwNDgiVo1V3FlhbLdy/KS3W
	Fiu+2dQbgwSfDyRD6heAqJe0ehTOhVNWO88AY67j8Q5NaV1+/87kM3+62BimCQkDQ19XP13OAva
	QWtsMeA==
X-Google-Smtp-Source: AGHT+IH+TmfCLdIaNzxJmSpEMr+pHlKHl21zQSiG9BRNBBOm0HusB70btlMPY4whjW+3iQfcuOBDCw==
X-Received: by 2002:a5d:56d0:0:b0:374:ce9a:ff11 with SMTP id ffacd0b85a97d-378c2d7298fmr8875256f8f.50.1726495102704;
        Mon, 16 Sep 2024 06:58:22 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f62dasm7285098f8f.49.2024.09.16.06.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 06:58:22 -0700 (PDT)
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
Subject: [PATCH v3 1/7] perf cs-etm: Don't flush when packet_queue fills up
Date: Mon, 16 Sep 2024 14:57:32 +0100
Message-Id: <20240916135743.1490403-2-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916135743.1490403-1-james.clark@linaro.org>
References: <20240916135743.1490403-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cs_etm__flush(), like cs_etm__sample() is an operation that generates a
sample and then swaps the current with the previous packet. Calling
flush after processing the queues results in two swaps which corrupts
the next sample. Therefore it wasn't appropriate to call flush here so
remove it.

Flushing is still done on a discontinuity to explicitly clear the last
branch buffer, but when the packet_queue fills up before reaching a
timestamp, that's not a discontinuity and the call to
cs_etm__process_traceid_queue() already generated samples and drained
the buffers correctly.

This is visible by looking for a branch that has the same target as the
previous branch and the following source is before the address of the
last target, which is impossible as execution would have had to have
gone backwards:

  ffff800080849d40 _find_next_and_bit+0x78 => ffff80008011cadc update_sg_lb_stats+0x94
   (packet_queue fills here before a timestamp, resulting in a flush and
    branch target ffff80008011cadc is duplicated.)
  ffff80008011cb1c update_sg_lb_stats+0xd4 => ffff80008011cadc update_sg_lb_stats+0x94
  ffff8000801117c4 cpu_util+0x24 => ffff8000801117d4 cpu_util+0x34

After removing the flush the correct branch target is used for the
second sample, and ffff8000801117c4 is no longer before the previous
address:

  ffff800080849d40 _find_next_and_bit+0x78 => ffff80008011cadc update_sg_lb_stats+0x94
  ffff80008011cb1c update_sg_lb_stats+0xd4 => ffff8000801117a0 cpu_util+0x0
  ffff8000801117c4 cpu_util+0x24 => ffff8000801117d4 cpu_util+0x34

Make sure that a final branch stack is output at the end of the trace
by calling cs_etm__end_block(). This is already done for both the
timeless decode paths.

Fixes: 21fe8dc1191a ("perf cs-etm: Add support for CPU-wide trace scenarios")
Reported-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Closes: https://lore.kernel.org/all/20240719092619.274730-1-gankulkarni@os.amperecomputing.com/
Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 90f32f327b9b..242788ac9625 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2490,12 +2490,6 @@ static void cs_etm__clear_all_traceid_queues(struct cs_etm_queue *etmq)
 
 		/* Ignore return value */
 		cs_etm__process_traceid_queue(etmq, tidq);
-
-		/*
-		 * Generate an instruction sample with the remaining
-		 * branchstack entries.
-		 */
-		cs_etm__flush(etmq, tidq);
 	}
 }
 
@@ -2638,7 +2632,7 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
 
 	while (1) {
 		if (!etm->heap.heap_cnt)
-			goto out;
+			break;
 
 		/* Take the entry at the top of the min heap */
 		cs_queue_nr = etm->heap.heap_array[0].queue_nr;
@@ -2721,6 +2715,23 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
 		ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, cs_timestamp);
 	}
 
+	for (i = 0; i < etm->queues.nr_queues; i++) {
+		struct int_node *inode;
+
+		etmq = etm->queues.queue_array[i].priv;
+		if (!etmq)
+			continue;
+
+		intlist__for_each_entry(inode, etmq->traceid_queues_list) {
+			int idx = (int)(intptr_t)inode->priv;
+
+			/* Flush any remaining branch stack entries */
+			tidq = etmq->traceid_queues[idx];
+			ret = cs_etm__end_block(etmq, tidq);
+			if (ret)
+				return ret;
+		}
+	}
 out:
 	return ret;
 }
-- 
2.34.1

