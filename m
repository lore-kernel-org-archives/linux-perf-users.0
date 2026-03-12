Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9E22459EA
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 22:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773354697; cv=none; b=P0dmqTAkqaAdIvS/2kBRwxW/SAc5Fr1biZqOoDRIy78TpvGqaSNggg1DIYm8l2KZM8QQMk9Ra1cOGEcBs5yOD99LdL7LOqIF+hCXtyBn0RNOXxq/wZcDd3lnmX90Yf+A8n9XA6OnmZ7yQePMjoA7gTrrnPE6ruCwhY440sBPZTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773354697; c=relaxed/simple;
	bh=QQ3dviOlS/QKwOAue1T9KEs16UskwW92wS4vygLVkM0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=PVdwxRDcMYlz/rl0anclil2lzfdBPXYLa9QYSeK+Z60/gChtmu6PJKAX6Nb1HtQQteg4zOlGgCSk1ws+mkT6uZMI54m6TW8/ZFaTshL9q3M7NKs2AcNOGlew/sWJ93ACfs8teR+cxL5witWGrLd+fgH1RwmCIEK4a4EBO4ES/bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GVzy63zS; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GVzy63zS"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-127133794b6so2415488c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 15:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773354696; x=1773959496; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=48/JBhfRTYkQbuu3k/IhRnah6yiGvJ46CDfj9rjG1jo=;
        b=GVzy63zSAUo1nMAGwaF6sq0WVkrCH1Wd2lgJE5+CS3RtXeKoLhDYDN2R96aDEg/s0Q
         EM7O1V80P5QOIzenCY1Aog4oJY0wLLjT2dNM8gsoumJr6oMJJ75KSmZrVxWR8d4vuYG5
         gwfObqvnyWmd4rknjJeyuXS1CEqATiu4MwYGHq2PNWiTwdDObBvWFPE7GDS2xoMv5rkA
         ZVI93gGQe9uCoIvElDBUy9rSaMKqeyYf0wZFuC1/0x8Tep7Dhcu0/FYY7Wg2U+3tYOFT
         YcY0tlRv2fLwU9dCwuLAUChmAjJIusC0e/QVn+8U8nW6dUv156+C+zVdgKBdyHj277Z5
         y94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773354696; x=1773959496;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=48/JBhfRTYkQbuu3k/IhRnah6yiGvJ46CDfj9rjG1jo=;
        b=AvJbg0aLNl6KoYR2j37CVX1k2Bcdm6aculBkRG/BiEeZMt5atIXJqbFHQ32ZWNrQvL
         ZQFkBgki2NwC5b0OF8d5Roew6FGU207oIxQQk1S6RsuibRqNc1PIs7Okke16y6iyXDwn
         SbPWEyqPAI/cjuUCukQPgE902g3rHYW1w0K87OWoldUdNXSmoiQYGkVMqbx6GPJb7M+J
         8ycuk2WvBFoI3HN8loNhcHhMCPdersjKjFAAm30/RBGzi0MPz4zFFUqKNMVRa6OF4ODA
         Y/RleH4xK8UxAKmxY8Zgao0WxFx6xX7Ww3pYQHeiVUbuW6uWnBvgdr0sk23yOIvCNhVM
         5EXg==
X-Forwarded-Encrypted: i=1; AJvYcCWh2C9M9uePtRdf+lg6A13sOZVWCHM3gishCMRA8n20qrDcF6yipAom4oPQ1qU3lSjyJatdGVDYZgDX3Wey7W+p@vger.kernel.org
X-Gm-Message-State: AOJu0YwAiAm+MCQ1Zi643FKHHBSVuhZKUmhIjRGBtJRxkxINEAfiZowB
	iVz6haVACzKzBJtVuoboxBiuAh5EGn0fKaWp8x6fjlqts5rgGT4u/XmDJrROQ4c1hXGTU3Vr/w4
	1F2/i1j+3Yw==
X-Received: from dldz19-n1.prod.google.com ([2002:a05:701b:4193:10b0:128:d282:5eec])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:459e:b0:128:ced9:93ef
 with SMTP id a92af1059eb24-128f3e128femr572510c88.39.1773354695382; Thu, 12
 Mar 2026 15:31:35 -0700 (PDT)
Date: Thu, 12 Mar 2026 15:31:31 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312223131.2184095-1-irogers@google.com>
Subject: [PATCH v1] perf branch: Avoid incrementing NULL
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If the entry is NULL the value is meaningless so early return NULL to
avoid an increment of NULL. This was happening in calls from
has_stitched_lbr when running the "perf record LBR tests". The return
value isn't used in that case, so returning NULL as no effect.

Fixes: 42bbabed09ce ("perf tools: Add hw_idx in struct branch_stack")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/branch.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index 7429530fa774..a1d4736497c4 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -66,6 +66,9 @@ static inline struct branch_entry *perf_sample__branch_entries(struct perf_sampl
 {
 	u64 *entry = (u64 *)sample->branch_stack;
 
+	if (entry == NULL)
+		return NULL;
+
 	entry++;
 	if (sample->no_hw_idx)
 		return (struct branch_entry *)entry;
-- 
2.53.0.851.ga537e3e6e9-goog

