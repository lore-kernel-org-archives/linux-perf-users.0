Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019404;
	b=3LgTuiL/Z0FHUKE3E+hsDmlxgDPqtZuIhFliuPDE7UPTw0Xg8LtgZQAHzIANiV7e6TFY
	 Z0b9OG+lXYVH4bavhrKzsrjUbHx9J9gbiNc7F9WCtLQERV0I7WHVbaAlHGxNwISZY/KUN
	 CIxuwUui+UA7/GcfGDqxs4bJwphKZe1jN+M3CwErsRiuaHUzmRKukDnpWqFbHyenTYPNq
	 9yj5x9AKsFCcWPpUfZegsp2u08tfHS1AuAtjgtgz3EXp5v8HNgjg5W3TtK0fDqkCHwk0n
	 oPwFMNL70UN1m+BEClLkNoJwC5Z78hrslqKNQtFHHYDvZ55Y2BC0HEnKBkcqahh8X8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=9TvI/tcWqsDiAaR0SImg0w5hNJWOXoXa6vuM34fV/cU=;
	b=0F7q9siiqPaCgzW3qV+OSvUF+K8AmdKVr6HHOHitFfNPqh/Ci1bTgzWYLOJ1FgpPMBOm
	 deZJa9Xp212muRI/Ipy248Wy4GgaW97a8xNc+kgrzqv6DA+7MRDj+EFH5Pzfxt8jEerVx
	 +4D/5hz+oZ6AqpKvclHQIJHisibj3ZMy9u6aK8T1prmwojjPEe7A6FJbtvHCPykpt9Jow
	 9wvJMYqR5z02IZ7Qge8GkM/3k/ETA2oZ7LaakTXN9yvk254J1qs+FlkajU5jLlp/pds0j
	 Xsv9UOID0j4R5v2LQxb1e2DmdOzgxKit4qGjeen20rTr7W5UY3fGcc8OAP/waOcHPnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cra1kaKs;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CE4606A33D
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12CE4606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cra1kaKs
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so13424005e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019398; x=1795624198; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9TvI/tcWqsDiAaR0SImg0w5hNJWOXoXa6vuM34fV/cU=;
        b=cra1kaKsyCsDSDCYmwefAdiIgXLO+xoK2UKY3tlZZsyrR+Jg3I1qSOtlqGu7vF97Ow
         BT3Ym0uW/fpOEBRPF6vBGGhc8RrBFW5cIa1SEEveJ+xU4qVHObc9+rqZ8XUJiKNP0lKP
         +eTF5O8XiP4xOJBEQgBEaJMx780sJJCitNqVRp24Cf6sulNsII10sOikSFMY37Oh7Vgf
         mMzeIVRiqtf8Jg4EqyZSflr587Q34oc7krvjNLF2gGvjb+C8xM6UWqNACmaXDMrHGeZz
         v/y7KicCNJa9QjSaZfnPcg0Kds6tCFqmlPupiHQ3j9VPdmfWWtpaWD909OrJ1CEMsSXR
         hy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019398; x=1795624198;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9TvI/tcWqsDiAaR0SImg0w5hNJWOXoXa6vuM34fV/cU=;
        b=DQaW0pKO+fdY54zltJrFFEAOUuuovH3/Pw4sWn/vK2mTeCeBBMc0+yOrrT/T9V2HTM
         YVEC3TtJikG0gMzuBsM0LCdQWW0T3dUqOCcwJtKElL5WxRx34G2yj1A6DjLm449SEg3R
         ziAJxyP6ZWniPfH4XKr6eI/4on2dLT4eaFexKTVgvCsHR+5BHsEkDnjo/em2KyCq40H0
         aKDO9rMNUr1rAp5tjfhKJb0fmdYQiRSc3qSpsG2ks0tPY9grbojbUiJ48nHC+kE2lz+l
         449GcPuz24hXa9pWtR3XVmbdqF8i27Brh1FbrlfC7Qcb7un3wjkUfizoWzq/iMWrIj/z
         o4HA==
X-Gm-Message-State: APuU4Z9eNXfpiLl2qLC8Hwm2SxcoYv913F8HMx55U49sP2PGTeI1LHXV
	3H5HFKb8DditiKkGY69pkY/u1Hwkveo+ClrigZ+AJeDTh81r3G91qH5XXt/2Hf9Ai5QtbODVa/l
	GxYj1Euc=
