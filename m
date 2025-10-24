Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B47348471
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328757; cv=none; b=OwojyercUReJtWF1k8PMfPTkUF5AzeeZuKss6LRDVc7/xefrgIgvDLar/ipAO6IqBgjQwEjLCP4IaVZaaWmiAIEQP2ErlaQh3drMTZuKJ0hnQ8Ud7ip6oXd/0vOvbd+5FArI0niX0PphTY+Lt+5anOQj9+/mTdOWkUP0MIBGsRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328757; c=relaxed/simple;
	bh=9/epWOlvqRElvVAYkJLo+3zLaR28RumkRGXocbmxMUo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XdZlMKivLbZkpSfHMY8nJFPHuSv3iCD1WTk5g6qs5y/YNNC30XCLUNAaCCI5X7tJ2YJ/OmMWCq9fYPYkPwbEzRYZSmyELWltj29Bs1hVNjrS67ENmtq9RpiZZNZbTIyM2K1X3F3YBDgyyA1btsG6L0gRENL7+QBEtenYtLFXJIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J3AKIj8r; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J3AKIj8r"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33dadf7c5beso2156496a91.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 10:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328755; x=1761933555; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=APc54Tj3AQGNHWIUCnd6bMLg8AtBQwOaMT/IoX0GM6E=;
        b=J3AKIj8rfNUPwYC0wL2uniOeVPOnWuZKfrfIM1GjmbG5/6wU5HNBFaQj6GRuzLaa88
         5pzOFcUtliJmkx2xl2r4urdJwQRRTP4mAUfS3zqMtsEsmok4Bn3WgZtZUTR6yTtpvPtI
         5u3vyF2L/KFEUltnLDiF061ou5Oibb0PBbMnZ0SPDE6PK9TcAVBc6VIRdWvQWTWoiQFu
         4aRxNC47flr/qS4MIoKoJ5GlCcQ9opNemAYftCTO7Mzl7zRCHxwFdO3ra/XARTOIHiWH
         /QhvyhKpv016k0B2NnLsEKdQCt27j5rGr/cnMs6HA9e4BmaRKkbpqEA53O7qa2in5cfu
         2eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328755; x=1761933555;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=APc54Tj3AQGNHWIUCnd6bMLg8AtBQwOaMT/IoX0GM6E=;
        b=pnL723iOer6nAVnOr6iNOOra2jjaz0F1365HBRbuH/MWTWwRyk/eVdJ2jcinhZ0SBS
         W0hixgEJDBBkvmqdd1TGiU53KG8z9J1uTz7yg+soX61F2OAqFuMOwZ/lCAJy1hTO1ruR
         6ea1/CYUVNZIeAGVq5feufVz5iOaJH5udHJcPW5QJFIVmJMvbDxK4Bcjr0ScWE9nk7uD
         gZFUPJwR5kRPBfOSZtuM8O4MXZRgcNhOSRSeSJ85RA1PiwQOK32ZRxXN7qOA4LjuFgu1
         PDujHFHaqwsFjhjzI89gVF1ZfKSuh68ID18DXSRA49D8tlRwrV2NWHD7Je4PthUKyro3
         +wAg==
X-Forwarded-Encrypted: i=1; AJvYcCVGJWR2VGu3jBdrZWK2pUZZfDEeCpZVATYDpNZbcAbBRQPdyualiwx0Dbqrc9GvAQfGaviGdkj3kno/SsJmyeS9@vger.kernel.org
X-Gm-Message-State: AOJu0YxySKScH22IjVGepP29RTIjB5OF/lnym10snEVaQ516rqL9rm7J
	stzS77ae3rqxfdVsHgAwigPQ7FOTwqK2L7CfLDeFtq3EOoz0hBNPrV3pVUgob7yDGi63Jps4h96
	o8F3t/IsqbQ==
X-Google-Smtp-Source: AGHT+IEN1iYOPYV7RXFzzvFzF07chEYfhJgksicY9whr0oTjDXk5EpLLJoQwOutmfEvwxm3VlnvXeCyC0ic8
X-Received: from pjbjz8.prod.google.com ([2002:a17:90b:14c8:b0:33b:dbe2:7682])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b4b:b0:33b:c20a:35e0
 with SMTP id 98e67ed59e1d1-33bcf90c1d3mr34702592a91.30.1761328755526; Fri, 24
 Oct 2025 10:59:15 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:42 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-8-irogers@google.com>
Subject: [PATCH v1 07/22] perf expr: Add #target_cpu literal
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For CPU nanoseconds a lot of the stat-shadow metrics use either
task-clock or cpu-clock, the latter being used when
target__has_cpu. Add a #target_cpu literal so that json metrics can
perform the same test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 7fda0ff89c16..4df56f2b283d 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -409,6 +409,9 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
 	} else if (!strcmp("#core_wide", literal)) {
 		result = core_wide(ctx->system_wide, ctx->user_requested_cpu_list)
 			? 1.0 : 0.0;
+	} else if (!strcmp("#target_cpu", literal)) {
+		result = (ctx->system_wide || ctx->user_requested_cpu_list)
+			? 1.0 : 0.0;
 	} else {
 		pr_err("Unrecognized literal '%s'", literal);
 	}
-- 
2.51.1.821.gb6fe4d2222-goog

