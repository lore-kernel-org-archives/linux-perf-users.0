Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991386F076
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153955; cv=none; b=aRB4A644xVCC36Ym5F9oUp+WKAaDWXJ/kTbALzlK5qNfeI+p2kuN9ZEo9b3JtkTY8+mulpJOIkyVGDifsRY57w2wrqHkCRSl0kZdDQSoxTNtM7TKFFF5kZno9f5dnBSCxQVulOuWwuWpCsB9V7crz4mG5jUr3SVY5Y13GOdvofI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153955; c=relaxed/simple;
	bh=BLyYNeKHXpaVRY3LVG7/JvVL5e/xrnUw/rEHeYJPcz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dKLX2NvmPuT0L3XfNGN4pqrcJFOO8bastVAlHGrE6zqFnDOwqWhENuNrNyu4nKiwSmIaIJYICe+UgSmOEf5qfvSApNMUl0SXfzHFKwJHyJIKb8uP48uLSJA/GouOV5pzqCmH+HedzwoGQa3Z6azC7G4ZAb4HYIsXgfAkljhkeqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s1pQwTD1; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s1pQwTD1"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso10399695e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 08:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726153950; x=1726758750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVBlRkBG8+Idy8ehQJVILHBn96DUefeGnB3enzkGPeQ=;
        b=s1pQwTD1sSGKbewqLBV5WUzMQk2nuWFhI9+wOf2+XVsHKIAr3Ib7P8TfojIfvQM8W/
         QA/hU16yHywCsMdJ9QwvqjXRgncJhi4nHxK2PaLjRRXfJqhmSwD8tA+qvaGWvjUBmp7k
         HTq1ru0V+YeCWeJ3CRyHh0MhpKaXxlgzwUe51mv3jxq3TB21ele0fsz+TWKbTaibQyzC
         t9F4HuBujLflXWhjjvuBFsdFihVwib37PbfasIgxfci1V/4S5Ti5X1+r1MMhHfN4+37d
         qJhr+6a0VJ43lXSQee1uWHSRgCiLQ6MlLhjMHQr1SQvWc6X5b6kNcok9ImsFjE1R2eiQ
         rdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726153950; x=1726758750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVBlRkBG8+Idy8ehQJVILHBn96DUefeGnB3enzkGPeQ=;
        b=Ibx9hOaT0ulFyI8b9n7OlLr0P7VV3x3sC55XE4UghzWxkEX7dryh97KyFB/MZOsd0w
         qoaKjV1+0+r2cULd1opAgnxAgRH1Ez84xqeggIWZ522o8G9DQmCDqbjiNFNKO2Cc2Puy
         bdjUrRmHwN+ZZfzCBx94zCjlYxHYgNJYbP1rISCIgnmLVSX5EXSof0jmxKGxqSzDKW+C
         CB3K7n1AtBPhHMmnHs/z9v6zwi749a4qZp9KI/xme1UVl1ZWq5CdFt+dctan7ANHgG3E
         itb9UAaqyzR4Jzd2VPNvziGm0WQXOqsMD7Ar/nAkFQ+OcRa4vMIV0ylf5ceTSrtAhNRD
         4dCg==
X-Gm-Message-State: AOJu0YyxGhv5ahAQszfqY5j+3KYLTQWrgaQuXaMlV5vaZrI+t2cHptw3
	uzcUuoMtdnLV6W3R24lzaTA2ssg/R+dyH+2rvYLNMOzAgicMM4uscmeJaSQ6agQEKTwCXM8VRW+
	XD6Y5xA==
X-Google-Smtp-Source: AGHT+IF+9bah/yP5A17iSIWzhHNRw1ieQewYP5DtP+X3D3ShpKM5Hg1qUBA6sanEMQfeBKZpW/0C4g==
X-Received: by 2002:a05:600c:1c91:b0:42b:af52:2525 with SMTP id 5b1f17b1804b1-42cdb54dd62mr28413645e9.16.1726153949096;
        Thu, 12 Sep 2024 08:12:29 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb0dbcb6bsm171928845e9.30.2024.09.12.08.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 08:12:28 -0700 (PDT)
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
Subject: [PATCH v2 1/7] perf cs-etm: Don't flush when packet_queue fills up
Date: Thu, 12 Sep 2024 16:11:32 +0100
Message-Id: <20240912151143.1264483-2-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912151143.1264483-1-james.clark@linaro.org>
References: <20240912151143.1264483-1-james.clark@linaro.org>
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

