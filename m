Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AAB4502E
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 01:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264462; cv=none; b=VC0C/HmoXYhtIMClwHQWQlrfTtmuphLi17de+nN4LmUzxkgWE959p8E1U0exzNAVsuDziSb1LlsOBBRg1OUWr7SW1xjnpBbFquQRqwxJHcQYzh2p5IG/b63MeMdr1fFgGYsIsOwY1qB8Vx7qdfCcJtuQYiFQH7K1TM9Rn2R7yGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264462; c=relaxed/simple;
	bh=lx9B36RzjHlRcTa00YroWxsB5FR7jL0RJ2UU+VNJZi4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fOB1QOLYNgKr15mgxDylMSXQ9hbf+VrUFe7YGPVvXuCP6vHcjX89Z9FQBDm2B30NpKWTWr7hIEDuYdCZD6qtWV2pbIt+vjVtDI0sjRL3JDkQehpk3wv86rq+CCK3op+DL0LNIbNBjey48FRnInt6g4oxyidNUbm2e/2e7vuCQHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=smYjIxup; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="smYjIxup"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-664bc570740so6607557b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 18:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264460; x=1721869260; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BRYCHYYbMGKjB3Qvf71te5ARgV5gIJcFTXBlC43nr00=;
        b=smYjIxupq4tHm3CdDh2uwakLulQ/eDW6sNiEWFfs70FfJ9WdZng1l+4U3aoJ+AFuy+
         ZxzbYl4yTjugcqqbyjzomRTV5PHzPu8AA2V6ZzoA/4kg/hI/qG6kcygUgtJtbYrn4vWL
         4BYWTXO2LtG6PoPidbNwfAUpXCkgjRqGO7F4eW8X7qm0ARhdJEfVJBznes6pBwOrNrb9
         /TkbbnSNk+qE585vNqoJaS2ZT0YLOBa/Rkqzef+RpvQ04OP5CwLhYL/cUNlv4p0Rt2vu
         CqakyMhjcZBh+qbJwYO6XhdnXXCQ5cWe5eRt6g0Y7Gcy5w9TZpETJ5IWEL++jK9+u20A
         1rxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264460; x=1721869260;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRYCHYYbMGKjB3Qvf71te5ARgV5gIJcFTXBlC43nr00=;
        b=jhOO70TXbij7l9LxhkGFUqhPxG3kP/hBxt0hBiEtj2vYfm9wZ58TkS+Qp5BgrZ8MzK
         1hW+eNov5st4/P/lpfEHrPt85df0pUx6XwTDqqsNitQPMKZ2mp2fXAcL/Y1Dxnk0Bu9A
         YXBUJEAOtRWV6wz8E6e301Zn1iTF1D8QWaBPaPuo8IuHDQmlJMG0xLT2uFAYCdnx6WBN
         H266s21xTur5TUi3XNPJ9Ky9fH27tuRpUvEtlzDc1GKX7Bfrsho7UF6WxlJeB2JMESBC
         UiC+QMRoryNzdnGWcBi4YO5K+l0mJyhBIoyoQ4UJX9rF+5JBCRCNQ43sAg102RzSaPU/
         O/yg==
X-Forwarded-Encrypted: i=1; AJvYcCWWJ381888PzDseZQ+ZE2TKV6jDpx/2D4rBXe9doMOF8RbKyPhG4Yd13nm8d+nRSXnXvZR1Jx/64i3TadT7JFZAbEzE3agKk1+o01V3zDBHKw==
X-Gm-Message-State: AOJu0Yw5PWasdyKt5MRbItE4lbPHrPcknQ7z4H1WbBGWnRt7mG3FXt2q
	sCSqVcJSqYKz5HHpnYhxsPjBBxmdSKVCG9nQ8WSRTI7mswtqURmB6F1WXz1ipRRpXr0C82ySNZ3
	NJjH6mA==
X-Google-Smtp-Source: AGHT+IFYtrxkbVfYcmj/8+44DV+o0ePqkzDO07+yzQP4ulp2Q9arWW+kMFkiLAGqIisbVnxNl9FY7TnY38mC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:6902:100b:b0:e05:a1df:5644 with SMTP
 id 3f1490d57ef6-e05ff4c5bedmr36307276.2.1721264460178; Wed, 17 Jul 2024
 18:01:00 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:06 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 10/27] perf evlist: Use perf_tool__init
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
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
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
2.45.2.1089.g2a221341d9-goog

