Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364CE19885E
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434256; cv=none; b=T5GEdDL1h2cPGTALo1OtXd2aw8fl2osIArrs4XYtE2AlXRlMkjYzbnavcDUTYiUq3okNuuQZqXr9k1HryNSV8GkIwfOtlzM7x/4XvQGfeRtiJnS/ltmdRpRDSgTsbDzJib1lcpzbqs7tqRV6Zm6oR1t6TR4Gwi/PhJxe2bpeRJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434256; c=relaxed/simple;
	bh=vLAWwP6pxeZ3+8l+944tuEizrGnbW644ZT2RUZBRZLw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ScCD5Ct47Dno81QUWSd8te+Pt7XVjqlpKTRJrukAfgocgwsujBxW3e7gCIT0L1ajp/BzKcMRnuMtWutwO8tPm2CT440LjTlnx1bPVoz2wfGgdeLJsRwyRb6WsP7gtMfOD5bjfKR6wXDP0l2AFrMKIlPRr+Y8PHHfgzF+oqDdx/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KWHjCidm; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KWHjCidm"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02bb41247dso12730537276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 13:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434254; x=1720039054; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TFHYu3Nth2gR5eivBBGcLrTyqj+GOTAKJL2cvnIsazU=;
        b=KWHjCidmBAyCkFGW6EIyO48NzgysWZZxlcV9NlHN2Zg6eWifjpyWwi5k3YBFVSEoiY
         5y1lUY85q+T3atzhq7Pd7eZKSzKImyRG0l/hP40Dg1/kfDNdZSbosF9GbJtSxSUdcPsd
         Y2c91tVAtccs4XJgF9jAl6SgySMS7+K4GPVyN0lQRhldTCIuS+FLR+Y2bh7WrC6Vch5A
         C2Pqbwp6Mvi0zQ+TpB9aJPeUdlnocKxpDZn/HBE6ZPoEvjz7KFEA4zsKuAXSUzHvlu+v
         Ql1MSq/nqsjckuMaOm4NObCxD1O6QyvfJpjT63DSk7RJJ4YD7ALn2rhFR0EclqgDsbeU
         895A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434254; x=1720039054;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TFHYu3Nth2gR5eivBBGcLrTyqj+GOTAKJL2cvnIsazU=;
        b=QFDtKn2441AAqP+Edril9L5IpKo49XniKRooEt9itHy0j9NNHTydjKwaAiH8BMjrPq
         R2w4XwHoQc+YaUU5x5aEfc2tpvhERgXEb/QHz1TL07vJeP6AumnY/o/8ePwbHp7tbpiH
         udm9HN/EwIiHsM6vYvKboKufPE6avs9dl//kGxX7/TZS6hgvxnxLMNaoFQwq4qzFemPa
         vH9Y+uou2p4UIaU/Oe8oDBGpc2BoUmYWXpIAYI9NR6Myn5Z1dzDk+MCC8eFtz4UjmSux
         hX9GpYXmj98ZKS8yC37PgiWnNAh0mGrm5bCsGNES5Tk4UuaS/eWnrUPnSdjJ0/ISxqMb
         GbXw==
X-Forwarded-Encrypted: i=1; AJvYcCVGYF/jlmNaCr7IgrrjO+w9Gx4ExwyRvN3+Ys+Oa3jL1bAKD3Z9GzsS4EX/K2qBE9Zy1dV341DwAUk9Nj0a3bLCLydEl5zpUOTgtqPT2FaqOA==
X-Gm-Message-State: AOJu0YxKJ8K2AjaYpWP4pkoZmhhy6Sa2nk4MyS5XHK6rnOho1vnilwP8
	DIqFmADOgvSrfkTr/mhKkfBggBBTpDWxnt2dybDWbO3J0xOPWHzP5F3SXWdAFT9mGasvhmWMn64
	fsJQerw==
X-Google-Smtp-Source: AGHT+IH9TuYO+WiPmgRtSFFWHjHBH655rX65a4zVzk7gaz2aQTP23YgHXVJikjgfAs5bm2nu+W28AwUbyUSL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:6902:1081:b0:dff:3096:85e1 with SMTP
 id 3f1490d57ef6-e030104fe43mr68452276.10.1719434254286; Wed, 26 Jun 2024
 13:37:34 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:26 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-25-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 24/27] perf test event_update: Ensure tools is initialized
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
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Ensure tool is initialized to avoid lazy initialization pattern so
that more uses of struct perf_tool can be made const.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/event_update.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index fdecad920f59..d6b4ce3ef4ee 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -103,6 +103,7 @@ static int test__event_update(struct test_suite *test __maybe_unused, int subtes
 	TEST_ASSERT_VAL("failed to synthesize attr update scale",
 			!perf_event__synthesize_event_update_scale(NULL, evsel, process_event_scale));
 
+	perf_tool__init(&tmp.tool, /*ordered_events=*/false);
 	tmp.name = evsel__name(evsel);
 
 	TEST_ASSERT_VAL("failed to synthesize attr update name",
-- 
2.45.2.741.gdbec12cfda-goog

