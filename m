Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C0815350A
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Feb 2024 23:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708127726; cv=none; b=PlbhotSW9qSTfAubY9vCTgKdJu7ZcxqUg3QZPHjf2f6efv2Ga5Mh+SM1oOy5ZoIC4gG/QeMrjA8Z/I/qtE434H0kD/NLUOx8nSZqLyNhfR+ZEtfQZ216aObTWnKBZ3SYQIqf9AiAIZRjM1za0LpzqGbGngG6VlYXJPYkPTLt+Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708127726; c=relaxed/simple;
	bh=I+UE93RRTXaqRw/ye3XEqbtXPztsO4QkZJrrM8rzem4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=FzQU/fAkskI+R8Hm4HA+Zq0G4tXtCofqqy9DufhrTIaLavwtRqdyVWWdaeGoePFfX186NpRqaumj8iiREeMHamJuNX1Ke3e9K6G//V5QV6YVxuaLLrarNw2vD38Z3FzE0dbChfuQJ8FAui4W7wlMGX2TQogi63vtRbkNulhIa8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0abjhKbL; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0abjhKbL"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607efc8e173so18861297b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Feb 2024 15:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708127724; x=1708732524; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BDoXWFUllq5r9qvxHaqqdOtetQC7wmYhYSm0N03NFTM=;
        b=0abjhKbLH+0b2/hA7gQDVaBkOkI5Oct22+pH28A+PD2G2f/N/kqBwB9BaVgzWabl06
         j5rAY6TOX7i2WGcsMbZlh4ZNH9gifdumlY/oHNCVLxkcbxNunDMqh6kpDkLz996zZCax
         lgq0ULCvYzrJtLylrkwVirTBDCqZc6/CgXQMY+OVCApNYIHFVowUjj/VzuK+o+TJCVXg
         /gB8i71e6Kv6hWADwOUI9Q2k0Ft1UVRdMY8uC7nJZ4otmM4siwR/k1wg+Fl8sAGkKwqc
         R2lXOta0Snn33dttEvEy0wPYRO6yxmtZlEjfOweaYcSm3cFVK3fIJDa838bdIAuC4xwr
         UC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708127724; x=1708732524;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDoXWFUllq5r9qvxHaqqdOtetQC7wmYhYSm0N03NFTM=;
        b=E7S9lYjsYUWSuP9RCUOCCU7Y4bkJ9Lqff1KbTJbMWtjQ2DYacfdD+zlMBQ9CxRPEIt
         A5c0m0wPANjV5kTkyQmS0EuoN5voQ9keR6fE103V5OIy7dIyVMjQZXo307VhAd0VkPra
         lQc2WI89LOO3zsEFHQBIUPjpWsZckRSZfn5CtFT+ip0lV2MziW9M5KBK/RFLIwJAzypo
         +YPWzxvcoPHVTvfmXc14lVwtFfwS82ljSSx0/DJ7W4RqLR4g44/yyLRF3EVtat5IF6ut
         4L8PF4olRNG4AQSx9pB679SnLBsvgDmPrudsaPbBpnEuoty971KITtdapXikrkZr9zOW
         q5rw==
X-Forwarded-Encrypted: i=1; AJvYcCXQZrzQmCGVtOvkS94xeOIWtSw8SpGwhXs3ZGhublihiwvwP4Yc25Fusx8CeIUaNaFWyXdRdParBHIVuPCTEcMDlgnXoLf1GgSlzJWld/TTmA==
X-Gm-Message-State: AOJu0Yz081HBQCaqdNB9VaDelPw0HxtDvOOmuaA8eHy8U5/bv8kMtpDr
	U9CCKQc9PH0MlZQWrNCqy3MHtFiw9t2Gst67X9BePwlVdT7/yntQ+Cz6Zl/pCH1xseat2OEqPAo
	uMg1PgA==
X-Google-Smtp-Source: AGHT+IHjzJawXDO2AXJXaejQYAiOMaUrWyEtn27ViDkJQiFti66UFA6r7CcCoH/bmb67Eb7eiXG+oRMQM2AD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4b5c:352:4272:e34e])
 (user=irogers job=sendgmr) by 2002:a0d:db4b:0:b0:607:81e1:8b83 with SMTP id
 d72-20020a0ddb4b000000b0060781e18b83mr1157396ywe.8.1708127724036; Fri, 16 Feb
 2024 15:55:24 -0800 (PST)
Date: Fri, 16 Feb 2024 15:51:59 -0800
In-Reply-To: <20240216235203.229256-1-irogers@google.com>
Message-Id: <20240216235203.229256-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240216235203.229256-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v5 5/8] perf test: Rename builtin-test-list and add missed
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

