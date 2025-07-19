Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D62A217722
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Jul 2025 03:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752894338; cv=none; b=DvOJ493QfVAU1BxMax8PwyotAOFClmUOlt0wegl9gAqAI+A7yb9KDZiLtNejzmzksib1eRLuBLUNgRkCL/IHfc8NqJedgwKRZ6+ulw2Ew3E7iaZ+6PV/QiDD1grBppTjJp4LWIekPO18qpZvyzJuP+A4uYnRm3GsV2dheEMQlCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752894338; c=relaxed/simple;
	bh=rxECd/orHJ+FjXD+vxZ9UCxbrPbeZ0Ymr36fQ+vUgvE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=OPaQFtjIWZOUhPTAovegRoy9y+7nmblUievO3cdrSDTBU+oX6Cg7ef/VgrvsMcWo2bntuywKP1vs4YU38DuTJMxWiiUoX+IhQ5CHiN4fQseKyLPbgee+kbvnooJCE7bGfc51AMqEAXzaKYHvy+LWjM9vV+llgy0SOL3jinoAEa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bULmIHrv; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bULmIHrv"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2ffc9597292so2019331fac.2
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Jul 2025 20:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752894336; x=1753499136; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8LzGDRK9pbbZy05/7NVo0qy9CZXcleNoSvz0ippsT70=;
        b=bULmIHrvuv281+jkDXslrXQLBccxdm9zmDt/3ZkoKnRwEHpz3LhXW+nafuCJ7doU+A
         Td+EdCisuVrOjkPHFejizvUqk1uf1dWF38F/tg440xzBhvEFgx70R/55ZxYAi/jyZqTA
         24tqF0bFX1Y4Rs8cbNSV2zQ7D/z7xNHubr+KTpRvJ1xoY+zarz8zp5kX2pZMkZypR1dV
         zn218QQ8JolXSVljr5cWXLmox0qFPaGt3ot3EPmCoZChLV9/skD04l7QrUifddM5RpTr
         3EHt+3XxwvGUozegZilI4TZOEzYlpU22T2t9jwyGnPnnbJcIYyp9g1Exo+X9nS+NF2ti
         /n0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752894336; x=1753499136;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8LzGDRK9pbbZy05/7NVo0qy9CZXcleNoSvz0ippsT70=;
        b=Wdo20wNe0h0mtJXYhhcAVhnNVd1oaM/Rpf7xGbmYWHFSuxBBkMtHeiE88Qt/UkBI/s
         XQ8ZNGRgI7gAUQ2v9+5IeJO2HZFDzJR9fora6I2Mc+3Pmiv2emU/FLwj4DjAx/pP4v/3
         +gPRxtVTNX76pYy8JDsFTC33ekfhF6ms4BdlmRhCDBdsi80SOcNX7QphM5DrwQRU/2ak
         vYWS+g6z1Py8I8qTEDs6Cj0sZabyHvrO2mweFmwUFX5k4Hp6K/SN4AQ+rzTNHsJy6T8K
         04EvE++lS9OAOXA9B55JBXDDszNJ0GXySEZIwpu85DY1WZ+T537pONeXTN1iaMYR6m5q
         fghQ==
X-Forwarded-Encrypted: i=1; AJvYcCVusu8Iq9xqkmWgC2pNZHZmLmSMqxDaJutFeeIJ49N8zazxEuE6Pofrp8UIiPUhgKGP4zexE2tpZEBv+mgkRTng@vger.kernel.org
X-Gm-Message-State: AOJu0YxAreK8PsnxARqdrJ7Uj+dYkTQejXQ0AOWjD8OasYWZwwgMbYiM
	LNYvhrA0Hf5shQE/EArN9pJmt5zyFBQzC3ijoWmC7weDSEOS2G5VSKI03SCZvfOGjM3Ujk/yhpR
	3RrsOpTYMVg==
X-Google-Smtp-Source: AGHT+IFeWvY21rnTa5jdEzRoKSaAvbnA4CvHa+J+RiVrn4VIO2NTPCK3Ajtkev5HdcX/TArTEOy39Ncf8kGY
X-Received: from oabdy51.prod.google.com ([2002:a05:6870:c7b3:b0:2ff:f5e9:3348])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:171a:b0:2c1:e9a3:3ab3
 with SMTP id 586e51a60fabf-2ffd2aa86e6mr7068513fac.33.1752894336264; Fri, 18
 Jul 2025 20:05:36 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:05:05 -0700
In-Reply-To: <20250719030517.1990983-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719030517.1990983-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719030517.1990983-4-irogers@google.com>
Subject: [PATCH v3 03/15] perf stat: Don't size aggregation ids from user_requested_cpus
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@linaro.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

As evsels may have additional CPU terms, the user_requested_cpus may
not reflect all the CPUs requested. Use evlist->all_cpus to size the
array as that reflects all the CPUs potentially needed by the evlist.

Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 73b4521ab8af..00fce828cd5e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1513,11 +1513,8 @@ static int perf_stat_init_aggr_mode(void)
 	 * taking the highest cpu number to be the size of
 	 * the aggregation translate cpumap.
 	 */
-	if (!perf_cpu_map__is_any_cpu_or_is_empty(evsel_list->core.user_requested_cpus))
-		nr = perf_cpu_map__max(evsel_list->core.user_requested_cpus).cpu;
-	else
-		nr = 0;
-	stat_config.cpus_aggr_map = cpu_aggr_map__empty_new(nr + 1);
+	nr = perf_cpu_map__max(evsel_list->core.all_cpus).cpu + 1;
+	stat_config.cpus_aggr_map = cpu_aggr_map__empty_new(nr);
 	return stat_config.cpus_aggr_map ? 0 : -ENOMEM;
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog

