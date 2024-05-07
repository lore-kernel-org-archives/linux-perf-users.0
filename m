Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D1D16E869
	for <linux-perf-users@vger.kernel.org>; Tue,  7 May 2024 18:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715106975; cv=none; b=tct9aOwGoiTkR5qqML7P2+FKfmU1jYQWQWZwMT6iLxzBs02X7hn2FP1qzZHtDd3bUC1nZTrZMwyf5vckA5k/HzBx68Hy9xJc0FXF1SMh/Mwb9flZCc5JQRfzutpwvIVLZZB8Ri4kRl7ylfrUI1UO5/lrlr2o3wJOLyN5+phCKAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715106975; c=relaxed/simple;
	bh=1ZVRDSMy75ejf8D/9j8I5oq6yhZXUPDAiSppOkR/Qsc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=eA0WaebO2+I1umo9cRhgo22Kbsu6X0ouiIr08IzBX19JeJcelxDp6qaGhSu/tcD80wjZkJ+kZRp0Mb8EXQMGcDAf1OwHJJquD3UKBqoYqRBnNBYVYDcWX68DslRo4CD8pPdnczJdErUj9yuL9OrJHcSJzzdQoL8MV/J5oTxib/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kKHdllpN; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kKHdllpN"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de59ff8af0bso5351507276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 07 May 2024 11:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715106973; x=1715711773; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jsvhOcC7MBczoTzNxBUcoVKQW0Fceq86w32j6zIJUUE=;
        b=kKHdllpNQnnWG3UMpszGXwtJYpDxl3hboiz+A6zwVVE/DIGpC54DmgHZ1JiKIORDeR
         wmnVcHeEVQRRQj8RFzpIyiotPM22v+J0V69Vn1A2y64glWl5GDZrDPms9rER6Xus4dYS
         hC090rCv+D6WvLBILJXnModyPAtc56OcMlyswMtqEhSFsU87i1rpmWTvkOL0c/psGdlf
         H7tY6XqtkMMxP2iUROMeuNm1+QPzfcEEtidBokIB9O3jjn/J9+gVndXN5cQBIvKqV4jW
         pJftE1M2cB9h4HYp90/g2r9HoRComOfOr43qUxJR8K3DyWaLMvSANRhlssXaKNQv2dmJ
         k+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715106973; x=1715711773;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsvhOcC7MBczoTzNxBUcoVKQW0Fceq86w32j6zIJUUE=;
        b=b8Pk8iWWwaH5EDRi13hn/WbNkE9yuZujMsHNXb+PA0qXjvve9aFSuXbTEc3qZL6HmH
         eqNWR4CO/EWnyiuTzZEiueIF6HaMwuk7CCfaB3HeMaVbArcLukZiBEa2akZkQMbj4S2h
         qL/lOqPd++q/QbU0HxgZjYAdDlkrOLa2hxjjKWf69gry1yGoaW+nlxqIV9TwXSoGekZJ
         2rfEx+4sbCV8usuHuj5bEf4FmhHTief6AUPX2b5xNA5BnrWc4KFX0F9FbNq7sLiECezI
         AX+NIMIACJJQ/sKCO/IQO2AAHtuDkTmBTHSfSa/zrxprQYcqC4BALlTaH0ojyJGNQvV9
         vm2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQYVQAuMaTzXtJjNid79oxyVwyljjpAVnoCKweGN4ZBxYeIBoLkAnQxMeMOEGuoftOAl5pR5qiEFo6KvSbndSKw1FitqSRNINF39dHgCxtWw==
X-Gm-Message-State: AOJu0YykF1e/KoEc2v79ERzl8kfKiCPscmWRZO+egsivRE+GXBIBmBhA
	fxDyPWj9/ahvNyIEd8EMjfHGaRwK2HJLzVzFXL1tQXK+7HGhPpuP9fhRtnszCfTv/x4fJ5z/+PW
	pcIXQoQ==
X-Google-Smtp-Source: AGHT+IFCmv2nVWz91raNmYWeKeQFOBY+cKG6SR192KEBCq8V3FtHad2/q8sCavEWaklZgl6bmFCxn1CSji3V
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8095:fd7:9773:b1df])
 (user=irogers job=sendgmr) by 2002:a05:6902:100e:b0:de5:3003:4b64 with SMTP
 id 3f1490d57ef6-debb9cd89d9mr54838276.1.1715106972741; Tue, 07 May 2024
 11:36:12 -0700 (PDT)
Date: Tue,  7 May 2024 11:35:41 -0700
In-Reply-To: <20240507183545.1236093-1-irogers@google.com>
Message-Id: <20240507183545.1236093-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507183545.1236093-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 4/8] perf cpumap: Remove refcnt from cpu_aggr_map
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	James Clark <james.clark@arm.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Kajol Jain <kjain@linux.ibm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Li Dong <lidong@vivo.com>, 
	Paran Lee <p4ranlee@gmail.com>, Ben Gainey <ben.gainey@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It is assigned a value of 1 and never incremented. Remove and replace
puts with delete.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 16 +++-------------
 tools/perf/util/cpumap.c  |  2 --
 tools/perf/util/cpumap.h  |  2 --
 3 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 65a3dd7ffac3..35f79b48e8dc 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1631,23 +1631,13 @@ static int perf_stat_init_aggr_mode(void)
 
 static void cpu_aggr_map__delete(struct cpu_aggr_map *map)
 {
-	if (map) {
-		WARN_ONCE(refcount_read(&map->refcnt) != 0,
-			  "cpu_aggr_map refcnt unbalanced\n");
-		free(map);
-	}
-}
-
-static void cpu_aggr_map__put(struct cpu_aggr_map *map)
-{
-	if (map && refcount_dec_and_test(&map->refcnt))
-		cpu_aggr_map__delete(map);
+	free(map);
 }
 
 static void perf_stat__exit_aggr_mode(void)
 {
-	cpu_aggr_map__put(stat_config.aggr_map);
-	cpu_aggr_map__put(stat_config.cpus_aggr_map);
+	cpu_aggr_map__delete(stat_config.aggr_map);
+	cpu_aggr_map__delete(stat_config.cpus_aggr_map);
 	stat_config.aggr_map = NULL;
 	stat_config.cpus_aggr_map = NULL;
 }
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 6a270d640acb..27094211edd8 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -180,8 +180,6 @@ struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr)
 		cpus->nr = nr;
 		for (i = 0; i < nr; i++)
 			cpus->map[i] = aggr_cpu_id__empty();
-
-		refcount_set(&cpus->refcnt, 1);
 	}
 
 	return cpus;
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 26cf76c693f5..ee0f6139b04a 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -5,7 +5,6 @@
 #include <stdbool.h>
 #include <stdio.h>
 #include <perf/cpumap.h>
-#include <linux/refcount.h>
 
 /** Identify where counts are aggregated, -1 implies not to aggregate. */
 struct aggr_cpu_id {
@@ -37,7 +36,6 @@ struct aggr_cpu_id {
 
 /** A collection of aggr_cpu_id values, the "built" version is sorted and uniqued. */
 struct cpu_aggr_map {
-	refcount_t refcnt;
 	/** Number of valid entries. */
 	int nr;
 	/** The entries. */
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

