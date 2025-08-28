Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FB6340D8D
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414808; cv=none; b=iafOOoKuMwVQ2HWCEYo1VR2uOWEr50QmTA0RsGsUx+MEK2snpyklXZBhougzU3mWa6HoT9rOdzmubiEQIeiSKwc4rW2h52zmNnKJhWcxcmW1XUmMdGXBR10CyLq6CgaPlQF0q8Q3YLcQbko0uAAnaAbpGJhOsMaXZPkDfq2OqXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414808; c=relaxed/simple;
	bh=OAN+8LPMukdu5dgxkvakBf+/9iFJXuGvrK7tSR9LUbU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=BGy4z/+CO2slz6IAH0mYMXUjGvTlXju1aR+Tum53V265HAkgMH6MHZeY0y+Wif7N7IWoLdkx8BRx36RlNCjGfstcE+3QKMz8wIoUbROUwydKh3ffJw8JogtGAgNCqcvEMvk2Qy3RrNg7zXo+7pguJ9zVxgfLQLg2u6CzxJbZLs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s2w+VL1h; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s2w+VL1h"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24458274406so25904395ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 14:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756414806; x=1757019606; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6dys8Aa/90XBuzSMjRwrAygLQHbdLbHxpcpKidAhuPA=;
        b=s2w+VL1h5dXSx2Fq96FS8KHJL+QOkkv/722dSoSQAi8CvjeMM5ESgdK7zO53Ss4vLM
         Biy969GViU/wjgyJ4Mym3OdqjJJeV/ZUAEb1nvkKo91ps9o4t985VBZ4b08z/JlSVKdA
         DE19XewweAhlikqF4xuM8mUO5zsNOUVdjQFzwx3boabajzJ+XM/qmloLMtCEY4W2BRzm
         ChAMZfk0uCUGN+zr2olUVNs8uoib8ThUkDOJ0A31du6ujjOS1CpTfHRzvrsNaRAgKjWA
         IiDdlawL0yPNCEan8gBLsXBmROehZv+rYSMFo41BficXwXVdrfrfunBGs32t8enYo5QV
         brRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756414806; x=1757019606;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6dys8Aa/90XBuzSMjRwrAygLQHbdLbHxpcpKidAhuPA=;
        b=F/Yugcu9T0wsBY7ZXBqr7t0+1o+2t6Pc8rHefFDAEgAeBbjnIw/c0E/CevNXtCdiql
         olOA96fj7QetGxtUEFr8uiXwgXZ3ESAraVa5VF5bUEyZN7wqj0vUYDEqCdf8NRfLZQ9D
         23ef/2lihjQAdaQEIOC3lN6BklO7WhxF21qJTRVIjBZ5IsI8wum3tUumvik0hk6XUYjd
         D6LLDbs1Bofd/8KTv/Z5YRLmVIf5qf6HklN/PKjYLYvECtYzTgbwkE5ozSUlfDAcPLUx
         8drWX/yilIxc6v+89Ge4BWYj2F/CfSZb+qLHzqkTFt7g1ks5AaQnq3kFWIjKc+C8xXwJ
         5OSA==
X-Forwarded-Encrypted: i=1; AJvYcCWjakNjOcC0ZSIrO+jXayGIeuWUGrfbjJTtT/fTd/KwSe2c3m9Nm0FN+bsydUraApC+Q4mtAovwFGLafCjdZGA2@vger.kernel.org
X-Gm-Message-State: AOJu0Yzztokfr/wNpS4PvVzaqHJTBtW0nDFcXyEX94Bt0AKCgRNaQWU2
	20DUxiEJUhGyjcEW5W2ZJW8g5eqiIpbnAmG2RL9K61SX/wrgRsxIEAxFSjCYnoLsLoQho3B78nO
	YDpe5qJzpvA==
X-Google-Smtp-Source: AGHT+IGcNCtFhdq4mrjQsHNV3i+iE7zcBUKuNgZSUJJ5JnvCwFPV38o/29+7WGktv6aOFkDV7xmYESVWKjVr
X-Received: from plbki12.prod.google.com ([2002:a17:903:68c:b0:248:7b22:d928])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:240d:b0:248:9983:fd9c
 with SMTP id d9443c01a7336-2489983fea6mr122425635ad.57.1756414806184; Thu, 28
 Aug 2025 14:00:06 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:59:22 -0700
In-Reply-To: <20250828205930.4007284-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828205930.4007284-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250828205930.4007284-8-irogers@google.com>
Subject: [PATCH v3 07/15] perf pmu: Use fd rather than FILE from new_alias
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

The FILE argument was necessary for the scanner but now that
functionality is not being used we can switch to just using
io__getline which should cut down on stdio buffer usage.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index b44dfe4c73fc..818be59db2c6 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -563,7 +563,7 @@ static int update_alias(const struct pmu_event *pe,
 }
 
 static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
-				const char *desc, const char *val, FILE *val_fd,
+				const char *desc, const char *val, int val_fd,
 			        const struct pmu_event *pe, enum event_source src)
 {
 	struct perf_pmu_alias *alias, *old_alias;
@@ -614,12 +614,15 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 	if (ret)
 		return ret;
 
-	if (!val_fd) {
+	if (val_fd < 0) {
 		alias->terms = strdup(val);
 	} else {
+		char buf[256];
+		struct io io;
 		size_t line_len;
 
-		ret = getline(&alias->terms, &line_len, val_fd) < 0 ? -errno : 0;
+		io__init(&io, val_fd, buf, sizeof(buf));
+		ret = io__getline(&io, &alias->terms, &line_len) < 0 ? -errno : 0;
 		if (ret) {
 			pr_err("Failed to read alias %s\n", name);
 			return ret;
@@ -698,7 +701,6 @@ static int __pmu_aliases_parse(struct perf_pmu *pmu, int events_dir_fd)
 	while ((evt_ent = io_dir__readdir(&event_dir))) {
 		char *name = evt_ent->d_name;
 		int fd;
-		FILE *file;
 
 		if (!strcmp(name, ".") || !strcmp(name, ".."))
 			continue;
@@ -714,17 +716,12 @@ static int __pmu_aliases_parse(struct perf_pmu *pmu, int events_dir_fd)
 			pr_debug("Cannot open %s\n", name);
 			continue;
 		}
-		file = fdopen(fd, "r");
-		if (!file) {
-			close(fd);
-			continue;
-		}
 
 		if (perf_pmu__new_alias(pmu, name, /*desc=*/ NULL,
-					/*val=*/ NULL, file, /*pe=*/ NULL,
+					/*val=*/ NULL, fd, /*pe=*/ NULL,
 					EVENT_SRC_SYSFS) < 0)
 			pr_debug("Cannot set up %s\n", name);
-		fclose(file);
+		close(fd);
 	}
 
 	pmu->sysfs_aliases_loaded = true;
@@ -1041,7 +1038,7 @@ static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
 {
 	struct perf_pmu *pmu = vdata;
 
-	perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=*/ NULL,
+	perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=*/ -1,
 			    pe, EVENT_SRC_CPU_JSON);
 	return 0;
 }
@@ -1090,7 +1087,7 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
 				pe->name,
 				pe->desc,
 				pe->event,
-				/*val_fd=*/ NULL,
+				/*val_fd=*/ -1,
 				pe,
 				EVENT_SRC_SYS_JSON);
 	}
-- 
2.51.0.318.gd7df087d1a-goog

