Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19A51DC04C
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Dec 2024 04:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733460058; cv=none; b=eKQLa0JGR/KNwKwoF0DuzRG7aXDdIwwbTy9TKbB8BVE9FSUHD8S5c0MfKS0DPDUZObuIBTN+OHFNgDVLxSQ1UuDkgKAqy7qUBnDvFDH4D5yI97ZMSku+r9z2JBu/bsMcDgcY4Be/VzXrgzMpAl+3vgRmEZ3BLm5yNnoFxHTXYp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733460058; c=relaxed/simple;
	bh=hQiLh7sZsGgCUtv2UvPu2RN6VeSmcwXkb3yt5YfihOU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=LRZQYG6Y5ExvXWcT+N+eilosla0ZWqsFH9F67nQAPRlM+W7bDXenZx1gGTqZ1b82OxaaNpK6/6V+Z8LLspadYvM6qszQAh4WpgbfGpipfAUsUCA9FVWh2FuW9REnpksI5CoReUsg/8BK1qaxIYeM7PFUPNNcJN0WQZ72CXLPQ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ROMvm6rU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ROMvm6rU"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6eedce8447eso12142607b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Dec 2024 20:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733460056; x=1734064856; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K8aGNRfDoJ3pTcSjnS5URRoovO9dVtKuYf6NSgPnrbk=;
        b=ROMvm6rUdD9dsWLRuB3lfH4USFakpAbru4HDP7Y6Wgf2lH9DBrDsXaTZDuVbpcnGvS
         JPO/c8GSxjBZmxcMWzLjoFJrz5UdseC9WP6bnyQCa2WQcAc33QQ6/xQSb6oq9Lcgt1Em
         aVU7PTiaHRJG+xf1hxt+Lc0CpKSvXu/r9vdgef1/UaLD90yMQB7Pt6WFfDhqBMkLbT3H
         nN07dJN0NDBv487E/FsueRpYM/YWRqkXnnSR9DneLVCXKKO6xvEBYrwoN1nMxlz7ggHU
         5P5kA7oXj3uIPBxf7ndfxE7SbdN3hfAngtkRSfqRuaKhyVa1RrMQrG8k6JdChituyiEk
         JW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733460056; x=1734064856;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K8aGNRfDoJ3pTcSjnS5URRoovO9dVtKuYf6NSgPnrbk=;
        b=bFskE8VX54GcmK2TGHTgZm9lQwNQn8vFSgPf7CDMdyybBdje9oYgbTpC4EQEdvffCp
         p6/PTcbfoS54LVygoGs+Zh4JAsi6O6wnVvGZ96A2+dfxNRbhJJBxr5yCuucmhjTJKUmx
         azQNu/7mMicLPWbwlQETURJACXdst+0mdGDZYaHulnUEf22SIK95w0d4cR13NRoLjDMJ
         4FQ/3Faot3MI+gfLladvBSlnaumwkj75OIOwN1AFYKtZN5H16pCFCfoli92xDkpv/L9V
         vfY5so8CrEgRCemN6ZmmaCwwwxxZrspB2/te43/uLh5gGHaGh6ueO2brZoY9q3vdxg/p
         dfCw==
X-Forwarded-Encrypted: i=1; AJvYcCXjCvq076waOYQSBuVozngbijyCYerBh8y6GX+ukMer2Y+mMkr9NnUNVnanLxmmxRRTmetJmOSac2z72npsEohz@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt8S4hb4FMCOBRxIzV0R0CIj+ysaLsb+jLc1Mng3NgTIMqInpu
	AALFeuPmvELEcdqNwZepkL+hNE3kO+TXTUiQnf8p2fs0LhJjkkOg2B7eba/eORbyx/rkO+RlOH2
	a4Tgrkw==
X-Google-Smtp-Source: AGHT+IHJTt6SspkYnMxQ2Ijr/i1yhHjbdWhgk+WnF1TdoCAiqORktrvqvdoCtq+W9OWyaq0CG9W7W6zO7Ul9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:eb75:393:2a8c:1440])
 (user=irogers job=sendgmr) by 2002:a05:690c:7007:b0:6eb:ac7:b1ef with SMTP id
 00721157ae682-6efe3bf2e89mr384737b3.1.1733460056007; Thu, 05 Dec 2024
 20:40:56 -0800 (PST)
Date: Thu,  5 Dec 2024 20:40:35 -0800
In-Reply-To: <20241206044035.1062032-1-irogers@google.com>
Message-Id: <20241206044035.1062032-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206044035.1062032-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 8/8] libperf cpumap: Grow array of read CPUs in smaller increments
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Kyle Meyer <kyle.meyer@hpe.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Instead of growing the array by 2048, grow by the larger of the
current range or 16. As ranges are typical for things like the online
CPUs this will mean a single allocation happens. While uncore CPU maps
will grow 16 at a time which is a value that is generous except say on
large servers.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 17413d3a2221..2237505f8f5f 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -212,7 +212,7 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 					goto invalid;
 
 			if (nr_cpus == max_entries) {
-				max_entries += MAX_NR_CPUS;
+				max_entries += max(end_cpu - start_cpu + 1, 16UL);
 				tmp = realloc(tmp_cpus, max_entries * sizeof(struct perf_cpu));
 				if (tmp == NULL)
 					goto invalid;
@@ -226,14 +226,15 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 		cpu_list = p;
 	}
 
-	if (nr_cpus > 0)
+	if (nr_cpus > 0) {
 		cpus = cpu_map__trim_new(nr_cpus, tmp_cpus);
-	else if (*cpu_list != '\0') {
+	} else if (*cpu_list != '\0') {
 		pr_warning("Unexpected characters at end of cpu list ('%s'), using online CPUs.",
 			   cpu_list);
 		cpus = perf_cpu_map__new_online_cpus();
-	} else
+	} else {
 		cpus = perf_cpu_map__new_any_cpu();
+	}
 invalid:
 	free(tmp_cpus);
 out:
-- 
2.47.0.338.g60cca15819-goog

