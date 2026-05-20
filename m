Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68793F8EB9
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303983; cv=none; b=YiUSBBI6ZdP3HgP3/m5LoUyX8/OuQuIHyrLDSRk51wfyqrB7RxyFHuEQOFg5nuEDX/K25xURhN6IgJgRvM6tl4OpTQldBnwj3lH+Sdt+8BaXvTVSjKHOlnZvQuhGbGa2lLxmDE3j5/fS7HvKuOvE2Akv+NntenJsC+YszYSvCn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303983; c=relaxed/simple;
	bh=UtAzRGCK1NfTq2mlkMihQ6FO/ij+Oxyelu5U8a380OU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oq4CCkhEtDRSWLy1mwjNEXLEze+6OTx+chUtnU831li8CQqXubTXqOhuXY99gANNbdwoQ9fTI2HvvkRERcOaBMoGOD7WfEo6aveSjPYxG50rc+InyYIS75AkLEhBhUHQ36qcveUI/c/JKjx4axtkA/U+uGn7YXR79TdxbezkZ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y1raLa/l; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y1raLa/l"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-135f2aa4742so2762396c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779303981; x=1779908781; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JB8cwrMEWExeeI3YMdCeq5oMAY2HQDfsFWNGpo8+0OM=;
        b=Y1raLa/l0Q4+MuaCtZ4fAmyEXCU3ir/de869G3+aBhgItlhOfEAmbO2GVJDWERv2ut
         HEJPRPVgXptzjvY2DoR//JWmZE4628aGq69pz7kCzt8B5s911F1kWA1SalbwKki8Y1ws
         SeOA/LI/PI4qSHVNzPN2RSIFYuqV3Gt25t68wL3h3snw1L30tybS9qwl1k3J9W8OXaNZ
         I5C4Mly+kH9J3hGNpx0AMxzmR5S+itb2/Y4J6NJouFXQaTjwFhuM8F2j+uSwmdDAeW1g
         65nPSylnK9nAcVRZMDIIADCp/l8dwy/i/ES0bdMABZahC2Pt5zxoQKvFxAqQZpVRgcj9
         wstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303981; x=1779908781;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JB8cwrMEWExeeI3YMdCeq5oMAY2HQDfsFWNGpo8+0OM=;
        b=eNtBedSp4jYdcMmbD+pEfoetAvlbj+RlHSGCXCRYyJ7hCCuBh9s//xtIhvNJ0Du3Q7
         94+slSqx3qlVrdtRPZMs6PRm0uBN5MzpoTRIkMbS8f1aLEY51yc0rgBqsoWGekrzFtD0
         9Onsogy/uGHf109dj13wEpQyM48HcSLOPururCkaT+CKbJOQyejDfzkRk4OwrU78mFAA
         Tr/wMaKSEJ/0H/mfyA8m8cGhPW9YwqmaIzOh60qL8Ee6SRDVSXx+ijBe6q+dAyDGBm3O
         Pje1qgW90G+j49l5LXMq/RC20ywrWO3944JfYi5GhRWImC5vNo9PuvQ/oJpywzaZTa4E
         ov1Q==
X-Forwarded-Encrypted: i=1; AFNElJ8k4b6rZ3RNXum7boP6JiSP2PIlUeSS4kn7Rv4aK82fp2+ksB41egnW07mD8lh38+2ojxr6nFVPf5xlIRV+XaQW@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjnc+4KCOctLsyV4bqGu+eYHX6WKL3BdrDDU78sEmdJ7BbXM/y
	Jl1wcUqv+VwwtFvVGlhuoak1ij4K6C83S2N+ABxLU5dGAQySo/63zwgoJHfSutGCXmfc2e32QxD
	KjB0ycWsDzQ==
X-Received: from dlbtk2.prod.google.com ([2002:a05:7022:fb02:b0:135:38fe:4472])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:907:b0:122:3a5:fc42
 with SMTP id a92af1059eb24-13504741229mr10142940c88.20.1779303980675; Wed, 20
 May 2026 12:06:20 -0700 (PDT)
Date: Wed, 20 May 2026 12:05:24 -0700
In-Reply-To: <20260520190538.142018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260520190538.142018-19-irogers@google.com>
Subject: [PATCH v14 18/32] perf evlist: Try to avoid computing evsel from sample
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

As struct perf_sample now directly contains its own resolved evsel pointer,
passing the evsel separately is redundant and clutters the interface.

Remove the redundant evsel parameter from evlist-specific handlers and
structures, ensuring the tool always directly accesses the evsel bound to the
sample. This simplifies the API signatures and eliminates the risk of passing
an inconsistent evsel.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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
2.54.0.746.g67dd491aae-goog

