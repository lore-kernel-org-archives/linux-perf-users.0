Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DB21DF967
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Nov 2024 07:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730963775; cv=none; b=qbSlbciG/8Gxd+Bxnra3FJTvZpKarB5aw51wmEzFt0hWdjd0c5rxOXaRdqIt8FJ566GVORX+foi+mKkM2/H+mPW7JD3jI9u4uK6z6OLLjhCurCTceXwgro8vwiYB+U8OHKBLmvgzbQhYPiEAJ+A7EMI88QVWIyKPOusxL4eEqz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730963775; c=relaxed/simple;
	bh=Y+vKqYUCxSTt4LSzTKZWPT5tUEvVlBLoT2ItWD2c1T0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=FGQeFdx4FdaqXyw5TjhpA97Rs7rDLH17ZNoChAQmn3ipt5W86EAESySaA605/tg/kSC4Fz0hekAxlYEEdJqQ4Mex0xJYJLtwPWbxuVIENKbHLdb0oXR/j87ONg3SEmdkuZQJgtMJwzem3vVzYUwKsH+xJ01I1jD5mpGnLnuaADM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2L0//W6C; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2L0//W6C"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea7c5805ccso11355417b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Nov 2024 23:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730963772; x=1731568572; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0JtSX1ivElzP67Gy896L9Ack6oYznxDX7izzc96bZIU=;
        b=2L0//W6C6v6WJQ9QtLDCW3jCP59/rGYz1ugpp7IhRfoHPSn4DbG7JZKu9JPnULVy5t
         yPWsfuoiJUb1M+C/fB32qB8ZqasoL7Wqv+3YFMTGovON5SmGhwOgpzDqaL9sqsHquEhs
         nxjlAiA/GLm7GV/1RJMo4YyEtvc5n1zD62IVupUzrKcHEEpGsRlpq0dF4DoAIIiwW6x3
         wzMnop52jfYj18sSUzIzesFekizChz7n07m2V7MpoA81tyRbHIlKERh11C4CfOpvPqSR
         +mujjZTKAg7DYXpI02vC2snegUutLUI4AxmEY7SYR4l6NTOk4BuUbtgQYFA04kNWbfTF
         cIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730963772; x=1731568572;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0JtSX1ivElzP67Gy896L9Ack6oYznxDX7izzc96bZIU=;
        b=TNXlX8f0e7iIQyXMwb+u0K0BVvumoWTqVovsznEElei/CkUskO4SY3BD5MB237WPTK
         QuZnJ4vFh6DZP2soZ0dRYm8UVLfQM3xJJQ9a1mT1wWki0lj1OVW/Kq/5LqL94h3onE5W
         BscRhxuv7KgZkjNOVtzJ6K3HIx+7tJxvnMRxzzBsMVjTInfwioqacogFqYYC1LUMaTrN
         wPWf6slYa36eE7Z8SFFDXmWwR5ig48Qpt7hCTleR2a2uCDZCaspS+hOhhVsope/in9q7
         Gk8v9dDYCP34fx8ubemJoe401DIL+7KThFIcSCLri13xuDBRpVzQHOqgALHOHcz1DVVK
         AM5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2cRm7qEsBklNwJ9nTOeSUsmYE3vvpB52r1kxvCKvaTOgSZf9l6ihy2ZA4zB4D0zhXXFXAzNnQLbfBHjHW3eHB@vger.kernel.org
X-Gm-Message-State: AOJu0YwqgYaooVfvFLkExxQA32lpdQj7mI1Q9+4piHs6JKuondWDLdrj
	7dVu9hxH57ifSWhCyL84U9IXmCfGZcnrcYzcvvw+JiMzbCUIXcOCp++wo0BpZKwN7WSyPuOK7Qf
	7tZZg/Q==
X-Google-Smtp-Source: AGHT+IHo4j7jX9RyogLzkobNcoqsPX4PHdOeTPc0u8XD0m/LH7jjhm2PFEQw7af1FfiKXF3NPlnJLAyyNQZP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc7:bda:7167:18d8])
 (user=irogers job=sendgmr) by 2002:a05:690c:60c6:b0:6ea:71c3:6cc3 with SMTP
 id 00721157ae682-6ead60ddc27mr1107b3.8.1730963772515; Wed, 06 Nov 2024
 23:16:12 -0800 (PST)
Date: Wed,  6 Nov 2024 23:15:57 -0800
In-Reply-To: <20241107071600.9082-1-irogers@google.com>
Message-Id: <20241107071600.9082-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107071600.9082-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v1 4/7] perf header: Avoid transitive PMU includes
From: Ian Rogers <irogers@google.com>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ben Zong-You Xie <ben717@andestech.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Dima Kogan <dima@secretsauce.net>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Currently satisfied via header.h. Note, pmu.h includes parse-events.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c       | 2 ++
 tools/perf/util/env.c         | 1 +
 tools/perf/util/probe-event.c | 1 +
 3 files changed, 4 insertions(+)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index e3aa9d4fcf3a..d60f1ac1d720 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -4,6 +4,8 @@
 #include "util/expr.h"
 #include "util/hashmap.h"
 #include "util/header.h"
+#include "util/pmu.h"
+#include "util/pmus.h"
 #include "util/smt.h"
 #include "tests.h"
 #include <math.h>
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 93cabdd7ff43..e2843ca2edd9 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -12,6 +12,7 @@
 #include <sys/utsname.h>
 #include <stdlib.h>
 #include <string.h>
+#include "pmu.h"
 #include "pmus.h"
 #include "strbuf.h"
 #include "trace/beauty/beauty.h"
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a580aa2cd512..d399c7e03341 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -40,6 +40,7 @@
 #include "session.h"
 #include "string2.h"
 #include "strbuf.h"
+#include "parse-events.h"
 
 #include <subcmd/pager.h>
 #include <linux/ctype.h>
-- 
2.47.0.199.ga7371fff76-goog

