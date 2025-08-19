Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378AA27A931
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Aug 2025 01:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567633; cv=none; b=lNA7sET1CK2Xi/5txT+KJ6ZnicGL8jHN9zJ6ISP+MK5C5phgS3WALCnPDrGbuLDYpocn+8h4n9uJFP24ojW/tbE1tjcVOz8EMdnQ5gZ+eV67Xxr0QFumJeX69685152zZaqU6r8AfjRoXA7go1Uu89Q0eIsb/+FGLVOFLW1vjng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567633; c=relaxed/simple;
	bh=9m3NIbf6G+NKc23GI7ySDayLKzAPlzW0J8oYNOOwiYg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lEpqtyyJoDDiL3++GIK5umSaoQKAC2SXl0kAP1NzmortPVcFnwdSg4NTqqZCUoydAs8h+WYA2wIebinDWPo7Cvb0FAb6rFprIWBLNh9FOkEtH1BY5T26sWJc0fF2DZ4rLocGNVGtzTnm46qaLPkaLWqjv74qJbZwFmfv9BumZQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YFXb/5Rf; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YFXb/5Rf"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24456ebed7bso56249945ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 18:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755567631; x=1756172431; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bLttyQpmtQ9ns5JcMBOEWKXtf65aFs4f20L8xnCqtm8=;
        b=YFXb/5Rf7oBPJ+f65jUrnJI6l6J7HzKiWofJpgJY60YxYY0T0tn2Lp+7xbPiblZpT1
         ukOUuq58jGtbb+5QjOv9jsA1FVJcj52yJccSC9XXVCjSBVpDXsf1U3VV3qpBbttz2X2W
         XX5eCAcBoafVt7JxQBjwQqDqxzYryIROyuRORb63rO8V3aExIENPZcdPRaSdMN1rnOlC
         cKOc+omwFumoURFhzM/vAYltH8QiY5O5s5CiD0lHPQiCsQcic/FSVfNjF13E+mf7Hm0q
         bHzd7jG9J2MlhfXAZqkhP4QW970PHltDtFQl2LxMZ09HKLWqvBxJ9Y6aMKyLvnZPXyS/
         UZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755567631; x=1756172431;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bLttyQpmtQ9ns5JcMBOEWKXtf65aFs4f20L8xnCqtm8=;
        b=iMahUUKL86EUi2+1BvG9P90YFrwzbJAOCkxRxSZUmPIFpgmpvuyTEMyw7PaeMxUbIr
         vYnfEdJW/bqqu7VquIkLfjNoxihR0gNkNZyRukF+qOi9tjCup7QIt1cQfww9SbVpsqJW
         SoE8L4t2QfufPTFHt+fdglftmSQnlV3IsQQUpJPrzGzMXma9Se/TpMGmFHEp18KDTar9
         BcpgRKk1DimejnUgIOHYcS2YXgf/okyh0F0pLjAeiCRCULrWCcv2CNvIYSxWV5mMoeXx
         7oOldBDsDl9rLn4cBrBx6sfmvfyMuTdLcd0iCvkZAqOvpgQr5IjiLg+hJxK/f9um177a
         PR1A==
X-Forwarded-Encrypted: i=1; AJvYcCV1ZRQu85DgvI/GUeMuum7Wm54jma3I5456VA+lNzyyi5mjSAlBq1dZ1bSvQ212A07HuvPtPHV0ZNf5yfbarCUh@vger.kernel.org
X-Gm-Message-State: AOJu0YyGKBEd52phOfxGAWHWxywqDWHjuptI5AIakK7QLQPXm4rNG2UA
	USld6VNUqLoV1Ey3w5aeqszF3sMgwgeS986699J6TFBykul22uPplaGaAGVqalv5E1wk/e2znhw
	KxR+lSgIMfQ==
X-Google-Smtp-Source: AGHT+IEBnLBRfX+O18qzMr8TEjJTaUqakya01MzrAg/MQihzbOmYI0CPTllurPyMzJs1Wj5L618BZe69bcdP
X-Received: from plwp11.prod.google.com ([2002:a17:903:248b:b0:235:ee71:80d5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:90f:b0:235:f091:11e5
 with SMTP id d9443c01a7336-245e0e98b88mr7165465ad.10.1755567631203; Mon, 18
 Aug 2025 18:40:31 -0700 (PDT)
Date: Mon, 18 Aug 2025 18:39:37 -0700
In-Reply-To: <20250819013941.209033-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819013941.209033-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819013941.209033-8-irogers@google.com>
Subject: [PATCH v10 07/11] perf python: Add evlist metrics function
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
Reviewed-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/python.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 48308ed4e1c7..31089f8e5519 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1303,6 +1303,33 @@ static PyObject *pyrf_evlist__all_cpus(struct pyrf_evlist *pevlist)
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
@@ -1531,6 +1558,12 @@ static PyMethodDef pyrf_evlist__methods[] = {
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
2.51.0.rc1.167.g924127e9c0-goog

