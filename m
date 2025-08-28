Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B830527AC41
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 06:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363361; cv=none; b=DaxjOtOHyVG7y8hdsQ+lZve29F1Nhl91gUyj9aF1U814W5sb0tDWr2P4N6jlhHx0O3ub5Zhc/mHm00CZiMj+l7alEmE2ZA0mffKWRLpeS2CqbwoY7MpL2H74g4yg2c8nQwQZzU7pjFEQ9IwazHnIW3aJlyfJB7aFWkDKvyU7r7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363361; c=relaxed/simple;
	bh=nBsGDyfGV/YwlVsRPVyPqun5rVk7VjpidpS76C7cgSY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=UZKMI8+N4KBJ6ZnR3w9AuT3Dy4Bz3CImJljUdReh1sQJ1qtwzj3f25oTtgBK79Nt7ZIvP88cqsYFwIDuAWQB02VweMuC1Oq2Of4N+O0eQ9BzWbjWFkccS9ctJqJmLTRlcsZOkvwh2NZUwCQ5IRgHUSP7L+H9WcbTLjzIZfa/Vzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hy7sx0gn; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hy7sx0gn"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-248981c02cfso7279455ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Aug 2025 23:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756363359; x=1756968159; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aOQ99xgVI8ZBcLOUqTlIwSjxWz4nfhGrBQ3qwqf0K9I=;
        b=hy7sx0gnZSlof0MuiCEsn4Oe78htN4Ra+vSLl+DgdM9YtmYrBvKLGMlx0MzB747AuX
         BfWyI22w18HH2G6Cy5I20nPh/4dnhjEQ5CBwCvw5rqA9SXIJzU/i93d1vzlElw2XNVEb
         tAmldP4IEZlo31D5XRKOTbOw7+DLFd0dp97yqGvOfn5U1HUMW+UuCbrEXfzZN/dJt46T
         Cs61juV580LhK5qgwLf22K6rdK9lvo6kyVELBf/TznqqXlxeFw1Wdt/KpLipjtwz017L
         OkM3D9NwbXco34AVfPGFDafEmron6akji3J/hfw4kop9Xu9YPuZW8YFbrpaQLyfjOidk
         GCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756363359; x=1756968159;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOQ99xgVI8ZBcLOUqTlIwSjxWz4nfhGrBQ3qwqf0K9I=;
        b=xFkxr5WQ4upMpVTdeYmcNZvCf9iwhnp+3HlZhPY64fhoBWH4NT1XqZR5m+viBqfWH/
         RZECRLXUR/a9fd2UmHEdAUJLEwacCOghd7LZwySPXVHewE9P3vyNFszhoEoWDHN6pUTN
         sxrcteugmNZZHDRcH7px/n7ZkJnRi8HOzRw0zU5KB0mkyu5w7bV/GVFX01w9CNQNpkYO
         9KIzog68q4iUeykYR+yBBlLH8mRcoT7nfqswDwUY9qYmuzpZeBqBh0cUrSG7lOMrPC9B
         Oun3x5r/ipQQ3fLVxgl2yePD/BzmWAiujuBcSvaHNZv9nbj+EMt05u4gyYLZFV+wrmtD
         wYGw==
X-Forwarded-Encrypted: i=1; AJvYcCUEkrcpP6AGm4NN/xqy6eWo+I1mSwjTuqQ3s4YjES+7Ut2UyEvuCusG4zqRaeB9GwmaJsnTIaWVU6R5KmQbNi84@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg+rZyW3YnGAwNlAgCjHUrN/XmGXIFzeCvwRG1aOYlZf7ZjL/A
	/ON4fY2H/fpcL6MUuz3iqEFbubEjSG4alDKcNB0bLhJIwawM2Ed30gX8ZA5UX+lq4w2V2U5WFKm
	0ZKEMRNeKjg==
X-Google-Smtp-Source: AGHT+IGbBEug43zFNvjsodrfYJVDDIxl6gROoWfwBMr6Qy08bff8Arx+xocGS/IfJ2+n+/ITDd99O7u4Sm6O
X-Received: from plru7.prod.google.com ([2002:a17:902:b287:b0:240:11bf:3c68])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf06:b0:246:7a43:3f84
 with SMTP id d9443c01a7336-2467a437c46mr253423915ad.5.1756363358953; Wed, 27
 Aug 2025 23:42:38 -0700 (PDT)
Date: Wed, 27 Aug 2025 23:42:20 -0700
In-Reply-To: <20250828064231.1762997-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828064231.1762997-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828064231.1762997-3-irogers@google.com>
Subject: [PATCH v1 02/13] perf perf_api_probe: Avoid scanning all PMUs, try
 software PMU first
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

Scan the software PMU first rather than last as it is the least likely
to fail the probe. Specifying the software PMU by name was enabled by
commit 9957d8c801fe ("perf jevents: Add common software event
json"). For hardware events, add core PMU names when getting events to
probe so that not all PMUs are scanned. For example, when legacy
events support wildcards and for the event "cycles:u" on x86, we want
to only scan the "cpu" PMU and not all uncore PMUs for the event too.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/perf_api_probe.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
index 1de3b69cdf4a..6ecf38314f01 100644
--- a/tools/perf/util/perf_api_probe.c
+++ b/tools/perf/util/perf_api_probe.c
@@ -59,10 +59,10 @@ static int perf_do_probe_api(setup_probe_fn_t fn, struct perf_cpu cpu, const cha
 
 static bool perf_probe_api(setup_probe_fn_t fn)
 {
-	const char *try[] = {"cycles:u", "instructions:u", "cpu-clock:u", NULL};
+	struct perf_pmu *pmu;
 	struct perf_cpu_map *cpus;
 	struct perf_cpu cpu;
-	int ret, i = 0;
+	int ret = 0;
 
 	cpus = perf_cpu_map__new_online_cpus();
 	if (!cpus)
@@ -70,12 +70,23 @@ static bool perf_probe_api(setup_probe_fn_t fn)
 	cpu = perf_cpu_map__cpu(cpus, 0);
 	perf_cpu_map__put(cpus);
 
-	do {
-		ret = perf_do_probe_api(fn, cpu, try[i++]);
-		if (!ret)
-			return true;
-	} while (ret == -EAGAIN && try[i]);
-
+	ret = perf_do_probe_api(fn, cpu, "software/cpu-clock/u");
+	if (!ret)
+		return true;
+
+	pmu = perf_pmus__scan_core(/*pmu=*/NULL);
+	if (pmu) {
+		const char *try[] = {"cycles", "instructions", NULL};
+		char buf[256];
+		int i = 0;
+
+		while (ret == -EAGAIN && try[i]) {
+			snprintf(buf, sizeof(buf), "%s/%s/u", pmu->name, try[i++]);
+			ret = perf_do_probe_api(fn, cpu, buf);
+			if (!ret)
+				return true;
+		}
+	}
 	return false;
 }
 
-- 
2.51.0.268.g9569e192d0-goog

