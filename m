Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69884489FDE
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939733; cv=none; b=eiQYhVvLAePz7trHjfqH6okDs82gra2dT9cawm66USK28elE3AAqsVH44IZ5UguOjqb9YPXDPW9Kun0ImrOKG6zNy4JEBX2g0JE3iv4yzQUwWBsZ/NORDRCpS3Xiq5nnVJAjHvLxj7o2i2mm0R1HKh2dVjTqic1SKSV2LS5Wh3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939733; c=relaxed/simple;
	bh=Mt5RUIIqhNU/l5hHtkeYWBdiR+GT7HiHLBustqGOlCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YoTiyTa26g/Fxu34G0H7GXYQA/PJr3CR1pMACQ9eHpyW+IYv0/X+cWTIOwyqIjOtZysfccG3erK5wcBNTjLB2KH0KeDO7GqvsRA7ycAG0RL6yKm/9/oXCSsJA7lnel7vNT1OSBkx7noIHZyZdhUWawPZaLuvoS4NiLTn0Hm1OTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y34t74Pg; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y34t74Pg"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b09f6bbe8so1060242f8f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 04:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790939729; x=1791544529; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AgLP/cRXSHew82DCMceg3gOpR06huHwNT68VSs/pBPY=;
        b=Y34t74PgxyYPyZSSxlX9dxfbyEf2KAsaUXdm41XUVMMiDUZKZHL23gkynFIrUyFI56
         +65AwhL+qKeCsNXxFj2fmTlK0baYaPifQNQZiOW+t7kltK7tirpZ7grnnwBs5fyNtRIi
         7cc0wmG8jSL5o5lQahUCf2PoOip0gZpYWQccZcPQMpGIzw+F84MUrF0buG+VhQI39sZ+
         LpczTBzE4LapsaKnzgbq99si5lTCdD6T+n9HErCXH5hLOhpBCmPHrWoIPv7pvnxMDtN9
         mCvpqJ6QFVd1c0rSDbTyNOz1RX1pcenLJ3k/6q5VuyWIcfyP+B64n85Xkn88mXFWoujU
         k6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790939729; x=1791544529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AgLP/cRXSHew82DCMceg3gOpR06huHwNT68VSs/pBPY=;
        b=fqYr+8MYOQsrEg0VwsKfVvUyMUEVbksR93VkE36nL2hT1bFNr33bB3Qv/MONXdS5dS
         HRQ2KaYIpphZN9gkyEPCHwGHTc7sCq1PcOZsf/kRAOa6a+5TuUoMWeRdFbyqc9a7T3pJ
         uToStjkEM7OAcfWIZ3ni/e4C0FEshSnLoEf8eBUZ6LNBzmnCoUwsvnJFiA6dAbEsykwz
         z+CI5ywyBRNGgG7kf+e7h3wP/MgsoNDbQwz7QdOCpCzLbkbu7nEQzLaPrIH4rvbqTkCL
         c6sqRDPeqzOFFddyfG2ueWIF/+V00Z8iT47coeHPzOJnPFtOZ6D0waLAHQx2BZOesGJZ
         GS2g==
X-Forwarded-Encrypted: i=1; AKwUvBwo0anlvlR9fczQMFVw6AnBQyloOHs+SO66nvJfHU+lIwoXcKTb6OMraG1LyKDI9xiDwEjjLSczOXkCyQ/FG2vj@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5LqWBOkihqn//dRdn7ZRS4Nmf/AvaYaR7VADTn29a9coliUAS
	jhXgIgj+Mw9h8z4Z1Zq6ahZyROe3g2KptF4t0B8Q9XKkwg/XCbDTtuuT4fAC+qm5JM4=
X-Gm-Gg: AYBFou0YGe+4pD+7H/fSBh1Y7q0Tdr1CzQ7DyRrg9V02y+Xtsub14kkEGbI+vCwKUHd
	DTInD/7CXubJysPFlc940q2nNABxJCFHb1AO4X1KgnDvBHN0NkR1BFfflbC6g++TSVVOKy2d2/n
	MAiEqbcHo618GPL0dQRm8hDMIYfwl/hxuyRTWA2wTA80JgMeb/8818M/62rnBD946a83HkPcGMb
	f9FmCovO7KhoWeUI4yaU/+XJG/5qnzTxCtLxx83W1AzvjOBG4RNTYWl44uTvTz2vDKccWSzkHMn
	4+LNG0zyzJ6MZ2Y9S7D+Hu4wVKtUQkJFSmVUKtLKsVlDtYcBX1bJfnYoDktLe5wg8THpp+KfLRj
	GiBDS0mBYqENuZakOb3EPsKl9Mr+Z9iKQIUtx7FR0gJTQknONY0PESFg0mcSwgUPEKZ/aGY1Ofh
	P2BgUuhgdAEwPQuG02lUa3CNbq0K2r+DxyYkNmApqWMjzhpgbtRMWrPDsE9lg6cQJO733AwRP/V
	lH24F6tVS1H
X-Received: by 2002:a05:6000:2887:b0:48a:f59f:8b70 with SMTP id ffacd0b85a97d-48b1272b4d3mr4696930f8f.46.1790939729422;
        Fri, 02 Oct 2026 04:15:29 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38306dd4sm4752986f8f.43.2026.10.02.04.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 04:15:28 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 02 Oct 2026 12:15:12 +0100
