Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019398;
	b=Nsx3cdCSDbzWeG+RmGWKnyDI/MNaIFUTBUNYig+KqQIvSknTezBIjGKoIRkyJlMhghkf
	 8sO9q5VK486kINR9/oz24yEoGm373XiH9UJk8bAty7XBGRQQDzNTxDYLDQa7IDKHQ5ad+
	 YCo2yRyPSuk186Q2NA1DQwWXPJGtX3seRgAl+1sc8W7770Q4gFuCEJ3KbRZb8LugfjswD
	 kIvTox+rfHzRSm0RZ8UlDu9TcpQzou7H0b0xBBmXxTgHIrWVQCBd48Cheu2YxFStFn8TT
	 PdCdLwEVWathe3SffT+cc5pOnznajXPXc6zjMLJw+sB37LMSO0AxNj85STMPOEUc+iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=Babeb2HFdoGfJcLZPBXE1y9vKgkFHl2HkzCwc6W1yGQ=;
	b=RNOKDrU8q5HlZTlH38qLAYdweUqKRcYhGM5UWotUctw1F0tlpze5eHImHCFcjhEljV2v
	 Pw18TbLSCPVdEDklRw/0I3nurVCcoFRCBK47CVH6uOjOAD3Sy2iRKg9sZEaR4tM36YQkF
	 Xhof323tZcXC48axO3zmB9pCWjonjQPOd3A44xDMUn/620aUU/L31ooKTGXLMlaFgKOqr
	 hN6BzhWNbx0oG9rmx22EmBaFMLQhsiOR5vx6Bkk5Y78ZNweXhGMf3SILmb3iblNCDZaLM
	 6H2GXfDTy1eP3KlhnPDVO+iZJVzr3h9PVgD2mgMANuLa8lshD/XzeAmkWjqzgJhZnmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NDJbtURZ;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5B3606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B5B3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NDJbtURZ
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so8948535e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019394; x=1795624194; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Babeb2HFdoGfJcLZPBXE1y9vKgkFHl2HkzCwc6W1yGQ=;
        b=NDJbtURZxxEfV5/3jhv2dVf9EbZiK6GuGOj1BjjjFpdaGiEKercbd8FTs6zje1nYSt
         IDRuk/9b+DuxuGCF4aKz2AKifJXTp8rtWppKhkXppGMPC12V/Ef13rjBGpurKEg3tg8V
         oc9tU8kNoqMpN76xVFpt5ZFYglRvSD/P3VjpovsQZPkKYp1yFejUWl1kjhFeI5ZYM/og
         VGt+WWoQuJnjgshJMBHAx7BourT3+Bdj0ILJz3KgbIjBiaCGisSXMCE2dO3wpNuIw1z6
         TZPkt8pTVF0FLnS6uZVHKUar0DKoMTHdYkfhlT34f5/L0QNBqG6wZiqZLAtZ3ORO10ss
         gc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019394; x=1795624194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Babeb2HFdoGfJcLZPBXE1y9vKgkFHl2HkzCwc6W1yGQ=;
        b=pdyjR+bW7c12jfirSRmwNboAn/SJYKl6k4JLd5FxF9P9CU74Ea/GsdhO1XpoCRFNHm
         8JNPcvCFvZDvtcnlvJ5kTiHU0ePst1KLV25vv5UZRhZ3qfGfZC0/Ap6H9lkXal9E1Guy
         N0YkJR03JrRuayPC+wPdStVYDSvHuVwsDXDu4dK5ry8joUi9zYC6edn6dHmU5sntswMr
         Ki9U/4gtuXgTFBXGneU7kqsgBS7qZ9ccpJGVpJwW+zrVcFLyk4Vc3OKWhzHF5fr3gVtk
         jMqvR1eFkx0guihcX5YysKqiBdOYNE0RgdfZYSTQC3urTdfcaWUCBW/o+TrVg6iN6cYq
         SwyQ==
X-Gm-Message-State: APuU4Z9S1gMsv3mrMth8HvdYSktyBz8bVGvD2mpT3awkTY0L1AIfoMXf
	NjJYs6lVT6Nfc8ich6lzFiA7pnautj4iiuP+EP8WVSVxBRjkdbZLQ2SuujMiFx9IXKI=
X-Gm-Gg: AYBFou3tagn0+MuJWcDOfP6dsnR09ySCqT8Es2bMxdrRrsgZwj7oXe6ASn+gcIAi0rz
	H3AQAESrJ9BoF3nOXlbbWV5omx1VB4jZcuKKebsIQ+QRoR0yS8BtsPmmah0ZrN16tCu4+EJlduK
	GqzbhovDpBVl/kifupwJr+MumT8bLcw4PWTmiCrcIWA4XWCUIg/bXOKYlHvCIsdTPNBa6/XG+ZP
	n6FpGm7qC0SexQsgMCULFZ3fEOk3CZZo+IPwX66S/XMD+H1lOQUb59KB5BaUXQM0YlI7i9fYCuR
	MBwm+sh47wlrdlaBXQTzJ2j4CJfqEHKK9kXBsBOaeTHM8tyognPfHtwYH84h9FdBevAIz14ueIo
	lq5L452KnaRJ6CKO0IsGyWbjlqFW8iYpCVJnnTw9Ne5L+q8u0iAzwOSx28lNCbIf5FXEMwS7zZr
	nJ59UkGntE3q9BBxzATTH+0/OmXxB0NotweVPpt+0b3HwQN4EizyAyGYDODomSxLkrPi8h4s+Mf
	JDHKxP6qEW2Stodm0S0XE5dA3x5zFCvAZiWdRUr5N6ClMOcWLnfO56tOcbAvw9Guq6xJziEl+P1
	VVfp/I5iBGUsHXH18iiMhiIb4pisE4uT
X-Received: by 2002:a05:600c:8b34:b0:4bb:781f:6067 with SMTP id 5b1f17b1804b1-4bb7d6cd404mr58751415e9.1.1795019394229;
        Wed, 18 Nov 2026 08:29:54 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:29:53 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 18 Nov 2026 16:29:28 +0000
Subject: [PATCH 06/34] perf cs-etm: Don't read past the end of the map
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
Message-Id: <20261118-james-coresight-jit-v1-6-dad4d90747f6@linaro.org>
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

OpenCSD caches instruction memory one page size at a time. Perf reads
this requested size from the file on disk without limiting it to the end
of the map, so the page can contain ELF metadata from the file that
wasn't mapped. If a subsequent read for a different .so file falls into
this range, then it won't be decoded properly.

Fix it by clamping the read size to the end of the map. Now when OpenCSD
requests an address outside of that range, Perf will load the next .so
file rather than OpenCSD using the mis-cached data.

Fixes: c9a01a11dfe6 ("perf tools: Add support for decoding CoreSight trace data")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 3fce3c357943..fb4582dc378e 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1213,6 +1213,12 @@ static u32 __cs_etm__mem_access(struct cs_etm_queue *etmq,
 
 	offset = map__map_ip(al.map, address);
 
+	/*
+	 * Clamp to the map size to avoid putting unmapped ELF file data from
+	 * the .so into OpenCSD's cache as map data.
+	 */
+	size = min_t(u64, size, map__end(al.map) - address);
+
 	map__load(al.map);
 
 	len = dso__data_read_offset(dso, maps__machine(thread__maps(thread)),

-- 
2.43.0

