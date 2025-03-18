Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632521C3BE3
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Mar 2025 04:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742271297; cv=none; b=egVkDuF6WdG5jttv6Ha+e3AT6MyyD3M16r2d0Dbh3FFeO99q6/foHYJgj/9h4Y0RWSZedPexACj78vPSU/+IwJBi8ApcnJ9+d/W+sboB43vfIEMfS6JYmyybhGJOEZbXhreWthhask3fnfWCtUsAMi5ZKJijGPgX8TluDey1kXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742271297; c=relaxed/simple;
	bh=nHqyEJ4/Frkdc7A1GAcvK78BriUbPBng6xe97aPEwzw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=FAClm3EthHT9OfWmsR9ujQFIa/4NVSGsDW3oaAnTMDUBpux6kXEfpvp4nPqFoduaxCi3qZS9sIpV3lrZ7wxNK7Dc1/7dLTy4+vtMH4FeDk9S4h3YV0ftS8uDirJfhR6RcA8OJ1bzNH/Qzw9z5KTWygulfdKxONA66mk4qGuy8OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3/gIR3O9; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3/gIR3O9"
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-72b9139c37fso1103984a34.3
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 21:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742271294; x=1742876094; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aCcMnU2SSC+0PDpp+5Nsu8Z6wRNoNoKoEAEvbkUeMQ8=;
        b=3/gIR3O9t1KeDuCWgZuOcF9e1h/G64BroUP/Jp9Vp9j3rKh9Ryp2VjwNSRlBvLoCq1
         ZgrXq5k5nuPHlBg1zU/N1P2rw9MvXP/Paehnss8UYpo0/c5YU7qWMPJ8fIWmibk/orj5
         ZkoJBMbcEoOA+hfSDS62kIUFnPMbKPzEkF4XszZsa2zkhopRSKNTYcX95V8qeEiXmCkB
         gaFIj3hpdQSDqcEg/g/eHVjwR95B5q3gBmkG5eSj9oDnErWFAronJ1HE89+6ohwMtqFk
         W2MVTlxu15Y9AG1KJjktG1ci4XL0Q42mozoEG2/OWnVd8motjHyOl0n9BR3+iAWdYbju
         ZJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742271294; x=1742876094;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aCcMnU2SSC+0PDpp+5Nsu8Z6wRNoNoKoEAEvbkUeMQ8=;
        b=ogQtBv4Kp8/gr87KL9Apqj9Lhbq9vtmv43enZYoisomUKQ+7JfkzNX8deNvzL/aTwE
         JRo5DvafMXlvscvSI47eziH79bsaWMcMFVE0Cu3b9XXg8DtQ+Q+xNUyJBllJY/jq5YED
         DY9Fy74CIB1TQo/421RusTKEodb6rcQR2VAL3kPjg95S8QJHMw3ZUfplcwfMNxJYNxHy
         N6HKrcJa9DrMjQr8iCgQdTqn82R+VuVxo6pF/VHlt4YlM6rRHICVWXrpltCyD+6VOS64
         Y4mx1iEqQgpTR3Jmpd/cnAg7aWDroTbcysmFPg1Ba1lFBquxJyVpmGSHa2GWgst7+0nf
         YXUw==
X-Forwarded-Encrypted: i=1; AJvYcCWeTg+gWZWPZruI04uKRxyBK81oVscYgnfDM4mug9vy8jzGvtG9LYloCoqAWJyy76/sgtbJTzjT6gvwYtKytXRg@vger.kernel.org
X-Gm-Message-State: AOJu0YxrejardTyw3BkC3yAUkuhxPVYN6sjscYmMOTIr3WMoOAevEa5c
	kJNhHHdbbNIJc6JtPYhrAH5BkvkvtgudLxWCPt/z3wDzRe+yoGmIxWGnS6AY0TGOGfQCqFBIWBZ
	bqgeSBQ==
