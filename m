Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE85302060
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 20:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179848; cv=none; b=hbeUn7zs0J0rIB/TWi7A6zs6q9fgRaygLff0u+M1nq3vagdskNZhA2krfJfjI3fOk4Zdvm0/lxFUDRY8BGm4ACFql0UH0reew3Cl3Ux9oy7ZnR/zJtgQJydJvT9V1yxNg+P/c4TUJ45JFV7vxrQTWY8QWUa4oIWZnSQ7hsYCQ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179848; c=relaxed/simple;
	bh=CQ3wmaeOJWsKbbuQFhAuSaG0gA+aFq/bD2Cwcmzd5EM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=LfE2jzZZokr+zfnXcFCd7EBpSl2Yfd1FtBybrri/VCVYRnaFOjDKyF+5kjazy3Mpw8GI9RXKimW8ph8hUz3kjK/AR7GFHPcVXa6rLG25zoH30S5yreBIZYytnRA61P2WADn1e5K1thYLzLKoMg5r2xZIGD3B2DXwHsXVpj0giFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uD/Tc5fC; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uD/Tc5fC"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31220ecc586so1404241a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 13:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752179846; x=1752784646; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ynfXIEdjbeoZVI+qyhuUZ2zNsB5tYJ4xhRzXaal67yM=;
        b=uD/Tc5fCUtywbhS3fuF8/nxyxS8o4OSd1nTj5WlRCWPUvKYArkEhcmnbxuIID2py6h
         S7eCh47NhXeIWH2vJI0pf+n9kbfwuEfy52oez87lq9jAOrVFZS9aFWOOmB3+uI+6CCMM
         Qsj0MEeUemcqLg2VJElBOtTBekZ5q+mPlM49iRn0m/ZbdWVugOLp8WCjc85B8lumI50H
         qucseIXCNzDuoY9pWsA1ATTFGzm/NLXPKDUW3fl109Zc7sUzYrL5intYpZZP/pHNj6ef
         OKK0X4m9uARPy/TfgG5BtGhmszBtZc2zmFGSL2n5Z3xNhVUWv5w8RG6JRk8sWBhykMLm
         2IhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752179846; x=1752784646;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ynfXIEdjbeoZVI+qyhuUZ2zNsB5tYJ4xhRzXaal67yM=;
        b=rcLtCBLKQLsYuoCmEWuD42QnaD61+2krhWPHb6ClcsGtTPvLG6ZVKwMMDea5ubgLHL
         SxuqRzzP0IqFTTgWXpO7s8uJSNOyJsAIKLhv6BnqNpgv74izgsoSJzmbXTz1flfiUonq
         ByTAcgvsGvPFGqBmSs3l0jNSlVXzpcvscrbNsHsHiRHlZbwDEaydqZVg3q0FiAoI3mlA
         jxKoapiA5N4KTt3Q/xzsLwgSlA3FfBK7zWC936q5SoEoamJq+7RkXGU4d+66yRLIsh6U
         uW3UCDpMrj1UutK7qtY0rlKoZ0cv5606mvsyVSalctjBCh9lzZhPulfDgHbtmoEpPODD
         gAhg==
X-Forwarded-Encrypted: i=1; AJvYcCUG1Ia9AoHKMCkgu9DgW59c0ciW2uohiLx7Wv+894YiyxXDDwHfx5cbZ8ETHyRrOwqBSR4dzpgrUrxr71IaFVs7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8i5UlL0kEpve8FCDbtDvigSE/F/poiLU4gc8FFVma2FOtIIpP
	Ny0gqWNQaKSL7jPgYUVCzgKDzt6QAQk2Hhc6bhmYLGqrhWyEJk+UX992rYKfx99gJiOeQnNTviB
	b6gSzW7R7dg==
X-Google-Smtp-Source: AGHT+IH5uRPHYsjqZRWR7Jiku4nZZTEYzvbXYkKk8s5HJWrhH6XI/ITs3cLIAAqZ1C0LFTk8gWKpCrT5+hVU
X-Received: from pjbrr7.prod.google.com ([2002:a17:90b:2b47:b0:311:f309:e314])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:580c:b0:311:ad7f:3299
 with SMTP id 98e67ed59e1d1-31c4cd9d001mr1121470a91.25.1752179846087; Thu, 10
 Jul 2025 13:37:26 -0700 (PDT)
Date: Thu, 10 Jul 2025 13:36:53 -0700
In-Reply-To: <20250710203656.1963075-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710203656.1963075-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710203656.1963075-12-irogers@google.com>
Subject: [PATCH v5 11/14] perf python: Add evlist metrics function
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
index 2a8026a261ce..9377b64d73af 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1278,6 +1278,33 @@ static PyObject *pyrf_evlist__all_cpus(struct pyrf_evlist *pevlist)
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
@@ -1504,6 +1531,12 @@ static PyMethodDef pyrf_evlist__methods[] = {
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

