Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03D540856
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 01:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264464; cv=none; b=nocgr35DKE01xGYyNLTaF9FxikYj3GwTUwnz6h5gqVMciS6IzXz1ZckAtx3FBbWT/vI1msDGdlryoWuAp0iDDp5nPqOaY5UnVORzY1TpEmaRoyaWzrWRf/Qe2A+veRqWTqwrTcm3r18in/RF153H2KGn8+LErvx7d8VL+o4a1xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264464; c=relaxed/simple;
	bh=5NLo6mkryom4NhvGMJNdBdDiyvx9A0lIz7/wg34r5RE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=m4As51XxYMXk7i6UgMjhE7hgR7E3y/raULGF1jifHjaq0MdBtXbpGdcVBFOmPKsbcIVu/qc6oAvj7CqsfrA/DeQZA81O7xugS3ispe1z9UrCZpc9VdXlrNgEKl8m2qd2+calrSff99xuWVT7ksdjHHIxC4keAHT+AJaKJ+eJBfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KnuQ5RtU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KnuQ5RtU"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-66619cb2d3eso7009287b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 18:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264458; x=1721869258; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+bihPZPBGJ6d8qN0fHDZAaoj4FmhnLovUYATiB5ueYI=;
        b=KnuQ5RtUL+jK4ahi/lEVK7dAoT+nuaImkVUZpffMvld/Uqkukc6eVSGRm3UizBpfDP
         Yaq/NnXYYAAFXKOhtmGQ57z4g6w+AcrJ63a1YCjZmFMj3CNwerObgbDyA1RzT6MwgMWV
         VaQcU6sZHsBYSpQkCAdvmHzk7sCbZTVo/IBFsSpHnDg2+xiBSgRKcA04D8jmxI9XG7sl
         tO+S1gzjvaAlufi+oahOmBbm5t8wjnAUZZGv1d1b2W3aCQqtRFyRmS9PuJ3COeBim25N
         ALN+HkTkC/LiFkKvdf0PkTHSiET/SpRaHjl6Q8tg61HDTZVxMpDMojnV8aAOzrsYrkAJ
         EIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264458; x=1721869258;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+bihPZPBGJ6d8qN0fHDZAaoj4FmhnLovUYATiB5ueYI=;
        b=F7ZzCkwMqioOh9uEYxwqfXjBXWPR5ljEzH2n2lq5DwHTl9NhIG/30TybHkIEpO5udD
         wTDUPe4jj1wwWqt9jeVYvRcDnXVf5MmBPlCYukiAZC3HzaToYKrzYQ78OXQ3HdNZmfGx
         IgWM156d4rRdkndu4hGS7VgY2XyoGntPGM5wna4R1UkbNbKdsaazMjit8dmlTIVXhH62
         OUUgAZGdi32U9nn/ZF21L3NoqISzOrpgsSrDAMWh4zy+pZEZU5gLKjWPtteohYJmowks
         iLdDUrcWermAlTcAvMlBHgFX34IfzsutTY3MPC+JOpNyTnesNzPU09O/ZQnWO/y8aG4d
         cs1g==
X-Forwarded-Encrypted: i=1; AJvYcCVkW//EpFtFSRcSuHwPEh5MXiC7brtCRWG1sHjAjCC10/buzT3XdkaBs/ZLod4orglYrUF3c6gaoAucnDBKCyECsDcT51ODd0QwhDx75sSfRA==
X-Gm-Message-State: AOJu0YyDwfv/YIMEtdTLnDoQE0gyhONwpT7iLhgNsYZlOmAbqldYqLMC
	7DwweAtTj9mLUw97nrMdZX2ErIeRWi5JsWYiEXv07FZX8tPbfwASwJkr8SGROz/ieXIhoEgsqeP
	zcTICYA==
X-Google-Smtp-Source: AGHT+IGDEF3uZXg4slq61N/gjbSuBnIZfH69MFL5bkSpRqZ+m4jNhYliSi0lDnLt9dM73d7tpplzPVLMX02w
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a81:ae04:0:b0:64b:a85:e2c5 with SMTP id
 00721157ae682-666019e3b2amr337027b3.3.1721264457820; Wed, 17 Jul 2024
 18:00:57 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:05 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 09/27] perf lock: Use perf_tool__init
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-lock.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 6efa9d646637..2c216427e929 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1933,22 +1933,21 @@ static bool force;
 static int __cmd_report(bool display_info)
 {
 	int err = -EINVAL;
-	struct perf_tool eops = {
-		.attr		 = perf_event__process_attr,
-		.event_update	 = process_event_update,
-		.sample		 = process_sample_event,
-		.comm		 = perf_event__process_comm,
-		.mmap		 = perf_event__process_mmap,
-		.namespaces	 = perf_event__process_namespaces,
-		.tracing_data	 = perf_event__process_tracing_data,
-		.ordered_events	 = true,
-	};
+	struct perf_tool eops;
 	struct perf_data data = {
 		.path  = input_name,
 		.mode  = PERF_DATA_MODE_READ,
 		.force = force,
 	};
 
+	perf_tool__init(&eops, /*ordered_events=*/true);
+	eops.attr		 = perf_event__process_attr;
+	eops.event_update	 = process_event_update;
+	eops.sample		 = process_sample_event;
+	eops.comm		 = perf_event__process_comm;
+	eops.mmap		 = perf_event__process_mmap;
+	eops.namespaces		 = perf_event__process_namespaces;
+	eops.tracing_data	 = perf_event__process_tracing_data;
 	session = perf_session__new(&data, &eops);
 	if (IS_ERR(session)) {
 		pr_err("Initializing perf session failed\n");
@@ -2069,15 +2068,7 @@ static int check_lock_contention_options(const struct option *options,
 static int __cmd_contention(int argc, const char **argv)
 {
 	int err = -EINVAL;
-	struct perf_tool eops = {
-		.attr		 = perf_event__process_attr,
-		.event_update	 = process_event_update,
-		.sample		 = process_sample_event,
-		.comm		 = perf_event__process_comm,
-		.mmap		 = perf_event__process_mmap,
-		.tracing_data	 = perf_event__process_tracing_data,
-		.ordered_events	 = true,
-	};
+	struct perf_tool eops;
 	struct perf_data data = {
 		.path  = input_name,
 		.mode  = PERF_DATA_MODE_READ,
@@ -2100,6 +2091,14 @@ static int __cmd_contention(int argc, const char **argv)
 
 	con.result = &lockhash_table[0];
 
+	perf_tool__init(&eops, /*ordered_events=*/true);
+	eops.attr		 = perf_event__process_attr;
+	eops.event_update	 = process_event_update;
+	eops.sample		 = process_sample_event;
+	eops.comm		 = perf_event__process_comm;
+	eops.mmap		 = perf_event__process_mmap;
+	eops.tracing_data	 = perf_event__process_tracing_data;
+
 	session = perf_session__new(use_bpf ? NULL : &data, &eops);
 	if (IS_ERR(session)) {
 		pr_err("Initializing perf session failed\n");
-- 
2.45.2.1089.g2a221341d9-goog

