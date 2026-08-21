Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A68E24BBF0
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305788; cv=none; b=tmNmkaWcEjkSseTuUlqJmf1HignP2ckqDrstp7heir4m+Kk/bP851IQQ6ZauAvlciFtFaIgf5uTWHQbw2xXwY5uLRjabUCeiCoSbYEYx5TgIvlQGrnkblhvPWdoFvAqPUkPYzWzr/rho6z2SQJ1joqAyUnI7U0tzFe6cYEcoJMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305788; c=relaxed/simple;
	bh=VHbTeSJfXkNdpa7GWemni8wgMespqnXWXrv3pQGnqWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TD/hRmAR3UEUPIFXrUUCaF4fu0OKAuVHUz+5F/boteQq/4zNVW9BXer7Iv2h0aKlSakd6ohnc3q2Hq3c+lZCZwYAVbz7lVvhD42268Owj9A/gVSL5S1gsyUnmT4nYyFsGOM7kEkwUHbsxvcTSvQ5+2YkZ5MysANvQwo/4DLl1W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aTVRvQmc; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aTVRvQmc"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4815bce4652so504477f8f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 02:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787305779; x=1787910579; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FLPGCt4Z2rnGiWCr3RwF/7TLVu4WTyiGBE7+q4fWYws=;
        b=aTVRvQmcDOKOQbm+FsJqrmVuxXxD5zOzPq2TM8Aiu9qyrY0ZooKc4gLhRp2r2dZVIk
         PcvbMS4tjLGy9uSuAsACkDg8GTJAiN9oA26bkaLp0Z8ejpQ/PDTffablPBDEdYdvqL9d
         qeq9vcOUXdFAo+627E73sjorEEQK8HDvnDXU9T0I4xuRgDbNh8erahalB5FgjWPM2HXn
         D11VS83QwU4JGbZe7gkcqqIizzyqpzqSTtipskvDcrHTqufleChdIGIvnOPq7QLD8v2u
         qUbwt4k3rTEMiZsn1rDGTuH82wVvHGANJnRm8Fo2m6x3klxclfD1K40ibhoWgTa52v4X
         WwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787305779; x=1787910579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FLPGCt4Z2rnGiWCr3RwF/7TLVu4WTyiGBE7+q4fWYws=;
        b=HhBBw5eM7A52DJEC8Hp9UqRh7cE7Ng4djc8wtD5G/qKTGSFw4mloBOcpBcELtYWonY
         +WiN8zJbED0f+O5JrcKDtt2JkOwuJaG0YqqM4yF2u28WnjBzORPDe6ylJh4+4KbMl72W
         L0zNK2/VvCLCOY2+SxRd9r4a6p/jk95zH1S7kufNw7g12D9yfBC97P4Q8DfqxMZZgJ45
         aL4QOga+WfkyqA9P4eCcEEtydyurfXDm88hR80YU2yA1dOJWlkOHAL2a/k+hQPDXodF0
         WcZ8K0scvOf7dursAcGpiEEllG+p7aD7u9YaTTw+lX6nONGxUu+NxwpKYUxa9eMSYEdF
         JtPA==
X-Forwarded-Encrypted: i=1; AHgh+RoD26MJI0CfdTeT9b2VY7cCjVd3UVUXRKXo0H5lZkoiI64Kg+SBqw6poNo7ThjFHjrVhd0FfQd7sG0VsNIxVpF8@vger.kernel.org
X-Gm-Message-State: AFuF++ku9XPfR7LrAXvcCvHmeCcWgh5shMnHZdtJIwNSnT/EZi9O81cm
	e0FhweVMKpyNOxnyJivu4kO714DoFX5V4h8XqJ54w6h88DcO1DUhzDUWDo2VWlqpiag=
X-Gm-Gg: AR+sD10DoMxFkTrabRlaeVQICYgkoE3/Zts3NJKvbc932Ck2+k6hevQ7o2Akvqcdmv2
	GUDJmpVAMEjlet6Ohw6QCNcEjuSJdikG4P42OG5BWB25hQ1tI084PZiHmy64KkY80ma9I2495Qa
	t0LENSPDXazC4QL3GwEZM6l8LYOjdWbDiVGSM+6KTw6ICpDAJ87wUdn4O5kjeKitodIUkXwVVOu
	/WaDJYYna8EhakiveksKgpq3Gj1fiAI/K69/q/wfU7+r3S5xlLWJxJIH6zzLo0boFKHF230Yw1Y
	qajqQehHe7cXDPwEFcyj0/g48tMCKCHHdRZen/gr9vH08MuXb/tjw/CXns//Jww19Dq1YhYG82u
	k0ADl5RaulYXDCYqt8CbAkzzwtaViZ3q64+mB//3N5l/fOQawe3eQLIvZUqWUG6w3hTwu6pDG19
	sC957zHwt3NhwUo05rko0CPsO38A7pHotoueDBiTNwACgrYZi+Lfs7Dghgt+CAw8SI
X-Received: by 2002:a05:6000:4b1b:b0:482:bb55:8bda with SMTP id ffacd0b85a97d-482c0b5bf64mr7702886f8f.5.1787305778190;
        Fri, 21 Aug 2026 02:49:38 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14d05a6sm17683479f8f.35.2026.08.21.02.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 02:49:37 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 21 Aug 2026 10:49:07 +0100
Subject: [PATCH v2 09/14] perf cs-etm: Queue partial AUX records
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-james-cs-unformatted-per-thread-fix-v2-9-00c4fd0701b4@linaro.org>
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

In snapshot mode AUX records may straddle the boundary of multiple trace
buffers. Currently we only queue AUX records whose range is contained
wholly within a single buffer.

