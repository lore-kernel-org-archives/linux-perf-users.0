Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621763;
	b=yHO1MZHOJUnC8gtekIyhbJeOthopUKvCp4f3IOEEEhVXrtsCRWkGzrnRP0l2Kzao0b0A
	 ggI8LHypCEPo35Cj7YXizxRvqqYUiPzDhW/3QJcTU91MYt9NvqTS7skY85rEhkR2yHTMb
	 0aX0tq5/d/SQJpEazhoU3ZM0Dqf8s2HCOZvEtpeswkLjmNxJhJA0kTKacKTuCAR/ux3x/
	 ycmeJ6DqVo2j8gRfUdcAoyHmC/YQmEGUXAGAuI3dlO6mSBSt1Y2V5JUIg7u63zuF6U71W
	 Y6F4TuglvuT0vOUUD44Tm3q/wiUh/xp9q94sPnMDnnpkeevSdbsD8RvoxrLLEc/qXqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=+9NpFkRdVW/EG2TCUGvGJ4MlQ2xcOGmdMzm207Q8vjU=;
	b=XcbTDSLt2mN/8eBKa6NFOLNhCFYpwkiD0RprPEGyvN3phgSoGTT3JbmwIsSmjvvnaIN1
	 Zk2rqtMUQYSUEeORWm2x+deWhjn6J2wfWzxr8SX+BihVci84JITUGL6E/xSLdBdvsS7Ez
	 yD8le5MQ9J3fbaozkrN7u6ArA7FuHlGx0CJYs+Kof+MQIN9Vd4Zdxbtr6CtafmJfrHmND
	 ehim8h5sgj/W6ZF8iLm/l1yvyX20BPPJHW6ch/+AnfGUPt6ulhLNrRxVJqKONLmAyQ8kU
	 clMKbb8TTDC8xKfTyGDF+sKzl80djZ8TPIjUJP1AJduv3e1+rtV5wao2Y/8rBgrrgUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IPl+jZoo;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21681606B1B9
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21681606B1B9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IPl+jZoo
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso20191575e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 04:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793621761; x=1794226561; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+9NpFkRdVW/EG2TCUGvGJ4MlQ2xcOGmdMzm207Q8vjU=;
        b=IPl+jZooc/Ocqa/xTyy0eTf4YzOERgAZD3gXOxXDZT74tas2k1vjLvWMwevPVRcqBL
         maKGsTaW6Sv5kdK4mbpfYVPn66mrwKrpPWsVgJXcnXPiaUJ5s2A5Nq5JeQtYBrGw2aIS
         vkIiiLOXFvzhPDz94DN/xahwm0DiDHQnsYxlp3FGehTNRUkBd0ixM8SXHBl5hqOvWBY2
         PD593Ari+fFZSjZZy5augqgkV9jBYii47phS4MVNOesAnAn42QdtkY5VcQK2DkqXRDr6
         RAZSX2JrDQhRmye/f0pAV2czhLBeBLCCHYSbDWpkXsYywwRfg3VHR7WvTJFiR3oHRZVg
         RNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793621761; x=1794226561;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+9NpFkRdVW/EG2TCUGvGJ4MlQ2xcOGmdMzm207Q8vjU=;
        b=tN6X0Q621ZF3z3+GsMacdEA6aoCtK8ptetNCLSyz5iYDrBqvqwftQq2Izw1OIpzBVe
         GuKyRCGM53pAUhuKvnEs9aukix4p5m85te0gV3BeQEoppjt7yvXw2d8LiMGCgbdpBUOY
         H5rHyrbxYnETHCXQ9EPegVlXeFvWfCx7mUiJPBCUt9/HngwUFmgDL7/qvbZgbeL+Mee5
         eE198w1j/C4kGUEpc8NRRuAEnrXU+A++lUw/kuJy4RZkPv0472eVjVXrlIMZig+l1gW7
         jq/fKH0POaOgdIFL1UbT1JXknYGIIPSU76Tn9QXgvb4tQlHTP7zd9bKOs2jYghoLfnRH
         rt6w==
