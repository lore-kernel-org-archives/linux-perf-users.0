Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A675D1957E4
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434236; cv=none; b=E6f1sPbA0/8JrfrE+Xi53bZkQUXTHpYc7m1rObsvPqoNJ2egi4T8NMKtiYOsQWEC9pfjUrWmlq4/WMBjlejON6NQvrkq8ZoPkj/NWANSurrc6X7omHaF3sKmoAcc/OveOP+gcaSN5ydoqHl4qGgbcchEmBYnTZNcBIGQFMzx7pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434236; c=relaxed/simple;
	bh=3FrpPhcqSWlNmnpFwaNx96Z+Mpxf4dIupHzPwx6lfeQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=phMpqC06rnjR9/McKmHCYuxGBgkNV9nhoHRz6ibbW9G4H9cLIRfPoV1LNqIcYvy1dDJBOfsiydFRk3fb2JSQxEChEWMD4VxdMlooAFEA7MZT/hWbZrMH418Yuu8DQGI0nSdYTs6z/aXOfH628kfxpcjS5jkr12bSy53lA4m1B84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=No33cHiE; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="No33cHiE"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03334bffe1so2492767276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 13:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434234; x=1720039034; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/glFNS8XgikFm2z1yC/0AkpB2sfHIN5dEG3tYazcbCw=;
        b=No33cHiEorzydKntL3UYfx9jmvKJlMLdbprVzgYwyFjAR4zeM20Prkyq+rdVcvtuWC
         USZSEouxrVGnVWrAjWychgwVegB7JDzNpoM7j8Ek76VUJBlhWp9ZEWLnto/T6PTqWnIW
         3QxcVcE5AlfcgNoqlra1/2cVt6K2xgUmrkWN9P9uOJSk3WRtYd1xhc66uLN9Mdq0ujq/
         r/sXXyByGmeuNJiR6Wai3TMywZZXPdeM1PAEFrQi07u+aOBWrp5SFt1IwbY55tLzVg5o
         xIJUExVlTzWS11B6RT8xLMNk8ZVWsu4EulltjkPR9A+MeKKnZWRldVKmPQI5TKWqQ9LQ
         3Tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434234; x=1720039034;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/glFNS8XgikFm2z1yC/0AkpB2sfHIN5dEG3tYazcbCw=;
        b=GD816G/iu1c1WHit+/q7ukdDBgu0Fdi4IgCJJHTndAQLoeTC+Otv2Cd94oa2x/zOPh
         DZazLnxBw++3sDbep872E2EAP5Cc85WDp1jYBGGTOFK+VfouluoBfKhsfAfbiRX0pnL/
         0A+IosAyqBjn8ygLkLJCmaF1OlieWKdhxZ8Lm2LkUsNH9JvS27+wN+PwjEx3X2PQeWqv
         hA9oDQJYSX1xyXpaDA9KQF/M/9V52vZ2vtm32q+F+zzYLUzB0TlUdd30VrMdXPM0cDxR
         RPslAy1QoM1tmnSVI3tr4Ywoyi5RJPcBEiPxgA7T6/+JDHSFGY4D2JvYZmrNCFyrqwbM
         8gcw==
X-Forwarded-Encrypted: i=1; AJvYcCW6g+L2f4BICShWsas2+hlDeH1oZ+OW9LKOJKXF1vc4FrohmIFpCoTx5gWNt5MD+bnfYs20FucTmcwoY28cS/FD72Io8O6Q47oIEv8VPA/a+A==
X-Gm-Message-State: AOJu0YyOkeFn6TDyq2Tips8kjSIn/7JuEgpSlryUL+XAeWFdj2VqSdJP
	tb1pfjwUcI9jrqi+knUctgji6jzbf8WlD04peRnlYP5hGt4bwmzB7UG6FsVjcidMFFB6aTD3C0l
	boQLo1g==
X-Google-Smtp-Source: AGHT+IH7xWjVfQ6FHHEhPxwNW11DF2T5pKfJxSXy/6lYJ9C2XxhVZeGCRnAlj0G2V0YLxBcrHW6+1vNR/qYQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a25:9742:0:b0:e02:bdcd:d68c with SMTP id
 3f1490d57ef6-e0303f474c7mr96082276.7.1719434233758; Wed, 26 Jun 2024 13:37:13
 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:17 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 15/27] perf report: Use perf_tool__init
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
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c | 55 ++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 2313bacea0d2..86501edd5a7d 100644
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
@@ -1273,30 +1272,6 @@ int cmd_report(int argc, const char **argv)
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
@@ -1478,6 +1453,7 @@ int cmd_report(int argc, const char **argv)
 	};
 	int ret = hists__init();
 	char sort_tmp[128];
+	bool ordered_events = true;
 
 	if (ret < 0)
 		goto exit;
@@ -1532,7 +1508,7 @@ int cmd_report(int argc, const char **argv)
 		report.tasks_mode = true;
 
 	if (dump_trace && report.disable_order)
-		report.tool.ordered_events = false;
+		ordered_events = false;
 
 	if (quiet)
 		perf_quiet_option();
@@ -1563,6 +1539,29 @@ int cmd_report(int argc, const char **argv)
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
2.45.2.741.gdbec12cfda-goog

