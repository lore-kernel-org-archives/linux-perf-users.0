Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECE11991C6
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533474; cv=none; b=WKohgi4o7Wi0MECFxpQDiulm4Z4O3cUZ/6lynGVnj8icHBikx59QH6Ka5maxXC6aDij7dZsJHvkdE0YHs/1oGNRMggHv3YN5h2XBQFNQpCpjsEixwahA71TKHcNvzALbbgb+d5Jc4YnI9gNUBJ/td8nRey1aBEtb8MFFcgqZ60U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533474; c=relaxed/simple;
	bh=PxZK1UYoQiEz/5XZdh+TkbpX8o1b6IrqnscJH918Tbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EE72oLCmHFRUpXYDq1d2nrssDazWOVY9bioOw1i/4HCDn8mClE7xHnztEGncsc9yyHGFegWsb47DlZh8mB8MgV2OMEmf42s5Tp1WTqW44DyIW+okX84uGb+S4QhLWNxYOdyAqKE9ZTDLiFOxiHs2uabcsik0UbL2MMLUeq1ypZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gemYYS5H; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gemYYS5H"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42bbbff40bbso4680995e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Sep 2024 03:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725533471; x=1726138271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pve9lnNvOpeZGUhzPh1pcaBloPgbua89KV6dx7HbhcI=;
        b=gemYYS5HX/jIdB8RFQ/VlJfB6jAMM6GDNoUoJn0MTVm+WpH72ltkwcLCGVK5Y1T7r0
         o+pRJSdp+SdgMnH5PUueO7ng+CmDHp0gOz140vkVM1jLIeH6aEpGob27hzfFPBSuWYl7
         AYNqCkLeEnxjalx/DuKfboV2fFOgtiYrhp0/GagTTtV2KKTcC27fajFLp/Dw0pMriVv3
         9p3UUlkmGL4z+xVBE4XkFF8JbTLFGYeOfGGa5oBkHA/wV3Sm4idk4Xbt0nLzOGXaI6lV
         cz6QFKIxpW9vqOa/C+DRo0tXQr4z7/IwzzMvNEyMry7p+lqGzh24vii8VvhzpBOD1k/q
         E3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725533471; x=1726138271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pve9lnNvOpeZGUhzPh1pcaBloPgbua89KV6dx7HbhcI=;
        b=WHkOr19tTyO87ai8+mj+bJ2v8B2cE3jqazbJKlXyiVA+6PHwRHSpMfuLdtQljNXZZV
         i8xcG1NMa2A05y4KWAxxy9YyFisYynLESh/TVK5ZX67R19dOFJqSIB7u8C5/C2KXmAS+
         WplBwqyqKmOwUZXmWAN9JdA+PAmCPCJYHhtStneqZE/vOCsdvyicSefVbpl0ZuB+oqEH
         TQn40zH+9G8YgTCBHq66aaD+HMB6mqvUbiDxy2qdqpjalIXeD18+oRJeeFGZKFAo5wy5
         6XSyeYqadakrLNpQsPB6wPwL2eRCctg60xKUN+kIxwmd41Zw2xuJm4nfrn4iIkNYoCS9
         p5TA==
X-Gm-Message-State: AOJu0YyTB1FDTEmzwkWEfYYVHcJFJ06sgUj5LSLb7+aRP0+FGVxPmcfH
	Yum/8XkBuMwyZTCQ+HmIBSUCNpBdo8VT2NdrLqQozn5PQm9AdpDuYG77XN92XQl1yVvk8kcDgXJ
	pzvA=
X-Google-Smtp-Source: AGHT+IGNR6IhhEwS/jgcksvn9DO/af4hIbBkDS8ADbe7BTQ8BnykRnU/aKDonHdKsUgmQWK1V7Lc5w==
X-Received: by 2002:a05:600c:34c3:b0:426:5fe1:ec7a with SMTP id 5b1f17b1804b1-42bbb440201mr138466235e9.31.1725533470807;
        Thu, 05 Sep 2024 03:51:10 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0dbcsm231089965e9.17.2024.09.05.03.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:51:10 -0700 (PDT)
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
Subject: [PATCH 2/8] perf cs-etm: Use new OpenCSD consistency checks
Date: Thu,  5 Sep 2024 11:50:33 +0100
Message-Id: <20240905105043.160225-3-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905105043.160225-1-james.clark@linaro.org>
References: <20240905105043.160225-1-james.clark@linaro.org>
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

