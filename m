Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD6828CF67
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Apr 2025 17:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306610; cv=none; b=OZszttJPPaVj9wYCoDUthLIpuyf9PPHiz9ht/rv6qeQSTjvREVoQ9sM364VXKNNfjKPZIObG2WmPXF/HdxuPtPMnRkbIzlmHkqw9ODg7Wd7wbItYoJB+2HQSjHuPKSmKkUngsesiHoDuXY3Aom/oQdjQrZ7Z8y3TVZICrAvLws0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306610; c=relaxed/simple;
	bh=G1gAgZUvOfcfqAATJ+QPOb6uS3I1bA5GRxZVqHLeqq4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JMHwNxFvGPkWIp1djy/S3c6+bB1n6VHvH3Nym26rzynAKB+/kIlSdfiLOuBSAAS0ADqhQtcNxkurwgLVkZwR42kcGXBR1k+gsmF/CkJm5uQdNCOzg6iXttgwUNqgWtw3sq3FWweaqbN5rOv5Jajbeq7jEHkn3Fcus4n8lhmDyO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nZ2je+Ut; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nZ2je+Ut"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2241ae15dcbso13033125ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Apr 2025 10:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744306608; x=1744911408; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jBep772rAPnbEAws0gmIZzBWpvWIV/iE0VJyGXGhVdQ=;
        b=nZ2je+UtpxEcOJRbSuZk1OVhBg5siLcwYycv54wdQGkfJjDkrHZFWbpZm9hnJye/KX
         oOuZJtG89k+bnXN8h/Zt/12gxmGtxsj4PNSrkqDxmkdjj7g6vbb96IRsUo3ylccgeqIk
         aN61sgvqFWEed+KihjidyRa9rkQYNohtLOGq/doePbdJTEEtFUclUoANte8l/EaLV4o6
         UHxPQCj6D9Lkynms2mpVy+6Oktspp8z3viXLh1R17vO/Z+nH8kRo3BgD07tRy7zdAKCc
         /85VPmWfS6Tvg1owPSpaCRc/9C42hJeCcJjJ0VlzJhhhxrGfn1t/Q9eP/VQVecXsNPVF
         CXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306608; x=1744911408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jBep772rAPnbEAws0gmIZzBWpvWIV/iE0VJyGXGhVdQ=;
        b=eu3Y3iBOZmud5a5j+AamTADHP5Yx2ldagP040rzQhpHMEKOwtzUeILroB3+7AhDpun
         y5iBpjZLvLO/eeT1sf6wZ/dOVFI/W9dOMyprD+AREYH/x33Dnrhg9d1dHzMeQV++WUDw
         MKo/esjvmuFDtqhhjD/TANlAoP7ED6RQsW4Y9Y+J5kaNxDqOVq7E+t+BzGplZtUrg5KS
         ava5wci+CKH58FwnyHzB0Yi9GWVuE/DHS7tyP3zDvWu9aN3ufiY99R3n0VFjbg+7iesp
         T30FUB3yGs8ngfpOn7xkSjwtDEbKGsS0p/HeriGY3Lss+oioAX1ZJvhlnbOlwOveGqJw
         ++Jw==
X-Forwarded-Encrypted: i=1; AJvYcCX1fVrONqTmh8txGUGfWsxTUPR2r2eMhZw3cdKdhkg7+JIpmmsvnqavKSQQe61qj4t5Oo+meLVb9CWRchNiCEZI@vger.kernel.org
X-Gm-Message-State: AOJu0YzQyk2mdFMWdZGIhyk/SeqyJn4gEF+7UoeGbWXF/EKatj1mrHAY
	fgCYX60l2/aMnSjK8g7qucPvK6N8BenmDIozAS5nlsqe1IXApYqx53zDTFKUeHYQsY+XMrsL+qW
	g/Q8esw==
