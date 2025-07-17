Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0962F85F6
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764950; cv=none; b=fn2NhszR9Z30FUz9YoME9qRnHkArXlm9zDHKxdBpQsUHzzU+miENE9ZB3/1bMK13cAmFsLfV9iq4u5XeQEi3r6LimWyMzqnrLJQCgPhSC9+p5JJL9CCANDH62Pwy203mAnGlPvBYaaoO+NUso1N5e2Suy6Z9+CDYN9BbscxAcsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764950; c=relaxed/simple;
	bh=e2N7oTY2cgHu2RKJ+FKHz780v8w7gc4fcXnxguLDIU8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=eKpTBIDtJ4kAFxPi8x6+ussO/NJXBzve/lqjCdvCrX7/F5wna1a8D+C/FJSuv791JwpMy+WS8fV1k5yR28bY9V969iWzJaGIi47mWZd7Fh0m3eXXc4gy/kO9fJV7Q8XiH+GihzveHu5GDW71BfgkcGhRAEkaHlkkI+GFHWRI6RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UBrG9y6l; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UBrG9y6l"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2fcbd76b61so1223580a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752764949; x=1753369749; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xcRx1AnfVIz4234lB8ggVFO+piASilvu9GQSG89S72I=;
        b=UBrG9y6lYnAedbQ3p/oTigAY9QrKH2HvNL0gGipfOor6eZ7RCPfsoZNff1WYsoMPrl
         UP/nSW2ijLnOrq/b81OkOPUNmNBfkWQeYxnBX9qnyEcsd438kIlgDF33vQzPAFQ2Fqqt
         VmVGIjpksyFUcmGKu7TRrcnyWut8qFUBEDXPPcWHMNlKof7xwJIKk3jjuVNiGhYiT0Ot
         9D6I0eHVvvz/fmK00xOodsgd8717IzPL6fa3tkQScoGwEcEZ4S6zplm3P3s2K6yIMTB5
         48CKD7kEP43ZIZVxjCjxFox4f5psYCrQ0jDqY1U9LbS1Zl+ba/sxZWPzhTx415GZq0wF
         u0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752764949; x=1753369749;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcRx1AnfVIz4234lB8ggVFO+piASilvu9GQSG89S72I=;
        b=pUFhuzsGLZlrjdNCEzyODJ2E8Rm3WY0yK6Fe41t4Wnjjhf/7MRzmgHSmumLPByS7LG
         HNBnBYFWD9D8su9lD5pCuodZ8Y1JEatm1DODqiMgK5E2KUO7CFAbXAv7yrBEAb2ckdip
         ekr2OuGfWnilRN0xTOT0kxmYDGwFdfhAbFwhLapxP+BfXHNWEFLZqVk3lUtBNUDcqOc3
         zCtZ9FFSfjUfHfnoIu6VEmab/V9q3khny3Kj7rrrGSkbeSkZGbR4tj6bE1H7DbOPa+xQ
         a2UpxEL8i5i95VSl5MnUvqE2n+g4hn5phgpOR6OGWUm26bse9/degsX7QzSSigbsxZeS
         ri/w==
X-Forwarded-Encrypted: i=1; AJvYcCXqsohlD3IoyzwIBiKtHAKpNqeZ0jr50gb4mHyy+Z0NIQz1oWxGkXp2SZi0E9QniOvTZjDkqUassiKSxPMf3PFJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi5TsMOjbYRRDb5mlL9zPNkNTQuuyVRGZ80nFaDtgS76TRcD8x
	CPWJJR8OJaE2TMfXtRx+EIT5VfQbf9yJKjkAJ0J0Nce2cNNJW2SzvtJVMKcQud6zt5C8JG0CxmK
	0TGkEIHUAwQ==
X-Google-Smtp-Source: AGHT+IHSj8dNhtoUR+ln6GApAc1Wa0LZ6OyasRb6Nd6ZtNENLFtcT6z3cMDUavEA6p5ZusIU4xoikFN8aOn4
X-Received: from pjff6.prod.google.com ([2002:a17:90b:5626:b0:311:d79d:e432])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:184d:b0:311:f684:d3cd
 with SMTP id 98e67ed59e1d1-31c9f3c6068mr9597668a91.12.1752764948730; Thu, 17
 Jul 2025 08:09:08 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:08:54 -0700
In-Reply-To: <20250717150855.1032526-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717150855.1032526-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717150855.1032526-2-irogers@google.com>
Subject: [PATCH v2 2/3] perf pmu: Switch FILENAME_MAX to NAME_MAX
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

