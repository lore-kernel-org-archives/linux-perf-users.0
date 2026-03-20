Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67262376BD0
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994171; cv=none; b=gYy9rYSxkLNFgIQyiPzZCHQzLuSW2hNh1jZ7a4tudAS2KUEG3foHP19WOcwnQh0YYjZfTT5Pzcx5gjOvMEdPwAPLKsSHWjPaDUqadRW+ABYDSiE+ODR5ewCEpj5THJrDI56XHuAH0acS/Z/fh1HYNo+7eLqsReHCPmSmuv6wKM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994171; c=relaxed/simple;
	bh=enfQpKJ57br2NS8902Ah/75U3dehIUkUW92GxgKcs0o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IMUNIUtXLa9sURbnmnU/xUyhd+luWctv1lk+0DprG71er6b47S6/N8PM7Qk9rysFmXKvtg70KG/hKFKsdD00guzP5xYxXWcJFCXvKJOfvA5t6p59P8r5WB0X0vUBuZL3Tuo6kUw54xR/ZmwFTL93yMilU58Sqkd3zde3mfM5BYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JUE2t6Rf; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JUE2t6Rf"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bda35eab74so1143172eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 01:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773994170; x=1774598970; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nv8zDk9PsqnI3UUSMBiLUu2GuZqxldUeI9UJusM+0CY=;
        b=JUE2t6RfpYD6dBw3AOhRTcr7Aq9jC5LygahQLWVD+MhJ/7rT4rO10RPldkvG5tlzAC
         ZS6Q9fpOwohwV1E5d4meV/r3riJ+7lgOuHqDHelqajM3BTTzfAOPYNaH6tdQVz9lmMvi
         CB9GrKO6nluYeZatm72YwSKzBXmj6lVE9cXo0J0gfoJjVzpZiFvDze9yDG2e1xiiBMw+
         gagzNsZipOyk45WCqHD/bX/olaVomsu4ZfiaXMsCR6JuWBtJensWizYV/WcIcT50HKKh
         wXwM6l76bLN13jlyEnpa6fOFCuPHnE+roFxspK2UejTPXVvr9I4oX6UDAKheojAhZ03H
         iAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773994170; x=1774598970;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nv8zDk9PsqnI3UUSMBiLUu2GuZqxldUeI9UJusM+0CY=;
        b=odMONjXKXtjiPhk0UkztiPE9o+ZGjfOn3aSoznDGteZVk9NK0oAs3ytcw+PoagRBTg
         G3wEcZi1jpl6yBU+rXX94ssL8IoE3P5xdSwdFF3SX8HpyzgtZOG5ScIKyBPSlg6cnbyq
         g4GKWEYn7HNLZ8lDJeVzsl+el2gsm4zRGJ5WLQEYtL4Se0cdXeViJTE+UE4AAxsqmtHa
         cUcjUfyCgqtSbZeiYueNWiS7h2GyVUbnd4sJtz0gGRBHgZEEZAwc6MiAzRnFdBvxV4R3
         uaAk52TTtu+jJse0T771dyO5WhTt2gFo9VxpiMXPBlw+JQty8Zg7iB05gzVMsZTdwNkk
         FggA==
X-Forwarded-Encrypted: i=1; AJvYcCUFqqrDd0LNcMsIyAwUZhWBbEphLmriddRncNxAeQg2V/LQGNR3zd+0b0YPvlkCzlGGUAZtGXOl8o/D/nCH3X0+@vger.kernel.org
X-Gm-Message-State: AOJu0YwMzq4XINuCvcnRwsoL1H2Yz312b8BvOUZUNmhbFroU1ZLdjFkL
	sIb8//+mHxwrI9oosJ5IwK8H/NATlmPJpT2B5HBuOmclKAS9oeLwQt9owRMv72OaeuYCq9HJSMz
	lJYPgauQF0A==
X-Received: from dycns22.prod.google.com ([2002:a05:7300:f796:b0:2be:6911:c4f2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:571e:b0:2ba:a1a6:c73
 with SMTP id 5a478bee46e88-2c10974ccb6mr867146eec.6.1773994169326; Fri, 20
 Mar 2026 01:09:29 -0700 (PDT)
Date: Fri, 20 Mar 2026 01:08:31 -0700
In-Reply-To: <20260320080835.724836-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319232334.287517-1-irogers@google.com> <20260320080835.724836-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320080835.724836-23-irogers@google.com>
Subject: [PATCH v3 22/25] perf evlist: Try to avoid computing evsel from sample
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

If the sample has an evsel, don't recompute using the sample.id.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c           | 4 +++-
 tools/perf/tests/mmap-basic.c      | 4 +++-
 tools/perf/tests/switch-tracking.c | 5 ++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index b89ca48e5d02..faa422e35166 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1163,7 +1163,9 @@ static int deliver_event(struct ordered_events *qe,
 		goto next_event;
 	}
 
-	evsel = evlist__id2evsel(session->evlist, sample.id);
+	evsel = sample.evsel;
+	if (!evsel)
+		evsel = evlist__id2evsel(session->evlist, sample.id);
 	assert(evsel != NULL);
 
 	if (event->header.type == PERF_RECORD_SAMPLE) {
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 3313c236104e..a18d84d858aa 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -142,7 +142,9 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 		}
 
 		err = -1;
-		evsel = evlist__id2evsel(evlist, sample.id);
+		evsel = sample.evsel;
+		if (!evsel)
+			evsel = evlist__id2evsel(evlist, sample.id);
 		perf_sample__exit(&sample);
 		if (evsel == NULL) {
 			pr_debug("event with id %" PRIu64
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index a7ea4b7874be..ed17c3be71c4 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -138,7 +138,10 @@ static int process_sample_event(struct evlist *evlist,
 		goto out;
 	}
 
-	evsel = evlist__id2evsel(evlist, sample.id);
+	evsel = sample.evsel;
+	if (!evsel)
+		evsel = evlist__id2evsel(evlist, sample.id);
+
 	if (evsel == switch_tracking->switch_evsel) {
 		next_tid = perf_sample__intval(&sample, "next_pid");
 		prev_tid = perf_sample__intval(&sample, "prev_pid");
-- 
2.53.0.959.g497ff81fa9-goog

