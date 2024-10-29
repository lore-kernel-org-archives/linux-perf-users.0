Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D97C20FA96
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 22:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241924; cv=none; b=nOjfihCQBq1i9wlPuKtQCxVz+buvAtqZTKqug6tD2MRDL7IFeNX3jjMu+ekBzpWVLdiaaaR8JvxDtjlCmgTt4khFtiHZKQmCzQvFEpjr7vB7DGpZ0Wy34PhNGklxx6KgsuEnp17KmLft1mdljkyjyRDaPfROlfudubRKew1xa8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241924; c=relaxed/simple;
	bh=RYBqniKAr0HDr9QavuDpVba3HWcJbNfezQsIwVzha5U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=p4GUxezGGWxT6VGMp5J8DAY+5rDJSkLBgUjMppU1dUg+wZlz77/0ctsBjyiSGILcWSFxb00iDSx42UuNlAw/xm29ReSuFsQZuOkOe9/H9C+P7ADpse63BPNdKAmYHaxWflkwUQ8W+WKCeoT294wxwKsC2rMakP1HRg0QGqLIj6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YMdwHvK4; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YMdwHvK4"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e24a31ad88aso8863792276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 15:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730241921; x=1730846721; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XAPItomQeEHLPhkkwn1yLotANahBFAs02uwcMpYu9h4=;
        b=YMdwHvK4cu7zDl4efOaJaGJLGxdCtsvRB4kNMFppq9wv7PsSam6clvJtLwaeOHZZjB
         xnhjRUtWBseUotqpxRpP8oh8uYUETfWKKOA2w92Potm+JEAIn3HISz6ObitxePinJHeF
         YXUsB3clNhfyu1gjCy5ChyH/D3wa+PlMzIBxl7ueCOAqz8fSlPie3F9ootTEDAWquhDb
         GaxcA58mZ3evYhw7aC6oMDOBFSTY0nS1qXc1lkv//JMNhI9j1p7X+JSIHIVzVFgjA7eA
         11Z+b7Y9726vNBMJ5s6gZwakWNOHAoRVEuIUkaGpmomkve1+jargZl4SwAFPXCDgYWqA
         8djg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730241921; x=1730846721;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XAPItomQeEHLPhkkwn1yLotANahBFAs02uwcMpYu9h4=;
        b=AKRMxXr9g/QwPh1iec1FtNhgijadvEPdwdqBe/Eg11pFIzK1oXENkqj4HDrKLkugm1
         Yb7j61NIa1wGKDLPiKHI2r5odYkbf7i7vJJeso877/+IQHm3olm2zFx4SzfFPQiX3eyf
         5A5XmazFmfFeDwpKU+knqbreV8ky1b/bUuMmUmmH5+1v7ZQfjD2Yt2kfGGLm/fFS1O0E
         xNEqmAyFibw9aY8RGp7zIptrWxc1w9PCT+uTpqKmRv5cUq3l6OkJpyUpQcg8Pc9hW6Gy
         gaID9CTbtwHxqauqpEBgMK2SrKCQic9CjaYjS37GBFjQUgEr8hBcaP1eMgb1khhTCSuT
         XRsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi6m3Mdv+RANqR90t6z/JTrR2nJtwUdCs2ELBbOcQsUziIX8W+Pd1sbhkSXRqB7nrqVvhCRDj+XRJx5QfGhp/h@vger.kernel.org
X-Gm-Message-State: AOJu0YyoPCXIsM/4FBakKe/iAhDgmkuxX13m9YADCffNXhwQc8u0jxgQ
	a+O2YLqgf3bwPRTRN4xjgQswrUGygLqnKi1LlteXyEQnw1Yvfxg8ShvTYKJk+MpnJPp9fiEVvrf
	GvT4ySQ==
X-Google-Smtp-Source: AGHT+IHjq9xY7rwYPlkiyef9KSLjkmkqOtnvQiFEzFzKfn6tQMOtFng+3YAEfFlHM7RYYXpf4xW/4PrJmeHq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8991:d3fd:38a7:c282])
 (user=irogers job=sendgmr) by 2002:a05:6902:3297:b0:e2e:2e79:207c with SMTP
 id 3f1490d57ef6-e3087728d56mr12242276.0.1730241921523; Tue, 29 Oct 2024
 15:45:21 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:44:31 -0700
In-Reply-To: <20241029224431.167623-1-irogers@google.com>
Message-Id: <20241029224431.167623-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029224431.167623-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 19/19] perf python: Correctly throw IndexError
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

Correctly throw IndexError for out-of-bound accesses to evlist:
```
Python 3.11.9 (main, Jun 19 2024, 00:38:48) [GCC 13.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import sys
>>> sys.path.insert(0, '/tmp/perf/python')
>>> import perf
>>> x=perf.parse_events('cycles')
>>> print(x)
evlist([cycles])
>>> x[2]
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
IndexError: Index out of range
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 0d71ec673aa3..25114dcadd21 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1071,8 +1071,10 @@ static PyObject *pyrf_evlist__item(PyObject *obj, Py_ssize_t i)
 	struct pyrf_evlist *pevlist = (void *)obj;
 	struct evsel *pos;
 
-	if (i >= pevlist->evlist.core.nr_entries)
+	if (i >= pevlist->evlist.core.nr_entries) {
+		PyErr_SetString(PyExc_IndexError, "Index out of range");
 		return NULL;
+	}
 
 	evlist__for_each_entry(&pevlist->evlist, pos) {
 		if (i-- == 0)
-- 
2.47.0.163.g1226f6d8fa-goog

