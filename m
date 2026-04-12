Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D8033FE26
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 02:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775959772; cv=none; b=kqnTlz0okP9ZLykQek/iYO17C3OA6qwv/slM3hz/KsJnnGGghZGXYgDUxpWeIGdhzmYPZIa6eVtzDLKCHM2urQo9ris1FCHAf7gW9CefWCt/zUwsS6b4YVxoeRRngKAsAin2pIWpjLPiuOz07mKCAWbYhaSvTyDbicBI7OQDor8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775959772; c=relaxed/simple;
	bh=D6J4TrILnw+Vd5duIq8Xx5kVQzeF4EcLXmzsOqpDjuo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X+p2qpdwG9pmHalkMZb/1fSMbTwQMMKNVq6s9xG71b1h2CTv5dxDpekLpxmbEfpWgZ1AMlZRln6Vvb2k8dZONxxoj+6N/6e9tV0VZbmDs0E/HEB9mIy6CLV6x/c1xE89fSO8k92+IpviE7yo71j3/tN+tHePSaewUaIw2jrEiOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=poFpBkVI; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="poFpBkVI"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so3753465eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775959770; x=1776564570; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DtrEOzqaeIjI7JHJhlF1QdgQmfPYgnjdkQHTwBVDnJc=;
        b=poFpBkVI5i/MLDOnRyxndT569QOgyvcQ/9mbndpKfIBDWqb3tEl75nJJ74E3CYok5o
         cfxbE9SvDOTYhDvZn9WwPpoWZRcFcJrLWprM+S2YyEiFM16H0GsyIxliOzWBO+x6gHXg
         ATWc9afAwf4qRSwicqb2kKorCiulIxtIUnTcrFXs1RtfshGA1pZZ2z9Ty5O5u2UBOBvz
         qKcKz2/HMXaH5baP1Mw8+LeRWd2hc09oZDmOXbraqSChrfh8t6snSJvYkpfKbsumUN2F
         RFfs89rWsmHa2nvbowZj6C3E8PXdzqTBb5P/r+enkpz5mAON5Zsyr0cDouJzICMKZ4Jn
         f1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775959770; x=1776564570;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtrEOzqaeIjI7JHJhlF1QdgQmfPYgnjdkQHTwBVDnJc=;
        b=Wxo+z3GOX5gET6xjgOXgAj4G/17ruQNjdWtMHWok0zaQ6duMHR1JTDTlBCagYPpA2M
         Mw1IeLoWXMKgFw5T/CDR5q4EBh5raQR1JM/30J4SXYJnJyZaTPQhAsROHtDPekGMI1Pl
         joxzEhDfGx50a55xSTYbAkAkAQuyVKqc7zfc+VO++JQGFe/F4S0jYI4n4RStkA+iYN+j
         gW3jTXNqBVafBxt+COhrAUKq7+S4sFI08E5qnJPONag4O2jWOw4L+2Qq30xHaEUbWiH/
         MCRPnornG7nRVkPEQi2rkBunOaCKCOa5KHsLuFbxYUpH5x0eQz/p2YmX3KszBb7HOBgv
         fvGw==
X-Forwarded-Encrypted: i=1; AFNElJ/D05pbJdYDiXHgCoX8SzaKmvaBpOEMUE5k9lDlcfrPRHJcXfa2KyvBN1eReMzwJX7AQ7fQRyox6sUpHCosl9c5@vger.kernel.org
X-Gm-Message-State: AOJu0YwXFxv5IlPZHcpTxaOkvByBKEWOt57eAUZ4CXrgJdN9Q1IVgMqw
	3MczU446UNuiSSO6n8JVAMFbEF/hux5xWXlMTTkVYPwZ0QPxplxS15t4eQclAktJoYo57Z0GZLK
	4SSFvnbvWRg==
X-Received: from dybeb10.prod.google.com ([2002:a05:7300:a2ca:b0:2d5:d26c:d4bc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:608e:b0:2d1:9b35:4eec
 with SMTP id 5a478bee46e88-2d58678ee5cmr4486338eec.2.1775959770039; Sat, 11
 Apr 2026 19:09:30 -0700 (PDT)
Date: Sat, 11 Apr 2026 19:08:23 -0700
In-Reply-To: <20260412020833.641177-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411191710.524998-1-irogers@google.com> <20260412020833.641177-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260412020833.641177-21-irogers@google.com>
Subject: [PATCH v10 20/29] perf evlist: Try to avoid computing evsel from sample
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

