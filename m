Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474253E6DC0
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170900; cv=none; b=Rlouy6qerUzjxtQ/JNR5IGK2WVfvjdcg9vM5UT0lRO5T7BT3bHGRXhBhoEeARUqZdH1PFfAq8eBPdQzzI56/jC8E/34BzENZv9WgsKIIBLyHD6ShBuHJtotPtT8sSECsM9+DBPoszxXAdq6FPVQgavIIXtjo0GfXS0vYqU4MqTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170900; c=relaxed/simple;
	bh=nGmx1YuAvFIQdUkuZHjjlOY0td5Cc8BcRfM1Hn6H9hs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G0XzfV+1raGKyIZxVzfpUlI4NkwTvygkBAvCOLPEUGIeDcrBnorky9aDpjuvg74UIwZEI0bRx4L3roHU0ZD3w7DzvLgPqUzicuqAfQsQY0cdamBI2vcKgr7ArCWu+Eh5KfZeU1QlPCCIT95XEoz5Louc/0EiqpQ4LHWrSJTc25g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZtMgvp4O; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZtMgvp4O"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48374014a77so75964825e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 05:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776170896; x=1776775696; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+Xe3V/IHAK7tYUKXkEGJ5jpMYrvIkuA0BtXyooehrM=;
        b=ZtMgvp4OYI0fYdbsg1/ZObfPcb2kpEdZ/DnatnyRLEQLCueC7UOv4+StL4wg3JBHd5
         KA0FJjH4o/5UsRIbIm0kKeTWf2ZJFQ1zn6b9t1OzeuoaE23ayyTcPPOcO3O2TlOuekE+
         ffqRuZ+ApNDS1ubA2F2k0EddijxsBZJhAoPI/jEqixPce92Ynek+rb6bm809/uXxZoYJ
         UmOHff4xrEbgWnQb4ghhNKcvv2+NdkQxgaVUCUzybWnRaUuKK/TJkvTHgFbjKOcsR8az
         V6zBHT31McSBqz4RMJ76Cyhk7j4GVJakcEmqJj5N5QW0ftVojYMKwsSHr34X7U6PiH6T
         FzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776170896; x=1776775696;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A+Xe3V/IHAK7tYUKXkEGJ5jpMYrvIkuA0BtXyooehrM=;
        b=BrAT2FloionneZsH/3WNSjCl+mjGMsHyGn+Tm0W42Flvq9FMyH9FqyWeOYwzWRagxu
         mD0IQDyHwQ8Af6hDx1qfUG4tOL2DM2FTy5ZU0S7wf5V1qWDF1QKSL2mf1QT/lFsLsCxv
         0ShaWkxO6KW6Gw7vj/RsbiLwfy1DcZLQmXFEGwhDjQj24TwDgi1TWBP32XtmKnyGzRUY
         ySVMpRGcUaHFG5x8/hToDWtqJi0/n8y9m9/AjZi51bGia863ddlpR9YEkCI6aXTq/C5L
         XE7w2XApCFQdu73MRSAQzdLKHh0dbdvvwqp5b4y2Fc4ZGzi9yarKL2ts/t8strbNfo1D
         23lw==
X-Forwarded-Encrypted: i=1; AFNElJ9BXl1tVmaChPuu+XML0L/78UZf4Wal6ybBejKLtG81j2NGc6z1efttmtgNpfPFMYjtaHm6u8AMFGJHajpLxLQy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+L6P5hbW9Wdpw3CT9M8Lu57Z5b4Ia+ijG+yq0/91ztWxfahHU
	IR5x/1KS7oMDf1D1dFXljD6JuAWenllU5BqcAkxPMtLra4183M0rl+fWNRf24Docp80uk8iPnqo
	7BvbWnppuKw==
