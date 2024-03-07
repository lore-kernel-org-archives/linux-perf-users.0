Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669AC133408
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Mar 2024 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833237; cv=none; b=UR5XGemV8VSmRYy7B+uauJ8z6XjiZR4FccEpCtXonNNLyVyU/p5/rOC3zS5/5JoA5uVz506NBpdSH2IixjIumcty+tNHDtfTSkounaSKPpjCmEu1xRopHKlxKT4/4a9Ym1zYW//32JrLmzKJL8kRGA9zePLePUvHD3WEbwxmtsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833237; c=relaxed/simple;
	bh=qRbM4J1nMnCOTtjpsDerekpdTUM2CRL3YgboxCf8VXI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Qg4nE++aLIKBS25lNuP3JgItYvjwpYcfCTlvTspOxm/g9e6h+rsypF6bxCTiKWczeep+X44AmDLGiReL6fc7oMTzzh85/Hz26uTVObEiIChxoD6oMobjVuOMEXa+aAYhyMgFZX1dqckfmNdTnvBBGt8qYSMZtV6o+09b0157zBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mUHzOig9; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mUHzOig9"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf216080f5so50937276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Mar 2024 09:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709833234; x=1710438034; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WnCRzMIwEmUWcP4taw0TGh+kO0P1YkAyutoR+GaoeIk=;
        b=mUHzOig98qznQjWKBadckcenh3qg3aKvQVTDtj/TVY0/C4fjjSlciDtKP8P1qw6l0D
         aoUZZ4R3kzQdlTnxbc32Yts/30FCEeJRV4joc4KGIKXaov/E0noIR7KfR8+FVB7pcx3p
         Ip7v2O3ahgWvzvO5Hd8/acMn80Z1PvM0fKiXcv+hdRke2cyxR8nCP4teH1kU9oZJyd32
         eDSkG6d8Aheu8RJIPuxhTOk0UZ2y8BisL/kLQHgqB4WwSMXXSRorxZaQLNppp/oK6lPi
         McCHTJgMmTnmhhLcm1UYIOPHWZsqlfR0OvJUYQ46R8F9Ng6JkMnHitkoSbcQUvrcE+zD
         CIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709833234; x=1710438034;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WnCRzMIwEmUWcP4taw0TGh+kO0P1YkAyutoR+GaoeIk=;
        b=S4tFjFStnDIAhTuTifakjeqt1XWDBa4mvnWmyAaq0y1oBGlfJBPC7r8Lr7mGkiZ2I8
         ZogO4XB97B2R1cJINE2QLpbVd/e40CJf6JXJY2dnaONtM39Vf/R6KapqHAyWBzt9jeyM
         4Y53GSRD+m411l8OE0qpmiu3PWWm2mj6orCBhlw1dSVIqfc8WWslL1EATHHESH1+dIUu
         b9r45OMEvEsKDe4cylOAM1PvyI595P0GfZKgB3dJu3CZeZddTVLxkwc9Ar4vEy78gTuk
         Hd5M7RqnBWBnfa08LGMHdhYAmbX3soyE4it9f3nt1Wm4C0NpMWQZ9SZ+UyMy5zpIhDl+
         JF7w==
X-Forwarded-Encrypted: i=1; AJvYcCXhhcTk82E9wkJu8HK5hNmaor+vzxsD2NETLhQxWs92KhMwu7LauudGqnKWbrtgkJqHld4bT1O4HTDIW7hLUbS+WuN7JQX3PAA5PcG0DO5gAQ==
X-Gm-Message-State: AOJu0YzONCPg1mLcLPrybgcjm6eJ3/SWbtFwot/xs2Y0uKWrL8gMIYdu
	kfv/OaZxc7uWBsCNd1rPyTZSymdy9zdamPSwgLo225Uev/x6KkaUOt76hpZXjseRdU9tvR7PuvZ
	ygQ5acg==
X-Google-Smtp-Source: AGHT+IEhh6Kp6uBn3S698WNWsAUPCqlRZBKy0FEY2SEfrml6jP5P0/i9mnZTMpgvkkcp7d7UPnOxJpU2jx1u
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:47d6:1de1:237a:6728])
 (user=irogers job=sendgmr) by 2002:a25:abad:0:b0:dcb:abcc:62be with SMTP id
 v42-20020a25abad000000b00dcbabcc62bemr4788790ybi.6.1709833234407; Thu, 07 Mar
 2024 09:40:34 -0800 (PST)
Date: Thu,  7 Mar 2024 09:39:54 -0800
In-Reply-To: <20240307173955.3982040-1-irogers@google.com>
Message-Id: <20240307173955.3982040-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307173955.3982040-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 5/6] perf tools: Use pmus to describe type from attribute
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

