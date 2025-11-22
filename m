Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFE72E5B32
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763799584; cv=none; b=GHGLhn1ojGmGHFl4r82/eeALyEeuSwTcZO1xd1G0AZN4krK5wWtlUWeMwn93rp/g9TIyNvVhXItGQSwn65zieZLIy6rfa6oZ2rvjZTzo+KXGzqvycVYxk9L+PURGZDj6Vtt1EaYJT9DJQrzzpgCfzexPim4beWcqyfYHkP8p67w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763799584; c=relaxed/simple;
	bh=sx7HYHks3ytj7Jes2KeHQ4gHIyvcIcsZS20MoUx3Rf0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Af80X0i3FI2fvnRNcKqCQqFTFLrqm/m9U/5GOVKrhoFG1aOYE0nVH94mchu9hbKqOwkxEqU/57U89vbxcO8994vhbTzzDmRjjxtzq0/LPd95jqZEyrw5Vn4JL79UDweyMxxKEVThsWS5IAI+/1e6QZe3GIAbZSPUE/xahPoZFRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E/hSQFwa; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E/hSQFwa"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b8973c4608so8715931b3a.3
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 00:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763799581; x=1764404381; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PfPxaYlK1t4toeHzJ2SOIsfB7c+WhL2RCiW1BSoMqL4=;
        b=E/hSQFwaGPK27GWjYueiFil4TFWSv+2NngqQk4L1KnmqSYgl08DHa0B/9xPUGn6a02
         7vUVhu2aSZJYuKSRi7XJ7dl15MPWmQ3Uar7UwkTApSntlUqWWpDXZLgpo8bxCi7koXuO
         8TkAdyDMdBHlDtbUrLWArodUhhlvUC2fK/z3dTrfDkcnSFF8mNcqYu29NyOKfu49C9gJ
         gu5GcMqk9IlavMqT3XUd4nIkx7Mn4NdFXYV1ayHc8Okg3P3EanEtWebt7Sp0vTeKqTmw
         x2IdtcRacR4dJ6G1IgzyHhPEWtC5nAHIHqQ2HkRBso5viPhXmUGuwd70MhdRDKHrhcv5
         i2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763799581; x=1764404381;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PfPxaYlK1t4toeHzJ2SOIsfB7c+WhL2RCiW1BSoMqL4=;
        b=OJX9/LQd1niyRHgAaTYkCNLlbfvaGPQMMfgNDsUZTxW8H6Jm852p13hA8879zn8oCk
         5nLO8gOJATUFAwrFncYbeikySvUP1lRdfxCFKyQJi7PBl+rSNMkCNory5gZRkQ8ZcBLe
         /qJ6UzuECk/ljIfq5DCzbX7lYSiji6MtLGrJZpwI5DebA4JtuSpLDAb3fYzpCALrK3CX
         rXpVJLPGqixMk3yfRjo5JCTYu3YTsKz8LL8la9S1zzW6Wfn/OtvS40qcstvj5VLni7fM
         MPHgBwjb5xamMI/Hh9TwFUjMeZHB7pFgZwHL4XxZRVEAvJCZcder8ZL7METhwOG6pe7O
         djFw==
X-Forwarded-Encrypted: i=1; AJvYcCXVcyoVIP6hXPahDIbOoaiv1v1BjTY/N1VoF+M4Zcj3bUAigOhfLlCpvc4uyuWs1wEGaBoxeTQ4lKIh4tzEDEy3@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5AhwZWc/KFZ6eOtBM/CqEtKuDq5BOtzQUK+jfqlZ+kuzyf+1i
	QeVl5jBuCtZ7OcSewgAsVBZOm+WRCY5gj4qS1+bwddoYTjo0bUk6/5x/dKtLCd3G2llC9w7OHo6
	5HMDbLHLuvw==
X-Google-Smtp-Source: AGHT+IG0rfZfyZv/KsW4SMkzha2L2s97MUZn6ZWmw1Xt/qrPrIa8qfuUMlZTN5DccGBLCB/Kg+hUvS2kXAQC
X-Received: from pgmj1.prod.google.com ([2002:a63:5941:0:b0:bd9:a349:94b1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:938c:b0:350:9b6b:8ea8
 with SMTP id adf61e73a8af0-3614ee6bb4cmr7151492637.51.1763799581068; Sat, 22
 Nov 2025 00:19:41 -0800 (PST)
Date: Sat, 22 Nov 2025 00:19:15 -0800
In-Reply-To: <20251122081929.7588-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251122081929.7588-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251122081929.7588-4-irogers@google.com>
Subject: [PATCH v1 03/17] perf symbol-elf: Add missing puts on error path
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In dso__process_kernel_symbol if inserting a map fails, probably
ENOMEM, then the reference count puts were missing on the dso and map.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol-elf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 9e820599bab3..4c76e680b13d 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1446,8 +1446,11 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 			map__set_mapping_type(curr_map, MAPPING_TYPE__IDENTITY);
 		}
 		dso__set_symtab_type(curr_dso, dso__symtab_type(dso));
-		if (maps__insert(kmaps, curr_map))
+		if (maps__insert(kmaps, curr_map)) {
+			dso__put(curr_dso);
+			map__put(curr_map);
 			return -1;
+		}
 		dsos__add(&maps__machine(kmaps)->dsos, curr_dso);
 		dso__set_loaded(curr_dso);
 		dso__put(*curr_dsop);
-- 
2.52.0.rc2.455.g230fcf2819-goog

