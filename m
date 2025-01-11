Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92C41B4141
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 19:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736622124; cv=none; b=F6vA0DUE3CdQ81P4qpplkn2bRGk0au7iTVjURYB1KmtdZgevUqD0Yzh/HuuqRqiACDqIuGmTSxqRCcHFKeNtRjsKivtF8IF3R7lU1hbTeHo7+5Mfh8VTAxKx4jAjjC6N4WVgsYpr36oe0JoPyRDZe/YGIGCV65Vi/UOd/kwKhVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736622124; c=relaxed/simple;
	bh=uxjKgTQOYc/g0NOKuabxXSO5OyiHysVTP5ZayJkk7/U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=mCLBQApyxz86sD0Tz5aN+WcbiMmf99M8YNEeEj5VwVDnT9A/hofwAaiKJ44xpnxVN7QYWv8JdjY2eUvUsZRXzof3Ep3r3IjBOzg1GhTIXzd1amnxBvT+BXLespDM5xIU831o0MNyT9hqSFjQS+Y8zdltpaMGodpuKK7xgopKsYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UNzkYyff; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UNzkYyff"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3a0d165daeso7102127276.1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 11:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736622122; x=1737226922; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YoQijeVtRvR+oBIRiWKwvAzKH0G3s+PandSVb3ef5bA=;
        b=UNzkYyffXQ0o9O3pDAIwn8YWsDYibQwLRrR1eA5hporaSo7dtmIMUAPXnlZhISkSEt
         j5+50IIUZEV07imm/fAPyWTyvHajEQAK2n/9JR716/94zjnImqtKuE+A/yVmHnC5oxwa
         6srMVOsOLQsubwwBpD1s8+Wr/GfllZgkoGZdda+xEiGikf2Le55lmxla2SWLcotXjTLX
         +5gMhqf1KSWaiXqVlu+U4coxVC649IDR967o8W6f8mXqZAENuU+ia9ngM6WtPm3gpAeP
         7QKfbiyMis72f9C2IRMXfV72+Blco5PbS7iIZgn6rnqLz3eKf66BZIZ59Hx2qUCK1Y7y
         yCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736622122; x=1737226922;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YoQijeVtRvR+oBIRiWKwvAzKH0G3s+PandSVb3ef5bA=;
        b=fgctEfeiBmsvowGITkH9EgXWYw3VE4syO2Q/T2B9HgkSZhMpTeTr+oIxwAz7zwYsp/
         CojKXQvLp546HWbkmGzeMnwlURaDuihomnkw+LbNBsL2L+VDrvJ8bYmoh7d6MmjZSUAn
         LdCdhAuX0HC7n4QtT9EDQLjUYnQzYBUvqa53bz4DRVG1y1uIKe9pYmAXuORZW4cRkV5/
         +ZZKWD5NjXOEzfDlZoTbKiWmTpj+KzvhKYmWe6rL0P9/hQVcqtJzLbiFBQuApes0tDaX
         xh/1bAkR1BiNwBSppZ5XMqzO47R+Qp1pyeLu/B0Pq1KMvplbrocE8TCDfLUt2UTDQWDa
         zTFA==
X-Forwarded-Encrypted: i=1; AJvYcCVqyUWlFgASczgxKU54C7ztacVxOBYy+YHci1UDHurswl3Cx1EavIixyk+NgG0VrebiLfDmgwHP3FbIKgHLa1B9@vger.kernel.org
X-Gm-Message-State: AOJu0YxpOu59wq0DqHIpqzQzWmjJenpCXL4o3/QEUwpn45YFxs0yYjDW
	Qv3CDMB2i4xK26GjjT+ZFpMFs2WaATj/CZRypuhQMdHxqxNCpxyJsYTLNG/vVEm8MdsVFP6aRQC
	6Psn4Tw==
X-Google-Smtp-Source: AGHT+IHxMZ8RvhsYktTfht/WNFE/YRGvPFn2yfbHp/8wNKScTNE1wBQLKnt5T1ARhCC9SxkMohry7resBITu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8807:d7c5:bb27:35fc])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b03:b0:e4a:4ca5:af79 with SMTP
 id 3f1490d57ef6-e54eddda40bmr52851276.0.1736622121933; Sat, 11 Jan 2025
 11:02:01 -0800 (PST)
