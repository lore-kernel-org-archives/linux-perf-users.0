Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9E0175D3F
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Aug 2024 07:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725087878; cv=none; b=gbMVymJ+wkA6KK5llKY8U/Ok6pDOTLqe+ur7fNwMDIWgT5sdhTssM+yiipEQlobFcr8lnB4A0ka97GzILhNQNyiaLyfO80wzTuryCHn2K+7yGMHYuVg7GuF/HHOjFdgArLdH2TNlBa2rhbiQ1M9hW5gHc/hcTujrBmxuDtlDW1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725087878; c=relaxed/simple;
	bh=8UPkJyqmMUZX6rxp//OAQh9bbpxpB7gHGefxdcxc+Iw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=TXCDJJOh5SSSLMP5C3cA92vnE1wBfQ/I15g04O5jg/P72kBdDmnMqAwRwDV382uhQaDzHmyBMBqTlM/SdMqH8ChIk3e8YxUIJMu2p71IA2rX3j5zly6kw20sngcJAsIrnAQ+80Oo7WmV7RZ96nd6Z95znJK7ozRuDJ20Bx/eSaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1QVuN1YZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1QVuN1YZ"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d3e062dbeeso22960447b3.0
        for <linux-perf-users@vger.kernel.org>; Sat, 31 Aug 2024 00:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725087875; x=1725692675; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3TY7dleA8hoe/b0STghmEa4EVbup5XFL8ChSr6jPnf0=;
        b=1QVuN1YZOdCQ4cRtAIjf2rOxQH70jwbVmI42HpY7v1TpFVJu8xsbvEHYJlSGPNyDeH
         igeq98AlmuD4/hWVb0h0D6AFuVUqVYatslbifMLGn8uIZVY4S3KubPocW8IsJ9Rvy+1u
         l/VGC/HRvBr/PHcYqIyrLGziUUL0oLr8fdfWzv7QQvbVmtDfPl2IwoCOw6ONNxjZFSZe
         bjE4ISxmR4zZrmqsrmVoymV+X++OKlo7tv6LuUNcTERRGDr37CUL31erfwJrM4dHE2U7
         M7U47C0A0qZ7duLqErB8YOSIV09aSHIxhiwBC+GvjLdGwcsvmOdqrDKizskyzjiLSkJQ
         WqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725087875; x=1725692675;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3TY7dleA8hoe/b0STghmEa4EVbup5XFL8ChSr6jPnf0=;
        b=iDFKvGhb919mfjDIgusG+pSKrnOClO1K4x/HeL++ndXJzxd72PmmJ/+QxBAYGXooZV
         UpRDG3YKve4P83cVV9LBB9Gmr+kCW4whOfMypuIl2xfl5Xnn4skLuocRPXt65A1zgrRX
         /zThrOy/W8OWAlF7pDuBr3tec0YHXCPUmUsgXjP1Jy9dvkcJGTLcnEy56vSmluWsju2B
         HwQdbelolssuDoKmdBq4c2uvE/TsgEgbf+4K+roJcnFJ9/tkka/vuniBsoSp2RuR1XNd
         DFFqblsWpwf2FpMJDIfjlD0b9pJVJjp5NNUfsyo/gmhhmdLSDfX7r7/xXzWwnSkg539Z
         ciIg==
X-Forwarded-Encrypted: i=1; AJvYcCVbAJARlonTuOqLkacz0m4p1Mka2+7ooO4oKTTpBMU/tCG1ANLOJMnBrzVRKw8/NB8KIzfK6g2owW1bLBCVG6Wt@vger.kernel.org
X-Gm-Message-State: AOJu0YyKvxzJWm73Bat2hbDMa49JhaGzDiPDOQdn9an4TXel8fMgqIqJ
	OaZn2mTvQUJfnknvN/k2+aOwllmw/OFL4flzkOgIJtcOHrha/hmOdd1IOB2e4h3ZGVBb3Q6/oDZ
	luryzuw==
X-Google-Smtp-Source: AGHT+IGnoAl7EJ4WctiSw6Y64whqdTB5BzobJZ3VDTVwGagWDxUuDNSHQY1Pw0RhThEdjT9oJNjsj9+X+qt9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4974:82ff:2f9:edb6])
 (user=irogers job=sendgmr) by 2002:a0d:ce07:0:b0:6be:523:af53 with SMTP id
 00721157ae682-6d2868a316amr2536287b3.3.1725087875282; Sat, 31 Aug 2024
 00:04:35 -0700 (PDT)
Date: Sat, 31 Aug 2024 00:04:13 -0700
In-Reply-To: <20240831070415.506194-1-irogers@google.com>
Message-Id: <20240831070415.506194-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240831070415.506194-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1 4/6] perf parse-events: Add default_breakpoint_len helper
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Junhao He <hejunhao3@huawei.com>, 
	David Ahern <dsa@cumulusnetworks.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The default breakpoint length is "sizeof(long)" however this is
incorrect on platforms like Aarch64 where sizeof(long) is 8 but the
breakpoint length is 4. Add a helper function that can be used to
determine the correct breakpoint length, in this change it just
returns the existing default sizeof(long) value.

