Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F317F19992B
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Dec 2024 21:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123883; cv=none; b=cSbGwiwOp9mjWv6GKCDRn6h4TmktVNisSVo0ORwHO01n8sa1uXlemWAWovnbzXgS+tX1SA34cbXAirgQnN5da0FsVQO99IyA31nRea72tzMq1ucS/65QvEvjBsn9WwAFy79ZrcD8s+0vRr+oBb7swB5KhI94OihRA3SzsB8u6n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123883; c=relaxed/simple;
	bh=i5e1b7t1EPpevqJjKlGFUSU+o5EL+PeGA8k4xzs8Loo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=HcATJP3lRjFCuRESXoKqQUp1IswEKb3Mqr5z6bt9FpaJin9SpN76oawPT/XsrWR28hUxcG2Ultvvts4hK1felAYV5/c/aM5DnxzPFQhgUHFtN2DhrYWkTnSkWZMTrvxrRvG02Vkk/3KvIYPmTpxD6oKcPIIyGRwksC94joHv9ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q/AW9b31; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/AW9b31"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f186a6d097so31440117b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Dec 2024 13:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734123881; x=1734728681; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jve5UrRFX8lUtfG0zKrFxVw3qJ0NTFZjVOZjxLZ9cVg=;
        b=q/AW9b31AwzdF2MPgZyiRCOZm8jMoycmBbP8bwFiuQ4KVPGi8yRxHagzUmPfUsI/rv
         nkdhfz0LVHxaP5Ju+TUZ9vynOea+c7Ij3cOKDJfIbK3t/q9nt2ulCevkt8akkGoaIDM1
         V27Gf2ISysII2zr4AX7ZzDhi8NpJYb7ehdWZxj0ZoRJTIm/pn4w6/aja3y6GOk5a6/hD
         ifaMASLDHl/F4b04rbC1POX6yc5MRf02nebueSZ/wgysXEq99ChiR1VBGcRxXnao1CvT
         +qnB1oCMGYpxOTqrRXt0AyS3VKitm9dvGnrCpNk2KC/mx5VEmi7eBEB4n6YLxV0dq+6P
         lW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734123881; x=1734728681;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jve5UrRFX8lUtfG0zKrFxVw3qJ0NTFZjVOZjxLZ9cVg=;
        b=EiE6GeiTqRlqQIUE37Lz6sZNZuWNAgO0cqKWoLCY7FdftV+FIac0yVvFEHqQmjUSBf
         tQNBRSxwmebeeQDxG5Rp33ENaZzlGJLgFqbY1cMStst7HjlMDZXkkEyL5q7dvDjkoSjk
         9Zuu1BTQ219/C5NAIOlJVkmrdE0czD6kngxbUbZaqWBxHNuc2IDabV+39GbE2FCB1joI
         ukLbo4mUvLkafXXkgslJPou7TJwso4Jhgq5yKy4k0AZKJcK+bvtQ/1ZXpMMvgHM2SSd3
         /0qTyXNB3B8aY8RYnbXdfYpWbaqdu/16vJo2ObO8B+t8h3i+xr1cM+MXPuN9fSVPkNZD
         wSXw==
X-Forwarded-Encrypted: i=1; AJvYcCW0kirRUPYq0mbJb6W+EMDCa+2ZPo8em29qWXEW0/8SeIm6I5B/OztvtWy6u9z6Y/QWAu7OKlYe39KzAbhKOVgV@vger.kernel.org
X-Gm-Message-State: AOJu0YyC+WDee3VW0ZTOqd27HpxgpdFsI2OUPGkH13Vuv1LNSgqip8Ek
	eAXA+kR+8+6jUkNJ11xWybKmp9xyARmqhtLM9Vf6tkdfVCLueAXuRwtCqcyKTwjvUwExUswDYd+
	b/c48rw==
X-Google-Smtp-Source: AGHT+IHENPzULra0CGF12H7jvOCHRuu8SzpjakUA14QaljJ4wh60e2ID3JmDlWJVD01OmUAMdsqmIhpWRjOY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:9a50:5183:644a:3472])
 (user=irogers job=sendgmr) by 2002:a25:aa2c:0:b0:e39:b4ca:3dc7 with SMTP id
 3f1490d57ef6-e434a259f73mr12504276.4.1734123880992; Fri, 13 Dec 2024 13:04:40
 -0800 (PST)
Date: Fri, 13 Dec 2024 13:04:21 -0800
In-Reply-To: <20241213210425.526512-1-irogers@google.com>
Message-Id: <20241213210425.526512-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241213210425.526512-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 4/8] perf evsel: Avoid container_of on a NULL leader
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Wei Yang <richard.weiyang@gmail.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

An evsel should typically have a leader of itself, however, in tests
like 'Sample parsing' a NULL leader may occur and the container_of
will return a corrupt pointer. Avoid this with an explicit NULL test.

Signed-off-by: Ian Rogers <irogers@google.com>
Fixes: fba7c86601e2 ("libperf: Move 'leader' from tools/perf to perf_evsel::leader")
---
 tools/perf/util/evsel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index cb6952b6d9d9..dc427eafca6c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3327,6 +3327,8 @@ bool evsel__is_hybrid(const struct evsel *evsel)
 
 struct evsel *evsel__leader(const struct evsel *evsel)
 {
+	if (evsel->core.leader == NULL)
+		return NULL;
 	return container_of(evsel->core.leader, struct evsel, core);
 }
 
-- 
2.47.1.613.gc27f4b7a9f-goog

