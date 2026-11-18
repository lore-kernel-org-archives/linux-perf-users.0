Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019397;
	b=3ZrEgzQnufMXYly+zSTNE0KuJDbhLq3mA9eQxWpG/WEr3JmkJ0id7HqNRWc/wAUXRmbZ
	 OwfXc6z/EN2cN+EWPnHXPPA2I7GRsotWN5yDG0zS7py6H3NLPJluUZZau4+3Nxv9XrYdK
	 TqsB2UNJSEnvjzd5yUxo6/iUmeINk1PTC5ZxpKE00yzQjSqzZDoNGWA4kh7VRuOdUykuV
	 iocqOMNs3cRCbno+ftO3lLEbZAM8PTyeNdey9NxvrUYLsY5c2FsjNKoKECA60ECzvphX/
	 qVyVNeTNMyLM5/Kvmfy7/UcRD2YRrCUb6OvbNGxk8YHT3WGlkZEMNJpRDtVrpuMMgSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=WRHWKRUMRo3z2ZrNBL7a1kOoOgKp/NNfuj874KBAObM=;
	b=bAMhre1CmoXGTNrCjCSgnZl41cgJvJBMImXuOeAX8AySce1kVp8GGMryzx+c5stRFvs1
	 VwC9FoMttC2S/YTxp475axcIIIDYZP8NMVvo7es3ccAENoncp7I2tuT8e7HZ+szqthNCm
	 dgre8wQBMpTxpYcTOrX0SRetenouw4USk81Iw0ayDMVRiyYXtfhRce6iCWolYOkPa9nhd
	 ZYoPVrPuBGu5bAIYDeruw8HyrWk7296dryVpRHwcBbcDd47eR5WtevJAySnUavN8U+tQ5
	 z6N1Khcj1Ks2Pk9fAkm26eZnuUhJLrHc6iXkqcZ/Y8HFbnm0eKABhB9FPVXNhdi/ggQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=W0ydXO7k;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EDE60A262C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1EDE60A262C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=W0ydXO7k
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-491971ac844so1206326f8f.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019393; x=1795624193; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WRHWKRUMRo3z2ZrNBL7a1kOoOgKp/NNfuj874KBAObM=;
        b=W0ydXO7kl3a5UIBTyabgYyvxKc8+c0rSj+af04j/VnnXmfDb8OLFPeQagC0aJsTyfk
         L7tlPeHdV84Sh0ApfLJaHj0WiR4aaqshwAtTXMHrxn67VyaSWGrfUCwkwXMzU47/qsDn
         ABJzlVho+7E6inEHIWDXr9LImysuYqh/tfiGuvwqoZOTP4KZin65HCSWM+58Y4JshxFQ
         BoB5AytN+2p5z6QGPRPbUqa9jvrxDHgO7owNGuKLBp52e3wbVVGQUH3z26g7Sv5U8WYC
         PJ3uBPRnZmLXpt9srBeA3QieiTM3SQ4WkSZ0Bi4ewjeHgJKKgEi2e4UlxYFS9u+REUWv
         QY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019393; x=1795624193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WRHWKRUMRo3z2ZrNBL7a1kOoOgKp/NNfuj874KBAObM=;
        b=HbLh+9MCqiFdfVd9b0ZdyqbvBao+MBSqgeEFzD3dogvowp5UC/LPEyR8p3Lph5qwki
         COGZ/K6h3oOJBPLUFNThW2dK5b1cdhlWtr2Rf++a7TYrTogfMQaB+fcljaZDkSuJy+7s
         zS5uZ5lOFDXRoTM48mjP10Nf2JU+OiWnLFcePwID4xtZmbKDMQ9VxuhP7kSdz+4256pP
         3c3qocCNh9dGxogg6CF70pXlNOce2jk5+wNCBS1zzmapMz4+HypxeNDWUdPE/9pebIcW
         EHZq8I6rRL/xWVqUiZh6rKBiMfAY0V1sZmCXp5aAGIqW4p/EPe8KMSnPlopSy5/Kl0jQ
         sT9w==
X-Gm-Message-State: APuU4Z/a+hwH7I3vFbM1lpc8zG1JfVOBOw91SL1Px3+gdKuJS790OUwh
	4zhv4XNeOn9uzlws89JkZcpqmEw5mU7svw/YJ8NWVrSdEOaRHFcUrISwvbIaJlnIXUs=
