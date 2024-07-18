Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56718BA46
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 00:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721262647; cv=none; b=bcB/p3HlOBIwAFpn6xk9VFNa/d2frEh/XR7W3u6FN7nigxZmtMgMDe5mt1qzsYH18mid2kN1x/ryD+32yy+tCm51KYa301WsMFRfN7tPCSefVz+I8Jk3iMO4sKkW7DxJxBOmdpQ2Iff2CNWzwFY3FkHvlbtbZlKza83nU+lfBEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721262647; c=relaxed/simple;
	bh=vuwys3K/PQPhgggx+tj8r4FNVlkm6yntFgCi4rPb+vk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=X8nZYiaH4Xxi87tx/69JtK+4zM2I4FUhpZVIz4k+PFJi7Ea3xf/nwK51ZSK6q6aDzBJaz206CRnYYQXdA1ZdGSdziKztnChF9w9SDP7VRydOh3p2F+a1Y2VgefnosqH0uLBfh4TrRZL5FzrhmKYrItzHNYTfLlXQeVgaWooFMWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SmQ6Q7kF; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SmQ6Q7kF"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-66619cb2d3eso6222567b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 17:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721262645; x=1721867445; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N65oyWVRY7b5fCUl5B9UBHpg82AXZoHzAgm4Amx1vhc=;
        b=SmQ6Q7kFybY3+Z1WUdWKVEgmtxoRg6dYVXerQD9MiIDKy5yycR9xaB6LYdR2XYKbZZ
         YQqz0qn1Bbja7YGEAIAKPMp2ZauPMQjL5OrS/BBn+RbOBi/5H1IzRq0BsIFzdnvRtAze
         2pWAsWbDxitOLKl5nsA482gNPtZGuM9QPgluslKOxtXZ74wIjgFG7MFpR1NORP60g+jV
         MdraloXqz8GhqP9EFov6RBTjRBqS+xHLyHQHs3y1plDbyktcIE1NLLrkLYAXahxkM2hI
         io/DTAr6aerNPqK6CRqQ3dmGylDllKSRVeGjWwYCvaXGucEyfd5OaTzsU2n9Dw6ICTVO
         m4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721262645; x=1721867445;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N65oyWVRY7b5fCUl5B9UBHpg82AXZoHzAgm4Amx1vhc=;
        b=ZmkkfjwnlYlSWJVh1EzVpvKI+MzK9bFGa5VURFroSFZzr6BlJzNMpmcGG5cAy/Wb4y
         4wxpmHWdFBuKFUj35HeyNh7AcCVCg6UbNtANk01C8zclhX9RbGIaLyOZB0CkABLTIL7L
         pWb4AxZ6RnjyQj8qidUQyCbb+rQ5rgiDtJjXVAgtNlFMJr7JNMQlU7TxHIpjsQ7DsALP
         pfGsILEaGpRomSjVemyhh+B6/L5N4uZM/o1/Q0Y9AkjNthwmtfKMYG/tQiLPI/fW8b4L
         4nV5EOxA5t7TtjaI1INvI+18T19MCTqu8qMGk0SiT+89AiHEuKx32qnNVUzr/14eTDwI
         CnQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXo+dnkdPTe6MxS8/wFGElyu+UaSSHGQFCfF3IpCSwy7V6GtOe1XLBfAl2W05vyk5BzvgK9jlGwU8fpvjT/q4Xup4QRrl5j2WSQEGz6PpVwog==
X-Gm-Message-State: AOJu0Yz+40gBt53lau+ux5J5OzuV9K+b4hZ83z2BijN2NHuma8+0ZgDB
	DQKlJaHrnoxpFk9RVxRRPYNN1kyfTtXDh+w3idLvYEeTznEw2VNIFCXSB3wtxMzulhE3dP+xvFr
	W+8IVdA==
X-Google-Smtp-Source: AGHT+IHIMq5cuOtpe99i9/VfABCqMAYjXYL4ce0yS7sypzVC8xSF817NvE8VUA6yYx0BwM0GPvB3U/eqWK0+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:690c:fce:b0:666:e184:4dfe with SMTP id
 00721157ae682-666e1845003mr78227b3.6.1721262645328; Wed, 17 Jul 2024 17:30:45
 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:30:21 -0700
In-Reply-To: <20240718003025.1486232-1-irogers@google.com>
Message-Id: <20240718003025.1486232-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718003025.1486232-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v2 2/6] perf parse-events: Pass cpu_list as a perf_cpu_map in __add_event
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, ananth.narayan@amd.com, gautham.shenoy@amd.com, 
	kprateek.nayak@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"

Previously the cpu_list is a string and typically no cpu_list is
passed to __add_event. Wanting to make events have their cpus distinct
from the PMU means that in more occassions we want to pass a
cpu_list. If we're reading this from sysfs it is easier to read a
perf_cpu_map than allocate and pass around strings that will later be
parsed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 321586fb5556..43501eb56336 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -227,12 +227,12 @@ __add_event(struct list_head *list, int *idx,
 	    bool init_attr,
 	    const char *name, const char *metric_id, struct perf_pmu *pmu,
 	    struct list_head *config_terms, bool auto_merge_stats,
-	    const char *cpu_list)
+	    struct perf_cpu_map *cpu_list)
 {
 	struct evsel *evsel;
-	struct perf_cpu_map *cpus = pmu ? perf_cpu_map__get(pmu->cpus) :
-			       cpu_list ? perf_cpu_map__new(cpu_list) : NULL;
+	struct perf_cpu_map *cpus = perf_cpu_map__is_empty(cpu_list) && pmu ? pmu->cpus : cpu_list;
 
+	cpus = perf_cpu_map__get(cpus);
 	if (pmu)
 		perf_pmu__warn_invalid_formats(pmu);
 
@@ -305,16 +305,17 @@ static int add_event_tool(struct list_head *list, int *idx,
 		.type = PERF_TYPE_SOFTWARE,
 		.config = PERF_COUNT_SW_DUMMY,
 	};
-	const char *cpu_list = NULL;
+	struct perf_cpu_map *cpu_list = NULL;
 
 	if (tool_event == PERF_TOOL_DURATION_TIME) {
 		/* Duration time is gathered globally, pretend it is only on CPU0. */
-		cpu_list = "0";
+		cpu_list = perf_cpu_map__new("0");
 	}
 	evsel = __add_event(list, idx, &attr, /*init_attr=*/true, /*name=*/NULL,
 			    /*metric_id=*/NULL, /*pmu=*/NULL,
 			    /*config_terms=*/NULL, /*auto_merge_stats=*/false,
 			    cpu_list);
+	perf_cpu_map__put(cpu_list);
 	if (!evsel)
 		return -ENOMEM;
 	evsel->tool_event = tool_event;
-- 
2.45.2.1089.g2a221341d9-goog

