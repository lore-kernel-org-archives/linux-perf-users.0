Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E569F470EA8
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305784; cv=none; b=iXh8mywGreMfpPcb2G71zhYBf4iS/H5L9+GOcFybWcD9AJ4EdVsE7rkoCHSM+Qz76YoYPMohHl41idvsAaDhK+G4zp8Xlkc5M85vVKoAokJxtvjmGPKdOGTSLjXCpVSZ8Aicx8GIxMgakCJVFObiIZDZL459vJx0gKhdYw0jC7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305784; c=relaxed/simple;
	bh=GmFPf0hS6ejuPSWWrOe80fbWivZhcfucDIR0UYfgWe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mMlYYqTcpt3wFEhl+K3zQijUhTE9KBfsML/d4k2WpKaXMUPqNXutY2i1aEkN3S+xgp7YhPdeJ9Hmc9ym1Vq839xVqNVTjOqJMEOk7WBKRg7yDo0q7fcagfTS+3J7QsORIP/XhDkAd/tQQfL10FQ3imQWrhPP3C+4JSp1usOMmAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JanPLl/h; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JanPLl/h"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso8828545e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 02:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787305770; x=1787910570; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tvr/xW0gPJp55FsCc7tSxN43AAHHoShgvkJBQUdWPcc=;
        b=JanPLl/h1RfBcg1aCSM8G6aHLcVTL9ArM5LbozpK0IssaXyhiDCETUff8+ZvvypPmN
         G+ip8Iyl6EPyLljVCBrU0VnTeouagxc5FwrFXDwEWatkotuue+xqLS1TlJuKQVdDVnB1
         RgEi7nm6VyMEa1Y71tzLBW0CUFIqh0GZep7Tn2dfRK3NpBDW4BBuCcN8nhlNAc3m4cV8
         2orbSG7rz0h1SnZtPWvsCbdJ0UUPZnXQ4C1eulciVyybzoYqR5Iy7PucolUm4b5yJOeV
         lWm7d6U4U/3l2zN4B61Ydg9L+2d5KzIJf+/dILsMTWgHm9fg0U1GXsHFtMKWGc/wI5on
         Hn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787305770; x=1787910570;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tvr/xW0gPJp55FsCc7tSxN43AAHHoShgvkJBQUdWPcc=;
        b=mEAHNEpVlse2X5jOh9gkuq2ACzogExE7LuhF/n1ltLR1sp8AOEroGDlw56laXDfgbg
         dvLz59xfadzor8di5HZ4zn/KVUJy2vUE+xfMUHIiScAH1iKWBle9vbChu8PQBE/RyCL/
         KvvjWlPcpvlouKxoChpkkwP4Unmp4tl2Cl2X/KQbaK0NnElwdlzgB214iQA3NiwQfRmw
         og3QM6hisVqSIb2H8Ik2cy1iqTUkU5FvcICxDtnjsA/GLCIR5pc1lphRr2GQjZ7Cb7P0
         Y4nmurGCUB75j+PA8llwCJFqBzXkNadoMZqqwN2FgSt1BNibn70OpKFh+OGmTABUFhiY
         DOvQ==
X-Forwarded-Encrypted: i=1; AHgh+RolvE0YemnXsuD0Tfve2CiP33mV0QiBOe8RqIr3tprq97bqM+0vV/K6wefUEpIEo7uNqUOO+mir4Lz+v9v23ixo@vger.kernel.org
X-Gm-Message-State: AOJu0YxLEKAku5/RMtHBN1ZOzD7zfMx1TYHw5iSDZf/bjyA1STnTWSCp
	OJZ1JeV3IumsGnD9AMTK241mKDyqMOcC2OUj6QaoRntkyz99mpFnVsPPse4SlPFDp+s=
X-Gm-Gg: AR+sD12AiFQ2kZnZ+jwH9lGzlDaAohx+eAyQbTYbgsYn13aR7oaLajK9IckrAoi8z1L
	CJwb6oUeRABTWMig7EPQ1Jp7F5YZs/nZWSUKUxwWOsVZEt1FKS4L45kWEKnODsaVbIyrmw6KFjT
	GW71p9qz0hjLK6lF6iD5aZyO8FBKGVlg5CgAPNn0iKE5gje2AGdAf4byo6BWKV9qE4cpDMptl1H
	MynND8B9O0BuRE1o/Q+cpgPK72DRqvWTbWkTBek3/BsMPGfKz+tWYKMFjXxzAmJoKlY5+Ag7rgq
	rYycYrOmN6/pCNfOlEuVk4il9Q2RhcWS6givj+8VBBt4XkH95m9cagXW+Pt2gRs75rRIHDaJ2oU
	AJeDJtSKJfrg0t+qo7fEn2NPI7hU+4RTP0/09SotiudV26/2lO+2kqzdCmDTMHOZyWSXyvOU4jP
	EWw5m0xj0DqC9Wwn3LgLn6Qhv7jruGg39rDa80DBCdSJkFQEuW/98NUFmKrADXryRK
