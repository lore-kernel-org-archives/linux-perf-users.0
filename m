Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378196A332
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 01:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264473; cv=none; b=GgbnQNGtjsvKF6KDLKCyDAXtHeGp85lTOIXau/PII6bv/nQR/xDmm8yMFvA3YQHL5TswVr/kI7ApNs5FnbxngP2aBZJbNDxhTb9fhWGaAwfifam12gEHZ8gFluhrWyFmB25lDOlHMCXn8hZd/nNH5dsnhgGVimGG6ucZl68ii0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264473; c=relaxed/simple;
	bh=/F7/4EIyw7D7CiUXDYCkLJycjGYVjLrkbxfIXcD/YaA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=gcqqL0knoMFP4KhO5gaHmvJP0bifXiK46WHfRJY/Ge6IYFbKD4GvgViZ4pEK5X+rWFdcnr+k8a3Id9oaXJo1V6U7c4pM20Jppp54Rw/2IHJyj7et5BW0gJB5GjO6NS+6U6JwIiDaPmw/TyUsTQtdHcIquYbrt9SsjRhpzrwYD6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u/mu8pGn; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u/mu8pGn"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03623b24ddso716608276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 18:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264467; x=1721869267; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pNFK3i3CL2hY169owdLoin8oWSW6A2yJIcLVmlGvbqE=;
        b=u/mu8pGnfVZd53SE9RvWYsGXBO7ib8pyHQD4tz4OFISD9nDYuvTh86SKqXxfKUMcxa
         tJz3vJLymxSgfGb1JzXwNVifckee4K/qSXld1EvndVTv+T6TvZ62jTdwe5PVAeRXEsUr
         NttKVpcKx4wE5+D/YU6syfplmKWhnJws00LrkxIqQJO12nzL86dnDmh7rXMTng70HEy4
         SToj5iOKl/KxxztabbObJPc/AE6ha9hLVzIhg8uMxcOzL7qXbZIlkXTiKkuh+j73koXu
         9X/qvior4wPtCJw9JZpbfGmGmjyq9Dng6t3jDWTPLkU1s/mD38b8AP2KEJPPaQe/yzHH
         ZLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264467; x=1721869267;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pNFK3i3CL2hY169owdLoin8oWSW6A2yJIcLVmlGvbqE=;
        b=p38HgtvtP4pSyHvw+C+Lxw9HUA8Wlt/ZRqfH5nRMeL4D7v1VENIppu4B0qFf8FQLwa
         Mat+oYEjbUpcpmXTRRcTydp97UqZEcFe/dpa11bC4MRdANRdP1z1zbNCoyQbn44U2WWg
         kvaS2sP5R0crPGa43xcEAodBr8ArRhVIZ5MVfbva4nQVsG19Yi4HZ4+tgTZLa26u757d
         YvTbVWvFN8GtoanJeBfu0Jelbg2q0LejlF/JydmC3XMG6f2RJNot6zcQi13fV/SIoKJ8
         H/95pQ84MM1VIng1Y1nHpbwfrDBbaEtDvsO4TLhWFhJeuRR3nyHCTo+6nc4C2VGXzR67
         b1bQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3h75iAzsWYut3gNe1EbN2xRxot1YYcaUCMVanl9G9Yl8JijBDpPV3DZdgNKzcqX61mgS1asDNhvnXMMRsI6xRKdEd49DAgoAjyVGDC+xO2A==
X-Gm-Message-State: AOJu0YwyZmj/pY++kBvN2HyhTJ8E7Ri8QekV0CUYUek26v3k+9aawfZv
	1qnCD9x5MS69tJbgJF2K7KhaeNoxSQhzu1pnXP76bW//BmL8b8fl3b5EXYvQWd7tKbFKYLhe0DQ
	Eq2kcNA==
X-Google-Smtp-Source: AGHT+IFHPEUR6SHxDxIGONs3PPAyxDcCJ98okKUpCTVwExnLyEiQ71Kvctfkm9eZdP+bwodMy6NLwOHXvMHK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:6902:1003:b0:e05:a345:259a with SMTP
 id 3f1490d57ef6-e05febdcb0bmr22837276.9.1721264467108; Wed, 17 Jul 2024
 18:01:07 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:09 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 13/27] perf script: Use perf_tool__init
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
 tools/perf/builtin-script.c | 65 +++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 35 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 394bce9f5338..b4fc2971335b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3899,38 +3899,7 @@ int cmd_script(int argc, const char **argv)
 	const char *dlfilter_file = NULL;
 	const char **__argv;
 	int i, j, err = 0;
