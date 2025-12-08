Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BE43191D4
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Dec 2025 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203808; cv=none; b=kwLjvJEHIreTHvEhDni2+NNaxUnqPk7xEpskhGtj5xDHequ6JgkF97Oyp8imvFYq7vYP1ZXkAU3pskCbzgSWFVbxfvzfflG5dVO42jOnFfdKcXxIoFPWxh78SlgPn2ZNiF7koILjrF4ZaCm6V++6d7aVSG87oULgL5fvU8lbrsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203808; c=relaxed/simple;
	bh=YtM+1aNng9k7tTt5Dwdj5usVkuCmgXWVCVWjkE7NZQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nJxsdFvZPJNNdp+BuSZaCwqPsJvM0C0MYg3BIU4BKnumCVE2kya07BGgSgBJKAJHpmTjbz+xXUTki71F9UMyIi4z6m8n3tdvMXYlyA1OsWn8PdtECJpdZJ14Bui5PvnVgD3S/g4Mlzo7MUOK7X6puSXMBCLOaLtaIRitZHvd7qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wVMUdblm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wVMUdblm"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477aa218f20so28891335e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Dec 2025 06:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765203805; x=1765808605; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ls6iiYqzfm34lFVKKpOeVQLMElwj6qnMc/N2H8cTBM=;
        b=wVMUdblmfTfyNwKftKP/20M9vVjys0O8acQ0DBBX+tEuBOSCLEHqDwkFGVTHtZ187s
         F7xdfW70j2fYJaIoQq8xbxJOd/eCNZXqq26EUlThr/PJLuyW2HbDlBR432ucCzKEJagj
         raorov8jE4eFD/IFg/7D54kaHZ3ATlNcleJpRZ4BTYhQQEybEdOr07PYdpAxTVw0IEKe
         n21dZcGi8i2T8qYlQMtRsWMfdknZpJRWasFggVKzn5FlyirkndOS6FR2/hRlKOKVFj7/
         RmwQp+yKHjGIV9srP8Zdvls7YpNIgSvJFTQ2awmtXmhYo0jqBPXVF+i+mtUlFiJNJt6z
         tnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765203805; x=1765808605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1ls6iiYqzfm34lFVKKpOeVQLMElwj6qnMc/N2H8cTBM=;
        b=wT/CNnsl7CN2lz+YAcJW2lxBIP5Zm7ZsxAwn9WyhzhXtK/kB3FPtHoiUPVS1HE6Lvt
         4bHDJI2ld26nDrMlyyrHlt8CNxCkHXIjr0UTTPlQI9H06A3nVuK1kT3R7le8v3LJAnei
         UMjD9fMSMZqFCDETOMriZ2p3C+kBq90daN+f8KgfmaQUAp+VwcrV9l1pHL7dxG/vTc6W
         6ix+ddwEHxhgVilppGTNZwSlzOJHF/wKHMuyM/d8D3amXo1Q6DJNX4ZDHQhL1uNyQLMt
         xaPyPKTQ0c7C5SxtfnLU9ST46Kg0ji6g7EMJIDzAxmTDnVZd2TyIp4ETEY/SCow1j7z/
         rUmA==
X-Gm-Message-State: AOJu0Yy6nK9MOdsfz2fWBeBC/zH22/v7BygBiaqGkEXbjAsJNyERViM8
	ZovA3NrEwyUqXdmcOdCfwZJDBBcVhwd2elxjBNJKLGMOOxu5VmlGAHKUGKKk7OxEseU=
X-Gm-Gg: ASbGnctGaIIQPWIRlIBm91mbBUmchYZD4D4M0hn6fL3FKZVqcG2HE0tk1Ye6E3X60ae
	dwm/dDzhOUHsZWyjXziSHPb7a4VaOb765FQjS+1GH75PW5/716+9vMgd/K6fyxXaE2RN3g6HXtO
	Ox3l/5lSFOLfSRmGqLTcywN3UHFlva3RDgHx5H37gEygJSY0kKKpqSGeMbGBc0vfLYpLZ5cjw0i
	bgdOq21QRzs6JNd+ij9V9qWUEZ/WgjKYIjIuGBzMaHZZKaU3zJ3ccFxVxerVtze5x2Pak+EQ9ZW
	/G131a6wbB1zS8giAE2cBI/y0uVE6gVqPuZFJ9VSJLTt5XqHQU7wVrLt0pBxZx59MdawS9T5Y7p
	u6cmg/dx2kCJfwuvsXlJrLtLFJPnEFEN8FfEMADamQCMgs1jH6015xHGIw7nhzfJv4dbdZhXCQg
	TKqiGQqodWTYWh6ZlsTgqa
X-Google-Smtp-Source: AGHT+IGGTDdxCfCm0gM0xxGcrXYIAxTama8dQFiA46eg6cBGPBkKoqG9sjgcfOrOmOKxOesrQvK/gA==
X-Received: by 2002:a05:600c:4743:b0:477:afc5:fb02 with SMTP id 5b1f17b1804b1-47939e246e0mr79324475e9.21.1765203805314;
        Mon, 08 Dec 2025 06:23:25 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930920e0dsm248561065e9.2.2025.12.08.06.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 06:23:24 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 08 Dec 2025 14:22:09 +0000
Subject: [PATCH v2 06/12] perf parse-events: Always track user config
 changes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-james-perf-config-bits-v2-6-4ac0281993b0@linaro.org>
References: <20251208-james-perf-config-bits-v2-0-4ac0281993b0@linaro.org>
In-Reply-To: <20251208-james-perf-config-bits-v2-0-4ac0281993b0@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, leo.yan@arm.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Requiring the 'pmu->perf_event_attr_init_default' callback to be set to
track user changes is a bit of a trap to fall in. It's hard to see that
this is required when depending on the user change tracking.

It's possible to want all 0 defaults so not set it, but at the same time
still do some programmatic setting of configs with
evsel__set_config_if_unset(). Also if a PMU reverts to 0 defaults and
deletes its existing callback, it will silently break existing uses of
evsel__set_config_if_unset().

One way to fix this would be to assert in evsel__set_config_if_unset()
if the changes weren't tracked, but that would be a possibly untested
runtime failure. Instead, always track it as it's harmless and
simplifies testing too.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/parse-events.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 7a3a90377896..c58829004fb4 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1528,12 +1528,8 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 		return -ENOMEM;
 	}
 
-	/*
-	 * When using default config, record which bits of attr->config were
-	 * changed by the user.
-	 */
-	if (pmu->perf_event_attr_init_default &&
-	    get_config_chgs(pmu, &parsed_terms, &config_terms)) {
+	/* Record which bits of attr->config were changed by the user. */
+	if (get_config_chgs(pmu, &parsed_terms, &config_terms)) {
 		parse_events_terms__exit(&parsed_terms);
 		return -ENOMEM;
 	}

-- 
2.34.1

