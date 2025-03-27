Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1258820FAB5;
	Thu, 27 Mar 2025 11:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073976; cv=none; b=QHfP/NjOU07zNb4A+4POghpU6JjHWZsPUp/T5Eqoo5a8I4NVN4SKYdY+0C+AYwgLXBbScvMoIEat4D3mIywhcOx8CF0CEpw6C4FIhJG6ASCSiGJFIa+iTm6Pad9xUWhkowg4WYlgMIJyMmEpqbF9FHDBhLP7sxHy7OIA+HSDYN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073976; c=relaxed/simple;
	bh=aLC7NcIzC1jybEH69KvTN0TcqoB4aHteLcvtE+49Jck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trFGIIFaCZdhEM0Kg/aPcwE+D5f6cdtZFG/ntoOJmZctZB5f7hD3yOXgwVU/E5yJIxHbyVVIxvae6TW8nwB8yZr60ev968F1JodU/IkENTgJfHjZdoS/Qmx7FXpkjxslkZ37C9sfwiQMaKC7IF3ApIuP4oObWV7lUNxA6/4ubDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=U7AmohYt; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="U7AmohYt"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R75sHT013524;
	Thu, 27 Mar 2025 04:12:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=p
	bpkHIovNPqcQ5fu1aW16jtnIw8TYXiKiBmahzxX8zY=; b=U7AmohYtbyOlUMH+k
	acDChOZxhPQMVIIUuq7Y+igMiiCEFo+9ymjINVEDavLzcoocD9hxXYltGwGouSVB
	mXnaIWy6LRQMMXNh13PIyUweVYQjcoC+LG8XQovMZQb9K6ti4fFn+bX46q+y8JUJ
	VLezvZvR4g/CgZeTSpUSDbJWfwl3QkyqrW9YtTNGJ3wK+Xl/qqsq16Zvb8rtmAPw
	PquCOBnXhUFh+qHspdS0jpVlYMWHcF/n8QJdaGv9sEQ/4dQ0OysHuPkGa6woNWqe
	uVaox0T1Rz3vbLcTmeddh/jmk2NyLi4hoZ0b1u4u/psNpmFH8aI1N7fz8d/Y7a+O
	OtK7w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45n1yv8gds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 04:12:43 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Mar 2025 04:12:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 27 Mar 2025 04:12:41 -0700
Received: from optiplex.marvell.com (unknown [10.28.34.253])
	by maili.marvell.com (Postfix) with ESMTP id 36F623F7060;
	Thu, 27 Mar 2025 04:12:36 -0700 (PDT)
From: Tanmay Jagdale <tanmay@marvell.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <james.clark@linaro.org>, <john.g.garry@oracle.com>,
        <leo.yan@linux.dev>, <will@kernel.org>, <acme@kernel.org>,
        <adrian.hunter@intel.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
        <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gcherian@marvell.com>, <lcherian@marvell.com>,
        Tanmay Jagdale
	<tanmay@marvell.com>,
        James Clark <james.clark@arm.com>
Subject: [PATCH V3 2/2] perf: cs-etm: Store previous timestamp in packet queue
Date: Thu, 27 Mar 2025 16:41:49 +0530
Message-ID: <20250327111149.461012-3-tanmay@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327111149.461012-1-tanmay@marvell.com>
References: <20250327111149.461012-1-tanmay@marvell.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8izJ4PYGXSk9WIQHdeAh21W6kF_57qXd
X-Authority-Analysis: v=2.4 cv=dKCmmPZb c=1 sm=1 tr=0 ts=67e532ab cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=7CQSdrXTAAAA:8 a=7j_uQjMFRymVN5L776oA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: 8izJ4PYGXSk9WIQHdeAh21W6kF_57qXd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01

Since logic in cs_etm__sample is changed to synthesizing the previous
packet (tidq->prev_packet) instead of current packet (tidq->packet),
the first time this function is called, tidq->prev_packet is NULL
and we return without processing anything.

This is as expected but, in the first call, we would have a valid
timestamp (stored in tidq->packet_queue.cs_timestamp) which belongs
to tidq->packet. This would be lost due to no processing.

Losing this timestamp results in all the synthesized packets being
associated with the next timestamp and not their corresponding one.

To fix this, introduce a new variable (prev_cs_timestamp) to store the
queue's timestamp in cs_etm__sample(). When we start synthesizing the
prev_packet, use this cached value instead of the current timestamp
(cs_timestamp).

Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 17 +++++++++++++----
 tools/perf/util/cs-etm.h |  1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index ebed5b98860e..b52b58328ca0 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1542,13 +1542,15 @@ u64 cs_etm__convert_sample_time(struct cs_etm_queue *etmq, u64 cs_timestamp)
 }
 
 static inline u64 cs_etm__resolve_sample_time(struct cs_etm_queue *etmq,
-					       struct cs_etm_traceid_queue *tidq)
+					       struct cs_etm_traceid_queue *tidq,
+					       bool instruction_sample)
 {
 	struct cs_etm_auxtrace *etm = etmq->etm;
 	struct cs_etm_packet_queue *packet_queue = &tidq->packet_queue;
 
 	if (!etm->timeless_decoding && etm->has_virtual_ts)
-		return packet_queue->cs_timestamp;
+		return instruction_sample ? packet_queue->prev_cs_timestamp :
+					    packet_queue->cs_timestamp;
 	else
 		return etm->latest_kernel_timestamp;
 }
@@ -1567,7 +1569,7 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 	event->sample.header.size = sizeof(struct perf_event_header);
 
 	/* Set time field based on etm auxtrace config. */
-	sample.time = cs_etm__resolve_sample_time(etmq, tidq);
+	sample.time = cs_etm__resolve_sample_time(etmq, tidq, true);
 
 	sample.ip = addr;
 	sample.pid = thread__pid(tidq->thread);
@@ -1643,7 +1645,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	event->sample.header.size = sizeof(struct perf_event_header);
 
 	/* Set time field based on etm auxtrace config. */
-	sample.time = cs_etm__resolve_sample_time(etmq, tidq);
+	sample.time = cs_etm__resolve_sample_time(etmq, tidq, false);
 
 	sample.ip = ip;
 	sample.pid = thread__pid(tidq->prev_packet_thread);
@@ -1903,6 +1905,13 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		}
 	}
 
+	/*
+	 * Since we synthesize the prev_packet, store the current timestamp
+	 * here in prev_cs_timestamp so that when we *actually* synthesize
+	 * the prev_packet, we use this timestamp and not the future one.
+	 */
+	tidq->packet_queue.prev_cs_timestamp = tidq->packet_queue.cs_timestamp;
+
 	cs_etm__packet_swap(etm, tidq);
 
 	return 0;
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index a8caeea720aa..359d6233dd9b 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -205,6 +205,7 @@ struct cs_etm_packet_queue {
 	u32 instr_count;
 	u64 cs_timestamp; /* Timestamp from trace data, converted to ns if possible */
 	u64 next_cs_timestamp;
+	u64 prev_cs_timestamp;
 	struct cs_etm_packet packet_buffer[CS_ETM_PACKET_MAX_BUFFER];
 };
 
-- 
2.43.0