Date: Sat, 11 Jan 2025 11:01:34 -0800
In-Reply-To: <20250111190143.1029906-1-irogers@google.com>
Message-Id: <20250111190143.1029906-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250111190143.1029906-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 01/10] perf bench evlist-open-close: Reduce scope of 2 variables
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Hao Ge <gehao@kylinos.cn>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Tengda Wu <wutengda@huaweicloud.com>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make 2 global variables local. Reduces ELF binary size by removing
relocations. For a no flags build, the perf binary size is reduced by
4,144 bytes on x86-64.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/evlist-open-close.c | 42 +++++++++++++++-------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/tools/perf/bench/evlist-open-close.c b/tools/perf/bench/evlist-open-close.c
index 5a27691469ed..79cedcf94a39 100644
--- a/tools/perf/bench/evlist-open-close.c
+++ b/tools/perf/bench/evlist-open-close.c
@@ -46,25 +46,6 @@ static struct record_opts opts = {
 	.ctl_fd_ack          = -1,
 };
 
-static const struct option options[] = {
-	OPT_STRING('e', "event", &event_string, "event", "event selector. use 'perf list' to list available events"),
-	OPT_INTEGER('n', "nr-events", &nr_events,
-		     "number of dummy events to create (default 1). If used with -e, it clones those events n times (1 = no change)"),
-	OPT_INTEGER('i', "iterations", &iterations, "Number of iterations used to compute average (default=100)"),
-	OPT_BOOLEAN('a', "all-cpus", &opts.target.system_wide, "system-wide collection from all CPUs"),
-	OPT_STRING('C', "cpu", &opts.target.cpu_list, "cpu", "list of cpus where to open events"),
-	OPT_STRING('p', "pid", &opts.target.pid, "pid", "record events on existing process id"),
-	OPT_STRING('t', "tid", &opts.target.tid, "tid", "record events on existing thread id"),
-	OPT_STRING('u', "uid", &opts.target.uid_str, "user", "user to profile"),
-	OPT_BOOLEAN(0, "per-thread", &opts.target.per_thread, "use per-thread mmaps"),
-	OPT_END()
-};
-
-static const char *const bench_usage[] = {
-	"perf bench internals evlist-open-close <options>",
-	NULL
-};
-
 static int evlist__count_evsel_fds(struct evlist *evlist)
 {
 	struct evsel *evsel;
@@ -225,6 +206,29 @@ static char *bench__repeat_event_string(const char *evstr, int n)
 
 int bench_evlist_open_close(int argc, const char **argv)
 {
+	const struct option options[] = {
+		OPT_STRING('e', "event", &event_string, "event",
+			   "event selector. use 'perf list' to list available events"),
+		OPT_INTEGER('n', "nr-events", &nr_events,
+			    "number of dummy events to create (default 1). If used with -e, it clones those events n times (1 = no change)"),
+		OPT_INTEGER('i', "iterations", &iterations,
+			    "Number of iterations used to compute average (default=100)"),
+		OPT_BOOLEAN('a', "all-cpus", &opts.target.system_wide,
+			    "system-wide collection from all CPUs"),
+		OPT_STRING('C', "cpu", &opts.target.cpu_list, "cpu",
+			   "list of cpus where to open events"),
+		OPT_STRING('p', "pid", &opts.target.pid, "pid",
+			   "record events on existing process id"),
+		OPT_STRING('t', "tid", &opts.target.tid, "tid",
+			   "record events on existing thread id"),
+		OPT_STRING('u', "uid", &opts.target.uid_str, "user", "user to profile"),
+		OPT_BOOLEAN(0, "per-thread", &opts.target.per_thread, "use per-thread mmaps"),
+		OPT_END()
+	};
+	const char *const bench_usage[] = {
+		"perf bench internals evlist-open-close <options>",
+		NULL
+	};
 	char *evstr, errbuf[BUFSIZ];
 	int err;
 
-- 
2.47.1.613.gc27f4b7a9f-goog

