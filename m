Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9129D1F1536
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Apr 2025 20:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743624982; cv=none; b=j/541dJmOdjpXysYlkXB5EiiBFpmX40iOpJzlvwl13K5rrpfWC0++/TVxm4jqsqnxD6+yC4F7KHNzvfjLsOUaVv8GL5mjzScxrRDBYa7321J70MVpLmsU/pgo7X4ppvOoSOM3ndRL3upY+c78QMZt4P/DwdriMhMBtgIQupxcRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743624982; c=relaxed/simple;
	bh=ceFQQBDmr9eZ5yU3Gt86zh2f8+RxL6DcgnNhvGpxxF4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=OCPGMAy2Fnlnu6zCHEx0P6tJL8TNuuUUidH7BobCBzgCAKCC4WSYr0jCMdpwxmj8FfQGe4yrouMpAKCdErQlNNBmlNJluvG9vZxeAB10a7/lyYwkzR9OUWAzBrXZ3QkjwPyUC4s/4kEHe/CkSDlIDX0BRmqNFXEQnfz81Hsf+bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DZhuGTSV; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DZhuGTSV"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-225429696a9so3061695ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Apr 2025 13:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743624980; x=1744229780; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/Qfr113zCIU5rUe0KDXRj0KUMUinv6gA3VPY5V4Jtk=;
        b=DZhuGTSVbrRzQ78VxJpp2S0YKG/IZxKIueRqDM5j/ybLpqR7464l9ZG00hWPgha1ud
         AsZliy6rlcBYbDhyBYqmojmgxp8j3tzkhK8x2xAguMo93sS5BJNU4ECof3vPOFSAMdWE
         lsvHavXZhMb7fA9dU6dIIpq5gc0rtCQv1eZWiDjQPAwcKA3eoKEdfl+kR3wCtx+Yqh8h
         isVnkslUqR42ozLTP5sYc7wYmB241N0yltF0TjP8/gE9AOhhfFSjx1ih/efvdI3Y7qlD
         LJaAsQ929KugZkuflXloQ0zZMMjF3OaEdTztJmiCADwGbhi2koUkAYqBmOYs+EZLAZNI
         ckeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743624980; x=1744229780;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/Qfr113zCIU5rUe0KDXRj0KUMUinv6gA3VPY5V4Jtk=;
        b=wZb2LyY2rPHAco2tJbVnrQ/55H6Hq/7fwMa5yjftKNiR35mewYLkRFfmdaZ8QfNp3f
         wbW7JiMUV2eEd/O41gY8B8AFKlYojPczBLzqNsnoIpWronq+wsb9+gfPWi10qD17vjXO
         hXMK/zW62IYr1Z3WErwjUpqGKOEnuLK2aZzfRZxA0gIsgUm0H1tAEMf1v90p1dns1Qx7
         lmDeI24cNqg+nqxAncc2pa36HgUg+jQYhBp2C3T7rvfjX6nKqlC/vNBZUCWXOPWPO+oU
         tuBPYC6HpvyNGGE6ULCtdMB0jPPy3pe+vjR57EFSDFz/pBhHZf8IRN2gO/fpTpBmoFcC
         NjIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgKYIVAWtBciZCgmL0l30ODk4k1uZlh3CT5QmpqGNwjCgbBt4plscvrtWf4bJmJwBRUvyAez1RoBuMN+gdF2af@vger.kernel.org
X-Gm-Message-State: AOJu0YxOno5eoMA8LdTGpJvOCFclJBZ6jWQDmWgayKRJ6tRfoAVZohre
	8ZulMgTcvBUp+IboQ17dMTkaFJVxKhj+qFanUHSHWsQ+uCafXCi/dwFv8ANzA2+Fhz4EeP3ym+M
	EZAURVQ==
X-Google-Smtp-Source: AGHT+IETEif39DUX+D51g2bBbhpyP0oodQFGAfpXoFFKrQ1cjkkkGk0Knxqrd1W1Zzu+AtS/B6svQpHL6ora
X-Received: from ploc6.prod.google.com ([2002:a17:902:8486:b0:220:e952:af68])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f543:b0:221:7b4a:475a
 with SMTP id d9443c01a7336-22977e0c7aamr930985ad.52.1743624979911; Wed, 02
 Apr 2025 13:16:19 -0700 (PDT)
Date: Wed,  2 Apr 2025 13:15:47 -0700
In-Reply-To: <20250402201549.4090305-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250402201549.4090305-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250402201549.4090305-4-irogers@google.com>
Subject: [PATCH v3 3/5] perf evlist: Refactor evlist__scnprintf_evsels
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Switch output to using a strbuf so the storage can be resized. Add a
maximum size argument to avoid too much output that may happen for
uncore events. Rename as scnprintf is no longer used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c |  9 ++++++---
 tools/perf/util/evlist.c    | 21 ++++++++++++---------
 tools/perf/util/evlist.h    |  3 ++-
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ba20bf7c011d..9a3f7d9f881d 100644
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
+		evlist__format_evsels(rec->evlist, &sb, 2048);
 
 		pr_err("Failed to collect '%s' for the '%s' workload: %s\n",
-			strevsels, argv[0], emsg);
+			sb.buf, argv[0], emsg);
+		strbuf_release(&sb);
 		err = -1;
 		goto out_child;
 	}
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c1a04141aed0..ffb5be41a465 100644
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
@@ -2468,23 +2469,25 @@ struct evsel *evlist__find_evsel(struct evlist *evlist, int idx)
 	return NULL;
 }
 
-int evlist__scnprintf_evsels(struct evlist *evlist, size_t size, char *bf)
+void evlist__format_evsels(struct evlist *evlist, struct strbuf *sb, size_t max_length)
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
+
+		if (!first)
+			strbuf_addch(sb, ',');
+
+		if (sb->len > max_length) {
+			strbuf_addstr(sb, "...");
+			return;
 		}
+		strbuf_addstr(sb, evsel__name(evsel));
+		first = false;
 	}
-
-	return printed;
 }
 
 void evlist__check_mem_load_aux(struct evlist *evlist)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index edcbf1c10e92..21f6bff319fd 100644
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
+void evlist__format_evsels(struct evlist *evlist, struct strbuf *sb, size_t max_length);
 void evlist__check_mem_load_aux(struct evlist *evlist);
 void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_list);
 void evlist__uniquify_name(struct evlist *evlist);
-- 
2.49.0.504.g3bcea36a83-goog

