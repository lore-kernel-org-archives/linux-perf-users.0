Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C85318C92B
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 04:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729052701; cv=none; b=sG7xWGg8D+wqzRZuqfL12vqMSsV5rFWhAE4j1gXxhfJUbFjAFRu8GhwA7uRBGo01tDCJR+8OhkOL7foQvCTLDm+2P3NdzyLjP6st9RZTYXqq/eeztrgSmj4NP7wPpd8EQJDNTeoIvu0nBbw36skPTM8A0DMA42q5gQcky0YX2Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729052701; c=relaxed/simple;
	bh=epKVJe3RCWYyjZNsPJZUgS3AsJWoqZo4b5ZWJnDvWVE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=CovUyfaHvtUqR8WKgkt2lJJxd9GE9MdxhPAuhPY7PhKB25bt1FAR3/q2CTP79o2pBhfcT3zKNVlfXeF+u1eJUBJLRbtEdJejOiw95/d4q7BawvcJ2PYUAimmK8+ISW3zXgqldJbcsvEPSdl5ChS2E7nNicnCYds1ELGeQy+EGhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y+BiNhPZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y+BiNhPZ"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e291ac8dcf3so6913127276.3
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 21:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729052698; x=1729657498; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lK9SNOIgTuh2oYu8HhqBxPR4MfR5jmGAMzuSS+m3nhg=;
        b=y+BiNhPZPAkEMATH9wWe1YvsQyycF0yLVarQR2wbgtB4LSMAa2OKXqDoR1Zj5rV2Ze
         XE4FuHa+9TVRDy7EVZsdP1ieWw32lZdJQ1pLlUsA02iCOBmUStS98ijbo3QxDEwltkqY
         iGZKkgwcRyDLE6p/ta6pT0TOuSqCQrkaLWfv23B3j/z0YQUxYKvbF7xJG4BKj8Th9kkz
         0c1Z5HzZUsJUZkjWxK7nklcKAv+L2il34kWo/hzPiIzEksnnEpa/hV0spIvANLA8bMo2
         pJXI6PN/g9sLnJoG6hR6lk1LuSyoEKhk3nju018UuxirlhHscw1QPKeF23eTSx8gTZVg
         4JnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729052698; x=1729657498;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lK9SNOIgTuh2oYu8HhqBxPR4MfR5jmGAMzuSS+m3nhg=;
        b=QmMTwOgIwUtVTK/j2ue+3gBhVHRq3JeLT0PcRy/45xosKzazTdjYAdj8vSdKwI3TV9
         5rdBx0GozS0+6gv4gU4Nm4MY2vK3MTt42d1bpXIx/NNhSHMyOOieiRSvh7Whq4Fmd4SO
         EJyd9qlS/iwAeN8fpuzHb8NRnWGc9e4Rnc8TaaGetF90cjbKXGhat+XpHFx0L/c3wgOO
         yHYX1TGiXj03bhEeE9cdZUws7GsUbDpTEvTaa61XY9lqT2ugDTg5R1bBvDyCpT8maqHU
         gxxpZLzdq8iuOc/ZoxWn7zqhUPE6K0vus0otxS0g65zfd/LTdhvuttZP6qG+z763eJT+
         4eig==
X-Forwarded-Encrypted: i=1; AJvYcCXcVcYwZMcxcC3BsbGTT07rJwFcxQXEHHJHV5jXqUiMvgEGO8zR43J8RYlkCgFdP/vHY8FuZrvedcNZbbkqSeIX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8HL51htUznFKhKHiPOtqVqAB448tat3XvO2Z3VPsbgE5tk8hJ
	nUpBN9eahO6026kLUlgAdxGh2MKu4UmAqhmVKJ1HWWGtn3Zak89qhhnT7ksP2Axhk4jmxZWvGlQ
	cgs+rew==
X-Google-Smtp-Source: AGHT+IEuWNkaP5l8NR2ftX8OExHxtrWqnWB9d4b5/+fsXNg6F4svjb/qo6bbUXwX/H7RKl/E3j6U49o2TWBe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:ad64:0:b0:e29:67f4:8033 with SMTP id
 3f1490d57ef6-e297830fafdmr2506276.5.1729052698166; Tue, 15 Oct 2024 21:24:58
 -0700 (PDT)
