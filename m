Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6EC8286D
	for <linux-perf-users@vger.kernel.org>; Sat, 29 Jun 2024 04:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636897; cv=none; b=VfX6TLt1AkddddTMw+NsWBpj2WlZO2J13BmoP8/Bno58cyqWu936nuc47y91ht3rE+9jVUuhsqz8DIcQ5HiKYQQCRZPYdcuZrGnWTp0ptF5pjdcpL4qerBR/pgvix88tZws59P0YRLRSgG0sXAJihUgE2H7nD3OscSu2PqfPlSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636897; c=relaxed/simple;
	bh=n6vmiL6wUTg0nPW7WZYagl0XLU4DbMO5fUh9FPhC+jY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=GUEHkpcjYBqoJIc/lS4KYWN38+KEgmEHlXxI6MCxyV499CM8WSSaxX2E7PBooYgfeYMNHO5T6aqB/cHJ6sL62HLFYh537ikkeXAkO1RRv0z2XuyOkBy1t6EgKaEehAIW+i8dcbNxgSttvNlPLC1sSMqu80Rpnc5gZsicgcYcCwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=azipCkGd; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="azipCkGd"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62d032a07a9so22250287b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 21:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636895; x=1720241695; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D520IbA5iH9wzM7pzjt2vV2BsWgfCNVquMDfYzdLQl0=;
        b=azipCkGdO7COcIpCEqS6o0srEDunArd/OP0YcjKBXGfwimwPpBw2QYp05j3Mx7cfGK
         c58MQEsgxIWgJI/uLjK31cKOCWBkIFkjDMUfbIj7BslBWF+7UoMCLnJKSX2vNnPSqxNZ
         ktN1TpCsJ9Rphfme9OknKt/xt5zGOH1+YepEr/1cQTvnpdrYdyhgVuyIyJLQRE8IZCSS
         hl9GCbDz0PU/WWzyPWxJuOjvtIRHABOykMcJhgqq/6jyFUrYWHRaoAElFZ3eiUSKEuii
         vNQPE24LjQw4WiZYXVH6fwAn/3IIoIhJvFWQ32VMUjSTAFGQCmsmoo0VmNPv1JKxqUAa
         JJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636895; x=1720241695;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D520IbA5iH9wzM7pzjt2vV2BsWgfCNVquMDfYzdLQl0=;
        b=PGsHSOog2d/EkT9Yu5ZXnjB5i5AAo8XAPejpxKYB4lELKV443Hr9VXtqL2M3pIt/Su
         db5zcoRoA/D5WpU+TOjphLbD8z3XCZfCE9J9Va6BlrGz9+jYbNtIBpCSVJ4Rk8GTFwGm
         uD2ZefKiw0I5qJpxzPWrzYEu48968SPs6e1UEM9/sChl/Z3i6RxtM74ClqpShl5DYVLH
         rpLFZBOxB/SOyWAQL06NmWXOSBiGc18ALyCQ+Dlp0eA5ov7w3tSepO1Dl9U2QulKFQWh
         fezK0FRsNzlY3sRdKTnC8x02GBwZmbBKVlmN2zeL4SXfvYrIFi+fiOUtyvda2RrhrUQr
         l6UA==
X-Forwarded-Encrypted: i=1; AJvYcCXoroLmT99c+8LNnVsWpX7Y82OxJpLZqMfdgxKEkRpEx2kN1ZdNcC5+z6EFGf4tNJCYZcnbbIzcDLMZhVyV3OhqFg8HsT575dxPbpzr+nu4eg==
X-Gm-Message-State: AOJu0YxYqmrrNw711E68VLpcmfxHG3q749DMt3VCugvGGkn9cQv5U29C
	8knTAitm5iNOJuCpl9bThOm4Gu3E8h24mRwVUi49oIwrqYedvtzAgm8Qjjk+PlCA8gFOoo2/ZqY
	F2xFWxw==
X-Google-Smtp-Source: AGHT+IHjGkctfrVaKHMf/S834AX9dLiEQUic95O2Gv5HigiTwS0uZAB3cdGsyXp40ykIKZIfie25wbvv2JJg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a0d:e885:0:b0:61c:89a4:dd5f with SMTP id
 00721157ae682-64c72b5434amr127907b3.0.1719636895234; Fri, 28 Jun 2024
 21:54:55 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:43 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-22-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 21/28] perf timechart: Use perf_tool__init
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
2.45.2.803.g4e1b14247a-goog

