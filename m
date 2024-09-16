Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A361591F1
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Sep 2024 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495112; cv=none; b=jNqEnMcoaZtOJMxDcLEYPAk4h0NBqqHbj87QULOFahWBI5OpkfKGyF9I4f0v2WjzZDLCHOv7MZZkQDFd3/r4QZuk3FZW3aXdsAMlzy+MyoJn9DoKsvg1z5hfiyxPyISUCVapi97nSuEoC8mHQn2CBFhi5e+6GyhIXwDkYJRVdDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495112; c=relaxed/simple;
	bh=3cu2k6gc2jH2QRlu3LXOLx+bvkQ+zgDEXORBnmpwwJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VHZ5r2DquWZE7zadQ2lzNB8rf2AJTWvXnmeFNxswyenDYKiBDqNozikhsXH3g/YR6zfr0jlIJpGNZSXvkG5Mus5lLWqcDBuiH0a785RvJt4/krhXOLmPOBBy4vpiVmJODu5wz6rlyTP+APrdByEcicZ9COvBd1GBo+GHS/6qhwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DjAl9MKK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DjAl9MKK"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374c1e5fe79so3370324f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Sep 2024 06:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726495109; x=1727099909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6I1ojreNPMnAqnnyAmn/bcHu89TPQPwVi7gpVoP/po=;
        b=DjAl9MKKA7VI4fhjfFLwW6yztxM5O4IIYnm/UzZJ3is4T6kVz+9Xcgdncx7WvZzoeQ
         nRk3JaRmIZRO6D6XhiZektTzbF7dBsDWc0/ej4yrk0DiGHo6/ViPa4zR0xYf0L/atFMb
         6M3R5+WP7RznOfH7U6yFAvvf+LvwWNFyQ/7MHHSvwH0V8l8Rs6zVcC8M1yE69LGBbN9k
         GU5Wq57Nn+NXUWD6wgBOMKBkNZQ5TWMQEbqPJJJV89ssIOZWMSKJPpSqmZG/y6neNzYd
         1zUNwODc7dRTL3RQFRfRRQcrasvMieIFC6fMyZOHPMyjvfx/97XJP2BKkVxhjxh0BAQy
         AF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726495109; x=1727099909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6I1ojreNPMnAqnnyAmn/bcHu89TPQPwVi7gpVoP/po=;
        b=HDLnJ5KglKm4I75faqVUuVq7WM+di6ghhPCc49La5JLMZG0/uUsh7/9IrUsawukN93
         VQRaqWei0521Q3js7XrSmVRcQzNpl+GWNLtziNV6TPaKExfg8Rx1RJRnTzES6pdadi4Y
         psmoxoyg15NsqfUiVtjyoacQfVxHikIwFiuleOSVHXrU7Vu57kauCU+m3e3/ASiZkdJm
         lvk3HFr/1wEaWNHHP6v5lwmv+S+Hwlm53Xx2Q6Owp+wK3F7ZmS8lpNcQvhZ9/NRDk7Zp
         e9taPZ4IYXYMmvQdqCuXzYUFAk6UXnEooiGygNHdZi4GWtmssnrdK0oPDwsB2Gssai5o
         hbzA==
X-Gm-Message-State: AOJu0YywBbKb2mUinTc+8aSoe5O2EJ4yLaLNeXSmBekF+AqXWA1VdZoY
	tqiA3VcVwe8mc2AAY7Gfr0bF4TK0RTe/0mMfe7PWdpBTN0848Iof2NuXg5zP/Ra3MHgLEf8MWc3
	x0a4+0g==
X-Google-Smtp-Source: AGHT+IFsrj9c9D2EcipbKadvrs/i4J9td9eJ+dOatQVeHhmva8RKXjoSO6yE9qOqsI6nilv8hZ9Unw==
X-Received: by 2002:adf:ae51:0:b0:374:d157:c019 with SMTP id ffacd0b85a97d-378c2cfeb36mr8698434f8f.12.1726495109000;
        Mon, 16 Sep 2024 06:58:29 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f62dasm7285098f8f.49.2024.09.16.06.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 06:58:28 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	gankulkarni@os.amperecomputing.com,
	coresight@lists.linaro.org,
	leo.yan@arm.com,
	scclevenger@os.amperecomputing.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>,
	Ben Gainey <ben.gainey@arm.com>,
	Ruidong Tian <tianruidong@linux.alibaba.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/7] perf cs-etm: Use new OpenCSD consistency checks
Date: Mon, 16 Sep 2024 14:57:33 +0100
Message-Id: <20240916135743.1490403-3-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916135743.1490403-1-james.clark@linaro.org>
References: <20240916135743.1490403-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously when the incorrect binary was used for decode, Perf would
silently continue to generate incorrect samples. With OpenCSD 1.5.4 we
can enable consistency checks that do a best effort to detect a mismatch
in the image. When one is detected a warning is printed and sample
generation stops until the trace resynchronizes with a good part of the
image.

Reported-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Closes: https://lore.kernel.org/all/20240719092619.274730-1-gankulkarni@os.amperecomputing.com/
Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index b78ef0262135..b85a8837bddc 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -685,9 +685,14 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
 	}
 
 	if (d_params->operation == CS_ETM_OPERATION_DECODE) {
+		int decode_flags = OCSD_CREATE_FLG_FULL_DECODER;
+#ifdef OCSD_OPFLG_N_UNCOND_DIR_BR_CHK
+		decode_flags |= OCSD_OPFLG_N_UNCOND_DIR_BR_CHK | OCSD_OPFLG_CHK_RANGE_CONTINUE |
+				ETM4_OPFLG_PKTDEC_AA64_OPCODE_CHK;
+#endif
 		if (ocsd_dt_create_decoder(decoder->dcd_tree,
 					   decoder->decoder_name,
-					   OCSD_CREATE_FLG_FULL_DECODER,
+					   decode_flags,
 					   trace_config, &csid))
 			return -1;
 
-- 
2.34.1

