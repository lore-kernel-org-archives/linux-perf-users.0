Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A631047125C
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305855; cv=none; b=DZkTx4vLyxpObNAqMnC8Dhrwt+d1VqXdT+3WbwZ/3gANOX7EJ4Zr3rrG5CLRjDLAvs7Vbaky90AFIBa6qDmS5RjVCA3Tjwebe4DW1bXQYwyKNn6EVya0BuapBBBe2ECsZjusnLKeeUXNCZbjacbi3FWwKhieHSGCyztt+vmcCbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305855; c=relaxed/simple;
	bh=reIErwj1+cOWTcSHBC5mNblnE1436q/H5bkvt6GtBUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gj8fS0XYiAGIcgMTNuPwO92RO9he4thDSrdUKWKW0wsCuhKoIfHpFP7RopYxNN6Abc1w667CJQRWxUzIPzJd+8BM33bSJkfDtcbFnOuaFDHWinX2ZpC6k+5bviRWdWQg5KqEwKBSTw4UGRsVslgwiudWrzQVSi6WsTkHw6nZegA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L3CZjypT; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L3CZjypT"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47fecbbafdaso285741f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 02:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787305845; x=1787910645; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3VQqnhce33GsylOL+ZatKl0byJTqhAxHVQiF8A3WGaU=;
        b=L3CZjypTRXw+6MZY3/FVGuIR94VR3e0Se832UUivRCOuvk56hGllbtx+IWZbr855G/
         /0YWfogmt7NmOCHj6UG/DDByicOkbgdanWSe02SDmHqqGGwF7IzwscMS2iFWb9IGu+uA
         xi4x7tFISVQP/TnN8xIBskXiAVRRdztgMNVGh/jqYx25PYJpyEAqAfWWEX6Fj7SLWdAG
         nzSg5Y2xvHr9A/+hrzIKboGeZqG372KROx1gq0c41H+Rmh26fcFr3AaPOvNDLQM0VWyH
         6Q1JLJgRqVJHTvtjb6jtrwBDhC4TLa3H5NqHIpRa5UDlsRKuku+/D2ScQPJ17Oea7FNz
         pkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787305845; x=1787910645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3VQqnhce33GsylOL+ZatKl0byJTqhAxHVQiF8A3WGaU=;
        b=ZJdTk3GSZWQGtwKmoSkDlhj5lzM9akd6SHq5JoplCpFCJ8Q2AUEnoUF7z1VbZSTgZv
         77LOlY9635tz6QTfmW4LHUlQ8nOPUTyauRDpjNGlGoom/Xc9sww11VwZg6mz7rW6s1jw
         FvqP864wZoq6pMBuKc4U/i3h1ysA/UEBLtpO5g+8OMwuk/tc+KPcfOW6wPGBePV/Ar1f
         yJdcPuLn/IoNHKs+aZIM4yTT9/DTEM5ehHqLr/waR9AwTAHb+gKRF4lEbmg2vEwJx8Nb
         abhwxzy7DQzsSXOjovlMlnmaHbQC4STQWilaSw3zWQ5gNGTTrWlEu5LxspYx1/WQFMd5
         r5Rg==
X-Forwarded-Encrypted: i=1; AHgh+RpMIkzr6UwcKmiQ8rP8ywc3SLAZ5A313c6pP3LlIXct0bO2Yw/ZCg8Wb9AAy7+JBQDO1STU5AUDvriY7KBu44W1@vger.kernel.org
X-Gm-Message-State: AFuF++ldxB+rjyj59xsZj1t2ZLjEjiBTPebmsFjpkB1j6XTkEvfRpOtU
	n9f55XtDWDixL1Eq+/lwi5pjdHTXIo6IQrU3K7iTpNcilt0slJvT3BMdVdjqBtG/5RA=
