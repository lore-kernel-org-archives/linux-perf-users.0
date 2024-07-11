Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACF717967C
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720861; cv=none; b=QJYlSZ+sSHFZGlReW7wMUu074OfUuICMoh/IJYvbH71NXWTRVeRfbWczgVb+ejLGG9G0tDuN+hlqW6yyIM47j7n+0C03M1ozmnhFZCGlUOMUxDnXr1sEEgXHFuLN/2DWRc5BN4DKGIFnDDB8X1P/RTXFblyTwiZGRr/BGIFmD8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720861; c=relaxed/simple;
	bh=ulxtdrULVFXHxSwGu1u6ejOo2/3AvfXoc6ANmm1gsuE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=OnjHplgD1sn0zX3PAed8erI/fSBpLmSCJ2By87goRIx1086QLEyIWapreorDxu4JUjI+pT6CL8nKHv4TNLZPKPu/OaEDZ/YJLZxVQve2gUJLKdnKxQFdFzuESSwlH7Vsc35hAPpOxZpO7PcUJoLi5JM1ameKsWOMqbasqqnyIyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oY5wAVSY; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oY5wAVSY"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6501bac2d6aso13428837b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 11:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720859; x=1721325659; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=30wTiCp+NVIhDTuqUvYj4YUy4HL96R/Tpq22ji595AI=;
        b=oY5wAVSYr8CgW5eQIgnVB0RZy+wBrReOOpsBcJs7qimpREAuhJHWIQ0ENgNWuE3uC8
         tl7iOx1zKbdJzb1fA7ZpoGWqbUyhZDltDVb6DWzCXKEpHdKRLHkw7Zd70vyRge2z3dp2
         skYZikwwpB2xHePvmwZKPolbIFUDcvaFR5poZKJhKPW9QL0qyzrAptMszPsDd/3ESyta
         0HXkE9O6nKUmOTIlqF63hjrSj/3p95473n6AWEbfLq7inqVT4XoogrDxyoGdbB8s4qy8
         bmhHNzn/GYG7Lz7rd8B3cf4vkAcA+2xKwci1iaObPWs4rcuB4rs0xSlQEX7HIZhRAcZp
         qxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720859; x=1721325659;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=30wTiCp+NVIhDTuqUvYj4YUy4HL96R/Tpq22ji595AI=;
        b=QVuSxAcpftu1DXWhgIoN6wJLpkqMpOi5lg6VyV4PtD+yEKW8sbQhzGU8lx9eQA/4gs
         wQYR5QSZqrwIRUeAfXnTgNrIOOfX9xW4wpizF4TCML7xRZE3lOYN8PB2poCXZAgQXDQk
         DGxuslPniw73LUbTsXyEbGfTSE3PLy+uwE7VoA/rPyMh3Q8+9YGnrftYacaPvxbiA8NN
         qyZM0XUVODkab3HdfxQ6E4/gmTli9iX4v6y4GDMwuvXhmRay98hH/13sILpjd8gcGASI
         l08OsFR6bftDdIQmj2AX6lN5Tj3/PKWhvo9Q8INewxn6tJsIvrdGngB+qb2dGOb4Iox+
         phBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXatDoifa+cefKgGgQqiD6goGMYl0dpgR5CVQ7R1x0QuWHH0Mif0i7GaJpIdyImcSeHKrmZYr9uSqnRPrtHi/LvTXUHcnn2QrW7zhJ+8cHZaw==
X-Gm-Message-State: AOJu0Yyrpg/J+PUBrggAmmIdb1JES+UMFfUUbCb/YMhVkCf19xNu+Lun
	cr3XNNJlkQpz7w36tS+NseMdYFY5cOO81sFrahUoCfFODd9Y4fdHd/gd9LX8yXxwusw8rOwGlbT
	d4C608A==
X-Google-Smtp-Source: AGHT+IFZpTMg4BQB94SCXas1IM8Xhd/IszdibFEMqZP5+uba0vWSTxmY0iKOvfL8EAF9shV0sCKOMUKx0Nvd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a0d:ea49:0:b0:64b:a38:31d0 with SMTP id
 00721157ae682-65df50b328amr15297b3.4.1720720859459; Thu, 11 Jul 2024 11:00:59
 -0700 (PDT)
Date: Thu, 11 Jul 2024 11:00:01 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-22-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 21/28] perf timechart: Use perf_tool__init
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
2.45.2.993.g49e7a77208-goog

