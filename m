Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443E31993B2
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 01:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979118; cv=none; b=uAbScVlvSM+GT4plcddbIQUtucEvtRmewEWg5Bw2gjGoQ+DG3c2iGN2fogt9KhNh6CJsJbBPte82QijeGN37ozhg258hbCLmArnOwwjGclRxDbt0qoMz9jZGylAeJVkY0DlCh74drK95gNKewHUXlfw7X30Z4AGWZexSYkouGaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979118; c=relaxed/simple;
	bh=1/uQjVUHeicVOsHf6JAkjbXnJL4QBfvJdjKE/VYq2Hg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=fJNZcLXREaFukv9Fp6uMFd8jHdLV5RYEVaWrRA+L+bWo2+Y1rcDaU4086H0WKJPyliXHsV3VHhRRS+IKWO9LsWj4ZfeCuIS9ouJ4+T3heWhDRdiQaKioHY93LEBGYiHiCpHcs2K6hLOlur8/qjHp+Xuy73VEQlyXIEhtSOFhYiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Natkp/kE; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Natkp/kE"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02fff66a83so4511531276.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 17:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731979115; x=1732583915; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MEXus1VjTmWCZL7mZtlARX6uzWRhwXwnNIhwzEO1AVg=;
        b=Natkp/kE8Dmhqggeb6AEydmCmUZgTOw2lX5mvAZR0q5od587mzi2ZaVtdOgSU3hqxQ
         mHJ8e/BjQ9r0W3zSFKV0VeUydXLBGzqbj2ng8vhUX+CqBSw4i9l1QhawLgJy/D1Q0Hie
         3AMiRGymkQRzrTjLkiCkZ0gyXazFsb5rMKQ4E8njB3aFxk6WCJVaafLZ5RwOU+vCrge/
         isk5VVI3HWOUFB8h1zIGuU6g4fVap/Bu33boE50H0wn9EJxZCKvrHO1mbN/RMgMRNiL4
         c0WP7hb7RZdUy6Qw8KaFIasOsFN7n5wnYNheiJ69EoCC2hhCiUR54GDLARxVI014QuFk
         fsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979115; x=1732583915;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MEXus1VjTmWCZL7mZtlARX6uzWRhwXwnNIhwzEO1AVg=;
        b=V5IWIyYZmzGw+6L2UvLHIkZEO3BzC6oHicVWrvFxKPFyu/uSzo0buFj0QGsZ31mqED
         tf0ZGu7eCcK9l5oD7BkUBrcuvyEffD2cdZ0/J/Yj9mw8u+wnfwLfei6M4TrRgkT/awoR
         BdUVyWRT16g+MwGyavcKKHYiwJM3yf96ryZdTG5tdk/s/BNDdPlUJICotUglmEqUu1v0
         0W311WrEVpC9JTAHrWhxei0Qea1ZA2SqfEBa4m1+LxykbkoXHYCcO8k3NniDu0n/XiMa
         +0nFUrrrMDbll+GQ2KkUfjcEfHhGNPZLS8MHkRwNGUWRlshHlWUcLceu8FlxvXmSX6+W
         IrCw==
X-Forwarded-Encrypted: i=1; AJvYcCXpDbZjqq/QDAB90gjtxNgr79N/jysxEmTA51We8AAak5LZ2q2LHPtctFfIaLHFsmlTL4YtPvvkXpUggpHqoDPK@vger.kernel.org
X-Gm-Message-State: AOJu0YzkRuvPZTS9+nyQXyEQVeGqP+bApoRaQKzSa8X3tyldAoMbrD9p
	P7z0+gO672QcKul4tFdHR900sZ4Q/dyG9WSEUimhcP4jwcMmSntNzEVV8Hh1VIc9S5zjRQGv92C
	2oJj+uw==
X-Google-Smtp-Source: AGHT+IE0l/lVCzoB/5F9kgHVNu1aiAHNnvrmyEJm8D2E0OtwOFxbGmgFNGiM7iavdjs0oCGKa1aaFQLcNqOp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a25:d092:0:b0:e2b:cd96:67a6 with SMTP id
 3f1490d57ef6-e38263954femr9475276.5.1731979115075; Mon, 18 Nov 2024 17:18:35
 -0800 (PST)
Date: Mon, 18 Nov 2024 17:16:43 -0800
In-Reply-To: <20241119011644.971342-1-irogers@google.com>
Message-Id: <20241119011644.971342-22-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119011644.971342-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v7 21/22] perf python: Add __str__ and __repr__ functions to evsel
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
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index c556cbc582ae..893aa4185c03 100644
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
2.47.0.338.g60cca15819-goog

