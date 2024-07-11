Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5EB16DEB2
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 18:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720841; cv=none; b=cp+Mlt1dxeWnMZvB6ZfVeZJ3gKaZq8HFoZAaRGx/6dcl/51uPla6elLQW60U1fjyGWhxpSJ7ht6AGoeJGpcZ1pJfyKUJ56OXQKYS9otZ6D2gwdZOMhulMHhVBRqDIPOzJlM1RZPLSvgLMoDgwlykD9hVQdTHAEHpekWXu+5iAoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720841; c=relaxed/simple;
	bh=n//5b9kLUBxzTee5X6iEwJUArQuNUyNCVfEklgkgJ5M=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=HFBZH/aSiAM/fMjuFU5FgQvifTyfT8C43XdndMYfyv6hFhPtsUTmOlmZXOW+K48pNIupSgQ9vUjmLN+W/kzfHBEHYO6uy6j+pCa0FE2XV6yprwfudFq1KzWvmWMXyjSBtts2McnputvGHSWFcT2sV2SfEW/ANMeqYXF69MuhyZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ykOTJylY; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ykOTJylY"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6501bac2d6aso13422727b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 11:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720839; x=1721325639; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Ff/gAGDG2aAEbUu/hDCKYzzmvI/uHVZRadY3JBl8Rs=;
        b=ykOTJylYM4kejbans6L9wi6z5noWr22pvllYU/L5bBt+1Oex1OE7WETxL92bae9lSF
         fujWywgWguB7zsstRZ4/O7HZm1zkVp6zQJTHj0U3sQnHQFGVeSgDz720xAqNrfHj8Ifv
         maEpqvIp/AMWFqhxlwDMsckdKZsFtzGC1ADcnI+RiVh/r1GJmfGA8uHrp4+GZ57IbAQo
         zcqDM6HFOudi2kOLM3YiGgJZ/KhSCcTZszrX38Wv45IKiJSd7A7udUsmePJg/hEIS3rd
         5y53v1xEayH/fmbC3rfUh468Gz6c0vX5gy0fw1t04ljIk21wo18VpuFJSGO64+eC8Iam
         FzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720839; x=1721325639;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ff/gAGDG2aAEbUu/hDCKYzzmvI/uHVZRadY3JBl8Rs=;
        b=KvtvNl+aXSS+jslbCKdysAxxK295aj5gEjhhVvCTgUib631xsP4U7oNM04mNwGcArz
         R9UfS3qverQigoztL0sMiirMd6tMH09QdIMthF82MdWxpwK9bpj7hdjhyMeVZvuCGG4T
         sxnDr6Fg8fGukuKlpV1Y2VnXVV8VhNDD8s71R0IJ+RykuWR/cuxQtpN+eoTXIp7MHxUV
         oOUUqaDnpp79AGyGxyYqhpyLf1UFaR1ZCbV1nh3XUGEps8HDYkIxi7mUHGPeAawfn9CS
         VJV+ITAkvhIJruBWD8WvRkRljDf7PLfxRhYJwulpgpcGe4p8Fp5GDiIPZJd9ghgNlCfE
         AnxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj3T5sJ+ME2dLu3gsPPZJkMQU3nitZFg4Q0ezcFhJBwsuFprYqg+g4PKYNTKIoaLARvmp1AHyhHB1su70rLgKe2n60DrU8cOKOs/t2CFklOg==
X-Gm-Message-State: AOJu0YxBDL3WK32qqhDlq5aCFKgdcZ6rp8bgSxvAgx5nNpHpX/MREpan
	993RbBWg56Dv8ctz9zE+zi3zo3BAVr/oFhvLw8mDt/240YaNdp1M+V4CzliZJHKmUvQ38MYxUVI
	fx2JOyg==
X-Google-Smtp-Source: AGHT+IFj9eydv65A7J7SzzeWQzPfBnQ3Mr87UOA0hqpnZkLQstHLPEsb9+ha7vzF8KoEQHxSj3FAFxPIHkwL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a0d:ea49:0:b0:64b:a38:31d0 with SMTP id
 00721157ae682-65df50b328amr15277b3.4.1720720839402; Thu, 11 Jul 2024 11:00:39
 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:59:52 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 12/28] perf record: Use perf_tool__init
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
 tools/perf/builtin-record.c | 33 ++++++++++++++++++++-------------
 tools/perf/util/tool.c      | 10 +++++-----
 tools/perf/util/tool.h      |  6 ++++++
 3 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e8677f9e1ccb..4b9309b4c07e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -193,6 +193,15 @@ static const char *affinity_tags[PERF_AFFINITY_MAX] = {
 	"SYS", "NODE", "CPU"
 };
 