X-Forwarded-Encrypted: i=1; AKwUvBzDtumW25D4vGTS9+/Nx0TSGIDRX/e+zQvBD42IXY9lyAyRSu6gdPgtMiHVaIICCeBmUvj6msSmI4m4TsAvXIoo@vger.kernel.org
X-Gm-Message-State: AFq9FYLTfR7d/PZXrpbvansln48HCTQo73d/AgmJ6PS6F9HWqL1+zBrS
	dIdZU4VcWV6fn7uykv7bJ7dkIqtfSdAa7mdET2lOX4elmVVwqL1Yw5H05UeVfGdDl68=
X-Gm-Gg: AYBFou3UwTb+rke4vY6bN4SbHiFg5zJThHWnXVwkaFlUYiq7vcNXLwslVZtKqalPrei
	440w9YBy6hSzcge0HHn0Sra2284kOcWc5YoGnufMciN9wHItkIbQzJMHSxl21yB5RfoyDnMcEz0
	f8p4CqNLxDfB+QGDOoqk5qcIlfEVXhVJ9S0MsTujwfx2vmoWTJL8Dr1QZS/q40I9CqklBzFRxqX
	TAQf0DoyDmaxBcIuqNJcF2GC0xXxD2U+ijBNF6yVGWJBupRE9f+Yg4/sPo0tFyCCD7lTFxcgSpi
	DC/Hxi6XIqNCYdJ+7d589R+46NOqms+kzkOjnenOI0CaVXb3YUpjf3c9jOSu7IZqoob+MAESj+t
	F0vIMR3HClyk5GUNL8tHdJLtgweXjdQE94v6cDsB+6WcffZYv9aNpggBcTEkyX1xPdZMTlH9rkK
	+qtyLfvXda2ielSDfHyZhSVRRNAxHJ0UZD1cKDuzVn+93G7fAnv/DJ1JVDu4DHzvGG7mXE4VU/t
	YAVUd1qHNG/IyvzaHQrNTwo6svO8lVwIexAAs9dfG7KgLRrqg0umOumpJInatk+MrLdYsN++bpi
	2cV+DKmI0eYH/HKY7dIbrtge3vIXZ2iyvgo3H5x91WeGkgUbpawH7Q==
X-Received: by 2002:a05:600c:6285:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4ac182dc8f6mr222521195e9.34.1793621761658;
        Mon, 02 Nov 2026 04:16:01 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm434974855e9.3.2026.11.02.04.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:16:01 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 02 Nov 2026 12:15:28 +0000
Subject: [PATCH v3 14/18] perf cs-etm: Don't print missing buffers in
 snapshot mode
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
Message-Id: <20261102-james-cs-unformatted-per-thread-fix-v3-14-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
To: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, John Garry <john.garry@linux.dev>
X-Mailer: b4 0.15.2

The driver produces lots of AUX records for trace data that was never
captured in snapshot mode. Downgrade this to a pr_debug3 message as it's
only an error in normal mode.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index e899d82b7c93..c880a1ca7533 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -3361,6 +3361,9 @@ static int cs_etm__queue_aux_records_cb(struct perf_session *session, union perf
 	struct perf_sample sample;
 	int ret;
 	struct auxtrace_index_entry *ent;
+	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
+						   struct cs_etm_auxtrace,
+						   auxtrace);
 	struct auxtrace_index *auxtrace_index;
 	struct evsel *evsel;
 	size_t i;
@@ -3414,8 +3417,10 @@ static int cs_etm__queue_aux_records_cb(struct perf_session *session, union perf
 	 * don't exit with an error because it will still be possible to decode other aux records.
 	 */
 	if (!found) {
-		pr_err("CS ETM: Couldn't find auxtrace buffer for aux_offset: %#"PRI_lx64
-		       " tid: %d cpu: %d\n", event->aux.aux_offset, sample.tid, sample.cpu);
+		int level = etm->snapshot_mode ? 3 : 0;
+
+		pr_debugN(level, "CS ETM: Couldn't find auxtrace buffer for aux_offset: %#"PRI_lx64
+			  " tid: %d cpu: %d\n", event->aux.aux_offset, sample.tid, sample.cpu);
 	}
 	ret = 0;
 out:

-- 
2.43.0

