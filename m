Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019412;
	b=BX7H8eIWBYz0r/GwRkFYcqUDDEUwfkl9G8siG+z8+fDwoH4SqbljgCDgxDPFVIvkup5o
	 uV4+VqHUusBAJaGKWrEUsq4K81qDRX2QSg61YS6yLG8zgVqJXr+0x9bpmST5ve8VWsBMk
	 TwTiD6SFG0xGlV2WZFKyQ0HPHqg+xwoKeq8fXry8l71YUlWBdB4IIOK2nP6Hh6YHcWmKY
	 yYkzZ/i+dW1El7LHC2+OCadAAAOlRd4cBRi/drqFXVmFfWZgxUzrVxX/f5aUkccrCwR5Q
	 15lIIgv9fc6xtaxvMiaYOW6mOrP9LqVT20yHZz1FEKX1tNjTeevdjPXdRqMUn2k9Q4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=yCjoTJR6LdbvR/cwt8ZPonwz8Vxbe4mw4fGpbe7vuDc=;
	b=zNMddxEZaWn7lFof31TwFMnkDmJYY3CVVc81Qwx2qbcc2af4kbBPGUDZoExHyRMeIltk
	 EDknOvD7FTDpg2u5F2AsSCkHuVXDOqfJVNpRGoSD4tJ1DhTO29j6NeA8wFvq93t6O+oOv
	 r9W/ITSPiqE1zzOPSCsD8DScHkcBRveyzn6S9QPaQU7CaQEmr3MUUUAO7jWq0yqxnTAVM
	 h6v7nQYsv5vj6j7LGiNVflrdBwZM7T1BOivqaxgH7mo9vQih2eqhEPQPuLUlEvr0QV2VG
	 DnS4QJTnw3a48yH8SNL6FRt/6xpWJc0+nEFDGmR3YSfnqmd58Oycka3n6HGt6k+B4LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uE+KKUfW;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F0B60A3830
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7F0B60A3830
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uE+KKUfW
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so9999795e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019408; x=1795624208; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yCjoTJR6LdbvR/cwt8ZPonwz8Vxbe4mw4fGpbe7vuDc=;
        b=uE+KKUfWWwx/JRX7W0XaHH0k1nfdURAdYk4NK6djAEQ6NwVicQ10II/QuTMUvHXG/W
         gcLI0h8EOyCmejowm3hsltWRuBvdzBPDVeVQaAOuXa5Wtz7egMo6VzjpVG6HO7XhpIqD
         AmXnb+c81ZQ1Cqq/n1Fa2iyUnY5El+nSJ0RIY9tUumiWYQYhAFJDSXdK0tu9lSDMyq2g
         8PAnyEOAXD6xgw+lFxUBpiN/v261Qx+TfZFs0ccgbN6FoQ73U3g0ozYOzkvnhdzJsdPx
         TK0slTL/EQT4bV0JpjUlulXa+qlVXjqtr1QQBalX8KkFntTCLCr3aoxJ+tk8gQ96MQc1
         Fj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019408; x=1795624208;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yCjoTJR6LdbvR/cwt8ZPonwz8Vxbe4mw4fGpbe7vuDc=;
        b=hlK/0z5BNxfQKVSwCWv1gBeCrLgX6/g0WZgrjEtoU6PFFINzlcmI1Id3tVGQ7m98Eb
         tNyFXHRMAJC2MTL4cDPvBoQqhY+k7znB/eru2rH7ma5nKQUhDT+kL4PbLFkmL1j6cQRk
         8vsd2zt62DOa0cFNIzSaplR19vWpbmMsalm/UXDD8O8fRzLC3JF7Alf+FEp+x7VHTDG1
         d+aTK5WTRgI4IfUct5BS9+bEP1tsffi/f/N4Gx9INWf5+3zeWnsJ3jdRbRlnGsqGn7pD
         xr15F7er5WOZ6kdyOCXHChauGjgkPdbfVpwbZwfhplYpDMA7d2DLoS2lMxkatv2Q2P0X
         eA8Q==
X-Gm-Message-State: APuU4Z9VMOjDxHvTLGvD5fUSttPKZ3pdIinQmuy6OkIbnVts8gVAGfiD
	x8Xo0690TuOuuME6pwjoRivfJa7hEeuNHkH1v5rszotpK6RTq75rPdcyEYooeUxUJ9Q=
