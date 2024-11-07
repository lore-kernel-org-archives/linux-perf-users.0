Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2EB19B5B1
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Nov 2024 23:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731021706; cv=none; b=byYnC9Hr9vWoWxq8mKdw6wswbhADkQIbIR+xqmjncqmjPUVVZHxoBsxM6W/KKuS7aKFmQPh1QRCCoqhQORNTYqroHrtYuy3u5r0fPg83KUUDTsfDJnYhRZBwsHpBeq3Vwcn/CeEqDcFQkxM5RBSWLGrfsco592sRF5Q9cdGzmlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731021706; c=relaxed/simple;
	bh=NfdgTRm/InOoY4ntCsmJxzUPoVo/2VSMOMLiVzNxSNU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZGBBED99IPJvQ/a/WMjE+vjYSjO4zLDwMBHVuqbiLvCnYfeY1nPAPLjX/0WKdDF4V8k18e0AYH4sWcI2t8E3MN+jv1JbJlR/3me5DqufFOtginzAF1cHiW+7ehnPMAqp5mzTvvlim7DoL9zg4s4hmUt5H7Qke+plRQMPNrkO7kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com; spf=pass smtp.mailfrom=engflow.com; dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b=pwA8qsxi; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engflow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b="pwA8qsxi"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8323b555a6aso70407639f.3
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Nov 2024 15:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engflow.com; s=google; t=1731021703; x=1731626503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsmnH9g+AFTEve2z/U3acIj1xPrEpnzCOf7R7M+xMvU=;
        b=pwA8qsxiwpUn93pKayfn9vRCxwMU1CCfHqN7UkorsZx8SwtAbIlaHNW7P+uIcbySM/
         8/E7preXMS8YAPHvECfd5ofE7XHo0S14WB8ayeVd18R8JqwlcwGjHdSg08R3wfkuMr2v
         2YOpVS9JqtGpL2a5frjt5HluVo7vIngQ6JQ6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731021703; x=1731626503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZsmnH9g+AFTEve2z/U3acIj1xPrEpnzCOf7R7M+xMvU=;
        b=WwooGKSPMGUvGMDLDKsLmc2D094W9apRF6J5a5vMLmBu8Px7ev4WHA/qMpCQwtd64b
         NxAdGYY9nSmgo3sKItLT/9D3aAfIkPTlm98IzXE/QXMVnymuWM6S317cN2bWFVkqVbcW
         fK4fJpww9XSKSsezBY3M4tE+xUSaaIScqMPdrDCOSX1elnwQhZbwk/BP9SDtFo4ILAbH
         Woe9q6NMR4vL2XMmTwfU//e7dld4H8fZw9xMO32g//9PB2JgOwygbDyE/o+LvPr1wg35
         wXLWVIaeKCwVx7+HqCOZRSwKlSZy9ciEGJaRZmPgNjIaJVu18lMYKe7v17O1t8iHjlhp
         RBgw==
X-Forwarded-Encrypted: i=1; AJvYcCXJb+QGJ2W6E3LHZpv3qkommhPIP9D8i/SOzw38o1CCX4RU2qVsuRvwoSoc6N4x31itKgmnU0CxGSYTXuPoH85W@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0IJEvR0r4OHHbFdoMIF29auStc1PUsiDAtPRVybu0V/baONax
	QAaB1TgUsLDywRLsSVMt9qcwP5jamoQaWEIMC7nARzzWmA5m2HGCDTsM5W0O1Vo=
X-Google-Smtp-Source: AGHT+IERedhhY9wPYgSbRoVsTnLZkBbzCxIRshmLxVugakPRcZPw0rS6tFuG7hnLt4NCcxAJTHYjjQ==
X-Received: by 2002:a05:6602:1586:b0:82c:ed57:ebd9 with SMTP id ca18e2360f4ac-83e0336a657mr85338739f.10.1731021703490;
        Thu, 07 Nov 2024 15:21:43 -0800 (PST)
Received: from benjamin-test-build-vm.us-central1-b.c.engflow-remote-execution.internal (93.126.232.35.bc.googleusercontent.com. [35.232.126.93])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de5f82e773sm533023173.68.2024.11.07.15.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 15:21:43 -0800 (PST)
From: Benjamin Peterson <benjamin@engflow.com>
To: 
Cc: Benjamin Peterson <benjamin@engflow.com>,
	Howard Chu <howardchu95@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH v2 1/3] perf trace: do not lose last events in a race
Date: Thu,  7 Nov 2024 23:21:26 +0000
Message-Id: <20241107232128.108981-1-benjamin@engflow.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a perf trace event selector specifies a maximum number of events to output
(i.e., "/nr=N/" syntax), the event printing handler, trace__event_handler,
disables the event selector after the maximum number events are
printed. Furthermore, trace__event_handler checked if the event selector was
disabled before doing any work. This avoided exceeding the maximum number of
events to print if more events were in the buffer before the selector was
disabled. However, the event selector can be disabled for reasons other than
exceeding the maximum number of events. In particular, when the traced
subprocess exits, the main loop disables all event selectors. This meant the
last events of a traced subprocess might be lost to the printing handler's
short-circuiting logic.

This nondeterministic problem could be seen by running the following many times:

  $ perf trace -e syscalls:sys_enter_exit_group true

trace__event_handler should simply check for exceeding the maximum number of
events to print rather than the state of the event selector.

Fixes: a9c5e6c1e9bff ("perf trace: Introduce per-event maximum number of events property")
Tested-by: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
---
 tools/perf/builtin-trace.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d3f11b90d025..f6179b13b8b4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3096,13 +3096,8 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 {
 	struct thread *thread;
 	int callchain_ret = 0;
-	/*
-	 * Check if we called perf_evsel__disable(evsel) due to, for instance,
-	 * this event's max_events having been hit and this is an entry coming
-	 * from the ring buffer that we should discard, since the max events
-	 * have already been considered/printed.
-	 */
-	if (evsel->disabled)
+
+	if (evsel->nr_events_printed >= evsel->max_events)
 		return 0;
 
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
-- 
2.39.5