X-Gm-Gg: AYBFou2ioawJRH8wW20s8NL0PUBaJIY1qtrHS+X7RApzRSZgK8sED3z15AlLe4e5QTb
	sGeprcs18/gJL0icvEldVrPFzVi+t6zG/CBmo4OV2z03GXNU6VMZ8BBwWJyMnV7hJrzxG1z0bWB
	131NLncDKpe2ldLZj/0+yrcbHm8ni/Z69nujwkEhmdGae/0vwH7lIOCqk1wgUsA/J3uzw0L9Edw
	8JIEbZmOjrdYlhPEq9880x2R+Yk8atk7u1w4OzNkMX6LrwtFAmPX2SLhO/4/eBpSVbtYcXy/Pik
	wqphY0PmDl6GJk+NO+EHfd8Aomk9RULY0kLbCGX6FVqyVXNJE79pwhvvo5sNj4KGgfU4c1fBM68
	Ux0tMlDXfYtssXhxgOXvFet5yYqBsZ0YD6qUtsgb27zOXdd4HDRb4TZP4bJe1YWmMzKxTpakLur
	SJInVcDZ4JF9p4CSb2u463xBs6B7LcPn/jszIpt+vxViXhNDC2hKH+gFTpcXcz7EoZxNzEjKsJi
	9NsYtk4bCrHeCQActZkDNpgGK6F65nzfcX5Im0NMZs2JjqmNetHEzroNGGGKckqOHfC1/6gUSMN
	ocY+C2jXjHmJdEciagck9Ra5ALUDenu2qHRAVg+Qk5A1isBJr8HOIQ==
X-Received: by 2002:a05:600c:1d0f:b0:4bb:56bb:1196 with SMTP id 5b1f17b1804b1-4bb7da349e2mr62508195e9.23.1795019393189;
        Wed, 18 Nov 2026 08:29:53 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:29:52 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 18 Nov 2026 16:29:27 +0000
Subject: [PATCH 05/34] perf cs-etm: Use the exception level to tell kernel
 from user
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
Message-Id: <20261118-james-coresight-jit-v1-5-dad4d90747f6@linaro.org>
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

cs_etm__cpu_mode() decides whether an address is in the kernel by
comparing it with the kernel start address. On arm64, modules are loaded
below that, so module code is looked up in the thread's user maps which
results in a decode failure.

The exception level of the trace is known for ETMv4 and ETE, so use that
instead and only fall back to the address when it's unknown. This
enables the ability to decode trace from kernel modules.

Fixes: c9a01a11dfe6 ("perf tools: Add support for decoding CoreSight trace data")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  6 ++++--
 tools/perf/util/cs-etm.c                        | 12 +++++++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index b9397151748b..f133e11ccc7b 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -462,7 +462,8 @@ cs_etm_decoder__buffer_range(struct cs_etm_queue *etmq,
 	packet->last_instr_type = elem->last_i_type;
 	packet->last_instr_subtype = elem->last_i_subtype;
 	packet->last_instr_cond = elem->last_instr_cond;
-	packet->el = elem->context.exception_level;
+	if (elem->context.el_valid)
+		packet->el = elem->context.exception_level;
 
 	if (elem->last_i_type == OCSD_INSTR_BR || elem->last_i_type == OCSD_INSTR_BR_INDIRECT)
 		packet->last_instr_taken_branch = elem->last_instr_exec;
@@ -607,7 +608,8 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
 
 	packet = &packet_queue->packet_buffer[packet_queue->tail];
 	packet->tid = tid;
-	packet->el = elem->context.exception_level;
+	if (elem->context.el_valid)
+		packet->el = elem->context.exception_level;
 
 	/*
 	 * A timestamp is generated after a PE_CONTEXT element so make sure
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 51431a4d5db7..3fce3c357943 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1134,8 +1134,18 @@ static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address,
 			   ocsd_ex_level el)
 {
 	struct machine *machine = cs_etm__get_machine(etmq, el);
+	bool kernel;
 
-	if (address >= machine__kernel_start(machine)) {
+	/*
+	 * Prefer the exception level when it's known, because arm64 modules are
+	 * below the kernel start address.
+	 */
+	if (el == ocsd_EL_unknown)
+		kernel = address >= machine__kernel_start(machine);
+	else
+		kernel = el != ocsd_EL0;
+
+	if (kernel) {
 		if (machine__is_host(machine))
 			return PERF_RECORD_MISC_KERNEL;
 		else

-- 
2.43.0