X-Gm-Gg: AYBFou1RnB1hYpPQHR08wocALWYnh1nuHxv61pLBwhQ7J5SSD421V08qDP4HNwVfVAp
	h66D9+5VGNUPG4aGbHSkC2gTH0saTAmYfRDF9rqe452KzhPXeQmt/YMmErLXzY/25htcXKfvD7Z
	gvP/L2guqCMEXYzSUV02JDieV+PtjoXvtWKsNsiVtbXojUSGFWejMTOMMFOPsoY7YByz6QAISrc
	78/F/9Wpk5wDVpD6RGEpuzKogwKsbXtUA3yH3T+vwLgDn2rjd6aP1GZRxJR+nJgChIITXAChRj8
	FeHgfGUTahV36eJHs0JLh2FILtsECV3THPWgCbRX1yu2rJD9Xmim2YTZOXxKwRhrrvRIN2oGPrh
	X7gV9bxJgVh0o2ZtDUEIpMeUPwAj97tImt5Qjxw2DCqK1Z4izMkUT+v8UMCwXcsPiBjQMjUSgzv
	NfhdJYI9v35LfbKk9kSKa6NSmHMJ67bHZxZwiQrZRNCqMhOJuku4TH01Fb278hodfL3zyfttYM2
	FjQM01H0PpRXrJA9/duUrfdusV7L+2N0s+JChkXL+Y8OwGzsT8i/mbS0uiwoqBbWlKZNh29OiU+
	3JBEAhi8NaiSbi+uJYZPfA/X7oFomIN0
X-Received: by 2002:a05:600c:34cb:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4bb7da4c5d3mr66218705e9.34.1795019407665;
        Wed, 18 Nov 2026 08:30:07 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:30:07 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 18 Nov 2026 16:29:40 +0000
Subject: [PATCH 18/34] perf cs-etm: Don't special case per-thread mode
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
Message-Id: <20261118-james-coresight-jit-v1-18-dad4d90747f6@linaro.org>
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

This was always an extra edge case to have to understand, and keeping it
would require another new special case in the following change to add a
timestamp decoder tree per trace ID. Removing it makes both cases
simpler and nothing is really lost anyway. The only change needed is to
seed every trace ID context with the TID from the AUX record, rather
than only updating the single special context.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 34 ++++++++++++++--------------------
 tools/perf/util/cs-etm.h | 10 ----------
 2 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 5c98c7960f82..accd4ffc19aa 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -51,13 +51,6 @@ struct cs_etm_auxtrace {
 
 	/* Trace timestamps are available and not disabled by --itrace=Z. */
 	bool has_timestamps;
-
-	/*
-	 * Per-thread ignores the trace channel ID and instead assumes that
-	 * everything in a buffer comes from the same process regardless of
-	 * which CPU it ran on. It also implies no context IDs so the TID is
-	 * taken from the auxtrace buffer.
-	 */
 	bool per_thread_decoding;
 	bool snapshot_mode;
 	bool has_virtual_ts; /* Trace timestamps can be used as kernel time. */
@@ -717,14 +710,8 @@ static struct cs_etm_traceid_queue
 {
 	int idx;
 	struct int_node *inode;
-	struct intlist *traceid_queues_list;
+	struct intlist *traceid_queues_list = etmq->traceid_queues_list;
 	struct cs_etm_traceid_queue *tidq, **traceid_queues;
-	struct cs_etm_auxtrace *etm = etmq->etm;
-
-	if (etm->per_thread_decoding)
-		trace_chan_id = CS_ETM_PER_THREAD_TRACEID;
-
-	traceid_queues_list = etmq->traceid_queues_list;
 
 	/*
 	 * Check if the traceid_queue exist for this traceID by looking
@@ -2225,15 +2212,22 @@ static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
 	/*
 	 * Per-thread mode still uses a queue for each CPU, but that CPU can run
 	 * different threads. When the TID from the AUX record on a CPU changes,
-	 * re-initialize the thread using the AUX record/buffer fragment TID so
-	 * we can start decoding even if the context ID packet was cropped or
-	 * they're disabled.
+	 * re-initialize the thread for each trace ID using the AUX record/buffer
+	 * fragment TID so we can start decoding even if the context ID packet
+	 * was cropped or they're disabled.
 	 */
 	if (etm->per_thread_decoding) {
-		struct cs_etm_traceid_queue *tidq = cs_etm__etmq_get_traceid_queue(etmq,
-							CS_ETM_PER_THREAD_TRACEID);
+		struct int_node *inode;
+
+		intlist__for_each_entry(inode, etmq->traceid_list) {
+			struct cs_etm_traceid_queue *tidq;
+
+			tidq = cs_etm__etmq_get_traceid_queue(etmq, inode->i);
+			if (!tidq)
+				return -ENOMEM;
+			if (thread__tid(tidq->decode_thread) == etmq->buffer->tid)
+				continue;
 
-		if (thread__tid(tidq->decode_thread) != etmq->buffer->tid) {
 			thread__zput(tidq->frontend_thread);
 			thread__zput(tidq->decode_thread);
 			tidq->frontend_thread = machine__findnew_thread(
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 71b1ef321625..ffe3a33885a7 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -195,16 +195,6 @@ struct cs_etm_packet {
 
 #define CS_ETM_PACKET_MAX_BUFFER 1024
 
-/*
- * When working with per-thread scenarios the process under trace can
- * be scheduled on any CPU and as such, more than one traceID may be
- * associated with the same process.  Since a traceID of '0' is illegal
- * as per the CoreSight architecture, use that specific value to
- * identify the queue where all packets (with any traceID) are
- * aggregated.
- */
-#define CS_ETM_PER_THREAD_TRACEID 0
-
 struct cs_etm_packet_queue {
 	u32 packet_count;
 	u32 head;

-- 
2.43.0

