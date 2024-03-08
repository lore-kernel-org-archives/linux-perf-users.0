Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCC4182BB
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Mar 2024 00:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709857189; cv=none; b=cZxPYkR+XPtnP9aqs5w0deG3MOG+RHB6zcb98iZNmSlQQ6tyraN/TCK1KRXO9vcO+kEWxq3fCJmAHod/OHVYJXKTBsiImUvFNnB02zQ4OBmIkoa98e9R/Fuls6oIQSB7vMAMcTq/z8ZLqJHLP3sot5GL9bcF//MIK2CVIdmySAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709857189; c=relaxed/simple;
	bh=qRbM4J1nMnCOTtjpsDerekpdTUM2CRL3YgboxCf8VXI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=THcflBY6x+QXh6Zy2ZzCmT3INq1AHYZua0dq30FfBkr7ZVHYRVTjB7a3oR3T05+PxhUtpdKsb8VN2ewtwnus9bFzKdvZsPThouw/g7CUYELhDbLZPHsTQtGruXGX4gGkQw+1WtIAR01iEEiSGYJuXCfcW6PsLDP9eZNy/UStVcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nFTx2lMC; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nFTx2lMC"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609d95434daso26549127b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Mar 2024 16:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709857187; x=1710461987; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WnCRzMIwEmUWcP4taw0TGh+kO0P1YkAyutoR+GaoeIk=;
        b=nFTx2lMCMk0ii5Y9Sv12Do9RxicDmi34+BWvgqM0YHYQQhjS8cXXkeiN0RXQm/xAMx
         WcP1aV/hHjz+7MY5VQHZ4zeA9QDKJHUVoThebsxyC6/uyqHfT68WBU1zEX7R/+vDbp19
         t0aXfNr45ZPMZtgfVLiOFN+/Eyavi1bh/ZbEaQTkFbRUS3LlW8WzcX5gJluS+gbZwa+F
         8i671RQvmhd3nBfaJ8wJjXyg0ZglbaDAx0ev7H55qOOlSSmyKtlE4Nxg8sCuJRssSCB7
         UQEibIvaCnaCV+g3V4BUa+rjqkcscjHBIrSToVwUgLdX9CfZ4q00UQYIB+zdVFnn3MqQ
         wMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709857187; x=1710461987;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WnCRzMIwEmUWcP4taw0TGh+kO0P1YkAyutoR+GaoeIk=;
        b=n1dh2FP595Qf7gLLJ2YZlMmWjl0PTebBJ5kNcIAunnsHxHH0i9q1trRdpU3E4iee7n
         mqGkr/F+FH8DY2yMomk9QSM2qd0wPGIIe6TVdeHZbun+FtZMfB4VUvJ9Ju7uOcmb8+Xp
         yZhRuQZcX4FE4BElTDQMsk0AChkW0qAgIP2mt6vGUJLSvKD2uZFF83tAK1qBMHcpuR1z
         mHUxdRNT7l78cIESYrBRf6RS2ROqBmQsffWrkfCih2T0/uaUtAfrEFaSbZ7lU/9ubqeB
         SiUatBylX5D93fhXqRkmPjzY7wJW+lEsW542xMMzgNtET6bZxivClZxx6BmhHP941otZ
         PUhg==
X-Forwarded-Encrypted: i=1; AJvYcCXmKQ7aqSm8CE6VLS05UqSWN7IKoSVIKuXiPars5MkGz9d3rbLmDUnEr8ka/+oetVMNufoH41QvEI94jRqrkkn8Npab6blvJ5fSwYcZhtlxxA==
X-Gm-Message-State: AOJu0YxHGxmAG8O5IsreZCeX7xgoXqhusitHHGObz/ZMQ6U8XRhZsgZg
	32iPdF72+cxMDDc8vwt6LWJYsgCsazQ024tdWLJDYJRJn/0BWiIc6HhG41QqPqPI3BwQxX3y3L/
	Al/Ragg==
X-Google-Smtp-Source: AGHT+IHJCTyaNqBxaTLU14hVtz+CLHQZ93ZrH5zbxunYvvExtWwXEhrwq/UeDgTB3Xlg6ocZjXgQewrFG8Hr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:218f:92ee:d543:c1a2])
 (user=irogers job=sendgmr) by 2002:a0d:e643:0:b0:609:fbb4:3076 with SMTP id
 p64-20020a0de643000000b00609fbb43076mr598138ywe.3.1709857186828; Thu, 07 Mar
 2024 16:19:46 -0800 (PST)