X-Google-Smtp-Source: AGHT+IFr8MNVN+8peZtfP0hpzvVNp7OmNgDD1BofaL+Cr8mSNZvBSEabZbssxCe08EmPkK0Yd91sAqD0cAEa
X-Received: from oabwh38.prod.google.com ([2002:a05:6871:a6a6:b0:29e:6524:e13e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6830:25c4:b0:72a:449e:2b69
 with SMTP id 46e09a7af769-72bbc543b53mr8336303a34.28.1742271294520; Mon, 17
 Mar 2025 21:14:54 -0700 (PDT)
Date: Mon, 17 Mar 2025 21:14:40 -0700
In-Reply-To: <20250318041442.321230-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318041442.321230-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250318041442.321230-4-irogers@google.com>
Subject: [PATCH v1 3/5] perf evlist: Refactor evlist__scnprintf_evsels
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Switch output to using a strbuf so the storage can be resized. Rename
as scnprintf is no longer used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c |  9 ++++++---
 tools/perf/util/evlist.c    | 19 +++++++++----------
 tools/perf/util/evlist.h    |  3 ++-
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ba20bf7c011d..cea5959adadc 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -51,6 +51,7 @@
 #include "util/clockid.h"
 #include "util/off_cpu.h"
 #include "util/bpf-filter.h"
+#include "util/strbuf.h"
 #include "asm/bug.h"
 #include "perf.h"
 #include "cputopo.h"
@@ -2784,13 +2785,15 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		record__auxtrace_snapshot_exit(rec);
 
 	if (forks && workload_exec_errno) {
-		char msg[STRERR_BUFSIZE], strevsels[2048];
+		char msg[STRERR_BUFSIZE];
 		const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
+		struct strbuf sb = STRBUF_INIT;
 
-		evlist__scnprintf_evsels(rec->evlist, sizeof(strevsels), strevsels);
+		evlist__format_evsels(rec->evlist, &sb);
 
 		pr_err("Failed to collect '%s' for the '%s' workload: %s\n",
-			strevsels, argv[0], emsg);
+			sb.buf, argv[0], emsg);
+		strbuf_release(&sb);
 		err = -1;
 		goto out_child;
 	}
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 49e10d6981ad..96cfc7ed1512 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -35,6 +35,7 @@
 #include "util/util.h"
 #include "util/env.h"
 #include "util/intel-tpebs.h"
+#include "util/strbuf.h"
 #include <signal.h>
 #include <unistd.h>
 #include <sched.h>
@@ -2468,23 +2469,21 @@ struct evsel *evlist__find_evsel(struct evlist *evlist, int idx)
 	return NULL;
 }
 
-int evlist__scnprintf_evsels(struct evlist *evlist, size_t size, char *bf)
+void evlist__format_evsels(struct evlist *evlist, struct strbuf *sb)
 {
 	struct evsel *evsel;
-	int printed = 0;
+	bool first = true;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel__is_dummy_event(evsel))
 			continue;
-		if (size > (strlen(evsel__name(evsel)) + (printed ? 2 : 1))) {
-			printed += scnprintf(bf + printed, size - printed, "%s%s", printed ? "," : "", evsel__name(evsel));
-		} else {
-			printed += scnprintf(bf + printed, size - printed, "%s...", printed ? "," : "");
-			break;
-		}
-	}
 
-	return printed;
+		if (!first)
+			strbuf_addch(sb, ',');
+
+		strbuf_addstr(sb, evsel__name(evsel));
+		first = false;
+	}
 }
 
 void evlist__check_mem_load_aux(struct evlist *evlist)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index edcbf1c10e92..5fe5cfbbebb1 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -20,6 +20,7 @@ struct pollfd;
 struct thread_map;
 struct perf_cpu_map;
 struct record_opts;
+struct strbuf;
 struct target;
 
 /*
@@ -430,7 +431,7 @@ int event_enable_timer__process(struct event_enable_timer *eet);
 
 struct evsel *evlist__find_evsel(struct evlist *evlist, int idx);
 
-int evlist__scnprintf_evsels(struct evlist *evlist, size_t size, char *bf);
+void evlist__format_evsels(struct evlist *evlist, struct strbuf *sb);
 void evlist__check_mem_load_aux(struct evlist *evlist);
 void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_list);
 void evlist__uniquify_name(struct evlist *evlist);
-- 
2.49.0.rc1.451.g8f38331e32-goog

