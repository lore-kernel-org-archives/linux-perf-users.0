Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2C9196D90
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 20:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434247; cv=none; b=dPGvJtstkoVIV/7VzgmD2Uuzxcbfaz9Yjw4n/+5wtsUFJQc5V0qVo9vPEvV5yoLZLHGt3+yo7Vp/uok17o35YrYCaVdfoKCgqxFsJ/Jj0Csd0ovqsjkmaEkE4R/8c4A2HF++odpBT9fK9AEnMFUFLMl6+z1yp/n1WoLV8j29ydk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434247; c=relaxed/simple;
	bh=wyJ+MS1hXvC6jnjDEgOqcoNvRhtG2Ev85ERR2gsbIdw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=YIJWR9PGeRKgYCcuakUNHnueRUDIF5l2p0DVszXMI7yGk5G7ghSIf8DG6VIHqDAs7yaYEaKMzyB0e1cZdjZrYZ+7kQqk5XtUFJRbfQEOdIpPixTr+DH/P7/Avc1PZTG5Z0mNO5NaXw/RxpSr64Lh/BlVqKCIhWYuTUXx2WdL2/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t8kZYEJ3; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t8kZYEJ3"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02c3d0f784so13407031276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 13:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434245; x=1720039045; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ygd9VSeBzmgIFn0KNDzBnTE+heYOe9Db6FtOSFvMpYw=;
        b=t8kZYEJ3Dp7rq+wqrkUv1eoQoRlmB7Y5UGfdOUoVUP0M/e+C9pAp023YchDFEs+QP3
         Qq1dx3bI5eU9B1UM6QAArDrX+rPdWl9k0uw/3vVhB45FWZcmeP36b2SLbogJx956NHj7
         0jicq/1SYjEzxl/BxLcUJFLWOKBMKyp611r8J/IZ56QgfF+qr9ve74Bv/EU9BCWYT2Ww
         eYy1REbmJmRY8T/rn6FowF3AVtybPweef/HOQ8NCrCKdPBAvftmgfARFwAcUj3GJiw5u
         6ms9OThTKyonxSo60ZAX9j2g4J4ORnX2cCtRxBMwls6ajDmaRODhHHdCPq+1KcFQl2+v
         tn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434245; x=1720039045;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ygd9VSeBzmgIFn0KNDzBnTE+heYOe9Db6FtOSFvMpYw=;
        b=jQEUJ8FYyx6ZaXBzteTmN+m6ymcqFciycFkGiN4u45BLLvgvZ3iHsgWcNBsFQd1u9V
         26DT4642JwBdeS5DSivG+avSl42K8xLNlr+UH7IJqs9+wP8LXUvHrd2D5e6cBhv7J3Zg
         vVtPm+bu04x5XWiI1C0qSFYkO+GmOCU/L6Po0G92TfoIMvVAXL5e4LWGkhfK06I99CYT
         Ez6ltKmgpogE6LAd+6T0t0v5xWJAsjyShWoSKWIIHuIer8Fa+TY5VyhafHDVLxBaP1IO
         C2W0hWAM1ufdy+ADLd2VJjCR/hPVwkiJrsf1NsnbPmYA6TAPYqtQ1C96G7DwehmIV5n/
         XBcw==
X-Forwarded-Encrypted: i=1; AJvYcCV+Yshz+di4fvDTfm1VeIQSY4b1bLOQXEP5Y9h8y08g8oTJxxquGZpMzmwK98vldAqiERRBQCMW6sqE1znCCuojSQcnuK7VUGZamplrVkxq/w==
X-Gm-Message-State: AOJu0YycNb1NmFzqfT3VF/k7h4p0DJVwP4uSzAdRlZTWn0cgKoz1UnWn
	GBeaCFzBaX59vUIV+TUf5+bDD0jgfQtdcCAspe+L2i09D255U6nhR/N/jqX1J3LsPGtuOZhhlny
	YbnDFgQ==
X-Google-Smtp-Source: AGHT+IF/vcrraNGO8BvvwHEaNEI4MnPwEjIw3svMWd/uO2vmBwnso/c7O4FDmbKBdx/YPU/OIZxWVyD57VYv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:6902:1009:b0:e03:252a:f931 with SMTP
 id 3f1490d57ef6-e03252afca1mr11973276.1.1719434245280; Wed, 26 Jun 2024
 13:37:25 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:22 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 20/27] perf timechart: Use perf_tool__init
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

