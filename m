Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858C217BB2C
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807966; cv=none; b=IdWb9diEB9uZA9yRYJp8/hP0SbSYdgD2MXQjjIMeUb2EhdbN6mTZBZQn0JbZBPVDP9m1NWgMF21Bytdb2cuuZN3RBpqtvUWyjEV4YBDqp7BOsGW3bKRYqcdVBhReVuO0BZCWINt0Oky1wGflZQoY2FOD8mNlffb6bhLMo/0SSCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807966; c=relaxed/simple;
	bh=Poyvi9HGQwQC12qF/8SGE3BV1oK/lWq58PuPKRxVztA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=G3Py+eVR98YHaqj2JWaJb4CDaqp2T7dc2XFuQDzwpB+cAf32TEHTYlVrpm3I2mvQQB8gPfhaQYkEkM+uAvjLaOzqe9zAwmDGQqYdDKSeplmZTE78vTGU2C3stgULGofVNpmLxkS7gtmcMUEHinwlqfk6zgM+Cdz+dHDUWjFlG5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rLPC5gqw; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rLPC5gqw"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64c3f08ca52so34520317b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 11:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807963; x=1721412763; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QTSkE2wJ/0ArGbZAlv+dCStory8B9jtqpGvumW8ARXs=;
        b=rLPC5gqw04o3hQALOnnq4R/LT+GFz5+dhBPtSnIL2UMILL2PpQKUdNgz42nNZKyFk5
         uIJDBbr5DIOyvrv+LP7lY6iMoxG4ld7ian7WLAMTAIi/lHB+1ZklIAebJAo/i//aCQaW
         7NE9hmu9YgWolX3jRphYGTiyXPyyRnzZWGqkq2KSwlmAjkfuOTi2h+xA3f4zlwebt3lh
         efO01B9XO0yL9msZg3Xv0/yCvpNVWKMRndXJ+aXb0DV/c/oaR6s1yRCuJbCuCly2pQAI
         XIQ8imJ7aRUqszZ+VktHqdwrjvuG2eijzZk2WwaDIBhQbb5nvibKeT8KM9VCeFnIyjOi
         b/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807963; x=1721412763;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QTSkE2wJ/0ArGbZAlv+dCStory8B9jtqpGvumW8ARXs=;
        b=RysBMgtXTtixkGdnoVKhKoeHHlmbUl828+6TIjYU4w2lu2QYSaktSWPPE9s/GBaBuR
         sFfpfH2q9ndmEiXse9VfH+tPfUblWqB1fgdC8C8o15vcAa3pA+qjlJZScXB9vJUddapZ
         yg748uK8tZZlpiYkkHRG8ZEmpHqt1uWE1JYAykfpN+v2jH86VeJnV528cXDYvbCm6vbv
         UWlrnul9PdOJCNhIa+ZCGk+MxhGoiIT5mU6QvicTlgLs45fMlZXvWwehLO4wFL6fOq1r
         g7eiA+2Ej89WmHqGcimU8he9rJ1uS3M75mygPruPWodkAdUlXML7LMjxBrHKI7mfzlV4
         4Q7A==
X-Forwarded-Encrypted: i=1; AJvYcCXAQj/HgzHp+MmfCDsJOe3UhCUTFebrHpFOVUwtHAYnQ3zZS71RLUVzYUc/bG/IjEhzXOP8wOpXsIHrghtseZKFk7Chu+ZCyGlUKBMWu+TelQ==
X-Gm-Message-State: AOJu0YzGWZurRYfx5BOe+GCMRaaUq9hiGujEGd2hsvVqk/reP032nmB0
	Cjhs6qYM0V+JrkbCkSIOFEtaq/1hzu/Tu9lG8zp0CUdiQHw6Mu+n4J0SYLZ0o1mULtICRP1s97h
	sytu8Hw==
