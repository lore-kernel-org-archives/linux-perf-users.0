Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1AC1DA619
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Dec 2024 04:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733460056; cv=none; b=POQBAoPoT5mbrQZ9gdbM/mczrY0ltGvYL8B9vGOrk19jVM6O6RoQuqP1INI6qjjTeoyoWQYxXNa0I+Ae+gzHimSgVaC0spcOeIc8aXdSMUnnpfrm7YamjYmDbtQ714no1whEzY2Fc+nXePicI+Dtva3EVD7nk7a/UmLojxCLosM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733460056; c=relaxed/simple;
	bh=6qQMnPoV7toq2InjiyqPN49G1JW//BJ3BW+cL78lXpk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=WOhAosyk6iBNYtOOUP2BP5rvXjY21Aryzs+uZWorGrv0s5Yu8jUlEioIexq9GIybhEnpI0w82pYKZaqHVNiJ97o3ETVpeYz8BhJn8FVzNDtdCJlqFikb8+Uff/HmUIFazP9vob3sy+xgstn7Kimc8AIY7cAQoCLkxEuSgmkgZyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P6bQjJlF; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P6bQjJlF"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e399457a216so2397155276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Dec 2024 20:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733460054; x=1734064854; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4PLDQ9cMJwyt8LLu+m8FYi+OjRqKatCbRkdPuiWR/4w=;
        b=P6bQjJlFbhFZWfQ6XenH1y8deOqZ2RSENJxQ1iYR2F8EA1CEUTaFkyLEft0tg6Akaw
         z14LqzAS25OpLqLjSiw2TsqQJ8dztwjI+qL5e+Yd6jniCH1x6aIgCzDCsWMJFg12wkGs
         GDRh9EoRqFiQmN9isPdFZVCEC6c2jY0Owo5g91Cobxfa4UMwFsWHQut4s0KwOuZZGdjp
         g6MBDxR6sRrlltcbkkb/xmteZt9sJcsEcgDyDhaKNsu3mLSBd3EDWrUg73UAhE8akUqN
         kxZx9cNzqWxnjkZJDNcl8zCRgJMeLoiTY35yDayXlZG8vNzPTqEQWCB6PaertIMVKTII
         amKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733460054; x=1734064854;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4PLDQ9cMJwyt8LLu+m8FYi+OjRqKatCbRkdPuiWR/4w=;
        b=PNmj6ZjO4bljqXy/Kr6yQ3yGzM5q9k2QX8VvVCDfshK60sMelHSBpi2ZdfL2z0lzZr
         eQyJ/bUdkmDfrM5RhzYg/5fiRRLEbyQ/JT4NloubpPjUY5qPxVZcJSzeb7fwX/OKxxRv
         OFy4EhGu5FbxDB6BDRpKHlfq5Vj1Zryscm7T4gUiEJum7EMPASqkCYalMhZz/i7IZz+V
         olb+PUTAk0KbPIFsIwjEHPO0m8f0hsjaTCZORvkOUMu4UBFE9naT5xPyQo+2TbRaq0Yo
         rDNxW1D7Wk906QuX0bxocaNZzk900kDS3rc/4t24IP7a0Q9O1ZFWX/ZxxD6iBxgJBoTL
         y9Kg==
X-Forwarded-Encrypted: i=1; AJvYcCW8a37ilbMUmi/pzE33PpzTIkVSLg+f0P97Xn7El2EIpmuEuCDq6xw7QYfNqLkkfB15jL/gPuat3DaQ/CTy3Apf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ovVxCMaiM6CPB0bSAHponQ0L03cNYekDO7UtDlUhvgmWDnY2
	0Sx+JxBVocOVEBjEnFFrsmBjHDTCjzbz/NH31Cjhxa/7YrCry4Qqh/fI3xepgIETFNwNV3R31l4
	ijuCaCA==
X-Google-Smtp-Source: AGHT+IGLwIotlj7ZIG269cEmwqa4ILVBPe9NX3i6hHv+wncSepxMVPXgIEEsA2H9UUJWcX9Ob7d2QOTkOVMz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:eb75:393:2a8c:1440])
 (user=irogers job=sendgmr) by 2002:a25:d352:0:b0:e39:3168:53be with SMTP id
 3f1490d57ef6-e3a0b4a2261mr1162276.9.1733460053972; Thu, 05 Dec 2024 20:40:53
 -0800 (PST)