-	struct perf_script script = {
-		.tool = {
-			.sample		 = process_sample_event,
-			.mmap		 = perf_event__process_mmap,
-			.mmap2		 = perf_event__process_mmap2,
-			.comm		 = perf_event__process_comm,
-			.namespaces	 = perf_event__process_namespaces,
-			.cgroup		 = perf_event__process_cgroup,
-			.exit		 = perf_event__process_exit,
-			.fork		 = perf_event__process_fork,
-			.attr		 = process_attr,
-			.event_update   = perf_event__process_event_update,
-#ifdef HAVE_LIBTRACEEVENT
-			.tracing_data	 = perf_event__process_tracing_data,
-#endif
-			.feature	 = process_feature_event,
-			.build_id	 = perf_event__process_build_id,
-			.id_index	 = perf_event__process_id_index,
-			.auxtrace_info	 = perf_script__process_auxtrace_info,
-			.auxtrace	 = perf_event__process_auxtrace,
-			.auxtrace_error	 = perf_event__process_auxtrace_error,
-			.stat		 = perf_event__process_stat_event,
-			.stat_round	 = process_stat_round_event,
-			.stat_config	 = process_stat_config_event,
-			.thread_map	 = process_thread_map_event,
-			.cpu_map	 = process_cpu_map_event,
-			.throttle	 = process_throttle_event,
-			.unthrottle	 = process_throttle_event,
-			.ordered_events	 = true,
-			.ordering_requires_timestamps = true,
-		},
-	};
+	struct perf_script script = {};
 	struct perf_data data = {
 		.mode = PERF_DATA_MODE_READ,
 	};
@@ -4102,10 +4071,8 @@ int cmd_script(int argc, const char **argv)
 	data.path  = input_name;
 	data.force = symbol_conf.force;
 
-	if (unsorted_dump) {
+	if (unsorted_dump)
 		dump_trace = true;
-		script.tool.ordered_events = false;
-	}
 
 	if (symbol__validate_sym_arguments())
 		return -1;
@@ -4296,6 +4263,34 @@ int cmd_script(int argc, const char **argv)
 		use_browser = 0;
 	}
 
+	perf_tool__init(&script.tool, !unsorted_dump);
+	script.tool.sample		 = process_sample_event;
+	script.tool.mmap		 = perf_event__process_mmap;
+	script.tool.mmap2		 = perf_event__process_mmap2;
+	script.tool.comm		 = perf_event__process_comm;
+	script.tool.namespaces		 = perf_event__process_namespaces;
+	script.tool.cgroup		 = perf_event__process_cgroup;
+	script.tool.exit		 = perf_event__process_exit;
+	script.tool.fork		 = perf_event__process_fork;
+	script.tool.attr		 = process_attr;
+	script.tool.event_update	 = perf_event__process_event_update;
+#ifdef HAVE_LIBTRACEEVENT
+	script.tool.tracing_data	 = perf_event__process_tracing_data;
+#endif
+	script.tool.feature		 = process_feature_event;
+	script.tool.build_id		 = perf_event__process_build_id;
+	script.tool.id_index		 = perf_event__process_id_index;
+	script.tool.auxtrace_info	 = perf_script__process_auxtrace_info;
+	script.tool.auxtrace		 = perf_event__process_auxtrace;
+	script.tool.auxtrace_error	 = perf_event__process_auxtrace_error;
+	script.tool.stat		 = perf_event__process_stat_event;
+	script.tool.stat_round		 = process_stat_round_event;
+	script.tool.stat_config		 = process_stat_config_event;
+	script.tool.thread_map		 = process_thread_map_event;
+	script.tool.cpu_map		 = process_cpu_map_event;
+	script.tool.throttle		 = process_throttle_event;
+	script.tool.unthrottle		 = process_throttle_event;
+	script.tool.ordering_requires_timestamps = true;
 	session = perf_session__new(&data, &script.tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.45.2.1089.g2a221341d9-goog

