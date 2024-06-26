Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF6D198826
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 20:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434254; cv=none; b=TYaS6KNktzue7laCxDEbqeUI8R40+s5nLkDasuICiiIW14Aa0ZAP7pP4x9cVOoAU1GLgsznNR51MCZgSoM2IGybBFobbel5A9tK3Z8U8CQrQvhVSv4KU9sBboTURYEdVVi0UNnuAmpbjW6ZhvaxBAHOjLSSi4ZifSNVRUmnIVcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434254; c=relaxed/simple;
	bh=4hregmkychdDNk+jks/Rw8XVYDtpylXDSeaooVz7NiM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=aaJ3bFOBJEUmHEmKEPiPl5l3i3mVfGD4Wa8ERFXu3W1NRG4Y7BUuS3kNxj8aaEAme/00BAEQv0yPqhW2bl8S5C5oiCySfVVZdV6gOfPJ8M+6aMHkHWyXfx+ugkS9YYUIYXpU07hvWZB0hIis+N0ZQFfomgy5g1UF9CnmPX2Jxuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3NGhoZgj; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3NGhoZgj"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62d054b1ceeso146328307b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 13:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434252; x=1720039052; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gHFcPRP+yhEWi0robOtIeOpLSabhSBGQ4xXRLMmGCaI=;
        b=3NGhoZgjQqk4W2wO9UoDeg9Z4eZuv2ksqQ36zy/zczw0KWTg3MSVqn9ocB7luMuLow
         qDiEdCRSBnIIkBnGNIsp5kFKnKiO6xnyasCC34kUhdxBLL6R4arje4VEL8p1Wx2lUvDv
         JldMvLUiyFIjQwAzph0xjCZln6VWWQOkksYIS7mBLLTyg5ShV0fmcqq9fE4qEBhV+Sec
         mM87bWICpGEn1y6mnU90k3HAzE+SbY2la3mMM3APFzJBxp0/vWKF+X9Q6nAIovBrCQA4
         uVh2Ql7UcoeZ65tmla25Zs/NuWRcoq3adYgGohnkRXIlGd19Ja40fyaGIivITL7Qyyxq
         G8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434252; x=1720039052;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHFcPRP+yhEWi0robOtIeOpLSabhSBGQ4xXRLMmGCaI=;
        b=mE3MHu0VRNQbaVWtbNofkLqCqCwy/+LJ12I+U6sil8FEnV53K+PbM347vVR2w62Gu+
         7pj96AAkKI4ywCx4UzT2gDK4FsSrRmciJ/Jmvtfpnd7MdC/G8lJTHOCxRyrzstIIlGV1
         XcDWFDzAm/XAs843KreuPrEKzVeirTJkQTHCxHVs/KqZDpfyedt4zoLbI5LoZwU7M7NQ
         qFMEdwYxZsfWIQRhglUXu+450afmfd4rw/fEQJslKn1Dstskg46ON78AnWPfLEj88esT
         MiwBgwqQnZQ7I8GeN2hBfG9qh+vHa7i35RhLjrbZp/16Iv2NEkanu1k/tCkcZcOC9WFi
         fyYw==
X-Forwarded-Encrypted: i=1; AJvYcCWvqxhDe4G/5BJwfhc/+743a5zg9ZLy4KnzPyofSUe240OGPGEgVxnz/8QaxIrgrRWAWwUtqbiCDVyelaunZ0So85f6jAjRtcn3LulCCzH41A==
X-Gm-Message-State: AOJu0YwT2gy0MTYALSflxsD2HE2zP2J8NL1GPGDl2ebgUQKlUxzTRm8I
	cZpyDOQ2FM5Pr1NAl5wn71iixaBd4w9vRZDuUIJ/J4xtIKytNYvAc3wDfR1RhgxvVwmsK8fTjcn
	QBXnxJQ==
X-Google-Smtp-Source: AGHT+IFJh90xA5zR81k/YAgHE8/x6XRCvuJUZgC/JjDthtGxwm0XkkDH8GPDxtXF5TzDpmTRTDcsIafOISw2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b12:b0:e02:ce2f:cf07 with SMTP
 id 3f1490d57ef6-e0303f2a6a8mr38528276.5.1719434252090; Wed, 26 Jun 2024
 13:37:32 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:25 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-24-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 23/27] perf data convert ctf: Use perf_tool__init
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
2.45.2.741.gdbec12cfda-goog