Date: Tue, 15 Oct 2024 21:24:09 -0700
In-Reply-To: <20241016042415.7552-1-irogers@google.com>
Message-Id: <20241016042415.7552-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016042415.7552-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 10/16] perf script: Move perf_sample__sprintf_flags to trace-event-scripting.c
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

perf_sample__sprintf_flags is used in the python C code and so needs
to be in the util library rather than a builtin.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c             | 80 ------------------------
 tools/perf/util/python.c                |  6 --
 tools/perf/util/trace-event-scripting.c | 82 +++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 86 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 63a00dad02c6..b5329f4b0602 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1693,86 +1693,6 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
 	return printed;
 }
 
-static struct {
-	u32 flags;
-	const char *name;
-} sample_flags[] = {
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL, "call"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN, "return"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CONDITIONAL, "jcc"},
-	{PERF_IP_FLAG_BRANCH, "jmp"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_INTERRUPT, "int"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN | PERF_IP_FLAG_INTERRUPT, "iret"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_SYSCALLRET, "syscall"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN | PERF_IP_FLAG_SYSCALLRET, "sysret"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_ASYNC, "async"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_ASYNC |	PERF_IP_FLAG_INTERRUPT, "hw int"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TX_ABORT, "tx abrt"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TRACE_BEGIN, "tr strt"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TRACE_END, "tr end"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_VMENTRY, "vmentry"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_VMEXIT, "vmexit"},
-	{0, NULL}
-};
-
-static const char *sample_flags_to_name(u32 flags)
-{
-	int i;
-
-	for (i = 0; sample_flags[i].name ; i++) {
-		if (sample_flags[i].flags == flags)
-			return sample_flags[i].name;
-	}
-
-	return NULL;
-}
-
-int perf_sample__sprintf_flags(u32 flags, char *str, size_t sz)
-{
-	u32 xf = PERF_IP_FLAG_IN_TX | PERF_IP_FLAG_INTR_DISABLE |
-		 PERF_IP_FLAG_INTR_TOGGLE;
-	const char *chars = PERF_IP_FLAG_CHARS;
-	const size_t n = strlen(PERF_IP_FLAG_CHARS);
-	const char *name = NULL;
-	size_t i, pos = 0;
-	char xs[16] = {0};
-
-	if (flags & xf)
-		snprintf(xs, sizeof(xs), "(%s%s%s)",
-			 flags & PERF_IP_FLAG_IN_TX ? "x" : "",
-			 flags & PERF_IP_FLAG_INTR_DISABLE ? "D" : "",
-			 flags & PERF_IP_FLAG_INTR_TOGGLE ? "t" : "");
-
-	name = sample_flags_to_name(flags & ~xf);
-	if (name)
-		return snprintf(str, sz, "%-15s%6s", name, xs);
-
-	if (flags & PERF_IP_FLAG_TRACE_BEGIN) {
-		name = sample_flags_to_name(flags & ~(xf | PERF_IP_FLAG_TRACE_BEGIN));
-		if (name)
-			return snprintf(str, sz, "tr strt %-7s%6s", name, xs);
-	}
-
-	if (flags & PERF_IP_FLAG_TRACE_END) {
-		name = sample_flags_to_name(flags & ~(xf | PERF_IP_FLAG_TRACE_END));
-		if (name)
-			return snprintf(str, sz, "tr end  %-7s%6s", name, xs);
-	}
-
-	for (i = 0; i < n; i++, flags >>= 1) {
-		if ((flags & 1) && pos < sz)
-			str[pos++] = chars[i];
-	}
-	for (; i < 32; i++, flags >>= 1) {
-		if ((flags & 1) && pos < sz)
-			str[pos++] = '?';
-	}
-	if (pos < sz)
-		str[pos] = 0;
-
-	return pos;
-}
-
 static int perf_sample__fprintf_flags(u32 flags, FILE *fp)
 {
 	char str[SAMPLE_FLAGS_BUF_SIZE];
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 22edadd64e5f..77e02fcc51dd 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1317,12 +1317,6 @@ struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork __maybe_unused,
 	return NULL;
 }
 
