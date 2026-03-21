Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BBD36D9F3
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 06:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774073695; cv=none; b=eA4OJtf6msDV5O5kE6QJV2+5eS5EvLChWfrJs/7S+WxBH/kvyW1JzNYif9VGRDXAM1YjopViJtRYO6vlCTiKx2HixYhew5wXqsYbWP/yME3++A+VKw0SwDd95Vcr2GMzs9XTyEakVdC7yWq5Ix7fzll54KsJ1V2ZBTyfpex/hcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774073695; c=relaxed/simple;
	bh=2Bib7wgHxSMJgG7dHD7S9FAf/Hs2BvL35JFJwF61oA0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=HPYt6gIvLEAkXFvdoAZdmSKu2jObOqD/SHoaqVA9tYcsTZmCMWK4PdcNulF25A9pVGZwBgdxDal/7MOhaDuP4dODTFNIMLFT/1LjHIrY1+O7FU3wXIJfd4D07F6M7WSW7cpEOPUcvGFaF5jMXKqwPILOlQiDeQIaDUZZqEDmbkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ii3xail8; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ii3xail8"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0ffce2570so45649387eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 23:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774073693; x=1774678493; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8PACYQbbmNhHgKdqEmTpeBymBEr9h1nJcy7rekDFmHk=;
        b=Ii3xail8pmyMoltkt0msegQDa33rRcdmOkfQH75YOP1zLKQfEc7lWTrFoafR509IQh
         rE4lCEfiFx9WVNbAX54ocDzIdt3ycMi7bMx5TdYy/dIkzUG36V5+k1lE15SlUNLRScYx
         9+Y0qO+M9/RTY0E6GBH7gHpoj3tRb6O9tj0uRSrSxhkjtwKRgT4Z8ecagPnn/RiRQV8k
         +8koAC8ZqEMxdADMR3KsNuqeGeaptsCwaZb7HDfxZ0P6xQXQd4bvD/TGebg2BTUqA1GB
         OlyNB7wvjw7bJMf4QIOLJUJvWGHVLebgPr8gHQ7o48bSJugn3LVQbFRHHkAEgCqOcMT8
         ZkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774073693; x=1774678493;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8PACYQbbmNhHgKdqEmTpeBymBEr9h1nJcy7rekDFmHk=;
        b=nRIFFAio/XEcCshha9Nc7r0917JSw0lpTGAqOq7ZC6X7gbXNSq7y4UMvlbBAchX1Va
         Z7uSVeUFJv3cOJki8Lr6QpYoBpu0AorAM88eyPZZphqWrFq7J+jc6jQZZTnwa/atfs1A
         xORtAjo38t9oCE72hcilU2uKmaxld44NAD0yMkgp32/fSIS1s8+xVdGnfH9uoFfAEGNu
         2soULYWFxVz3tZyh9u9VI3Vp4r9POHlBSpYeS+WCsGwh7UAeaX1Qyd4m44oVPW+ehjBw
         XFd94dQ+z2pscXB6uZzS+0Bs/aDMrlnKKp1bEA+NPyrJJ3dhwcttQEHiMRfLcbGvMfeY
         g8Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUJBhSSF7PKxRi2TqWUUtMrTrlaDTIz/hcTY0HI/J2JyNq4rr0/QScPJsXq24OeAw7wv6A7iowTYpICFY94KfjM@vger.kernel.org
X-Gm-Message-State: AOJu0YwyGYqaRRzBTPGM+GR34eUWhXViqehZCO8YBUtmLR5EQDejVuCN
	IqhjqP9PkCu2hHqIymd7j58bRn5av7xbYvnhmB/sMQQD0R4rQOEIOmohEKl9uPfHYcgu2kFfjDX
	0C2W9Dvum0Q==
X-Received: from dycmq1.prod.google.com ([2002:a05:7301:781:b0:2c0:d73f:8519])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e785:b0:2be:2f58:2ef5
 with SMTP id 5a478bee46e88-2c1095d7861mr3213370eec.1.1774073693178; Fri, 20
 Mar 2026 23:14:53 -0700 (PDT)
Date: Fri, 20 Mar 2026 23:14:47 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260321061448.810525-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf sched: Avoid segv if tp_handler not set
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Doing a `perf sched record` then `perf sched stats report` crashes as
the tp_handler isn't set. Add extra checks that tp_handler is set
before accessing through it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-sched.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index d083e2bb7703..196f263ff667 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1525,7 +1525,7 @@ static int process_sched_wakeup_event(const struct perf_tool *tool,
 {
 	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
 
-	if (sched->tp_handler->wakeup_event)
+	if (sched->tp_handler && sched->tp_handler->wakeup_event)
 		return sched->tp_handler->wakeup_event(sched, evsel, sample, machine);
 
 	return 0;
@@ -1809,7 +1809,7 @@ static int process_sched_switch_event(const struct perf_tool *tool,
 			sched->nr_context_switch_bugs++;
 	}
 
-	if (sched->tp_handler->switch_event)
+	if (sched->tp_handler && sched->tp_handler->switch_event)
 		err = sched->tp_handler->switch_event(sched, evsel, sample, machine);
 
 	sched->curr_pid[this_cpu] = next_pid;
@@ -1823,7 +1823,7 @@ static int process_sched_runtime_event(const struct perf_tool *tool,
 {
 	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
 
-	if (sched->tp_handler->runtime_event)
+	if (sched->tp_handler && sched->tp_handler->runtime_event)
 		return sched->tp_handler->runtime_event(sched, evsel, sample, machine);
 
 	return 0;
@@ -1840,7 +1840,7 @@ static int perf_sched__process_fork_event(const struct perf_tool *tool,
 	perf_event__process_fork(tool, event, sample, machine);
 
 	/* and then run additional processing needed for this command */
-	if (sched->tp_handler->fork_event)
+	if (sched->tp_handler && sched->tp_handler->fork_event)
 		return sched->tp_handler->fork_event(sched, event, machine);
 
 	return 0;
@@ -1853,7 +1853,7 @@ static int process_sched_migrate_task_event(const struct perf_tool *tool,
 {
 	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
 
-	if (sched->tp_handler->migrate_task_event)
+	if (sched->tp_handler && sched->tp_handler->migrate_task_event)
 		return sched->tp_handler->migrate_task_event(sched, evsel, sample, machine);
 
 	return 0;
-- 
2.53.0.959.g497ff81fa9-goog

