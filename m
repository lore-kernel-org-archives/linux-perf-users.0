Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3840220C00E
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 22:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241922; cv=none; b=MjJDfUzSm+NG19Bc7gmSkvdD7pvYrEyThqCuFGmDdze4JQvARuLjG3oZSl0cqr/bLN8VaAHs4I1feWGH6CESsmsTRzEafxgWP87qTX0WwswNEIQxzUDwB22YbIYYfGkbJvpGy412aHB9Vn2mQwCPmYHIUs/qFLALxwJ7YieL+mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241922; c=relaxed/simple;
	bh=/jY2Cqs+V3l7u/rQt+XOfsCTPd6q/qZBAn7EK80i8Ms=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Co0FLHNApUD3HigXdmX3RvHWomus2VwiEnYsDm0nxJOAUvli5r9/U2syTcdIaJgXe0nnBqIlQnvOOxUcIQV9akNOKNpDUd+H8E+XbYUZ+A10dRqByas+CPp181XEfCRkAqnrRhvVNBGQx9/XEoM4cW1cCSv8iuugiuBjyHux49U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a6XqIUOq; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a6XqIUOq"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e307c375d36so8075986276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 15:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730241919; x=1730846719; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IhmE2mCwcXnI6RxZJjd/8LP8gD2HSvEYfpFi71K4cps=;
        b=a6XqIUOqzKP/XV0jY1oWePOGAb6Mea78tL0+Dr6neLM0gJjlIM7cJZawP1C6ocWjDm
         WUfQ6vE9rFxFe4ejyCzhD1dWoKBAK74JsAFZKlJ0rfi8TJo/druO3PpOH6ojY28eR+fT
         zNQk/1ifr/Nzau4GFRobzfPaE0lO5G0IYViwhcbPBq584CqcvHe3Q1iPSliCaxVzCQmr
         EOIYu6InjZe4osTrGLTA42VjCrbd+dRbWDXJNXMkKS+0LBe8WgxOEyXMxEN83TElOT7F
         bDkhtRn9M35K+JFdentZIFbDKYJEsmwfZafu0uvQWFIZIa/oxyHkLgvGy4hDtJR4XM6k
         uVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730241919; x=1730846719;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IhmE2mCwcXnI6RxZJjd/8LP8gD2HSvEYfpFi71K4cps=;
        b=FTY95uVjeGSrdC73Epsc1V1Bt6YN6ufNBaskoN9GdmTYz+EwLrDExkkBiFFbabPEdO
         nI7vMmelK7OLyz0sm9U6KlaRCHU5zootD8T9AZAQZNovy1ZmA1n7m0rf6K/1GkOycjRB
         /i/Z7OZoh2kWSTrhTF95sUSH76YSATrCxjsZOL0m3yXZgHAIcvlm8pfliPX9sk/Tz+0t
         szWl0ZIuQcweZfLKBSt1SoDSyL8kOyWEdplC0U7fSmHIg/S0QGBQtDQm/QxM2yP2DKTL
         qxbucdP3JLE17AVyKRGId8CRK/yXPR5uZmVJSJRJgOXhj8g7tcY+94vHLZLek5eWQsrm
         sU5A==
X-Forwarded-Encrypted: i=1; AJvYcCUSo4iQ3oYkBy5ucDaSCt/l3SUFlKfmA0/GTdwexwpgKQBWQ6IK6N5dZKZ8BzlTS8NoypM4Dn/u2ue371h9Aq4A@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0fGLLDJI2Keo1K2a5LO+zrqrEw1JzXGw3HeW2Y0Nhd016eriQ
	Q/jcN5zbPP38b2I/A0v240IIVz6QHOxPUR4X5gWO6WZYIQbwPTwQ2rt7EVvHIMhxYbr/GZu3AIy
	+9DvtMg==
X-Google-Smtp-Source: AGHT+IEiwTyu3FXtnESAFQEUBUGxhe21zhV1ho+p/YYW5zq+ZRw72RrLe0MyZ5+jU5pdkeqoFDMgoTSLuJw4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8991:d3fd:38a7:c282])
 (user=irogers job=sendgmr) by 2002:a25:e04e:0:b0:e30:cd7e:c0b5 with SMTP id
 3f1490d57ef6-e30cd7ec150mr1471276.3.1730241919095; Tue, 29 Oct 2024 15:45:19
 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:44:30 -0700
In-Reply-To: <20241029224431.167623-1-irogers@google.com>
Message-Id: <20241029224431.167623-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029224431.167623-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 18/19] perf python: Add __str__ and __repr__ functions to evsel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This allows evsel to be shown in the REPL like:
```
Python 3.11.9 (main, Jun 19 2024, 00:38:48) [GCC 13.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import sys
>>> sys.path.insert(0, '/tmp/perf/python')
>>> import perf
>>> x=perf.parse_events('cycles,data_read')
>>> print(x)
evlist([cycles,uncore_imc_free_running_0/data_read/,uncore_imc_free_running_1/data_read/])
>>> x[0]
evsel(cycles)
>>> x[1]
evsel(uncore_imc_free_running_0/data_read/)
>>> x[2]
evsel(uncore_imc_free_running_1/data_read/)
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index a71bad3418da..0d71ec673aa3 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -781,6 +781,17 @@ static PyObject *pyrf_evsel__open(struct pyrf_evsel *pevsel,
 	return Py_None;
 }
 
+static PyObject *pyrf_evsel__str(PyObject *self)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+	struct evsel *evsel = &pevsel->evsel;
+
+	if (!evsel->pmu)
+		return PyUnicode_FromFormat("evsel(%s)", evsel__name(evsel));
+
+	return PyUnicode_FromFormat("evsel(%s/%s/)", evsel->pmu->name, evsel__name(evsel));
+}
+
 static PyMethodDef pyrf_evsel__methods[] = {
 	{
 		.ml_name  = "open",
@@ -802,6 +813,8 @@ static PyTypeObject pyrf_evsel__type = {
 	.tp_doc		= pyrf_evsel__doc,
 	.tp_methods	= pyrf_evsel__methods,
 	.tp_init	= (initproc)pyrf_evsel__init,
+	.tp_str         = pyrf_evsel__str,
+	.tp_repr        = pyrf_evsel__str,
 };
 
 static int pyrf_evsel__setup_types(void)
-- 
2.47.0.163.g1226f6d8fa-goog

