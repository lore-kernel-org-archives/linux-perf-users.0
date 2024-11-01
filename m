Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75651CB522
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Nov 2024 17:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482044; cv=none; b=ru25RkFnk3Q/jqz8J35eu5Kuuf/UKqW/zvENA/Fkr2dR0wQ73sgoZ+soo7iT3mu0qi1ccBQyM5SFbOR2hRgp/TOag3xw/R6rB/WwAILPCOMWfRBMqW5cjKnoJgmcYXQbkhtvhiZFnidlF9rnQaRQFSO2nLarTdofRZi+otvk6x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482044; c=relaxed/simple;
	bh=KU9rwIN6d95c30EkDh282i5OPjsEk/eTWUcP6OHGtYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N8fHudUg3ii0jHyByBmhP+qk0bSABEOnU1mgnBjekJjW0j2IO5fkR85STTIUPp2c0DWtlAtDtRsfZjFEP1yY3aIbyUgEFadBpLqcZYSlL5sh8qU3PabMFfIcmnKVLlg/M/tmQZYag1xwDaJhmaG5IvffI2mBkh4SYPw0mOmt7zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com; spf=pass smtp.mailfrom=engflow.com; dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b=HOIFhwpC; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engflow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b="HOIFhwpC"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-83ac817aac3so90516339f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Nov 2024 10:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engflow.com; s=google; t=1730482042; x=1731086842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRncpCVsFZrGgtk3qlgEv2y6veWYinM5Xkv8y5SyOvk=;
        b=HOIFhwpCstxH14PQIhfA4c8u6+C4Ca260T2Wm/BfeAA4h/JIlm/F50jhWsyS7uQxvZ
         zn6C4/htHSPEoWyCd+7pyWJt8v2Hp4hSWMpoJxFod2Diuqi5QgdS39uXSnFBKGuwIOLv
         4kZy1mfLixqbbsyAAnkZvo3Ix7Egjgf2r5vEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730482042; x=1731086842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRncpCVsFZrGgtk3qlgEv2y6veWYinM5Xkv8y5SyOvk=;
        b=acaRwQ662uXmbejGEK6xlFTT/B1sEgv7GDhmttwcmB/P/dV8OT3sBcnLeY/Kpn9XrX
         kaT40wvxbWQ7kIK+bXXd0z1Ntw3mkA0xMIdGcFvRxiPUSA3r2XLEWJO0q93JLalethVn
         007j2DtkSiy0B9BGRClq5ACp6v2cPynHQlj/gJShz8T/L9Diy+R5xo4ta8wo/KMRRjLY
         wiItPPSEpIzSZ5HrmXJwCG52MwEe6w7o8lw7DeVeUoUBbO/wuSOp2Pd/7gRk/2ZaFlzS
         MN2BbXnRo5amgBj3UXhpnVP80xM27igy5wMB+KRJdVTcLdULi2vocIR3ZfZi1K6Jv8F0
         pDmg==
X-Forwarded-Encrypted: i=1; AJvYcCV2cFMKugVevyqRR2xUUZkLnXGUc1tWInPmBI2DfH0zJNOWEr9UzaLsn8AmhNm2o1aPb9l8851VrXcBVMZuJUw1@vger.kernel.org
X-Gm-Message-State: AOJu0YxRD8i3TeeakSoPW4sRiuwxoIUjET908RhbsceL+Q3EYdnt6d0m
	yP/I38xOqy0n7AzJ39wBGPI9Udd1Cd0722ICjoE6/StgqeOi/67kfsTONkyaOPI=
X-Google-Smtp-Source: AGHT+IHMIzf1E2Ob3z1d3xzjtPWR3YAEEitFND7Do7HMOKx72yRKrl7lXdSjJQnSSV5wvzIM0sAUjw==
X-Received: by 2002:a05:6602:1354:b0:82d:754:5026 with SMTP id ca18e2360f4ac-83b566edf89mr1580062139f.4.1730482041992;
        Fri, 01 Nov 2024 10:27:21 -0700 (PDT)
Received: from benjamin-test-build-vm.us-central1-a.c.engflow-remote-execution.internal (213.193.56.34.bc.googleusercontent.com. [34.56.193.213])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de048b15f8sm812376173.37.2024.11.01.10.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 10:27:21 -0700 (PDT)
From: Benjamin Peterson <benjamin@engflow.com>
To: 
Cc: howardchu95@gmail.com,
	Benjamin Peterson <benjamin@engflow.com>,
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
Subject: [PATCH v2] perf trace: avoid garbage when not printing a trace event's arguments
Date: Fri,  1 Nov 2024 17:27:14 +0000
Message-Id: <20241101172714.84386-1-benjamin@engflow.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241101005338.5846-1-benjamin@engflow.com>
References: <20241101005338.5846-1-benjamin@engflow.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

trace__fprintf_tp_fields may not print any tracepoint arguments. E.g., if the
argument values are all zero. Previously, this would result in a totally
uninitialized buffer being passed to fprintf, which could lead to garbage on the
console. Fix the problem by passing the number of initialized bytes fprintf.

Remove the return value of trace__fprintf_tp_fields, since it was meaningless
and ignored.

Fixes: f11b2803bb88 ("perf trace: Allow choosing how to augment the tracepoint arguments")
Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
---
 tools/perf/builtin-trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d3f11b90d025..4e785ea29df6 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3021,7 +3021,7 @@ static void bpf_output__fprintf(struct trace *trace,
 	++trace->nr_events_printed;
 }
 
-static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel, struct perf_sample *sample,
+static void trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel, struct perf_sample *sample,
 				       struct thread *thread, void *augmented_args, int augmented_args_size)
 {
 	char bf[2048];
@@ -3087,7 +3087,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		printed += syscall_arg_fmt__scnprintf_val(arg, bf + printed, size - printed, &syscall_arg, val);
 	}
 
-	return printed + fprintf(trace->output, "%s", bf);
+	fprintf(trace->output, "%.*s", (int)printed, bf);
 }
 
 static int trace__event_handler(struct trace *trace, struct evsel *evsel,
-- 
2.39.5

