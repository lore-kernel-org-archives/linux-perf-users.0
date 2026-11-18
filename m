Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019414;
	b=WR+OEMQn/oAurYYfdqlmJ3E3HdVIUcHcAn2+AcGfrwdTx0bJ//PeYCN6Ob4zDHTjYoFF
	 AXL8QsbYneBVh1SLJv9IWIevjUTYBy0Atlb0LZP55P3ByuvQMpb0tSCChZboSv+yRGL8o
	 WTsvOkABNM/KLEcIkm05URor3hKRBgnwcI4dvoBufc+9U0eGPNr1B02UpCbj90+0BnUAG
	 UGrle5+xhYFuKi3LkGWKgyDQbQWlp+9mkPSHrD5ME4TLRrtTsaBUy9SaJiJBYDT660OYl
	 +wazOux36q6EFO/CJbdW/yJ7X2R5HGxq0rjaNbOxe7nf/TAu5VlB/2HwfD3sxiMiA1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=vdM6Q4YNocjVgblKZjtGxqVXhtvY7RSHi8S7pxRdWys=;
	b=KE8mV2Qp2QXDZ2AqmI2+0ChYgCexGb+q9n4xVCfSgUS/tWWTfNxOh+XGZRfd2FIx6RVD
	 4hDOnV2cOpmHPVd6LtRKs/2hFR2j7sEV43oCPVg8ypVbOyIkPIAOXcYLte0H0PaflB+mq
	 YUCTqWOnFfC4/1lHRZFKaMISFymf7OXW1/gcSN9d+A/CmQm4E2sYl7zxsXIWl99/mMJA2
	 6kBENMDjL1L/MZZ0HI5bH3TZcrr6zX8I26iIiR+Pno4BeYHlrhKQDJz35Fd7uo/rEXsKt
	 gvPb5rduxWNodhNetsDsoFWBCZW/tMSJNIETHvL3cVPavYu9Dla9x+ooSpSD0qkLqmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="qG0/IDqk";
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F0860A6F5F
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2F0860A6F5F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qG0/IDqk
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48b001cd92bso728961f8f.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019412; x=1795624212; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vdM6Q4YNocjVgblKZjtGxqVXhtvY7RSHi8S7pxRdWys=;
        b=qG0/IDqk8srIjEfHO+4gJ6Ah4YKoariSopbPf/Vq8b9IlmfdYgnES72jS/tcNdG00+
         VSMEQJun8InsvzXGmJdNGqd9d+jQoSqbBfBXUWghd+Vsicmfcy3bZqB28BQ1/CILlQQ0
         teyZYIer2ERU4so4uE7aSJY6Dvafa1HH6zGPwrc2qUKosnKC8Vrcb4Pr/naqM6ZmvChu
         AppM81MkiOP71CRmbhs6pBm+MSXGeh3saUTuPjuv4hXFGj5MmjjN0CX5eBd2XozyHHmQ
         s7OEr8Bjeb5XFql2KDmPZ3zmjz6pS8e9xplDSjAlGki+S8UBy1/KRw4i5nOM8CLsUVzA
         5aHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019412; x=1795624212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vdM6Q4YNocjVgblKZjtGxqVXhtvY7RSHi8S7pxRdWys=;
        b=cLYbov0+nCQjeXtPAOiAtWUkpTU7gZ0biNUWUhubTj9zfjV4KW8StCZb7PLeoYE42K
         kyHfm0vj7Ughfz+cQUJfe2Df1F+BBlD8K/ieioB9TG7vnghMs6/sEB5ElpzOXeRefO5s
         5iVa7mSHummOeSrkKS8teuPyG7DrggVaRqWiCxhZOpXnPws6uGgWPcvTgTH0FTdbIg3c
         HI+QMIklAIlSz+IOMGucOZhSVO4BFkapM66kixZLMiZJtsxESRc2jhEK5RiIg9iwuoTR
         R5Ie+JJELsZka16SWPvvRw1fkINdcmSUHj8S4aynPMsMLAR5MJk8miD/n6AZ+LanR8hW
         h3fw==
X-Gm-Message-State: APuU4Z9p9JN0xt4urnymt75wXcekfjkR94tYZta4TEGd85/r1Ss+RXX9
	iEBHBV3Q+K0dZG1PyvURX6JfyBwB+H8PeTb0zLzJzzrwDD8hhvQNHgljY+SDUGR2xL8=
