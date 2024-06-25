Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B676517FAA0
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336420; cv=none; b=hkBTvUJnAh9PKh10X6dZA6Kx/5DR/VBmFr1bErh4QDLW8HbRpgWq/F7+y6u1qIbVaQcb5PnS+dnGJ3g9/XSfyO8GM8PfhRTukSQ6IzRbtRPfcFn8jyCAB/KM89VGZ0iEM2GbORq0/SjTldXL5mVhvqz+RZDdw/ZtZSVZZM/b0V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336420; c=relaxed/simple;
	bh=4hregmkychdDNk+jks/Rw8XVYDtpylXDSeaooVz7NiM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=CHVvMgCGMF+EtKwZwOh/ssRg14Lr5oz5U65jglWAm8E0q3GKdj7TXfHAv2vt3nGRdSCTTwdgJLV7ku0tbtREMOyGP5fU0bXj0G0D4bwhqZ6/rKXHZKelDKXtkq3l4u4THA67gbylHL/ZD5GXN5+v0VD6h4YXFHd9V7VwTIg0wIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QUJJjSQT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QUJJjSQT"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-63bf44b87d4so65863567b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 10:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336418; x=1719941218; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gHFcPRP+yhEWi0robOtIeOpLSabhSBGQ4xXRLMmGCaI=;
        b=QUJJjSQTRGaH8kLEMb0P8zFB2ZHrIoOkZmyaSjztNUhAiQ4ycXqvTCL1BetmRaUpyw
         AW70+Od8RusFnWsCl81aAL3IuZqxu+5sJrTZSzAQ4v39ww3GKpY8rXk/7StZGgaBPVBm
         P8qxf5i8ds9m+UnZUdUNB5ZYQokzV43pDY2mFLiKf8s+Az6AbORjOKsCH5Ewj9hu65TI
         ZrBV6NXa5xNFwNJolbweQkaaWAuVKQ4wWJ8u4PwNlsZ2Bkfx7kbDOpEj1eRhSaFyvCLm
         Xs1JrZ6OVHS4tU0TteYNwPXi4Bi+yW1v6PTwvgZg75bMeeYwt39p6GaWtXvF/ULQ+jhA
         ouYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336418; x=1719941218;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHFcPRP+yhEWi0robOtIeOpLSabhSBGQ4xXRLMmGCaI=;
        b=NKLbTp3/F4+TgYBrF1+33yi11Rw9ii5icxbX9/pIVJS+1K2HFs+JCCLbu+NlpFE5tf
         Grk3RnNkRQXlhKNMOjkoxI4iTIpy8lK88oA3AayQSQkgBDsikeZJFKUzkoKV/fF5yPYj
         /JiuJJr2mmQd3Kt5NnFcxi0TWs020SdHBRLzQ1U9+aAZKQyuQLstLQTscUeZMJd2lDoo
         OYnuACC1c0LXvVDLeFxlDsF9lMmc+lu55IuR0q3Bs1iPVSewF1dECXr3AX6qEgWt5BfC
         bRIoaokNW3+Jk8tGAUQk3Z1HcdzBkNAFgMwbRhW9zpw2uzN831J/Qv98CPJbe1jWDEpP
         ey9g==
X-Forwarded-Encrypted: i=1; AJvYcCWmGl1w3LsY3sf0HvsrS+hPCZzhKKgevEzHGG5aJDVhhMWswLpqqVHTX5BUhyTSg1LbPKbdjgAlPVM1Ut/E1zZW0OReIn2Bb236DkPcPBiWMQ==
X-Gm-Message-State: AOJu0YyEfhmEgWk25B8MvGPRZXhitVdaikIpIryKvrqSTNNHzAUqTGzu
	56OWvFUEXEvSxE/uogrkN3F77IY3PFsGse+fr1iT3itMTxsfKdo0/vC55KOR5+cLDCK75QvixLr
	/00Ixfw==
X-Google-Smtp-Source: AGHT+IHvubIUZhjEok3/V/kgZ7MsIbdXa2+oaKX/HdJ6s7+Z2Phn78YjiEcP/gWbJXNedxraCdMON4nnJvNd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a81:ad12:0:b0:627:edcb:cbe2 with SMTP id
 00721157ae682-6424dc5e95emr531847b3.5.1719336417810; Tue, 25 Jun 2024
 10:26:57 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:25:58 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-22-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 21/26] perf data convert ctf: Use perf_tool__init
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

