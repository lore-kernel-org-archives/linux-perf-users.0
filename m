Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B53E78B4C
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 01:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264485; cv=none; b=vD7ME9NEU4olgOvLPmdDvXVN40HgTEv3LYY46XKy0gNn7IE6ZZmuUt7MQ5UxKomWq76hgz+gREGa0fHg2h6vfMCdItZTvuyDF05jkWe/vNwkMhCoyAnDohhffNmUH+6v702A2B9u/IvgDVGCN8IIRkLKg5/uABpWo9lEqQ4p/kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264485; c=relaxed/simple;
	bh=5n56mjuu2839fDPcAxqZPMwy+ARy/VmiiiMQ5jI5utQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=TJQLfcG4if4cut9a6OPlBBmhthe97Pm2wc7pkzVJ+xR0ZeN4f2E+OrBJ7TxbW6ZZIYuigsJYDGkIVGCqGgd/WWfIDhVRXh+k/38lPCL7qW/EfJUU/ibhMdOZat7LWGdMbZtYUN5qCjo55pY/xN8HAUdnGO4KILYamjHpdYhmrOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qKkev3AH; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qKkev3AH"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e05e3938a37so623455276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 18:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264483; x=1721869283; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fnEjjhiFWiWK1ZjHSoRI+4nKrjjHTPs3eA/kl5KV2XA=;
        b=qKkev3AHRMGFTYcPszyImhUit9bS01+xVUrJp1r8wDqpBZuqYLMOC9OfaoShQh+1Uk
         fQxqLC1BuftAWVIQjEtQs2FLTL0ZOtWUK/r9Y3sxw0mcEiM0VW+Lg9MlpVZXrHonFQ7B
         O/Bbu09/SGq5vYQmUQg/Hehht2/YTglioRhPuxH6/pGXjHPu4g+3y01DaQrujfcNCzL1
         uIECVrv7Homtr0taq6wgY18mBquBMlXj2r0Q88dbYOu4MoYdqV9IbzRg3doOPIOP3RSp
         imckauG5tHX6B/+E8kV/T4avJrn1Oed6APuoR9fvtZTGGVPOYTO8mf1NmcLKZCuNassi
         uakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264483; x=1721869283;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fnEjjhiFWiWK1ZjHSoRI+4nKrjjHTPs3eA/kl5KV2XA=;
        b=oJ6avmlSgWAMEufKLoutphBNjPM40nU31Zlj5Oyxn5tKI+sznFdSq/JSo2nJ3ELsK5
         QvZOtc4WIjwOMQ1scVUHPCAfHsyN1KhADAG9p0DQeHl4ydMHOuupA0k/lD7EY3WHvL5w
         RtLQDw0RXnbLpmA9L+aXsV+CRJgm12ycSqZX8g9/DFDFUm2uyYCIJmgW6G2TEKbY7ZCP
         FKpMFBYQSa8e2QzUb6uaBS8JTrseO08lm39nPSt6vwnaltf0mc0pZal65Swu390Ck5ZW
         awNMujrZ+/bRrQ+0c/c1GJgt/3MVyXZMLIwBqIsS42+/IJt1KC+9DFsdFZWEWy8POksn
         gxmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQgXe5uiSM2wMtl0Plb4CTbcjkFXu7HlytOsmChFUjA1bO/VsKCINCbwWHnR2cgZBsN9oekH5U/ccZxrTvbuA5psuUIfEgcl/HOunTZoY9eA==
X-Gm-Message-State: AOJu0YzV36WC7y0ptVvut5r/G62dyj7yKk8u8aZXEZtrQL6uzzeKKifm
	Dlv2XJVjpxOHvJlXfxMCdvBfMIOQbDjYfwoVfg7lFCAOOEqekeLq4+G72BCDvI00uLLH99mXb10
	i/f7O4w==
X-Google-Smtp-Source: AGHT+IGc02dcns067S/+Js+jqFzEtFv/PZyENgn6kRY6kp4H5xE8Md1QOSwjwqbLR9srevWvPq7mRSuwgOSG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a5b:885:0:b0:e03:5a51:382f with SMTP id
 3f1490d57ef6-e05fed80951mr2244276.8.1721264483228; Wed, 17 Jul 2024 18:01:23
 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:16 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 20/27] perf timechart: Use perf_tool__init
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
2.45.2.1089.g2a221341d9-goog

