Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1A01F03CF
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Apr 2025 20:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743624978; cv=none; b=GmSXHkmQpVMVAUvICAcQZXMtZdezTIDYwfdK6wi6Ylt3uRfodVD/cYwAHIf2w+uiE/uI7JirJBqBSHudz+b8bO1EZ3Hq10uUXnoa34mhM+lqQ/iXHMyav0y1C2baoxR4C2tIMoqS535xwc/QoDxkSs8bgqRV5gTh82os+odlgJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743624978; c=relaxed/simple;
	bh=mdSSrhP7G24frprN16593VOBIgMZgeUhPBNK6wrZNsk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=eT9iCLRt/9gA23FtTUvyawvAWslJRsb/YKi4pK58xy3XRbe9ksm3yN5lAhnliLb5HQDcVf42SI3sIjBnbAS+VJsI+3zERgjQn4PlZVrcSuXQeiqDWBZrPRstMkGx3iGBQzbxcMZ7zyyIoZCwL2rqIuxlDAWx1Jf58ke77q08Czs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yipm/8kr; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yipm/8kr"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af570998077so184575a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Apr 2025 13:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743624976; x=1744229776; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=32l0Pu2pjVOQ0/rzRKMg0Sp9sEBo5wkzEsYD7DuEcpE=;
        b=yipm/8krmTWExkLJlePo7dM92sbC8vgIf9wYAbnKVgszX2MF5rE+rPzGlZHvEeYCaL
         isLFRNZ22EUSaFZ1FyPE5llzowUU3vQkqke+sPJHr99Z03/ZIh88EdQEL0IEG76Z/i5b
         fYg43pJVOuZ9itpKAcLXO7hZFCPxyiHsH9rf6NxkTYmX117tO3YDTfugjTgH59VbztEs
         HynIv2mMVSNeH4/KD58y5Lqr0rA7gFqCNvfnQjOUWbTKYOd9ex17RGb1noaBpxMr4reT
         ty5jmyekQg+SDiL4C93/D5ERD/QkeefvlJ9BCbiInAlZ6C+WyRXziXFQU+fGug4cFMM9
         0/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743624976; x=1744229776;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=32l0Pu2pjVOQ0/rzRKMg0Sp9sEBo5wkzEsYD7DuEcpE=;
        b=ujYHwiyOmH0vz/QUNDjaQGHQc/PEPYRyx42hI4MYuvgFliFp5DvOHaoerEHo0/48hp
         W8+ZuYI59b4LhBgLVMpHGnh8XFCz9a1ovl06KZg1gB3uRzklDHzdQqMliuB4ume/Ov9F
         JjhWJMEKDX7lHUHnjkVnOw8oVlkiX5cfgOS1gnhSJ5Suf5dWo6errsiqsIE69PVIddo1
         WvTb4ogThRBAQCHPi2W94OMmIGk00r02g+0vcylpgK1qbXh0yt1MiEoZMK4YJJUW2213
         msOm//4ll0BobgCQxeLVdd/tm/anm2OoGitx69S5lC0qmlWrzZsusOFLY3WjJ0HYi7yt
         hWRg==
X-Forwarded-Encrypted: i=1; AJvYcCWgoKFH5vco7dmmVwXZUA80759AYuh6GhnDWOzVnVzJFUyXBhJNXLyAcNy33fTgK7PlsByXnMYDQb1Fz4aRbBSR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1tNfL0V/MVxALcN3FgBwQJfzpD9loB3Lxdm8mbxlAR+rE+7RP
	OU2roJVVChAruyRZ8FW0P9ms1h3PmIDhJp5jFLicZsTY6bPy5yofgf4L1bYWVHdf+sYD8G0oNnH
	cKXmveg==
X-Google-Smtp-Source: AGHT+IEA5HC2pgKufmc8BlDFZQkWT4SBZPM+GdUwHnsP32QmD9Uj4LuXnzm5s7gHWkyrTRUYBQU+oV3zK5zf
X-Received: from plxx10.prod.google.com ([2002:a17:902:e04a:b0:223:5416:c809])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea03:b0:220:c813:dfcc
 with SMTP id d9443c01a7336-2292f9fa333mr300249905ad.40.1743624975684; Wed, 02
 Apr 2025 13:16:15 -0700 (PDT)
Date: Wed,  2 Apr 2025 13:15:45 -0700
In-Reply-To: <20250402201549.4090305-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250402201549.4090305-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250402201549.4090305-2-irogers@google.com>
Subject: [PATCH v3 1/5] perf stat: Better hybrid support for the NMI watchdog warning
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Prior to this patch evlist__has_hybrid would return false if the
processor wasn't hybrid or the evlist didn't contain any core
events. If the only PMU used by events was cpu_core then it would
true even though there are no cpu_atom events. For example:

```
$ perf stat --cputype=cpu_core -e '{cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles}' true

 Performance counter stats for 'true':

     <not counted>      cpu_core/cycles/                                                        (0.00%)
     <not counted>      cpu_core/cycles/                                                        (0.00%)
     <not counted>      cpu_core/cycles/                                                        (0.00%)
     <not counted>      cpu_core/cycles/                                                        (0.00%)
     <not counted>      cpu_core/cycles/                                                        (0.00%)
     <not counted>      cpu_core/cycles/                                                        (0.00%)
     <not counted>      cpu_core/cycles/                                                        (0.00%)
     <not counted>      cpu_core/cycles/                                                        (0.00%)
     <not counted>      cpu_core/cycles/                                                        (0.00%)

       0.001981900 seconds time elapsed

       0.002311000 seconds user
       0.000000000 seconds sys
```

This patch changes evlist__has_hybrid to return true only if the
evlist contains events from >1 core PMU. This means the NMI watchdog
warning is shown for the case above.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e852ac0d9847..1115efb380fb 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -822,16 +822,28 @@ static bool is_mixed_hw_group(struct evsel *counter)
 	return false;
 }
 
-static bool evlist__has_hybrid(struct evlist *evlist)
+static bool evlist__has_hybrid_pmus(struct evlist *evlist)
 {
 	struct evsel *evsel;
+	struct perf_pmu *last_core_pmu = NULL;
 
 	if (perf_pmus__num_core_pmus() == 1)
 		return false;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->core.is_pmu_core)
+		if (evsel->core.is_pmu_core) {
+			struct perf_pmu *pmu = evsel__find_pmu(evsel);
+
+			if (pmu == last_core_pmu)
+				continue;
+
+			if (last_core_pmu == NULL) {
+				last_core_pmu = pmu;
+				continue;
+			}
+			/* A distinct core PMU. */
 			return true;
+		}
 	}
 
 	return false;
@@ -872,7 +884,7 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 		ok = false;
 
 		if (counter->supported) {
-			if (!evlist__has_hybrid(counter->evlist)) {
+			if (!evlist__has_hybrid_pmus(counter->evlist)) {
 				config->print_free_counters_hint = 1;
 				if (is_mixed_hw_group(counter))
 					config->print_mixed_hw_group_error = 1;
-- 
2.49.0.504.g3bcea36a83-goog