X-Google-Smtp-Source: AGHT+IEblV+LCk1KeV8fImuRJAGAXrqJSnRd0Y2lGfb50NUegiQTWmLeQGEx7ynGu/qD8BUtkEWv8J60bYVx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:690c:d81:b0:64a:d9c2:42c1 with SMTP id
 00721157ae682-658f000551fmr2773277b3.5.1720807963503; Fri, 12 Jul 2024
 11:12:43 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:10:56 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 15/27] perf report: Use perf_tool__init
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
 tools/perf/builtin-report.c | 55 ++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index c402d9b3dca6..cd5caf1c974c 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -799,7 +799,7 @@ static int process_attr(const struct perf_tool *tool __maybe_unused,
 
 static void stats_setup(struct report *rep)
 {
-	memset(&rep->tool, 0, sizeof(rep->tool));
+	perf_tool__init(&rep->tool, /*ordered_events=*/false);
 	rep->tool.attr = process_attr;
 	rep->tool.sample = count_sample_event;
 	rep->tool.lost_samples = count_lost_samples_event;
@@ -817,8 +817,7 @@ static int stats_print(struct report *rep)
 
 static void tasks_setup(struct report *rep)
 {
-	memset(&rep->tool, 0, sizeof(rep->tool));
-	rep->tool.ordered_events = true;
+	perf_tool__init(&rep->tool, /*ordered_events=*/true);
 	if (rep->mmaps_mode) {
 		rep->tool.mmap = perf_event__process_mmap;
 		rep->tool.mmap2 = perf_event__process_mmap2;
@@ -1272,30 +1271,6 @@ int cmd_report(int argc, const char **argv)
 		NULL
 	};
 	struct report report = {
-		.tool = {
-			.sample		 = process_sample_event,
-			.mmap		 = perf_event__process_mmap,
-			.mmap2		 = perf_event__process_mmap2,
-			.comm		 = perf_event__process_comm,
-			.namespaces	 = perf_event__process_namespaces,
-			.cgroup		 = perf_event__process_cgroup,
-			.exit		 = perf_event__process_exit,
-			.fork		 = perf_event__process_fork,
-			.lost		 = perf_event__process_lost,
-			.read		 = process_read_event,
-			.attr		 = process_attr,
-#ifdef HAVE_LIBTRACEEVENT
-			.tracing_data	 = perf_event__process_tracing_data,
-#endif
-			.build_id	 = perf_event__process_build_id,
-			.id_index	 = perf_event__process_id_index,
-			.auxtrace_info	 = perf_event__process_auxtrace_info,
-			.auxtrace	 = perf_event__process_auxtrace,
-			.event_update	 = perf_event__process_event_update,
-			.feature	 = process_feature_event,
-			.ordered_events	 = true,
-			.ordering_requires_timestamps = true,
-		},
 		.max_stack		 = PERF_MAX_STACK_DEPTH,
 		.pretty_printing_style	 = "normal",
 		.socket_filter		 = -1,
@@ -1477,6 +1452,7 @@ int cmd_report(int argc, const char **argv)
 	};
 	int ret = hists__init();
 	char sort_tmp[128];
+	bool ordered_events = true;
 
 	if (ret < 0)
 		goto exit;
@@ -1531,7 +1507,7 @@ int cmd_report(int argc, const char **argv)
 		report.tasks_mode = true;
 
 	if (dump_trace && report.disable_order)
-		report.tool.ordered_events = false;
+		ordered_events = false;
 
 	if (quiet)
 		perf_quiet_option();
@@ -1562,6 +1538,29 @@ int cmd_report(int argc, const char **argv)
 	symbol_conf.skip_empty = report.skip_empty;
 
 repeat:
+	perf_tool__init(&report.tool, ordered_events);
+	report.tool.sample		 = process_sample_event;
+	report.tool.mmap		 = perf_event__process_mmap;
+	report.tool.mmap2		 = perf_event__process_mmap2;
+	report.tool.comm		 = perf_event__process_comm;
+	report.tool.namespaces		 = perf_event__process_namespaces;
+	report.tool.cgroup		 = perf_event__process_cgroup;
+	report.tool.exit		 = perf_event__process_exit;
+	report.tool.fork		 = perf_event__process_fork;
+	report.tool.lost		 = perf_event__process_lost;
+	report.tool.read		 = process_read_event;
+	report.tool.attr		 = process_attr;
+#ifdef HAVE_LIBTRACEEVENT
+	report.tool.tracing_data	 = perf_event__process_tracing_data;
+#endif
+	report.tool.build_id		 = perf_event__process_build_id;
+	report.tool.id_index		 = perf_event__process_id_index;
+	report.tool.auxtrace_info	 = perf_event__process_auxtrace_info;
+	report.tool.auxtrace		 = perf_event__process_auxtrace;
+	report.tool.event_update	 = perf_event__process_event_update;
+	report.tool.feature		 = process_feature_event;
+	report.tool.ordering_requires_timestamps = true;
+
 	session = perf_session__new(&data, &report.tool);
 	if (IS_ERR(session)) {
 		ret = PTR_ERR(session);
-- 
2.45.2.993.g49e7a77208-goog

