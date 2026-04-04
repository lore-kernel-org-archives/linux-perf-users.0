Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1130346E47
	for <linux-perf-users@vger.kernel.org>; Sat,  4 Apr 2026 03:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775274271; cv=none; b=ZahStAopLnKve+8FWa8434KwfcqBIZgS7jYILRHV3tOrRc2/MA+8oo9oiLoFQxF3Hsp8D/sZ8C1XUlVQ6bnFUcII0i7v97LvPYF67S3Gr7CQp6zRehcVXMwY9SpwkJLcMziGnEKAF4JqmR9tZ0OaxBBMUrIPwv2UGNC8R3K7tP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775274271; c=relaxed/simple;
	bh=0Keft5t7OBXgX7YaxEhWnWuQSKMAek/Moq2pD9h81W8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kd7nJlK/GgcWNnjKwBfYGGb/B9JC0Y6nTVcCyjF6TekDHr4YpbjXqRjJgju6SjNweJ9Pwi+moouq7UjO0m9E2Er4m5t1vpZiRhIsC6sRFp0u24OylSb+sD0Oc5jVfBRTd1E6QjMcH0ru59DINjJq0Yf9uP7JJvS76iO0ICf+AU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VzYG+vxr; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VzYG+vxr"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c68a134df8so2317190eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 20:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775274269; x=1775879069; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DD9DzZmqkeGtfBm/333ve8pZcjoUvLLGIPaFR8uqSWs=;
        b=VzYG+vxr/ytSx32zlkFprMtL22+BtxLDT8gV8wBQD2TDMVdG6nSxWpek4zsWyJYF3P
         9b5xltRFoUw9p+gdThK9Q2PegikXUtinbXU7rMPNxH2pBC/IP75rqTIm3vj/RZ5WEknh
         sYKL2cQEYdh6nf4OiIs8gNct/oYrqu9mo6PCxEDf2Be/pZVwUM7dR6JltOZzIejlJrmk
         CpTOurIug5ts9iXIaSItwB+Z0ajuIXPpaQ8bnItqwDA+BAwEE7VgOFJ94Mj6Z6wcXgCD
         +9s4GI/cMh4LJQSnGPEBQoaXUuWzJeAYns9G2NKU5y61K4hR2zOhFDSR4MzghqMTsSal
         Aljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775274269; x=1775879069;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DD9DzZmqkeGtfBm/333ve8pZcjoUvLLGIPaFR8uqSWs=;
        b=bGwu80eaZth/hAbFaj9wDUi4C9qEeO7J++eD8HWDKNJM0CNtk1nfKBcBRCUmXTAKcn
         BHh5EM9tmZEI+VPfkUguhVWV97b1JOSxjE0OfPN26K4QYwjZAqAGlCYXCM2ru6lkGCPm
         yHebGpCuIiNWmQiIsinyEkQOITtY48WoOs2Ofi3qiacrls9FG5KVcfQoSncqrFLFUFO/
         PJ2AKOcoyRUj7wPc0MHsZ9430yu6dDtyBjpkon4ihWezLCT/qAESj2rTHS/aqIbYwgk9
         g5IPESMhokI2l7PmDRjHM/seDUmDum4ulG5hJ7qwSlaopDm4MtRxH4czUJKQ5xiKaLIm
         InZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUEJXdDxucpQx/8j0EHsNfzEfSyd1tN9GRdOakSCzDO0jhsjVf2+f/bFpQALqDIhfJpbvMrgUljraI0z36Pem1@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvh3bzVBJydKXD/CM/3kgXcsS25yssm60VyOZLHmplM30IKZ71
	Fhu8Y1sO+CIDNCNJX9EB0qUMNb1+x8p6KE8KIizSRdv1+bUuMYt+fbBaBdIWdIIiMY7SgDH4qjj
	enZ+IyfFQFg==
X-Received: from dlbrh25.prod.google.com ([2002:a05:7022:f319:b0:12a:c447:d6bf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6097:b0:119:e55a:9c04
 with SMTP id a92af1059eb24-12bfb767aafmr2124937c88.32.1775274268853; Fri, 03
 Apr 2026 20:44:28 -0700 (PDT)
Date: Fri,  3 Apr 2026 20:43:22 -0700
In-Reply-To: <20260404034325.3172592-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403204017.2919994-1-irogers@google.com> <20260404034325.3172592-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260404034325.3172592-23-irogers@google.com>
Subject: [PATCH v6 22/25] perf evlist: Try to avoid computing evsel from sample
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

If the sample has an evsel, don't recompute using the sample.id.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c           | 4 +++-
 tools/perf/tests/mmap-basic.c      | 4 +++-
 tools/perf/tests/switch-tracking.c | 5 ++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index a66666e89f67..f8bca1cb5769 100644
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

