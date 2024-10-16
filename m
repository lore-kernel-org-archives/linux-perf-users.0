Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBD31B3923
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 04:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729052713; cv=none; b=uYI+woJnR1oze7sJkg0dvCnDyTR8NJEa6ruj5Ts9W93NRXB+mu/xYhwvKpyLYFwbOqSAvuoA7VXTLn+mmbiXh1+tMhL0zs0xzEsM+kyTM8nDxKX+ug9/0EdsxWSthHXcDiWx0af9dKpMTw/cdsjQqdTSsmagqGIU3SEBLUsRGWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729052713; c=relaxed/simple;
	bh=YTJsvsOE8a25R1DD/RA8PVQLNC4Uq1qBnyneB6eRW0g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=n8zGrV0FAumXAzcf58H9hXW3mwVREB6xzn8L+T8DfkVuzBQ5bINiFG6zPNDOTsSeuk0bRfrS/YPnVzc2tidpQTcoHZ/+Cxg+ga+R3loB5kjgdq8x5sYPo7LJENX6uiobkhvd4aB+K7risCvG2OTGkgTv/oJFnLUf5a26utnoWu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2QOvH27j; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2QOvH27j"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e376aa4586so58379977b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 21:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729052711; x=1729657511; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hqYrLnfi6pZq/dyjCorwIaw7kfTRCdabnWEBnJH4emk=;
        b=2QOvH27juX3O1CUWCYYRMXX63kUlQW+wG/6I08/H4Qnu1YZxB5TgWDHdNKPemN4//I
         9iAMI4pQdbrIGDvUHxHkuz3spcdON6iQNtU2ch4Wgrrg8eTn0p92vZHa67g7Ch83JrUP
         SSbAP9DHR/0vFD6ShuIoWZYinJw5yTUW639WYUYT4mB5ZIhUYgGGHcRF9p6U9ckxYSqE
         SXhzNn8snQJOFt3ogz/5jNpH0CeGwfdPRQQLnQ35RLXSR1phAS9MT7rxD7E8+q+pEK9q
         a1d+UWXwfATn7Mfm39dFHXnjxsIrNx/FvaAmODOkl1dq4sruJ2AzW/AkDiN9RzsP2erR
         V5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729052711; x=1729657511;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hqYrLnfi6pZq/dyjCorwIaw7kfTRCdabnWEBnJH4emk=;
        b=jp5k2rC7yXhJW2BcSATL3KNKJnSyrzPcJxCktLPfM4p4UbU8JahQZAV1lyeakgUr77
         Sd4mGSfBe6kLDP4FoVeLjwradaoe4Qyk7hpoNTE91StN/cfK704QhUsDjBXBC3eZFgmm
         g7S3k6wfQHFJ+RKeM8WjafrEn+hv1SZA90DgQCzrcEeD/6AxhLEgTAMaBFW3fvTYshnB
         FnCZ/wRbkFK7CKjA7UOZTekvvioX8wXA34M3JQUvMX8/xbr4lonaMT2kSYEj9DxcwBfX
         aCJ2pkKSjHTcFDHaP5cGdHnOJPrlRUfKHjmhOutjoAoRSOYIv/Iwjj70fRT5eTr6qZOO
         Ph0A==
X-Forwarded-Encrypted: i=1; AJvYcCWjuVvWdIF82Ro8e/aLEudoaNcwCOfzO3MSJXKQX4wocrON+uWHmaNhir1xmmmeR8aGK7QBLBxr3tOUdIcqPhFE@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2c9IUB+rsBmhF+Z/B4l+IpoUV+pkZCM48JEBhSMi1XtcqwYNS
	Ym+4UL7uQZe0KjmAIyj1nI2YOwaFIbPhRLDtIv625sjVhkrSzOp6CynPsp7s68+eIaK/F3bK/sZ
	+X85QtA==
X-Google-Smtp-Source: AGHT+IGPhS0PoOQUoVyeqB2Lwq/bFZXE1TdnwJnJCsevOVA+4Nsjgul44oYsbPNu44WV2uFZF8Ik9X8Hed4D
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:690c:3610:b0:6e3:3407:8575 with SMTP
 id 00721157ae682-6e3d41e809bmr691907b3.8.1729052711513; Tue, 15 Oct 2024
 21:25:11 -0700 (PDT)
Date: Tue, 15 Oct 2024 21:24:15 -0700
In-Reply-To: <20241016042415.7552-1-irogers@google.com>
Message-Id: <20241016042415.7552-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016042415.7552-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 16/16] perf python: Add parse_events function
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
2.47.0.rc1.288.g06298d1525-goog

