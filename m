Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ED21F3D23
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436596; cv=none; b=ajcNQK5PwABL4vcGf2zDV4mi9eqM1S6iwP2yGB5v4MVQNXcBRdPTMcPSmlo4owoxIpGZNHQPQHzOJmfPWumdTXCMS4hh04njbnI5f29jbPp8/VLL4OjX29iNioXpIp5ewMVrkq9deK545o23kDC+K0Mh/hFiOQi6i94JbF8xmUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436596; c=relaxed/simple;
	bh=EXhJJH3GTtw0Pc2COLLlPSCssK0z09b5q0z1Po3tSGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cyAyNeqpMq8cVMsAaDGw++HVHUwaxO35ghTJVA0QzKOf8/tjp8BtSNwoxqU0zkBKdd+T/DD2ID3uGNc4/mWscG+f3blwdKhAFVjWOoWgJOP5I5gSlBY0n1NlZKqwZ0n83GDaka0d61NJd9zS7j75Q4Vxo7DzRj15uvFIknelogI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A2/WpRPy; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A2/WpRPy"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso36324395e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 03:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734436593; x=1735041393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52uSj8E/aVB15WhaSRtD8CBQxo0ybh/UWrgjS+bPGCI=;
        b=A2/WpRPy+ASNIgFlgSyQbT+bufsa7Op61vm4V/XpNAp0LTeiXKNxLxu2jouc/FbYkZ
         oDbg51WJEWVqKsqq6/GHX1SLNgK0aN5dh/g8T801tSMCHgjPFaWJpu2JBGrRpy2uZy29
         xr7bQdluI4Mag7hQ+vSKrvAP2llNX3k1rgE7exEcB7G5CuMZ8peOzEN11QnAiPZyiOOk
         BnFjTkKANCG3sjLr7rOyKZfn/k0m/X8h6aplZJw/oi7FxkanhL3vEFXIp0eBh4OmG8Z8
         IiXUXyIVkOhtQG+8oAME1ETFaaemi7sdNjp2fghmr6BKlpWMOOUAlgSgz8x3cBLnsxb5
         O9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734436593; x=1735041393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52uSj8E/aVB15WhaSRtD8CBQxo0ybh/UWrgjS+bPGCI=;
        b=gof1XuimaJlT8V5vmXq5gadYpq+J0Ofg4OfY9P/qV60VQXjocOMrerq1juQkjMienU
         EDkYWMNDNghhdnqLsMs5XrSo8FZ9yVQ50q4jsyWqFexq/eGvQdi62jJCapYfXTmDAA9F
         UnD87Q9xjVQJz2XA5VM2poJQm5czRvvXTOeuAxWCOYp4EOehfOTLyZw0FxqCL6w9VokJ
         CC52AQTxOJaK2+Vh2iWSxh919gfuDpdxBYuO6HDr+IoQx6wQZihnOR4OfVnpngHfLKJp
         6st1PPPO+LkeB8WRAjISFnaervgaPuYS6vXmjRZHy6a1uFis03c5jVBgh+3V7aL/rRl5
         eyhg==
X-Forwarded-Encrypted: i=1; AJvYcCXmHtam/7O8nmPPMrblxSDNXwza9eaaJSqJQpgGpyE/aUVa+xPSvAMnl5b/7vynj/sApJufJPavsG0olPenx8Kl@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6w9MdyeKdZCp8UHg9nUHfwWNXHPLd/ah1y7BOCYBWTqLh9mSN
	1U2tSE6Y2P/4qEHkw8MrFdhni9DzxeXq68H4Mfdp7/wHhlj+boAW618blydKzFw=
X-Gm-Gg: ASbGncuFk+jKHRFy1EuCddZiWrBD4f2Cz/0UEJVMd0eOvNK7Nrt5JRJefGFzcdqt47d
	4fl92ByI4mldat9jEHHvDP8+SuJjbfC/liHxJKnYH0azwTD1eod4eCbDjxEhjZ43gKcMavneZfO
	8RoqjxD4ZGz5adpMAC/I6JQ9m8Cn9ppQLFsYoH3w2QHxHVJAZRz4FQaJ6KJH6/xttsM0VpVVnl8
	OXAgaTxgjjnby+0TmG/tacgFRMtAF7XVgG358wGkKKuHPWi2ON3YAJ3
X-Google-Smtp-Source: AGHT+IH2s5qUAf+fpkuqgPU2+mVf7/GWHrtm3hb2i29uW1limYKT3R5Wn/YlSCwzGGbUSzG/NCKU+A==
X-Received: by 2002:a05:600c:b95:b0:434:9c1b:b36a with SMTP id 5b1f17b1804b1-4362aa2e539mr159531685e9.13.1734436593037;
        Tue, 17 Dec 2024 03:56:33 -0800 (PST)
Received: from pop-os.. ([145.224.66.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436360159aasm114935825e9.6.2024.12.17.03.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:56:32 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Graham Woodward <graham.woodward@arm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 3/5] perf tool: arm-spe: Don't allocate buffer or tracking event in discard mode
Date: Tue, 17 Dec 2024 11:56:06 +0000
Message-Id: <20241217115610.371755-4-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217115610.371755-1-james.clark@linaro.org>
References: <20241217115610.371755-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The buffer will never be written to so don't bother allocating it. The
tracking event is also not required.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 1b543855f206..4301181b8e45 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -376,7 +376,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 			container_of(itr, struct arm_spe_recording, itr);
 	struct evsel *evsel, *tmp;
 	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
-
+	bool discard = false;
 	int err;
 
 	sper->evlist = evlist;
@@ -396,10 +396,17 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 		return 0;
 
 	evlist__for_each_entry_safe(evlist, tmp, evsel) {
-		if (evsel__is_aux_event(evsel))
+		if (evsel__is_aux_event(evsel)) {
 			arm_spe_setup_evsel(evsel, cpus);
+			if (evsel->core.attr.config &
+			    perf_pmu__format_bits(evsel->pmu, "discard"))
+				discard = true;
+		}
 	}
 
+	if (discard)
+		return 0;
+
 	err = arm_spe_setup_aux_buffer(opts);
 	if (err)
 		return err;
-- 
2.34.1

