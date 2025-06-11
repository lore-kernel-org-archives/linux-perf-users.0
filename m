Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA4A224B08
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 03:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749613580; cv=none; b=n2pK8m7TTzZySMO4wk4mELR+JR+iX2kDipi0ANGHvGAtjr+48qCgshbzF6nRgccuJJKw6lAY9Wc31oxugpUepKOTu9nXhxwge6C5j1sjzuq2j7DNl/ldnE6yXXIsBSCeej7enmI7aNDlr9jeB7sX1GYVUrB1610Pc3s/eh23sjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749613580; c=relaxed/simple;
	bh=d1DekuT4b+RpmHHw8+0cV96WV12ZXy4R3fduBzB7g5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ZLnlWI6WJlr9QePCCxa4eb/w9mQXOUANIKhajsdPDe6DN+IH+qqF2FTdhvfiOo6i+jtxBGT9jvjt5+5tDKVtL2yoafAA7rQy5T++zX6M1vzi72nqMN28H3RBK5AKrnyGmwbuei10we1GNyYN+3ae7XubYaIbF1O3OuMrcxQfOVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eUwcktBf; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eUwcktBf"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-234fedd3e51so55357015ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Jun 2025 20:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749613578; x=1750218378; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oTVLN6IxdloaWx8kgCQ0wDt7X84NOVop+ZW7Gi+fQHw=;
        b=eUwcktBfTjUJnVMp8XMGX6Wx2OAAvIQH3hskuGNAUEU1DbUx/xYPKn0iDJQctjbDgq
         QgbuIzIlYi8LHBzODtD252oR/bY8qYTjnnqhLQ/2EEQIUaRaE1FKDnaG6sfcf3LfFUbc
         qCb9IeVlTliDujUgZWIfXJxLOqJnvA2iASEZWBfGXimpg4rWNOd15Ljh9MJUZAduIRNG
         JglaD/v9NJhjspr8g5nNLNQtk27b6BzffkvmW9h6it+rwgVutUGHvumV4afpWlqbkRsM
         NFW2A9MG+F5zK42fuDqw2r5+o7pTW6JARsf4/yCs1sp+TUHjK7364z+zFHp5B1dlq1i6
         BKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749613578; x=1750218378;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oTVLN6IxdloaWx8kgCQ0wDt7X84NOVop+ZW7Gi+fQHw=;
        b=bo2l1CGaY0tfTEuzv7ELhMVAc3KXc7vRBhwGoWzv7flKNUhPYwi7t26UMc7PZI7xHh
         3Jxa7JsIL8DT3ZLFxkdkCba1Sm1V4o2wwQKuIBxc1G1FDWrhoqMnPET5VawdBTuAQkGz
         5yAEmrSU0Az/lvQ/J5x2bu1y2RRG7G6P15N8Gx8CA6tB2PZ7lCeF6mvvC7QG5AC1wX65
         VGbmUPGip5oom2YNQe/faH0SkovBei7b4ROTVVPDKoM2iiOICVJ7jD9kpAsJCeZFrEpQ
         DTuYU0HJ+99x0qa/2Devrm4fdCuE25fmPYQPA6ju29GIERCYPiaAvXROnDgH7Av3irTY
         dXJg==
X-Forwarded-Encrypted: i=1; AJvYcCXaKPzb1RNWi4Ad1ZnR0DiPna+8tvuPV3hbIV1geH3PmP1splh7d8rHRM7R0xM1aV95fxoPH6rQrXDLODrIBWgI@vger.kernel.org
X-Gm-Message-State: AOJu0YzV2qdOETpJewu/kZzQmqwCYB7cyHIhG8/PFoBZ9SQPWVeNqccP
	WlxNRyxWNFzGcVjjEWy6mOixDzEzi+1aZrBwvRGEwEHxexffV/r2FPf47meXI6AnU9NwHW55Z9q
	Mqa1py35u9A==
X-Google-Smtp-Source: AGHT+IGSJgxA1iCXoAQG6NxNIRILvjbosK7Sjd9nbn9uBjPLyroUJZd0wkV7a7NAm7Rr+yI+dwb8Go+aAlDU
X-Received: from pgct5.prod.google.com ([2002:a05:6a02:5285:b0:b2c:4a89:4b36])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2985:b0:235:2ac3:51f2
 with SMTP id d9443c01a7336-236426a858emr17252575ad.45.1749613578271; Tue, 10
 Jun 2025 20:46:18 -0700 (PDT)
Date: Tue, 10 Jun 2025 20:45:18 -0700
In-Reply-To: <20250611034529.508842-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611034529.508842-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611034529.508842-5-irogers@google.com>
Subject: [PATCH v1 04/15] perf python: Fix thread check in pyrf_evsel__read
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The CPU index is incorrectly checked rather than the thread index.

Fixes: 739621f65702 ("perf python: Add evsel read method")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 49e1db3feb87..b724478fe34a 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -909,7 +909,7 @@ static PyObject *pyrf_evsel__read(struct pyrf_evsel *pevsel,
 		return NULL;
 	}
 	thread_idx = perf_thread_map__idx(evsel->core.threads, thread);
-	if (cpu_idx < 0) {
+	if (thread_idx < 0) {
 		PyErr_Format(PyExc_TypeError, "Thread %d is not part of evsel's threads",
 			     thread);
 		return NULL;
-- 
2.50.0.rc0.642.g800a2b2222-goog

