Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P9S4QcPW"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4413C102
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 10:23:36 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db5463707f9so4428696276.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Dec 2023 10:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701714215; x=1702319015; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SZ0pxQHPPtXifBYnQK2oqRhP2CZVwJXTHj6rC9GaE3c=;
        b=P9S4QcPW5Eh/3vBzx4A6vHvsIbdvrm7Hvr0V0y80HGL8IYg62FJv6KsMWsMFdUaWMO
         N9qhefubyi1bAbmDVqjYEFrorVqM6RHQCOZNgOG+9i7ZZD4rMWtt+EAikFY7TcK97jNy
         epM4/byRmFSZyv8abKGyFOSyomlXjYA9AasUlktW06JTychjoMLxbnhTJWLFkxR3HEiI
         RCxo5XyDefB4n24h4kbjhVVwmuebJhCQl/80WvulztIoHDjVA6P5nvQJLHWzkCJPtHsa
         tbACaKlXYz6/cCHdQupSqlt0662wrsF7IV0nNneTIdROvdgH2Mf8EglzBeXAAtpiivyO
         AiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701714215; x=1702319015;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SZ0pxQHPPtXifBYnQK2oqRhP2CZVwJXTHj6rC9GaE3c=;
        b=WRSBIU17oQfmjgDc32Mq/L/rHkR+QNiXfGcwEiu5Z235EFnbxOGXDSNz5zg3drpQ8/
         U9VXUYvkQIHPtfkHznVw7AwS9uStat7T0EYwOVE+YcJisCer1daWXMBMvJ3mT0QWCLoc
         ojm0REjSbmPsjf69Z7CJ+lsx3VCEl469ehxW9YavvjC+40vPncJjHyEWRD+3+7EgtpNM
         sQvvslU6MwGfkQaeGERlxBW4NlFotsbfH1GyHtXSHIpfZjB/qRpj/KfMylMUuqjL8yvk
         rQl7pjwVJBh2GYzMdIMSO2Vm089RSNbtI8HjGBkELXB91uQ7qFzl2M2Z9DWcYQ5xpELi
         DufA==
X-Gm-Message-State: AOJu0Yz9Z5iPHV9AwGIHz7I5yUdA9QQu2Llo+dlsXJR++6Yki8569Z55
	xH8NFK3sCsA8qBfqLeeTcimNdKDQlcAA
X-Google-Smtp-Source: AGHT+IEi0XJiqlbzPFe4i2AZZ6mCBKtqb89HyDPZeG0sLxj598uJOhxVo9IAsT589yyTX39eoBGSOL+OWZ5d
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b241:d804:967e:c827])
 (user=irogers job=sendgmr) by 2002:a25:cace:0:b0:db5:4692:3aae with SMTP id
 a197-20020a25cace000000b00db546923aaemr331621ybg.4.1701714215509; Mon, 04 Dec
 2023 10:23:35 -0800 (PST)
Date: Mon,  4 Dec 2023 10:23:29 -0800
Message-Id: <20231204182330.654255-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1 1/2] perf metrics: Avoid segv if default metricgroup isn't set
From: Ian Rogers <irogers@google.com>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A metric is default by having "Default" within its groups. The default
metricgroup name needn't be set and this can result in segv in
default_metricgroup_cmp and perf_stat__print_shadow_stats_metricgroup
that assume it has a value when there is a Default metric group. To
avoid the segv initialize the value to "".

Fixes: 1c0e47956a8e ("perf metrics: Sort the Default metricgroup")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 0484736d9fe4..ca3e0404f187 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -225,7 +225,7 @@ static struct metric *metric__new(const struct pmu_metric *pm,
 
 	m->pmu = pm->pmu ?: "cpu";
 	m->metric_name = pm->metric_name;
-	m->default_metricgroup_name = pm->default_metricgroup_name;
+	m->default_metricgroup_name = pm->default_metricgroup_name ?: "";
 	m->modifier = NULL;
 	if (modifier) {
 		m->modifier = strdup(modifier);
-- 
2.43.0.rc2.451.g8631bc7472-goog