X-Gm-Gg: AR+sD11cVZY1nUssMMcin7U2IVAmaNtVGR9zaUOIBo7ySyWFfmn3MBzYamGlFwVapc1
	S+N2YHNJRCpIcPwedf1rHE04IHl7EZ+M30FwO1u4M6goVHle8wJ9LHzXPF2Em/oUozl+TkrLLW5
	vQMZoWdU1RWXippT+x+cHbVN+FF/IUUvBAt5Z9cewgZJgMzbhhrmAgRgjLE5gy/Nnfh0D4IPtl2
	KUc1BaisptUzgd1yLDlg3DfZu6m+26FV9X3ivpd55cBDwdAGIA5E94axhOmV1nUa9F6XdWje+zT
	JafSIDKF25eBa15Lah+ZoNDFPMT2jUeBZZciNQcNUviAAT9MItqY6h2erDZWbGIHk7AZrmranwN
	sNpBQGD3ZnyR+VhYJKHP3M561Gw2adCdKou+bk0ZTscFaEngUrYzYEvJrxnxnZ2aNzlilRSY70x
	S1czHgY4EB3dgp0oSdhASU02tKk68TaMDG7HzuEpuPW+v0AkvgSv1yffdOtY8qyXck
X-Received: by 2002:a05:6000:420c:b0:47f:eb5c:9b25 with SMTP id ffacd0b85a97d-482c0b83b3fmr6279797f8f.10.1787305844266;
        Fri, 21 Aug 2026 02:50:44 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c3775sm14474284f8f.26.2026.08.21.02.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 02:50:43 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 21 Aug 2026 10:50:31 +0100
Subject: [PATCH 3/6] perf cs-etm: Synthesize missing HW_ID mappings for raw
 trace
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-james-cs-hw_id-output-failure-v1-3-9d532ddabcc3@linaro.org>
References: <20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org>
In-Reply-To: <20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org>
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

From: Leo Yan <leo.yan@arm.com>

The CoreSight driver emits PERF_RECORD_AUX_OUTPUT_HW_ID via
perf_report_aux_output_id(). If the perf ring buffer is full,
perf_report_aux_output_id() can fail to emit the record and return
silently.

When at least one HW_ID record is present in the file, perf skips the
legacy metadata-only trace ID mapping path. Therefore any raw AUX queue
whose HW_ID record was dropped can be left with an empty traceid_list,
and cs_etm__create_queue_decoders() will not create a decoder for that
queue.

Backfill missing mappings for non-empty UNFORMATTED queues whose trace
ID map is still empty after the HW_ID record scan. Real HW_ID mappings
remain preferred and are not overwritten in case someone is trying to
link what the kernel outputs to the raw trace dump.

Signed-off-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 44e20067da1f..dd15e91b7b38 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -427,6 +427,39 @@ static int cs_etm__process_trace_id_v0_1(struct cs_etm_auxtrace *etm, int cpu,
 	return 0;
 }
 
+static int cs_etm__synth_unformatted_trace_ids(struct cs_etm_auxtrace *etm)
+{
+	struct auxtrace_queues *queues = &etm->queues;
+
+	for (unsigned int i = 0; i < queues->nr_queues; i++) {
+		struct auxtrace_queue *queue = &queues->queue_array[i];
+		struct cs_etm_queue *etmq = queue->priv;
+		u64 *cpu_data;
+		u8 trace_id;
+		int ret;
+
+		if (list_empty(&queue->head) || !etmq || etmq->format != UNFORMATTED)
+			continue;
+
+		if (!intlist__empty(etmq->traceid_list))
+			continue;
+
+		cpu_data = get_cpu_data(etm, queue->cpu);
+		if (!cpu_data)
+			return -EINVAL;
+
+		ret = cs_etm__metadata_get_trace_id(&trace_id, cpu_data);
+		if (ret)
+			return ret;
+
+		ret = cs_etm__insert_trace_id_node(etmq, trace_id, cpu_data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int cs_etm__metadata_get_trace_id(u8 *trace_chan_id, u64 *cpu_metadata)
 {
 	u64 cs_etm_magic = cpu_metadata[CS_ETM_MAGIC];
@@ -3801,6 +3834,16 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 			goto err_free_queues;
 	}
 
+	/*
+	 * Add fake IDs for any unformatted queues missing them. The IDs
+	 * themselves are only cosmetic in unformatted mode (raw dump output),
+	 * but a decoder won't be created if one was dropped and Perf can be
+	 * resilient to this.
+	 */
+	err = cs_etm__synth_unformatted_trace_ids(etm);
+	if (err)
+		goto err_free_queues;
+
 	err = cs_etm__create_decoders(etm);
 	if (err)
 		goto err_free_queues;

-- 
2.43.0

