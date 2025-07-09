Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2713125C82E
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Jul 2025 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097254; cv=none; b=pqkZfQ5YSKH6GeiiR+5qke2aIFGRamMVD+g8RNkjyOYBPuVqX8rO+Mx9dEtYcfipn9r7uG9yNHK0c4P+IeJmSg7VCIl1JW1J64BtsycsimyiTCQ50GM5KEG66Uy6ugtJAv3y3neFqs27qoywin+iSjMxdz7UVLRjaaMwKEGtol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097254; c=relaxed/simple;
	bh=S3yRMHiJp63Z3sa35dQZZnYodURgDAIos+timRoWgfo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=J1sFokLYzjHFPH7VHsLdNeiZMFFQZjJNdQvA6vzsRFJcRMR8rxAYwmGwk2w2V+bIO8mUVpKA9oLnJhwvO0VH8hZG9RrOOU5h5zMiKJhn3ba5LWcdm2KUvTHaZBEbNuXfxKvs16jJfLUYu92wklsqirVmfF5QsvqMY6O369Pl5eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p2/+vNdi; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p2/+vNdi"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b31ff607527so249844a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Jul 2025 14:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752097252; x=1752702052; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ah0+wkOLh0SfnYMJxPVvQJg73AT2FFx/KryIhqiVcI4=;
        b=p2/+vNdiFF1ScDWAvzuaEWKFbLT0cPrtWaUvoZunRoRGqke1KS907gZVn5/CgQizma
         UBaYCF6Pm7pqCKO8W+uEl7A3MhvH24XskV8Z4+EjZKI9DlS/AdqRDlwU7RQNVS5AX48N
         FhuU8yraFrx+tW+xhg214tNW4+9qIXqYTK21m7y/drAzQAjiOXn6H9BUhxb+84JC+oGj
         BhNLhQx0k2SqFmZ/H+XRHSukryEmxOsPj6WmwIJ+dtzSq0afskwo+5rY3dui5YvBfEVU
         Y+p9Z+iFdERQrk9Q2HfR4BFV7vJ05Ya92TFKKPFtcCNYi8vCXlaZludAemAYlhJKKWYl
         Byew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097252; x=1752702052;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ah0+wkOLh0SfnYMJxPVvQJg73AT2FFx/KryIhqiVcI4=;
        b=tyZBe3sxAWRsEv7pIegeMRsS49Svxccyur9SBhzMsDxvZ9YZy78PQtzd0zrV0dkiFn
         G+Sw/pDVmTWzqdRyj0KN+bCzxfNJHRwEzhzdNJ5jVtnVpFsimOutW+1bB4+CLwDJbFFC
         i6RvaQ4K5C1wIkzQu0EpeUdG1U9Q3/eF9hhOqImUkncsam74YyXMBP3U125k2X7mhmeG
         Exlg26zQTIX24Ln1QSmVCPpYvH1CPr/fbRlx45foeAtwvESk8CFyc4nQUZ4dfh6a1gDK
         7Fknjsp2MnrDv7qBntbjgW7O4FB67qQvmjfiYGGYykKlLR1zwwd3wlB20X6WAaxVqilk
         /eGA==
X-Forwarded-Encrypted: i=1; AJvYcCVdFoPZsLTZzJUNKF5qIbyNN9fyyqOxN+sEvxhETXWIl6AOb2lOEB7BUDCF6asgJ7bdo5SMCn0XptFq7kTDuA4i@vger.kernel.org
X-Gm-Message-State: AOJu0YxPLjxaDKPw0joPyYNHKPivAsgn+a4gi6/JU2t5CLzQ71++geR+
	K0cTwcZC53WboT5j2i8bzeo5HxDov78hQ87r1ezeHM77PCMQ3plcnoTWfDZZDpvxCOk6XpKjbQH
	1Sj5e0pCQHg==
X-Google-Smtp-Source: AGHT+IE3bMTEiaAvZjwECwHqvmNwTimZoOEIqLX76Q+VxD1c2+r6Vimd0Q4OgbRb6fCXgT+dFIOu6fecErrE
X-Received: from pgae25.prod.google.com ([2002:a63:3719:0:b0:b2f:1e09:528b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9188:b0:1f5:7eee:bb10
 with SMTP id adf61e73a8af0-23003de3380mr346052637.8.1752097252483; Wed, 09
 Jul 2025 14:40:52 -0700 (PDT)
Date: Wed,  9 Jul 2025 14:40:26 -0700
In-Reply-To: <20250709214029.1769089-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709214029.1769089-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709214029.1769089-10-irogers@google.com>
Subject: [PATCH v1 09/12] perf python: In str(evsel) use the evsel__pmu_name helper
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The evsel__pmu_name helper will internally use evsel__find_pmu that
handles legacy events, extended types, etc. in determining a PMU and
will provide a better value than just trying to access the PMU's name
directly as the PMU may not have been computed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index b5ee9f7a4662..0821205b1aaa 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -925,10 +925,7 @@ static PyObject *pyrf_evsel__str(PyObject *self)
 	struct pyrf_evsel *pevsel = (void *)self;
 	struct evsel *evsel = &pevsel->evsel;
 
-	if (!evsel->pmu)
-		return PyUnicode_FromFormat("evsel(%s)", evsel__name(evsel));
-
-	return PyUnicode_FromFormat("evsel(%s/%s/)", evsel->pmu->name, evsel__name(evsel));
+	return PyUnicode_FromFormat("evsel(%s/%s/)", evsel__pmu_name(evsel), evsel__name(evsel));
 }
 
 static PyMethodDef pyrf_evsel__methods[] = {
-- 
2.50.0.727.gbf7dc18ff4-goog

