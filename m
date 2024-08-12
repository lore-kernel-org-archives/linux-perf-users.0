Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16601199EAB
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495677; cv=none; b=V8h4+BhVHbejc5ImS1VN9CMojth+NcHbmHvrFBqgbHt8xpVVQwWlJqG+jWbuwGuT8AS+/i+uCe2RFKj453UXNomptUhDZKlk7QFkV9qV05IWdoqQAQZO2wiMooYxAYTiUE9ZztZ0z0qr0sniqHH5tHQ5Usosox+A+sHJ9w4WilE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495677; c=relaxed/simple;
	bh=nvVIN0ZLLh6yh7g6JqUgu4I+Qq32U1cP9dpEv11TWp4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fgy0JShOvuFBr/CPo5IrPue1qW/PMlDqZmVkUf+pco0b2uU4DbRolvBokn7B6H5xdvPE+fOdaAAEN14fQBfdwQqliaxQpNu0D3GbURAhx/b3iV6xSugGxLoZhiZxaoRp57D4zk19nX2u7tyo5ytMPOawOaoRgMx/sxglPpQdKmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uqEE0b1E; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uqEE0b1E"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-672bea19dd3so107603367b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 13:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495675; x=1724100475; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sjc2eLEDEoqOWEk7kdawEPHb3ceHGyCKWkqgoVjnHA8=;
        b=uqEE0b1EsbDaAcxuLEi0zn4DG2leQsITuqryra62v/hBdwV7c1H2+vFA9u7+rG7J7n
         R6i5PfHdM/z0BBPL+uS1ZgIrQUS1uqqLyf0SjEtMjGGm6/0YCQse66f60ee+AZKzxGze
         Tk6Qau2DVhxwjw0JFVpCp5hkhFBogZUAvAGgsmFW4jgxfxZf36Teob/zBJcnUeFt7U82
         SLTJ+8UKYoeZTwuoZipRZtkaHxl+3yTTOhPNu++mx0gOdm6rs80CjgVzal9YqUlSnHGt
         JvHVFgl6s5PPYhPaqa4H3kG0iStXn2hq2RXqkO+taYegTJlO7rrUUT43pLsGLydoYtZ6
         THCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495675; x=1724100475;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sjc2eLEDEoqOWEk7kdawEPHb3ceHGyCKWkqgoVjnHA8=;
        b=YmG7E+EVsb92jOayBKrAfEwrymAzcb1bVtI7WKZuX6Vuv3LkDlIVbxAIroMUrggDQo
         aAruJm5Jt6DhUHnZwvIaCAbY25xZjznLSq9cbmZSwOA+w73Su0QoVqMKyFpj5rT6p6KX
         L7q6uVTKeAZf3sXj9aSFdpdTqUxpzHkTJ61NcCZaNzny5dUNJoNHmpFj+akmjDgWixmi
         nVY40gVsIupzTkDwcvFDf+GLFv2vHx0SGEeAnLD9AetOrxwa4Y+QYSoR8cCjGbMl8K1H
         8QI76YKSUGjXppVQtIn3nAxOV1WyFdMWuTQUKfz89gS4SpA9udBokLij0aydqkjWgNrG
         CXyA==
X-Forwarded-Encrypted: i=1; AJvYcCUTUnors1fBxUW/2XRrWVBHvf6wFjkRlM6ek0LaCSwhsvPSL2sj1OU6m14HxHstzmleP7bx2KvOM6d1S6+E5l2R@vger.kernel.org
X-Gm-Message-State: AOJu0YxA/UR9RzRFMM6ZSZSKCfJBjh7GO2c4lCQUhRKdXOMQyib/Eee7
	YU1rtt+IZuZiB4Hq4+GRIR96WkdU/s/Prbn4o8d3QOhK7c75L/rMT2fnG4M8+pG2hqZAzQeYCCp
	+RgFoNQ==
X-Google-Smtp-Source: AGHT+IFOd0OYmeV8Y9nqWsHm87cprbndwMQUuF1PkqYQQdBPP3ERK15XiwbbgvEjejpEJkcmP4DPnNKtl5rP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a81:ab4d:0:b0:69b:c01:82a5 with SMTP id
 00721157ae682-6a975e90bcfmr579667b3.7.1723495675061; Mon, 12 Aug 2024
 13:47:55 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:47:05 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 13/27] perf script: Use perf_tool__init
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
2.46.0.76.ge559c4bf1a-goog

