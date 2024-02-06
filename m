Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F58278B5B
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Feb 2024 04:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707193934; cv=none; b=q+v3liuBWa6RmrMwTSKUFqDvkzy3Sjyry2JMHIjhKdKBc2BXFbNFijS4YNmgiVpsdyPzA1pzkuW8BmkyOYMgtCPs7gJwfEPhqsYveDYqN50fRUcM0WmCbIk1COQEeD/IAYLEZxWZ0BIkl2mhsKqyTwyenkWQnZn+K1+DfpWjhnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707193934; c=relaxed/simple;
	bh=+dGqQcOQIiIKm4nZa/D+qKz6TWrGgBGYDyGjniDUOCI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=lGxKPM9iZnrbMK5ewH8Otn4tI2mCzhIqswLKYGUSYKduDRBpZBrx9pKhO8DtuBnJd8ICajXFPv2MkAifeWzjkpXFfWTHnK5LyF4W7OdYyyNLc6ezDWnp15B9cLNic2mN9CpI+lIPdWvy9h4asa44n+cwXMmnjfcPie8JOIlMsKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zgc983nK; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zgc983nK"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6047fed0132so524387b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Feb 2024 20:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707193930; x=1707798730; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eE8QPd1iYx3LHUzisH1HrCND1yAXDK1EtvXVhual9UM=;
        b=Zgc983nKC3l4U6De+l/eCtpfB4LN9AzpMN6CSuAdgUVpy3wZN1M2cmhRkGxltfEaTZ
         MvUBZwRaIEuNbg4jCFqDSCd40g6pW5+ptLfGGTSH0xg/Bdm+cqrKfJYmjdIhvxw2lgUk
         qrHOwhJFJUDRqIi8KX7reLElyqEzJB5LWOsG35c8Lj1JEcz2bVDwFpcMhFMcvU237iHK
         TDYOL1RjU9qoT/0JS+FlaM3Liu3c2jKU0ieLv5UjGHLXEFijmAdt9bNUnjyC4fdlnLUD
         foCV6586U43Z1Wn1RUGIUZqLUxWhuD+o8sSTGifhLvAbHUTm+HO3L/8J9ewVISv3ctNw
         mzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707193930; x=1707798730;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eE8QPd1iYx3LHUzisH1HrCND1yAXDK1EtvXVhual9UM=;
        b=O14B3ZOEjkON4BhOkHTw89mWrvkqcs7kHGVT6AswuEthyMtl3OWHUBlGLAtEV4QKzz
         A4Q/bL6nNenkqYpE5GSc4DoppQLcHnE22MS2Z57NlRZ66PdYqQVOXH5yMoLIMxyMYPZI
         eoxBynjY6nt9+kpB7sd80PoApYOki+M42iLZIUIstEE2/VLZs8kq7qJNQTf3FWoue+GW
         0QwVZhd27CQfeghI/V3Fs1mFfQ/1TJ23OBhL0vkri5nDBMHZ2Lw81h6cnf6EakKi0fM5
         BMuymc3CuifKz/woaENNFMqcOZ9hiCOANN9zfkWUvd8LfyqGRGn6yBpA2I1nofUS13Bs
         AgGA==
X-Gm-Message-State: AOJu0YyyfwtZ90sAJ8exH6mga4iUc1rZW4y4RxznoWiueqk0HUAL/fHz
	71tJn2B1eTutm/zYOA2QsMrhpp4Ci5U6pGdneqzNXH9g3VoHsHNuuO5hEx1M2/tiSCoK51/3E+v
	w/7QY+w==
X-Google-Smtp-Source: AGHT+IFs8WVliW6lEpIOaQZTGS4k5cTnGBBP/qnkpPAdjSWSWu+uKXXHv+WwRmeGYmvINFcqL+zNEtpVjMne
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:326b:71bb:e465:6f39])
 (user=irogers job=sendgmr) by 2002:a05:690c:ed4:b0:5ff:796c:722e with SMTP id
 cs20-20020a05690c0ed400b005ff796c722emr94174ywb.1.1707193930365; Mon, 05 Feb
 2024 20:32:10 -0800 (PST)
Date: Mon,  5 Feb 2024 20:31:59 -0800
In-Reply-To: <20240206043159.2539981-1-irogers@google.com>
Message-Id: <20240206043159.2539981-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206043159.2539981-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v2 3/3] perf stat: Fix metric-only aggregation index
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	John Garry <john.g.garry@oracle.com>, Kaige Ye <ye@kaige.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Aggregation index was being computed using the evsel's cpumap which
may have a different (typically the same or fewer) entries.

Before:
```
$ perf stat --metric-only -A -M memory_bandwidth_total -a sleep 1

 Performance counter stats for 'system wide':

       MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total
CPU0                            12.8                           0.0                          12.9                          12.7                           0.0                          12.6
CPU1

       1.007806367 seconds time elapsed
```

After:
```
$ perf stat --metric-only -A -M memory_bandwidth_total -a sleep 1

 Performance counter stats for 'system wide':

       MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total
CPU0                            15.4                           0.0                          15.3                          15.0                           0.0                          14.9
CPU18                            0.0                           0.0                          13.5                           5.2                           0.0                          11.9

       1.007858736 seconds time elapsed
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 8c61f8627ebc..ce830c6afdf2 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1126,11 +1126,16 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 			u64 ena, run, val;
 			double uval;
 			struct perf_stat_evsel *ps = counter->stats;
-			int aggr_idx = perf_cpu_map__idx(evsel__cpus(counter), cpu);
+			int aggr_idx = 0;
 
-			if (aggr_idx < 0)
+			if (!perf_cpu_map__has(evsel__cpus(counter), cpu))
 				continue;
 
+			cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
+				if (config->aggr_map->map[aggr_idx].cpu.cpu == cpu.cpu)
+					break;
+			}
+
 			os->evsel = counter;
 			os->id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
 			if (first) {
-- 
2.43.0.594.gd9cf4e227d-goog

