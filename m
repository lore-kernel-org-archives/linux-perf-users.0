Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB862EE5E6
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052285; cv=none; b=SFKmS4jws8ZB5s9JQwFgNlewtCunlEp0R7e4O1zNQHCiUsmlAEJxr3fn9l85TkBGyN5JII7bLwfx0IZW47ZmiX2v16ej8KDD2rZiDX7tsaGC0GlXtLvXGRMu/9Uc7m5cUYzW6dpfFS2/Fg/zuEV+vzwR5s8cDVWGGdlPjAh4NXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052285; c=relaxed/simple;
	bh=TmgYCTTGSJdKq7z8EdzJjt+Yp8LyqX4VI4Ic6NdyBsM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bN9jOWphJ24dvMG/FOJEevTZRJEaQY4MxcvYjOrY9zRltQy7fvDlUpeFXs6TpVtm9ZO9Vbx4C5RRoZaqddjgdRZqgCZ9UfBJz2IBiz4RQHo0ucevaT6/mDkOypV6gatxU4tZ8i0jFGhSr9x5dCRd40viThMCvE9Z5oO2i2rQVoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GDgbipIk; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GDgbipIk"
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-4066a4d2d31so767750b6e.2
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 12:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751052283; x=1751657083; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EFyT+8RU83ZXK59fsAUqw8r9gWLHShlARLFnNU9b/6g=;
        b=GDgbipIkPGQBmCJKE74L9wx/h1wvgkd/33kCLUjpcQFYxTJ/XL/irBKcY1JNF8cZ4X
         TL7vfoIGi1r/ZZVDlL0ksQpXMT+aBmZCuJ1Doz5FQ5I8s2QVEVmcl8lMNV+dTX6seELk
         LK9fagpAJPEqRH9srtUk0odlZpFMfgiD7wp6N8sv7Yt900lSHtTsiiMO0pgpbksV5Mrz
         MIzG9edAe21CzwFyBgdzEg2PnUb8EhESPubTQOjMUq0IZu8H3NVPrLkEkZU4fQZqCpJt
         pSKCVEhJTvj6ts2xvT+2c1QAunusUvBZfvpV246HrJiIOAL9cHybMqpfC2NRzMtZppFP
         XSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751052283; x=1751657083;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EFyT+8RU83ZXK59fsAUqw8r9gWLHShlARLFnNU9b/6g=;
        b=n3FVQsyYDikpRXWNb52DCguY/C0DWdQ7XgyZ/49zQ02TmqllTmrRlZIoSn88Gb5laJ
         H+rVu1K3ablzC6jPMUINAh9HLoWUJNEhPf0ixzAa3EpEr2YRiPMrmEsdplCFaddcsRph
         R+xMlJsada550geQj0AxaHKP5dOOgqlOWGjnKBCq0cFjzKeaB1HW1E/J+sxqn+fC/I/h
         7uTwPk6dwEmPAlSQnpw3sTWDl0zBCIbHwhoHJ3MgXm6sQmltyU5BZtEstLDrMnm16OX9
         U218106Pa1P6v5wOBpciA2R/vvBplOSMY/Vajluhw9eGB9xn1XuI+9ZIvJX1V2u78dNG
         iixw==
X-Forwarded-Encrypted: i=1; AJvYcCWlJ1IZ9L0qtaUOzrWOQMO/WAHRbcwJgj8IGpTtgbmlPAmmg15A7aoBUZCXneO+XCCxXablx1bdv6FnIhUDpCSG@vger.kernel.org
X-Gm-Message-State: AOJu0YxVkKgMbQf3Wi06in+075dq/5GbKtPwFJlcDBB2rbrf1KoUoE2+
	KbfCK0hywaEC3Dslm+KiWoLx38wVJn+h2b6LSeOWmKhzfe1NxUZprbEtA1PxtOsc14QlvSh0dsJ
	rcRkcjoknOw==
X-Google-Smtp-Source: AGHT+IHPcRI4IStwL19Uepy2ZttTWHngKeBVZRUyOc+r75wj7tI5L0IQ5QjZmvYiblT/p1WFOLuKCX16y6tM
X-Received: from oabps10.prod.google.com ([2002:a05:6870:9e0a:b0:2c1:fc56:4d62])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:8312:b0:2d4:e96a:580d
 with SMTP id 586e51a60fabf-2efed4d9bd6mr2974016fac.16.1751052282906; Fri, 27
 Jun 2025 12:24:42 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:24:16 -0700
In-Reply-To: <20250627192417.1157736-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627192417.1157736-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627192417.1157736-12-irogers@google.com>
Subject: [PATCH v1 11/12] perf evsel: Add evsel__open_per_cpu_and_thread
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

Add evsel__open_per_cpu_and_thread that combines the operation of
evsel__open_per_cpu and evsel__open_per_thread so that an event
without the "any" cpumask can be opened with its cpumask and with
threads it specifies. Change the implementation of evsel__open_per_cpu
and evsel__open_per_thread to use evsel__open_per_cpu_and_thread to
make the implementation of those functions clearer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 23 +++++++++++++++++++----
 tools/perf/util/evsel.h |  3 +++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1169aa60c5fc..9abc62635e76 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2741,17 +2741,32 @@ void evsel__close(struct evsel *evsel)
 	perf_evsel__free_id(&evsel->core);
 }
 
-int evsel__open_per_cpu(struct evsel *evsel, struct perf_cpu_map *cpus, int cpu_map_idx)
+int evsel__open_per_cpu_and_thread(struct evsel *evsel,
+				   struct perf_cpu_map *cpus, int cpu_map_idx,
+				   struct perf_thread_map *threads)
 {
 	if (cpu_map_idx == -1)
-		return evsel__open_cpu(evsel, cpus, NULL, 0, perf_cpu_map__nr(cpus));
+		return evsel__open_cpu(evsel, cpus, threads, 0, perf_cpu_map__nr(cpus));
 
-	return evsel__open_cpu(evsel, cpus, NULL, cpu_map_idx, cpu_map_idx + 1);
+	return evsel__open_cpu(evsel, cpus, threads, cpu_map_idx, cpu_map_idx + 1);
+}
+
+int evsel__open_per_cpu(struct evsel *evsel, struct perf_cpu_map *cpus, int cpu_map_idx)
+{
+	struct perf_thread_map *threads = thread_map__new_by_tid(-1);
+	int ret = evsel__open_per_cpu_and_thread(evsel, cpus, cpu_map_idx, threads);
+
+	perf_thread_map__put(threads);
+	return ret;
 }
 
 int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map *threads)
 {
-	return evsel__open(evsel, NULL, threads);
+	struct perf_cpu_map *cpus = perf_cpu_map__new_any_cpu();
+	int ret = evsel__open_per_cpu_and_thread(evsel, cpus, -1, threads);
+
+	perf_cpu_map__put(cpus);
+	return ret;
 }
 
 static int perf_evsel__parse_id_sample(const struct evsel *evsel,
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 8b5962a1e814..4099812d9548 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -349,6 +349,9 @@ int evsel__enable(struct evsel *evsel);
 int evsel__disable(struct evsel *evsel);
 int evsel__disable_cpu(struct evsel *evsel, int cpu_map_idx);
 
+int evsel__open_per_cpu_and_thread(struct evsel *evsel,
+				   struct perf_cpu_map *cpus, int cpu_map_idx,
+				   struct perf_thread_map *threads);
 int evsel__open_per_cpu(struct evsel *evsel, struct perf_cpu_map *cpus, int cpu_map_idx);
 int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map *threads);
 int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
-- 
2.50.0.727.gbf7dc18ff4-goog

