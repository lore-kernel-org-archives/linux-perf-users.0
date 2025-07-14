Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080422641F8
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511480; cv=none; b=PDQHZ9cnK/4TNPyv7rwgKnqvDj+MZ0xQpG/5fHUjEr2G02WrC6e+5qhsDC0VK9UJ20Ga4K3nMkNSfgfG5AU7IEsrH76OwCWM9P2vnseYI6qJR7AaP9Izsz6niZ7Q6m79rAWTltM6u1XGL1NGHWiFYvgfXsXeQn/bd9q+H9tcLqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511480; c=relaxed/simple;
	bh=YfHrvvulmnCHCIxuummdSqASVcc704Ccv5tz5doWQeo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Iw4TlXYB4GjTuAMywav389IOTL5J0UcJJ9g7Wgx8olJkAbeSw4zNNCX4A/gYgUs5bQ6eutB7zUGYoGkv0qRkG7CPjS7YE7sCrpLtgv2g5KnY+fBXUeqmvYfmLusiYmOmN4kXEnM4ppqvBvZGy5NGosOr9feXup6UZlhAQByYsBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N02aIP8O; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N02aIP8O"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3138c50d2a0so6882687a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 09:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752511478; x=1753116278; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rquscjWRa6LTliNe/SCTRQKemW4K6Wpniv3kqn6BfWs=;
        b=N02aIP8OP7PvSIYY9yjhQJImenNE8YqTYbhXfH2wbk8pFyy9k2272zAue4KUQu7XlM
         9I8qzsErnEh0KsF0eJ/ETkfjKnOI/bwt9Uw1xVtole2y3UXW1jFsUSYy8O8RF4cQoMJX
         nUpGOd2MivGe57gmmV3dC8WrJZ/Q9ti17cHMolNnhvQQRW4IO94/2IZLZy0P1UekXbZU
         zqa8G1t554kKPGEZu9u2mVrYhLcBgpFyoquTHvrthWk4LvecrlzOLvSOrJXchaMJG2NQ
         JTgUvx72fL49FTszXD8Nzxs2poRSQ63SlS/7D2kH17cpkvtW0nWetJDloCsXzm0fbI9+
         krtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511478; x=1753116278;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rquscjWRa6LTliNe/SCTRQKemW4K6Wpniv3kqn6BfWs=;
        b=eb8hL4FJ35Ik8tmaVwIPraaJiNH03IcQ7XamOCiYbvIiRx8r5awfRg/+Md783fbq1u
         RN4GfyfWFy9fd+5aZLWASYMfWPRM5R6Z6F+rYBDhhthu8uGm1eMwnog3yhkocBClV8nD
         w3SvGshGtYG7imXky0EQ8QlHAeQwSmDqoEsMta4uXBmXsJZL8G6z8rNUNxMTiJdlmvsZ
         eEyThmykxd2sVAWXkajviZHz+AFnYdTrATuBtxv9rNq648HMhUOW2ujdRLjapWizFZSv
         IvmPPqSTsTMRp26PZNztVspSth2m+5O16J9WqpaRyZhNLlZPudRTd9M6j3NEUgY+T+Dt
         oOWA==
X-Forwarded-Encrypted: i=1; AJvYcCUx9eQ0pnJ0Ol+BSaL9BqKXRZrK23CS2nWQghtUfoistkhcuEKQhSh/K28R5Q3Tdxq+T9fVW2dZdAsF2fHJlQgR@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwl06+vnrWZkmQw8koNIJ4S1oNA2Sb8CdeTxVCQg1B8uOEGYTo
	V/fJUeVShzD46Zu9cGwY7le3NNdXATazWPE4gR79o5LSoM6zV+Y6JzDjYXtc35Tg1OkzD/CgjYw
	zDRXEiJrbOg==
X-Google-Smtp-Source: AGHT+IFjr6s/WVCdiudJRc0Rj/hLFvpXOTTdTCBMb9JIx+S3NaaimeJQcAnUk8PRa7ClwAhkne0a4WxXfBE/
X-Received: from pjbsi9.prod.google.com ([2002:a17:90b:5289:b0:311:485b:d057])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3844:b0:311:c1ec:7d05
 with SMTP id 98e67ed59e1d1-31c4cd568bfmr20099835a91.35.1752511478227; Mon, 14
 Jul 2025 09:44:38 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:44:01 -0700
In-Reply-To: <20250714164405.111477-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714164405.111477-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714164405.111477-14-irogers@google.com>
Subject: [PATCH v7 13/16] perf python: Add evlist metrics function
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

The function returns a list of the names of metrics within the
evlist. For example:
```
>>> import perf
>>> perf.parse_metrics("TopdownL1").metrics()
['tma_bad_speculation', 'tma_frontend_bound', 'tma_backend_bound', 'tma_retiring']
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 6454f24cd810..c1eab506f55b 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1293,6 +1293,33 @@ static PyObject *pyrf_evlist__all_cpus(struct pyrf_evlist *pevlist)
 	return (PyObject *)pcpu_map;
 }
 
+static PyObject *pyrf_evlist__metrics(struct pyrf_evlist *pevlist)
+{
+	PyObject *list = PyList_New(/*len=*/0);
+	struct rb_node *node;
+
+	if (!list)
+		return NULL;
+
+	for (node = rb_first_cached(&pevlist->evlist.metric_events.entries); node;
+	     node = rb_next(node)) {
+		struct metric_event *me = container_of(node, struct metric_event, nd);
+		struct list_head *pos;
+
+		list_for_each(pos, &me->head) {
+			struct metric_expr *expr = container_of(pos, struct metric_expr, nd);
+			PyObject *str = PyUnicode_FromString(expr->metric_name);
+
+			if (!str || PyList_Append(list, str) != 0) {
+				Py_DECREF(list);
+				return NULL;
+			}
+			Py_DECREF(str);
+		}
+	}
+	return list;
+}
+
 static PyObject *pyrf_evlist__mmap(struct pyrf_evlist *pevlist,
 				   PyObject *args, PyObject *kwargs)
 {
@@ -1521,6 +1548,12 @@ static PyMethodDef pyrf_evlist__methods[] = {
 		.ml_flags = METH_NOARGS,
 		.ml_doc	  = PyDoc_STR("CPU map union of all evsel CPU maps.")
 	},
+	{
+		.ml_name  = "metrics",
+		.ml_meth  = (PyCFunction)pyrf_evlist__metrics,
+		.ml_flags = METH_NOARGS,
+		.ml_doc	  = PyDoc_STR("List of metric names within the evlist.")
+	},
 	{
 		.ml_name  = "mmap",
 		.ml_meth  = (PyCFunction)pyrf_evlist__mmap,
-- 
2.50.0.727.gbf7dc18ff4-goog

