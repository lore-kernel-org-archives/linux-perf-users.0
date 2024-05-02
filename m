Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA10181CEE
	for <linux-perf-users@vger.kernel.org>; Thu,  2 May 2024 21:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685714; cv=none; b=GuC9AusbzHduZg42lrLD1ABo130WER0/GN1AtgnXzUCVb08+gdQJ8IqywZqzxmygEfCFXq9uNaRacAxA02O4brwrrSxnEhjjH6aMyO5y9k8lqYXgAC3cvlnNT8sAp2W1vbqCi7XFk4hQAGhuV5tJ++imyfUlDONOBhmoGqYBUAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685714; c=relaxed/simple;
	bh=tOBCq5saQrvaRbLejKaKunkpMMX6Ijqd8fdc3WGaBWs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=k5X+lbb7FJesoPx99/2vNQerG8LZ6voCIX7b0RNCbfSIq5wCp/jzd87uMLy/HaF0Su4lXA8IVfQFvaty491oppgUdFfRVphjZH/h0ppJHy1JoAmaBkB1F3kC8Nddh9sYnQDteP6Q3kxwd9afpMubs7g+NCnSfAFEZ+YniNydGaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E+IyvtLr; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E+IyvtLr"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-ddaf165a8d9so13741660276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 02 May 2024 14:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714685712; x=1715290512; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dFxWFm3XAkSXgRMvbK6qHWYFEQhk7mOXO6rOJepfIcg=;
        b=E+IyvtLrE+ta45BkDrFrm/un0HEYJbQ7HG8iGmlIKL7SUgBoftftFssyMvSmFLNIql
         FDk03Dq0LM8sWGKkbylwm6lWHHXj7cIbpfuX8zBOG8kyVT2nzD4C30auJPhkXO3Sy3sl
         JN6iiA/vNfvH3K+LRmkBwyYSLcvzQXtlBZv3EaKUuR5NqPAXm5kpowd6T/GpxMf+c1R7
         lYN3ng7izVsEJ5KRooFOWMek93F907K7CRKkUbjAZeeNtUOLLrzl5FQJXHIW1lMAYN+p
         4glbcaAkiR1pxE6+Nuajy5z+M5RGvKsiEZpmp+lJAHI859aRA7gK919ng/kVMuRTtI0u
         KXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685712; x=1715290512;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dFxWFm3XAkSXgRMvbK6qHWYFEQhk7mOXO6rOJepfIcg=;
        b=M6Dc62krFOsFTmajurFuldDDWKHfGlxkn2rwf+aUASYD/2oQb4c6wqvkM2rgW8QvJn
         c9o2d7PsHwBk9ldp8By8b/0QIAKEvMXC9KtNGz3B1O1GaTwYh5+HhNb967c9BCG3Jn4J
         8UT04X4TL4YpQWua+KZpSIMlu+hBDK13zgV37FvqAdosSMoy4yaVcDlXUr+x3Kg4OvNq
         iBLp2SbMaTLnwDv6I/CTi/hmgJZI4r6PJlgA9nzxRBKlKfMU15NhTYqh/qoAy+MCXH4/
         MEJ3pN8CrRGAb7GUnDkVIeg/jkbu1BJzp6SrUewARHhqATWe+S+IxFgyZH9i5EWkhsV8
         8DHg==
X-Forwarded-Encrypted: i=1; AJvYcCWtJzxPa9K/BJp8h6E3eRkn3+PUCVbrvuPDSLEcpRy3DR7qMYlPaW/Qkad46UdtCTQiQgSS9KDkuKnV0szm8tefj3HlO/KOvSx1ubo+TZQ0bQ==
X-Gm-Message-State: AOJu0Yz1D725eqLSpkQ01exYc82011Ib+gqUoqfgf/Noddk4sxQUKOzB
	Di13QuSw5lx81W+nDeHIwm5fHzCb2qT2QBeNgizz2s2D2exO2D/VXrb1NVSHSq63GX0/H3FEP7/
	HY1wzOg==
X-Google-Smtp-Source: AGHT+IEk1ODDvzdT8Cb7sSOH6uOhMZt/Y9YdELjl+b5F3Z2u0EmkSmoN0mV5UaRdfxOH1tTAE0u7bHdeFpJO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:deba:378d:2d3a:2641])
 (user=irogers job=sendgmr) by 2002:a05:6902:f88:b0:de4:fa0d:ab3e with SMTP id
 ft8-20020a0569020f8800b00de4fa0dab3emr169767ybb.8.1714685712509; Thu, 02 May
 2024 14:35:12 -0700 (PDT)
Date: Thu,  2 May 2024 14:35:02 -0700
In-Reply-To: <20240502213507.2339733-1-irogers@google.com>
Message-Id: <20240502213507.2339733-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240502213507.2339733-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v5 1/6] perf test pmu-events: Make it clearer that pmu-events
 tests json events
From: Ian Rogers <irogers@google.com>
To: Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Randy Dunlap <rdunlap@infradead.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add json to the test name.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/pmu-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 47a7c3277540..7b2c34462fcb 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -1105,6 +1105,6 @@ static struct test_case pmu_events_tests[] = {
 };
 
 struct test_suite suite__pmu_events = {
-	.desc = "PMU events",
+	.desc = "PMU json event tests",
 	.test_cases = pmu_events_tests,
 };
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

