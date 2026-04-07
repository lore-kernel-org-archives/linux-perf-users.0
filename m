Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E603B8D5C
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Apr 2026 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570759; cv=none; b=NcX1qIwnEl2NBey8DYhQvXrs4YmlxV6flWaXtrehojTPGFxAuch4BxKVwFY2TJu/ScULHoxy1FNcQ/YsT/o1V7bukaWSaWJKq3NuPW8sIk+uSepb7OYs4/nQrxSCYSurBaPorkovBP7+/C77Fk0XqVmJssmReD2bkMHkZ0sGIeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570759; c=relaxed/simple;
	bh=u1zqiIUwypVOUe3QPjcGXXBzhP8Aust4a3M6Cuz9R2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MIKNKmsIm8Qi+6b++jUqIzE7Oi/RWuHt438dYQHn1bpUXdth1tibmrjAnz2SxiMx1T1NFHUgH7OPDo52ERtjW7ODo6QAuoFzfPbkh0z2930BQMhDnpGjaH/9p2pwv24qQazP2BBT2TUVd/J+mv6RwN0QZ5nxu5Rqk1xvUyiLQGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KG7D+Z6g; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KG7D+Z6g"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso32691005e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775570757; x=1776175557; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9LL9PwPypWvbniXtyE+RR5RtoAnIbsZcQ38eiczBSY=;
        b=KG7D+Z6gLM+vnjLlhXkhcwACH76UJo/dgVBQvYlzQpK0CjVtv2N6n0G9n3OpFBIfNk
         txIFA9TvZljsxA165GX3rDcrT0AJmD1McMkQALZrkf4hZUkmaf1MMdjLsngYdUOfrxrM
         IDtKUcX0ztpDpKQkadAcJyUBzY5xPfGgLL3MLln6bjFIuZ5Quq58eh/S2ERWVVXXsvGK
         j1YzpJxl6XpJktqro67NryzotOij4f1+VQDu8kbZ2BH4q/MaZgD5HkTf8ZaSRnzf7BjK
         1rO9pW2l53jAvFhXmWoe3A6173yEtuXDXOxyRW3ekTKyjK/+1jonp+u2pjQd4OncQcn2
         KBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775570757; x=1776175557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U9LL9PwPypWvbniXtyE+RR5RtoAnIbsZcQ38eiczBSY=;
        b=E4zb4c+/z70Jfq6Woop+reFYlRdfXRCugDM/WOh60+QZ67wrMP6wtjB7uvfaB4BtBJ
         opTovfIt+U+rM8XjUk0EU4aDxIKtVAnbdfE/IcPTsPKvAoUrU0tn7vf29dkvzETS+vDu
         CVXUh7te9H5ni6H42s85jYzN33BYGqCRetdVy91e01WZf670K9NCw8FHgE8gLnR7JAer
         3/8ArEb/19fH3HwsC41eh5+kpkkFs0QLVUcgs3HMQiJtfxGQehDflGQL4F8TghZ9MKoX
         mFU3QEBWxfnkwJnkdCcnDcYWhXVELNta2i2YkOaAefg1/mju/5C8DeIywC0U74WDvKRx
         GVVA==
X-Forwarded-Encrypted: i=1; AJvYcCV3wuRXSQTzY8mnfWoEdlDVq/XQG/RcWuOjCg2QUwuBhRMTk3bulbZzlue3m29gAxa70aivB+veiWcbRJlERJMK@vger.kernel.org
X-Gm-Message-State: AOJu0YzwPo7PWxFuwNZCVddzHU3Maa1JWZEjK7nLvwf3zErluiEWoPkP
	NjK8KGM8x6w52ZhN1FQpbS6XPi57xhLLm1Ngsww2+R7ujcrWX1OYi65LEsV3I/erBng=
