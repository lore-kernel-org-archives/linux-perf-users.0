Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C51839E4
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 05:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725426374; cv=none; b=G6GtrMIHSJpwtn+p9KY1DiSDUaDWE6iK9G31z8qJFF8JsC2N09ekKI+sy5cVoczrJTcHDRoO7QBq2wBxWSyfw4FtlC95VoeMs2iLbWF5/TEm9XppM2L30unFaX8Q4ce49JiX3zl9h74rkDtYvCLrI8tK1BeenPhGxpD8O+HtXls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725426374; c=relaxed/simple;
	bh=e7twF7D4RZxswFbYZbFUFk/hv4Xp6qmoMYXmywlWvMQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JbpLZbr00+HL1y040rd1G5oHSxzYPlOSaKyKMX3e5TmrAmCizwICgv70vKccA0PzXWbdqhi64LaKikFzxIw+/CwqNZsdcZRaWiRcPcQsVEMeCXmsisO0ItKt7X3ZFJ5efAdrNUYuS7A2X6IURo5aDuDdnpd8MjNAg38XqiPmu+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZceUgQZH; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZceUgQZH"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d4426ad833so108197987b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Sep 2024 22:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725426372; x=1726031172; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5JYnw2dXbPbmg3NZBXlioPl/0JNNRzqtalz3T5B9FgQ=;
        b=ZceUgQZH2jf7AGhKdIzR+Q+Z61c2JGiOvPQjKwA+tmA+wy5dgm+q45ZpxeNsL22Cow
         8wJKFolDTjHgDfh61USh44RknXT36oKuyJkRhQPo1XOT7jNaIqKmyhZp9Gd/+zlW6N3+
         tnEcRj2tQz1R0/tUNqWrcuVtVBHOO/xuPd7mZr4sMr9twYCEjExBSkGIzuOJECxI/ccs
         xhCFD4oM8tYcWz4cmFVpbIjf+LRtT5UIDkwMteYKqNPuNHf8iPEU0VLOjINJ5/hXzpDx
         jZ7HIctqD7QEJ4C0Klhf9/rkt+pRgtOI9ip7d0uytWfelso+zaZ7wJdoGyX4qoczaSd+
         qqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725426372; x=1726031172;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5JYnw2dXbPbmg3NZBXlioPl/0JNNRzqtalz3T5B9FgQ=;
        b=DPb+3TgH6MIzhcAW1d+OJzur84ZwMybmzY2bwqdta7D7XzvTmMWFadOE3WtiKd014p
         UcVipBE0ncKihpLQHIzufjlCCV5y2BUfw61/V5aS7ndb6bNNsCW036yq72WFNa41Jlpv
         ETZE6hUF+NZXPURp8C3pEc+Dj3PsB0u9iB/rgkoKQGm042vQXrpkw9ibrvHDaLeltdm8
         PSWhXKdqAlhVIEm+Q2tHttxnCKl4WIIHLf8BC03E6mgzj8M5KOA9uq/QNFqUOvBdGTjv
         AnGF8oBBO0nh5+Hl4zO6rQC8seIz/z0NE+MoBfy5lPDRKNPvKK8PmSrqn1R716YVpRIe
         sztA==
X-Forwarded-Encrypted: i=1; AJvYcCX60P8lJLq+FdeLzrFdKcCCQvQdkhaCwHx9a2FTkAbnntljsdqEcWGezUwvYUDXbZ0+aX5u95vHEkfueruR2N2K@vger.kernel.org
X-Gm-Message-State: AOJu0YwqIjLsVKC2zhjSm9T2nTlfr5twH8db2NE3oqICk6LVldXvH6qT
	W5gM0oUh0RnJqw2B/fRuZo75OkkiJ+SKAKZZ5jjD4Wo7eTDRwxQcFRF67hV4ey0Oh3c+iJO/+Gp
	amlBKbQ==
X-Google-Smtp-Source: AGHT+IEMgGK3kKUPug6YrK1FymJVV4ObYq+yK+ANVEHj+WY9mLBrHgfy5pgCRUdgiN9TS5s545K0o+YICLeT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c48b:5e3:a63c:2d09])
 (user=irogers job=sendgmr) by 2002:a25:f302:0:b0:e02:c06f:1db8 with SMTP id
 3f1490d57ef6-e1a79fd4228mr27889276.4.1725426372213; Tue, 03 Sep 2024 22:06:12
 -0700 (PDT)
Date: Tue,  3 Sep 2024 22:06:01 -0700
In-Reply-To: <20240904050606.752788-1-irogers@google.com>
Message-Id: <20240904050606.752788-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904050606.752788-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v2 1/6] perf pmus: Fix name comparisons on 32-bit systems
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The hex PMU suffix maybe 64-bit but the comparisons were "unsigned
long" or 32-bit on 32-bit systems. This was causing the "PMU name
comparison" test to fail in a 32-bit build.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 3fcabfd8fca1..769b920d9250 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -69,7 +69,7 @@ size_t pmu_name_len_no_suffix(const char *str)
 
 int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name)
 {
-	unsigned long lhs_num = 0, rhs_num = 0;
+	unsigned long long lhs_num = 0, rhs_num = 0;
 	size_t lhs_pmu_name_len = pmu_name_len_no_suffix(lhs_pmu_name);
 	size_t rhs_pmu_name_len = pmu_name_len_no_suffix(rhs_pmu_name);
 	int ret = strncmp(lhs_pmu_name, rhs_pmu_name,
@@ -79,9 +79,9 @@ int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name)
 		return ret;
 
 	if (lhs_pmu_name_len + 1 < strlen(lhs_pmu_name))
-		lhs_num = strtoul(&lhs_pmu_name[lhs_pmu_name_len + 1], NULL, 16);
+		lhs_num = strtoull(&lhs_pmu_name[lhs_pmu_name_len + 1], NULL, 16);
 	if (rhs_pmu_name_len + 1 < strlen(rhs_pmu_name))
-		rhs_num = strtoul(&rhs_pmu_name[rhs_pmu_name_len + 1], NULL, 16);
+		rhs_num = strtoull(&rhs_pmu_name[rhs_pmu_name_len + 1], NULL, 16);
 
 	return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
 }
-- 
2.46.0.469.g59c65b2a67-goog

