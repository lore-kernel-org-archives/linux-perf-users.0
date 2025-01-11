Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D901B85EB
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736622126; cv=none; b=WImsW/jbrpTjg84NFuzuMiTm/n1fjWBZ/35/k9quj5rOJACPIupxaUUhVuCtJxu1TRTcqNYF1hycDDHzds/0LkX/vh6VQKRA7UAgTFHtXPQhcJxbO2Y+e77hzVHQUQOT48EwPlgxNcV7Q5DzsWZq0GGGlZYrjR9qsCmidufosyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736622126; c=relaxed/simple;
	bh=O1Dtd7pjA+zdivihnQeaHiU9M8haFty8/c6b44VCETE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Oj5n6UpzzdQ9qDt3t2BK42cKwjRc/JmTiDMZoo8KKAmwxnnTiMPe6G82hWdyFxXDYS8WQuJUmc0BraKM81E/9zfXEOazvWVhmk4lcIRQr8FMmlODw0Yn/wUNF9dpMvGA4npz1I3bQfid+6CK/4PlXIeeKOAjeRfIr1kkFT3EBWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZYp9EySK; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZYp9EySK"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3a0d165daeso7102192276.1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 11:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736622124; x=1737226924; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/HRcqVrZdSLX9zBarcP0H5K8ePiVkWn6K/7fJX66j0=;
        b=ZYp9EySKP5d9gt7vY+K5QBVaWqMAjDFzfB57zFeeoXf0RfCTiCK8dQXsM4t1Cbq5L/
         33qfiO+Hng1LurLeL6xZm8tsZpw2GjKOlfLEiUEHx2bsqK0VRYusETThnql6oFOUF3M+
         mOxvnfRjDraDbQi4H5dsUm4sTq6Bi/QgeLkC2GdWT8fWuKJnsCAyZMU5UC0KfgTSQOxd
         LW3ccKji+2SGR1lk9wDKHjbVhxOYzGunlomqeFOQS03DZ7b1S6DLXrdngLhP12GobzPP
         LAwdPZUNaF6rLXG47z7GQswnuAtnOAozjAkrLBgYyWYbnn1IUERzKigEhxtk8gXaRBvw
         9HIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736622124; x=1737226924;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/HRcqVrZdSLX9zBarcP0H5K8ePiVkWn6K/7fJX66j0=;
        b=niodxp9GUyhw0mmfzNC6/FuWRQssdNHWQsZQMGMgxRxyrwYKoZ0CZbjUhwydQQRcCO
         sN8OqbeyaOSeBFZwCmJY1C0sanF0+CVNgB20OoKF+pV2PUlBnk+JYR8Z4loClvM6o+CZ
         8EB8h4OMG/XwQyjUOAIILLzVXN+28l2PPxnI1B4zKDtHyW1nbfi8RbURSxqCZa/aUxGx
         hVe1muqc57LhFOQLRf9tO2X7Zrg6OXrZ0oaBP3plK7r4EuGqpNS+EZUMx6nqy9r/u8S+
         sL4CkA3mhoT93c5U2d7ErSg5lhwzDzBgzcK1SKK+13VmHBYbQ4rXKOvG41j4/nymdxiw
         o/Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXEe+fzDhlnRkpD8u0xcDPsgxFi3rBCWKcpMa30TwiXWii1gpkoriiOC9A3YnqzD18NXrA1sUDMCFiQfs6hQjpf@vger.kernel.org
X-Gm-Message-State: AOJu0YzeC2WT5O1UNjQJyKJExZ5/xUb+r8a2CKw3lvrgjF4ap7s0vMyz
	7gxQaimASuQ36MC/IFKH2sE/GjaaMEkrOCrrlP/tLhqslEQKE6XeEtWN16/RGTKV9RN58RFdVmX
	bQlF6tg==
X-Google-Smtp-Source: AGHT+IG3GBAIcm3ka3GFUhTG66wYaTj2YTGsJaO/9sZpFhyF7FXbGcPFvIVO0PM9jUPacj9TWmtDPBWjjV+H
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8807:d7c5:bb27:35fc])
 (user=irogers job=sendgmr) by 2002:a05:690c:317:b0:6e6:38:8567 with SMTP id
 00721157ae682-6f531329501mr430717b3.8.1736622124219; Sat, 11 Jan 2025
 11:02:04 -0800 (PST)
Date: Sat, 11 Jan 2025 11:01:35 -0800
In-Reply-To: <20250111190143.1029906-1-irogers@google.com>
Message-Id: <20250111190143.1029906-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250111190143.1029906-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 02/10] perf parse-events filter: Use evsel__find_pmu
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Hao Ge <gehao@kylinos.cn>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Tengda Wu <wutengda@huaweicloud.com>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rather than manually scanning PMUs, use evsel__find_pmu that can use
the PMU set during event parsing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 1e23faa364b1..f147e13a7017 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2406,9 +2406,8 @@ foreach_evsel_in_last_glob(struct evlist *evlist,
 static int set_filter(struct evsel *evsel, const void *arg)
 {
 	const char *str = arg;
-	bool found = false;
 	int nr_addr_filters = 0;
-	struct perf_pmu *pmu = NULL;
+	struct perf_pmu *pmu;
 
 	if (evsel == NULL) {
 		fprintf(stderr,
@@ -2426,16 +2425,11 @@ static int set_filter(struct evsel *evsel, const void *arg)
 		return 0;
 	}
 
-	while ((pmu = perf_pmus__scan(pmu)) != NULL)
-		if (pmu->type == evsel->core.attr.type) {
-			found = true;
-			break;
-		}
-
-	if (found)
+	pmu = evsel__find_pmu(evsel);
+	if (pmu) {
 		perf_pmu__scan_file(pmu, "nr_addr_filters",
 				    "%d", &nr_addr_filters);
-
+	}
 	if (!nr_addr_filters)
 		return perf_bpf_filter__parse(&evsel->bpf_filters, str);
 
-- 
2.47.1.613.gc27f4b7a9f-goog

