Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8D34AEE0
	for <linux-perf-users@vger.kernel.org>; Sat, 29 Jun 2024 04:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636875; cv=none; b=Gb1SNd/8UosDpPCr9ft9RtReS/t8CMyglL7GYACMhC5foni38imUFyrevz9jTeQvQJAabq/f73IkTyYOCMx1RPdQv4wkCEaZHtqiBl6Pdv84uTBweUP0mOHBO4B3pFX8qZCphAsIWU3i0HAv/w9p1+2EZOmHmVUAPTjz/qaQi+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636875; c=relaxed/simple;
	bh=X9Z2kNLXWNvCUsSUfNxJSkHFuSsUQbOh8Fkf4jkYl1g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fZGZcNzy7yt8cT4rMtYG4LTrPCEZPK2b/BafyDelmaWqdaj4VIyvo0/qCTpdp49AdDCu98Pnm7fka0CWd53fKPWT/NsogIcx2GpaCy7qXbWySJoWUr3apI+GCm8fTmHQyDjAn5P5CpPSi3gMaToOJYVl/+xk2zxnq8sGt+pjR0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UowK8gqr; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UowK8gqr"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-645eb1025b5so20439007b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 21:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636872; x=1720241672; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nt9mZXAuqIiRG3JkoyTKDkuyzTJ4dFDHgxDpLqHy/YM=;
        b=UowK8gqrWYc/ryYCzOydVe94TiQas/skFb/wF7uVUZszEqJ3aHIshTzSAybzEWg6Kh
         V2DqliobMzxpyMvb4/OrjNDSi/UKOo0C8JDrK5lg7vYUZzkiucvPJaMph5NFHyu9rVty
         yxiFDtTWUzN0VzQ5ILBhPtyHBtye3+Zpykl4SD9H/76rL2HNHNScQDw7pRoiDm9CRDG1
         oN3B/pyyHS95M9M1cjY0b4Oz9davnavm4v4ccxwldO0Xg+letnRWgQ5/LWJKZFpMRTFt
         8OUOIeN0GV15HS1i4CaYStxlYUMBjTtie7X0OhJCT022Rmr+9g4he6gzB0n+A05ZhO5Q
         N7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636872; x=1720241672;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nt9mZXAuqIiRG3JkoyTKDkuyzTJ4dFDHgxDpLqHy/YM=;
        b=hsX4H2XNjW4SKdkBZHiiuVrnjXEJnU7UVxH4w1crDUg7C6Ct0ZiGhsn/8fjr8t0BvV
         D57XpTgxZVx2qlHC6vil6UAFMwwibERHoDIvpcnSH9MOHg1Ih99pU2BQdjxaAVv/+nbA
         v+6M+pbYp8MjEEQxvpKcu+LKtbPkLiv2Wy1DAHIrapaao85qNFtT8pTt4GwmbMGGWjJH
         Cyi/OuyoIhbxTPe6g0h0Rlkc4E7cMROBQmZpbT7m35mRXNmdXOlGx1ypCpNqYlaCF4eC
         jQ0i4Vw3KzoQlziHKqu73E4HMs1/9JjTTryxf7rtgxTdVS8tslcNSwVSUixJrFh/lJRW
         Cq7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNIOcOnGVVxFEhvVdtqYbYu016Oj76F/MyNZKLkGKPNCo+OenMUClVKHLFrfHrq9FYAPHsOORinRtkIfbPG7Vd9xN6/2ZJlIQoAZXKTIMYMw==
X-Gm-Message-State: AOJu0YyWSgM5NS2q3ZE3AYx/B25moh1fBpaSlsjwWRkBOHZqNh2KiVYO
	E6uQZ7B4Zgb66F0gpUjBgXFZdIAbVQCE8i4Kl54ZHsAkdlQ4wea4wHOFCFCczgL8tNOmf+jPsuG
	5MHCeJg==
X-Google-Smtp-Source: AGHT+IG/i/nGorsDZPqwpN3jkDdzpKa0IkTfmGtlPZ9QyQPVv+PDNAraaATyncwHa7O+QG6cNNBWowsK6XZn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a0d:ea83:0:b0:64b:7f7e:910f with SMTP id
 00721157ae682-64c77cb5cbbmr5307b3.7.1719636872623; Fri, 28 Jun 2024 21:54:32
 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:33 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 11/28] perf evlist: Use perf_tool__init
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
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-evlist.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-evlist.c b/tools/perf/builtin-evlist.c
index 7117656939e7..818ab21c3f73 100644
--- a/tools/perf/builtin-evlist.c
+++ b/tools/perf/builtin-evlist.c
@@ -35,13 +35,13 @@ static int __cmd_evlist(const char *file_name, struct perf_attr_details *details
 		.mode      = PERF_DATA_MODE_READ,
 		.force     = details->force,
 	};
-	struct perf_tool tool = {
-		/* only needed for pipe mode */
-		.attr = perf_event__process_attr,
-		.feature = process_header_feature,
-	};
+	struct perf_tool tool;
 	bool has_tracepoint = false;
 
+	perf_tool__init(&tool, /*ordered_events=*/false);
+	/* only needed for pipe mode */
+	tool.attr = perf_event__process_attr;
+	tool.feature = process_header_feature;
 	session = perf_session__new(&data, &tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.45.2.803.g4e1b14247a-goog