X-Gm-Gg: AeBDieuUYPCUQVwK+WxMzXGl5xGpzqoKPNtjDpoO2JmbdO0jN0QfY6TbPrDDo0E5ch3
	vMUGwybnwjU+IdZaMgdq0P6v/qxlM2E4K/IiNx4mZQpWmn93fGNLGI3s1ygzhqtFkhfOU4Rueow
	N2zWzk16H3FRTFo8jUkPXRINFH3QjKUnWfs3ldqA7zPTQ81vpeqr78xxnHWiDRRy5nVqb42bzER
	Tgwyd07hiVnia9YV3dtGyvBpkhm7J1QNYh/yamnjEPdiVyuN+H7ESzv9/YZLlVCUExclprZhKBg
	MijAc73U4IRgjQHb8HbpndP3KX2YXrMPd5BVek/X8m+qxj0IvG+nDC1Mz4+QDPNKumhMp8CbLPN
	x9lZ7Fj2/OFd2mSDs3HE7lgjER05QBxhZuokjhRdA70MYRAMZoSihoAlvPnMnXRFZjAxQWsBis+
	spxmh2ZzRF8VNSEvlDu2BOd0+bE4CMakKVX5m6HLkNhhspKmU4MHes
X-Received: by 2002:a05:600c:19c8:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-488d68ab2ccmr236905995e9.29.1776170896420;
        Tue, 14 Apr 2026 05:48:16 -0700 (PDT)
Received: from e133063.arm.com ([213.137.22.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1e05bsm81185285e9.6.2026.04.14.05.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:48:15 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 14 Apr 2026 13:48:01 +0100
Subject: [PATCH v4 3/6] perf arm_spe: Store MIDR in arm_spe_pkt
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-james-spe-impdef-decode-v4-3-1dd30783a33b@linaro.org>
References: <20260414-james-spe-impdef-decode-v4-0-1dd30783a33b@linaro.org>
In-Reply-To: <20260414-james-spe-impdef-decode-v4-0-1dd30783a33b@linaro.org>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2

The MIDR will affect printing of arm_spe_pkts, so store a copy of it
there. Technically it's constant for each decoder, but there is no
decoder when doing a raw dump, so it has to be stored in every packet.
It will only be used in raw dump mode and not in normal decoding for
now, but to avoid any surprises, set MIDR properly on the decoder too.

Having both the MIDR and the arm_spe_pkt (which has a copy of it) in the
decoder seemed a bit weird, so remove arm_spe_pkt from the decoder. The
packet is only short lived anyway so probably shouldn't have been there
in the first place.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c   | 17 ++++++++++-------
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h   |  3 +--
 .../perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c |  3 ++-
 .../perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h |  3 ++-
 tools/perf/util/arm-spe.c                           | 21 +++++++++++++++------
 5 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 9e02b2bdd1177193996d071dd88f969e25b1ad86..7a3a4815fd37b7f57687189c09c618aaf7ac9801 100644
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
index 3310e05122f02e8ef32f79f8ed3c6932cc43eecc..0cbcb501edc9965d34cfd3ede79cab3fd9b318f8 100644
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
index 5769ba2f414049161f271fd8b8f40c440d15a75a..718022aecec30bf30a51ba3d2bca9cf6465259a7 100644
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
index adf4cde320aad01265b5232b0d6ff6b1f752f35f..a457821f3bccb67691cfd530de2f1c5bf9d8d50c 100644
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
index 037c7aa150c1efeda6e8e956a5b1db733e6ea74a..2b31da231ef3ec84a37b5a314ab1fc1151dca907 100644
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
 
@@ -1248,6 +1253,7 @@ static int arm_spe__setup_queue(struct arm_spe *spe,
 
 	if (queue->cpu != -1)
 		speq->cpu = queue->cpu;
+	arm_spe__get_midr(spe, queue->cpu, &speq->decoder->midr);
 
 	if (!speq->on_heap) {
 		int ret;
@@ -1490,8 +1496,11 @@ static int arm_spe_process_auxtrace_event(struct perf_session *session,
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

