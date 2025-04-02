Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD1C1AAA0D
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Apr 2025 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743612457; cv=none; b=jSsql2NMJbnSN0hGEl1VhS4NjN8KuIIVFXQkF0bIlIH5DUrzbt4qIKMq7J9RPGkP3M/vXj5oN2kdKSkLJ3dv3Lv4g9HqDXc/fma5A4n3Ls3OPglURCbitvJGeJ2m75ssOV/b1cZy9LSSGAYGh4HqwJU+H+rwf/GL8RHNShuKp98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743612457; c=relaxed/simple;
	bh=IoNk4f+pHHqP7GqFc1Z3S9xs2ShDQotfi0G7WwroLJk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=tWM2dWLRbGPWNxo3yjoEVXyhkt/8dRbmy/QDykQG3L3ynrJfarMBd0TYIy4G3MfbbASin/JPvSTeJviZLcQaHyt4C3cz0YhiQZ7XhCRJ1gj/OE464oTCOrQceQ/sCTezdwi4zLpEhpDuBqeTAr4A0fNLOqM4u8+6unEcOJTf1VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nIzUNnJT; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nIzUNnJT"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-224192ff68bso485265ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Apr 2025 09:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743612455; x=1744217255; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+2uO9pmTjsejVD/zY6cyyd9PztZvdMOJJd4Zz+Pr1QE=;
        b=nIzUNnJTWSdpDMFyTDHhB7gcUH9rCFZk+/7QenY86iTiOxH5lktBr7V5eiDgkVDwKT
         3hEVHfSQpPlEFDclz9/Fw/7mooxmB/wdy2d6pmX3WkH7z1msTRAA/Lz351qgwHRomoZG
         ZKeWiLOGgeirjOmiv9rMrgcx0r2skOXV3pEN6JGCKBtMxFzQUEkBlzuZGY1lMCTJi/WB
         oC4QhUnzLMicP3ex6m4oyZmDEkWxdcsF1YbEyiDVjbviNLLwk2sT7pfidLU4JTFw8HKf
         9GHwdSqFLoQivgvjnUuLqnUI+uGu1icNU+HgUouk6T3wZh2FCyBve7aDVMHJZQ36piEL
         5RTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743612455; x=1744217255;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+2uO9pmTjsejVD/zY6cyyd9PztZvdMOJJd4Zz+Pr1QE=;
        b=T8ucizn7LuhoaoQ0DvxdzxKKfL9JXU66xKG6mUivoQuGzcH/c9UKVCtSN9FFN3Zjw0
         YtPPTsY6GUF9pATh9joPym5uCrPtAr6BQMPC5wiyS5FvO3LyQI/rofZ2jT2RP+Fod28F
         hsxPt5eRAU6NZDNq9X7mXYbe4x+F1wA/DymoGQNNLPdfKecWERjzbJ4iL+DV6AHtEsu1
         kOjGppHpcYgcl488fRCM4lLfittu3sG4fkFPU2cH6xNoJA4OBESJ7c4JVRYsTlqrxmzc
         H+DL74488FRE7NbtCcfT1pc/HMLxNMCeCJv3+hzPDHklOsY/WEMDei7qh/+WHTG5HVJ8
         tyMg==
X-Forwarded-Encrypted: i=1; AJvYcCXxfAzjBVBGgHqrxYTN5tQWCv4w6lCWLMsDEQEBr8ecW6dyM7JYrBaqY3Ccz7ap390+L9V/l2unJbnye92bTqY8@vger.kernel.org
X-Gm-Message-State: AOJu0YwNlfy0AIPNdWuMvf/zuY/UjClXYhqH0fP9DBZM702CVNj0v6cR
	QuOxdSBCdZocQ73lG1KN5ZJJ4VwA7+cit5vfGHoENhwO9Dw9C1m6DohzctTXMtzdRpDnSLxuZaK
	3zf1dew==
X-Google-Smtp-Source: AGHT+IGzG/3y+ietfy34xtDoKHmB1Af67pToNGHEdvk/vvMUa8iuexUCdCA+6jNAoMtTewR2ka6+Lq6tSf3v
X-Received: from plks2.prod.google.com ([2002:a17:903:2c2:b0:223:49cb:8f99])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2312:b0:223:fb3a:8647
 with SMTP id d9443c01a7336-2296c8606e2mr41385685ad.41.1743612455185; Wed, 02
 Apr 2025 09:47:35 -0700 (PDT)
Date: Wed,  2 Apr 2025 09:47:20 -0700
In-Reply-To: <20250402164720.3847573-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250402164720.3847573-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250402164720.3847573-6-irogers@google.com>
Subject: [PATCH v2 5/5] perf parse-events: Add debug dump of evlist if reordered
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add debug verbose output to show how evsels were reordered by
parse_events__sort_events_and_fix_groups. For example:
```
$ perf record -v -e '{instructions,cycles}' true
Using CPUID GenuineIntel-6-B7-1
WARNING: events were regrouped to match PMUs
evlist after sorting/fixing: '{cpu_atom/instructions/,cpu_atom/cycles/},{cpu_core/instructions/,cpu_core/cycles/}'
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5152fd5a6ead..0f8fd5bee3a7 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -28,6 +28,7 @@
 #include "util/evsel_config.h"
 #include "util/event.h"
 #include "util/bpf-filter.h"
+#include "util/stat.h"
 #include "util/util.h"
 #include "tracepoint.h"
 
@@ -2196,14 +2197,23 @@ int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filte
 	if (ret2 < 0)
 		return ret;
 
-	if (ret2 && warn_if_reordered && !parse_state.wild_card_pmus)
-		pr_warning("WARNING: events were regrouped to match PMUs\n");
-
 	/*
 	 * Add list to the evlist even with errors to allow callers to clean up.
 	 */
 	evlist__splice_list_tail(evlist, &parse_state.list);
 
+	if (ret2 && warn_if_reordered && !parse_state.wild_card_pmus) {
+		pr_warning("WARNING: events were regrouped to match PMUs\n");
+
+		if (verbose > 0) {
+			struct strbuf sb = STRBUF_INIT;
+
+			evlist__uniquify_name(evlist);
+			evlist__format_evsels(evlist, &sb, 1024);
+			pr_debug("evlist after sorting/fixing: '%s'\n", sb.buf);
+			strbuf_release(&sb);
+		}
+	}
 	if (!ret) {
 		struct evsel *last;
 
-- 
2.49.0.504.g3bcea36a83-goog

