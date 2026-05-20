Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3C9400DFE
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303995; cv=none; b=QIIxIeZJ/KmwnZraAl6pBhxjY04CnezTRYp7PW/qM+BvTTStnQfAucVolONBVySz/s6ow+NO2ZP2lUbXR23XZeUpjMBxSNItBu6JdVwbaKdsCpIHchB9xsFXqWtarKnG8x1Vyh2gwDsvLVsfTRA3z9xDia0lB1jERSa9QWHFSSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303995; c=relaxed/simple;
	bh=HQm1z+3tMiV7v52E7RJ7PE7Yqm2BJBsIxLPbEO6I+04=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fAGRuA4iyaqHtqH1inMwQs39YEu9Tmsvwfx8fmfweTMbeUxLIz3sTWggQXTSuRVddw44k5v5MtknH7I/L9WktVHHHOtmdlMjzebuqIL4OY5hCUV2qYQUP+ltBfXdZj70QP5vCQdVW5D60UHIAC419JB+GNiWZ21efTMjbSqthT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=opWuNXQL; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="opWuNXQL"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-3041c65a30bso883858eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779303994; x=1779908794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JNPijCSq77k0mVk7YFQkiMR+V8E+8sPrC3NIhlaJKmM=;
        b=opWuNXQL2dY6cjO5y97XDvZDzZuwakjYX7B/MSsxkqASZ4CSygOppyHWME+t8riWL4
         mJ8ac3qaOyIDaI4YXW1qdCzj0HYLUfIElH+hpy68dC1lVa0G0DElv9L8SAHpoR28SO8r
         Nk0a4EDbQ6Po8o91EE6vdQ0ahZHWGG/99HK7wB/fP13Ub0y7ijhayjeI6tBQK/N+CHGI
         HiYHbzn43O2MAC6CtqUK398rMgaQiMcnzSKC4V+cgY4qHbp8jxorXgVUgfTKbR1bikns
         8QPo8uScrXQMyaHXKrypWNrmVQNKgmZcv/vTLc8lU53FUA7f5v+u2yrNwqn9pk3ItCKD
         Bchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303994; x=1779908794;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JNPijCSq77k0mVk7YFQkiMR+V8E+8sPrC3NIhlaJKmM=;
        b=slRe+OpTtf8W4BcWJAI32/dlyVEuGoE/6rSSRVVnm9qV7BOeBMEE+OzzzSQ4DfcrBL
         MSYjLCvsWyENjzFyauhc8sH02xa0ljjEMIkWArV/6Bwu2JkyXOFF9LJ4XTSrCYrpIW2j
         7fPeSFOBHUcuc2op77yXGeJXeN9VoYqjpquILpXCz5JD1/fWcBanshuUMGfDIfvrmkV4
         jxaVBQMO2KFwsg/HXevSGshTBzBaIrDE1YnNmrIiwG7C5aGA+tZrA7hL620fPO02y7MS
         0blRLTzNxS9skj16/i2J/JqjL0tqRycYKjUE06WH7HBrdBth3aUqzIWpXAJXsRjnLSVc
         JrrA==
X-Forwarded-Encrypted: i=1; AFNElJ++cxbSjyJuXULmN/LkPpFXrAHxNA24Hkf9rmHdfVQc0qRDaea3zbufnXnH1ZLLYv62BxXUK3rNps9/iRdOf0U2@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsj8gsfE287Fi1icMNKQr4w/UvNUupWElLB/NWTrWu5RUfHDOz
	jTQsp3u9+D5oCTAH45Egg4aq0cNlwjySlno2lFrjjU3QfOQdlJbfT6c0oPIZN1kXyFQrlhIPMSd
	9urLRUboa4A==
X-Received: from dybrc16.prod.google.com ([2002:a05:7300:d810:b0:304:835:911])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6448:b0:2ea:b975:3db1
 with SMTP id 5a478bee46e88-3039867c25amr11864746eec.23.1779303993357; Wed, 20
 May 2026 12:06:33 -0700 (PDT)
Date: Wed, 20 May 2026 12:05:30 -0700
In-Reply-To: <20260520190538.142018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260520190538.142018-25-irogers@google.com>
Subject: [PATCH v14 24/32] perf timechart: Fix memory leaks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Resolve a major execution-time leak of backtrace strings in the timechart tool.

- Modify cat_backtrace() to return dynamically allocated memory via
  open_memstream(), transferring ownership to the caller.
- Free the returned backtrace string inside process_sample_event() immediately
  after invoking the tracepoint handler.
- In handlers like pid_put_sample() and sched_wakeup(), make a separate copy of
  the backtrace using strdup() if it needs to be persisted in the sample struct,
  preventing lifetime issues and double-free vulnerabilities.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-timechart.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 1d24d8738519..d2e15d02304e 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -299,7 +299,7 @@ static void pid_put_sample(struct timechart *tchart, int pid, int type,
 	sample->type = type;
 	sample->next = c->samples;
 	sample->cpu = cpu;
-	sample->backtrace = backtrace;
+	sample->backtrace = backtrace ? strdup(backtrace) : NULL;
 	c->samples = sample;
 
 	if (sample->type == TYPE_RUNNING && end > start && start > 0) {
@@ -433,7 +433,7 @@ static void sched_wakeup(struct timechart *tchart, int cpu, u64 timestamp,
 
 	we->time = timestamp;
 	we->waker = waker;
-	we->backtrace = backtrace;
+	we->backtrace = backtrace ? strdup(backtrace) : NULL;
 
 	if ((flags & TRACE_FLAG_HARDIRQ) || (flags & TRACE_FLAG_SOFTIRQ))
 		we->waker = -1;
@@ -489,9 +489,9 @@ static void sched_switch(struct timechart *tchart, int cpu, u64 timestamp,
 	}
 }
 
-static const char *cat_backtrace(union perf_event *event,
-				 struct perf_sample *sample,
-				 struct machine *machine)
+static char *cat_backtrace(union perf_event *event,
+			   struct perf_sample *sample,
+			   struct machine *machine)
 {
 	struct addr_location al;
 	unsigned int i;
@@ -577,6 +577,7 @@ static int process_sample_event(const struct perf_tool *tool,
 {
 	struct timechart *tchart = container_of(tool, struct timechart, tool);
 	struct evsel *evsel = sample->evsel;
+	int ret = 0;
 
 	if (evsel->core.attr.sample_type & PERF_SAMPLE_TIME) {
 		if (!tchart->first_time || tchart->first_time > sample->time)
@@ -587,11 +588,13 @@ static int process_sample_event(const struct perf_tool *tool,
 
 	if (evsel->handler != NULL) {
 		tracepoint_handler f = evsel->handler;
+		char *backtrace = cat_backtrace(event, sample, machine);
 
-		return f(tchart, sample, cat_backtrace(event, sample, machine));
+		ret = f(tchart, sample, backtrace);
+		free(backtrace);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int
-- 
2.54.0.746.g67dd491aae-goog

