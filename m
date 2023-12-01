Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M5ypXAAW"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18679170D
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Dec 2023 15:50:50 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db53919e062so1433385276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Dec 2023 15:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701474649; x=1702079449; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S5bEZDUZx9SC+UNDGd8Tkd4xhf8pPfCYFDzGqkpX+gI=;
        b=M5ypXAAWIKM5ZHV/Qc6J6zFGvkWDwcge57sGGjwLkyaXvxOMKRbF5LlCjsE87dBTGz
         uIScQqD++m41JwIyEPzvSWWWwaoDrpj61a0VyxJdRUM5YK/aP+gpDxFH0Tp098RjYSJs
         JHf6/saK68VlWy6ucX7PzlnWnY9kgSH0l7tJNXcMgcDcgrt4gYeyoTsD4guBXDpIqlHu
         m6PiJsxB/AsneBBaXbEDSj0ilte4azWij5k9Evy2bvUTF+i9SYE7ZaJiLPnl3XxCRR70
         z18qW1y5TIalTYp2rcucfqxd0cvJ0B0y3nLYKGMm1xMCjG3jANKXdYuw087SmJCBThIV
         +yvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701474649; x=1702079449;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S5bEZDUZx9SC+UNDGd8Tkd4xhf8pPfCYFDzGqkpX+gI=;
        b=B2TGesusvIsGT7d2a0keXdbcnS7Idfp5RHp6nNkzkVPMM4AfdwRXj8J3vIi0zj/Wse
         /MSUj8S9ojqhEifkef/IY4Nw2Dw4nJOO94viSdL9STIUvWtzSzqy+gD6R1rc4h6W9nGE
         C1MuwMo6KC1/+DgyX/jtE5ZjUFcsrG962WPQssUFQATH30trV4K/ox957xt83bY6z9lN
         AAZaIw78RsZbNzxMJE+hIWZnLnPR4HZGxI4fqUIg6W1ju70rUHEpJA22LYndQBQrOFch
         TT0gAhmIlRt1GeLj9oSXXAkl/MngQKRicliXZmS8OTajH3zGmyHct2Vwq5lOa8h+/xKO
         LOcQ==
X-Gm-Message-State: AOJu0YwidI9ebBnD/LbBXduwOLtq+M+7XpbYeeDpbJDNuswA6e4aCe6h
	AaWRaNWrBl3E7dtmAfpMnqArFFZ0oAaY
X-Google-Smtp-Source: AGHT+IGxVifoKKxnrgQ64N0R0ThCAE1eb5F+Ng+jSAIgm5nvdPD7/C+4gmOXBYz95YL9nzm94UBSTaUFTzGq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:df3:224b:7b7f:efc5])
 (user=irogers job=sendgmr) by 2002:a25:a3e6:0:b0:db4:5d34:fa5 with SMTP id
 e93-20020a25a3e6000000b00db45d340fa5mr857933ybi.0.1701474649200; Fri, 01 Dec
 2023 15:50:49 -0800 (PST)
Date: Fri,  1 Dec 2023 15:50:27 -0800
In-Reply-To: <20231201235031.475293-1-irogers@google.com>
Message-Id: <20231201235031.475293-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231201235031.475293-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1 5/9] perf test: Rename builtin-test-list and add missed
 header guard
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
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
index 2b45ffa462a6..5cc814af8e37 100644
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
index b8c21e81a021..fab49a60d508 100644
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
2.43.0.rc2.451.g8631bc7472-goog