+static int build_id__process_mmap(const struct perf_tool *tool, union perf_event *event,
+				  struct perf_sample *sample, struct machine *machine);
+static int build_id__process_mmap2(const struct perf_tool *tool, union perf_event *event,
+				   struct perf_sample *sample, struct machine *machine);
+static int process_timestamp_boundary(const struct perf_tool *tool,
+				      union perf_event *event,
+				      struct perf_sample *sample,
+				      struct machine *machine);
+
 #ifndef HAVE_GETTID
 static inline pid_t gettid(void)
 {
@@ -1458,7 +1467,7 @@ static int process_buildids(struct record *rec)
 	 * first/last samples.
 	 */
 	if (rec->buildid_all && !rec->timestamp_boundary)
-		rec->tool.sample = NULL;
+		rec->tool.sample = process_event_sample_stub;
 
 	return perf_session__process_events(session);
 }
@@ -2386,6 +2395,16 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		signal(SIGUSR2, SIG_IGN);
 	}
 
+	perf_tool__init(tool, /*ordered_events=*/true);
+	tool->sample		= process_sample_event;
+	tool->fork		= perf_event__process_fork;
+	tool->exit		= perf_event__process_exit;
+	tool->comm		= perf_event__process_comm;
+	tool->namespaces	= perf_event__process_namespaces;
+	tool->mmap		= build_id__process_mmap;
+	tool->mmap2		= build_id__process_mmap2;
+	tool->itrace_start	= process_timestamp_boundary;
+	tool->aux		= process_timestamp_boundary;
 	session = perf_session__new(data, tool);
 	if (IS_ERR(session)) {
 		pr_err("Perf session creation failed.\n");
@@ -3326,18 +3345,6 @@ static struct record record = {
 		.ctl_fd_ack          = -1,
 		.synth               = PERF_SYNTH_ALL,
 	},
-	.tool = {
-		.sample		= process_sample_event,
-		.fork		= perf_event__process_fork,
-		.exit		= perf_event__process_exit,
-		.comm		= perf_event__process_comm,
-		.namespaces	= perf_event__process_namespaces,
-		.mmap		= build_id__process_mmap,
-		.mmap2		= build_id__process_mmap2,
-		.itrace_start	= process_timestamp_boundary,
-		.aux		= process_timestamp_boundary,
-		.ordered_events	= true,
-	},
 };
 
 const char record_callchain_help[] = CALLCHAIN_RECORD_HELP
diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index cbd9b888bd73..a4ca16e5eefe 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -99,11 +99,11 @@ static int process_event_synth_event_update_stub(const struct perf_tool *tool __
 	return 0;
 }
 
-static int process_event_sample_stub(const struct perf_tool *tool __maybe_unused,
-				     union perf_event *event __maybe_unused,
-				     struct perf_sample *sample __maybe_unused,
-				     struct evsel *evsel __maybe_unused,
-				     struct machine *machine __maybe_unused)
+int process_event_sample_stub(const struct perf_tool *tool __maybe_unused,
+			      union perf_event *event __maybe_unused,
+			      struct perf_sample *sample __maybe_unused,
+			      struct evsel *evsel __maybe_unused,
+			      struct machine *machine __maybe_unused)
 {
 	dump_printf(": unhandled!\n");
 	return 0;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 897c6c44b6b2..fb7e32d98dda 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -93,4 +93,10 @@ void perf_tool__fill_defaults(struct perf_tool *tool);
 
 bool perf_tool__compressed_is_stub(const struct perf_tool *tool);
 
+int process_event_sample_stub(const struct perf_tool *tool,
+			      union perf_event *event,
+			      struct perf_sample *sample,
+			      struct evsel *evsel,
+			      struct machine *machine);
+
 #endif /* __PERF_TOOL_H */
-- 
2.45.2.993.g49e7a77208-goog