X-Gm-Gg: AZFdTZf0JfQrXfJGs32eqHo3B8bKXmJSBj2YEjSigucllQ3c/a1CGZ8h9cQ+CTwpZGE
	lGWvuPu6ZVKOlUIltQBREl7mT3cY5SMujcacun1R6TA+TWIZssJpLGHI6UDvT5k8QALKpcBrm+o
	fsDCJEzx5QvkgRGq0KBqfkY3xsoRjbVUHc8N2Ncor/fDqMLfVyJtyY683vhvMloO0D49rZO/h/y
	Rh+tLpaWQ7u7t6mviGitpg3zEgc1YD2kqC29KfxAKrKddcPBW39cMrT66gjLIQo8sFYl/ZrOFil
	RelHjMZxzmUr4UdiuV68H29eK/YMDv9mXFOa65DFECK/OVFy/TZ4vZP+GixxWVkvXKT21XLs6wK
	ct11n8flFoFTw9czh49PUL/5ePc7ttn+ARzu3vQQCF9opppMVuFc4n02zbBY67XEz2ztLmie4wW
	qxv75nrTFSt45IaclGjgu5Cf/yD9zlkRgIcQopWPzvT0w3OXKMLqP3B96sxLWHck2Mo8E3RXoYJ
	OYLZVVUo6bDLovlwl2pf90a0bTihK/s0dbBpy0S7hRtaVekUI3RwCjgixBALlceYuJOEHqoraoZ
	Xqf4zqPCLQT/tQXy+B2mBinDsXTQnSq3
X-Received: by 2002:a05:6000:40c6:b0:48d:f14a:9182 with SMTP id ffacd0b85a97d-4a6385221d2mr6573956f8f.20.1795019411938;
        Wed, 18 Nov 2026 08:30:11 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:30:11 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 18 Nov 2026 16:29:44 +0000
Subject: [PATCH 22/34] perf cs-etm: Rename trace ID queues to trace ID
 contexts
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
Message-Id: <20261118-james-coresight-jit-v1-22-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
In-Reply-To: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, 
 Leo Yan <leo.yan@arm.com>, Amir Ayupov <aaupov@fb.com>, 
 Suyash Mahar <smahar@meta.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Now cs_etm_traceid_queue is a single decode context rather than a queue
of packets. Rename the struct and related functions to match. Keep tidq
variable names for a later cleanup.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  27 ++--
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |   4 +-
 tools/perf/util/cs-etm.c                        | 156 ++++++++++++------------
 tools/perf/util/cs-etm.h                        |   8 +-
 4 files changed, 97 insertions(+), 98 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 4c47bcf3e2e2..3e3ec30bc7b3 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -87,7 +87,7 @@ int cs_etm_decoder__reset(struct cs_etm_decoder *decoder)
 	return 0;
 }
 
