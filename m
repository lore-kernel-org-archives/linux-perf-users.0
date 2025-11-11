Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE8A34B421
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 04:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762833883; cv=none; b=PSomZLkGcXdZG06n/spVD8/3dxUqp/W8Ac2rjOOWnqvrYKxVZwjlXuO6ZdOfH+EpR8c5/9Dn126cMUqzYL2RFtm/N5iMMZPGEbs9yw40n2gxPGffby6+NRhxqQe4KyuJM+4n8nq1Kzl3QTcFzeRqIAj3zLbp35dPq6/TQOqPAyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762833883; c=relaxed/simple;
	bh=cZF5rXK0ot4f5Ll54hzIMYMkIxY+GXfM/HIllfqaohs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=QVo5LVxfFMC1eQA+fVRcFNkCuhoWyGH4LVgFlTkOdaABoNimyJttCfPg5x9yJdC4I4HwQSJtLZt8J/4eUVRHfwlmobr1mmbEv8SQ2HkU+nsSFrZ8ZxHxgdfljn6uAzsNCDgeeK+HuzFjYYsK/U43oobTLrNY54hLbnDS8le4tfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tMHZ+qj8; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tMHZ+qj8"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-295592eb5dbso34301205ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 20:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762833881; x=1763438681; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CJrFojSq6nlkAfypEMFi1zUKz5050bK3dx0VztPcSL4=;
        b=tMHZ+qj8E2QRfuhNUb4UXJNNDTw2JFFhWTcQT612muYlXUcXRAj772/9qMEvXT6Z3Q
         zL4BGjDwroZe4GLZueozy4yLTGLuTeOyPv2zsOGnSca339MkO4DTiPT0YXEmzwpimVGC
         +vN/slGRzVT+HZGC57XXAiUZQ1sGvw6i03BJHAUmvfk6HB6thkujsBRXlwtwiEOJ0Fhs
         aWMCJI6Y6QrmWbwh2kuGcA7J9NCSRIMATVmk7IvqFltowbluJe+zVFfuYzerWt+ds7f8
         P5qq5+YXTWF7GniPmE0j/QNhBljK6Yq1Vlx0DjOYPatLdcs2IKhmaPmIu0xxYolDFM7I
         Rqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762833881; x=1763438681;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJrFojSq6nlkAfypEMFi1zUKz5050bK3dx0VztPcSL4=;
        b=gujFlUjNXDK/ZJABbqfh/lnY1mlgOMfVLLxUlZ6T/1tm8Grp4QZT6oRJy3GA0dfNk8
         eu9MMHCLkXi8n7xA/ZHbagpWFnWO/68Utv8GQ+6v7/lrDw0e2vpRYM2OAeB8o8wMlUc7
         GD8su2fhjeqTy7TconE3ArzaZXr6HmnK9EgfYm3428IERY1JJlA8927mCDBg+eQN4I4w
         qcUrBXsh5GpvPCKNODXJgtVXB+qSS++6ghOAtwq9qX2ByQLaiPvLEorTu+aYIjAM8rE1
         OKdwH7BXLM9fWNygAJqPnQBkeO2bL5pLZCgiJUySUD8Xem3wufeJbX6ZGhG6eE8Ry62I
         KaRg==
X-Forwarded-Encrypted: i=1; AJvYcCXmpoub3ISe9BRPGU1gAEfIz22LKbLtbhBN/3Cp0UXYIcdsdaLO9fj93/L+gRupPJ+iO6aT0pBWFAmikWHSbVsK@vger.kernel.org
X-Gm-Message-State: AOJu0YyxOMLEX67sfqjVu8BNUYCexTf3KuR2xTLOsBcCgKEdhsxUjtMs
	VuADFkpbVdJ32MJBnC1mzBWq4AqiSiLr5gFJZlw3yB3RYQoZsTrZ7VlEfurtCfEvwACZK60sAN3
	SmdGpiyC5xw==
X-Google-Smtp-Source: AGHT+IF4k0uFcaS7/tC4cyXC8wsIhicVjSl/j9UnN2s9TsgyF6DRp0WIZCwddGEHn70Zm1RF4d0DU8ZooCF5
X-Received: from dlbqd3.prod.google.com ([2002:a05:7023:b03:b0:119:49ca:6b8c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da8c:b0:298:3e3a:ae6
 with SMTP id d9443c01a7336-2983e3a0b4bmr30376125ad.48.1762833881039; Mon, 10
 Nov 2025 20:04:41 -0800 (PST)
Date: Mon, 10 Nov 2025 20:04:07 -0800
In-Reply-To: <20251111040417.270945-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111040417.270945-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111040417.270945-9-irogers@google.com>
Subject: [PATCH v3 08/18] perf stat: Fix default metricgroup display on hybrid
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

The logic to skip output of a default metric line was firing on
Alderlake and not displaying 'TopdownL1 (cpu_atom)'. Remove the
need_full_name check as it is equivalent to the different PMU test in
the cases we care about, merge the 'if's and flip the evsel of the PMU
test. The 'if' is now basically saying, if the output matches the last
printed output then skip the output.

Before:
```
             TopdownL1 (cpu_core)                 #     11.3 %  tma_bad_speculation
                                                  #     24.3 %  tma_frontend_bound
             TopdownL1 (cpu_core)                 #     33.9 %  tma_backend_bound
                                                  #     30.6 %  tma_retiring
                                                  #     42.2 %  tma_backend_bound
                                                  #     25.0 %  tma_frontend_bound       (49.81%)
                                                  #     12.8 %  tma_bad_speculation
                                                  #     20.0 %  tma_retiring             (59.46%)
```
After:
```
             TopdownL1 (cpu_core)                 #      8.3 %  tma_bad_speculation
                                                  #     43.7 %  tma_frontend_bound
                                                  #     30.7 %  tma_backend_bound
                                                  #     17.2 %  tma_retiring
             TopdownL1 (cpu_atom)                 #     31.9 %  tma_backend_bound
                                                  #     37.6 %  tma_frontend_bound       (49.66%)
                                                  #     18.0 %  tma_bad_speculation
                                                  #     12.6 %  tma_retiring             (59.58%)
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index afbc49e8cb31..c1547128c396 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -256,11 +256,9 @@ static void perf_stat__print_metricgroup_header(struct perf_stat_config *config,
 	 * event. Only align with other metics from
 	 * different metric events.
 	 */
-	if (last_name && !strcmp(last_name, name)) {
-		if (!need_full_name || last_pmu != evsel->pmu) {
-			out->print_metricgroup_header(config, ctxp, NULL);
-			return;
-		}
+	if (last_name && !strcmp(last_name, name) && last_pmu == evsel->pmu) {
+		out->print_metricgroup_header(config, ctxp, NULL);
+		return;
 	}
 
 	if (need_full_name && evsel->pmu)
-- 
2.51.2.1041.gc1ab5b90ca-goog

