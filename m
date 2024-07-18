Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481944AEE6
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 01:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264465; cv=none; b=uw9Os1kETem6QGuGzQ60H/e7N5gnZ8eupdbUqwuHpkwv4bbuqtrqrPR89rQHYe9ylJTuZ1uClIL2NRlJkhGd9H4wtWo2jmQBqflyNkala3Rs9OMC7ciUMnky2eXJb34fAem4Nwm4IfkoeVv5r4+Hsh+wxtMIgp1LGblMOt/IKrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264465; c=relaxed/simple;
	bh=H+IPSfdi1XWUevftbp/S5w5ZjSsxdnIbgCEG0f7dgCA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=l6qYFPGKLT9q+iJTFOQb0v/qRfKoGir13epooqwy0SRwFi1Mz6yEc7nImcGUFrP978dr69AwmH3rrJ5ToA6am5dtDclO3omU1X+7U5RN5izsPYr6j+w5tqhRV+Rz0sqK1t0Al/UkcpkUib4pR65Jcfb+O0p+vFBaq+qYpDVBiXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ZwRFOn6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ZwRFOn6"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-650fccfd1dfso6311377b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 18:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264462; x=1721869262; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WcLk/IdzOPY+RjxovTTq+hic/bNKHt+pBKiPhBtB+zE=;
        b=2ZwRFOn6zu6WVu5gJsN2IDA8YuqVvzWzHR4i31TS6L9vGuPSNmAmVSiwqW/CLAFuDi
         1w/x4W67aIT77IDxCpe3/KNdZb/ZnhJteGnzjOnT8fIAvD2zGREXy/P+w0x/ZYKp4gXd
         TtYb2YbTIc1jewshdv5ybPZpc5oNMUPmeQPeTtx5N+lKeirblaUABo0irXRetvQzZWGF
         8s45F+/3E9hgGeYOBV58xHcvT7u0zrLIDAMmZmNJHFgx54E8X5reX1EdjS2LSttx+IZm
         i0DKK3Ak6FFG2j7cTJd6/sZBiPOsMcYzm+49IdPHvmgPmcXODqDOEUaAD9Cit0hB85Ie
         CDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264462; x=1721869262;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WcLk/IdzOPY+RjxovTTq+hic/bNKHt+pBKiPhBtB+zE=;
        b=j6dSbWKDz7oFQltIj8vejNh2JChzKYDA0qa5kpmz6JK9Mx+eiHNIKQYXpWR8+BUQn6
         GTOGce2y+7btWG8fwfTpK1wXAYkdb7LudlJNNRhvJLu1NJwvRG8nR3HMKHXC4Qrl9d1o
         xhpTZknFFqL8fnYY1jpejMK2loS1jIDOaDaxQMjnzqfVH9N5svnEmWP6wR0GCBVJMgBx
         +VWfmXi2fdKxztLG9OAoNvWoZR0X6ksIJ2Ai+bsdYKi8SDgNPasTW1amq/gff6773Ioj
         8qdgDJb+I6dr7UzkTBywprknyKzHDH8wmArmF0eM1J5HW+NR/WCc0F+OhqKRlTmjiqwJ
         WDAg==
X-Forwarded-Encrypted: i=1; AJvYcCV52K7BvLhctq+NrY3TG2vqXBeMta/03UOPhZTenSReVMlXCKQULWKgK5QqMAjyg19Bk0c+kHcGVZhfEteLImknUr8AW6FSRg8treUsrAtEcw==
X-Gm-Message-State: AOJu0YxkKQirwsFmC0kglezw553ULUkYY5Va8EpokcN+NriK79luZFBE
	rknqzKAzaByZZIGIC26XLpNqvxZIravKFp8SD6t15rz3Lx9TtI9G13uJfwW9j+6G5QNYbF4/Qpi
	cYe2kog==
X-Google-Smtp-Source: AGHT+IEKHTyblJoo125sOHAe4wzZxtfBlpdtI8dNPSpZYT1yA/iN+KaAbZBujqa3GKfkudcZLR62quUfwf8I
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:690c:288:b0:65c:2536:be7f with SMTP id
 00721157ae682-66604a8c105mr572767b3.7.1721264462396; Wed, 17 Jul 2024
 18:01:02 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:07 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 11/27] perf record: Use perf_tool__init
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
 tools/perf/builtin-record.c | 33 ++++++++++++++++++++-------------
 tools/perf/util/tool.c      | 10 +++++-----
 tools/perf/util/tool.h      |  6 ++++++
 3 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f27f725913d7..12a5170d9193 100644
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
2.45.2.1089.g2a221341d9-goog