X-Gm-Gg: AYBFou323QR5XWaiOjZYQJzIoHaw+DXzKZeIPA3Qqk1UYlfyB2eXwsUcA7++2TarR3g
	TZK3BtlinNrZzDQ6RKf0iTbV+M7ZfxKK1srkIqH6iYcljgjVtVB9vT0bQuVowVYqMnS6A29M6vD
	eHxYqpfFxTZ6cE79vQTTGkD7JSFPjNx7c6CCm9Ncy7M0kYPCuXPKpQ4a+XyHlrgHqInpC1d9Esn
	XlkyRibwPSD7PI1+rm4bRZad+nvQzAmkxgsDreJoyIkJAeBwbR4b3j8k0znKjqCjMwq3gsVEKNI
	VXkkOuTDDAgM6ciq3CnmQ0C5ya2H79Bh45C1QwepzY1xPPORPjSzK887MFYr1vE7fDdEy1wntKI
	JkLCmQwjQoIG/YGsp+GpLwrGj9B9SvZ0/AskvUDHmMTBF5ugGGCplCto9jJnr/hy7+vBPD6bRBh
	9ni+pPMPjREL+ycpde2OMC6To79loT8Sw0+ba2OpAQshcYHgMBUVp82sWYAVVqkKk5jyunbIcnm
	GyYbZRf8dWyUUhcF+uPWaWLZtB+JiNMWV61UHlYxLYZiO/ilqu04zj4f/VZC5LOOitCn6GWMBXh
	CHC/HVYiVFE5A0QsfjdbX0K8KmnP5S33
X-Received: by 2002:a05:600c:8b8a:b0:4bb:52bd:a3c7 with SMTP id 5b1f17b1804b1-4bb7da2240amr67857325e9.6.1795019398311;
        Wed, 18 Nov 2026 08:29:58 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:29:57 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 18 Nov 2026 16:29:32 +0000
Subject: [PATCH 10/34] perf cs-etm: Remove old pipe mode support
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
Message-Id: <20261118-james-coresight-jit-v1-10-dad4d90747f6@linaro.org>
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

Pipe mode hasn't been supported since we added several peeks to
cs_etm__process_auxtrace_info_full() that require random access. Even if
it was supported, we would have to buffer the whole file anyway to make
fully ordered decoding work. You don't know if one core stopped tracing
for good or whether to wait till very end of the file for the next one.
IntelPT has the same issue, see 'perf-intel-pt.txt#Pipe mode'.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 38 +++-----------------------------------
 1 file changed, 3 insertions(+), 35 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index fb4582dc378e..11ebfdf1e933 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -66,7 +66,6 @@ struct cs_etm_auxtrace {
 	 */
 	bool per_thread_decoding;
 	bool snapshot_mode;
-	bool data_queued;
 	bool has_virtual_ts; /* Virtual/Kernel timestamps in the trace. */
 	bool use_thread_stack;
 	bool use_callchain;
@@ -3126,33 +3125,7 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
 	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
 						   struct cs_etm_auxtrace,
 						   auxtrace);
-	if (!etm->data_queued) {
-		struct auxtrace_buffer *buffer;
-		off_t  data_offset;
-		int fd = perf_data__fd(session->data);
-		bool is_pipe = perf_data__is_pipe(session->data);
-		int err;
-		int idx = event->auxtrace.idx;
-
-		if (is_pipe)
-			data_offset = 0;
-		else {
-			data_offset = lseek(fd, 0, SEEK_CUR);
-			if (data_offset == -1)
-				return -errno;
-		}
-
-		err = auxtrace_queues__add_event(&etm->queues, session,
-						 event, data_offset, &buffer);
-		if (err)
-			return err;
-
-		if (dump_trace)
-			if (auxtrace_buffer__get_data(buffer, fd)) {
-				cs_etm__dump_event(etm->queues.queue_array[idx].priv, buffer);
-				auxtrace_buffer__put_data(buffer);
-			}
-	} else if (dump_trace)
+	if (dump_trace)
 		dump_queued_data(etm, &event->auxtrace);
 
 	return 0;
@@ -3454,12 +3427,8 @@ static int cs_etm__queue_aux_records(struct perf_session *session)
 						 cs_etm__queue_aux_records_cb, NULL);
 
 	/*
-	 * We would get here if there are no entries in the index (either no auxtrace
-	 * buffers or no index at all). Fail silently as there is the possibility of
-	 * queueing them in cs_etm__process_auxtrace_event() if etm->data_queued is still
-	 * false.
-	 *
-	 * In that scenario, buffers will not be split by AUX records.
+	 * No entries in the index (either no auxtrace buffers or no index at
+	 * all).
 	 */
 	return 0;
 }
@@ -3867,7 +3836,6 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	if (err)
 		goto err_free_queues;
 
-	etm->data_queued = etm->queues.populated;
 	return 0;
 
 err_free_queues:

-- 
2.43.0

