Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D163C487A5
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Jun 2025 00:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749861679; cv=none; b=N6YrceYRgI/lNyM0UaxuHoCX/XgpshvsUytXcnaQdwA0IZKTwjBaF1uwqeVbLQ9Rczagk8AWIJ76bBYi2GFerZPZ9pnJZT8mYwRDU464KlAA4fnFXNyTv7ufP/ZRk3jqJ5XQMgMd6OyQaQ8SS59NgWPmtopxYnlr2NnmqtOHOTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749861679; c=relaxed/simple;
	bh=a+L2Z7m6yrJeoElkPd1IDjKuQkumW7pbFY2sHHN5KbQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=qSCwMkU5dX97zTT4lCSqDL5ET+y2eJBIllaJaf0Osa3T6GI1CplSY9pdJBUeX3vTmdozBhOD5fRD6nhTIDccT5lkw0K1FPatb8rJb9w5jS8wYEmioEcz77/iCtrjYq/xd9XwaUtd2BG4wGCj7VQv19xro8QWqWjar1M+2hcIoEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sni3e8n+; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sni3e8n+"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748269c6516so2237164b3a.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Jun 2025 17:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749861677; x=1750466477; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SuiEn9NXl10PYHeqkEYR4Z+695ojYBvc4TBV5HWCdzE=;
        b=sni3e8n+m357fQo0wRMUagK/BQZMyDiiw+9ynSAZGalo/P6988Wx+EoBkWWwqEeQQF
         T4TIWsmb8kiPQihKjD5x6i1YM3o6NPKHicysQChAebVqGdJCdqsHAuq6QPaxvp1sHNhm
         mxbppUlLRChO5JpqLashBW8LEm9WSnajaoNfZR9P60rFp0RsuFpGiqcysNVTNHh6vBFW
         SvOeKueyBQAJdcoS4Ui3oclnnQrU5dA4DOIJf4UY2NFFhh8jUSssV6Qr6LZyHMdjbCaE
         B/OiMsJQQiTj5pb07X0VOKuUC+cMBtz+asciEMLzUs+QIdw26xIMWTal+QR8CVQTz5QD
         LDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749861677; x=1750466477;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SuiEn9NXl10PYHeqkEYR4Z+695ojYBvc4TBV5HWCdzE=;
        b=oR0nXW2oXl58filAuDNj6wMjRDoHcLtEqmJjtkKEWZG4hS+S/tupO7opguKXVMy8Yw
         A7JE09/GoVnhpue0eWMHMes6ZSsSrzLU6OmTOq0oQvMzn1cqvw5WaYc0R0GbE0griPIK
         J1Vy4DQGBYwhRBn9H5HIlGc78gGKBiQj+/u4GgV64RlpAdKat+HKQSjMoX5RRhBHrnPF
         74sAsMEfPsmL5cjsdL25rUohR2wZO7+Jo/A1m9cGqFl7O2tK36W3WPXfNS9kfJpQbgOf
         zmwOTK9EB6GNFHhhgrawHrz9k9Bd92Vdo3CYW2wCPVty60LhMmLwRzLWCUZik++mKnTo
         cb5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoBqTN9loaaUMWx6yizHpZ5Vj8k3Vlhhr8yCw023vfKb4Z5xeH95v2NQk2cji/yH1psjhfNXgEb/IGS26i60nU@vger.kernel.org
X-Gm-Message-State: AOJu0YyfYNgcVG3HXrX1FTKhQAcG+duQiGVre10Q+z3aAB34NAH71E2t
	anHrdjLLTSf4sq1sd3O014V9EsKUrPjTwwXVOgZI4f3NlbWZsRzdu6+AxgMNy4YNhz0ZIfR7+d+
	YnIdc8Bh0oA==
X-Google-Smtp-Source: AGHT+IHuZV9bp7nrwHpq5xYnXAbpYpw2zYn1Ylbss6Q8IbL6tFEHFOnmA4J0mis/CLUtB2DMIKGEICqy5+vo
X-Received: from pffk19.prod.google.com ([2002:aa7:88d3:0:b0:747:b0ae:799b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4646:b0:736:5753:12f7
 with SMTP id d2e1a72fcca58-7489cdedcfamr1752865b3a.3.1749861677246; Fri, 13
 Jun 2025 17:41:17 -0700 (PDT)
Date: Fri, 13 Jun 2025 17:41:07 -0700
In-Reply-To: <20250614004108.1650988-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250614004108.1650988-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250614004108.1650988-4-irogers@google.com>
Subject: [PATCH v1 4/4] libperf evsel: In exit add missed puts and assert
 close, etc. were called
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, 
	Andi Kleen <ak@linux.intel.com>, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A missed evsel__close before evsel__delete was the source of leaking
perf events due to a hybrid test. Add asserts in debug builds so that
this shouldn't happen in the future. Add puts missing on the cpu map
and thread maps.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evsel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index c475319e2e41..2a85e0bfee1e 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -42,6 +42,12 @@ struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr)
 
 void perf_evsel__delete(struct perf_evsel *evsel)
 {
+	assert(evsel->fd == NULL);  /* If not fds were not closed. */
+	assert(evsel->mmap == NULL); /* If not munmap wasn't called. */
+	assert(evsel->sample_id == NULL); /* If not free_id wasn't called. */
+	perf_cpu_map__put(evsel->cpus);
+	perf_cpu_map__put(evsel->own_cpus);
+	perf_thread_map__put(evsel->threads);
 	free(evsel);
 }
 
-- 
2.50.0.rc1.591.g9c95f17f64-goog

