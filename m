Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31831D47B3
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Nov 2024 23:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730936729; cv=none; b=a2AsHUixTu13G/2zHUJM9p9pJsAFQ8p+i9/kW0VKE8tTh7p0y3Ziv8GM5O+mMNPvY98C+WduTUKiYeJv9QemDUeSbXJZBpd9+WquHD5djSgEM2TyrRSU+ZOMRBwlmrPuZM/MwnBJeMzz4lpBnune80UaIQ8669oBnB73ok3UH7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730936729; c=relaxed/simple;
	bh=Qfirc4O31/ZM0gFfIfa1xSrbiS63G6QjT5cC1qr0Dto=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FzVezzOjuHHHibkXpEaH4gAQJuBIsmuPFG9XuXxDasn3xI3v9NMUkKJuW6n8X/XDxi6SRrQz/pBa9BlMvoqr5pm2j8njMiAhHvip4g2rbr42eDlpCMvQXCX8JK6b/dVe40DsdpUn3XUVCqwbaoJsuqx3lem/ibJY9stsrzrhXes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com; spf=pass smtp.mailfrom=engflow.com; dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b=MWfoRhFh; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engflow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b="MWfoRhFh"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a6c2077afcso1659865ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Nov 2024 15:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engflow.com; s=google; t=1730936726; x=1731541526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ptJC94diYWOUdvMtH8z3GbtBqdTfvSWNLK4dH6tAaKg=;
        b=MWfoRhFhDpNqmQBQZsy3r4RJ70C6XYo0FdlhupqUINiaC5Ry+MiVXF6BhW/2aimp27
         Xaf8xjbEkl/XfOazdEa14laUvQ/JMBhlcwFAUQ2s+KRVr51A9OgYAIlxKxlB8UwSxGFP
         nzv3DCwhS1hONMvBJqfUTnSCyzpgSQY+YvgVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730936726; x=1731541526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptJC94diYWOUdvMtH8z3GbtBqdTfvSWNLK4dH6tAaKg=;
        b=o/OhdjAdDP0WwkEX3Zy7WkrQZPXulPmHw9wadGoGZuq2DUa1c1p2MCSTRSuHOrnvEn
         wV02D0JFLuloRala5YeqAODusond8hPf9C8wV4FEOAUk8Sytsq4eBDeUwwJCuLGACZC9
         sVwBRnaYx0kC+87LONrRyO9ubI7mSXx42/Mhm1fX8H4FU0EjNJJ5VJFj0Z+qFSg5cC6I
         uDB9tFvCCxvCCYdzpILvjm2m8PD5PU6CMJH5e3xHcgOtHEGtaumaCnhhB4Ey7yrLT/Wd
         7zjTOO82ASGtNUajNh0f3H98kC14h7cBlkFFl/hYQPGReaoIfCIa6kb+Jf4vB9iRerqc
         xdHw==
X-Forwarded-Encrypted: i=1; AJvYcCXg6TR6PVqdjHLA5z5DrSXoisOy9vZolOFxsGPXFKRg0TyoWaj2yttzvxM1LOpJOFG8ONtg2F38/BCLYeBeD/PL@vger.kernel.org
X-Gm-Message-State: AOJu0YzDCHZM7eb4YFzjS6+bJ/V+1iU7uTNzUqeNp2u8yEFjaVSZQw4A
	eTE0HnI19Zbwn+lO+sYnOsylD9OZmPxbWe+gsT/1u/YGX5H9XnEIUn5JW/EnZyI=
X-Google-Smtp-Source: AGHT+IH5eRb7TmUcP7kRbCY2LBcoVcAb3ol/Ro6z2gFuEKQC361+qx8U8LRIAjY3kCj2oElyLAjt9w==
X-Received: by 2002:a92:cdac:0:b0:3a2:6cd7:3250 with SMTP id e9e14a558f8ab-3a4ed29dcdemr417202125ab.10.1730936725982;
        Wed, 06 Nov 2024 15:45:25 -0800 (PST)
Received: from benjamin-test-build-vm.us-central1-b.c.engflow-remote-execution.internal (209.179.154.104.bc.googleusercontent.com. [104.154.179.209])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6eac8c5c0sm127745ab.6.2024.11.06.15.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 15:45:25 -0800 (PST)
From: Benjamin Peterson <benjamin@engflow.com>
To: 
Cc: Benjamin Peterson <benjamin@engflow.com>,
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
Subject: [PATCH 1/2] perf trace: do not lose last events in a race
Date: Wed,  6 Nov 2024 23:45:17 +0000
Message-Id: <20241106234518.115234-1-benjamin@engflow.com>
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

