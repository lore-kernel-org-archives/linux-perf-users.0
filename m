Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCED254858
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 21:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752786182; cv=none; b=R2r+gBvvhmWta5gx5vvmqDabjKh5YnV5DECW7bJIdM1JODxTm1k8gfm9aBbxwaTzjsfQVmmNYy9wq0VK0bOG9hEgA3pFGhiL64f8e7jYDjjWTHBS6MmjMuIYrxsJrDGSinFe9pz7z5XpWvBBExAXTpCQGSY0Bvj8NpIq4IwK4Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752786182; c=relaxed/simple;
	bh=7V57mrxclma+L6i7A+s/RUZqSr9To26yFbxOIRG9Ic8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SZvsUnJwIOXl3ASjhG7iQKFneMIZMsOJ4a5tEmvQdi1qGejM+ecx+4U/OfKmA1EuYJRCuDmL9FKIr8rJI4JPSgvvxrjfTzfqs+KZ8/OzoBsBpH0A15mR7I9qII+BN3MyClQ7DtLCDka97zu14KjXp2U/TM/CmKu6npjUlmehxjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=stxozxnO; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="stxozxnO"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-300884cb43bso431495fac.2
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 14:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752786179; x=1753390979; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lxK32ZV3/TwHJ48GSqnT12vEqhtnY89NH3NlvQCfpOQ=;
        b=stxozxnOpPXY3REDH7IRmXb8E6OC389QWhcniKGNZoOak1f21aOv8gOnib6xXpkhQn
         i4u/BMIwtwJfXiNpo1ghtOWwIBzCIGLjk8BMs60i1Dhb/uC85AFREuyZIhrHTJBmM3I6
         paueMsMaB/tUANxC3O1+EGoV2J0li8eyrNzIUpbuPwsv9vxgDQcXL/P+5dXudoW+EPAZ
         2tIJcpk8X+2yAS5Y32YWSKRHg423BJXIILe1wJ/MeVxdcDVh7QZfPcCo/Mjs40jO6ehk
         gkdo7ZrTdVIgCiWQfo0PrCRFyvhe4og2EvnCDtKc16xjVPC4eX9NHudem8PO/DI8Yimn
         TOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752786179; x=1753390979;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lxK32ZV3/TwHJ48GSqnT12vEqhtnY89NH3NlvQCfpOQ=;
        b=qg25esP6sRJ9oPbSS6yxN6jaPsQ67obg4F1Ipt4Zz5BTTw+X6+F0PaBN6O5u7uixeQ
         6pHvRzO/FpEEHkJyU7maLgn5fPGrOabaoWXXfD1IWsa2idMesp7dt12ab4Ham7ikgMc+
         yROzVZxmutyPcRkc2IAC4SK3ROlGzYQyyZiHIpGPVOmPTCD8E54P7ejNHMyX2TGe3/Nm
         sGFTC0nvGt9A1bay128Nipy+IzUXFtyoH3fVd7mm2IUR7boxEy2hKYKRK43tSOknhYPS
         5lZQvDVRf+UEFnL0ctrOw68tkGWQll9U/TDxK1eO+BfwT/UBi/ehPh/2lw6fEKYY1jF3
         ihSg==
X-Forwarded-Encrypted: i=1; AJvYcCVhiLt92selL0eHsB4pF5TRUDat3BAqbU4/3XR5HrU1cMb1eAkypaUwK/DUR2i6lkKmF5CmgU0lsmsFvBLNk3wi@vger.kernel.org
X-Gm-Message-State: AOJu0YzQIeTexi6c35P2TDrVoqp/I6V3aI/3afIPMcGxqX7+vVxvUdGc
	b6BcQ61KS8J2IJ4q9ttjnk18g3w3z75RtuXFvJx7YRjT7MA8RrykS0Qf+ZLT8F0teKlJFRu5a5R
	25w/nS07COQ==
X-Google-Smtp-Source: AGHT+IHcIFzwFnn+SjPmcIqyplDWuJDsGtXSmp5dZf0+tUKV7Fw7+u0UQJPZHt4hNF01UTe3QJIM+mWzCi3d
X-Received: from oacdz3.prod.google.com ([2002:a05:6871:ac03:b0:2bc:69a2:7ea5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:687c:2f22:b0:2ff:8e7d:1d9f
 with SMTP id 586e51a60fabf-2ffb2285801mr7054112fac.13.1752786179445; Thu, 17
 Jul 2025 14:02:59 -0700 (PDT)
Date: Thu, 17 Jul 2025 14:02:32 -0700
In-Reply-To: <20250717210233.1143622-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717210233.1143622-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717210233.1143622-12-irogers@google.com>
Subject: [PATCH v2 11/12] perf evsel: Add evsel__open_per_cpu_and_thread
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

Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 23 +++++++++++++++++++----
 tools/perf/util/evsel.h |  3 +++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index af2b26c6456a..ae11df1e7902 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2761,17 +2761,32 @@ void evsel__close(struct evsel *evsel)
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
index cefa8e64c0d5..8e79eb6d41b3 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -351,6 +351,9 @@ int evsel__enable(struct evsel *evsel);
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