X-Gm-Gg: AeBDieuheYiJdVbGQWSBj2AcFuC80N5SOzWboSw7OWydM0FcqKhLJ4JKUHs6gyr1rqn
	Z8rjtOcaCASfDBO9/KQ+RR0tGXcWmYqJqbJkLuVY0lx4IacrjMq44SORv16ieDPMCU4RdVF8Zq2
	zbdVWSgfrZ0EyC1fvmrbs+9pxVYCn6eaD8dQDSJNgDXHZ6eqL0uK5+DcORi4LkLsD5lJwVqm6kQ
	Q+Xl+ehp6aKlEoYjrByk2nmflYBx336W6ebBXKcAU2IwlgvNzK5eqq+0etiZ+aeufLjlqi6Ov69
	2iDini+AtAwGnU17IT/0ri6eGMaGDKXiGNDSwUqhD0KL4xPzFguwG/IHo94U3Og/2hgV5OP/TJ+
	YmRj/eZB9ccYKTqlFC+j921tPmeAhBHrDF7Ru/9r8qC0bLQtH77gIQe5Uf4TOAvrbWX/PWEx3Ju
	WSfeei/3aUO0P2NMKfhk8ne5yEDW/J69Z1
X-Received: by 2002:a05:600c:64c7:b0:488:a8f0:35bd with SMTP id 5b1f17b1804b1-488a8f037c4mr188433225e9.8.1775570756530;
        Tue, 07 Apr 2026 07:05:56 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e822227sm626876145e9.4.2026.04.07.07.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:05:56 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 07 Apr 2026 15:05:17 +0100
Subject: [PATCH v2 3/6] perf arm_spe: Store MIDR in arm_spe_pkt
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-james-spe-impdef-decode-v2-3-55d3ef997c48@linaro.org>
References: <20260407-james-spe-impdef-decode-v2-0-55d3ef997c48@linaro.org>
In-Reply-To: <20260407-james-spe-impdef-decode-v2-0-55d3ef997c48@linaro.org>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

The MIDR will affect printing of arm_spe_pkts, so store a copy of it
there. Technically it's constant for each decoder, but there is no
decoder when doing a raw dump, so it has to be stored in every packet.
It will only be used in raw dump mode and not in normal decoding for
now, but to avoid any surprises, set MIDR properly on the decoder too.

Having both the MIDR and the arm_spe_pkt (which has a copy of it) in the
decoder seemed a bit weird, so remove arm_spe_pkt from the decoder. The
packet is only short lived anyway so probably shouldn't have been there
in the first place.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c   | 17 ++++++++++-------
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h   |  3 +--
 .../perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c |  3 ++-
 .../perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h |  3 ++-
 tools/perf/util/arm-spe.c                           | 21 +++++++++++++++------
 5 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 9e02b2bdd117..7a3a4815fd37 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -120,7 +120,8 @@ static int arm_spe_get_data(struct arm_spe_decoder *decoder)
 	return decoder->len;
 }
 
-static int arm_spe_get_next_packet(struct arm_spe_decoder *decoder)
+static int arm_spe_get_next_packet(struct arm_spe_decoder *decoder,
+				  struct arm_spe_pkt *packet)
 {
 	int ret;
 
@@ -134,7 +135,8 @@ static int arm_spe_get_next_packet(struct arm_spe_decoder *decoder)
 		}
 
 		ret = arm_spe_get_packet(decoder->buf, decoder->len,
-					 &decoder->packet);
+					 packet, decoder->midr);
+
 		if (ret <= 0) {
 			/* Move forward for 1 byte */
 			decoder->buf += 1;
@@ -144,7 +146,7 @@ static int arm_spe_get_next_packet(struct arm_spe_decoder *decoder)
 
 		decoder->buf += ret;
 		decoder->len -= ret;
-	} while (decoder->packet.type == ARM_SPE_PAD);
+	} while (packet->type == ARM_SPE_PAD);
 
 	return 1;
 }
@@ -154,19 +156,20 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 	int err;
 	int idx;
 	u64 payload, ip;
