Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84CC23C512
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043395; cv=none; b=XOybiTxQwXhZBXq3QCQljNLcpyHZ9HAQisJygYC9zPaXcNYjNWVmiaNJV5c/XWZ772sif6Qks7KFng4k1zABc5RrIgX5evHXfnB5uKY0WBClM0Lc/3VirJgjWZmHmZSGJS3lLcI/M7TsfTh9WBqkWFW0wBHgILbAr0iu1pHxX9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043395; c=relaxed/simple;
	bh=D6J4TrILnw+Vd5duIq8Xx5kVQzeF4EcLXmzsOqpDjuo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BIUzeI9ZnVLKUBcC3taJfeChRca/ZvtziPToDP91c/8phr52n4zsS9yTMI+FCHLiJq7G+0brEuuc11hj1c+nKbuaPvo+JqwMmMepN+Mdn1SCuUhuALlY6/XqwyciFCdXR6n9mBw7MV4OmLSDIjmN2tz9Kidzczy8yzLaXK+IwFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pw+cRVc/; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pw+cRVc/"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c20a91932so7452635c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 18:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776043393; x=1776648193; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DtrEOzqaeIjI7JHJhlF1QdgQmfPYgnjdkQHTwBVDnJc=;
        b=Pw+cRVc/qd/FUaYSizxVYLzCUIAofyEkazGmgGiuV/wqdjztf1rVoSDuOp0ky//WXF
         6V9twxmn/1JWSrKCpImMj+Xw2RmxwMhdlaK+ikzVbFjXz/277wrgDiAzSg4oXINw3iuB
         ZsLhi5+yvu/pQxMPBOrGVm3o2AWQkeZZGoRm3lnswQZYPjfMUv9t6NgvuOQLRajCZ7vM
         xZve4FSw5Uqu4/LJZf8yrXwYvc7X0iKrgT62ou3hpez7igDWOwZpEGSdWPnGWkoTohsk
         ngj91mM99SISZCVLshIBRzZL4o/BsmmU+gxH8/heK+qlTxOJxk7tKKfH0L3tqo3/UxtL
         2I8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776043393; x=1776648193;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtrEOzqaeIjI7JHJhlF1QdgQmfPYgnjdkQHTwBVDnJc=;
        b=BN8M+XtRzgzW3BE1A6AwgZAM7kyeDvS7WFsknKJy+Jx8f8SsSBF4wcKIbsyPgwVsIS
         En6bnQ3os3nSz3yXt2CeKdzQGcS+N9RAwlzHks1ZMbUCmtpqQRtpEs0Mmop+ryQT3E43
         22qIVhhpC8qXzut89TKdSghqNemyNo1BQpm6WDxWPazV/vYzDSxr3dvpkq/nnu9phbMW
         mynY+avwodFigc0vTQzRuHQU1NDdU2UQLoJj5i/+ncreTLOA+t0lfL6zk/8e1+4qopE/
         bihvO5Kk8qVWr9uQEYM4PDyrjq/PoHycF94SqK7Uz7PhItZo+V/o65JIwIw2g6aoWzEf
         Q6Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXDEHa0V51nt+BZALW7sxdNnQR9RW1M/tLBvN1aq/Gvxd9Ex0QTL1bVCarejxhcOBxNxBkK8lHil/Z2zlce9sQe@vger.kernel.org
X-Gm-Message-State: AOJu0YyA0RzNM5TpcIyGrrhMNtJZF1lJN7cyGxDZIbX9aTvTO3RR1D8r
	maUX5jDdnnYGeup8uyEs+XNjiqXQFA/GrnXr6jx5T3JZcNMnD0lfOAmEaqoWaxbVfrMR0ZYYFRc
	ffuRVzoUx5Q==
X-Received: from dlag4.prod.google.com ([2002:a05:701b:2504:b0:12b:e83a:8d31])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fd01:b0:128:d4be:7438
 with SMTP id a92af1059eb24-12c34eeb7f3mr6967038c88.30.1776043392976; Sun, 12
 Apr 2026 18:23:12 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:22:13 -0700
In-Reply-To: <20260413012227.1089445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260412020833.641177-1-irogers@google.com> <20260413012227.1089445-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413012227.1089445-20-irogers@google.com>
Subject: [PATCH v11 19/33] perf evlist: Try to avoid computing evsel from sample
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

If the sample has an evsel, don't recompute using the sample.id.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c           | 4 +++-
 tools/perf/tests/mmap-basic.c      | 4 +++-
 tools/perf/tests/switch-tracking.c | 5 ++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 6cf73bb0c7af..c8474f7ac658 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1164,7 +1164,9 @@ static int deliver_event(struct ordered_events *qe,
 		goto next_event;
 	}
 
-	evsel = evlist__id2evsel(session->evlist, sample.id);
+	evsel = sample.evsel;
+	if (!evsel)
+		evsel = evlist__id2evsel(session->evlist, sample.id);
 	assert(evsel != NULL);
 
 	if (event->header.type == PERF_RECORD_SAMPLE) {
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 3313c236104e..a18d84d858aa 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -142,7 +142,9 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 		}
 
 		err = -1;
-		evsel = evlist__id2evsel(evlist, sample.id);
+		evsel = sample.evsel;
+		if (!evsel)
+			evsel = evlist__id2evsel(evlist, sample.id);
 		perf_sample__exit(&sample);
 		if (evsel == NULL) {
 			pr_debug("event with id %" PRIu64
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 22b0302252db..e32331fee277 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -138,7 +138,10 @@ static int process_sample_event(struct evlist *evlist,
 		goto out;
 	}
 
-	evsel = evlist__id2evsel(evlist, sample.id);
+	evsel = sample.evsel;
+	if (!evsel)
+		evsel = evlist__id2evsel(evlist, sample.id);
+
 	if (evsel == switch_tracking->switch_evsel) {
 		next_tid = perf_sample__intval(&sample, "next_pid");
 		prev_tid = perf_sample__intval(&sample, "prev_pid");
-- 
2.53.0.1213.gd9a14994de-goog

