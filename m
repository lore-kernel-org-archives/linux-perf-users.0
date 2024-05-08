Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A475F17BA5
	for <linux-perf-users@vger.kernel.org>; Wed,  8 May 2024 03:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715140400; cv=none; b=fxMpUW5r6RVAXkvuYx0M+U3ZYv3n1fU2hWlGx9V4fPI7YRfWYaEuwWGiclVaRb1ZPjXZKgFG9jtDtL/9ZxM31F/9mFEFbuJMybWuRyl1cVb2gXoComtlif9wrkFese0N6oSRMzicgqMZ2TuOtrNgvVgW9gC9LrRJVgnj0x+ulwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715140400; c=relaxed/simple;
	bh=1gjiKx8CEp6GLpjJeA3XOWVnAQEoANQb0FbmONXrbR0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qi15Hjvc9E8euZOnslhxWqK6nS9viJCmjK0ZOZsFb59k5yzm9aX69ll9i5g+06C46lhEbFpj3u+uG2CuVjCqg0Dv8Tz6rg9VK2NkuPpjH+nTgcrOm12jB6XwTPkcENHcBzGqpyjmAeFwU9p/4VU4nlnjajX7J2JspEvrqxAaojY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XXcuIzLu; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XXcuIzLu"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de54be7066bso7241697276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 May 2024 20:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715140397; x=1715745197; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=evqEKyKRq93CW7bOGoBWyVHoXocBvIcKIjPummzTEM4=;
        b=XXcuIzLuefo9G4WTw3U9XOiXLzmSa+pH4K2LfVLoD2KPMZgNp89verZ4PCuzFwnDCD
         JKXQlVMhQF9xYpd8btLg0OG1nmQ6uPCBusyEwVq9Ykdfl2o1I7O+xbXnuxq/+MDhhua9
         iVbxv6Oj8EGU91EpTlFpHur1eMSwGpV51dJ1rH46FAQdLKGh6Crg3DGO7ksx7KjHgsGf
         orlbaZBODsmO1UKJzCLssfpI42CG2XbINZpHtS+z8KVAdc8n/uQEIXwLPqPv1Kj23QMo
         S5Sd2CaxE7R5mGiyyAeDEW7fAOLqbrojY6JZP3FNW/sYxmaV2bgKdw3q9BMHkGh9cDaU
         QFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715140397; x=1715745197;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=evqEKyKRq93CW7bOGoBWyVHoXocBvIcKIjPummzTEM4=;
        b=nmwyp/3tgK5U3lRnXYwxLmVmlWOXns63S3bQjqDh6/Xo/dxXLwvb1jN83gxU8xfStm
         ovWa6dfjU8+yaiq5t2/Sk6A2/jJ6b6pC5tEfFuCtA2ART7WFmIZ5BwXrOMXAwLmpujaL
         dZomwDzQIf7CrJLTA8eLxSp5MBIKvDIo7KxHOkPt0pERHrxuGk18ZN83NBJjjpfshcjk
         Mb7bjqH41tCKv0nL16sSo9YLvup3ueeMsvDheAYQnOJQHsak9ksB3zaMYEGwjGjR+25c
         +vl3rbwpfdXQ+AojadqOf+XyctdXGlN0kwB85+ZC3aiJGmf7nrIdwlMWAhsPBv0OxlCr
         Prmg==
X-Forwarded-Encrypted: i=1; AJvYcCUmQyGy39uO6ouHipU9bJs2syzgYAHpFMsJ5zszInk4GjfWItC4bYOGZW3AB+6rhXYDpzuTdXBowMYOA6qbr4MvE9gOjAj+1fqsTtFjLKAFAQ==
X-Gm-Message-State: AOJu0YyBR3ze4PimBMTnsxw5X16M/Gd0F2yHcF24gzqZXT7/ind4Ulzo
	wqIAGjr7EzVpZltqnOgyb7Qysggz9Kqjg2VMbCoHTy3K/Z2pJm9ZrfpkeqlQJUPGjDJLM72iF1x
	W3Iy17A==
X-Google-Smtp-Source: AGHT+IFFi6TPEZBiQZat0J8wPmQsKgf7WRxfdVdZ6yCN7mIOFkHcTAwrw61sUraFs85lMk8PIkUKfpdUg5AT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:56f9:40dc:113f:ba3])
 (user=irogers job=sendgmr) by 2002:a05:6902:1083:b0:de5:5225:c3a4 with SMTP
 id 3f1490d57ef6-debb9d3d713mr439844276.7.1715140397650; Tue, 07 May 2024
 20:53:17 -0700 (PDT)
Date: Tue,  7 May 2024 20:53:00 -0700
In-Reply-To: <20240508035301.1554434-1-irogers@google.com>
Message-Id: <20240508035301.1554434-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240508035301.1554434-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 3/4] perf report: Avoid segv in report__setup_sample_type
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In some cases evsel->name is lazily initialized in evsel__name. If not
initialized passing NULL to strstr leads to a segv.

Fixes: ccb17caecfbd ("perf report: Set PERF_SAMPLE_DATA_SRC bit for Arm SPE event")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 0892b6e3e5e7..69618fb0110b 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -429,7 +429,7 @@ static int report__setup_sample_type(struct report *rep)
 		 * compatibility, set the bit if it's an old perf data file.
 		 */
 		evlist__for_each_entry(session->evlist, evsel) {
-			if (strstr(evsel->name, "arm_spe") &&
+			if (strstr(evsel__name(evsel), "arm_spe") &&
 				!(sample_type & PERF_SAMPLE_DATA_SRC)) {
 				evsel->core.attr.sample_type |= PERF_SAMPLE_DATA_SRC;
 				sample_type |= PERF_SAMPLE_DATA_SRC;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

