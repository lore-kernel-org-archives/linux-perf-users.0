Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83A630FC2D
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666806; cv=none; b=mNQ0Y0iTrEaFif63ziHLLH6gvAZkrO7vWLYsx+/JRcEHnYwcwuGKRaew2q1+q8pv35KcOvoxxuHMxKSEWo2aplbZtbb9dRE7QgnIiBYDzcvI1Qanvglli2UVzO4NXG/3tO4giJ+NfxarEvUWczbgQNJ6GHxaq0Z1Fm4fYvr8hNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666806; c=relaxed/simple;
	bh=Gnr8aN6GsTXLF4rZkpbbCQxr1ke1Ni185cKQORktmN0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XNFPW0SVtUO8qbB6efQl8T7esL5oD846qwGQVIqHL/mDZ5ECVu9GiA/mvX5SjF9fJ4CISPMwRBHd6LYS3WStWV5nDfO2dYiKXQ+/9doxjk1boVcZXcRvauKt05J0K+1S1Ox+zTmd2kCZVBALKmVQ8WnzqFkoXJlF09knAbSqpRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U5tiCIq3; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U5tiCIq3"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b55443b4110so245226a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 15:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758666804; x=1759271604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QH93BLUOeILn9fmSsLk5rxs6+k76FrXoN/c2VrpOq9k=;
        b=U5tiCIq3Fy0FLu9WBE8mNrXo+GXfQKhbMPeXuHzoFrRzfp6S4ZxXsKHwEpqx/+VRjl
         akX5/jKaGaeiBeO7RHftd1+5+rPovx/aOsyCt6fy8r7t70ngNyXSEcfN24cH2avkzwPV
         qVeDvX6CRmk9jWtGRMoXP5X7eVo1EeSpnlGUayZwLfCIqKX3nRmtPR0sS9ol/2rL8A7w
         87mJN2rFVEFZ3azriQ0bY9Pmhp1RELsjQHs1GPLBsBjTQD3Jwvdxmx+Fk11beSds5B4B
         3A/WXS89CztIgUiOjO4ws6O+i1ZiZG64UvD9tKaQNibvu2CGa4Wq9X1oZ/QSlHNk9vbt
         THDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666804; x=1759271604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QH93BLUOeILn9fmSsLk5rxs6+k76FrXoN/c2VrpOq9k=;
        b=mcQUGStlZf60G5OlYUAC8r9qAvoh1NyYKKAj50I5ZMJ/SbDhsAW31dyApg9zP9/74D
         gl7qkt9I+6LClNxWTV/fmCaEqbWCM9sbYkw99/rpXdEmTsc8Y1wqivd9Di7E826WmfqM
         IB5Zb5gl4ZU1PW2pfnBNo68YG6GaCK9/74CCVJxwFoqPTAVOFpkZIzJc9bkGlIi5OEQA
         fjXOr8jYzsekSJaGWuA/Gl2rn1m0RgOksbRtqordy0a2Jh7Ja/dSihnzQpu4jCY/vwMi
         pxDVgpY6Ls56f8xJNCfJDQU3kEm3ifQfOzEraYBhi7/jzo4zfCFyhNgCyiyY3BzNVtFA
         K79Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0aL8P9P1HJ5Hi+fG+E246KJqb5HbprK5AXpLA57jrDItNwkxcyhmeeMh2acElTqFjBLIApuU+Hcpl6p5v6SvO@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Jh3Ssa2MQis5gGn0CSPEFB1x65rU3Xp19SiJ3VqO2IjmHJUb
	YU5NOEMh0WEHLxC4OHt85ct9ElRKjDr6ON+Vg5RyOa6N1IYP5aUT8mjgOzI8i0PYmB3DStZnTct
	wXPEkRHtjIg==
X-Google-Smtp-Source: AGHT+IF1MCxlWKERyZdxGl1kXmjzrGzbmjsyM4UFRRJeNgmEGRYpGAtktABJHq34owH1+HALXJP08OQlpE4c
X-Received: from pfbbu4.prod.google.com ([2002:a05:6a00:4104:b0:776:1c5b:ebc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a125:b0:246:3a6:3e47
 with SMTP id adf61e73a8af0-2de8ba484edmr318142637.12.1758666804167; Tue, 23
 Sep 2025 15:33:24 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:32:47 -0700
In-Reply-To: <20250923223312.238185-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923223312.238185-4-irogers@google.com>
Subject: [PATCH v6 03/28] perf perf_api_probe: Avoid scanning all PMUs, try
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
	linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Scan the software PMU first rather than last as it is the least likely
to fail the probe. Specifying the software PMU by name was enabled by
commit 9957d8c801fe ("perf jevents: Add common software event
json"). For hardware events, add core PMU names when getting events to
probe so that not all PMUs are scanned. For example, when legacy
events support wildcards and for the event "cycles:u" on x86, we want
to only scan the "cpu" PMU and not all uncore PMUs for the event too.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
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
2.51.0.534.gc79095c0ca-goog

