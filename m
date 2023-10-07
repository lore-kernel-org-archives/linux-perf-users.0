Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB7717EE
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Oct 2023 02:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="38hu8QC/"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EA4CF
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Oct 2023 19:13:57 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a1d352a86dso42169707b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Oct 2023 19:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696644836; x=1697249636; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1sGfqKagqGXkVUrcgYGR2LHjgzBLLZ9lBFke+x7gv14=;
        b=38hu8QC/gJVuyTiA8l1iPgE6WRMZ2f62s8Z+0wMuxjbYdEvIX5+AbTQeiDZk1GUJv/
         YPfdwG2XovLgAtzFAgmP7VwPTTvvLgLK6kzpfZOc3kcC5VNlUAlhZczEYgzHQEkmNYPz
         EOtJLIVGrKo56XhQa4EyPQBU3FQGqHJvPRkQJ5li7OjOrAQT9eY7ZkLNKp+pnRfEj44H
         wsLebhf9YXVQ4RTnX9UdHUadeNiCC1EdxPmPByFV8d4tyMc50DyepORh22+QHPFVGzT0
         182S4OhL9Tn7wbzfw6sONm9xkwRLKNAQaF5scHrNuuSSSwXsprtFFEza+s+Rwo+dXevB
         4uzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696644836; x=1697249636;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1sGfqKagqGXkVUrcgYGR2LHjgzBLLZ9lBFke+x7gv14=;
        b=DEZbG4FinpU1volNDfptBJFWIRwzLG+IpT7c/9gqbdz2USMY8ITze7e5eJnyme3vcT
         YnSIxsYh96X99O9NTgD6j82YvVKXIbBFBOjuEBBtc68txBEN/A6vFKJ4jiBGc9GraSlX
         zkf4Wa77S2cRH7kKEK6fUMrbSc5kj1GBmbXS92I/2p0kle9ATOBooPbtaZsoLc+Bs6v2
         GN9fhMHG4UxyHg2bLQQniuAtyZeMt6Hr8LyC6U/eKQSiEX2cvx9uQbk0z47agib1pUvt
         8sj2UNvYbVEWmSVKpWO9MhZgHZ3zcv83NvjTXU/WJEGzYUo3rLibnSHJhiucc0waH9Mo
         nfhw==
X-Gm-Message-State: AOJu0YwSPSh4jLYc/PjChVTe5n5JJYqrcUTG/WsWTFMqpPNq6QRLUua0
	qvbKuSYn/qkuSHML5oVR3JL8iNuhSUWr
X-Google-Smtp-Source: AGHT+IGPyz728tGRH8ExhK1+QmM65x0nmN9xIVpRL18JfmMySQD/XlSN7mZpyD2UibDvb5iXO/7jdemBmJnt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7031:b36b:6c77:bfd0])
 (user=irogers job=sendgmr) by 2002:a81:aa4d:0:b0:5a1:d4a5:7dff with SMTP id
 z13-20020a81aa4d000000b005a1d4a57dffmr188765ywk.6.1696644836200; Fri, 06 Oct
 2023 19:13:56 -0700 (PDT)
Date: Fri,  6 Oct 2023 19:13:23 -0700
In-Reply-To: <20231007021326.4156714-1-irogers@google.com>
Message-Id: <20231007021326.4156714-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231007021326.4156714-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v1 4/7] perf pmu: Const-ify file APIs
From: Ian Rogers <irogers@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

File APIs don't alter the struct pmu so allow const ones to be passed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c    | 12 ++++++------
 tools/perf/util/pmu.h    | 11 ++++++-----
 tools/perf/util/python.c |  2 +-
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6e95b3d2c2e3..e11901c923d7 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -575,7 +575,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 	return 0;
 }
 
-static inline bool pmu_alias_info_file(char *name)
+static inline bool pmu_alias_info_file(const char *name)
 {
 	size_t len;
 
@@ -1771,7 +1771,7 @@ bool perf_pmu__is_software(const struct perf_pmu *pmu)
 	return !strcmp(pmu->name, "kprobe") || !strcmp(pmu->name, "uprobe");
 }
 
-FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name)
+FILE *perf_pmu__open_file(const struct perf_pmu *pmu, const char *name)
 {
 	char path[PATH_MAX];
 
@@ -1782,7 +1782,7 @@ FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name)
 	return fopen(path, "r");
 }
 
-FILE *perf_pmu__open_file_at(struct perf_pmu *pmu, int dirfd, const char *name)
+FILE *perf_pmu__open_file_at(const struct perf_pmu *pmu, int dirfd, const char *name)
 {
 	int fd;
 
@@ -1793,7 +1793,7 @@ FILE *perf_pmu__open_file_at(struct perf_pmu *pmu, int dirfd, const char *name)
 	return fdopen(fd, "r");
 }
 
-int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
+int perf_pmu__scan_file(const struct perf_pmu *pmu, const char *name, const char *fmt,
 			...)
 {
 	va_list args;
@@ -1810,7 +1810,7 @@ int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
 	return ret;
 }
 
-int perf_pmu__scan_file_at(struct perf_pmu *pmu, int dirfd, const char *name,
+int perf_pmu__scan_file_at(const struct perf_pmu *pmu, int dirfd, const char *name,
 			   const char *fmt, ...)
 {
 	va_list args;
@@ -1827,7 +1827,7 @@ int perf_pmu__scan_file_at(struct perf_pmu *pmu, int dirfd, const char *name,
 	return ret;
 }
 
-bool perf_pmu__file_exists(struct perf_pmu *pmu, const char *name)
+bool perf_pmu__file_exists(const struct perf_pmu *pmu, const char *name)
 {
 	char path[PATH_MAX];
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 588c64e38d6b..24af7297b522 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -222,14 +222,15 @@ bool pmu__name_match(const struct perf_pmu *pmu, const char *pmu_name);
  */
 bool perf_pmu__is_software(const struct perf_pmu *pmu);
 
-FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name);
-FILE *perf_pmu__open_file_at(struct perf_pmu *pmu, int dirfd, const char *name);
+FILE *perf_pmu__open_file(const struct perf_pmu *pmu, const char *name);
+FILE *perf_pmu__open_file_at(const struct perf_pmu *pmu, int dirfd, const char *name);
 
-int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt, ...) __scanf(3, 4);
-int perf_pmu__scan_file_at(struct perf_pmu *pmu, int dirfd, const char *name,
+int perf_pmu__scan_file(const struct perf_pmu *pmu, const char *name, const char *fmt, ...)
+	__scanf(3, 4);
+int perf_pmu__scan_file_at(const struct perf_pmu *pmu, int dirfd, const char *name,
 			   const char *fmt, ...) __scanf(4, 5);
 
-bool perf_pmu__file_exists(struct perf_pmu *pmu, const char *name);
+bool perf_pmu__file_exists(const struct perf_pmu *pmu, const char *name);
 
 int perf_pmu__test(void);
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index c29f5f0bb552..8761f51b5c7c 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -98,7 +98,7 @@ struct perf_pmu *evsel__find_pmu(const struct evsel *evsel __maybe_unused)
 	return NULL;
 }
 
-int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt, ...)
+int perf_pmu__scan_file(const struct perf_pmu *pmu, const char *name, const char *fmt, ...)
 {
 	return EOF;
 }
-- 
2.42.0.609.gbb76f46606-goog

