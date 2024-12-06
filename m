Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0378619644B
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Dec 2024 04:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733460045; cv=none; b=hhtoJ6CFdPjSDhMSYQLTXFpYMEp5XCqwLK5HgzJXFtTJ0BFHkP/1l9czd0JaTNKaWRUOHTU/3lrneFVZ/keOBpLG+KIpMyRznSJFXFUR12H6OgF3asUJAtqOzVL0BBv/wRou2laIwQi0o++OD4AwR+SKqQx0sHoSaWHRBnanpes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733460045; c=relaxed/simple;
	bh=l8qUIHya3K31WTRvVu1jv39b7mumPyblakLVFf0XyaY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=BqibnZ/16MqLhsXrLiVn3x6HBgOoMUphpZKYG5aREK6DniJvOeqceucJNCQsEeBS0Nnh7HnvcZSpybxuEIyWiRkcMJ3+sdFARXW1HQMsTBxHMa8wp8XQJNcquyGHJi2yQLa8ua/nm3qOylKZs1oM0cDui+ELijw9Brxn5uRyv6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1MuVUJKi; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1MuVUJKi"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e39f9a14448so1699259276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Dec 2024 20:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733460043; x=1734064843; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T/6KuZeoA9hfQ8w7qTpUnYSr+3QNWIClGfYo5QkRc1U=;
        b=1MuVUJKi5UrHeOEQC5WBonUv1rVreiVF+yrEXxIELhpNZHd91idgxwQPxOqD/yW+T4
         J9JMHpQCR6ZLg69nAIGFDv3Ce9CgvIe2V6Sc6ROWYIUyubZsGmeQofSZRzHEl693VASq
         ZAn6s1t+WUFQ706KlB3D3EOBrndssbXUvEB5tj1ckm0XZ6GqBSIud7L3CuMNTJOIydii
         GbfxRMGxWiLXdgU+w6zDSKnF4x5Hb4rsUdJypPrbeX454GblunC8ygRudeLw8xnYLujp
         y960TV0aKEVm+4P5gNjNXCEzSIfo2s7LAHAT0L1YX2obptG7PydxJYENWG9SIxCcK89E
         wVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733460043; x=1734064843;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/6KuZeoA9hfQ8w7qTpUnYSr+3QNWIClGfYo5QkRc1U=;
        b=TlGI2Cr/YzVvYxwv5c0noht8y3vY+GaNOZksM2/ELESQqqrGuj288OY7SdweHEtsUC
         LlDNZMDYStQwf0DbNThbKUKHjXJcLwocWFJ4Og6cdp2cwnhV55y+aMw4zCuJqHmHk36+
         yMcuYkPtUondiGZiuz1jf03EnvSFa/bVwCFxuO/m3Ff1tLSO8yQ0AlY/+DEgHHK4v7uU
         kJ+2cjnXYhNuYfOJ4CV8bBFaOFwWlF2xxoq8yxBq1aDJ8fQA12+gSxx/ZtLqNg3iFVVK
         A4Ap2U+sG2burZWEpqmeh1fqGSvbNxppGY+5BJ60qxieutvB9+eJvgcQmKx2teuJHaPD
         vXew==
X-Forwarded-Encrypted: i=1; AJvYcCWcuTw3l9jzvayDucLLU1oTBvYs80aX8xCasZjO1XDDcSyEPZpJU9GzJrDGRZO6GdH1mOyai6PwqrZnzvL3b5me@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6EqD4UbcAm2iqCOR/RwD8ppdpdYPfMTDhhVgiq4c3n+hAf/tm
	HskcOLTY/XjMMxA6j3te40roPDpF5dSu6gvwg6R45kbPItBWZmC4mq775MLxx9c0nbARxPYtBOX
	5ovSF6A==
X-Google-Smtp-Source: AGHT+IERX0y+SrjaaB6yLsinmWuyNnCNJB6CooagJGk19unTJTWsreDzrfz5zQi5ugSeemAO8BjhrdkKmd0f
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:eb75:393:2a8c:1440])
 (user=irogers job=sendgmr) by 2002:a25:fc1c:0:b0:e33:111b:c6a4 with SMTP id
 3f1490d57ef6-e3a0b073bbdmr734276.1.1733460042968; Thu, 05 Dec 2024 20:40:42
 -0800 (PST)
Date: Thu,  5 Dec 2024 20:40:29 -0800
In-Reply-To: <20241206044035.1062032-1-irogers@google.com>
Message-Id: <20241206044035.1062032-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206044035.1062032-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 2/8] perf cpumap: Reduce transitive dependencies on libperf MAX_NR_CPUS
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Kyle Meyer <kyle.meyer@hpe.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

libperf exposes MAX_NR_CPUS via
tools/lib/perf/include/internal/cpumap.h which is internal. The
preferred dependency should be the definition in
tools/perf/perf.h. Add the includes of perf.h so that MAX_NR_CPUS can
be hidden in libperf.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c | 1 +
 tools/perf/builtin-diff.c     | 1 +
 tools/perf/builtin-kwork.c    | 1 +
 tools/perf/builtin-mem.c      | 1 +
 tools/perf/builtin-sched.c    | 1 +
 tools/perf/util/kwork.h       | 1 +
 tools/perf/util/session.c     | 1 +
 tools/perf/util/svghelper.c   | 1 +
 8 files changed, 8 insertions(+)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index bb87e6e7687d..836ae0122dab 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -7,6 +7,7 @@
  * a histogram of results, along various sorting keys.
  */
 #include "builtin.h"
+#include "perf.h"
 
 #include "util/color.h"
 #include <linux/list.h>
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 82fb7773e03e..196969538e58 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -6,6 +6,7 @@
  * DSOs and symbol information, sort them and produce a diff.
  */
 #include "builtin.h"
+#include "perf.h"
 
 #include "util/debug.h"
 #include "util/event.h"
diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 8234410cba4c..233ca3c3895c 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -6,6 +6,7 @@
  */
 
 #include "builtin.h"
+#include "perf.h"
 
 #include "util/data.h"
 #include "util/evlist.h"
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 651188c1d825..99d5e1491a28 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -4,6 +4,7 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include "builtin.h"
+#include "perf.h"
 
 #include <subcmd/parse-options.h>
 #include "util/auxtrace.h"
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 7049c60ebf77..26ece6e9bfd1 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "builtin.h"
+#include "perf.h"
 #include "perf-sys.h"
 
 #include "util/cpumap.h"
diff --git a/tools/perf/util/kwork.h b/tools/perf/util/kwork.h
index 76fe2a821bcf..596595946a06 100644
--- a/tools/perf/util/kwork.h
+++ b/tools/perf/util/kwork.h
@@ -1,6 +1,7 @@
 #ifndef PERF_UTIL_KWORK_H
 #define PERF_UTIL_KWORK_H
 
+#include "perf.h"
 #include "util/tool.h"
 #include "util/time-utils.h"
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 507e6cba9545..c06e3020a976 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -37,6 +37,7 @@
 #include "arch/common.h"
 #include "units.h"
 #include "annotate.h"
+#include "perf.h"
 #include <internal/lib.h>
 
 static int perf_session__deliver_event(struct perf_session *session,
diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index 2b04f47f4db0..b1d259f590e9 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -21,6 +21,7 @@
 #include <perf/cpumap.h>
 
 #include "env.h"
+#include "perf.h"
 #include "svghelper.h"
 
 static u64 first_time, last_time;
-- 
2.47.0.338.g60cca15819-goog