Date: Thu,  5 Dec 2024 20:40:34 -0800
In-Reply-To: <20241206044035.1062032-1-irogers@google.com>
Message-Id: <20241206044035.1062032-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206044035.1062032-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 7/8] libperf cpumap: Remove perf_cpu_map__read
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

Function is no longer used and duplicates the parsing logic from
perf_cpu_map__new. Remove to allow simplification.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/Documentation/libperf.txt |  1 -
 tools/lib/perf/cpumap.c                  | 56 ------------------------
 tools/lib/perf/include/perf/cpumap.h     |  2 -
 tools/lib/perf/libperf.map               |  1 -
 4 files changed, 60 deletions(-)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index fcfb9499ef9c..59aabdd3cabf 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -39,7 +39,6 @@ SYNOPSIS
 
   struct perf_cpu_map *perf_cpu_map__new_any_cpu(void);
   struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
-  struct perf_cpu_map *perf_cpu_map__read(FILE *file);
   struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
   struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
                                            struct perf_cpu_map *other);
diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 60ef8eea42ee..17413d3a2221 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -161,62 +161,6 @@ static struct perf_cpu_map *cpu_map__trim_new(int nr_cpus, const struct perf_cpu
 	return cpus;
 }
 
-struct perf_cpu_map *perf_cpu_map__read(FILE *file)
-{
-	struct perf_cpu_map *cpus = NULL;
-	int nr_cpus = 0;
-	struct perf_cpu *tmp_cpus = NULL, *tmp;
-	int max_entries = 0;
-	int n, cpu, prev;
-	char sep;
-
-	sep = 0;
-	prev = -1;
-	for (;;) {
-		n = fscanf(file, "%u%c", &cpu, &sep);
-		if (n <= 0)
-			break;
-		if (prev >= 0) {
-			int new_max = nr_cpus + cpu - prev - 1;
-
-			WARN_ONCE(new_max >= MAX_NR_CPUS, "Perf can support %d CPUs. "
-							  "Consider raising MAX_NR_CPUS\n", MAX_NR_CPUS);
-
-			if (new_max >= max_entries) {
-				max_entries = new_max + MAX_NR_CPUS / 2;
-				tmp = realloc(tmp_cpus, max_entries * sizeof(struct perf_cpu));
-				if (tmp == NULL)
-					goto out_free_tmp;
-				tmp_cpus = tmp;
-			}
-
-			while (++prev < cpu)
-				tmp_cpus[nr_cpus++].cpu = prev;
-		}
-		if (nr_cpus == max_entries) {
-			max_entries += MAX_NR_CPUS;
-			tmp = realloc(tmp_cpus, max_entries * sizeof(struct perf_cpu));
-			if (tmp == NULL)
-				goto out_free_tmp;
-			tmp_cpus = tmp;
-		}
-
-		tmp_cpus[nr_cpus++].cpu = cpu;
-		if (n == 2 && sep == '-')
-			prev = cpu;
-		else
-			prev = -1;
-		if (n == 1 || sep == '\n')
-			break;
-	}
-
-	if (nr_cpus > 0)
-		cpus = cpu_map__trim_new(nr_cpus, tmp_cpus);
-out_free_tmp:
-	free(tmp_cpus);
-	return cpus;
-}
-
 struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 {
 	struct perf_cpu_map *cpus = NULL;
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 90457d17fb2f..cbb65e55fc67 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -3,7 +3,6 @@
 #define __LIBPERF_CPUMAP_H
 
 #include <perf/core.h>
-#include <stdio.h>
 #include <stdbool.h>
 
 /** A wrapper around a CPU to avoid confusion with the perf_cpu_map's map's indices. */
@@ -37,7 +36,6 @@ LIBPERF_API struct perf_cpu_map *perf_cpu_map__new_online_cpus(void);
  *                     perf_cpu_map__new_online_cpus is returned.
  */
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
-LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
 						     struct perf_cpu_map *other);
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 2aa79b696032..fdd8304fe9d0 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -6,7 +6,6 @@ LIBPERF_0.0.1 {
 		perf_cpu_map__get;
 		perf_cpu_map__put;
 		perf_cpu_map__new;
-		perf_cpu_map__read;
 		perf_cpu_map__nr;
 		perf_cpu_map__cpu;
 		perf_cpu_map__has_any_cpu_or_is_empty;
-- 
2.47.0.338.g60cca15819-goog

