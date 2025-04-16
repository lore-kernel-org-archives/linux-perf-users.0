Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B3D22B8A4
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Apr 2025 04:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744779100; cv=none; b=mDT/OqeN7VXH/lGhNMq47ngdD7ntIIf3IuHH9udvef7kXUWYevh4ZT2IQwlK3mmCj8YnBamL246PC3q1Eh0UjBqdmEO0ALFoKwVr4Cp5x7JAJ67/el4Iw4euIXK5puXXPD3g+/9vlgSZbbeayqcrfAYTfSALJemf2tfYOXrhZr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744779100; c=relaxed/simple;
	bh=ZOTsHlfTpSL/Ly5DC6zov/N/ZrnqIeX3TnDUs6l3nhc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ebsiI0343o5VdHIAkeFBzWJlr/OBpwcWFvTZyNos4499a92go1xJ/1wvm0mpb1ah+/Oawy8UjeqxKuk5EVdSWnmJC7CCYqfXYQE/dTJkrZLa012G0tGq1qtSDlLPt8nhDg6O74wKmoNgO9B7c1rtqiODyZgx9ym6B8kmufDA1mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ALyIc9lm; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ALyIc9lm"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3085f5855c4so403298a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Apr 2025 21:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744779096; x=1745383896; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qWGXJXdrT9sF0I7mA7+F4IJQ0dt51AALQlFzat3VGFk=;
        b=ALyIc9lmsya7hbSYBGhFkjjikTAy914pDgFnU+vAidHMd4d2elxqc8EAMz5nYh3BGI
         iqwNP0vXImDIjM51BSBBRre96DBO/MpOr/s4yM2HicNqHJZdI2pCehr3heRjT/h7g/4D
         ugtGFhMY2axdl86/xFeRmsDQS9A1ZmifdHJUaI1igchCciM6PfsdmGY3xP1l+E3RzuoD
         w1wE+F8CTxS/m+GFsVUc2VkKbkGiRF8KSpoSZ3rEqAmW7Lz0GaUjEOpArdqUhulv5oas
         ovZu9CYtDxSocOeINqhTCg6uOwFZn+HvvbN4oDHgqhoVem5sWyG3flp4VUnoWcfYqPhC
         ESrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744779096; x=1745383896;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWGXJXdrT9sF0I7mA7+F4IJQ0dt51AALQlFzat3VGFk=;
        b=IxwyhBSBidQuZOn2VO8Q/uiJyc03u+KbRMkrB5JA0UXc6+PDek2eM/YoM2ieGcgRJ+
         O6bZi8WtHUWlj/gew6iOiObZ0ts3yVqqW8BzRGK5cj2YIpZsKp6d1uerlJHQKKAD3LNQ
         ET7S4D0w8wAWoxJQA7OpY+ROXjbNxTo+C9yB4g4AUl5sDc6Iqseb755ZNvGRv7yrf/Mf
         83uIfEjwV2caLbBeuSk8aew9mvtYzjjQf7UxjByN0J4mHCV6cCyRyeGeYkzLLJGZSSoV
         CIJxeOzo4XNaxVCti0iVWHxTuHyv/X5P2gabGdGS8ZjbqsIWks5EuhtBjB5a5x0BGsHv
         VfLA==
X-Forwarded-Encrypted: i=1; AJvYcCVdpd+CZUoUZfWhPRnq3nDtQUCbqoZvLyVOaHZ6e+N7UMVEqlxIjCerX1ApyZQsj8+YhsTaY6hUTu3NxXosX1dT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+citODKltPActLzMp9MOYNTgRCBNBof6RwSKF73CW2vkXGJKp
	16hVQSLQyxA5goL8H8PrjIAFQfsdMFqES/rc8pgLl3w0QkOgdQNBO+k9GYJjpxwvsMR90RuOrU9
	0ao0ZrQ==
X-Google-Smtp-Source: AGHT+IFzs+p393a7mxlM3r7qnHxaFIdEo/RP9id0OjOQIRti4PH7xmLH1y5HCxIonfQ1rdoHNlT/H3fbkkEy
X-Received: from pjzz8.prod.google.com ([2002:a17:90b:58e8:b0:2fa:15aa:4d2b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:6c4:b0:2fe:84d6:cdf9
 with SMTP id 98e67ed59e1d1-3086415d88emr495438a91.26.1744779096558; Tue, 15
 Apr 2025 21:51:36 -0700 (PDT)
Date: Tue, 15 Apr 2025 21:51:17 -0700
In-Reply-To: <20250416045117.876775-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250416045117.876775-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250416045117.876775-5-irogers@google.com>
Subject: [PATCH v8 4/4] perf perf_api_probe: Avoid scanning all PMUs, try
 software PMU first
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Add PMU names when geting events to probe. The first is only ever used
but by not specifying a PMU name perf_api_probe will load all the
PMUs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/perf_api_probe.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
index 1de3b69cdf4a..a910cde4d78b 100644
--- a/tools/perf/util/perf_api_probe.c
+++ b/tools/perf/util/perf_api_probe.c
@@ -59,10 +59,10 @@ static int perf_do_probe_api(setup_probe_fn_t fn, struct perf_cpu cpu, const cha
 
 static bool perf_probe_api(setup_probe_fn_t fn)
 {
-	const char *try[] = {"cycles:u", "instructions:u", "cpu-clock:u", NULL};
+	struct perf_pmu *pmu;
 	struct perf_cpu_map *cpus;
 	struct perf_cpu cpu;
-	int ret, i = 0;
+	int ret = 0;
 
 	cpus = perf_cpu_map__new_online_cpus();
 	if (!cpus)
@@ -70,12 +70,23 @@ static bool perf_probe_api(setup_probe_fn_t fn)
 	cpu = perf_cpu_map__cpu(cpus, 0);
 	perf_cpu_map__put(cpus);
 
-	do {
-		ret = perf_do_probe_api(fn, cpu, try[i++]);
-		if (!ret)
-			return true;
-	} while (ret == -EAGAIN && try[i]);
-
+	ret = perf_do_probe_api(fn, cpu, "software/cpu-clock/u");
+	if (!ret)
+		return true;
+
+	pmu = perf_pmus__scan_core(/*pmu=*/NULL);
+	if (pmu) {
+		const char *try[] = {"cycles", "instructions", NULL};
+		char buf[256];
+		int i = 0;
+
+		 while (ret == -EAGAIN && try[i]) {
+			snprintf(buf, sizeof(buf), "%s/%s/u", pmu->name, try[i++]);
+			ret = perf_do_probe_api(fn, cpu, buf);
+			if (!ret)
+				return true;
+		}
+	}
 	return false;
 }
 
-- 
2.49.0.777.g153de2bbd5-goog

