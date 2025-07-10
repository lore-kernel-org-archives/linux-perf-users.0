Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722743074B9
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 20:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179145; cv=none; b=M3lfgxvOGXnDw02Y4kNZtaApyPXIrt5EK0Lj4aXe5cyr/+4gWsc67t+NOp+IYO85u46ex1aLHYnz9M1n+sak6tmvKNLqxd6zYVAUFZSOrI7ddbwGbsQ0uhe2MTYtTmx79EboRaM9YXZqi39PawPr1KFCC16Kn16D66VXVVuxd8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179145; c=relaxed/simple;
	bh=3dXnQX59uCIqHGxrXpzMnI4Zl7s0lQpAP1vxN37XyBs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=H0RbIzf4WxRViWH6v2+ki6MU0NQDKEGkd8plHRfcws9h6JIt6l6Coo88SQg5CXjvd4wGHoScJk4elruzjMvATkA5k4lb0IScw9HtI4KJ5E2uzlZOVrlo1ESIJKB5DY2quo1Ydquow5tpg+3G/efXO8QQiqPgdsKCnCC8aHmFtCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ick4ZjV4; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ick4ZjV4"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b31c38d4063so1007242a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 13:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752179144; x=1752783944; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kKmR4p/5RIten4aKh3XJYKu49jHs+S3X2MC/LIpLWZY=;
        b=Ick4ZjV4qlrhgEoNy8Dnw+ZyGhUaNhHbCvgxueftZB4mGwp42Cq0nA1gPm6WpZ4EAH
         wARug9Tl3SF6LaVPXG2iSHTlkFq/980vdYpLTcqK+EegAV2hAOrMZI0cAtzYuc7dLSgv
         d0e+VpR4mWTD6q3OEtJxQhec0SuTtP6IoUSeJR7ztkAPTHAnuiVgNSK05faXw1nHrOu4
         Tc/oyQNJvq4qe4VX8YHMbQL5fFwjCmnELAsQXjusd8qI2UhRk+oEmx3UCXZ+OZVt8ZzY
         w/GTQsjoqNSk4nRWwMXF+wvVvkS+PsqL+K19cU51cE+0vIv2TcCk0tCjcwC8zETr0+uI
         E1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752179144; x=1752783944;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKmR4p/5RIten4aKh3XJYKu49jHs+S3X2MC/LIpLWZY=;
        b=OQyNXJk1cQlc8KLPuvWHX+l++RSV48azFO9TzGWwp5CLXRNUQrTVkA7vlp9MrdVSjR
         ryuDEbrjzZsQEhbVtG3YGW5D7Mz2LuPTeuEJlq+adY76WyRcuSSI53d+ao8rgSvWDgWl
         5SeIzRw9D/CfXCkrn83B6zFVYyqceTfLQ8tesjeNfuYGiVjyK7hQEx6ZOAX9k/zTzgEz
         VrlOVTEyis6BMtcWaJziDoNZMvLAdClKrHIu5CescMdotNR5oWOKMGviy7ncCjt/IbxP
         y5VCu1iFy+RcRtU86vTJfLQgwmzNjY0QJU6nNNFu89wouOcAZcxGOihSobKfFcxyaJWJ
         Wa/A==
X-Forwarded-Encrypted: i=1; AJvYcCXhhKQLvaTujnNpenmz9h+JD7vW+p9xhXA/WqwaoR7K/7jYQBaM/YEXDiQdezMEbxBs4itlkmDuxL9/dxf1ZxAj@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn73emoYgx4omrAc4DJ8sgKQn4FV61OUQz9VOHLAN753cvKmBa
	hLjHMvcqNyZ0GPtlBqifbrONehCEOPLYbCRQ9iqsuzLPSCbUwzi9xiqRdfU/BgpydZKvF5btqQD
	ZtCajmIbDOw==
X-Google-Smtp-Source: AGHT+IGMb6gzdDHDVJtMJQdjdiB2sSHyLIcSx+wq4io8/nN853oSogBXzIpKHEFOzru5HYy7zAazLRvW5hIP
X-Received: from pgbdk14.prod.google.com ([2002:a05:6a02:c8e:b0:b31:c53b:ff59])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1f8a:b0:222:180e:3f22
 with SMTP id adf61e73a8af0-2313686203emr586614637.26.1752179143819; Thu, 10
 Jul 2025 13:25:43 -0700 (PDT)
Date: Thu, 10 Jul 2025 13:24:56 -0700
In-Reply-To: <20250710202500.1959672-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710202500.1959672-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710202500.1959672-19-irogers@google.com>
Subject: [PATCH v5 10/14] perf python: Add parse_metrics function
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Collin Funk <collin.funk1@gmail.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add parse_metrics function that takes a string of metrics and/or
metric groups and returns the evlist containing the events and
metrics.

For example:
```
>>> import perf
>>> perf.parse_metrics("TopdownL1")
evlist([cpu/TOPDOWN.SLOTS/,cpu/topdown-retiring/,cpu/topdown-fe-bound/,
cpu/topdown-be-bound/,cpu/topdown-bad-spec/,cpu/INT_MISC.CLEARS_COUNT/,
cpu/INT_MISC.UOP_DROPPING/])
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 728ed27986b5..2a8026a261ce 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1849,6 +1849,40 @@ static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
 	return result;
 }
 
+static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
+{
+	const char *input;
+	struct evlist evlist = {};
+	PyObject *result;
+	PyObject *pcpus = NULL, *pthreads = NULL;
+	struct perf_cpu_map *cpus;
+	struct perf_thread_map *threads;
+	int ret;
+
+	if (!PyArg_ParseTuple(args, "s|OO", &input, &pcpus, &pthreads))
+		return NULL;
+
+	threads = pthreads ? ((struct pyrf_thread_map *)pthreads)->threads : NULL;
+	cpus = pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
+
+	evlist__init(&evlist, cpus, threads);
+	ret = metricgroup__parse_groups(&evlist, /*pmu=*/"all", input,
+					/*metric_no_group=*/ false,
+					/*metric_no_merge=*/ false,
+					/*metric_no_threshold=*/ true,
+					/*user_requested_cpu_list=*/ NULL,
+					/*system_wide=*/true,
+					/*hardware_aware_grouping=*/ false);
+	if (ret) {
+		errno = -ret;
+		PyErr_SetFromErrno(PyExc_OSError);
+		return NULL;
+	}
+	result = pyrf_evlist__from_evlist(&evlist);
+	evlist__exit(&evlist);
+	return result;
+}
+
 static PyMethodDef perf__methods[] = {
 	{
 		.ml_name  = "tracepoint",
@@ -1862,6 +1896,12 @@ static PyMethodDef perf__methods[] = {
 		.ml_flags = METH_VARARGS,
 		.ml_doc	  = PyDoc_STR("Parse a string of events and return an evlist.")
 	},
+	{
+		.ml_name  = "parse_metrics",
+		.ml_meth  = (PyCFunction) pyrf__parse_metrics,
+		.ml_flags = METH_VARARGS,
+		.ml_doc	  = PyDoc_STR("Parse a string of metics or metric groups and return an evlist.")
+	},
 	{
 		.ml_name  = "pmus",
 		.ml_meth  = (PyCFunction) pyrf__pmus,
-- 
2.50.0.727.gbf7dc18ff4-goog

