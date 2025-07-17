Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C00424110F
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 21:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752786175; cv=none; b=uuY/ASvXq7EbkA7EzAy5YE2JRgjiViuS7QM+T5xkAXw1SZlZVD/VGPxniyM2DrmsG0L0Nux+FEQLStisL+XJ+/vBhvccwtEWdRnUFUuhx9KLCNHEOe2TEmErJEuoGdkhbemcEf5XIIhGiIQ4Kqqn5qz4deqo23SC65JSw4QXbJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752786175; c=relaxed/simple;
	bh=wXa1SCmjfrA/iYrTIx3xkr7OdsM/urYyoLsdv3r5x70=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=A262ihNtI4oPXY2EVd5YCKazVNO6Cqo7jMpEWXYiaKjgapZXqUJfi+g2ALjHUVzO4mBxVKdY2p1J/2qNDLRUIwa7VTxbTx8KrZ6lcF+X7yuMh7VEwNarvFDYfYqru5EVi0WL2zbONf8dgOvFgjziwEySaqrdHQBIES66A0C0/20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZHe7fu0z; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZHe7fu0z"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31cb5cc3edcso779348a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 14:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752786173; x=1753390973; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ZM3pCSwYMC0xtzhmcoaS56jTJWwNHuIZbVeellQWzo=;
        b=ZHe7fu0z586wTm8v48ZV9Iqw6nHOctzMHHrN4I5o/0/ed8VM3RiPIiBcnB6rtrLRjt
         sW7J/p/KZ+Ympi9Lkhtv7r9IM3GBIpnbiCVnqCVVHAzS6L5u3+u3jHh003nijm0i5SL/
         /X7rgahy0ICkTPV5W+PF6XVWUce2/CVs3YCoHTrBRfJxfh+igFbWY0XcmXkX5wnjL+NY
         Q3T4taDmea3oSZd4OFY1JuCvmAXW7eXORs7GSr+RhwHdy4LEO45xa5YxZlIeSK4WpCHx
         dW3SHvhE+q2hxDCtlQLq78SsTY5L/YoMQkXyo08Ho+TLXPx88za+d8RFtk+R6us2EfnY
         BvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752786173; x=1753390973;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZM3pCSwYMC0xtzhmcoaS56jTJWwNHuIZbVeellQWzo=;
        b=lGyAS++KqlNnQlNa3B8NCksB6RHeydVTlkKMnc1Eq4cZM0t5fi9pbJLF24DC07e2ax
         zVqObDvpmiOb4AtO+BJaQDDpvdX0R/vEXeTxzIWeKo2zuQRNfKw+fdO0gdubTBKLmdSt
         YQYVueACvqSBNQONO1FUgPwoE/qNumUAd7QFpLtCfWVVXbnVJ/3yEJPsqN0TD7Y2Du56
         8WXhpwhidLQvsODHzGWyzAjv8hXGUj3F6g802TdcdrK8ZxaT/PPfIgnf5ZHEHh4pZ2ng
         mI63jK6G9Tncc54OqVOM9EXobPKac35mhes2VuudtOK4uwRD5DarR69TRzRDxn5JJLKU
         dhZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl7Zg9h0hpJJYUbXZnxSc1kYLLdYBLeGtsEg1VE2n3M7S1frItR0d/8PBlHX5jYylhy126wPJBx5NtnKI9qSYK@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2/No7YIJJoVZTgyYBrBlfUq3DM+IetwSXQpBpzfmlHT5AoqD8
	bHQfxJY5mIgE0dHo7Y0a5UuDtFTL1G/UKzmODyy+nibeftSPidPBWLYsLJr9vLeIHId3/BvDAGV
	6Ev/1JbozlQ==
X-Google-Smtp-Source: AGHT+IHUu3zgtgmAaVp6ifFETkP1mzQNAhWfaE9t/IlHqPOCXxgmX4IzE1WxtYzCaCEmo6bbXbyj/Om1yeyA
X-Received: from pjbst15.prod.google.com ([2002:a17:90b:1fcf:b0:313:221f:6571])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:58ec:b0:311:c5d9:2c79
 with SMTP id 98e67ed59e1d1-31c9f42e84dmr12055444a91.21.1752786173521; Thu, 17
 Jul 2025 14:02:53 -0700 (PDT)
Date: Thu, 17 Jul 2025 14:02:29 -0700
In-Reply-To: <20250717210233.1143622-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717210233.1143622-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717210233.1143622-9-irogers@google.com>
Subject: [PATCH v2 08/12] perf evsel: Use libperf perf_evsel__exit
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