-int cs_etm_decoder__get_packet(struct cs_etm_traceid_queue *packet_queue,
+int cs_etm_decoder__get_packet(struct cs_etm_traceid_ctxt *packet_queue,
 			       struct cs_etm_packet *packet)
 {
 	if (!packet_queue || !packet)
@@ -228,7 +228,7 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 				  const uint8_t trace_chan_id,
 				  const ocsd_trc_index_t indx)
 {
-	struct cs_etm_traceid_queue *packet_queue;
+	struct cs_etm_traceid_ctxt *packet_queue;
 	u64 converted_timestamp;
 
 	/* Ignore trace timestamps when unavailable or disabled by --itrace=Z. */
@@ -236,7 +236,7 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 		return OCSD_RESP_CONT;
 
 	/* First get the decode context for this traceID */
-	packet_queue = cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
+	packet_queue = cs_etm__etmq_get_traceid_ctxt(etmq, trace_chan_id);
 	if (!packet_queue)
 		return OCSD_RESP_FATAL_SYS_ERR;
 
@@ -257,7 +257,7 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 	packet_queue->cs_timestamp = max(packet_queue->cs_timestamp, converted_timestamp);
 
 	/* Tell the front end which decode context needs attention */
-	cs_etm__etmq_set_traceid_queue_ready(etmq, trace_chan_id);
+	cs_etm__etmq_set_traceid_ctxt_ready(etmq, trace_chan_id);
 
 	/* Halt processing until we are being told to proceed */
 	return OCSD_RESP_WAIT;
@@ -293,7 +293,7 @@ cs_etm_decoder__get_isa(const ocsd_generic_trace_elem *elem)
 
 static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_packet(struct cs_etm_queue *etmq,
-			      struct cs_etm_traceid_queue *packet_queue,
+			      struct cs_etm_traceid_ctxt *packet_queue,
 			      const ocsd_generic_trace_elem *elem,
 			      const u8 trace_chan_id,
 			      enum cs_etm_sample_type sample_type)
@@ -329,13 +329,13 @@ cs_etm_decoder__buffer_packet(struct cs_etm_queue *etmq,
 	packet->el = ocsd_EL_unknown;
 	packet->tid = -1;
 
-	cs_etm__etmq_set_traceid_queue_ready(etmq, trace_chan_id);
+	cs_etm__etmq_set_traceid_ctxt_ready(etmq, trace_chan_id);
 	return OCSD_RESP_WAIT;
 }
 
 static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_range(struct cs_etm_queue *etmq,
-			     struct cs_etm_traceid_queue *packet_queue,
+			     struct cs_etm_traceid_ctxt *packet_queue,
 			     const ocsd_generic_trace_elem *elem,
 			     const uint8_t trace_chan_id)
 {
@@ -370,7 +370,7 @@ cs_etm_decoder__buffer_range(struct cs_etm_queue *etmq,
 
 static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_discontinuity(struct cs_etm_queue *etmq,
-				     struct cs_etm_traceid_queue *queue,
+				     struct cs_etm_traceid_ctxt *queue,
 				     const ocsd_generic_trace_elem *elem,
 				     const uint8_t trace_chan_id)
 {
@@ -380,7 +380,7 @@ cs_etm_decoder__buffer_discontinuity(struct cs_etm_queue *etmq,
 
 static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_exception(struct cs_etm_queue *etmq,
-				 struct cs_etm_traceid_queue *queue,
+				 struct cs_etm_traceid_ctxt *queue,
 				 const ocsd_generic_trace_elem *elem,
 				 const uint8_t trace_chan_id)
 {
@@ -431,7 +431,7 @@ cs_etm_decoder__buffer_exception(struct cs_etm_queue *etmq,
 
 static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_exception_ret(struct cs_etm_queue *etmq,
-				     struct cs_etm_traceid_queue *queue,
+				     struct cs_etm_traceid_ctxt *queue,
 				     const ocsd_generic_trace_elem *elem,
 				     const uint8_t trace_chan_id)
 {
@@ -441,7 +441,7 @@ cs_etm_decoder__buffer_exception_ret(struct cs_etm_queue *etmq,
 
 static ocsd_datapath_resp_t
 cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
-			struct cs_etm_traceid_queue *packet_queue,
+			struct cs_etm_traceid_ctxt *packet_queue,
 			const ocsd_generic_trace_elem *elem,
 			const uint8_t trace_chan_id)
 {
@@ -495,10 +495,9 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	ocsd_gen_trc_elem_t type;
 	struct cs_etm_decoder *decoder = (struct cs_etm_decoder *) context;
 	struct cs_etm_queue *etmq = decoder->data;
-	struct cs_etm_traceid_queue *packet_queue;
+	struct cs_etm_traceid_ctxt *packet_queue;
 
-	/* First get the packet queue for this traceID */
-	packet_queue = cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
+	packet_queue = cs_etm__etmq_get_traceid_ctxt(etmq, trace_chan_id);
 	if (!packet_queue)
 		return OCSD_RESP_FATAL_SYS_ERR;
 
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 4420daaf159d..8624f48d696f 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -16,7 +16,7 @@
 
 struct cs_etm_decoder;
 struct cs_etm_packet;
-struct cs_etm_traceid_queue;
+struct cs_etm_traceid_ctxt;
 
 struct cs_etm_queue;
 
@@ -102,7 +102,7 @@ int cs_etm_decoder__add_mem_access_cb(struct cs_etm_decoder *decoder,
 				      u64 start, u64 end,
 				      cs_etm_mem_cb_type cb_func);
 
-int cs_etm_decoder__get_packet(struct cs_etm_traceid_queue *packet_queue,
+int cs_etm_decoder__get_packet(struct cs_etm_traceid_ctxt *packet_queue,
 			       struct cs_etm_packet *packet);
 
 int cs_etm_decoder__reset(struct cs_etm_decoder *decoder);
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 3f5865ed2724..b49bf606ffeb 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -86,9 +86,9 @@ struct cs_etm_queue {
 	u64 offset;
 	const unsigned char *buf;
 	size_t buf_len, buf_used;
-	/* Conversion between traceID and index in traceid_queues array */
-	struct intlist *traceid_queues_list;
-	struct cs_etm_traceid_queue **traceid_queues;
+	/* Conversion between traceID and index in traceid_ctxts array */
+	struct intlist *traceid_ctxts_list;
+	struct cs_etm_traceid_ctxt **traceid_ctxts;
 	/* Conversion between traceID and metadata pointers */
 	struct intlist *traceid_list;
 	/*
@@ -545,7 +545,7 @@ static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
 	return err;
 }
 
-void cs_etm__etmq_set_traceid_queue_ready(struct cs_etm_queue *etmq,
+void cs_etm__etmq_set_traceid_ctxt_ready(struct cs_etm_queue *etmq,
 					  u8 trace_chan_id)
 {
 	/* Tell the frontend which queue the last processed packet is in. */
@@ -567,7 +567,7 @@ void cs_etm__etmq_set_traceid_queue_ready(struct cs_etm_queue *etmq,
 static u64 cs_etm__etmq_get_sort_timestamp(struct cs_etm_queue *etmq,
 				      u8 *trace_chan_id)
 {
-	struct cs_etm_traceid_queue *tidq;
+	struct cs_etm_traceid_ctxt *tidq;
 
 	if (!etmq->ready_chan_id)
 		return 0;
@@ -575,7 +575,7 @@ static u64 cs_etm__etmq_get_sort_timestamp(struct cs_etm_queue *etmq,
 	if (trace_chan_id)
 		*trace_chan_id = etmq->ready_chan_id;
 
-	tidq = cs_etm__etmq_get_traceid_queue(etmq, etmq->ready_chan_id);
+	tidq = cs_etm__etmq_get_traceid_ctxt(etmq, etmq->ready_chan_id);
 	if (!tidq)
 		return 0;
 
@@ -593,8 +593,8 @@ static u64 cs_etm__etmq_get_sort_timestamp(struct cs_etm_queue *etmq,
 	return tidq->cs_timestamp;
 }
 
-static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
-				      struct cs_etm_traceid_queue *tidq,
+static int cs_etm__init_traceid_ctxt(struct cs_etm_queue *etmq,
+				      struct cs_etm_traceid_ctxt *tidq,
 				      u8 trace_chan_id)
 {
 	int rc = -ENOMEM;
@@ -657,22 +657,22 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 	return rc;
 }
 
-struct cs_etm_traceid_queue
-*cs_etm__etmq_get_traceid_queue(struct cs_etm_queue *etmq, u8 trace_chan_id)
+struct cs_etm_traceid_ctxt
+*cs_etm__etmq_get_traceid_ctxt(struct cs_etm_queue *etmq, u8 trace_chan_id)
 {
 	int idx;
 	struct int_node *inode;
-	struct intlist *traceid_queues_list = etmq->traceid_queues_list;
-	struct cs_etm_traceid_queue *tidq, **traceid_queues;
+	struct intlist *traceid_ctxts_list = etmq->traceid_ctxts_list;
+	struct cs_etm_traceid_ctxt *tidq, **traceid_ctxts;
 
 	/*
 	 * Check if a decode context exists for this traceID by looking
 	 * in the context list.
 	 */
-	inode = intlist__find(traceid_queues_list, trace_chan_id);
+	inode = intlist__find(traceid_ctxts_list, trace_chan_id);
 	if (inode) {
 		idx = (int)(intptr_t)inode->priv;
-		return etmq->traceid_queues[idx];
+		return etmq->traceid_ctxts[idx];
 	}
 
 	/* We couldn't find a decode context for this traceID, allocate one */
@@ -683,49 +683,49 @@ struct cs_etm_traceid_queue
 	memset(tidq, 0, sizeof(*tidq));
 
 	/* Get a valid index for the new decode context */
-	idx = intlist__nr_entries(traceid_queues_list);
-	/* Memory for the inode is freed in cs_etm__free_traceid_queues() */
-	inode = intlist__findnew(traceid_queues_list, trace_chan_id);
+	idx = intlist__nr_entries(traceid_ctxts_list);
+	/* Memory for the inode is freed in cs_etm__free_traceid_ctxts() */
+	inode = intlist__findnew(traceid_ctxts_list, trace_chan_id);
 	if (!inode)
 		goto out_free;
 
 	/* Associate this traceID with this index */
 	inode->priv = (void *)(intptr_t)idx;
 
-	if (cs_etm__init_traceid_queue(etmq, tidq, trace_chan_id))
+	if (cs_etm__init_traceid_ctxt(etmq, tidq, trace_chan_id))
 		goto out_free;
 
-	/* Grow the traceid_queues array by one unit */
-	traceid_queues = etmq->traceid_queues;
-	traceid_queues = reallocarray(traceid_queues,
+	/* Grow the traceid_ctxts array by one unit */
+	traceid_ctxts = etmq->traceid_ctxts;
+	traceid_ctxts = reallocarray(traceid_ctxts,
 				      idx + 1,
-				      sizeof(*traceid_queues));
+				      sizeof(*traceid_ctxts));
 
 	/*
 	 * On failure reallocarray() returns NULL and the original block of
 	 * memory is left untouched.
 	 */
-	if (!traceid_queues)
+	if (!traceid_ctxts)
 		goto out_free;
 
-	traceid_queues[idx] = tidq;
-	etmq->traceid_queues = traceid_queues;
+	traceid_ctxts[idx] = tidq;
+	etmq->traceid_ctxts = traceid_ctxts;
 
-	return etmq->traceid_queues[idx];
+	return etmq->traceid_ctxts[idx];
 
 out_free:
 	/*
 	 * Function intlist__remove() removes the inode from the list
 	 * and delete the memory associated to it.
 	 */
-	intlist__remove(traceid_queues_list, inode);
+	intlist__remove(traceid_ctxts_list, inode);
 	free(tidq);
 
 	return NULL;
 }
 
 static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
-				struct cs_etm_traceid_queue *tidq)
+				struct cs_etm_traceid_ctxt *tidq)
 {
 	struct cs_etm_packet *tmp;
 
@@ -894,20 +894,20 @@ static int cs_etm__flush_events(struct perf_session *session,
 	return cs_etm__flush_queues(etm);
 }
 
-static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
+static void cs_etm__free_traceid_ctxts(struct cs_etm_queue *etmq)
 {
 	int idx;
 	uintptr_t priv;
 	struct int_node *inode, *tmp;
-	struct cs_etm_traceid_queue *tidq;
-	struct intlist *traceid_queues_list = etmq->traceid_queues_list;
+	struct cs_etm_traceid_ctxt *tidq;
+	struct intlist *traceid_ctxts_list = etmq->traceid_ctxts_list;
 
-	intlist__for_each_entry_safe(inode, tmp, traceid_queues_list) {
+	intlist__for_each_entry_safe(inode, tmp, traceid_ctxts_list) {
 		priv = (uintptr_t)inode->priv;
 		idx = priv;
 
 		/* Free this decode context from the array */
-		tidq = etmq->traceid_queues[idx];
+		tidq = etmq->traceid_ctxts[idx];
 		thread__zput(tidq->frontend_thread);
 		thread__zput(tidq->decode_thread);
 		zfree(&tidq->event_buf);
@@ -921,15 +921,15 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
 		 * Function intlist__remove() removes the inode from the list
 		 * and delete the memory associated to it.
 		 */
-		intlist__remove(traceid_queues_list, inode);
+		intlist__remove(traceid_ctxts_list, inode);
 	}
 
 	/* Then the RB tree itself */
-	intlist__delete(traceid_queues_list);
-	etmq->traceid_queues_list = NULL;
+	intlist__delete(traceid_ctxts_list);
+	etmq->traceid_ctxts_list = NULL;
 
-	/* finally free the traceid_queues array */
-	zfree(&etmq->traceid_queues);
+	/* finally free the traceid_ctxts array */
+	zfree(&etmq->traceid_ctxts);
 }
 
 static void cs_etm__free_queue(void *priv)
@@ -941,7 +941,7 @@ static void cs_etm__free_queue(void *priv)
 		return;
 
 	cs_etm_decoder__zfree(&etmq->decoder);
-	cs_etm__free_traceid_queues(etmq);
+	cs_etm__free_traceid_ctxts(etmq);
 
 	if (etmq->own_traceid_list) {
 		/* First remove all traceID/metadata nodes for the RB tree */
@@ -1163,7 +1163,7 @@ static u32 __cs_etm__mem_access(struct cs_etm_queue *etmq,
 }
 
 static u32 cs_etm__frontend_mem_access(struct cs_etm_queue *etmq,
-				       struct cs_etm_traceid_queue *tidq,
+				       struct cs_etm_traceid_ctxt *tidq,
 				       struct cs_etm_packet *packet,
 				       u64 address, size_t size, u8 *buffer)
 {
@@ -1175,9 +1175,9 @@ static u32 cs_etm__decoder_mem_access(struct cs_etm_queue *etmq, u8 trace_chan_i
 				      u64 address, size_t size, u8 *buffer,
 				      const ocsd_mem_space_acc_t mem_space)
 {
-	struct cs_etm_traceid_queue *tidq;
+	struct cs_etm_traceid_ctxt *tidq;
 
-	tidq = cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
+	tidq = cs_etm__etmq_get_traceid_ctxt(etmq, trace_chan_id);
 	if (!tidq)
 		return 0;
 
@@ -1192,8 +1192,8 @@ static struct cs_etm_queue *cs_etm__alloc_queue(void)
 	if (!etmq)
 		return NULL;
 
-	etmq->traceid_queues_list = intlist__new(NULL);
-	if (!etmq->traceid_queues_list)
+	etmq->traceid_ctxts_list = intlist__new(NULL);
+	if (!etmq->traceid_ctxts_list)
 		goto out_free;
 
 	/*
@@ -1208,7 +1208,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(void)
 	return etmq;
 
 out_free:
-	intlist__delete(etmq->traceid_queues_list);
+	intlist__delete(etmq->traceid_ctxts_list);
 	free(etmq);
 
 	return NULL;
@@ -1312,7 +1312,7 @@ static int cs_etm__push_heap_all(struct cs_etm_auxtrace *etm)
 }
 
 static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
-					 struct cs_etm_traceid_queue *tidq,
+					 struct cs_etm_traceid_ctxt *tidq,
 					 struct cs_etm_packet *packet, u64 addr)
 {
 	u8 instrBytes[2];
@@ -1328,7 +1328,7 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
 }
 
 static inline int cs_etm__instr_size(struct cs_etm_queue *etmq,
-				     struct cs_etm_traceid_queue *tidq,
+				     struct cs_etm_traceid_ctxt *tidq,
 				     struct cs_etm_packet *packet,
 				     u64 addr)
 {
@@ -1364,7 +1364,7 @@ u64 cs_etm__last_executed_instr(const struct cs_etm_packet *packet)
 }
 
 static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
-				     struct cs_etm_traceid_queue *tidq,
+				     struct cs_etm_traceid_ctxt *tidq,
 				     struct cs_etm_packet *packet,
 				     u64 offset)
 {
@@ -1480,10 +1480,10 @@ int cs_etm__etmq_update_decode_context(struct cs_etm_queue *etmq,
 				       u8 trace_chan_id,
 				       ocsd_ex_level el, pid_t tid)
 {
-	struct cs_etm_traceid_queue *tidq;
+	struct cs_etm_traceid_ctxt *tidq;
 	int ret;
 
-	tidq = cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
+	tidq = cs_etm__etmq_get_traceid_ctxt(etmq, trace_chan_id);
 	if (!tidq)
 		return -EINVAL;
 
@@ -1502,7 +1502,7 @@ bool cs_etm__has_timestamps(struct cs_etm_queue *etmq)
 }
 
 static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
-			      struct cs_etm_traceid_queue *tidq,
+			      struct cs_etm_traceid_ctxt *tidq,
 			      struct cs_etm_packet *packet,
 			      struct perf_sample *sample)
 {
@@ -1544,7 +1544,7 @@ u64 cs_etm__convert_sample_time(struct cs_etm_queue *etmq, u64 cs_timestamp)
 }
 
 static inline u64 cs_etm__resolve_sample_time(struct cs_etm_queue *etmq,
-					       struct cs_etm_traceid_queue *tidq)
+					       struct cs_etm_traceid_ctxt *tidq)
 {
 	struct cs_etm_auxtrace *etm = etmq->etm;
 
@@ -1571,7 +1571,7 @@ static bool cs_etm__packet_has_branch(struct cs_etm_packet *packet)
 }
 
 static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
-				    struct cs_etm_traceid_queue *tidq)
+				    struct cs_etm_traceid_ctxt *tidq)
 {
 	struct cs_etm_auxtrace *etm = etmq->etm;
 	u64 from, to;
@@ -1603,7 +1603,7 @@ static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
 }
 
 static void cs_etm__sample_branch_stack(struct cs_etm_auxtrace *etm,
-					struct cs_etm_traceid_queue *tidq,
+					struct cs_etm_traceid_ctxt *tidq,
 					struct perf_sample *sample)
 {
 	if (etm->synth_opts.last_branch) {
@@ -1634,7 +1634,7 @@ static void cs_etm__sample_branch_stack(struct cs_etm_auxtrace *etm,
 }
 
 static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
-					    struct cs_etm_traceid_queue *tidq,
+					    struct cs_etm_traceid_ctxt *tidq,
 					    struct cs_etm_packet *packet,
 					    u64 addr, u64 period)
 {
@@ -1683,7 +1683,7 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 }
 
 static int cs_etm__synth_last_instruction_sample(struct cs_etm_queue *etmq,
-						 struct cs_etm_traceid_queue *tidq)
+						 struct cs_etm_traceid_ctxt *tidq)
 {
 	struct cs_etm_packet *packet = tidq->prev_packet;
 	int ret;
@@ -1710,7 +1710,7 @@ static int cs_etm__synth_last_instruction_sample(struct cs_etm_queue *etmq,
  * and the next taken branch. Generate sample accordingly.
  */
 static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
-				       struct cs_etm_traceid_queue *tidq)
+				       struct cs_etm_traceid_ctxt *tidq)
 {
 	int ret = 0;
 	struct cs_etm_auxtrace *etm = etmq->etm;
@@ -1879,7 +1879,7 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
 }
 
 static int cs_etm__sample(struct cs_etm_queue *etmq,
-			  struct cs_etm_traceid_queue *tidq)
+			  struct cs_etm_traceid_ctxt *tidq)
 {
 	struct cs_etm_auxtrace *etm = etmq->etm;
 	int ret;
@@ -1981,7 +1981,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 }
 
 static int cs_etm__context(struct cs_etm_queue *etmq,
-			   struct cs_etm_traceid_queue *tidq)
+			   struct cs_etm_traceid_ctxt *tidq)
 {
 	ocsd_ex_level el = tidq->packet->el;
 	struct machine *machine;
@@ -2009,7 +2009,7 @@ static int cs_etm__context(struct cs_etm_queue *etmq,
 }
 
 static int cs_etm__exception(struct cs_etm_queue *etmq,
-			     struct cs_etm_traceid_queue *tidq)
+			     struct cs_etm_traceid_ctxt *tidq)
 {
 	struct cs_etm_packet *packet = tidq->packet;
 
@@ -2030,7 +2030,7 @@ static int cs_etm__exception(struct cs_etm_queue *etmq,
 }
 
 static int cs_etm__flush(struct cs_etm_queue *etmq,
-			 struct cs_etm_traceid_queue *tidq)
+			 struct cs_etm_traceid_ctxt *tidq)
 {
 	int err = 0;
 	struct cs_etm_auxtrace *etm = etmq->etm;
@@ -2058,7 +2058,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 }
 
 static int cs_etm__end_block(struct cs_etm_queue *etmq,
-			     struct cs_etm_traceid_queue *tidq)
+			     struct cs_etm_traceid_ctxt *tidq)
 {
 	/*
 	 * It has no new packet coming and 'etmq->packet' contains the stale
@@ -2159,9 +2159,9 @@ static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
 		struct int_node *inode;
 
 		intlist__for_each_entry(inode, etmq->traceid_list) {
-			struct cs_etm_traceid_queue *tidq;
+			struct cs_etm_traceid_ctxt *tidq;
 
-			tidq = cs_etm__etmq_get_traceid_queue(etmq, inode->i);
+			tidq = cs_etm__etmq_get_traceid_ctxt(etmq, inode->i);
 			if (!tidq)
 				return -ENOMEM;
 			if (thread__tid(tidq->decode_thread) == etmq->buffer->tid)
@@ -2183,7 +2183,7 @@ static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
 
 /* Check whether the instruction before ret_addr is an SVC. */
 static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq,
-				 struct cs_etm_traceid_queue *tidq,
+				 struct cs_etm_traceid_ctxt *tidq,
 				 struct cs_etm_packet *packet, u64 ret_addr)
 {
 	/* Initialise to keep compiler happy */
@@ -2254,7 +2254,7 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq,
 }
 
 static bool cs_etm__is_syscall(struct cs_etm_queue *etmq,
-			       struct cs_etm_traceid_queue *tidq, u64 magic)
+			       struct cs_etm_traceid_ctxt *tidq, u64 magic)
 {
 	struct cs_etm_packet *packet = tidq->packet;
 
@@ -2277,7 +2277,7 @@ static bool cs_etm__is_syscall(struct cs_etm_queue *etmq,
 	return false;
 }
 
-static bool cs_etm__is_async_exception(struct cs_etm_traceid_queue *tidq,
+static bool cs_etm__is_async_exception(struct cs_etm_traceid_ctxt *tidq,
 				       u64 magic)
 {
 	struct cs_etm_packet *packet = tidq->packet;
@@ -2304,7 +2304,7 @@ static bool cs_etm__is_async_exception(struct cs_etm_traceid_queue *tidq,
 }
 
 static bool cs_etm__is_sync_exception(struct cs_etm_queue *etmq,
-				      struct cs_etm_traceid_queue *tidq,
+				      struct cs_etm_traceid_ctxt *tidq,
 				      u64 magic)
 {
 	struct cs_etm_packet *packet = tidq->packet;
@@ -2351,7 +2351,7 @@ static bool cs_etm__is_sync_exception(struct cs_etm_queue *etmq,
 }
 
 static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq,
-				    struct cs_etm_traceid_queue *tidq)
+				    struct cs_etm_traceid_ctxt *tidq)
 {
 	struct cs_etm_packet *packet = tidq->packet;
 	struct cs_etm_packet *prev_packet = tidq->prev_packet;
@@ -2571,8 +2571,8 @@ static int cs_etm__decode_data_block(struct cs_etm_queue *etmq)
 	return ret;
 }
 
-static int cs_etm__process_traceid_queue(struct cs_etm_queue *etmq,
-					 struct cs_etm_traceid_queue *tidq)
+static int cs_etm__process_traceid_ctxt(struct cs_etm_queue *etmq,
+					 struct cs_etm_traceid_ctxt *tidq)
 {
 	int ret;
 
@@ -2657,7 +2657,7 @@ static int cs_etm__pop_heap(struct cs_etm_auxtrace *etm, u64 timestamp)
 	u8 trace_chan_id;
 	struct auxtrace_queue *queue;
 	struct cs_etm_queue *etmq;
-	struct cs_etm_traceid_queue *tidq;
+	struct cs_etm_traceid_ctxt *tidq;
 	u64 queue_time;
 
 	while (1) {
@@ -2684,7 +2684,7 @@ static int cs_etm__pop_heap(struct cs_etm_auxtrace *etm, u64 timestamp)
 		auxtrace_heap__pop(&etm->heap);
 		etmq->on_heap = false;
 
-		tidq  = cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
+		tidq  = cs_etm__etmq_get_traceid_ctxt(etmq, trace_chan_id);
 		if (!tidq) {
 			/*
 			 * No traceID queue has been allocated for this traceID,
@@ -2699,7 +2699,7 @@ static int cs_etm__pop_heap(struct cs_etm_auxtrace *etm, u64 timestamp)
 		 * Packets associated with this timestamp, if any, are already in
 		 * the etmq's traceID queue, so process them.
 		 */
-		ret = cs_etm__process_traceid_queue(etmq, tidq);
+		ret = cs_etm__process_traceid_ctxt(etmq, tidq);
 		if (ret < 0)
 			goto out;
 
@@ -2723,7 +2723,7 @@ static int cs_etm__pop_heap(struct cs_etm_auxtrace *etm, u64 timestamp)
 		/*
 		 * Add the next timestamp or decoded packets to the min heap.
 		 * Packets will be processed and synthesized during the next call
-		 * to cs_etm__process_traceid_queue() for this queue/traceID.
+		 * to cs_etm__process_traceid_ctxt() for this queue/traceID.
 		 */
 		ret = cs_etm__add_to_heap(etmq);
 		if (ret)
@@ -2741,7 +2741,7 @@ static int cs_etm__flush_queues(struct cs_etm_auxtrace *etm)
 	int ret = 0;
 	unsigned int i;
 	struct cs_etm_queue *etmq;
-	struct cs_etm_traceid_queue *tidq;
+	struct cs_etm_traceid_ctxt *tidq;
 
 	for (i = 0; i < etm->queues.nr_queues; i++) {
 		struct int_node *inode;
@@ -2750,11 +2750,11 @@ static int cs_etm__flush_queues(struct cs_etm_auxtrace *etm)
 		if (!etmq)
 			continue;
 
-		intlist__for_each_entry(inode, etmq->traceid_queues_list) {
+		intlist__for_each_entry(inode, etmq->traceid_ctxts_list) {
 			int idx = (int)(intptr_t)inode->priv;
 
 			/* Flush any remaining branch stack entries */
-			tidq = etmq->traceid_queues[idx];
+			tidq = etmq->traceid_ctxts[idx];
 			ret = cs_etm__end_block(etmq, tidq);
 			if (ret)
 				return ret;
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 1cbc8bc0aa06..115def9c6abb 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -247,7 +247,7 @@ enum cs_etm_pid_fmt {
  * Decode context for a single trace ID stream. In a decode tree there is one
  * of these for each stream.
  */
-struct cs_etm_traceid_queue {
+struct cs_etm_traceid_ctxt {
 	u8 trace_chan_id;
 	u64 period_instructions;
 	u64 kernel_start;
@@ -276,10 +276,10 @@ int cs_etm__etmq_update_decode_context(struct cs_etm_queue *etmq,
 				       u8 trace_chan_id, ocsd_ex_level el,
 				       pid_t tid);
 bool cs_etm__has_timestamps(struct cs_etm_queue *etmq);
-void cs_etm__etmq_set_traceid_queue_ready(struct cs_etm_queue *etmq,
+void cs_etm__etmq_set_traceid_ctxt_ready(struct cs_etm_queue *etmq,
 					  u8 trace_chan_id);
-struct cs_etm_traceid_queue
-*cs_etm__etmq_get_traceid_queue(struct cs_etm_queue *etmq, u8 trace_chan_id);
+struct cs_etm_traceid_ctxt
+*cs_etm__etmq_get_traceid_ctxt(struct cs_etm_queue *etmq, u8 trace_chan_id);
 int cs_etm__process_auxtrace_info_full(union perf_event *event __maybe_unused,
 				       struct perf_session *session __maybe_unused);
 u64 cs_etm__convert_sample_time(struct cs_etm_queue *etmq, u64 cs_timestamp);

-- 
2.43.0

