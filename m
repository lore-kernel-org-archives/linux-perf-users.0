Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF8A1487CD
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600475; cv=none; b=RomoTFIgxjSqTY00K7ZiUMOwHjzaDXRnEZPTPcjimlLl6sqZVjSHrbfrllH1mmozOsQ6rBwxdRDrhLp7JoRRNms0oL6Toyz2Pddnym6M7YvT/JJvfgd4d/TylqOdK+2tr10rmChPQiMOKIv2odmxqZIWzEk46QMw8JoTQiA1jyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600475; c=relaxed/simple;
	bh=bzQ9CRjWdecUHtFTM41DyW8czRtgDd01ddhI7LWZXOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sLHHOoZzLiTmpV+DH+D1/ZYrX9htox0GekGomJyfbUTHXvneVlcLdh33FqlkuUZ2B7o0pR5j4C6UB895/oALklhq6X9dnVF2XHaM1NwVE0927e9mCqsn3xUCSrgwtM08ldvf5zsW8rUO4QFs4lREC8/KPgY8Bf7iKb5o8bSkx9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SZy6P5GT; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SZy6P5GT"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9e8522445dso151408566b.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 08:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731600472; x=1732205272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3cdScFAcgvdlRHopcdKPzeCgYcfuZjBjrzryDpj2HE=;
        b=SZy6P5GT/OqSZe/QYPRkWaTGry9nck/mdkK/ZNEgJHOI/n8imGVOX277m2jXGR2+b5
         mEO3eAs9eCdeQmVEnIianGBo+avAjWOhnnx0DCTnpAUs6MG1+vtFyhbskTjQQcMjsARd
         PcWbNeQA0XwrQLCvhC9K5oshaBqqFEQnbaGvD42vKsRP1cR3+93xVVBoOs6uGR2LvIWY
         JT/W2wA7lnXc6aM4Mi3UkXmZISATa2TK4HrsqbOq2Pr4AIID9e+dt0OyiqLl4EIyFh/J
         PQnS4vUOPwIRVvkbncqxFZATm/r6WLmiKyx5AqJqDW+8QBMCg5sv+IlXGq/+WxHGW8rA
         kl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731600472; x=1732205272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3cdScFAcgvdlRHopcdKPzeCgYcfuZjBjrzryDpj2HE=;
        b=fwnAoZ960IB6u+gSUNNz3spoU/HykRVwwqVg1oa7hO/14pz2S8ZbXmKt60KEGBi7tG
         rhYMoOhqteba9UABeojeSb5h7U7Jg0fq5O7EzN3YytRMkFyMcizOSWo+Yyy/tL59m/1m
         P5YUB5vpQbqz1S0VHiFLIEFxesGz8AhkC0KQmX9bb+nQRGi6La3GDPxVJhJX7Uwm5v6k
         gYn+uahhevgPt3t73ZGWq7skCbdDvUHpEo6uW+3dq6YwNaTbo2Qiwk/LXRIbx9yreMrx
         tf705d/CagWcDxuof99rg60BfLbMxMo4KN4j3xbzigeJGui9ifNhNZpvn0uMShd2viOi
         8OQw==
X-Gm-Message-State: AOJu0YwQbSJz3maAAUh2z/TAucgZXXUxtaU489mNbluF+s3vGpqgfq8f
	bZ8TrgoWMJlkVdlNWK7JfrqZ9bTf5vfRUwRKE8WrmPWTqBXl8mhiUUJcSKtK4S9lV9QwD3ibQx0
	uRp0=
X-Google-Smtp-Source: AGHT+IGHoLs6q08SPM4TqfP2UFLFrJQtplNKocJZiNpyTod0sYUFtC3vT9Nx2DHotVltrf59qYc4fg==
X-Received: by 2002:a17:907:60d2:b0:a99:e1a1:473f with SMTP id a640c23a62f3a-aa20cdefc8bmr294267166b.57.1731600472062;
        Thu, 14 Nov 2024 08:07:52 -0800 (PST)
Received: from pop-os.. ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e046d76sm77456366b.165.2024.11.14.08.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:07:51 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	thomas.falcon@intel.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] libperf: evlist: Fix --cpu argument on hybrid platform
Date: Thu, 14 Nov 2024 16:04:48 +0000
Message-Id: <20241114160450.295844-2-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114160450.295844-1-james.clark@linaro.org>
References: <20241114160450.295844-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the linked fixes: commit, specifying a CPU on hybrid platforms
results in an error because Perf tries to open an extended type event
on "any" CPU which isn't valid. Extended type events can only be opened
on CPUs that match the type.

Before (working):

  $ perf record --cpu 1 -- true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 2.385 MB perf.data (7 samples) ]

After (not working):

  $ perf record -C 1 -- true
  WARNING: A requested CPU in '1' is not supported by PMU 'cpu_atom' (CPUs 16-27) for event 'cycles:P'
  Error:
  The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cpu_atom/cycles:P/).
  /bin/dmesg | grep -i perf may provide additional information.

(Ignore the warning message, that's expected and not particularly
relevant to this issue).

This is because perf_cpu_map__intersect() of the user specified CPU (1)
and one of the PMU's CPUs (16-27) correctly results in an empty (NULL)
CPU map. However for the purposes of opening an event, libperf converts
empty CPU maps into an any CPU (-1) which the kernel rejects.

Fix it by deleting evsels with empty CPU maps in the specific case where
user requested CPU maps are evaluated.

Fixes: 251aa040244a ("perf parse-events: Wildcard most "numeric" events")
Reviewed-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/lib/perf/evlist.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index c6d67fc9e57e..83c43dc13313 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -47,6 +47,20 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 		 */
 		perf_cpu_map__put(evsel->cpus);
 		evsel->cpus = perf_cpu_map__intersect(evlist->user_requested_cpus, evsel->own_cpus);
+
+		/*
+		 * Empty cpu lists would eventually get opened as "any" so remove
+		 * genuinely empty ones before they're opened in the wrong place.
+		 */
+		if (perf_cpu_map__is_empty(evsel->cpus)) {
+			struct perf_evsel *next = perf_evlist__next(evlist, evsel);
+
+			perf_evlist__remove(evlist, evsel);
+			/* Keep idx contiguous */
+			if (next)
+				list_for_each_entry_from(next, &evlist->entries, node)
+					next->idx--;
+		}
 	} else if (!evsel->own_cpus || evlist->has_user_cpus ||
 		(!evsel->requires_cpu && perf_cpu_map__has_any_cpu(evlist->user_requested_cpus))) {
 		/*
@@ -80,11 +94,11 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 
 static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct perf_evsel *evsel, *n;
 
 	evlist->needs_map_propagation = true;
 
-	perf_evlist__for_each_evsel(evlist, evsel)
+	list_for_each_entry_safe(evsel, n, &evlist->entries, node)
 		__perf_evlist__propagate_maps(evlist, evsel);
 }
 
-- 
2.34.1

