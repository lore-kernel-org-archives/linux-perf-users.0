Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD8320C026
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 22:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241890; cv=none; b=hE9vyP8dttrcDAp77oWEMmvTZDV2dAKWA2OkACSOvFgK0jDqWDiHqMexA4jRm2TUxCqTAHZDRhQLvfcZqhXc8d/bvxQbHJDWnG918NkNNZAWnP627Tc6nlOGaUaDy3TfrliOrXSSObfZjem4j1a8WQKyUQlk3E37mEbRZwrmZJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241890; c=relaxed/simple;
	bh=bgAMnten7yUv77lry4kHbLHEtlNNVxnv2bZhCLDu2bk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=CmHRxtdowWU715xRRQoCMGrEdzIGc8AtwrtXFhVdB9ov13Gek//y5//325UoNE9h4VaNBgba8+LwM+ZjmSiW+9aK6acUg/NjukMmQlqVzxCcb+tZNUbLIXMAScNP8GZRrIU3l2ERVsFxbDx+3qVVB1eK3HYqw2qXvRv0ppc3oVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HGft9Nfd; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGft9Nfd"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2939e25402so10434879276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 15:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730241886; x=1730846686; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dn03tO6yjk+hHI/uxx4ev1BNOlrfTOa71VTpKPW70Iw=;
        b=HGft9Nfd98oTkw4ke7KdjOGf1sLw+WmzDf5miRr4m87aOHnpLqh/4u7td+cC+CvbmZ
         rT33+nMOMu85KXB/8N594wZnhSnWIuaVpP9GoWRjTeHYVFa6I9RXa1DBQLZNzIqdmfhd
         mKZdethPBF/flhPSFJB533G/ZPaLlxKZfsG22vKOll4TQOihStPl1ewa9waTALUXfps8
         OhsIA7IZTM0CjbWfdKTqkB9alC1nIoWaMvQpsCaPWsMOqrQ6WZVELIMjXqMCAKfuDsbW
         rXTboAtoXzYQxxoWuDbB5jkmO8WW4apCi1SSX980la/PCSsxMFnq2TWJCsBD49K2l6Ki
         mNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730241886; x=1730846686;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dn03tO6yjk+hHI/uxx4ev1BNOlrfTOa71VTpKPW70Iw=;
        b=eExMN879plGRlA6zUv9IZhOJ+1kZ9X7SrwxsE/RgfDe+rgcqV8w/ZhfTC23mxxyq70
         WyIu8QuuCuzDmHcsygHB5sfzMiRXT2lTQkT05AzyiutbklhcxWkgLZPRGEJHbXoIDVsC
         zy/0rf2xECuuHuMa+SDzbfln/poUvdanw6Dw7MikGOk4+e/xZRU7to/GU9TxiVz6SY3I
         HL+Bxdt3Qm4HYPciohnrcOKkWaDc3tDEhEE+xs2PfPA2cct0NjTDvzaNnFWRYoyO1Sep
         5ac1st3SpMtNJ1ASOkkYU9q875xh2sGBVJyQPT8Lp+goEf6EJWYNnz66rvqJsRE0wB05
         ykXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB+BnaExSOymno8K7T42v05ppwQfNniwjmr7ZYJ8dRF/qlZyzOdBF4fl/Psp+02cC8QWb58avrqcwhsIKgBEeR@vger.kernel.org
X-Gm-Message-State: AOJu0YxPxY2yeEtASk5YRE331hMp2qqizQpPUhnE2TG3GlGXLNn/cPbB
	8R2WophCJQ7TEKmbxxLydqmLrtfSAh7GbaiyKoXfaB08h62puD5pW7VYvbXc/T8HSF/mCEl+pwe
	D+Lc3aQ==
X-Google-Smtp-Source: AGHT+IExA3JFVO57o5s1aC/oywbSW2IzrWYHiZ5NZUiXTsoJ3RexOTnxGKyv3IbKPCltwR6LNnBfyO+G729l
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8991:d3fd:38a7:c282])
 (user=irogers job=sendgmr) by 2002:a25:d80e:0:b0:e2e:3328:7a00 with SMTP id
 3f1490d57ef6-e3087a548eemr49327276.3.1730241885935; Tue, 29 Oct 2024 15:44:45
 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:44:16 -0700
In-Reply-To: <20241029224431.167623-1-irogers@google.com>
Message-Id: <20241029224431.167623-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029224431.167623-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 04/19] perf script: Move scripting_max_stack out of builtin
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

scripting_max_stack is used in util code which is linked into the
python module. Move the variable declaration to
util/trace-event-scripting.c to avoid conditional compilation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c             | 2 --
 tools/perf/util/python.c                | 2 --
 tools/perf/util/trace-event-scripting.c | 3 +++
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8c5d5cecfba4..ff30fe466189 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -92,8 +92,6 @@ static struct dlfilter		*dlfilter;
 static int			dlargc;
 static char			**dlargv;
 
-unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
-
 enum perf_output_field {
 	PERF_OUTPUT_COMM            = 1ULL << 0,
 	PERF_OUTPUT_TID             = 1ULL << 1,
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 974578a04099..298f43981fc5 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1306,8 +1306,6 @@ PyMODINIT_FUNC PyInit_perf(void)
 /* The following are stubs to avoid dragging in builtin-* objects. */
 /* TODO: move the code out of the builtin-* file into util. */
 
-unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
-
 bool kvm_entry_event(struct evsel *evsel __maybe_unused)
 {
 	return false;
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index bd0000300c77..8abb7a7b6888 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -16,9 +16,12 @@
 #include "debug.h"
 #include "trace-event.h"
 #include "evsel.h"
+#include <linux/perf_event.h>
 #include <linux/zalloc.h>
 #include "util/sample.h"
 
+unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
+
 struct scripting_context *scripting_context;
 
 void scripting_context__update(struct scripting_context *c,
-- 
2.47.0.163.g1226f6d8fa-goog

