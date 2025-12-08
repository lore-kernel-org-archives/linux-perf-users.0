Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5602EA169
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Dec 2025 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203803; cv=none; b=GRtv8J5MjrwcfrNo48KF8Ayhic8vzSRqCjWwNOYD+K1G9OpZbrev5MsKVoYnB0WOQJ7C/tO+IJ0//pcSYOcVr5DdBMolzTqorl0jkhCyKl5nfOXFz9JqiLQ+Yggy7N5L7ZBdj4qloCGIj73ZKH//Ve60aC4oIteQ/PiYmo3HSIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203803; c=relaxed/simple;
	bh=5NCEYmFOMSn1NnqH2r6SLNGkyrF/aEzQcgPmbeVVcCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cpNF3wWI/8QdBg3L5HmnTO/6mF++mJYGo1u3avKZ+c0mI5W+fHE0nLozTaqH4hXyiKz42b1F513HM//v/RUYdAp2hBPvKzbRtyI0MW1N32NcKJ7m2nKNGQCgvwK6+cupqhVgP+WL1PNRvAc2+PQBp4+ax4pY7o+hAV45Hi6C18c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZdtBGmU8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZdtBGmU8"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477770019e4so48364525e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Dec 2025 06:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765203800; x=1765808600; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fo3Ukb8C7ZJ/8SCaXAl1O3xmDhdyoGsW4g7zVBrDJgU=;
        b=ZdtBGmU8Z8qYRXdAnrkBscTAaXJ1FUvw/xBOi8Rwlp2t5+RCPKP67e16WsYiPK7J8K
         5/yqU+CrwNiwkaC6fc6rfJwRICt5hvzjfvEpVdK0D1rI278YdN/JXOlKhQZUcvEHW1pi
         Skl2Hwx25ln97E3ZL38pkrOMUwcBdscrxKimxa1soYEuz95z1k8C0j/TctnmxoBbpq1c
         oyxuNQsesByoodEm/TvXMA+BWlQjG60ZxoabHU24LKsvNG7/aI0dL3NZkbKsa7e903Xr
         j+BJtLWrQTsgqCl6RElU0VrHpbrsEEYzkOKQVR1D7D6TZLuNdGBeJPHLsmLj7Rz2Kpsg
         gj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765203800; x=1765808600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fo3Ukb8C7ZJ/8SCaXAl1O3xmDhdyoGsW4g7zVBrDJgU=;
        b=maJtaYXmHR+k4HuFpDUBwYw5RIVQ+G92D+0hIlwWn3QchgvMQvEtVKLYSK7hVFfa4S
         P0Ie8a2hE6sitGsBnNQp7CZXC8TAQcFxV89JGUSZyla6LiOYYJhPn05myArrwSeyUTYT
         lCviiBlqIn8aq+kT7xPqnnIdO1pezNOvj+st2UvBAhnta7VRArSgL2NlP6ygpIRdzKXY
         KCmp2zHrMxZshZRpTwqb/Gy9FwgfEEXOiVBnMLwf9O2ZSJhZf520IcTHrjvNlcFi7ohp
         ToO1lJJn9lJkCrIAuKqRpkA6kA+uIGpIzaStRDBTBAWjoewwb/7l3NG4aywgTZ527DIE
         hHGw==
X-Gm-Message-State: AOJu0YwCZbbnOVSL4tdhSSxyKOdyMzQ14zEAzWGzePWTh/BLkvcrzzbi
	+pE09W9buXiexL1sNSU8tUhgiPlyL8AaMh0u4TKdc45G7xYYEB9JH8VaJOWzJ4y9+BU=
X-Gm-Gg: ASbGncuVJraoDoLAXhBLied04eWAWZjrXB1hev4PzcAxwMvwpmRhHTM7xXK3gidwpuh
	cRojGIg80Vj2J3DwW1lVrKJlPWkAZRmsj3UlDN3q8XRVDYtjYPuYI7YdkWXtxodDYDxbMr1o8VN
	OnVdgGTUpL8Bo+LvcJBxzgFwXW+dBoyWBdCxc2nz9/q59PSvjo0cNfZvfeA/SzwtjRkDybCuoWI
	3pX7hXCkrsOl++SiNm3O4dvpzDtgQ3tdBF4KiSAoP7rgHl0lfBaAA6NzFZpnMxZ1C1VSV+zHSTU
	lIVcXLVMEhcRM+BJUhOjJ0zvv7HEwRkimSyBFm/XSP7rB4TsvrqzytEIJQGHemtBvP9yxfXkx2D
	Vml9COe58yj1awhYLECklIumYuW2WowNWhcrwr0k5YtynXNo2ecD7P8z0W/z7iGGUo6BYDJ7qV4
	G5btb21iXOkERMdlQnVIfg
X-Google-Smtp-Source: AGHT+IEWXXN+QPhKpdMYQbMuezg4ndaMdLlTrhbxsRoIEQiDGZKKfKzsw7aEJsV99BxsYe4l/srBZw==
X-Received: by 2002:a05:600c:35c1:b0:477:9cdb:e32e with SMTP id 5b1f17b1804b1-47939dfa0f0mr92586695e9.9.1765203799977;
        Mon, 08 Dec 2025 06:23:19 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930920e0dsm248561065e9.2.2025.12.08.06.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 06:23:19 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 08 Dec 2025 14:22:05 +0000
Subject: [PATCH v2 02/12] perf evsel: Support sparse fields in
 evsel__set_config_if_unset()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-james-perf-config-bits-v2-2-4ac0281993b0@linaro.org>
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

Sparse config fields are technically supported although currently
unused. field_prep() only works for contiguous bitfields so replace it
with pmu_format_value().

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/pmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 956ea273c2c7..2c26c8d76bed 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -144,6 +144,8 @@ struct perf_pmu_format {
 };
 
 static int pmu_aliases_parse(struct perf_pmu *pmu);
+static void pmu_format_value(unsigned long *format, __u64 value, __u64 *v,
+			     bool zero);
 
 static struct perf_pmu_format *perf_pmu__new_format(struct list_head *list, char *name)
 {
@@ -1381,7 +1383,6 @@ bool evsel__is_aux_event(const struct evsel *evsel)
  * the bit pattern. It is shifted into position by this function, so to set
  * something to true, pass 1 for val rather than a pre shifted value.
  */
-#define field_prep(_mask, _val) (((_val) << (ffsll(_mask) - 1)) & (_mask))
 void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 				const char *config_name, u64 val)
 {
@@ -1398,8 +1399,7 @@ void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 		return;
 
 	/* Otherwise replace it */
-	evsel->core.attr.config &= ~bits;
-	evsel->core.attr.config |= field_prep(bits, val);
+	pmu_format_value(&bits, val, &evsel->core.attr.config, /*zero=*/true);
 }
 
 static struct perf_pmu_format *

-- 
2.34.1

