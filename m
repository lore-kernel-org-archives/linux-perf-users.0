Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD391C9DEA
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 17:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618289; cv=none; b=Gb8WnQmNGvLNjcgLpuHLm4T5ZmAFw/e6X2BMcDfzXw5fCwRvPPFW5SMuHfICGMXj0/rpwJc3bYhBrSZ55rcZA5JiGnjWjSFnRTS4LQ9oDrpqUBV/ojxmyVgB4GYy76dLMTzQjq6MieXor4oV9WdiFy2kuRZZTmE0cgtifT5GY7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618289; c=relaxed/simple;
	bh=uf+pqZIq59zWUrhBXlbY8/wph3KVNlWL4TVWGoXzUW4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=knS6i3MS9/dxbPGUaowPguGQWnl2yWRVTdAFXUHIqLWkgstUzjRMEz4ZUB/5PrbvAYFI+KXfM06uKSG1ih8g5jilhjlbbfw1OH14qZBtaaspHkexZvXV2vsxuMMZggubFQpfxaSwYPnQ1I28EOhu+rfFZV8yzz8DfbI2b1VYkCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wkATsuC4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wkATsuC4"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2bd09d2505so5484787276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 10:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729618287; x=1730223087; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4RCKTfa55Bgazupu7nQwlQJBbYx0nTCBpL94lBi/7F4=;
        b=wkATsuC4dwNJxwGu0MHucKw42b6iqQ+QYNdG0nVfmsI2ZowDc9+1JK2MhqHQtBH+NP
         9+p+gPl03ngmSjW0b9rJXgFk67JGUcWkDvJBNWidYtORk1i1vybqDXaK6JysctB3p6f3
         7QhIPrbPvB/56OCkiTnig+t6BUD4HWsjphmnnTN/NJ0H+T9qE82h3QyIEjB8u4wDRvXv
         TmQQzzLY1LoimL7k62XqxZdvVuYe1DJdcQnUWug3TnoxaZBbgRHfY5Ao2eh66lQJA7C8
         b6hmgTVTezXrRsPkaTjMMlOKuHgCtF8d2II8PcVUjaeD3Bqfa+RmFImFK/uhx+r6fYiu
         ZW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618287; x=1730223087;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4RCKTfa55Bgazupu7nQwlQJBbYx0nTCBpL94lBi/7F4=;
        b=FBXdCB06EY2LY0Lb6zKymk+MLYeKKPqC1vMiWlUXTj+vPdR95zYWK3aHdNqVeeA3wY
         zZjv2iHKRaS2LjpNIUC3cJ2IdihiwnTWZ6XJg8f3pyHOO1FFwtoORBYB3nQWxqqMl67y
         Qh6oL/lcwKikLWSZrnJ2a9eghgDas+jLkyVcWFpKK+eUwuueJP7OcaEsI0wjfMW5Pg8x
         0L9uMCbe7xNWFIMgYVhVTIfdpm3hXddJt8sIWl+6+w5qqMCTOgicSB3emW78vxVjcCUI
         cUZfz0+uRmvFpxMtAWsqWkqJhHMh9xG6BLiqRWo1v+kT8u/+vyIEKcnzMXQWh0+gPTDS
         cZIg==
X-Forwarded-Encrypted: i=1; AJvYcCVpnkdfMFmzpG2OtTBbNGxBvDbvDjIAU95GdpX+O/C8D4UIwnjhD4npxip8OaVm2ZHMnnXrwbE+wY7sokqAdUZV@vger.kernel.org
X-Gm-Message-State: AOJu0YyGFY9rQiF4zeo9zLU1LYPugzYJ+gYsb5qZvYkUoztfnerQgcjd
	xdgTt2D8pgpdNRCvYosQldDHqu2HXKkgaOdK/hKGS3iKoy2gXOWzOBeiiXoyUK1B/BBPqVCfnGw
	Tflz9Tw==
X-Google-Smtp-Source: AGHT+IELK1cabkM9jyDLWipM07rBPcwjibrm8lK+0QxhvWjalP/V3OW1tr82/CblTbowpRmugUTYhUZLFi7Y
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:57ba:88e0:aaf6:282])
 (user=irogers job=sendgmr) by 2002:a25:d350:0:b0:e28:fc1b:66bb with SMTP id
 3f1490d57ef6-e2bb158a800mr8674276.6.1729618286412; Tue, 22 Oct 2024 10:31:26
 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:30:14 -0700
In-Reply-To: <20241022173015.437550-1-irogers@google.com>
Message-Id: <20241022173015.437550-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022173015.437550-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v3 16/16] perf python: Add parse_events function
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

Add basic parse_events function that takes a string and returns an
evlist.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 6e2ff0076daa..ec37f887db43 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1201,6 +1201,30 @@ static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
 #endif // HAVE_LIBTRACEEVENT
 }
 
+static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
+{
+	const char *input;
+	struct pyrf_evlist *pevlist;
+	struct parse_events_error err;
+
+	if (!PyArg_ParseTuple(args, "s", &input))
+		return NULL;
+
+	pevlist = PyObject_New(struct pyrf_evlist, &pyrf_evlist__type);
+	if (!pevlist)
+		return NULL;
+
+	parse_events_error__init(&err);
+	memset(&pevlist->evlist, 0, sizeof(pevlist->evlist));
+	evlist__init(&pevlist->evlist, NULL, NULL);
+	if (parse_events(&pevlist->evlist, input, &err)) {
+		parse_events_error__print(&err, input);
+		PyErr_SetFromErrno(PyExc_OSError);
+		return NULL;
+	}
+	return (PyObject *)pevlist;
+}
+
 static PyMethodDef perf__methods[] = {
 	{
 		.ml_name  = "tracepoint",
@@ -1208,6 +1232,12 @@ static PyMethodDef perf__methods[] = {
 		.ml_flags = METH_VARARGS | METH_KEYWORDS,
 		.ml_doc	  = PyDoc_STR("Get tracepoint config.")
 	},
+	{
+		.ml_name  = "parse_events",
+		.ml_meth  = (PyCFunction) pyrf__parse_events,
+		.ml_flags = METH_VARARGS,
+		.ml_doc	  = PyDoc_STR("Parse a string of events and return an evlist.")
+	},
 	{ .ml_name = NULL, }
 };
 
-- 
2.47.0.163.g1226f6d8fa-goog

