Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530F736B15
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Oct 2023 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VUS2eGTK"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D9FDC
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Oct 2023 10:57:00 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7be940fe1so19439027b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Oct 2023 10:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697133419; x=1697738219; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=14FOksjqV545oUYd4P/1q30YKINPT/rJmn836J71agc=;
        b=VUS2eGTKBUNJ4Xuh3vfwN7wY38OLT7C9FgbHk/fSut55+H1dEGh64qPVffmGFEdGzS
         t0f1eg+8HVslY+34MjmrPYBAybiv+0SO8fKWPLs9NEJtfJtJrUVvGGsyik6YoEFNoM/J
         Oo8WudxEiM5WD0/h9rdk6w6/jHoja496xLVgaWJrz+QMRjwULwSMkxBP0e9T6sJanjbi
         WRv2baZRAuytvHX6JFPaNHTX/FFj/zZtr0vJKbRhYn8fhYapfxmOiFwL+u6wVeNxp6Xp
         8nCRs8QvPitERJqfeALfZN62hWngb0FttuhBR1x4UrNt30mUFVcvMTwQjrRa+L1YaGMj
         K9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133419; x=1697738219;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14FOksjqV545oUYd4P/1q30YKINPT/rJmn836J71agc=;
        b=WZfnJuokcTo+4nxEDJmbRpCEA/i0rtESuZFc+FJmmK4GYYFzpkgzsUwyQw2C9I2jbv
         7gnt2J+U/okZoSdmu+YMKUa6+GU7cuI0vdus2eEzH8112DogHyPe8kh1eF65HljkkH6H
         VUxsBHjtLc3sxLUzP5AD2EQT/2yKXdJY+iB6ghk06b9ny9ajzUBrkOa+ifjGstiAdhWg
         HnSqyDjtn6nmlFlUyzvXHNnJnuR8O9aGcZB1l5NRbkoSnfFZxnmb0mwVbLH4TO+PK7GT
         gmfTZhAHU/MX60jrlnJ3pfT6JsT6Pp5qSr3ZL9yCA7QoxRwWdRrDSZvFtPz1Xg6WmFWS
         qpzg==
X-Gm-Message-State: AOJu0Yx3ipSGPOoi3V60Sf9W0BSLmhDacD2j8nOFFOOKzAB/vaLwHrFC
	qEQAyUQ4yk6K75cStdG12qoW5y1hPGkR
X-Google-Smtp-Source: AGHT+IHgq6meuGbKkQDt+1J9vJsjMlp7VVyn5KqsFhf4Ln1NLHH1bTqBxU7SrG1olske0no0RoZ9hc2QZcjY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6a89:babc:124b:e4e6])
 (user=irogers job=sendgmr) by 2002:a0d:d70d:0:b0:59b:f493:813d with SMTP id
 z13-20020a0dd70d000000b0059bf493813dmr56973ywd.1.1697133419314; Thu, 12 Oct
 2023 10:56:59 -0700 (PDT)
Date: Thu, 12 Oct 2023 10:56:42 -0700
In-Reply-To: <20231012175645.1849503-1-irogers@google.com>
Message-Id: <20231012175645.1849503-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231012175645.1849503-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Subject: [PATCH v2 4/7] perf pmu: Const-ify file APIs
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
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

File APIs don't alter the struct pmu so allow const ones to be passed.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/pmu.c    | 12 ++++++------
 tools/perf/util/pmu.h    | 11 ++++++-----
 tools/perf/util/python.c |  2 +-
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d075da0eecc0..861e485e0a70 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -575,7 +575,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 	return 0;
 }
 
-static inline bool pmu_alias_info_file(char *name)
+static inline bool pmu_alias_info_file(const char *name)
 {
 	size_t len;
 
@@ -1770,7 +1770,7 @@ bool perf_pmu__is_software(const struct perf_pmu *pmu)
 	return !strcmp(pmu->name, "kprobe") || !strcmp(pmu->name, "uprobe");
 }
 
-FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name)
+FILE *perf_pmu__open_file(const struct perf_pmu *pmu, const char *name)
 {
 	char path[PATH_MAX];
 
@@ -1781,7 +1781,7 @@ FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name)
 	return fopen(path, "r");
 }
 
-FILE *perf_pmu__open_file_at(struct perf_pmu *pmu, int dirfd, const char *name)
+FILE *perf_pmu__open_file_at(const struct perf_pmu *pmu, int dirfd, const char *name)
 {
 	int fd;
 
@@ -1792,7 +1792,7 @@ FILE *perf_pmu__open_file_at(struct perf_pmu *pmu, int dirfd, const char *name)
 	return fdopen(fd, "r");
 }
 
-int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
+int perf_pmu__scan_file(const struct perf_pmu *pmu, const char *name, const char *fmt,
 			...)
 {
 	va_list args;
@@ -1809,7 +1809,7 @@ int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
 	return ret;
 }
 
-int perf_pmu__scan_file_at(struct perf_pmu *pmu, int dirfd, const char *name,
+int perf_pmu__scan_file_at(const struct perf_pmu *pmu, int dirfd, const char *name,
 			   const char *fmt, ...)
 {
 	va_list args;
@@ -1826,7 +1826,7 @@ int perf_pmu__scan_file_at(struct perf_pmu *pmu, int dirfd, const char *name,
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
2.42.0.655.g421f12c284-goog

