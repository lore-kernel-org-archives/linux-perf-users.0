Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF6531A04E
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 17:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769104738; cv=none; b=r+YzrSrraIGEHUSJf/3m8Dj835xPO1GYCePrssoZj183VS98SPYMbppwH4AQCJmnQDDkZwLo7rIugX02R3WW8PlLmvV6FecIp4vpP6/D08WeznHnT97CONqeXHy22qRzULaNhd3+8wyOQzZb3mtcqtoTD3SqX6yNsIYFw6I1ZkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769104738; c=relaxed/simple;
	bh=61ieGi6tgxBt9xA4874XhGbiTWFJlqnS1CJ8/YE/2+4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=fKD7QlAmKxFuguspyNMMeT5vYZpxRY+4+LakBRG7ZjNkoHcQCik/7pdh9f/pd70z5WACblzdjoeGWR5bSagx83bUBVULxyq52BMtYppNjnFY6YJldL1Aw8wQ18neGphGvCGeyMCBNYLrD7bMMG6QHpjnMzkFlEFifK7+f/9ledA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UEIWb2nB; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UEIWb2nB"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-124743cf760so1834563c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 09:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769104730; x=1769709530; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZtNnciwt61qdu/VZ1nvJdHEqwS5GTCcyAYHlwDlKrLw=;
        b=UEIWb2nBixitlJhCStVV6u0ORO5NXu8NX+9vcIC/lO7/HMCE/H2d+IOi1XNsiEAcMb
         Jkx3fAEHPrGGFtGsSQBcSyVu+kcyQe4FiIClFiurBHPtIFR/dDsvZvZPs8KJoDkdqndD
         grCj0+MM3YU46SggTQgoEiJ/CCr5ghDt9a7JoELLhIQe/T/tJVMlPO0yNHpoAau0bDIx
         gUMsPqOuWY0HFcvG37Vg4MQSRGZfpyNSE4piMInres7AXcLHW4+U5dQOfrOkHWtjUVUs
         j/e4JkCMvS05a0CExFPopUyHpG/Mh71V9xHBk6LOVla4H1YLpk9Cpp5l4zcUFMk+QKKB
         R1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769104730; x=1769709530;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZtNnciwt61qdu/VZ1nvJdHEqwS5GTCcyAYHlwDlKrLw=;
        b=q1mJqSCN9F4+JmJtFISSmlaoBCfXYZY+QAXkERqsQBzRU+Y9RUfBDGRGt3n0/bTAnW
         POjkzPudRqTCX6jeGP1HzdLtVQTMSccNvKRT6k18xzein8QEJFi65k86e2NhKuj0p0+q
         cjyK3ZJlQeXckqjqKnFhIU2+6WPc5SAEeStMWbY/pZL3jDzao5eKwbFnWSDznlxIPETI
         O7KbxDvvdDW4F7B4AQnjUInCBwrzG2qfIw85On+SP7MI9EZxkhZGz0+eyOmJIm7WYwhk
         Do92BLMc6rSPUCHIhF5sC0Hsz6XJtFCktmBvJTVJp4FWq6dqY5oX8u7WST3+BXZ5Kq2C
         7VPg==
X-Forwarded-Encrypted: i=1; AJvYcCUEK1zRTFsSCttoZ6Aj8gHBY8BkxnHxMLR3PRaAoFdsPwRmD2OxRvLpsU5cxQn0K6w+5EY5CjDBckdDkcrJDS3u@vger.kernel.org
X-Gm-Message-State: AOJu0YxmcaFgul1fma9nE5oxhuj+JIb4XG+/KhKcxwipLJHjlqpJiwk2
	6LUMqhoKlN0RZln8SIy6zNn0IwK86no4X8dYm9a6iSi/hvfVGZs8bJdjDdnc1ylvDOOGONTnTQr
	B3O0Q4ZUdfA==
X-Received: from dlbrh26.prod.google.com ([2002:a05:7022:f31a:b0:124:4ff9:fb25])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:618e:b0:122:2f4:b24b
 with SMTP id a92af1059eb24-1247dbf8d52mr73222c88.25.1769104730026; Thu, 22
 Jan 2026 09:58:50 -0800 (PST)
Date: Thu, 22 Jan 2026 09:58:46 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122175846.592786-1-irogers@google.com>
Subject: [PATCH v1] perf inject: With --convert-callchain ignore the dummy
 event for dwarf stacks
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On hybrid systems there is generally >1 event and a dummy event. The
perf inject --convert-callchain option is failing to convert perf.data
files on such systems reporting "--convert-callchain requires DWARF
call graph." The failing event is the dummy event that doesn't need to
be set up for samples. As such ignore this event when checking the
evsels.

Fixes: 92ea788d2af4 ("perf inject: Add --convert-callchain option")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index c89ac85ec112..ea3ac35256ce 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2727,7 +2727,7 @@ int cmd_inject(int argc, const char **argv)
 		}
 
 		evlist__for_each_entry(inject.session->evlist, evsel) {
-			if (!evsel__has_dwarf_callchain(evsel)) {
+			if (!evsel__has_dwarf_callchain(evsel) && !evsel__is_dummy_event(evsel)) {
 				pr_err("--convert-callchain requires DWARF call graph.\n");
 				goto out_delete;
 			}
-- 
2.52.0.457.g6b5491de43-goog

