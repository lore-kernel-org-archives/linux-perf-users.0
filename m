Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908DF1C579F
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618277; cv=none; b=Apux9cN2QoDnm2wkkaOj2MNKiRj1kO/cFK4Plj7YtjoswcATMCDJCuUD6JnG6B7zUPjLmBCi+a7krKZ4zs8lcUDvTBPSB/wC/ahVa3D20yODvxnhxNsCBEz3S7kWIuMBodsWvXU3K8uCp1Tk0twzMRBw6apnIUNjgXHwr4K7+b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618277; c=relaxed/simple;
	bh=6cBSvBCPWOSZF+MItRvyrCkvc/eDCuHzWE3rNUATjb4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qBxO1U3+s+Wx57cQfDpnf/k5EaPyQlFSub0wuXoUau0/28g47Ym5fa8YxcYf3d1k49WQFfXuqPSHJDL4cshfvIyxgoZ7gb8//9l4aozzlbxXVncHqHeMmT3xmjLnz34sy6ked6kOyUGMH6vI1FSCCXq/7ATgVCyLhLXXnXpQmpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rRZ9OBPh; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rRZ9OBPh"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e390b164c7so97438447b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 10:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729618273; x=1730223073; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FGGhHZMe/gCvpVhm6kMneTHlRVnqYzRTKL5fI6/PdXc=;
        b=rRZ9OBPhRuqP0BgYnYiB5R8EDtXyrAaqA4k+JN1AD+NpDB+D5eAQNWbdbViFXC1hpT
         vXBrAq8oQCl7EoOdU+D5vRut4PjwxZFp6wUKMc+rOcmrxDzVy8s8/QlBdg5ndiby15CZ
         5UANxCza1TKxxDto/cnFlJ5OJ56wIWZLqGikqFKmqpUz705xxxyo33Ffht5ichAVABbg
         /1vXWmd1XACfWJ01WtB0zBsUv3iHccP4m6g+o9oKQIfB3S6j93BT47BG4mLyzkBmVHex
         T7sSUYRZPPfUH/UngMru8YSVqesV7gPQpDLO3t6QvNJp2rikDH3/MPs9M3ezjCIkHfXA
         KE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618273; x=1730223073;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGGhHZMe/gCvpVhm6kMneTHlRVnqYzRTKL5fI6/PdXc=;
        b=WSwRX9F2NcDzkSIKLBAI+Iwk8q07NtA0JfI4bgic8Q46LhNJ8TVQ+UgYAIRO5nHFyo
         /wofiHdCi77KyaNJxeDbBLsg/oXY+asANSplGobvGNcIV6Fu1VgPFvzo369tEj3U85+c
         8dO/4+9QGBmRxZ/kfN2O1sVuMoj0c5f95YvmijPyW1Tta76iaj5mukXsHSgdYATzuafC
         zaZ+Z35KNz6docb3GEq15Bf3LIpLVJigMpKZdEk0z/MFmZ5SDCj94Ng2tMQwrJosRdAo
         2IEptFJUFDNqylqQWgk8x1ARCx2SfKSLvZOQKfFfjA6oMnzj2IgOIQJZomUzB5kKibib
         aU5g==
X-Forwarded-Encrypted: i=1; AJvYcCXP7Z6wufPINQkU7gQ5LmNhfqRAEXbUB+1SgRmM5xSTlXIzmC9nS1xMr1Qv+I0MUtwh7ul5CDzB/3U5zMm/D4wi@vger.kernel.org
X-Gm-Message-State: AOJu0YwqXoRuakdX7kMXY1LOGDqrLjvUQ7U8i3LJe+MoG0X71xOBUeLd
	6+DWjHV6FkIkN7n0Fkul7vqR91irVaAVzCO4wMJPYBazLB2T5NKhVB8ba+swXnjz8SscsAgGVHM
	RGxwwFQ==
X-Google-Smtp-Source: AGHT+IF3S9g75sPNhGzb0F/YX/oOHI6JoHuNFLi0jjjoECv0cQRrHecZ9TUZKQkAY4FfP3Y55sqexXI6QR6w
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:57ba:88e0:aaf6:282])
 (user=irogers job=sendgmr) by 2002:a25:868a:0:b0:e28:8f62:e735 with SMTP id
 3f1490d57ef6-e2bb11aac7emr10021276.1.1729618273325; Tue, 22 Oct 2024 10:31:13
 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:30:08 -0700
In-Reply-To: <20241022173015.437550-1-irogers@google.com>
Message-Id: <20241022173015.437550-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022173015.437550-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v3 10/16] perf script: Move perf_sample__sprintf_flags to trace-event-scripting.c
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
2.47.0.163.g1226f6d8fa-goog

