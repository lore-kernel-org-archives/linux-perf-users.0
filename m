Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1706B29C35F
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Jul 2025 20:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752696920; cv=none; b=ZomQbpkcHPPSv/r9RUt1dCpVhyDuZdqe58b//rzx1xEFtROgxEfHSTMjdR9aSjAG1mLFTRK9H0qnp0V1usyRZqhgK82q6z2CbdaDmDaZLIe5h1Sfc4my7PD+ssAqhPkAC9TpQDtuJvfrlDMPYFPgv+JJEwcYfen82IWfpDkc374=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752696920; c=relaxed/simple;
	bh=e2N7oTY2cgHu2RKJ+FKHz780v8w7gc4fcXnxguLDIU8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=smYZvND83KnnDDr5mxnytsdnOt6Dx+4jO1V/ujt4SXiHLTrFYz440qWhTVPshbQykf68QE6XcYYGevEDstnL62k+n9ddICHtp5HmYO/FT+tVtfwnPU0gfh1IyiQZTzhV2i9z5spkhfF4K5aqf6PqOcgO8519xbNGjWlCth7kJOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ga+cp8yj; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ga+cp8yj"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3138e65efe2so221829a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Jul 2025 13:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752696918; x=1753301718; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xcRx1AnfVIz4234lB8ggVFO+piASilvu9GQSG89S72I=;
        b=Ga+cp8yja5uNTcns8am9fwEFgI5RjILlCJWgjbv8JrM3snOX0T6XG2/ILZdZs7lkST
         BImwJRcD/lh1S2Pd4fIqarL/xCCkzuNg0INcXYtTJrnPHU4KLsrMKIiLQXn3/qVMFv/3
         00wvlwcNI0PEOXZoT2jPvtOloZayTpJcH0B7lbc2qE3KYjsVtqFelG7bxOkpCbayWAwy
         8gIYPUFCfHBzDva11uIUZKyfMweO7nZrAgyy7/m1fehgHJTSMEzwm2jVof3rNMlXAOmI
         pZzsD425UWnkb8arkt5IBHwZvLKBDpDH1qxFghg3bmGPQMZOPMiyzTIgvZHjuuTuVY8N
         mxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752696918; x=1753301718;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcRx1AnfVIz4234lB8ggVFO+piASilvu9GQSG89S72I=;
        b=fruU0ecuU54D93taLENmb8NeJnLQB3vtWlTi3rNApgKZAu+6r7eEAUJ3G4oyhsVmTu
         qJdJOJJ8S6/y2XNpWm4ELhR1R7PgWW01LfkK7mPRawOc3Oaxk7ZirabT6Dz381d6+Dys
         XDsJtrD44KPAYHnJu6dM8XY5CJ/C+3HoY6pjRMhTHg8kBouQPaERbIf9zou4GQ2iDwvw
         IL+h9b1S+E8l/Fk10S0H43B3EQUEOhwUp6nJ/DQ0Smhz26jRh47ahnQdq7cc45/gKK5W
         nwn3NnEd+2e+kIAtsrYbXEz2fC2TEPrmEfDGFie9Wfwxm/k+Jd/MeCsrUwfItWLx5zxw
         XjRw==
X-Forwarded-Encrypted: i=1; AJvYcCW0fFE1wQdjSgsWr7YJ0IUZqjImw84pEX3lovd7SVP4arZmx6ksszBXdwoYmuXIfVelJzvyfrNPAXrJmjhWJ5LW@vger.kernel.org
X-Gm-Message-State: AOJu0YxU9/GwtDr2yOYNi90n9hMybKjQQBFjecSmE58eON12GMogMsdV
	5I71LdAJ1/ZIRCVLEdHjS+elymqQlcZQp13EXzBVHJi6gHjKHLGe4ji0xbWn+7vX3nG8jzOpaNq
	XwcP8WHMT8Q==
X-Google-Smtp-Source: AGHT+IFXFIpR8tvs64KCwVrEAEYj5ZqRVuARd4HnUVyBiTRdTywmRrVQcsrH3+6kOTEgWsdaQsvJ8LZLPRA+
X-Received: from pjbst15.prod.google.com ([2002:a17:90b:1fcf:b0:313:221f:6571])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3cc6:b0:312:1dc9:9f67
 with SMTP id 98e67ed59e1d1-31c9e6e2d84mr6491611a91.2.1752696918425; Wed, 16
 Jul 2025 13:15:18 -0700 (PDT)
Date: Wed, 16 Jul 2025 13:15:11 -0700
In-Reply-To: <20250716201512.792052-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716201512.792052-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716201512.792052-2-irogers@google.com>
Subject: [PATCH v1 2/3] perf pmu: Switch FILENAME_MAX to NAME_MAX
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

FILENAME_MAX is the same as PATH_MAX (4kb) in glibc rather than
NAME_MAX's 255. Switch to using NAME_MAX and ensure the '\0' is
accounted for in the path's buffer size.

Fixes: 754baf426e09 ("perf pmu: Change aliases from list to hashmap")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index b09b2ea2407a..f3da6e27bfcb 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -453,7 +453,7 @@ static struct perf_pmu_alias *perf_pmu__find_alias(struct perf_pmu *pmu,
 {
 	struct perf_pmu_alias *alias;
 	bool has_sysfs_event;
-	char event_file_name[FILENAME_MAX + 8];
+	char event_file_name[NAME_MAX + 8];
 
 	if (hashmap__find(pmu->aliases, name, &alias))
 		return alias;
@@ -752,7 +752,7 @@ static int pmu_aliases_parse(struct perf_pmu *pmu)
 
 static int pmu_aliases_parse_eager(struct perf_pmu *pmu, int sysfs_fd)
 {
-	char path[FILENAME_MAX + 7];
+	char path[NAME_MAX + 8];
 	int ret, events_dir_fd;
 
 	scnprintf(path, sizeof(path), "%s/events", pmu->name);
-- 
2.50.0.727.gbf7dc18ff4-goog