-int perf_sample__sprintf_flags(u32 flags __maybe_unused, char *str __maybe_unused,
-			size_t sz __maybe_unused)
-{
-	return -1;
-}
-
 bool match_callstack_filter(struct machine *machine __maybe_unused, u64 *callstack __maybe_unused)
 {
 	return false;
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index 543e78b17e5f..1734967d7f70 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -15,6 +15,7 @@
 
 #include "archinsn.h"
 #include "debug.h"
+#include "event.h"
 #include "trace-event.h"
 #include "evsel.h"
 #include <linux/perf_event.h>
@@ -285,3 +286,84 @@ void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
 	if (sample->insn_len == 0 && native_arch)
 		arch_fetch_insn(sample, thread, machine);
 }
+
+static const struct {
+	u32 flags;
+	const char *name;
+} sample_flags[] = {
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL, "call"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN, "return"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CONDITIONAL, "jcc"},
+	{PERF_IP_FLAG_BRANCH, "jmp"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_INTERRUPT, "int"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN | PERF_IP_FLAG_INTERRUPT, "iret"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_SYSCALLRET, "syscall"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN | PERF_IP_FLAG_SYSCALLRET, "sysret"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_ASYNC, "async"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_ASYNC |	PERF_IP_FLAG_INTERRUPT,
+	 "hw int"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TX_ABORT, "tx abrt"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TRACE_BEGIN, "tr strt"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TRACE_END, "tr end"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_VMENTRY, "vmentry"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_VMEXIT, "vmexit"},
+	{0, NULL}
+};
+
+static const char *sample_flags_to_name(u32 flags)
+{
+	int i;
+
+	for (i = 0; sample_flags[i].name ; i++) {
+		if (sample_flags[i].flags == flags)
+			return sample_flags[i].name;
+	}
+
+	return NULL;
+}
+
+int perf_sample__sprintf_flags(u32 flags, char *str, size_t sz)
+{
+	u32 xf = PERF_IP_FLAG_IN_TX | PERF_IP_FLAG_INTR_DISABLE |
+		 PERF_IP_FLAG_INTR_TOGGLE;
+	const char *chars = PERF_IP_FLAG_CHARS;
+	const size_t n = strlen(PERF_IP_FLAG_CHARS);
+	const char *name = NULL;
+	size_t i, pos = 0;
+	char xs[16] = {0};
+
+	if (flags & xf)
+		snprintf(xs, sizeof(xs), "(%s%s%s)",
+			 flags & PERF_IP_FLAG_IN_TX ? "x" : "",
+			 flags & PERF_IP_FLAG_INTR_DISABLE ? "D" : "",
+			 flags & PERF_IP_FLAG_INTR_TOGGLE ? "t" : "");
+
+	name = sample_flags_to_name(flags & ~xf);
+	if (name)
+		return snprintf(str, sz, "%-15s%6s", name, xs);
+
+	if (flags & PERF_IP_FLAG_TRACE_BEGIN) {
+		name = sample_flags_to_name(flags & ~(xf | PERF_IP_FLAG_TRACE_BEGIN));
+		if (name)
+			return snprintf(str, sz, "tr strt %-7s%6s", name, xs);
+	}
+
+	if (flags & PERF_IP_FLAG_TRACE_END) {
+		name = sample_flags_to_name(flags & ~(xf | PERF_IP_FLAG_TRACE_END));
+		if (name)
+			return snprintf(str, sz, "tr end  %-7s%6s", name, xs);
+	}
+
+	for (i = 0; i < n; i++, flags >>= 1) {
+		if ((flags & 1) && pos < sz)
+			str[pos++] = chars[i];
+	}
+	for (; i < 32; i++, flags >>= 1) {
+		if ((flags & 1) && pos < sz)
+			str[pos++] = '?';
+	}
+	if (pos < sz)
+		str[pos] = 0;
+
+	return pos;
+}
-- 
2.47.0.rc1.288.g06298d1525-goog

