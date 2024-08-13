Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53E819B5BD
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555507; cv=none; b=HVav0p71hXOtE//UI3uGFBp5j6P+MpLnNEilpczZGGtkaJWeQP+zr+ASnb8qO3lU4mlTHK+08P3fURbzFwjyUFqfjXxcWvCC6lRkbum0GWVIVNq91OFU9wMNwWM+S033XgR36jbNhkiTrgaxGTNICjp+ulZT2GjUPtjHEZXTniw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555507; c=relaxed/simple;
	bh=sk8jQ7TSnFQUuaoZblpBoM3GuHBThM7t2sSndxy08T0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=In9/vpbL6LSIWzgWfIcQhHikkWKN9pN7ELwwSosnL2NxUrObPVuFGATt3gd71LfPcBOFfIZymZ5LyrjKNvAXgy43BEWk7ZgP3gRN4B8GnaLDEn8Qcg9MM9kvBDnpLz2hF7umXAVaKyxuP7N2bgO3SgZvzKdTtWCB++U9sRq6jp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RUKI/Rn3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RUKI/Rn3"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso40610945e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 06:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723555503; x=1724160303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mUMDC/pIRcRlMc7URQ4bqWH4ou9rkjeyAIxTsLOjwA=;
        b=RUKI/Rn3O4aURT2ShtYQQ3jKAjOHq7BLf+P96vQgA0LDWT/losfWZfRg9MRLToZT6c
         UN7OV/7sOVKEF0DqW1WcpEdwNzrM0DrQ1gCby+T4x7nO1R9jLmU/XaqZH10Psp+pgnoU
         mvYcvLv0vO84sOdFxItRg1FsjhEf7zp7AcEQZvUkRDq9kxSR7dbOoKVHY2P+x4zNiI0Z
         vUQt2wmfGa8EvhMSw8zgA5oqpORUHE8Pjq91+02pHGiOe+X/l7fHaCSL1EEczig/68Yi
         /QJAclLe0xkdt6gi0jrvAGdwlIiBecprBLur/5h7sNWs14aDisMHME/GT4dDC8EvNmOD
         /tLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723555503; x=1724160303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mUMDC/pIRcRlMc7URQ4bqWH4ou9rkjeyAIxTsLOjwA=;
        b=rcGzCUKDz76W7aIklEXS81CF4c++UChhJ6BBk36FODQBEAHlP/kCrZoNFZanlTFaNV
         DxOdaUv7kxuNOx0+gIkRtAHMd0ynvM9DL1SJKZlSXaU35U+oz8Rg27erDM4ftGC4f983
         sMyxSGaBDBPXValjC7ledjLBhNlkM747+mW+EfAV7vE/2+Vq03qPWXtRsI/29qIvEaNA
         344A2P6/BEBVgQbyeDfhwyJCBQ6Fy+C0nbiLKGkbtAoaWry+TbkKoEP01vpD/zrAUls0
         voD53dwpkX2NE/JGjgE5OgqYfnj1NVizqTXqT2KsY187haNyC0SzzBSN978yDXzpmGBo
         P0TA==
X-Forwarded-Encrypted: i=1; AJvYcCUfcOiyyuau63FRdokEHjl+0eb5rFntbmQvO//rRzMjfbRCpu6h9eaAM5U8e8PTv6aFKq68+hoCsZLhmsKhdhKqYjwLax4Ot57tS18vHJ6m7Q==
X-Gm-Message-State: AOJu0Ywtlpq90bzQwth8aD1swRGHtKwJJ+YPlJGLBFP0ctEyI7tUMm8N
	9T+rG6hx5kO+mfr++xmK90WjREsENvtzcjbVA+utYIhthL4oM0L2UNZaEwSaftyih1Sy6opFCxg
	zJng=
X-Google-Smtp-Source: AGHT+IGw1QWxHLTWtfvThNKdG+ceHa5O84W33fyasp2TM4dbvhwsCi+UKFDYqmXqt/QG5hQn4Fsr4g==
X-Received: by 2002:a05:600c:1d2a:b0:426:6388:d59f with SMTP id 5b1f17b1804b1-429d47f4ac1mr26464035e9.1.1723555503354;
        Tue, 13 Aug 2024 06:25:03 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c738d21sm223186625e9.12.2024.08.13.06.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:25:02 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Ze Gao <zegao2021@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/7] perf stat: Remove unused default_null_attrs
Date: Tue, 13 Aug 2024 14:23:10 +0100
Message-Id: <20240813132323.98728-3-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813132323.98728-1-james.clark@linaro.org>
References: <20240813132323.98728-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All current implementations of arch_evlist__add_default_attrs() do
nothing if nr_attrs is 0. To avoid confusion that it's used, remove it.

It appears that it used to be used as a mechanism to add topdown events,
but this is now done separately.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/builtin-stat.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a65f58f8783f..cf6a1923811b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1930,7 +1930,6 @@ static int add_default_attributes(void)
 	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
 };
 
-	struct perf_event_attr default_null_attrs[] = {};
 	const char *pmu = parse_events_option_args.pmu_filter ?: "all";
 
 	/* Set attrs if no event is selected and !null_run: */
@@ -2072,10 +2071,6 @@ static int add_default_attributes(void)
 			evlist__splice_list_tail(evsel_list, &metric_evlist->core.entries);
 			evlist__delete(metric_evlist);
 		}
-
-		/* Platform specific attrs */
-		if (evlist__add_default_attrs(evsel_list, default_null_attrs) < 0)
-			return -1;
 	}
 
 	/* Detailed events get appended to the event list: */
-- 
2.34.1

