Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0BA2DA75F
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Oct 2025 22:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760653367; cv=none; b=rbvI/ukE1RgbZXBgwpONfGL1UZ8YHlb6Nv/4OPDtTbi/HgzmR1gnCoNZhSVI6WbowQfyS2qCcstsXR+6PmmI74EkPGan6urMu+xzSj0bvhACNjTdAy2iHeibDTYOGBIcJmaHidC9VUSd7AgyLOhR2wXmXw839+kpD5wlvmUZAXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760653367; c=relaxed/simple;
	bh=pnCNjsbAF4fbV8J34XGNRaAbyj04wicIk1PQP0OojQo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=V7+JLcpREaZjjwHGzxgZUjXQip2HCYJHkgHin24toHgPdEG/yZp5ewkpdR8F11fXRou/bZZOXgyNphKdvkgPe+uN/DMBBSmc9n0JWOeWzQT3NPSzHhCrd4ub+zGj/36GuUO2nkKOMBGkWBjAvZuCFslJ/5oSnttKtQ7NfymYodI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rqNqdFez; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rqNqdFez"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-792722e4ebeso1328788b3a.3
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Oct 2025 15:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760653366; x=1761258166; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CVp4000v4+p6Jp02AmU2i9jZRIK/MzbNMWKvsi0YcUk=;
        b=rqNqdFezJWtznHhIHt/n3gNb7TGk1dQ/GTUI+3u2v4uFxNG/f2l0utUIiGUO9TmXv0
         87CzYaK42CBYZO0ZER9e5S0eLZgCj5fG4Q3I92ORVd6UFe0+8Xuxp5smoC7GbOR/vunU
         5k5yk65kzYIyY6GPLoSpQpvjLYiqBJ1aQUrOpqRUOx5MfJJaYbZHI7bZTjPkIKuotmbS
         yJgzNdirNiWjS6zs4fPBAu8AChWW9oklD+6NtCgkhiUGDHqpcVL4SoKWsiUbkmHSGPRc
         a0d6eHFWWu5ARoojf078N8pFA9Tj/zmlvDcWJvMn+DyA0rVXFztkF5VvEcrF3InHL9Xm
         vs9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760653366; x=1761258166;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVp4000v4+p6Jp02AmU2i9jZRIK/MzbNMWKvsi0YcUk=;
        b=vmtb4s/dMN2HfP4EA8AtH1q76D0UA4gMIqCRQ185w2qH0cTNJyHgZ8cCLilqY3aH/J
         feIfZyyXP0OdjwBsGt+P5K70V8p9u3euu4eQcOgVIiuxKutCJFWPmwBvxLj/YO5LLajb
         0mv2pfnfSXgLw9v/HBCg2wQHoCIq3SddWMuMmXcqjMj8YufJ6RjZHcz5XtAqHMP5jFkE
         Er1kjoubkKz4DAuOlUXBZsYxeDzlHJcbFNagpnqDDVMTqN/E/F9vFv3UjJPXjl3Z3RHc
         h6M7C9dysuhPWnQS4CxOLvLoRW77k/RqwdPMzSdyqQwKPQnmqBF2smFkCdXIFnCmhcs+
         wK2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXpopVQwlkECmVCuxE8BxHKkMjHKMZ4a92grzbOTX9BgC8TsPUqd14Hp3uxsni6T1gureSmb8Tl3WqDGAIehQVi@vger.kernel.org
X-Gm-Message-State: AOJu0YyxD4TGHLTVKUmgz5fDYXPgqyhMQXgeVTTMtnlo0XEp4zbC/OvA
	QQDzn/FRcUr9g+sIWPF7mxbxwLv235k03p+SC3pm67hSMg/CjpTuOaEAkQsYJS12nsepdIqweU/
	WH5MCcIleQw==
X-Google-Smtp-Source: AGHT+IGrasebroivlsDByk+hO786mJCf3alb9Fal7TBM6TTNeKJiss7Ev/OSdJvYSkLeII1PzMaZeIT+fgMF
X-Received: from pgcs13.prod.google.com ([2002:a63:770d:0:b0:b6a:2621:7a75])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d80f:b0:2fc:d558:78a9
 with SMTP id adf61e73a8af0-334a8610b14mr1738718637.28.1760653365254; Thu, 16
 Oct 2025 15:22:45 -0700 (PDT)
Date: Thu, 16 Oct 2025 15:22:27 -0700
In-Reply-To: <20251016222228.2926870-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016222228.2926870-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251016222228.2926870-2-irogers@google.com>
Subject: [PATCH v1 2/3] perf python: Add PMU argument to parse_metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Howard Chu <howardchu95@gmail.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add an optional PMU argument to parse_metrics to allow restriction of
the particular metrics to be opened. If no argument is provided then
all metrics with the given name/group are opened

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 779fe1280a56..fa5e4270d182 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2051,7 +2051,7 @@ static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
 
 static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
 {
-	const char *input;
+	const char *input, *pmu = NULL;
 	struct evlist evlist = {};
 	PyObject *result;
 	PyObject *pcpus = NULL, *pthreads = NULL;
@@ -2059,14 +2059,14 @@ static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
 	struct perf_thread_map *threads;
 	int ret;
 
-	if (!PyArg_ParseTuple(args, "s|OO", &input, &pcpus, &pthreads))
+	if (!PyArg_ParseTuple(args, "s|sOO", &input, &pmu, &pcpus, &pthreads))
 		return NULL;
 
 	threads = pthreads ? ((struct pyrf_thread_map *)pthreads)->threads : NULL;
 	cpus = pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
 
 	evlist__init(&evlist, cpus, threads);
-	ret = metricgroup__parse_groups(&evlist, /*pmu=*/"all", input,
+	ret = metricgroup__parse_groups(&evlist, pmu ?: "all", input,
 					/*metric_no_group=*/ false,
 					/*metric_no_merge=*/ false,
 					/*metric_no_threshold=*/ true,
-- 
2.51.0.858.gf9c4a03a3a-goog

