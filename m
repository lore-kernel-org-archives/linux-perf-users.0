Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E478221FCB
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Jul 2025 03:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752894347; cv=none; b=VxD6NbzAjUg0ji+ruNeTptt1Vb3nuj1HibgFndHIB5ryCe0MGjChKsX5riyIfKt+EYP2BqAgR23S8Sn0spSWM9K6cbLgQsk/jnxy3mL02+aD9Kxz3g64gP5UU2uFSyQ57ZWsaCkvBJqpxkHvCDEzDD2BWlQX6SurTSrB4UHgyPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752894347; c=relaxed/simple;
	bh=wXa1SCmjfrA/iYrTIx3xkr7OdsM/urYyoLsdv3r5x70=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=l4qIYlo7R8JsGkD2Edg00V4anbkY0nTZbMSPf6dV5PjhdMabt+6u55zbw9SpDX9QxKMNSJ6z8fJu1cYwFalTCMYvavSmBb+kl4ofa/Pe4qWETs2lIeKg1bV4q42NmDUBbmWb0pBkUBF8qzbAA/XmK51cFWyYVDJX6dyFetGKzwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UZvnIwCn; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZvnIwCn"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31315427249so2540417a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Jul 2025 20:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752894345; x=1753499145; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ZM3pCSwYMC0xtzhmcoaS56jTJWwNHuIZbVeellQWzo=;
        b=UZvnIwCnUH3/BzMe8nsLAV6HUrAE0Rf5+pkhugssOrrDp+/RW/74U0zJRzVV7QYAOz
         WUITNAveMvC1rn9qf16KaHFdTBbfH037KFqpPGhhq7zyFVUHuNBVx8ZOYphdmVclzF5b
         DWUPG+wUmstja5KJLcdwQ+odTudma8wYJON9Hq4Ow3Nf6So9Yt/3egy7grO9I3fKxozO
         2+Zg4N8+h8J1tZbBJEmy/ePJn9YiqePMSDMhnx9En8GVjkrhi6SLDfoufKmwoCIpKCx0
         Iki9/Bz5gJPBgB5Knat3R9GfNAkoaLHwJcQlk8K2rZFGSPb5nRoofskmDYi9WxVeW1HC
         EPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752894345; x=1753499145;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZM3pCSwYMC0xtzhmcoaS56jTJWwNHuIZbVeellQWzo=;
        b=PrMJ/40ozHryOwYTcDC6Q4HOA8ypowZsNDduqW8LAvQw49WUJulLKi1XGrnRGWZ+mY
         evNP7kfhI34daLVS2eGCb3xb0cuLFoK+7mdqqMLAyvGdnKpSj5l3Wi+umtt2jnEBhAGQ
         5jcj9YD9JRoeRtJ7vO0T5vE5sbe8ecfmgCE5h9h/2D9myTDBxV4zNapad2E2Uh4zKODZ
         PWRlCJKLRzqOBLxaPrOjuslLDMTyZYZaK2oKSm2bjB0OyE5eoUFdnN4VlUEfZ/qq4AX5
         QrS29feg36xFw4EgFpZbOywmMK+p+1IJ4+vJYRIvt880JyM2PgaDjM4rSV+uBL9Y77U4
         zeQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4Xtvv4s+AhDxnjwz1O1QHNQ64ZoKjT1E07sJkDOS/7zou58t02t9MyvV5C51wjwtRa9A74qSs6DT3CpPxADOK@vger.kernel.org
X-Gm-Message-State: AOJu0YzGh4eeovHR58IcCo+aAr7wsqahph6Fu7hDHqyTbrXPEY0fhpcM
	YAogFihnCKd2wRXd4WgqR8cVrzsBxcWO3BFYP7Y4JM3cAL3zwUx6qFY1yBFooJddmMbWCJO4IO6
	KXIsazgSFyg==
X-Google-Smtp-Source: AGHT+IGxTK1lulIEjB+dBbyn5f9/P/TVosL0kIfsZoFKCIIF6FSBvW7lRnCfCOa5k4w9eAI/HS2myzqxvBSD
X-Received: from pjbqa9.prod.google.com ([2002:a17:90b:4fc9:b0:313:d6cf:4fa0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:fc46:b0:2ee:d371:3227
 with SMTP id 98e67ed59e1d1-31c9e7617d1mr21663665a91.17.1752894345374; Fri, 18
 Jul 2025 20:05:45 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:05:10 -0700
In-Reply-To: <20250719030517.1990983-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719030517.1990983-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719030517.1990983-9-irogers@google.com>
Subject: [PATCH v3 08/15] perf evsel: Use libperf perf_evsel__exit
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

Avoid the duplicated code and better enable perf_evsel to change.

Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ba0c9799928b..af2b26c6456a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1679,9 +1679,7 @@ void evsel__exit(struct evsel *evsel)
 	perf_evsel__free_id(&evsel->core);
 	evsel__free_config_terms(evsel);
 	cgroup__put(evsel->cgrp);
-	perf_cpu_map__put(evsel->core.cpus);
-	perf_cpu_map__put(evsel->core.pmu_cpus);
-	perf_thread_map__put(evsel->core.threads);
+	perf_evsel__exit(&evsel->core);
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
 #ifdef HAVE_LIBTRACEEVENT
-- 
2.50.0.727.gbf7dc18ff4-goog

