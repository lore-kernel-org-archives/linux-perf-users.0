Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C98153565
	for <linux-perf-users@vger.kernel.org>; Thu, 31 Oct 2024 01:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339044; cv=none; b=RzGRvBjCeMuNocpsfexiEEcU7W0txkM2dmlASLF9O4VSE3m2vNQ5QfcaLYlJE0d1wmxuNQs9A/CGFQ8IbK39u4VUDeD5GFA5XT5yeaZFIwAclT1ymiXagrHjg/cIoWfrsXegWk3k0bv3OuR/JfG15zU9by7C2x5DuioKWXEzj3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339044; c=relaxed/simple;
	bh=/jY2Cqs+V3l7u/rQt+XOfsCTPd6q/qZBAn7EK80i8Ms=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=i3tNvPRJ8z8e4qd+0cDFXIc9vaDxzvzbrWHyWhGufJnIOCrOIOiWJo1xWVZovI2k5e5Mw4Ufh1bPQsblCM1FWEY+IQzFS/kuUsdr0Vy+GBv+dXsa5qOZVcqi4UQkMeDXbZ55B61UWJtfcm7m1pTQFR+JgfyGjAGSwutY6DHj9V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uFWuYjKi; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uFWuYjKi"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30ceaa5feeso810342276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2024 18:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730339042; x=1730943842; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IhmE2mCwcXnI6RxZJjd/8LP8gD2HSvEYfpFi71K4cps=;
        b=uFWuYjKi+9TY6reK+N2hr8K688jrrr3aEacNcGGTYY6KCqqvJ2pq9EBje6j4sxS2S5
         DPTTlZv7BgHNjMe5RwVh+mZrU6BGdTV9vCLuRfhvDp4ZvcGSG595k4uJWsCDcLwbaZ1f
         vYyYBnDNUYsi9f8Z661HGGQsLYrENyu8bdYF5TloqdcM1YVpAkQIXdV1HVqSwmb/mRmQ
         rLK/wNDm5/6224DtdNXoxk2uQkNvbkq1aMTWBXUCOHDxIDCXepoIwGgMRrb8c8iHeAl4
         9G0N6boWxBxZKxp4R7P/U2dzgcFKi8mppTnJwzDRHnh6qrao9f/jeyOhRyifWdAPH4fr
         xhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730339042; x=1730943842;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IhmE2mCwcXnI6RxZJjd/8LP8gD2HSvEYfpFi71K4cps=;
        b=WCB4O3le51bwTqTK5c/swfcH2JDmXu/s5vWbePnvPNrCR14AN6/67xbR+7/CDjS5vz
         qnHP3iIM4PoZ9QVEHy3Mc/UT1QKmaQZc3poxSKbK+IhpXnIDvVnyR9aC5hthgCIfoJLu
         UcXuAiOE90JN1JBmi1rn1oJAjD3vrjSckDlZbneTZXTmUudl+fePQUyudojMjBeOoqKs
         zlb599NKqVbdWXktc3hExY47A0PK9g1ie+6rrFNf57/Mha+1g9S9IvbGbOMaMW91stik
         tswvcMkqagWXNfl7SnCgvPlSAcJLRmONfdx/1CTwyYCXgfVQz5KYdR8mvgzb/4n4o2EC
         U0qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbmfgJVJq9pNjKcH2+hjDiN4vO3KP367qx2BB2eFSjTesx5Bny6CDx7Oczuq+muDGkzeED8KBjpJSr1ENuo/NT@vger.kernel.org
X-Gm-Message-State: AOJu0YzVU+/Rv1FF3BsoV2J/sT2JPRReGU2vMCuqqClCTGiEq8uE8KJw
	DMT71kvtosaRupTo6FJMo+FYj+6pvAP7Gikm8Ev5QuB9Yf6uYzWHALiQ1u7IvVwSBWxlpv7zYtd
	p4eIPhQ==
X-Google-Smtp-Source: AGHT+IF2Wm48yp/1f9MpiKy0f92BjyDlsHyY5mBiiVL4GOvoDikO9Kah6FK8W1kPcElcsptW0C0VK9sCKWiY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ad0f:67e7:f1a6:84c4])
 (user=irogers job=sendgmr) by 2002:a05:6902:531:b0:e22:3aea:6eb5 with SMTP id
 3f1490d57ef6-e3087be9610mr62129276.7.1730339042077; Wed, 30 Oct 2024 18:44:02
 -0700 (PDT)
Date: Wed, 30 Oct 2024 18:42:51 -0700
In-Reply-To: <20241031014252.753588-1-irogers@google.com>
Message-Id: <20241031014252.753588-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 20/21] perf python: Add __str__ and __repr__ functions to evsel
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
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
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