Fix it by queuing any partial AUX range that overlaps any buffer.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 54 +++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index ccf886efff95..d1eb4ec17bbd 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -3197,7 +3197,8 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 	union perf_event *auxtrace_event_union;
 	struct perf_record_auxtrace *auxtrace_event;
 	union perf_event auxtrace_fragment;
-	__u64 aux_offset, aux_size;
+	__u64 aux_start, aux_end, auxtrace_start, auxtrace_end;
+	__u64 frag_start, frag_end, frag_size;
 	enum cs_etm_format format;
 
 	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
@@ -3245,43 +3246,42 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 	}
 
 	if (aux_event->flags & PERF_AUX_FLAG_OVERWRITE) {
-		/*
-		 * Clamp size in snapshot mode. The buffer size is clamped in
-		 * __auxtrace_mmap__read() for snapshots, so the aux record size doesn't reflect
-		 * the buffer size.
-		 */
-		aux_size = min(aux_event->aux_size, auxtrace_event->size);
-
 		/*
 		 * In this mode, the head also points to the end of the buffer so aux_offset
 		 * needs to have the size subtracted so it points to the beginning as in normal mode
 		 */
-		aux_offset = aux_event->aux_offset - aux_size;
+		aux_start = aux_event->aux_offset - aux_event->aux_size;
+		aux_end = aux_event->aux_offset;
 	} else {
-		aux_size = aux_event->aux_size;
-		aux_offset = aux_event->aux_offset;
+		aux_start = aux_event->aux_offset;
+		aux_end = aux_event->aux_offset + aux_event->aux_size;
 	}
 
-	if (aux_offset >= auxtrace_event->offset &&
-	    aux_offset + aux_size <= auxtrace_event->offset + auxtrace_event->size) {
+	auxtrace_start = auxtrace_event->offset;
+	auxtrace_end = auxtrace_start + auxtrace_event->size;
+	frag_start = max(aux_start, auxtrace_start);
+	frag_end = min(aux_end, auxtrace_end);
+
+	if (frag_start < frag_end) {
 		struct cs_etm_queue *etmq = cs_etm__get_queue(etm, sample->cpu);
 
 		if (!etmq)
 			return -EINVAL;
 
 		/*
-		 * If this AUX event was inside this buffer somewhere, create a new auxtrace event
-		 * based on the sizes of the aux event, and queue that fragment.
+		 * If this AUX event overlaps this buffer, create a new auxtrace event
+		 * for the overlapping range and queue that fragment.
 		 */
+		frag_size = frag_end - frag_start;
 		auxtrace_fragment.auxtrace = *auxtrace_event;
-		auxtrace_fragment.auxtrace.size = aux_size;
-		auxtrace_fragment.auxtrace.offset = aux_offset;
+		auxtrace_fragment.auxtrace.size = frag_size;
+		auxtrace_fragment.auxtrace.offset = frag_start;
 		auxtrace_fragment.auxtrace.idx = etmq->queue_nr;
 		auxtrace_fragment.auxtrace.cpu = etmq->queue_nr;
-		file_offset += aux_offset - auxtrace_event->offset + auxtrace_event->header.size;
+		file_offset += frag_start - auxtrace_start + auxtrace_event->header.size;
 
 		pr_debug3("CS ETM: Queue buffer size: %#"PRI_lx64" offset: %#"PRI_lx64
-			  " tid: %d cpu: %d\n", aux_size, aux_offset, sample->tid, sample->cpu);
+			  " tid: %d cpu: %d\n", frag_size, frag_start, sample->tid, sample->cpu);
 		err = auxtrace_queues__add_event(&etm->queues, session, &auxtrace_fragment,
 						 file_offset, NULL);
 		if (err)
@@ -3321,6 +3321,7 @@ static int cs_etm__queue_aux_records_cb(struct perf_session *session, union perf
 	struct auxtrace_index *auxtrace_index;
 	struct evsel *evsel;
 	size_t i;
+	bool found = false;
 
 	/* Don't care about any other events, we're only queuing buffers for AUX events */
 	if (event->header.type != PERF_RECORD_AUX)
@@ -3354,11 +3355,14 @@ static int cs_etm__queue_aux_records_cb(struct perf_session *session, union perf
 			ret = cs_etm__queue_aux_fragment(session, ent->file_offset,
 							 ent->sz, &event->aux, &sample);
 			/*
-			 * Stop search on error or successful values. Continue search on
-			 * 1 ('not found')
+			 * Stop search on error values. Continue search on
+			 * 1 ('not found') or 0 ('queued')
 			 */
-			if (ret != 1)
+			if (ret < 0)
 				goto out;
+
+			if (!ret)
+				found = true;
 		}
 	}
 
@@ -3366,8 +3370,10 @@ static int cs_etm__queue_aux_records_cb(struct perf_session *session, union perf
 	 * Couldn't find the buffer corresponding to this aux record, something went wrong. Warn but
 	 * don't exit with an error because it will still be possible to decode other aux records.
 	 */
-	pr_err("CS ETM: Couldn't find auxtrace buffer for aux_offset: %#"PRI_lx64
-	       " tid: %d cpu: %d\n", event->aux.aux_offset, sample.tid, sample.cpu);
+	if (!found) {
+		pr_err("CS ETM: Couldn't find auxtrace buffer for aux_offset: %#"PRI_lx64
+		       " tid: %d cpu: %d\n", event->aux.aux_offset, sample.tid, sample.cpu);
+	}
 	ret = 0;
 out:
 	perf_sample__exit(&sample);

-- 
2.43.0

