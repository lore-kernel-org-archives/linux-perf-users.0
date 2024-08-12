Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8220E194C8F
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495682; cv=none; b=QEUdLFKq3SCxYELtqj6LVOZMss4PQhk5bKg8BIaPxT6QNqdcO/qATeukESBO6gqdy30ni9xDpjNJksEZasfymrAOwZEOByxElKHO4FpvUd/bPv+g/0SSCswQe2vQQmvwAKxS0Eu4o5PSZOZWTOEaCTk+nBIIdN7QHWOafjeEoyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495682; c=relaxed/simple;
	bh=yn1Y4YUPaCPNPZx3MbBPCZJQjCXbLK9zms+TrM3KBDI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=hUt2WHcj365lTsWJ1vFssHhQPgMA/gWGXYkKMz+D5e+o2lloaKDe1oGPjVUGLjebXMJBiktK6K1kadfvKXt0Tkv2C3cakXb6uhILT7Sg7zfJJhY/b9AYUQIRU5kdlI6ASxW45YNIpIE4iwkQMQdb4q0Z38hVDvwBW2DN/fcIQlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qn5XzBn5; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qn5XzBn5"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6688c44060fso112167867b3.2
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495679; x=1724100479; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7NdZMo6g09POfWB6a47CRgDZioDpzOqzlpd52Wjbvy4=;
        b=qn5XzBn5gGN2lHDf2XyMbYTujX/lP7fL99HrkueOrXGlWxt0rvsqgFy+MDV7mj7YeK
         Oi6zDeRC6f5kxtS/85EJvP7Pw6te1jFXIndLy2nfXyhfF8dUWZU78jHyg9j2/dyH//N9
         Uq+k5Oz3gDxcUqVTVn8AS/6f+3qNa1CSKO1e/wy91rDehC20NJbRVHfZr3o1TAqo8bht
         B2X1hu9iaQYE8RR45o3QiSUzAxAiUfTJ9QzxghgyVw/VHJPmJYgGaXWiQZQRodeVJuL8
         +xrIiP9BhExTouJohhlLPkpy6OD/OhUZYKhdEHbtvNSueUjK4RUpfemgWpqUX+Sj7Kq5
         gG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495679; x=1724100479;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7NdZMo6g09POfWB6a47CRgDZioDpzOqzlpd52Wjbvy4=;
        b=PLnO2H7L/Hnu/yWoW1IVUjgWZr/rzZ3aMEZhAKt+YZMbsnpNlWM4GoHez2KssbRHsQ
         L/5O/PRbzfAAf2RKhd/kNhNbZNV87QBdxymbcgBrVENp0OO9y0UyjFq3+C+9zYLiJdW9
         gXfSG64yXpE2+VO8aUIIQHmk7A2dwqz/M6crl7gMXL/B30cCzjigUxSo14OrwDiz7sqh
         U9V1C4VEsMfzuB4SxqWUde1Uzvi88U2uKWKiCYGlj6oWQJANacr+bjupAFbVy1rPEHEq
         ns8z6IyLFbGI0glXk8Tvcoedj4GATpn7xPp7pi2rbBdR3hKDkKMGPH8BBeBIxiD1Xl+M
         7s3w==
X-Forwarded-Encrypted: i=1; AJvYcCWZyztHwCerFd2UfGDhA0aedTUMz33l50FzS5vzexiSSWC+lEnqmHHkTIZsBBv+6lvQhIn1axBUvvMOAas7QTby9C7rqRhok7jAsjQz0hHPdg==
X-Gm-Message-State: AOJu0Ywfj7YqwHUe9Yo1xZhbS+LCVhZDf7//p0yAHpfgeZ+50Ij0eVS5
	8tkybrjmywupGZKnTSvlhkmzr8uOm5zp/8mHWzxPCo6rd1MfQlRnd8ntLAA7C0mRH35qv4YtYzA
	PkyZjWw==
X-Google-Smtp-Source: AGHT+IFLRCJIhWvPJSHjOHmMfdHtiQHnRoYSTMp/a6ol78xUAn1ejpME245xEtPgzqIaNdDEPkgMc8SAGVRM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a0d:e347:0:b0:648:afcb:a7ce with SMTP id
 00721157ae682-6a97266deabmr35017b3.3.1723495679604; Mon, 12 Aug 2024 13:47:59
 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:47:07 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 15/27] perf report: Use perf_tool__init
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
index 5f609a7791ea..dfb47fa85e5c 100644
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
2.46.0.76.ge559c4bf1a-goog