Use the helper in the bp_account test so that, when modifying the
event from a watchpoint to a breakpoint, the breakpoint length is
appropriate for the architecture and not just sizeof(long).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/bp_account.c         | 4 +++-
 tools/perf/tests/bp_signal.c          | 3 ++-
 tools/perf/tests/bp_signal_overflow.c | 3 ++-
 tools/perf/tests/parse-events.c       | 3 ++-
 tools/perf/util/parse-events.c        | 7 ++++++-
 tools/perf/util/parse-events.h        | 2 ++
 6 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index 6f921db33cf9..4cb7d486b5c1 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -16,6 +16,7 @@
 #include "tests.h"
 #include "debug.h"
 #include "event.h"
+#include "parse-events.h"
 #include "../perf-sys.h"
 #include "cloexec.h"
 
@@ -50,7 +51,7 @@ static int __event(bool is_x, void *addr, struct perf_event_attr *attr)
 	attr->config = 0;
 	attr->bp_type = is_x ? HW_BREAKPOINT_X : HW_BREAKPOINT_W;
 	attr->bp_addr = (unsigned long) addr;
-	attr->bp_len = sizeof(long);
+	attr->bp_len = is_x ? default_breakpoint_len() : sizeof(long);
 
 	attr->sample_period = 1;
 	attr->sample_type = PERF_SAMPLE_IP;
@@ -92,6 +93,7 @@ static int bp_accounting(int wp_cnt, int share)
 	attr_mod = attr;
 	attr_mod.bp_type = HW_BREAKPOINT_X;
 	attr_mod.bp_addr = (unsigned long) test_function;
+	attr_mod.bp_len = default_breakpoint_len();
 
 	ret = ioctl(fd[0], PERF_EVENT_IOC_MODIFY_ATTRIBUTES, &attr_mod);
 	TEST_ASSERT_VAL("failed to modify wp\n", ret == 0);
diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index 1f2908f02389..3faeb5b6fe0b 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -26,6 +26,7 @@
 #include "tests.h"
 #include "debug.h"
 #include "event.h"
+#include "parse-events.h"
 #include "perf-sys.h"
 #include "cloexec.h"
 
@@ -111,7 +112,7 @@ static int __event(bool is_x, void *addr, int sig)
 	pe.config = 0;
 	pe.bp_type = is_x ? HW_BREAKPOINT_X : HW_BREAKPOINT_W;
 	pe.bp_addr = (unsigned long) addr;
-	pe.bp_len = sizeof(long);
+	pe.bp_len = is_x ? default_breakpoint_len() : sizeof(long);
 
 	pe.sample_period = 1;
 	pe.sample_type = PERF_SAMPLE_IP;
diff --git a/tools/perf/tests/bp_signal_overflow.c b/tools/perf/tests/bp_signal_overflow.c
index 4e897c2cf26b..ee560e156be6 100644
--- a/tools/perf/tests/bp_signal_overflow.c
+++ b/tools/perf/tests/bp_signal_overflow.c
@@ -25,6 +25,7 @@
 #include "tests.h"
 #include "debug.h"
 #include "event.h"
+#include "parse-events.h"
 #include "../perf-sys.h"
 #include "cloexec.h"
 
@@ -88,7 +89,7 @@ static int test__bp_signal_overflow(struct test_suite *test __maybe_unused, int
 	pe.config = 0;
 	pe.bp_type = HW_BREAKPOINT_X;
 	pe.bp_addr = (unsigned long) test_function;
-	pe.bp_len = sizeof(long);
+	pe.bp_len = default_breakpoint_len();
 
 	pe.sample_period = THRESHOLD;
 	pe.sample_type = PERF_SAMPLE_IP;
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index edc2adcf1bae..0681653b12d2 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -5,6 +5,7 @@
 #include <api/fs/fs.h>
 #include "tests.h"
 #include "debug.h"
+#include "parse-events.h"
 #include "pmu.h"
 #include "pmus.h"
 #include <dirent.h>
@@ -262,7 +263,7 @@ static int test__checkevent_breakpoint_x(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
 	TEST_ASSERT_VAL("wrong bp_type",
 			HW_BREAKPOINT_X == evsel->core.attr.bp_type);
-	TEST_ASSERT_VAL("wrong bp_len", sizeof(long) == evsel->core.attr.bp_len);
+	TEST_ASSERT_VAL("wrong bp_len", default_breakpoint_len() == (int)evsel->core.attr.bp_len);
 	return TEST_OK;
 }
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index fab01ba54e34..dfb951bb184b 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -670,6 +670,11 @@ static int add_tracepoint_multi_sys(struct parse_events_state *parse_state,
 }
 #endif /* HAVE_LIBTRACEEVENT */
 
+int default_breakpoint_len(void)
+{
+	return sizeof(long);
+}
+
 static int
 parse_breakpoint_type(const char *type, struct perf_event_attr *attr)
 {
@@ -728,7 +733,7 @@ int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 	/* Provide some defaults if len is not specified */
 	if (!len) {
 		if (attr.bp_type == HW_BREAKPOINT_X)
-			len = sizeof(long);
+			len = default_breakpoint_len();
 		else
 			len = HW_BREAKPOINT_LEN_4;
 	}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index b735cd9e0acf..f79d076cd1bd 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -286,4 +286,6 @@ static inline bool is_sdt_event(char *str __maybe_unused)
 }
 #endif /* HAVE_LIBELF_SUPPORT */
 
+int default_breakpoint_len(void);
+
 #endif /* __PERF_PARSE_EVENTS_H */
-- 
2.46.0.469.g59c65b2a67-goog

