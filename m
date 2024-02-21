Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798B33A8C8
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Feb 2024 03:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708486941; cv=none; b=Aj96yawNj76vFBR1gJn/WT8IgxpE1v2JMRhUptdxOuHJt2bsCcZrw50hUO5RPqFwLHZ/otQzBbKg949/cOjIXp6M1W5lsXfniAHnT1g/7Wwj6wdarSuBwgmt1MTrXMSjsx3GmafZIUj6lAPjEiC8VuWqNUxachIAhzUpaa3nfGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708486941; c=relaxed/simple;
	bh=I+UE93RRTXaqRw/ye3XEqbtXPztsO4QkZJrrM8rzem4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=sGI9rUIJN2i1r6LsRIkrMZnimFZnDuQkIgohp/TEkUJpJqzWGLXEY7o+c5fepzO0mhQFMuoO6dr2CwBsvp1NAPD+FLzz73g+ETdnJ9sF43EzlaoB5MeSBqtFmbV86u3WyGqIUXAX4GpNPGLJ7YijQZu/6wKyBCgfX1ZzFEO7awI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G7s7dV87; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G7s7dV87"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608835a1febso1769497b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Feb 2024 19:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708486934; x=1709091734; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BDoXWFUllq5r9qvxHaqqdOtetQC7wmYhYSm0N03NFTM=;
        b=G7s7dV87iO7rxKFJv9uTv0T1850IFJiqgrvwCcDPdq0FC+X0wep23+WCGp0dPGoVbM
         01jMp13UL+SxmzadnLAuXPcPAeBtizvqRdz/5i2kLfbU4g2EoOP3RXgIHxfiRnMT9sHX
         gJqY6toDXfXHwLqtY52TdO/m5vzeuTXF4RJMzo5lp6JDykqY5FSE+ZqkXauIpG4AEFG4
         6ceRYgOHwcESECTb15RJ6Q/L7z9iOsKbjSaANfEw069U42R/qfk4Z9P+mKI+i5uelsgA
         edgVtFCit60f9F8yUdJyfqifUhJssCpu+G5RHjlXAbPkK235MPWTnSiuIfAJEHsAEDlb
         3mYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708486934; x=1709091734;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDoXWFUllq5r9qvxHaqqdOtetQC7wmYhYSm0N03NFTM=;
        b=P9y132JWjMDjd+fBgcSYPiNZEUCXudI1hhNixhvgVz7DwBhhAo17k/gWkikU2dmcLh
         ycihYgbWDLjjnJO26PYqWDmet3PHmQb7RQgOAgwi/mWjwv3WtPi2TGDxrGC92325H5AC
         ihnkhGXABcbp0UdonTzlI7fWPFPCo/ClfmOFqEB0qsCCwEywMkv3MfzwOiR2lMq90lzw
         kzYOVypIfwwb5zSrJqYZM1ZfAtA4v7sFLnkxZuUk7Un165qciJ0dlw5ANXHe/21AhGND
         Uh9kYc5y827Clwfjkro6MwRRc0meuLEOXJGvyoY4bQ8gkvPQleQX3dGVxdsNN5FP587Q
         Ac4g==
X-Forwarded-Encrypted: i=1; AJvYcCUvWCK4mEopQ1BmmXJRlpMjP30kDOlqhQjpL8jU7OrON5Do7Vt9G2LGjs2gKpTSDDIHzOTDQPIXmJ/jScRQZ4JhdJXvm8RRN9xOnFO52eaRXA==
X-Gm-Message-State: AOJu0Yzb3kFzI5Afie51vbVrGCFQZByTHZHi37+YcIX34tXNELIFQMD2
	SFmZv/RH8BPLLh918nV7Q5gHhqIqWBJ3QFty6w1jmdr7oN4MbtXrNZmVCAJgFcDUr/kaY3E2f3U
	+4eM4yA==
X-Google-Smtp-Source: AGHT+IEKcmdKTjHr2xWWJkj/LRomPZ1pY+pgf9xS7sna0/bb350+idRqAo6Uz+mbnsKjTAEDSZ8CywccCPNe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3c02:f882:5876:b7ab])
 (user=irogers job=sendgmr) by 2002:a81:f008:0:b0:607:f6f0:bdca with SMTP id
 p8-20020a81f008000000b00607f6f0bdcamr3613089ywm.7.1708486934605; Tue, 20 Feb
 2024 19:42:14 -0800 (PST)
Date: Tue, 20 Feb 2024 19:41:52 -0800
In-Reply-To: <20240221034155.1500118-1-irogers@google.com>
Message-Id: <20240221034155.1500118-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221034155.1500118-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v6 5/8] perf test: Rename builtin-test-list and add missed
 header guard
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

builtin-test-list is primarily concerned with shell script
tests. Rename the file to better reflect this and add a missed header
guard.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/Build                                    | 2 +-
 tools/perf/tests/builtin-test.c                           | 2 +-
 tools/perf/tests/{builtin-test-list.c => tests-scripts.c} | 2 +-
 tools/perf/tests/{builtin-test-list.h => tests-scripts.h} | 4 ++++
 4 files changed, 7 insertions(+), 3 deletions(-)
 rename tools/perf/tests/{builtin-test-list.c => tests-scripts.c} (99%)
 rename tools/perf/tests/{builtin-test-list.h => tests-scripts.h} (79%)

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 53ba9c3e20e0..c7f9d9676095 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 perf-y += builtin-test.o
-perf-y += builtin-test-list.o
+perf-y += tests-scripts.o
 perf-y += parse-events.o
 perf-y += dso-data.o
 perf-y += attr.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 4a5973f9bb9b..eff3c62e9b47 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -29,7 +29,7 @@
 #include <subcmd/exec-cmd.h>
 #include <linux/zalloc.h>
 
-#include "builtin-test-list.h"
+#include "tests-scripts.h"
 
 static bool dont_fork;
 const char *dso_to_test;
diff --git a/tools/perf/tests/builtin-test-list.c b/tools/perf/tests/tests-scripts.c
similarity index 99%
rename from tools/perf/tests/builtin-test-list.c
rename to tools/perf/tests/tests-scripts.c
index a65b9e547d82..4ebd841da05b 100644
--- a/tools/perf/tests/builtin-test-list.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -15,7 +15,7 @@
 #include <sys/wait.h>
 #include <sys/stat.h>
 #include "builtin.h"
-#include "builtin-test-list.h"
+#include "tests-scripts.h"
 #include "color.h"
 #include "debug.h"
 #include "hist.h"
diff --git a/tools/perf/tests/builtin-test-list.h b/tools/perf/tests/tests-scripts.h
similarity index 79%
rename from tools/perf/tests/builtin-test-list.h
rename to tools/perf/tests/tests-scripts.h
index eb81f3aa6683..3a3ec6191848 100644
--- a/tools/perf/tests/builtin-test-list.h
+++ b/tools/perf/tests/tests-scripts.h
@@ -1,4 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef TESTS_SCRIPTS_H
+#define TESTS_SCRIPTS_H
 
 struct script_file {
 	char *dir;
@@ -10,3 +12,5 @@ struct script_file {
 const struct script_file *list_script_files(void);
 /* Get maximum width of description string */
 int list_script_max_width(void);
+
+#endif /* TESTS_SCRIPTS_H */
-- 
2.44.0.rc0.258.g7320e95886-goog