X-Received: by 2002:a05:600c:8b0f:b0:496:c379:b2a1 with SMTP id 5b1f17b1804b1-499b82e8e92mr80267695e9.2.1787305769809;
        Fri, 21 Aug 2026 02:49:29 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14d05a6sm17683479f8f.35.2026.08.21.02.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 02:49:29 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 21 Aug 2026 10:49:02 +0100
Subject: [PATCH v2 04/14] perf cs-etm: Use per-CPU queues for per-thread
 mode
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-james-cs-unformatted-per-thread-fix-v2-4-00c4fd0701b4@linaro.org>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Cc: Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org, 
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

This fixes two problems, firstly per-thread mode didn't support multiple
threads well or at all because we always use queue 0 and assumed it was
for a single thread. However, Perf attaches to all child threads of one
process or allows multiple threads to be specified on the commandline.
This meant that trace before a context packet could use the wrong MMAP
for decoding, and threads running concurrently wouldn't be interleaved
properly.

The second problem is that we'd put all HW_IDs into queue 0, so if a
thread runs on multiple CPUs then it would receive multiple HW_IDs and
trigger the assert that unformatted trace should only have 1 decoder
per-CPU:

  $ perf record --per-thread -e cs_etm//u -- taskset --cpu-list 0 \
     taskset --cpu-list 1 true
  $ perf script

  perf: util/cs-etm.c:3381: cs_etm__create_queue_decoders: Assertion `decoders == 1' failed.

Fixes: 9182f04a85b2 ("perf cs-etm: Pass unformatted flag to decoder")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index d423f1cb408f..ccf886efff95 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -295,9 +295,6 @@ static int cs_etm__insert_trace_id_node(struct cs_etm_queue *etmq,
 
 static struct cs_etm_queue *cs_etm__get_queue(struct cs_etm_auxtrace *etm, int cpu)
 {
-	if (etm->per_thread_decoding)
-		return etm->queues.queue_array[0].priv;
-
 	if (cpu < 0 || cpu >= (int)etm->queues.nr_queues)
 		return NULL;
 
@@ -1268,7 +1265,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 	queue->priv = etmq;
 	etmq->etm = etm;
 	etmq->queue_nr = queue_nr;
-	queue->cpu = queue_nr; /* Placeholder, may be reset to -1 in per-thread mode */
+	queue->cpu = queue_nr;
 	etmq->offset = 0;
 	etmq->sink_id = SINK_UNSET;
 
@@ -2160,6 +2157,7 @@ static void cs_etm__flush_all_stack(struct cs_etm_queue *etmq)
  */
 static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
 {
+	struct cs_etm_auxtrace *etm = etmq->etm;
 	int ret;
 
 	/* The current block is not finished */
@@ -2188,6 +2186,27 @@ static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
 	 */
 	cs_etm__flush_all_stack(etmq);
 
+	/*
+	 * Per-thread mode still uses a queue for each CPU, but that CPU can run
+	 * different threads. When the TID from the AUX record on a CPU changes,
+	 * re-initialize the thread using the AUX record/buffer fragment TID so
+	 * we can start decoding even if the context ID packet was cropped or
+	 * they're disabled.
+	 */
+	if (etm->per_thread_decoding) {
+		struct cs_etm_traceid_queue *tidq = cs_etm__etmq_get_traceid_queue(etmq,
+							CS_ETM_PER_THREAD_TRACEID);
+
+		if (thread__tid(tidq->decode_thread) != etmq->buffer->tid) {
+			thread__zput(tidq->frontend_thread);
+			thread__zput(tidq->decode_thread);
+			tidq->frontend_thread = machine__findnew_thread(&etm->session->machines.host,
+									-1, etmq->buffer->tid);
+			tidq->decode_thread = machine__findnew_thread(&etm->session->machines.host,
+								      -1, etmq->buffer->tid);
+		}
+	}
+
 	return 1;
 }
 
@@ -3245,7 +3264,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 
 	if (aux_offset >= auxtrace_event->offset &&
 	    aux_offset + aux_size <= auxtrace_event->offset + auxtrace_event->size) {
-		struct cs_etm_queue *etmq = cs_etm__get_queue(etm, auxtrace_event->cpu);
+		struct cs_etm_queue *etmq = cs_etm__get_queue(etm, sample->cpu);
 
 		if (!etmq)
 			return -EINVAL;
@@ -3258,6 +3277,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 		auxtrace_fragment.auxtrace.size = aux_size;
 		auxtrace_fragment.auxtrace.offset = aux_offset;
 		auxtrace_fragment.auxtrace.idx = etmq->queue_nr;
+		auxtrace_fragment.auxtrace.cpu = etmq->queue_nr;
 		file_offset += aux_offset - auxtrace_event->offset + auxtrace_event->header.size;
 
 		pr_debug3("CS ETM: Queue buffer size: %#"PRI_lx64" offset: %#"PRI_lx64

-- 
2.43.0

