Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852D73A9611
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 22:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625065; cv=none; b=nzmJwXWHi7cBqjAsPEy322/P7pkRyWtxqypugY7bcoqcB9LP5fx3tOGiue4Lmpl4mem4LbgcG8OB43D7Jb3pV/ZdEINgyXAG56PwmfUjwGCJH6C+P4DItTZ2pj6Y0cITc0on3B9vnU9uNUta/mwI0LXv86aiUFzeb+40tC5kITY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625065; c=relaxed/simple;
	bh=7dCyzce0fUKMy0m0LylFG+hP0V3SzFcAVKQyj2Q9Ztk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IXrDsXfZt1AwHDnFuWnRoC4TaF9opOexa/SWRBAYMQvbbsru2R6p5ie2bYUfSmlrhNI2nr65ml8M5wx0svcDH7MdHuLM9mdkM99LwL5644wgv7w1rs+LHVECaVH3CyYphO/Kt82bzDolUf/ri2Ghx5R6RoxmM0Q43d+vfPPwl0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f3KjSk6H; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f3KjSk6H"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13312af37fdso8792892c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 15:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778625063; x=1779229863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rLldBDtwyceQsQeRnzK5IU5eUXX1NM0isoHE7I0M0PU=;
        b=f3KjSk6HzTDCgsbOD2Huevn5DAVMvvnDCtdp/9NHD3L7dn6YId9ApkiicHrvc8YPsm
         OdKK/HfMtSwDVRG5cmY8QarZQobBXswqu94eAJffrPXGl5Z+BCOgmR5NvLhHWROp9w7b
         8SOAoqTyuV390Wh6SeCvKKnIr/xHV9Dwj8eTZy4EKO0R0Gde1TkynCmWmTVFB1CcHtWA
         TT8mVIcUSBBQ8ChW7t1rSJixuPAQa2hIZEjdU7BTlKi3ONv/Z0wmk323xbs3/QwZwDiE
         ddho9BAsU3oY0BzfxV9pmjo8V9shPSjdjSuuojDCsOl4Nzc9NrAYY3fDzeOqyrs0VD7V
         tamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625063; x=1779229863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rLldBDtwyceQsQeRnzK5IU5eUXX1NM0isoHE7I0M0PU=;
        b=bdIpxkMF/mjHCwpuTUgwZa8JPAyfqQK1m0WZr0ioYJ7t+83lnhYphQIE96hVYSOiUS
         IXBJ7Rk04zXo9ZehAGzutr4/89/mfHv3+8QRdXWLvCipQhTwPupDtDwDL5ESbHlPrEGB
         SN66G7vD0uB8p/gPZ3KSGgMDST090JHWxG8eH1ZT5fQYPJUFCRNHwVAKhaG6bBTr+HNy
         6i4RAWrGRR12E3ylnxAvPLixfa3NGfnVqafNXGSSZOGP2XgForeRNKzFZCd9tcAqlzD3
         gvSt0BCcG1ROGVGZlqrDhRaFqfZjOOdaq0mlll2B1Si7vFE4IYkDSBYSvFIPdGVg4OEp
         iwow==
X-Forwarded-Encrypted: i=1; AFNElJ8KktzpCqnX/8ehHnjnGrsa4ROMvW9pLmrqDGU7g7ByjwaibgytlVg9AtaNrsee8vHBZCzx4lTajE73vOyrbuKU@vger.kernel.org
X-Gm-Message-State: AOJu0YybnOWQuvpueX2wpqfSf5eJEwztuL+rMHqBYJ3pihkfg1U+nDK+
	/TyFxz2LD8y+G6Bje6q+Q6Jj+C8/wxHnwhmH8oxfb4M/Gp5pLd9uMcuLWMqkTc5YTuS+v0jgrB9
	gmux70tkveA==
X-Received: from dlj2.prod.google.com ([2002:a05:7022:502:b0:12e:97be:ed8a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:527:b0:11b:f056:a19b
 with SMTP id a92af1059eb24-1343668297emr580722c88.18.1778625062624; Tue, 12
 May 2026 15:31:02 -0700 (PDT)
Date: Tue, 12 May 2026 15:29:47 -0700
In-Reply-To: <20260512223001.2952848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413041143.1736055-1-irogers@google.com> <20260512223001.2952848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512223001.2952848-19-irogers@google.com>
Subject: [PATCH v13 18/32] perf evlist: Try to avoid computing evsel from sample
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	namhyung@kernel.org, nichen@iscas.ac.cn, palmer@dabbelt.com, 
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
2.54.0.563.g4f69b47b94-goog

