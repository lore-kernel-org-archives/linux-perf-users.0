Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC503A8F8
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Feb 2024 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499283; cv=none; b=sdr9b24HeBJchxqIfmbWY0OOtOzHKdI1nHbOcfcJaXcQU7+2Es2qeagc19wM95JefIwMuaU3+Ae1RGx7gbDvNZSTpmAQTieVJlal7g3UE7PL+/Sc91Cc8CMEyqi3d1bNekL8EDMq2cV4pjyBMb6PVYfu0FeCpgrt696q9NkrUWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499283; c=relaxed/simple;
	bh=VTnFedSHbWRXdPeVX5bVM50OyRSGy300r/pvDJawCfs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=dUmFoBO7ZhKQTiwyalHiBkSWvC9dEMu9FkKSQYKYWzMlYgRvCYJfoEFyzkoxcYReiYBADplcnqHj0TcPtBD2hFrtvWXZFs3CaCUxq0CyzFpepfvxmfzsxYNShbsbCB3vTQz1KbVR99bx4D/CKmK+HBI6rHAwVnIYiVdJmW9Ib0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u5WMWwiS; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u5WMWwiS"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608886b1a3aso983657b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Feb 2024 23:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708499281; x=1709104081; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DfVuTk7FcAUa184IhDAbJwuMC16l/TIzHOCMWidcT2s=;
        b=u5WMWwiSuRnVlwYVjkghy8yD3+KyPndGBwJfXJ3oKw/BulP7ut1YfR1R9vuMafZ1V2
         fGzEfiA49uhG7VmObQzrcbNRYV13emTfYeZ6SSqiqxtNG22tvRMAl5n5UK6gR6qSvFtg
         Pq0kPTpxlRn4r4r7y/pV9Det5kO0rnCLFh8Yf7JHDxKI+Kwj7yxWWgOn/ent8eAN3l8Y
         Cy6WZ5Fr6+JOShEM9A0G507i6PxF1PHmYKLBjZDbTNuTwgCk9fpbMcxZN9iMPAJJp0JW
         y5CaPMzksKBcWYfZXzL8be9GlSwiESvNCzd28wVz9uUSc+nrIibcuBGlyclG6EVfYPo3
         w3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708499281; x=1709104081;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfVuTk7FcAUa184IhDAbJwuMC16l/TIzHOCMWidcT2s=;
        b=xJ7VQuBi1hdvVTgWyyVD9U/u4tVIcdy1DjAr1C/HCSlwhNeAL+Iuit0FecNJCKlBZT
         pAaAZ3MBRmkC6moHKSx8tCHbif7l2ZzJvGbvg/DjTfBAYU3t6omMdBeVmnM8pvwyWcfZ
         yxverJY+wkuEOtQcFcUI4WxpzGTuXbqv/jJwF/JLuMnVhgpn5OP9u7X85sjwS+wo3G9U
         NCfSwOl4hVHJPab4YfLbl+cM+N77wPYiYDbI5zYGRiQ5lpF87WMJ1WRdmPrRgH358pWI
         QlUCnHvsITdm2FpfVVHKVPmW/ONkBtp5QW6Md/rJA4fWpbLsOe/NtBvALrXPA39LrOeX
         iQnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh4k3xDD4URDAlKeuuokT4yPqwVf0lUqhSAyinzNs+ZLEoHIiTGaiB/WUsMMXj4BiFuyzHQRb14/PvO5GL1eUbTZPymJHWlI4jjypyE0L8Eg==
X-Gm-Message-State: AOJu0YyKJd7YnbHLbgZaGpDPctJMhhIKFiRTw3eYaULGv9+7anfV9lVY
	35TfVwhS5IGAmNLCI4+z8u5E38dCEgCZ8leGub1dJdbSqTJvNJiPiJFDUFIXyjsAZ2MtAFyDN12
	qko5HHw==
X-Google-Smtp-Source: AGHT+IEjSgJYS5XU5/3VduLquncZCLuHXOsyv5NjgSTN6RCN2NQWWZVx/AxQIvEZPul2v2cXQ4FctOlKH6g7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3c02:f882:5876:b7ab])
 (user=irogers job=sendgmr) by 2002:a05:6902:98b:b0:dc6:ff2b:7e1b with SMTP id
 bv11-20020a056902098b00b00dc6ff2b7e1bmr5058563ybb.4.1708499281168; Tue, 20
 Feb 2024 23:08:01 -0800 (PST)
Date: Tue, 20 Feb 2024 23:07:54 -0800
In-Reply-To: <20240221070754.4163916-1-irogers@google.com>
Message-Id: <20240221070754.4163916-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221070754.4163916-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Subject: [PATCH v3 3/3] perf stat: Fix metric-only aggregation index
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

Signed-off-by: Ian Rogers <irogers@google.com>                                  |
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ae37395f90c0..bfc1d705f437 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1137,11 +1137,16 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
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
2.44.0.rc1.240.g4c46232300-goog

