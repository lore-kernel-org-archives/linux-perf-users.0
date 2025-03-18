Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D804A1A2658
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Mar 2025 04:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742271293; cv=none; b=S3gaZDVaQQfyahfxjlqFrE7prk274HZ4EIDZ09VZchSE92taoEOf1Fwg5fU6hphdMHxPMhjohOZD5qKQ2URS4UITzezv9XN6Yovlpoooudq+14ukJraa/1GMdKEz4mHV3g2B4AYb5EQfdjW9CMLbRVDzq4Yz750Eg/B5sKgnavY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742271293; c=relaxed/simple;
	bh=l1jkTLgRI/f5/qN6LeVtV033c5ilO6kZMs//pmDP2rQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=QWuGc2mhl5WY0DqtQcW0VyU8M9M9jVonMEKbM4CVOGq66olcJ055X6W3CtQAgG7Ixv2vbGRBZnnkbiygL06H20GgofyowbbTSUoeet812GSxSmxwvcMNGPyTUMLvyD6OmPe2563teLcPUCFLQJhcQNvXDEux0Q26ZQM9ulXGbBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d+4IFBgd; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d+4IFBgd"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff798e8c93so4231817a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 21:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742271291; x=1742876091; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q/73Kpk2L7vMutO69KMLDlRxgU/lpzgb+NuxVOTOV6A=;
        b=d+4IFBgdlnRsARL/Mss+ihgrItD7PiQ02SUAMb3iCtSQNW0/qc88RfPiE286I2Hsz4
         XCkEXvjIBxxVYgkJOCF6LOq57GirS0s8elP0xKW0+jbD1+AzXcFJAZwyyTuOusWCsnMV
         Nr55o/Zg8j0uutYLYa2MKm6LuilU9ExPkiQiFsuOWHzZkM7oTKvDc7MuQla/BLG57CMe
         gm8k1ov2bxiW+g02SPcv5+ElJsLIJ217Q5palzG4NJAGTMiD36RP72co5nEIBviG15Bi
         7d82SwYiNj89XTbngmePZ3iyChiyiOFzpTTDxQTFhcZJNfrgj2R+QCyHBR5BX2qR8VQ6
         Nc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742271291; x=1742876091;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/73Kpk2L7vMutO69KMLDlRxgU/lpzgb+NuxVOTOV6A=;
        b=dj4bOwZMxpCcjlHvViMqXz/vH4zkKsPcVf6CHTLe6WSfS+dUYBJnXDr8G7chDAchvJ
         KP0NT0Z0f+QzbtktPLKYbacpcZ4QoneWTqyeldRMciBoEcAHBdhCBXwWKSgZRxzaMpXp
         e/48WSYpveH0ZREbWra6XzKL+n/1ZQiWwIoZjF4d4l2DzWnqULEGf9PYtg1yPWrxgrCl
         wx3HDMo5UNV4A+XBnXD7gUUw+IxI+ReGCqpsDMAUnIikvXuIzjOeTRFx1aB3vUuc+RKO
         tAk5uGlwOSovHIuTtE/6e+1LLA+H0QzXX59b273jXkyewa4qaR7PMwtp9xhD7OtmJVpU
         E+/w==
X-Forwarded-Encrypted: i=1; AJvYcCVTUhgvzw4ZGGRaoZXN/cbxCGQReZt6bf8voo/Ji/VtQ2pZtRzkXiIOYk39X3rIxsCzkE1I7VyUtqUGuoqJfIgE@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuh8aLLa/e57noY5i7UTWu9I5gRIsb8kaR28/KQYocbo6OODAP
	Oo2vtofxp4JnjhohTGcr4uCRdfFghJ2yIOWPsuioaxhANXaRracSxj0mYOr3cfhYL1IHfIADyDp
	M5BE8Vw==
X-Google-Smtp-Source: AGHT+IFcAfBEQciZiHy7t7Sm89sYmqUs7Yj7t+9M+SoNXAE5qEt6Y0tXRSIqYugJh7uXMU3uF3V9yse6JCAi
X-Received: from pfl8.prod.google.com ([2002:a05:6a00:708:b0:736:3cd5:ba3a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4325:b0:1ee:e96a:d9ed
 with SMTP id adf61e73a8af0-1fa43ace812mr2992442637.7.1742271290868; Mon, 17
 Mar 2025 21:14:50 -0700 (PDT)
Date: Mon, 17 Mar 2025 21:14:38 -0700
In-Reply-To: <20250318041442.321230-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318041442.321230-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250318041442.321230-2-irogers@google.com>
Subject: [PATCH v1 1/5] perf stat: Better hybrid support for the NMI watchdog warning
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Prior to this patch evlist__has_hybrid would return false if the
processor wasn't hybrid or the evlist didn't contain any core
events. If the only PMU used by events was cpu_core then it would
true even though there are no cpu_atom events. For example:

```
$ perf stat --cputype=cpu_core -e '{cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles}' true

 Performance counter stats for 'true':

     <not counted>      cpu_core/cycles/                                                        (0.00%)
     <not counted>      cpu_core/cycles/                                                        (0.00%)
     <not counted>      cpu_core/cycles/                                                        (0.00%)
     <not counted>      cpu_core/cycles/                                                        (0.00%)
     <not counted>      cpu_core/cycles/                                                        (0.00%)
     <not counted>      cpu_core/cycles/                                                        (0.00%)
     <not counted>      cpu_core/cycles/                                                        (0.00%)
     <not counted>      cpu_core/cycles/                                                        (0.00%)
     <not counted>      cpu_core/cycles/                                                        (0.00%)

       0.001981900 seconds time elapsed

       0.002311000 seconds user
       0.000000000 seconds sys
```

This patch changes evlist__has_hybrid to return true only if the
evlist contains events from >1 core PMU. This means the NMI watchdog
warning is shown for the case above.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e852ac0d9847..f311f1960e29 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -825,13 +825,25 @@ static bool is_mixed_hw_group(struct evsel *counter)
 static bool evlist__has_hybrid(struct evlist *evlist)
 {
 	struct evsel *evsel;
+	struct perf_pmu *last_core_pmu = NULL;
 
 	if (perf_pmus__num_core_pmus() == 1)
 		return false;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->core.is_pmu_core)
+		if (evsel->core.is_pmu_core) {
+			struct perf_pmu *pmu = evsel__find_pmu(evsel);
+
+			if (pmu == last_core_pmu)
+				continue;
+
+			if (last_core_pmu == NULL) {
+				last_core_pmu = pmu;
+				continue;
+			}
+			/* A distinct core PMU. */
 			return true;
+		}
 	}
 
 	return false;
-- 
2.49.0.rc1.451.g8f38331e32-goog

