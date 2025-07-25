Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F4E25F980
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469563; cv=none; b=QFzJtGm9QObQyQbLcbzd82bkztNmFisKRNp6gEY8o6OTGl/mHht93i09izNyywyrocDUcnibYAiemTkJMSzxjGUO/XWRkBkVBam7HKzTwiNv5ZrNFwdoNH5Cr5D4D+6VRlwA2E9CK5q0HeLGi+UJTaxGgi4cuXYWXKg0zqKkDi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469563; c=relaxed/simple;
	bh=sw0V4tcRM8nzystS/ROnWaYm14K4bPEjZplUBiHrm0g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LUBDtfC6TRAWts1u5V4aPU+UQf23ZHXEyQdaGpd+SuOZaiu4RwxLAdBvkJGH9J78xTjf92gc9gdzHaf4pNjQbh76w0VHWWzvTaihnyFBo9rJodyglJEhu0FqlDoffI4Y5PChFdK/+tBZY0sKw6FuoEMRhoZBf/mLlOaiJcoXkic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eF1EMMLg; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eF1EMMLg"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-236725af87fso37534875ad.3
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 11:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753469561; x=1754074361; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n8OCFhwd2lpx54kVyZvp/cazm5hu5rf3uGrxE8ojG60=;
        b=eF1EMMLgbiLvmarRKF4rscuH4xTaEwN2p6TGd9yjMjTAYe0sa9bpBkhwQmipU51jdV
         4rsTfKK6hiM0fMiuzuJCoeE42pEODIF2fotoukdUpVxJqAp4yRhXeSlZyuXghT+QS0ok
         ER3XGN95aaWwQifmaR8ycqEq4EEW1hi/n1BXY66f/Tf+SmTtEs8tI7Y9DHBr6HTLr+Zs
         QPm0XdBOqo90kOLAWv+W+m/D0ymWsIjZ3tokmlhGv/WFlS5rhG+58cwNLYEAWpkht9Fi
         CumGp6ClwdVSqJwyHGpyfzNaBR2PCFnFGbT8cYwJ1FJfcEHq1TbYjHXMmXWPFwZpRsoV
         dOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753469561; x=1754074361;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8OCFhwd2lpx54kVyZvp/cazm5hu5rf3uGrxE8ojG60=;
        b=O0KaBQnwnAsqQOKcdb7j9ACltkJedcgbdtHZcP01w2q3vDFBELVH8q8rUYyvx/atWM
         4I1tO/StE7IkKdVgAimJJM/lBuEhZ6bpDkyuxN1Y/Zr/sM6PSJFHe0zwOpDo36y46OID
         V1UNbfUraeN18zy4u+P9O+2tN9jvWKk1XhEfJSVNy2SxpVcW4F0Vu1ilR8OTJHmBgKP0
         fOrqz64XqcUTtGHtiyqwNK1nqMxVrFqm+/EUKAbNC1FXUNlXZl9mTaAOLCltmsj5i/gZ
         Ysa3+vk3B9C+KBND4qOgjEMF0Ql38lTFn+3FAGsYmoHyqEBvGKeunN22GCAl1IhDw/Jk
         O9GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRDIcZRjix+L98jAzUzE3wr03BOLqH1bhMwxgTfZA2P4sGiRudew4ttxpMlOypeEf7DohOTSOKKNAOrMTquakt@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs7EW1KCLATcOChShLdux8c+KyyPYiVJVEHWRu0gM+Q0IhWelx
	Th/2QzhKe4z6fQp0mzx9eJTkmHhdUOh7CaV00/xXq2bj2gZu5hNxQ/Rs/+ZF8xelA3lTQ2BSzQB
	Ug8ewX7Ho+w==
X-Google-Smtp-Source: AGHT+IF2ZIMzOsjNBNx9unpLBTRWdC7TZPOx60ZBUCd1CXeGH6I+54LnIHrGuSFf5hW0ofiA4wyBjbLySQ4T
X-Received: from plbkt8.prod.google.com ([2002:a17:903:888:b0:23d:d2e9:8861])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:240f:b0:236:8df9:ab38
 with SMTP id d9443c01a7336-23fb31456fbmr51818505ad.34.1753469561246; Fri, 25
 Jul 2025 11:52:41 -0700 (PDT)
Date: Fri, 25 Jul 2025 11:51:59 -0700
In-Reply-To: <20250725185202.68671-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725185202.68671-1-irogers@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250725185202.68671-14-irogers@google.com>
Subject: [PATCH v9 13/16] perf python: Add evlist metrics function
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
2.50.1.552.g942d659e1b-goog

