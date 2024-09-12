Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4868A1BFE14
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153959; cv=none; b=sBh7gNYMxn014cW9MlHXojjlwAGSYkErHlj2rYwWDrIKktrhvfhpjFEk9xFl0RcezzLhyPPswAaMj8lZubBtQZ0B2lDphlDviOIZZJDONhkq49OHKxSqHrLp3+GEr8t8amlphZLtAGNsedouHEIEjD6XuV1NfwQ3d0tShslYMQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153959; c=relaxed/simple;
	bh=PxZK1UYoQiEz/5XZdh+TkbpX8o1b6IrqnscJH918Tbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bp5YEK13i8BQCENS+pK56sqBka56QfkNM5GvPN3EBjfnYffC0BOtEGdZDUkNLzLN+WhnY1wVWRR/Kg4wMvKWXUB+7QEWJXgVLGytSk5UPc7eVvXUKixy3Mevq114T/d5BWuyTGdz2y5t8eMD2jykD+DQ8946Gpm9wo9yWF6gbhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=haeZG2xR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="haeZG2xR"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so12135635e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 08:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726153956; x=1726758756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pve9lnNvOpeZGUhzPh1pcaBloPgbua89KV6dx7HbhcI=;
        b=haeZG2xRiPkrqPRqk1/pqTIXkoDuFc2yaDAfb+EHoJr8xlDCY7NGhZAtmuNq6rxlna
         xCqVrDPrmntSkw5Nhk5ZFJoL8l2vZSOiRot/Ndwvm2lIAJ1sCDbtyxF5llJr9lf2vPCp
         HeXdQd50UJII7b7ml8PKfvNW1ztlwoCmkpJrayQPbRwPt74O8+oZZqNeb6RwBq3nuDEW
         UO7r9ZE+3DhhJa93kbSzghxoJ5l+IOK605ut/UR2PomhMrsLjjermix8txkCnH2uvx+O
         QK9xmcfXSzbsimT/m5mSOmavZEjwKtzc2+dAsGT+wO4GUITlu3uWWgrqc9Y0J25mt2+p
         1taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726153956; x=1726758756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pve9lnNvOpeZGUhzPh1pcaBloPgbua89KV6dx7HbhcI=;
        b=j+vUFU0Rkgb56Q9V7vBjv0xDdtuV+jFMxzOliAA5iK/2QeFmCrvDu4n6KJH7IwZfys
         OWgOsOknBAXZZq3I4P5ADG+bjOMmx4JVaLsrBVhZyT+/GkpcisT29DS5KgQ0lLlQzHDp
         YZK39AvlLUURRgNosd5paLMiLEbZ5F7th/I/HdP+xwpkhufPeOydTDovKptC39Ibqr2W
         VWfa4L9GSmawYJoNwwJBjAaXfny7B9HXmKH2SFDPBA0uGdJs4Zok8yQOkPCy6OK2mOix
         7C2AgWIplDeOqIML6hRWqPbbXzLIgFxHuGyq6oGKhgJ6DFMGFac7+GT7DO8vOHxQ/sLe
         FoiQ==
X-Gm-Message-State: AOJu0YzcSqiJoHOBR5IZlkSeqhP+ht3zSY7nd6xzTIFW9rAPmsdCdccW
	BantdElDET+3J4hjTFWg44kAN5/oJtSscx9PNSlH+8XAg/E1NhIQO20OXMaIG4yFC0u4x8HmYs5
	RrLVolw==
X-Google-Smtp-Source: AGHT+IGzxYKeWu7EffFMWELHmwkIdN54nPpsTv5NT6AtbeSZT+Q/+XaT8AVKFhJoMlm8Z9w+5+yKlg==
X-Received: by 2002:a05:600c:1992:b0:42c:c401:6d6f with SMTP id 5b1f17b1804b1-42cdb548b0emr34832575e9.16.1726153955430;
        Thu, 12 Sep 2024 08:12:35 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb0dbcb6bsm171928845e9.30.2024.09.12.08.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 08:12:34 -0700 (PDT)
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
Subject: [PATCH v2 2/7] perf cs-etm: Use new OpenCSD consistency checks
Date: Thu, 12 Sep 2024 16:11:33 +0100
Message-Id: <20240912151143.1264483-3-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912151143.1264483-1-james.clark@linaro.org>
References: <20240912151143.1264483-1-james.clark@linaro.org>
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

