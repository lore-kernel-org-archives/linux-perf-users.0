Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3E18F7D
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Nov 2025 01:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762650015; cv=none; b=VO8wWfid7XxIGxeHwiqLZSaWog9m+VYzr7hrTiXmZQ1gmk/9io8oVQP0wrV8f/M9bhSMpw1keM+4rnCd2nmbO5BZhvbFpNBZTHkjYl5l3A3a48eB6GZrGWBLrJWWzWiGItciBiSB2OtQ/IXvBg/6nC+z66AtPurrI4Z45J9cZ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762650015; c=relaxed/simple;
	bh=S7/+HBtEvZG9Qq5Szv4TpB9V0AyAe5mzIsqylrNZYdg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CZWy3+oSJhvZB7j6M7h1Smnwsw4TGxiL8Y9m/Wp/vxfZayGvJdqmenbXnWWEVmDEKz33g+xzQ1IwurFg54E3prE/xSZRb2kyA03iL+MVzIYnb4SQm5eqR4A6MwPhwPZz3/77KdK8ttazADzKaIta62qCInzb7XmS/3GplOvULK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZAg3J2mu; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZAg3J2mu"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-78108268ea3so1809509b3a.1
        for <linux-perf-users@vger.kernel.org>; Sat, 08 Nov 2025 17:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762650012; x=1763254812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P6y3TFdHBEZk/bwF/qWSyN+tu4MCaAtXn8kZScOn/II=;
        b=ZAg3J2muVmQDB4Cl2VOD+xMOh8NVMc5XK355uFVGeDXvQ9HReJFaKyfKH8+kJpaLf9
         Dw5RJpcSyXKxtWQ/JYRCxPk0pJqXHM4skV7x5lP61Cv+4tJyhX9dDTMUATKb9ndvOx1x
         AZ0V6ACa5WRoya93lwsZOD3Inu3F2OoKutK8ULsqEbkOQLqCw6HfIVNWFg+XgYwkwJ63
         kmbVPlihYKDGBShG61I1XIy1D+lK7C+IwqOhSSJXoNlNHDkgGugu6JYBzb+FVID7B8b8
         JrgAIX/ihVzXVgLVnZV9wyq/kVan+v7jhFC0AGV54Q7KAJrUUrvQi41PL5aP0/CKA19q
         GSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762650012; x=1763254812;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P6y3TFdHBEZk/bwF/qWSyN+tu4MCaAtXn8kZScOn/II=;
        b=hx4cZ4+sCyg+9ih4nSmq0CjhaALTwpJ5nlHgTxIfr6s9+CoI85/KfUCa3D3gT99LBe
         RqK3BCxX2A3kBpU9Y/lwaaateweeOyuNmRNL2iExiB+EZPmNpf92/X2Qa8pzoOSNyyLo
         mhaP3HCV5NRZ2LSsvqq5zW2WYYqS/whFXdoMJpNNO5Uj49GAn1h9bRxYG7AA+/5qGtyx
         9TQpi6UugRuaLUItPRAevEYCt+jYCaGo6PGTCHHXqaEWCfHjWSH2AI6nkv6MpJ/algJf
         /1YD2yacO+hqOSBCvFCc/6vCR7SACf0JUPzH38H/w1ZGnqwFSMbswlmur7y8g60El3MY
         yL9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGy6rJ/1LdcUSANlawsbUsT4Dz4m4ZjjMo6TJW8VmOTBFMJFp6qYRfQ8dHGZWojzLRmaYC1btxpT6SLg7Oi82D@vger.kernel.org
X-Gm-Message-State: AOJu0YyN3iN0jaVelogNcJFpu3HSCH59EuyFIjDB8XxbCESpKxBQ1o/3
	vo912JEzx0rIIXc1YUBVhPk16HRubOZn2hx/w3bZYOo6C6uOWa7xAxk9DKqJ2+9DfVoRejUBYK6
	KWDR3KFHTdg==
X-Google-Smtp-Source: AGHT+IEwqkPO0LTwSEjO/KwiMnjaDr60PlW1k0ZcISsA6YD46M1sO8jbptz/j0pezzJdaDxc+ODhmQXsnv9Q
X-Received: from pgbdn3.prod.google.com ([2002:a05:6a02:e03:b0:b97:fcac:5547])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:734a:b0:2cb:519b:33fe
 with SMTP id adf61e73a8af0-3538b0f60ffmr4779118637.21.1762650011997; Sat, 08
 Nov 2025 17:00:11 -0800 (PST)
Date: Sat,  8 Nov 2025 16:59:58 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251109005959.2540616-1-irogers@google.com>
Subject: [PATCH v3 1/2] perf pmu: Make pmu_alias_terms weak again
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The terms for a json event should be weak so they don't override
command line options.

Before:
```
$ perf record -vv -c 1000 -e uops_issued.any -o /dev/null true 2>&1
|grep "{ sample_period, sample_freq }"
 { sample_period, sample_freq }   200003
 { sample_period, sample_freq }   2000003
 { sample_period, sample_freq }   1000
```

After:
```
$ perf record -vv -c 1000 -e uops_issued.any -o /dev/null true 2>&1
|grep "{ sample_period, sample_freq }"
 { sample_period, sample_freq }   1000
 { sample_period, sample_freq }   1000
 { sample_period, sample_freq }   1000
```

Fixes: 84bae3af20d0 ("perf pmu: Don't eagerly parse event terms")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d597263fab4f..f14f2a12d061 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -802,6 +802,7 @@ static int pmu_aliases_parse_eager(struct perf_pmu *pmu, int sysfs_fd)
 static int pmu_alias_terms(struct perf_pmu_alias *alias, struct list_head *terms)
 {
 	struct parse_events_terms alias_terms;
+	struct parse_events_term *term;
 	int ret;
 
 	parse_events_terms__init(&alias_terms);
@@ -812,6 +813,13 @@ static int pmu_alias_terms(struct perf_pmu_alias *alias, struct list_head *terms
 		parse_events_terms__exit(&alias_terms);
 		return ret;
 	}
+	list_for_each_entry(term, &alias_terms.terms, list) {
+		/*
+		 * Weak terms don't override command line options,
+		 * which we don't want for implicit terms in aliases.
+		 */
+		term->weak = true;
+	}
 	list_splice_init(&alias_terms.terms, terms);
 	parse_events_terms__exit(&alias_terms);
 	return 0;
-- 
2.51.2.1041.gc1ab5b90ca-goog