+	struct arm_spe_pkt packet;
 
 	memset(&decoder->record, 0x0, sizeof(decoder->record));
 	decoder->record.context_id = (u64)-1;
 
 	while (1) {
-		err = arm_spe_get_next_packet(decoder);
+		err = arm_spe_get_next_packet(decoder, &packet);
 		if (err <= 0)
 			return err;
 
-		idx = decoder->packet.index;
-		payload = decoder->packet.payload;
+		idx = packet.index;
+		payload = packet.payload;
 
-		switch (decoder->packet.type) {
+		switch (packet.type) {
 		case ARM_SPE_TIMESTAMP:
 			decoder->record.timestamp = payload;
 			return 1;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 3310e05122f0..0cbcb501edc9 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -147,8 +147,7 @@ struct arm_spe_decoder {
 
 	const unsigned char *buf;
 	size_t len;
-
-	struct arm_spe_pkt packet;
+	u64 midr;
 };
 
 struct arm_spe_decoder *arm_spe_decoder_new(struct arm_spe_params *params);
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 5769ba2f4140..718022aecec3 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -222,11 +222,12 @@ static int arm_spe_do_get_packet(const unsigned char *buf, size_t len,
 }
 
 int arm_spe_get_packet(const unsigned char *buf, size_t len,
-		       struct arm_spe_pkt *packet)
+		       struct arm_spe_pkt *packet, u64 midr)
 {
 	int ret;
 
 	ret = arm_spe_do_get_packet(buf, len, packet);
+	packet->midr = midr;
 	/* put multiple consecutive PADs on the same line, up to
 	 * the fixed-width output format of 16 bytes per line.
 	 */
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index adf4cde320aa..a457821f3bcc 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -35,6 +35,7 @@ struct arm_spe_pkt {
 	enum arm_spe_pkt_type	type;
 	unsigned char		index;
 	uint64_t		payload;
+	uint64_t		midr;
 };
 
 /* Short header (HEADER0) and extended header (HEADER1) */
@@ -184,7 +185,7 @@ enum arm_spe_events {
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
 int arm_spe_get_packet(const unsigned char *buf, size_t len,
-		       struct arm_spe_pkt *packet);
+		       struct arm_spe_pkt *packet, u64 midr);
 
 int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf, size_t len);
 #endif
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index fc11f32e4911..7fb33fe27693 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -134,8 +134,10 @@ struct data_source_handle {
 		.ds_synth = arm_spe__synth_##func,	\
 	}
 
+static int arm_spe__get_midr(struct arm_spe *spe, int cpu, u64 *midr);
+
 static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
-			 unsigned char *buf, size_t len)
+			 unsigned char *buf, size_t len, u64 midr)
 {
 	struct arm_spe_pkt packet;
 	size_t pos = 0;
@@ -148,7 +150,8 @@ static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
 		      len);
 
 	while (len) {
-		ret = arm_spe_get_packet(buf, len, &packet);
+		ret = arm_spe_get_packet(buf, len, &packet, midr);
+
 		if (ret > 0)
 			pkt_len = ret;
 		else
@@ -174,10 +177,10 @@ static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
 }
 
 static void arm_spe_dump_event(struct arm_spe *spe, unsigned char *buf,
-			       size_t len)
+			       size_t len, u64 midr)
 {
 	printf(".\n");
-	arm_spe_dump(spe, buf, len);
+	arm_spe_dump(spe, buf, len, midr);
 }
 
 static int arm_spe_get_trace(struct arm_spe_buffer *b, void *data)
@@ -302,8 +305,10 @@ static void arm_spe_set_pid_tid_cpu(struct arm_spe *spe,
 
 	if (speq->thread) {
 		speq->pid = thread__pid(speq->thread);
-		if (queue->cpu == -1)
+		if (queue->cpu == -1) {
 			speq->cpu = thread__cpu(speq->thread);
+			arm_spe__get_midr(spe, speq->cpu, &speq->decoder->midr);
+		}
 	}
 }
 
@@ -1234,6 +1239,7 @@ static int arm_spe__setup_queue(struct arm_spe *spe,
 
 	if (queue->cpu != -1)
 		speq->cpu = queue->cpu;
+	arm_spe__get_midr(spe, queue->cpu, &speq->decoder->midr);
 
 	if (!speq->on_heap) {
 		int ret;
@@ -1476,8 +1482,11 @@ static int arm_spe_process_auxtrace_event(struct perf_session *session,
 		/* Dump here now we have copied a piped trace out of the pipe */
 		if (dump_trace) {
 			if (auxtrace_buffer__get_data(buffer, fd)) {
+				u64 midr = 0;
+
+				arm_spe__get_midr(spe, buffer->cpu.cpu, &midr);
 				arm_spe_dump_event(spe, buffer->data,
-						buffer->size);
+						   buffer->size, midr);
 				auxtrace_buffer__put_data(buffer);
 			}
 		}

-- 
2.34.1

