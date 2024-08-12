Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1A519D895
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495697; cv=none; b=tKrP57dRFtDgbSTqGiwFQn4/wa+pim9RkyhuoIU7lgoJkZJTd1qK5nJFYLaOJaM12SwjJ5CsmzI1cwpRkywpsrCEpCnTsavj2Tb1vLWgKx7K7xoCxvXrOUmMgzw0Om2AyaCMMIyBKN7sfgN5f9T9XGi7Cnfy/xJwUqA+1e2YD00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495697; c=relaxed/simple;
	bh=B2/PUnnFEkgGzs20puhL/HN4AsJUmb7HRfSa/UkrbmU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=myZk9AiTLpiNpQsx7wuhAeWoGtDJL7sYQlqJFRTU0NCSjU8EhX2WLYXa44ZM+kcisgqNNmRgb3vGkrCZmyGTuIiDJjuQDpiNrVJQHklgHSyVCdESLM7z4YbwGkYhpaB6mX3ry3BOuOhhIDTJU9wr/CEWP7vlGpOb4mhMaI08euI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GJ1e0fQP; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GJ1e0fQP"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b8fa94718so8607623276.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 13:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495695; x=1724100495; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GbSuls1koziHCu+Zgk0ioXEnPdjQxeNgIBorrGo8zG0=;
        b=GJ1e0fQPhefxJPmgw6ZPBo23+nlOI6T/3k3JGwnEZviIwJpU5jYOi14r6O1honn3OD
         6pxrwGooD87RLRYesJac/5eZDk+FSuGGhq/A9Jx3+G/0t70jAP1vRaEjKqPXdGAC3zFX
         fOviq/fZ0xaGo+bbHhL+Z2qGRZFMF9aAvzssixwZKyLm005Hj+0RgZP4g5etZ4/UCGBo
         3TBNSv38xYRC8+BHanU3EN9DyW3drX+fLtBcpum8pW7F7JwwDeSNzOV4AiI8e+hIggPM
         AzifTuWIXc/wm2Gmbjb9URpqvlOUKoqbIlNi+01hIAP2oODPct69JcaE/RUJ3UV8gQDL
         tHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495695; x=1724100495;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GbSuls1koziHCu+Zgk0ioXEnPdjQxeNgIBorrGo8zG0=;
        b=nBldU00lRPC6N95mGf4vanJRD3IeidrOCDiWmIJe4WbrDTw61GB9Bj/O9watRfqHu+
         YURdXi3nmQYD4tckKT8UZBxC+EvMdKy3k7DDlXJhy8ThI0faH3Yjxi1Iiq+KsltNJxgJ
         EXanWUHABSZKRAn3Y4Rz55NXCFjxIzJbzoWz/4zV0nIzRSvuI5vZtrcjp6PfcF/z1HRl
         VJGu9T4onFze00h2vvjo8KOUk/MgeFpLeq/GgFZr+7M8x6YKAggKm6cB8FA4iJRW4Ewp
         nRy7mb2HVubXDuznFesdltUlI5EW68sGuc6Mp6LNJtKuzzz0zDZDDkDj0UV0B6tfJSio
         ac+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWY0UoLk0ubxugQhogjEOCOqMdy6JXBrzQAC66BNxPosx93Virn4g687wN4JPll6bq2jlAgVTax7sc94m9+WeFX@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrh5Otp9BJ83wmS8VlFBvdVlVq3cnFMiBTOXdg0JZFQVDUfREW
	nhabpWNyVMfE0aCkCtQU6wjZ/CNp0xFKtvQ85ykrd6lFSDtdtVscq0Q0QejPK8VFbNak/jbjCX+
	4v7UbhA==
X-Google-Smtp-Source: AGHT+IGKJ+9oWMNqxHbfR8xASqbD92WuYLWcfVYrMvX7Qri5bDa2vpoBKzYqnCKUn0C5AVvaDA3aVfY+pTnG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a25:eb09:0:b0:e0e:3f14:c29d with SMTP id
 3f1490d57ef6-e113ce83143mr78677276.4.1723495695218; Mon, 12 Aug 2024 13:48:15
 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:47:14 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-23-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 22/27] perf data convert json: Use perf_tool__init
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
---
 tools/perf/util/data-convert-json.c | 43 ++++++++++++++---------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index 905ea9823f9d..20bfb0884e9e 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -316,39 +316,36 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
 	struct perf_session *session;
 	int fd;
 	int ret = -1;
-
 	struct convert_json c = {
-		.tool = {
-			.sample         = process_sample_event,
-			.mmap           = perf_event__process_mmap,
-			.mmap2          = perf_event__process_mmap2,
-			.comm           = perf_event__process_comm,
-			.namespaces     = perf_event__process_namespaces,
-			.cgroup         = perf_event__process_cgroup,
-			.exit           = perf_event__process_exit,
-			.fork           = perf_event__process_fork,
-			.lost           = perf_event__process_lost,
-#ifdef HAVE_LIBTRACEEVENT
-			.tracing_data   = perf_event__process_tracing_data,
-#endif
-			.build_id       = perf_event__process_build_id,
-			.id_index       = perf_event__process_id_index,
-			.auxtrace_info  = perf_event__process_auxtrace_info,
-			.auxtrace       = perf_event__process_auxtrace,
-			.event_update   = perf_event__process_event_update,
-			.ordered_events = true,
-			.ordering_requires_timestamps = true,
-		},
 		.first = true,
 		.events_count = 0,
 	};
-
 	struct perf_data data = {
 		.mode = PERF_DATA_MODE_READ,
 		.path = input_name,
 		.force = opts->force,
 	};
 
+	perf_tool__init(&c.tool, /*ordered_events=*/true);
+	c.tool.sample         = process_sample_event;
+	c.tool.mmap           = perf_event__process_mmap;
+	c.tool.mmap2          = perf_event__process_mmap2;
+	c.tool.comm           = perf_event__process_comm;
+	c.tool.namespaces     = perf_event__process_namespaces;
+	c.tool.cgroup         = perf_event__process_cgroup;
+	c.tool.exit           = perf_event__process_exit;
+	c.tool.fork           = perf_event__process_fork;
+	c.tool.lost           = perf_event__process_lost;
+#ifdef HAVE_LIBTRACEEVENT
+	c.tool.tracing_data   = perf_event__process_tracing_data;
+#endif
+	c.tool.build_id       = perf_event__process_build_id;
+	c.tool.id_index       = perf_event__process_id_index;
+	c.tool.auxtrace_info  = perf_event__process_auxtrace_info;
+	c.tool.auxtrace       = perf_event__process_auxtrace;
+	c.tool.event_update   = perf_event__process_event_update;
+	c.tool.ordering_requires_timestamps = true;
+
 	if (opts->all) {
 		pr_err("--all is currently unsupported for JSON output.\n");
 		goto err;
-- 
2.46.0.76.ge559c4bf1a-goog

