Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED13719885F
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 06:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133149; cv=none; b=MR0nUagGi8d96H8hVqDHFXDGZweNn0v1q48V8QGQ9M7s60wobKJBOEJsWidMgcvlwegh8yOgZbFZ9sLO9WiIrh1Q2T92BFqiPeDucUvr3KXoGt9q5LPLCmDAh10DFZRe17la9XDvMBTvEpj/KSo7tn+oJzRlTKhAF0U31jChkKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133149; c=relaxed/simple;
	bh=lo8v/8lzKi2C37iCsrx8frWOHW56Z3pjRjxD2LGxcBk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=iOAVULEGtTNyeibsz8jJBDjy2DXZEEeYQSoInPSfqwhNNJCK2+uTvZcDEgRtVL1ke0LhOfmCWNnsGu4yiBsi5sSCXzHqPbrtqZ7Bqc5ChWg2Wkt8v8wt1Pbfl8MZd81WDp6/TVPesHb7xTJ+fnSDxL8PJB1uQyCc7f7QdaVX7X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I9FpMQe2; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I9FpMQe2"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2b9f2c6559so4455987276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 22:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133147; x=1731737947; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mcNbzzRS5VSvLqueZ2osfH4cEHyPpkywFOwBXdLSQFY=;
        b=I9FpMQe2pyHsb/CNCIjalnEQ1Zc3BEbSJ3vYug9zZSpT5zE0BVqBujrOxFAGyfwIS6
         3GPRVi0SI5uAhCr2Y61IzBmpuPo6Z1pF+3iBGiVHzNRUoJ8YqPaFJfCNLQZ4z/SqYSW/
         PNG5/ZP2d9gK7JAkYn0rhcIWy0wuWCEQrh0fSJ2DgB+iPiOmfxuOVfSrI3C8AXNVZ7Ef
         nEJY4ptMNEzx5TjpIDHwEXuE03f/tLChh7VfaSx0mrtOngVVX8ZmWlIO/uga4P66uwVJ
         P77nzC9NUa5Nta8vfGsn9oUZQxm77ZXSFlBi0TgtiFgZRdpuVgdpRIgZuz/sV9o56qQF
         Y1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133147; x=1731737947;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mcNbzzRS5VSvLqueZ2osfH4cEHyPpkywFOwBXdLSQFY=;
        b=bLk1HzbFoDfdu+pMqmzOV0CDO4mmEUICDSVu7YlfAPAEOV7IHe7ttbcvsjyK5PqJF/
         a+HCswXGZOYaYTfD6tRgYX3jv8x1XU/be6GaY+u8uZmtPq4D8b3fIF3cjIS1v82Cbnbu
         uyQyDzY3m6yTUFneWBczSvN7XW189r90I1H1ZeNI14g0s+xwhncWLI4E/H7Z9dglcNwx
         ols7bXG+MFXAvPGF82Hkrm0M5JdKhnTH4+TpbB2cf+4cKe8UeDtn4ySSLY9vOJr0fXZX
         u4HWEIPjV5cqc4y0kOKgpAWUmV24XT2yDDwKdIiDKSZAvTbHLP5gZLrqhlEwoNsU7/zv
         A5ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXs6T7Ymwvb7WEMLHrWwQ10gL6kqQIqabCzUkzRGccYCHm96cnfEqetfzwKOWZH+AZB7YW0Rwz0i4DQtjR4vDq+@vger.kernel.org
X-Gm-Message-State: AOJu0YxsX6Q7fVpiL5M3DuaJeP8U48dlgdDuzQd1QUbrZeyn0YbJZord
	qOzyTAOWlv91dUcvDq+8PcU3FOCCmawRpSI/sthuV3c/mL7vNEko/a3OX1XVh99i6KIiiOKCBtz
	nnA2mzQ==
X-Google-Smtp-Source: AGHT+IEKaG3zlJt89Q/3pdQFukKpZBajf0ZNkUqR0ExiOk8/EXoIs6qi0VEv8zHURZeQDLRlnyhNsZA6ER1Z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a25:3355:0:b0:e2b:cd96:67a6 with SMTP id
 3f1490d57ef6-e337f8c133dmr3846276.5.1731133146758; Fri, 08 Nov 2024 22:19:06
 -0800 (PST)
Date: Fri,  8 Nov 2024 22:18:07 -0800
In-Reply-To: <20241109061809.811922-1-irogers@google.com>
Message-Id: <20241109061809.811922-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 20/22] perf python: Add __str__ and __repr__ functions to evlist
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
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

This allows the values in the evlist to be shown in the REPL like:
```
Python 3.11.9 (main, Jun 19 2024, 00:38:48) [GCC 13.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import sys
>>> sys.path.insert(0,'/tmp/perf/python')
>>> import perf
>>> perf.parse_events('cycles,data_read')
evlist([cycles,uncore_imc_free_running_0/data_read/,uncore_imc_free_running_1/data_read/])
```

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 1a53a97c513d..a71bad3418da 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1069,6 +1069,30 @@ static PyObject *pyrf_evlist__item(PyObject *obj, Py_ssize_t i)
 	return Py_BuildValue("O", container_of(pos, struct pyrf_evsel, evsel));
 }
 
+static PyObject *pyrf_evlist__str(PyObject *self)
+{
+	struct pyrf_evlist *pevlist = (void *)self;
+	struct evsel *pos;
+	struct strbuf sb = STRBUF_INIT;
+	bool first = true;
+	PyObject *result;
+
+	strbuf_addstr(&sb, "evlist([");
+	evlist__for_each_entry(&pevlist->evlist, pos) {
+		if (!first)
+			strbuf_addch(&sb, ',');
+		if (!pos->pmu)
+			strbuf_addstr(&sb, evsel__name(pos));
+		else
+			strbuf_addf(&sb, "%s/%s/", pos->pmu->name, evsel__name(pos));
+		first = false;
+	}
+	strbuf_addstr(&sb, "])");
+	result = PyUnicode_FromString(sb.buf);
+	strbuf_release(&sb);
+	return result;
+}
+
 static PySequenceMethods pyrf_evlist__sequence_methods = {
 	.sq_length = pyrf_evlist__length,
 	.sq_item   = pyrf_evlist__item,
@@ -1086,6 +1110,8 @@ static PyTypeObject pyrf_evlist__type = {
 	.tp_doc		= pyrf_evlist__doc,
 	.tp_methods	= pyrf_evlist__methods,
 	.tp_init	= (initproc)pyrf_evlist__init,
+	.tp_repr        = pyrf_evlist__str,
+	.tp_str         = pyrf_evlist__str,
 };
 
 static int pyrf_evlist__setup_types(void)
-- 
2.47.0.277.g8800431eea-goog

