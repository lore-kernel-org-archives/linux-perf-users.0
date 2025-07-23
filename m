Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB72275869
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 23:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753313019; cv=none; b=gLZsAvJXVwBIWk9isWyRXNhVEcdUhBhZ5m24COQ1nAtQv+N1UpG7N6OZdEAnIArM4cgDdiHkGhCEhOE2+oRzhtnu8oEIgOTHHzFUD7Yiru8+Fpv4e6Je6VzKhRaqqIAfd9cr4tH/jgL+8PzRM6ybkrF07ZPQ/qQ6+i6B3cuKdCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753313019; c=relaxed/simple;
	bh=Sxav3zDD0U0Gg/+clfnyl2vd++/wAcjd/MiMe5A6hwM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DY/X9IaOFcvfFM0roC4XTbM9p22IUaeaao++RFBkbaAampAvXe9Hc69fgxUthTAIMrw65m0soYKFuJscpqIj4hMxuld9ReY1A4QJz6gyMb3Zxuxvq2sZLIsAUx2n31KZmae45URh3rCgHEKz7R39gO+QhGYf0ZWYoyvRku+Tc40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L4b0IuFu; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L4b0IuFu"
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7e2e8a90a90so71019585a.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 16:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753313017; x=1753917817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v96KHBG+xnk8h1wczuNITcFFd9n/85CgWkXy1c40Fug=;
        b=L4b0IuFugtYSEzDSSRreFDsDpnF9xwnOntjYB8vJlLZFJAF/1l8Y8yVEbCtZjBrOJH
         UZVH8oRvpW2NJrcQ2fBTz4k4cO4fxznZXk/FQK6Zuc6mFQhhDHKOJYDWCIPG1RHOZyKK
         5pmNz3J2p9HB2wUQWljtOpuxLqQYPwHm8wwl63oNAGfLv92GYqtFLwE7fmxrkScOHEHD
         79uM/aascGATsb2tZIMk/EeogzkH6vtnJcmV15iFTq0tGObe2blcvI3BIlxGyT7Q12//
         UPp7QB0FoKqZWvQPuHW2lYZwmfkCbLNg7X3enwCl4XB4LWWYH5HG2RoBU8bEg6z8S4NP
         f7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313017; x=1753917817;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v96KHBG+xnk8h1wczuNITcFFd9n/85CgWkXy1c40Fug=;
        b=IMm14p7alKOVyWFdQcwjKsP9ouNJeyM0tef5sTY/6R9gjwoi99LsBvVUWNozKtJvIk
         uheMKhGdvyQiCQUhy9JPYVtFiu41k8pse1W9bjCW+ZRRiVR61Yu+B6QQ5cQS57jRGgRr
         90f4MztJjV/WGNkXTXBnW8UI1JKJX34Rs3rlNfRjQt6Ss5bYW9ojCvj31bSiXu2BICLN
         ayPwUR4rvZnSgvaXL+hHR1fAMP0+ukt8fadY9ApCcq+McqQb3jvg3yroRI1vGuLzHl0+
         SS4dI+ExFJJOPYuKEY3ll+hVOlq3K2SUUJ8xuhTJEmcv1yUUdGN0V5FbLxvdX3Yd5q/y
         E3DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiOoHKe71ep37yb2fi/KhE0pCHdp6e17S8JMcG3ieoxtbSFpVSJlj8rvUKY6+wMKUNHt1D1nilUNIouQCWba53@vger.kernel.org
X-Gm-Message-State: AOJu0YwpXEHg9yIqJ/A9FUzRGL5pjxvuI6CiW44aiO4lDNWGaR6i7/as
	x24GnzCSXF9yc0bmJO+Tr2lccJy9DlsmkQIqf7tcJkI2ua4cbVC3uXJsmmguIf495uy35t7fE6V
	SeBy1m+WMnQ==
X-Google-Smtp-Source: AGHT+IFITYad3KgDe7X8tbLUFDJuJhFhSRxKrRCTY7rZfyUjflk9lqEUUE//mQnXdlw4KoxYLec69qUS7oaW
X-Received: from qkpu10.prod.google.com ([2002:a05:620a:454a:b0:7d4:4ab:49a7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:400d:b0:7e3:3cbc:786d
 with SMTP id af79cd13be357-7e62a17ec2emr533579385a.28.1753313017256; Wed, 23
 Jul 2025 16:23:37 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:22:14 -0700
In-Reply-To: <20250723232217.516179-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723232217.516179-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723232217.516179-14-irogers@google.com>
Subject: [PATCH v8 13/16] perf python: Add evlist metrics function
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
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

The function returns a list of the names of metrics within the
evlist. For example:
```
>>> import perf
>>> perf.parse_metrics("TopdownL1").metrics()
['tma_bad_speculation', 'tma_frontend_bound', 'tma_backend_bound', 'tma_retiring']
```

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 3a58080bab24..ccfa1ac4ad4b 100644
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

