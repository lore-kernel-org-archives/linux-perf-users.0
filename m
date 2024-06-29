Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF3512FB34
	for <linux-perf-users@vger.kernel.org>; Sat, 29 Jun 2024 04:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636902; cv=none; b=WOJlMm3NFEQdE1RNJh5EtuB43L6Ssi66NFI5Uo7mVuty9at/l7XCK+hhKsXNKv9MQUFYxuGwTn0Y1sLxqWRs4ElTMWKVvUDAy0rWw1Sh/6BttVIyof1mf4TiEeWVXCEUh0JhdzKl0ejZhzp2dtuKntlETE5+UNg5U4uhMJilbAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636902; c=relaxed/simple;
	bh=Q8fXrFHhOeJZyCMZE0c09JJrKg9nIIrKFbU/Ag12mZc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=UwjY2JKbW1iM2G5MNd59qjAj5DNtdAX5hZ+Kl8w7/AQz3vUyfSpx8EG8ifvYxvHw+PAaNOL1kNvT0GsXaZZKWiAUHxX012yzUhGyvfxarAMMcQLYcqnIVK2lMq7Xk+trbRjM74o4+1R+zGkeO+E3V+CgQ1i7OgY+92HQFhEJBXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SJOWTvfx; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SJOWTvfx"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62f43c95de4so21871537b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 21:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636899; x=1720241699; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n6yEyi/glyHe8pWjJ+W5oLG0v6fQ7RZJQWnowp0gj9s=;
        b=SJOWTvfxY+UPNEwjhoynDXeZOgFcRBUmz2xaTxum3ax0lNr9Fj/ZQ7tWNBsEtSdIiP
         7q1qA7yhsDkbGksvcWD3XWFshhEAXUV7NpsuGAKebBjJ60SLdokVrmixju5Ls6IBFgl3
         qIGTM7Jdw4jnbPOyVKvrWzIIEU2R85azQRl8+ggDnbrf2CsPN94jjJBF6WLMPNUZ5Xrn
         CHhpYvgCtjPO3QoR9bjfy24mscs8PVHnWQme7SwrxCh57VgkwuQGd7Lah5ERGsQn3ogm
         XrZHomCykLB/uitbzVKAXcXOQxIszEpOFCWLhI4Wi9wcLVycwMZSKNMYCu1mqpuSLaUr
         xTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636899; x=1720241699;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6yEyi/glyHe8pWjJ+W5oLG0v6fQ7RZJQWnowp0gj9s=;
        b=HEESqMWrUqH3+ihi+6QvfFBtMXK1Eh3YKxeCfRtvIYseg0MFiLnhiaA1rkH4MdLieb
         vzPAyEeM6/ZWhsy+y2xKZ5UTUJr3nTlsfYjBAVOjzaUz7MHqKoRwQ5hPbyMF5WqECRJA
         nua9xkLa6H+Q1Et+mzLyKBmJX5f2Eme5EfIgb0TcoKwilUg8uTFOgK4niV8cjdyhogfS
         HXiaalnAJ6d+QpVCh0HzxRAr1ldec3zVgocuam4txXBz4BB48hfakkMw8quXYf/S08Q6
         KWmbdWEieaoLgNOK1evefNyIAUT7YOw1tmWyVec7+9lVbMBLSJWK2R7/ifdEf7Ukjsz+
         RaAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvFsfY4xZ49dH/fR7pUCr3Qju+TAMQ/JOfrbnqMRAVPX4ZnbZal09Li0wxQbchhuxUWCKqEjmXGd+j7l5P2+mipdfrVMq0oh1q9BRVKZxfqQ==
X-Gm-Message-State: AOJu0YzvbphM5Fju9rtHy8X56LyaPnDahQmtzX9M4bSxUwXjejDwYazW
	PQF/ShG6QftbyvZrXvuc1k6m0XQZL56m58XgsNfyJzPk68Cv9OpXWUoz7AcxDb08ym4p3cR7tSu
	QTgxkXQ==
X-Google-Smtp-Source: AGHT+IGtfrZeP5PYTGGfKv+9uFwUUxybvKRI3Ehr0XzH84CTB3D94s32GM5l3MralwINvpyEQI0nBApiDALo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a05:6902:1142:b0:e03:3cfa:1aa7 with SMTP
 id 3f1490d57ef6-e036eabf996mr430276.1.1719636899526; Fri, 28 Jun 2024
 21:54:59 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:45 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-24-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 23/28] perf data convert json: Use perf_tool__init
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
2.45.2.803.g4e1b14247a-goog

