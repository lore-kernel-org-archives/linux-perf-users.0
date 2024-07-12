Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB1817B507
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807961; cv=none; b=Mkw+Zhz19dbAq0ZRyoGwyCAbwU6DUdH/pEAggchJa6jSMkpJLZZr3arAQnQeDXPstxDfqxE6t/stsQbojC5oNHh4Tz/UTELAVoS++GZHK7Iqxd7d9x65XpzYwVEZhLi9QTN2Pjp2jWQR6G5m6rPEnVQtpdznqWydvq25rcyqGx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807961; c=relaxed/simple;
	bh=gdWytOna78avdV8ta1mlF796MEMlXufN3RbPM1j+MUo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZOjnWt3L8UsXWvACQRMmVFZwYxQNf8rSPFrkgZkNnEArXom1xGgtgtpxMhgJIu02B6KkUvHn8IBJp2XpEJDYSZ1RITfJ+4QxbQlj4yoYDosWxYn5O5G/G8rkxJvQtvFT45vBlREHOtE0+3gLskfCZzBFLC6hgSpvRbpmXeiOCQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aeYFLDj0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aeYFLDj0"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64b5588bcafso39766197b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 11:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807959; x=1721412759; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BgJSCF9yLnG02WKUg8SfX7odmyVBKa2lGRMN+iopItY=;
        b=aeYFLDj0olUKf9HOKySFHWrUNisKcR1hz2njupqtn94EDMF/OQv4O9zJ2XCoe/b96W
         4gzf2iLJ5mIFcRCOu5ieMHslWpOD4lQe/srwUwMfIoQBt+WkmmiuheaaCA86DOFl5wOZ
         vN7qsbHkYnYzSQnFV3x4bhJOpSNphXia1wvY7oAokuP6A2b+hLI/ZJ25MsLDOL6/EZHr
         1iILpzz1FYnyev5h6cWFFxMJXZmqYkFB0bMvAxUsSdwFsU+3YehGsnplIHS92O/DEbdf
         8Po+29euvgRHgQuRyBdfhju+YndiTFmrEvPrNgM8FePQPU1Z5nlLowTfk3cw+NeHi2Bo
         5pwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807959; x=1721412759;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BgJSCF9yLnG02WKUg8SfX7odmyVBKa2lGRMN+iopItY=;
        b=X1MWdDw/7NXIho06yUAEERNxTvMswCDU7urf5/2j6zpqei2uztPkNqNK0XfCJWRqBG
         3QxJI7GnOl2LFK2uCMCzpcxwJphT+vnjc0bnp7CsPw5NbK6iYPE3HGZgRt5d2XRPvCBX
         oWAJDuvOpVq5YsBOjEsCPqTUfp1WGTqIWEpRbW/+RxI9N3+fhmQlEGE0QI8hN/1S9YTF
         UfbIPxtO1HTXXrlGRkjL41Cyy3eg+56F0XyxvGDlsGPB6YFCMfGH1l7q1JJp7/fBTQBS
         2df06oSHfQeMWExsODRa0tMDUSsQRhYP59dMXaVF606JTZ6MfYJsFGWHNlUnd2LgHwy/
         qp3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXM8I5uWn/tMh7nNoKWcx5J16aQYRFtUXsEDzIjkUkQLWu1QeztnI/YwBwOqIVLGOi0VEtP0Y0vdIBcXdI9w3lvUt2GFQE/YafOnxOx/7aXzw==
X-Gm-Message-State: AOJu0Yywb0kfAe4LCCF6z/zdR+iitKgi7eiENx4w6PW28sQ114wdtTS8
	D4lVobgzNSAQHyC2QcCtn7nz9+OsXG3pd3qOHgSdPoOmUMhNx7gb3yFaLcOl7LabCZXX8ohJpgy
	w9uewrQ==
X-Google-Smtp-Source: AGHT+IGSRo1j+8MrlxjlP2j0amUvFCZ7I7KDAWRqN8yitAfuMgeL0LfUscnbxCScl9n5gTfoA9hXSuXoBhys
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:6902:1002:b0:de4:654f:9ad0 with SMTP
 id 3f1490d57ef6-e041b058ccbmr26281276.6.1720807959082; Fri, 12 Jul 2024
 11:12:39 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:10:54 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 13/27] perf script: Use perf_tool__init
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

