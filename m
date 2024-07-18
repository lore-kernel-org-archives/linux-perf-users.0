Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968E080045
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 01:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264493; cv=none; b=BsLqtG/XMb2IOPBqAafXxpAY3/sBMoa8HgQypCtB9VhOK551+yA6gBSBzM75nwYgQkW0BzebrnWavHkKhpkn4EwfKW0QJgVEV0CcuCg8ReHPfhYj8+QXIteWQClRBH0Nes+AY1U7jkx7bK0gedK+tq7ZEKQGj+mKiYW5asLJj+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264493; c=relaxed/simple;
	bh=cmLg3dO793Vu8RRjxUPuYw4PgNi/G99PcpLXCc/ZGCo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=VtZ9cDrLliVFXH2d68e2ZvofGnBkNSp5o331Lyn5phY8BGURKciS/btBiG9eDzbzh8m0Sd5aD0XUKtJ0AdMyW8K+K9BzNSfJpmnNQ1tJpnKpwmBvxyBj1i/LNP0vkVxdtEX6voyVXbuSFqxwPfODzjoU9Xc3euThL6fNGr+7f6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MA4DcuZc; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MA4DcuZc"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-666010fb35cso5204727b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 18:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264490; x=1721869290; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Clkf8d2hIy3r9JhAIXh+9vb9zWkbL7cEj4ImfbK/zRA=;
        b=MA4DcuZcWGdqDM1AW+3Y/o2/J3M7yo4YWw/Cj0fT0yo5AwcPqSfZ0kOwHp+rErHw2o
         3mjEtCNz1nkT4jLWW2e+T2LvQ6sloUuR4dLiwDq0LavAkUDFdK0bnjFRqK52+9eA68v+
         SFWJUvTyVTPBqxDCm2u1e0hgDalKUahzdTHH6nAOEItLcrat4uxYy7ch8dCcmKiYHgrb
         ZkAGBiYfJBDGydY+LtITroMfDHT5gdY7dA8NaEmn7mvF5hmfuZhlCTD+PC1SZOQUb5CI
         xfPRua1tG+C2EozP5gTf7Dhe8LGtQoOAm8KLOjUgbHlG44mB9pBWo25qRQ2qRLJC7QJ/
         xmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264490; x=1721869290;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Clkf8d2hIy3r9JhAIXh+9vb9zWkbL7cEj4ImfbK/zRA=;
        b=HZWxjLG8eC7LV4SOrUOzuv7lm6awAugYcmWu53RYSbyJOFNNdMKSHbHR+26GS3Tdk9
         btlfrbtHjZ2jubkGMm8heHoqiz8kKqmZoKdaikSwzC6k20jxKCFh39uU2tkYwPWZb4HY
         nUEjTYoF980GW5KejgpSl5DVGRXv85egQwgnQo2ZrfQZxz2EvtIppPbZRWEWo+bvoeqr
         Rl63iv0fQOBOUwq++hZrnzFcJxep157Ey6PNGCasFo+bCV0CMFo7ScR4ucSjbOH9c1wW
         chom3NVMY/QJmn/BuzJ6FbbvQ6h1Fu4HXHNX/RHsE9/1kph7kH4Dk8gfAPt8VaoNBNOS
         mCtA==
X-Forwarded-Encrypted: i=1; AJvYcCXwpnti6ap5ZXYgCooyZQ3UPlmK7N6+ReRTz1XdISrhQ+YbzriwzShlb8dFl+JqEHWfyEObn8vSh0kX/QvPLHr2szzNAMhoSM4oKKETLZH6HA==
X-Gm-Message-State: AOJu0YxaR8Lbgv5cMxr4ve/hdz80gh1gqFsmtekv5pGllqNw1kf4lFyw
	bvolDirEBFgUXfnE2ENIq0TZJWs5IWKx/nXFGnxelJk/GD26U6QPJFMerDhMFPuNfpob9lCfJAO
	69/Wxhg==
X-Google-Smtp-Source: AGHT+IG3uW51DaI0jwt64D2aVkFsd0oCKXhiJ/qB6/tX+ACDLixR+siknXwDm1ELbOkMHzZQc1ESlEtW9OiS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:690c:2b04:b0:665:7b0d:ed27 with SMTP
 id 00721157ae682-66608017be9mr125757b3.2.1721264489810; Wed, 17 Jul 2024
 18:01:29 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:19 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-24-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 23/27] perf data convert ctf: Use perf_tool__init
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
 tools/perf/util/data-convert-bt.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 9e2170604b66..021e9b1d5cc5 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1607,25 +1607,23 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 		.mode      = PERF_DATA_MODE_READ,
 		.force     = opts->force,
 	};
-	struct convert c = {
-		.tool = {
-			.sample          = process_sample_event,
-			.mmap            = perf_event__process_mmap,
-			.mmap2           = perf_event__process_mmap2,
-			.comm            = perf_event__process_comm,
-			.exit            = perf_event__process_exit,
-			.fork            = perf_event__process_fork,
-			.lost            = perf_event__process_lost,
-			.tracing_data    = perf_event__process_tracing_data,
-			.build_id        = perf_event__process_build_id,
-			.namespaces      = perf_event__process_namespaces,
-			.ordered_events  = true,
-			.ordering_requires_timestamps = true,
-		},
-	};
+	struct convert c = {};
 	struct ctf_writer *cw = &c.writer;
 	int err;
 
+	perf_tool__init(&c.tool, /*ordered_events=*/true);
+	c.tool.sample          = process_sample_event;
+	c.tool.mmap            = perf_event__process_mmap;
+	c.tool.mmap2           = perf_event__process_mmap2;
+	c.tool.comm            = perf_event__process_comm;
+	c.tool.exit            = perf_event__process_exit;
+	c.tool.fork            = perf_event__process_fork;
+	c.tool.lost            = perf_event__process_lost;
+	c.tool.tracing_data    = perf_event__process_tracing_data;
+	c.tool.build_id        = perf_event__process_build_id;
+	c.tool.namespaces      = perf_event__process_namespaces;
+	c.tool.ordering_requires_timestamps = true;
+
 	if (opts->all) {
 		c.tool.comm = process_comm_event;
 		c.tool.exit = process_exit_event;
-- 
2.45.2.1089.g2a221341d9-goog