Date: Thu,  7 Mar 2024 16:19:14 -0800
In-Reply-To: <20240308001915.4060155-1-irogers@google.com>
Message-Id: <20240308001915.4060155-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240308001915.4060155-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 5/6] perf tools: Use pmus to describe type from attribute
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When dumping a perf_event_attr, use pmus to find the PMU and its name
by the type number. This allows dynamically added PMUs to be described.

Before:
```
$ perf stat -vv -e data_read true
...
perf_event_attr:
  type                             24
  size                             136
  config                           0x20ff
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  exclude_guest                    1
...
```

After:
```
$ perf stat -vv -e data_read true
...
perf_event_attr:
  type                             24 (uncore_imc_free_running_0)
  size                             136
  config                           0x20ff
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  exclude_guest                    1
...
```

However, it also means that when we have a PMU name we prefer it to a
hard coded name:

Before:
```
$ perf stat -vv -e faults true
...
perf_event_attr:
  type                             1 (PERF_TYPE_SOFTWARE)
  size                             136
  config                           0x2 (PERF_COUNT_SW_PAGE_FAULTS)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
...
```

After:
```
$ perf stat -vv -e faults true
...
perf_event_attr:
  type                             1 (software)
  size                             136
  config                           0x2 (PERF_COUNT_SW_PAGE_FAULTS)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
...
```

It feels more consistent to do this, rather than only prefer a PMU
name when a hard coded name isn't available.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/perf_event_attr_fprintf.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 8f04d3b7f3ec..29e66835da3a 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -7,6 +7,8 @@
 #include <linux/types.h>
 #include <linux/perf_event.h>
 #include "util/evsel_fprintf.h"
+#include "util/pmu.h"
+#include "util/pmus.h"
 #include "trace-event.h"
 
 struct bit_names {
@@ -75,9 +77,12 @@ static void __p_read_format(char *buf, size_t size, u64 value)
 }
 
 #define ENUM_ID_TO_STR_CASE(x) case x: return (#x);
-static const char *stringify_perf_type_id(u64 value)
+static const char *stringify_perf_type_id(struct perf_pmu *pmu, u32 type)
 {
-	switch (value) {
+	if (pmu)
+		return pmu->name;
+
+	switch (type) {
 	ENUM_ID_TO_STR_CASE(PERF_TYPE_HARDWARE)
 	ENUM_ID_TO_STR_CASE(PERF_TYPE_SOFTWARE)
 	ENUM_ID_TO_STR_CASE(PERF_TYPE_TRACEPOINT)
@@ -175,9 +180,9 @@ do {								\
 #define print_id_unsigned(_s)	PRINT_ID(_s, "%"PRIu64)
 #define print_id_hex(_s)	PRINT_ID(_s, "%#"PRIx64)
 
-static void __p_type_id(char *buf, size_t size, u64 value)
+static void __p_type_id(struct perf_pmu *pmu, char *buf, size_t size, u64 value)
 {
-	print_id_unsigned(stringify_perf_type_id(value));
+	print_id_unsigned(stringify_perf_type_id(pmu, value));
 }
 
 static void __p_config_hw_id(char *buf, size_t size, u64 value)
@@ -246,7 +251,7 @@ static void __p_config_id(char *buf, size_t size, u32 type, u64 value)
 #define p_sample_type(val)	__p_sample_type(buf, BUF_SIZE, val)
 #define p_branch_sample_type(val) __p_branch_sample_type(buf, BUF_SIZE, val)
 #define p_read_format(val)	__p_read_format(buf, BUF_SIZE, val)
-#define p_type_id(val)		__p_type_id(buf, BUF_SIZE, val)
+#define p_type_id(val)		__p_type_id(pmu, buf, BUF_SIZE, val)
 #define p_config_id(val)	__p_config_id(buf, BUF_SIZE, attr->type, val)
 
 #define PRINT_ATTRn(_n, _f, _p, _a)			\
@@ -262,6 +267,7 @@ do {							\
 int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 			     attr__fprintf_f attr__fprintf, void *priv)
 {
+	struct perf_pmu *pmu = perf_pmus__find_by_type(attr->type);
 	char buf[BUF_SIZE];
 	int ret = 0;
 
-- 
2.44.0.278.ge034bb2e1d-goog

