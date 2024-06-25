Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBD917F376
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336413; cv=none; b=Ccwo4dNUXaHsNSWuBczO7W6pD0qRs0Pcm98BLqow2JN9hLGwRKySkNwiQrXmVwQ2LczfkT2EGWhW14sH2hFpCq1ob9i/AibCeKl3gqyVKuCMCQHnOZVMVqnboF4y8v3SxjvAmCWdGvR6aMm7fHy/fG2eNNTaBsq0QDI3JW0D6gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336413; c=relaxed/simple;
	bh=wyJ+MS1hXvC6jnjDEgOqcoNvRhtG2Ev85ERR2gsbIdw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ust/PAwIUCorTUsBEkmnwwR8Y2xJhniaR08SuergrENbGMIRVnZibmFpKMRsUX0om8SNyC5peHTmw+7sBOzy3YtkwuphI0Ui3E5usI3qMfpyStpFd6UKEgX4DirlSZBAeBBoklj1wM7xArPw6tixv7s/VkrvriumvyRXdewD95w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0ei3c/UI; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0ei3c/UI"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfa73db88dcso11513801276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 10:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336411; x=1719941211; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ygd9VSeBzmgIFn0KNDzBnTE+heYOe9Db6FtOSFvMpYw=;
        b=0ei3c/UIMAsYHLRlrg2JJKlzHWxbzftb+76l5Xgw6d7i9XQExYvIlXurDNw+TlP7Ap
         dVAYUusS/w29wS267str7Em25TSnGCmAkvCMQbQMiehGbFO4u38XXWuPA67UDPi7B0jM
         ESWSnK0DIVMaTaxaevI/r+7EC0JgAphf1qQMV0afsYJ1zQa2y/0P9zt6BcYd7h7QAFAf
         v5ZECPO44npQkb3hqZAz+Uo15QHdyVso9sSt0KeyFi7488Xpw3OMaRCAWGXlBWHTSQy5
         ELTeXHATSz1V3DQ/1dehLe+cBpn6f8gA3WeclWqGO3GtyfT08JxPwWOUNzD5Jf5/aTjx
         pnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336411; x=1719941211;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ygd9VSeBzmgIFn0KNDzBnTE+heYOe9Db6FtOSFvMpYw=;
        b=KSXEhcOoGdZ9RHm/iuh0Wrz3r5R5atWXcIFK3UuP+pEcc0cKma+tAzBQAfr2ihjqGR
         iQj7yRF08N5PAjzZsXH1FpcM1aSE8VwvQxq6xvkQNpSCBYEDuG5U7QFHxPuyUFigRCwS
         zxNsFC9PJIOHBcq+y3qRvRxJRo07txkCreBvFp6ko4MkK0JS+iYnBZcWQJP1KBVI9/q1
         neby7bom/24e7NeOAyNJD/R6u7iXGYKVDpw2HqfLoZ2uHnnVG4J7BpATjNNMD+KrOv38
         DFO5euvT/WKDpi4+/Szf9syWDBohadG5pdAHrwxMMZ7rjukzI6OgG8zCeK7H8FKIr9NY
         RR2A==
X-Forwarded-Encrypted: i=1; AJvYcCWyXNQu5yVLX8M2Z5NsbQL56Y386K7sFsi/wHo52is6skE6BJSELUGTVqZ62ZSuqAXA+d4bydskf+MT9gwdms8jfno/SHPYVRq+/MnzlgukNQ==
X-Gm-Message-State: AOJu0YypzXHpU4sJrB9QwM7DYN9frMmKYX3mnNgOM7V2LF+j2JLbX3Hi
	RbBVDLkg1qsHEp5HRusENRprJu/iR9V6eh99TO87MmvntQuIeEZwgvPIFd7Y+/jmxlkuUrlLfFA
	XeSBFoQ==
X-Google-Smtp-Source: AGHT+IGJqb768geaJ/+3Dza1yAwPrymkaebPJuzakVPlvvTG4c9cKDtVCh89RfUHal9utqfZd1Pqsy6N9wKe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:6902:704:b0:e02:b093:dc1f with SMTP id
 3f1490d57ef6-e0303edb60emr31284276.1.1719336410683; Tue, 25 Jun 2024 10:26:50
 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:25:55 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 18/26] perf timechart: Use perf_tool__init
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
 tools/perf/builtin-timechart.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 5bf818baa662..218c8b44d7be 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -1606,10 +1606,16 @@ static int __cmd_timechart(struct timechart *tchart, const char *output_name)
 		.mode  = PERF_DATA_MODE_READ,
 		.force = tchart->force,
 	};
-
-	struct perf_session *session = perf_session__new(&data, &tchart->tool);
+	struct perf_session *session;
 	int ret = -EINVAL;
 
+	perf_tool__init(&tchart->tool, /*ordered_events=*/true);
+	tchart->tool.comm		 = process_comm_event;
+	tchart->tool.fork		 = process_fork_event;
+	tchart->tool.exit		 = process_exit_event;
+	tchart->tool.sample		 = process_sample_event;
+
+	session = perf_session__new(&data, &tchart->tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
@@ -1924,13 +1930,6 @@ parse_time(const struct option *opt, const char *arg, int __maybe_unused unset)
 int cmd_timechart(int argc, const char **argv)
 {
 	struct timechart tchart = {
-		.tool = {
-			.comm		 = process_comm_event,
-			.fork		 = process_fork_event,
-			.exit		 = process_exit_event,
-			.sample		 = process_sample_event,
-			.ordered_events	 = true,
-		},
 		.proc_num = 15,
 		.min_time = NSEC_PER_MSEC,
 		.merge_dist = 1000,
-- 
2.45.2.741.gdbec12cfda-goog

