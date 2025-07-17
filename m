Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2C952F88
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 21:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752786165; cv=none; b=Vg0eckeXkilgndDIW6w5SBceMPJixIXTmNLAatd0YXp5kz/CgA7LMkbrxJM28YvujjbbR9wij6oun7MqzU+ZrxQeHyaqQhFeIFdFfk+2lFWmnO3q1154PnxWmnlmhRudzR69hAplVCBp18542L4CPtoMw3ALKnpuem2eCz2ZAzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752786165; c=relaxed/simple;
	bh=rxECd/orHJ+FjXD+vxZ9UCxbrPbeZ0Ymr36fQ+vUgvE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=rGMhWwpW8dr8yKwq9BcXh1Ma4GgxfP9NeJskUjv/QOipk4XRZxPIjpgY2Yend9wMSm5tl2UTDqEDG2KTD6D3gAT6vucgky8SM/MPHHqGlwmnn3J5/82xQhBxPc1n5DbPObL+pzjG6UwaCOrMx1+IuPsNmfn0SkMgTTBvyTTneoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kL/aq8pY; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kL/aq8pY"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3141f9ce4e2so1955352a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 14:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752786163; x=1753390963; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8LzGDRK9pbbZy05/7NVo0qy9CZXcleNoSvz0ippsT70=;
        b=kL/aq8pY0Mc7uRz9P2uhSIaSgGveJw8RXWFzuUU+nef1tEVlGlXrK+dZrPRjYE9BKg
         UhQk5ev6pjagq9wF+JiM6PvJsdIRraiqTOVphMTJfQzWFyeIiyHcmJRKHiZATwMbjaDQ
         TZ6s7QzvjiiiBILxWe6yY2NVH88odwJHuC2jrsBGYQO8gDgAg+eJVhv8p0mTswJeEkBl
         e6lw5CThFaMh4nVddf5Hl1aaVIXX2yy9oOutErAC73TQyreHXs7IZNP09ghL0wD/zjit
         Yt4zMV0N2/LtULRRotHIW2OUnG4FCq0AM7dC37yfH7+7robP+PLKsli/4ZM7zcnc6DFe
         5AWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752786163; x=1753390963;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8LzGDRK9pbbZy05/7NVo0qy9CZXcleNoSvz0ippsT70=;
        b=ano/8J/ORlcr901Ch7aQzgt/N8ny9by8i131ObJEZXFTKs8WeqAX+SyhsrTBDFvLsY
         s/CVgaFNMnZxOKk1i8m+nGg370+gh4LCmdzo0dwgqCXmHBXSB93gCtBMTIJHeAyYyQlz
         38d3qZ0AbPoz7WTvUUh6Kljs7RWgmJQSCl7HxiOosD7N+90jo+jrWkjLdC1bOvVcdcio
         SVqChX8lxEaK/4k7ijJFIR2jsjQ6UjDfWOL3YDnmNWx+jGM1XCWg1Di6CqPHs3koG7RT
         O1lMprLz4WFHgAZ0atJzgSHNXKzW3tDnmiAs8MoBrzIdVdRTzII4X7eyRJgkPM+81V/5
         eK7A==
X-Forwarded-Encrypted: i=1; AJvYcCVDs4xLDYw9sblz0r3WCLP3ZOpWR2euNqyOkHrxY5iBhI8t3FY2IDBpQTteDK9fB1jDVFkKi3Sd0/UV65v+CZ6U@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdv268yAVrifls6cyVhdDv8568oCPQK3DCYS0msfHA12pwTDTC
	nObcH+Ne9XWSgIU1x3bd4vy71k0F0u1RF43cSPgwYq/UERK3XncaxnZrDnI5RlLeMqYC7gOdKLw
	0JDEKRK2pSQ==
X-Google-Smtp-Source: AGHT+IGsliyvhCftHU8djUYilaALOZXqY6bbgwjC12dls6LI/EgUoGa/R5hu086zF4Ygat+4qBbb9lXx2O9T
X-Received: from pjb7.prod.google.com ([2002:a17:90b:2f07:b0:31c:160d:e3be])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:270b:b0:312:e8ed:763
 with SMTP id 98e67ed59e1d1-31c9f42412cmr9768817a91.22.1752786163575; Thu, 17
 Jul 2025 14:02:43 -0700 (PDT)
Date: Thu, 17 Jul 2025 14:02:24 -0700
In-Reply-To: <20250717210233.1143622-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717210233.1143622-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717210233.1143622-4-irogers@google.com>
Subject: [PATCH v2 03/12] perf stat: Don't size aggregation ids from user_requested_cpus
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Blake Jones <blakejones@google.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Song Liu <song@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

