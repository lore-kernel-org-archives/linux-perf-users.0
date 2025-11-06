Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA112E8E0E
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 07:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413182; cv=none; b=XHwaRtjNe/jzCaSM0LZEVos0Ad2yfRe5JHAA7ez0GXhkRl2vLKqjZJDgJilNiGZYXw8JAwLIPU1e//hfFQ6jtxDCLVsP9v7LRGguEjit0sbnb37UfOndHwNkCOuDMkxm0JraFdfpEAMBlqPiS7ERhmUky7LTaS7gWiuQaDFdu44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413182; c=relaxed/simple;
	bh=iP5yCD4lNJBZ54VXCnLo6TAsw5GH2qBuAbNIhmsoFCI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=HJ3gslKMLh4xjR5R4/VL/r2M1Q4liBICtmw+uo7WBnlzDzyikJESL035RrJ4dlXJdIcVnMUaZNrc6bXd8PP8JRVwQ6/DoXv2+eR5PnxXUAQKa5KY1cj7PG3fu6YHz1mS5Dv/QZ0Rc2z0QZ1LedtcNQCmC5arFmLJzmH9QK0kEOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0nQDTx10; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0nQDTx10"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b471737e673so130408a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Nov 2025 23:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762413180; x=1763017980; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s3mUC9sPFouhj1rBALiYO4Qb6Uq1xN1oWTquV7EiCFw=;
        b=0nQDTx103mQetrXofg38pcjMLu542t1FIGiGdwXf/ssWhgwIoEoieHlAA296Z18Yho
         ri8fSQpu6h3I8hCcQkorsnUj8kDuw/IAXsXqmXqB+LwHQToBQkN2NXvfNlgRaUJc9DkM
         xlGj3qINbxGIOVRUzYemXGtVFHh62OVJrBf0gBWe/SsgMaHnHMGsD+dPq0YsKfeq+ZL7
         sDmR5WJqiC+j44Og47LxJgWrVBcTnVvBi4yN/YFJiBm1D6IWBmW/SzWFxCjhD0cWc9L9
         xK995CYIBj18uweCyMOVUiCZykqRUN25kC3jHv01IycVzeXm9/vbCiZXotly1okHY63w
         ATKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762413180; x=1763017980;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s3mUC9sPFouhj1rBALiYO4Qb6Uq1xN1oWTquV7EiCFw=;
        b=IlSkieooNt98OY/+v8MS5VJ0K6NBYVbXP0B6oxzfE8Fp/QSAw0OtGIpBl4Ve8plUX9
         RSaYEJsc7lpfK+2MK1ucPjs8l9aNoBo46XQK5xR2AoYTNV+RAvLVUNrF+dnunGG8VaJT
         6L0I48eUxdUzCNdZXnjhabKl0kgECMjgTGwLh+edAliRZjQ18/GuoOjP6kLZGbMwalFn
         7ELFpkJYAXvHFuQNqGi2gM6pAMd/babt03AnPgYp68VECa2FVKp7zz/b1qkdU7ooJhvm
         6jWvt7hh/wqUEz0tv0b7YVEg93pX//hRkfugBPEsuWTJsXX2tuKjJcam5aVJswqJ/scy
         gk1w==
X-Forwarded-Encrypted: i=1; AJvYcCWMHbwxpcIahmgLJicr7CoTQBwVeJkjhFNuYjithZqI5KRrsSfIR2vbA5nSrnkAWC7q2INhi31Bmi10dLDQPAhV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9qkQobR1oxyvFObhkoYygdDwHv2GdVzQT+7SPQzGcX4JFuTOq
	Wa2rHnbJ1X7UUfEwLa90JJ74oe/uAVUbYK2q8MSDCbCs4g3gF4bagXV+UPpt1QuBHC4+uk0gKMX
	EkZyaC8BnvA==
X-Google-Smtp-Source: AGHT+IG4sIhbJsW2cMjujNFWdXTnrQvTWPxQtMzU7mQ4Vd/UmEodRv7ANnAPYqSxmGy75vD+p+QmxdkA76f1
X-Received: from dlbdt2.prod.google.com ([2002:a05:7022:2582:b0:119:49ca:6b8d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4306:b0:346:331:97e4
 with SMTP id adf61e73a8af0-34f87301a42mr8511687637.56.1762413180476; Wed, 05
 Nov 2025 23:13:00 -0800 (PST)
Date: Wed,  5 Nov 2025 23:12:39 -0800
In-Reply-To: <20251106071241.141234-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106071241.141234-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106071241.141234-9-irogers@google.com>
Subject: [PATCH v3 8/9] perf stat: Read tool events last
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

When reading a metric like memory bandwidth on multiple sockets, the
additional sockets will be on CPUS > 0. Because of the affinity
reading, the counters are read on CPU 0 along with the time, then the
later sockets are read. This can lead to the later sockets having a
bandwidth larger than is possible for the period of time. To avoid
this moving the reading of tool events to occur after all other events
are read.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 29 ++++++++++++++++++++++++++++-
 tools/perf/util/evlist.c  |  4 ----
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 5f31cd5bb03b..75ff08c5f0ed 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -373,6 +373,9 @@ static int read_counters_with_affinity(void)
 		if (evsel__is_bpf(counter))
 			continue;
 
+		if (evsel__is_tool(counter))
+			continue;
+
 		if (!counter->err)
 			counter->err = read_counter_cpu(counter, evlist_cpu_itr.cpu_map_idx);
 	}
@@ -396,6 +399,24 @@ static int read_bpf_map_counters(void)
 	return 0;
 }
 
+static int read_tool_counters(void)
+{
+	struct evsel *counter;
+
+	evlist__for_each_entry(evsel_list, counter) {
+		int idx;
+
+		if (!evsel__is_tool(counter))
+			continue;
+
+		perf_cpu_map__for_each_idx(idx, counter->core.cpus) {
+			if (!counter->err)
+				counter->err = read_counter_cpu(counter, idx);
+		}
+	}
+	return 0;
+}
+
 static int read_counters(void)
 {
 	int ret;
@@ -409,7 +430,13 @@ static int read_counters(void)
 		return ret;
 
 	// Read non-BPF and non-tool counters next.
-	return read_counters_with_affinity();
+	ret = read_counters_with_affinity();
+	if (ret)
+		return ret;
+
+	// Read the tool counters last. This way the duration_time counter
+	// should always be greater than any other counter's enabled time.
+	return read_tool_counters();
 }
 
 static void process_counters(void)
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index b6df81b8a236..fc3dae7cdfca 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -368,10 +368,6 @@ static bool evlist__use_affinity(struct evlist *evlist)
 	struct perf_cpu_map *used_cpus = NULL;
 	bool ret = false;
 
-	/*
-	 * With perf record core.user_requested_cpus is usually NULL.
-	 * Use the old method to handle this for now.
-	 */
 	if (!evlist->core.user_requested_cpus ||
 	    cpu_map__is_dummy(evlist->core.user_requested_cpus))
 		return false;
-- 
2.51.2.1041.gc1ab5b90ca-goog