X-Google-Smtp-Source: AGHT+IFTo0lN/DGGBZMtGdBm9V4Gd+ZDzBjeI4vL2FnktYYk1TbWtujx99ZirSakEtrM/OA2kI73D73SRWn8
X-Received: from plal20.prod.google.com ([2002:a17:903:54:b0:215:48e7:5dc8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4cc:b0:21f:617a:f1b2
 with SMTP id d9443c01a7336-22b42c5bd38mr51689375ad.46.1744306608453; Thu, 10
 Apr 2025 10:36:48 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:36:21 -0700
In-Reply-To: <20250410173631.1713627-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410173631.1713627-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250410173631.1713627-3-irogers@google.com>
Subject: [PATCH v2 02/12] perf bench evlist-open-close: Reduce scope of 2 variables
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Make 2 global variables local. Reduces ELF binary size by removing
relocations. For a no flags build, the perf binary size is reduced by
4,144 bytes on x86-64.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/evlist-open-close.c | 42 +++++++++++++++-------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/tools/perf/bench/evlist-open-close.c b/tools/perf/bench/evlist-open-close.c
index 5a27691469ed..79cedcf94a39 100644
--- a/tools/perf/bench/evlist-open-close.c
+++ b/tools/perf/bench/evlist-open-close.c
@@ -46,25 +46,6 @@ static struct record_opts opts = {
 	.ctl_fd_ack          = -1,
 };
 
-static const struct option options[] = {
-	OPT_STRING('e', "event", &event_string, "event", "event selector. use 'perf list' to list available events"),
-	OPT_INTEGER('n', "nr-events", &nr_events,
-		     "number of dummy events to create (default 1). If used with -e, it clones those events n times (1 = no change)"),
-	OPT_INTEGER('i', "iterations", &iterations, "Number of iterations used to compute average (default=100)"),
-	OPT_BOOLEAN('a', "all-cpus", &opts.target.system_wide, "system-wide collection from all CPUs"),
-	OPT_STRING('C', "cpu", &opts.target.cpu_list, "cpu", "list of cpus where to open events"),
-	OPT_STRING('p', "pid", &opts.target.pid, "pid", "record events on existing process id"),
-	OPT_STRING('t', "tid", &opts.target.tid, "tid", "record events on existing thread id"),
-	OPT_STRING('u', "uid", &opts.target.uid_str, "user", "user to profile"),
-	OPT_BOOLEAN(0, "per-thread", &opts.target.per_thread, "use per-thread mmaps"),
-	OPT_END()
-};
-
-static const char *const bench_usage[] = {
-	"perf bench internals evlist-open-close <options>",
-	NULL
-};
-
 static int evlist__count_evsel_fds(struct evlist *evlist)
 {
 	struct evsel *evsel;
@@ -225,6 +206,29 @@ static char *bench__repeat_event_string(const char *evstr, int n)
 
 int bench_evlist_open_close(int argc, const char **argv)
 {
+	const struct option options[] = {
+		OPT_STRING('e', "event", &event_string, "event",
+			   "event selector. use 'perf list' to list available events"),
+		OPT_INTEGER('n', "nr-events", &nr_events,
+			    "number of dummy events to create (default 1). If used with -e, it clones those events n times (1 = no change)"),
+		OPT_INTEGER('i', "iterations", &iterations,
+			    "Number of iterations used to compute average (default=100)"),
+		OPT_BOOLEAN('a', "all-cpus", &opts.target.system_wide,
+			    "system-wide collection from all CPUs"),
+		OPT_STRING('C', "cpu", &opts.target.cpu_list, "cpu",
+			   "list of cpus where to open events"),
+		OPT_STRING('p', "pid", &opts.target.pid, "pid",
+			   "record events on existing process id"),
+		OPT_STRING('t', "tid", &opts.target.tid, "tid",
+			   "record events on existing thread id"),
+		OPT_STRING('u', "uid", &opts.target.uid_str, "user", "user to profile"),
+		OPT_BOOLEAN(0, "per-thread", &opts.target.per_thread, "use per-thread mmaps"),
+		OPT_END()
+	};
+	const char *const bench_usage[] = {
+		"perf bench internals evlist-open-close <options>",
+		NULL
+	};
 	char *evstr, errbuf[BUFSIZ];
 	int err;
 
-- 
2.49.0.604.gff1f9ca942-goog

