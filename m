Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBCD33C52F
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775890692; cv=none; b=FUJ8bSWfciqXcy/q8cP9LnRCFFYdmJc69QQU+JjlNI8+ruf8vQRYN3DvRG1rEMR4e3zX7euTa954m9svuWlch3DCXqGAGrAz6yBg1vudODgwYOPnY6W5cn0iHT3QLHA937GbqT0duRgj8E0Npy/IuUI4Iaxacu3XzHC3wKNKYR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775890692; c=relaxed/simple;
	bh=D6J4TrILnw+Vd5duIq8Xx5kVQzeF4EcLXmzsOqpDjuo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t3Tq49PGhp7sVMNwpKXC7XoK3dLJBd8ao4mXFVc1ByAU5gioRbpGF2a/ljvYDQfFMxYYVLMEkn9Tpb47WCWbbHRv5GALgnODKjOP03+/9tUhVRtvKc53iN/bMwbSxP1cL/w580LIsPHN9GV+Vu6La6SdBryCJj8GzUMdyuDeSQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=emLb9ErT; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="emLb9ErT"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c21dbc9c1so7242453c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 23:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775890690; x=1776495490; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DtrEOzqaeIjI7JHJhlF1QdgQmfPYgnjdkQHTwBVDnJc=;
        b=emLb9ErTNsZoI5ZTLHY7wozsWIPsiz8Zr38oIRG6y1nYa3TUlvJsOmg86mlaR5zI41
         ftXHDVnBSk1nBMPWExDp8LMumNcMwN5u+5v+kchQlTcedYNmNXFMSrOqUEgYRtwgK4O9
         /Ruj8jAA59RWZO53wjA2fxYYqCGd13VTVC6/WXbuUgEAyabBkozwvWH865dgdRDUN528
         Wi9js0ZPzser5d/SsBK330zBXsF3xAvLjcbmCtc2OcVwTohmhHZ1/zmEH2YJ7gLEoH9b
         Kni/oE/4h1vW95mgvbqwCgwK0BWR01IMFHikCBaqPfrBkR0IqdQUb0jKtJtk41x5Ue1g
         kF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775890690; x=1776495490;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtrEOzqaeIjI7JHJhlF1QdgQmfPYgnjdkQHTwBVDnJc=;
        b=H3UTt/WBefU6eArMjxGlOjvuJQSNYnf28rfKmE9jFNcgah3AqyhJ71wYxpBo9rU3ZF
         5qFGAAHIAeSfl7IY8v5oHO5nl8kxiQOJMrLRFkoUGlDhqcdbgnHYR9mPCvmOMudoky6s
         UeZy0lYUU6UCzhGVrt+Vn6xjYByCeiRGzKT7S26nUD+oVrp4h6EMHX9i6XKsnonagTb8
         +XPTfz5xKYip46BJXQ9x61K6M3KLXM2xHUIamDGWazGj3r/w9gZUl4csbQlW1knHZHZg
         Q6cxEoznlse7fhjQBfS7/BxkziMC9ZCmJcLuuYTGzm+st76QB62KCiwrMbTj16CL2t7Y
         e0Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWq5+FNg5q2I+BU3yEvSaB6zIv1SLzRumn2npr89gIhexVg4yKlx2QZuKZQH/IKVSf6Erjpws583Y+J77NAv12i@vger.kernel.org
X-Gm-Message-State: AOJu0YzUYJsSCdtM24N0QAPbmtxFad6dXm+vipabr7b5Mtmto0STowzO
	JQXzfMH9rFhiAiULp3ulp4qHaqPPFgpatRRh09JEMHYl/VTtkaRPctpJpo/klWb9s74zYsI0Shc
	GKCYXFiRJgA==
X-Received: from dlag4.prod.google.com ([2002:a05:701b:2504:b0:12b:e83a:8d31])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:239a:b0:11f:3483:bba6
 with SMTP id a92af1059eb24-12c34e8015bmr3891841c88.13.1775890690040; Fri, 10
 Apr 2026 23:58:10 -0700 (PDT)
Date: Fri, 10 Apr 2026 23:57:09 -0700
In-Reply-To: <20260411065718.372240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408072601.210837-1-irogers@google.com> <20260411065718.372240-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411065718.372240-21-irogers@google.com>
Subject: [PATCH v8 20/29] perf evlist: Try to avoid computing evsel from sample
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
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

