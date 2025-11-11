Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67943271F5
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 21:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896144; cv=none; b=hNE1CzKZA3KQarnK4LSoTfiawWPTYCbJq2Z5g4wCeOFI5sm3Xw5X2TcvH/EmUPXjC6PuQnJCTiiMoAFzfoR5lmXyQ5m6uSYqyryfzmOv7zfqJOI8ELfHJhuw4205MTKx/hWMKx1e5nMVru05hIMHGFcGpPWmB/3wCGH3YC1wfOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896144; c=relaxed/simple;
	bh=goAJRIvcXmArqjtsnCnAKiuCo6RWRhzBbuO89gkopnI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=sL//oi+QyA85FXoOCebR6SoJknWjwnZmozNRRUlGLie8bLPqC0rMxYdc/L7SVxa/T2OEf4H4NgcgHA3Bc85k+luJvA+vjTbydJb1Xmo+q3e7uY9onD1KazC0ENvmJV060fVkEmH/hpbjAKGFmnA7veo8b5FUY4fnmZ+J2hdFihs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zWY0eQgw; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zWY0eQgw"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b99763210e5so125909a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 13:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762896142; x=1763500942; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+kfrvj9SxzyHWG3QRMI04WWVn93aXW9NO85HAoMrUfM=;
        b=zWY0eQgwHBbKvUkZgBVIWGVj9ATbzvAstAwF1/ucjS7uMGhBYr0Ts7Qh8c8KZ1ueIG
         itvHl7wMSLtbvPe+QQF1kQpuWES6eetgOfegwgVUQtrCNynjOqS6JhfQ/m2IzCvgjkge
         YYKUwPuEL+Z1lT2sxIgbntQ1y9i1xY+Jvj7viMBFl1q3aymKNEKOF0GRqf1xiwqKai30
         UdEJm/3SfBaqwXPPEtcAt0BqSnbKSC9kDDsL6SDQpGEVP6IKX+SL+FSKgnVovf1faFd8
         6a7ynV64pTxSEBAu3+UzQRb0WNhUGHkr+dfl2ByysQ4qdVVZVAx+g5tQTXKuWdjVVwwH
         YugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762896142; x=1763500942;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+kfrvj9SxzyHWG3QRMI04WWVn93aXW9NO85HAoMrUfM=;
        b=dh34abhDkqNbaVsCV0Myodmj4ti4uxsf1RbOVOXrcgCFVPsAFU9xbJ8OWF8joxarDQ
         sYSkFdhFX/sKjkpEyRbxM4XZ+4152CQTRNsWhoMfF9FOghjnIH0QolhgUKgxDwauZNDJ
         YovVVuP+XFHqbui4gwJy+UZslftoIeT0VNkBzTdraD0MGx7KyXflhtBemzbAx9Va77ul
         +fC1rTscDMIpIcVlAwj7WZDevB1y3j4nLYLUT3EA1w+rXU6DSs8eRzqZBc1Cf53MBCTz
         lDGsv9TpPwU6b37M4+0HyoywhPTUVa5LcQ/zqy2sy9Q0KysW4GxlCJ11FejUdyRqJKpr
         Z6zQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5n8yyXmvLsg2TU38he+bNoXa2spb/E2VYWJMWn1PFfMx1T6zY+hWxuw5oVScu2wHdOSAqrOv4CZDVPgo9J++x@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+dpkuDzQ9cUoVnPnQWZcgMsuVP0TFfI7tlYjdw75L92eZ7XqJ
	+E8VSCwCBahNdKksJSmVCyhGe0Aok9FReY9r0XTLbEOs7eQFqbP6wNj7dYQViPyC6kbnAYxUZ1T
	b8R7jaKepXA==
X-Google-Smtp-Source: AGHT+IE+tdMBRjGe3JlN3IgFcsRDYYGZOFWHmqPeeZFPCkAD0xTkiW67mE3P/N7wAsvMPgn+Y8w0Dl2tcRh3
X-Received: from dlbcy19.prod.google.com ([2002:a05:7022:b93:b0:119:49ca:6baa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da4b:b0:297:c0f0:42b3
 with SMTP id d9443c01a7336-2984ed4b960mr9193215ad.25.1762896141827; Tue, 11
 Nov 2025 13:22:21 -0800 (PST)
Date: Tue, 11 Nov 2025 13:21:50 -0800
In-Reply-To: <20251111212206.631711-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111212206.631711-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111212206.631711-3-irogers@google.com>
Subject: [PATCH v4 02/18] perf expr: Add #target_cpu literal
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
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
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
2.51.2.1041.gc1ab5b90ca-goog