Subject: [PATCH v3 2/4] perf cs-etm: Free partially created queues
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-james-cs-hw_id-output-failure-v3-2-1d8b6ef339c8@linaro.org>
References: <20261002-james-cs-hw_id-output-failure-v3-0-1d8b6ef339c8@linaro.org>
In-Reply-To: <20261002-james-cs-hw_id-output-failure-v3-0-1d8b6ef339c8@linaro.org>
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

cs_etm__create_decoders() can fail half way through and the
err_free_queues label won't free them. Call the full queue free function
here instead. If no decoders were created it's a nop.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 12 ++++++------
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  2 +-
 tools/perf/util/cs-etm.c                        | 25 ++++++++++++++++---------
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 26940f1f1b0b..b56cf57a68c8 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -741,7 +741,7 @@ cs_etm_decoder__new(int decoders, struct cs_etm_decoder_params *d_params,
 	return decoder;
 
 err_free_decoder:
-	cs_etm_decoder__free(decoder);
+	cs_etm_decoder__zfree(&decoder);
 	return NULL;
 }
 
@@ -793,14 +793,14 @@ int cs_etm_decoder__process_data_block(struct cs_etm_decoder *decoder,
 	return ret;
 }
 
-void cs_etm_decoder__free(struct cs_etm_decoder *decoder)
+void cs_etm_decoder__zfree(struct cs_etm_decoder **decoder)
 {
-	if (!decoder)
+	if (!(*decoder))
 		return;
 
-	ocsd_destroy_dcd_tree(decoder->dcd_tree);
-	decoder->dcd_tree = NULL;
-	free(decoder);
+	ocsd_destroy_dcd_tree((*decoder)->dcd_tree);
+	(*decoder)->dcd_tree = NULL;
+	zfree(decoder);
 }
 
 const char *cs_etm_decoder__get_name(struct cs_etm_decoder *decoder)
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 12c782fa6db2..2a8214f17958 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -96,7 +96,7 @@ cs_etm_decoder__new(int num_cpu,
 		    struct cs_etm_decoder_params *d_params,
 		    struct cs_etm_trace_params t_params[]);
 
-void cs_etm_decoder__free(struct cs_etm_decoder *decoder);
+void cs_etm_decoder__zfree(struct cs_etm_decoder **decoder);
 
 int cs_etm_decoder__add_mem_access_cb(struct cs_etm_decoder *decoder,
 				      u64 start, u64 end,
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index fda6b6c02e26..78ae8443ac96 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1002,7 +1002,7 @@ static void cs_etm__free_queue(void *priv)
 	if (!etmq)
 		return;
 
-	cs_etm_decoder__free(etmq->decoder);
+	cs_etm_decoder__zfree(&etmq->decoder);
 	cs_etm__free_traceid_queues(etmq);
 
 	if (etmq->own_traceid_list) {
@@ -1017,13 +1017,10 @@ static void cs_etm__free_queue(void *priv)
 	free(etmq);
 }
 
-static void cs_etm__free_events(struct perf_session *session)
+static void cs_etm__free_queues(struct cs_etm_auxtrace *etm)
 {
 	unsigned int i;
-	struct cs_etm_auxtrace *aux = container_of(session->auxtrace,
-						   struct cs_etm_auxtrace,
-						   auxtrace);
-	struct auxtrace_queues *queues = &aux->queues;
+	struct auxtrace_queues *queues = &etm->queues;
 
 	for (i = 0; i < queues->nr_queues; i++) {
 		cs_etm__free_queue(queues->queue_array[i].priv);
@@ -1033,13 +1030,23 @@ static void cs_etm__free_events(struct perf_session *session)
 	auxtrace_queues__free(queues);
 }
 
+static void cs_etm__free_events(struct perf_session *session)
+{
+	struct cs_etm_auxtrace *aux = container_of(session->auxtrace,
+						   struct cs_etm_auxtrace,
+						   auxtrace);
+
+	cs_etm__free_queues(aux);
+}
+
 static void cs_etm__free(struct perf_session *session)
 {
 	int i;
 	struct cs_etm_auxtrace *aux = container_of(session->auxtrace,
 						   struct cs_etm_auxtrace,
 						   auxtrace);
-	cs_etm__free_events(session);
+
+	cs_etm__free_queues(aux);
 	session->auxtrace = NULL;
 
 	for (i = 0; i < aux->num_cpu; i++)
@@ -3476,7 +3483,7 @@ static int cs_etm__create_queue_decoders(struct cs_etm_queue *etmq)
 	return 0;
 
 out_free_decoder:
-	cs_etm_decoder__free(etmq->decoder);
+	cs_etm_decoder__zfree(&etmq->decoder);
 out_free:
 	zfree(&t_params);
 	return -EINVAL;
@@ -3758,7 +3765,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	return 0;
 
 err_free_queues:
-	auxtrace_queues__free(&etm->queues);
+	cs_etm__free_queues(etm);
 	session->auxtrace = NULL;
 err_free_etm:
 	zfree(&etm);

-- 
2.43.0

