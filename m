Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991CA16DEC9
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720846; cv=none; b=kMMbQX1djsEJBCnjKudJxh/w9oPTu9Tmwzm52X+ksYKwe13JTeUjcrw4Ij5RrV0aiJTypUrDc5My6Hmk1xGYTcFpxUWn4LVmNgSBG5mkZfYg82nzR4ME96M4HV1KZIWDANwXew4HuBU2cvf0lSIOztrLuNSKFV/TYxMhOB6T+o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720846; c=relaxed/simple;
	bh=gdWytOna78avdV8ta1mlF796MEMlXufN3RbPM1j+MUo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=avNSqge3bsUKYQ1zNsSR4zu5K0bXU+FGBuJ0BUHqVgAayz4KfijlOpRD++2AIJU6sPOalyLaY6PEf8CoZzlXiGKllRiNt0SVmtko3BqtTxT8/fCUFvVSm6sCnObAeaLCCvGRqQmYRT+MbG4EPZaDRXkWEHyc6griLYqx5qrmw74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XcXE+d54; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XcXE+d54"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03c68c7163so2024194276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 11:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720843; x=1721325643; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BgJSCF9yLnG02WKUg8SfX7odmyVBKa2lGRMN+iopItY=;
        b=XcXE+d54E/nI0W6uHdDcD7cyNaaCflJCceyJ/vJLLYDG9IDo/S3QYH5sMk8aUI6nHJ
         AX4MiYmGLhvBsuUNHiBjEVPRnd7NoMHqdtYbMQjO3/yrow7VEeNCkJW70xDx3Ux5DA4w
         Pw3RstYTx6rFs5p/7wSfp6TJiuT9JlCXYTFaUB8kqWMs6m8HitI3650rOreEdbNIHNKB
         BxK6DHj+e4gBM+v0OEDiLu/cNB+9Pk5QQ3dfMooE7YXfjoREzVi+WHDf02pi8sMcAevu
         xWuiPExgkVZ7LV15w2ANhH26e7UgmXK/gPiM4bXhl1DKpEgp0X1/B0mF/854pBNmxnM6
         cLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720843; x=1721325643;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BgJSCF9yLnG02WKUg8SfX7odmyVBKa2lGRMN+iopItY=;
        b=pRSjSYZtlJq1Mn4y6C4+HH4E0BnK99FYbB5uECvYz7KS2RsrVqx32huZrZkeJw/b3t
         D3EYLU471uCNMKkWjnurmqUCjoyvEH81EwHEq4XzMGzyZLCxa0AIgZDJty4ydeITGZOR
         ny2HJh3xLpQk0aGb50j+Dw7MxCtnFsxzQ8rVgHhWaq7LvtOtUPXv1S2ou5aeVnMV5dUE
         /fTWPQ6qPPkNb0JDM6UYKRRXcQbHXu0Ift2YxvpQbQOrn7H0EXXSEgImmuwlwjXL56Ps
         oMTfwVsYPefwLySg/4GCK5NIoSl+2KNWlhIHjaCtYKY1iPjiuaOSdpL9/+QtOZgyrK74
         p8hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl977o9SHl7O7BKHtopmYzKiIuLKzXIMWQbe4puCDrDhHxS8SStn1u+95vaJtvyQKA9NZLPIbGLZWbNF6PVMAoF9QMcp4qif+hQUlzU2TRMg==
X-Gm-Message-State: AOJu0YwjuExxLFAw1ei8IPio/HLWoBiy6TKfCwpJpMTTGRu8LjmDWUV0
	1rUgDclXVj3IsLFVse79Zesh9lLvNI1x2pdfCayr8IxdYXuC53r+iHYFpN3bsNDj0GIhPU39KSo
	JBU1NRQ==
X-Google-Smtp-Source: AGHT+IGUZPma1/UNbVlFLgQNB3aw1ju3QFq7+jgs3bRCoCKdY1pYTS0J6J1QQ1ukZSK8z62+IBuYguGU+ptP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:6902:2386:b0:e03:9d57:57ee with SMTP
 id 3f1490d57ef6-e041b0545c2mr460225276.4.1720720843539; Thu, 11 Jul 2024
 11:00:43 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:59:54 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 14/28] perf script: Use perf_tool__init
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
2.45.2.993.g49e7a77208-goog

