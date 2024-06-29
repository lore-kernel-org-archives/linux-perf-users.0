Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A86139579
	for <linux-perf-users@vger.kernel.org>; Sat, 29 Jun 2024 04:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636906; cv=none; b=VBqsK6V99UqhjalP29E2wnXjW3EzeDWATEAP0g94g4GsdDOlRjzEKUBFazAk27qlxTIbPxuQDqIo2hdeFw+nN6HdBibSKBbkKTB4LIFkTV/ca7+QKe5kBQ3fmsRyvVUMZp0WW2O3TvQ6+P1h30+k/CxQkf2szCvo0m18dnUPHe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636906; c=relaxed/simple;
	bh=vt9ewm0QhsA5LxvdEiaxvxHZ5z/a2gIOxOI+SUxySds=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=eOZpoPZlW36R6mR3Iq0Jt3/mY6kDsj9PQYHzUiWfuVPrUtFO95bJP4OfW8Ei00MiSGqen0vS/YbncM4mUI8E7kgZ2Uzf8q76/WXBmaPthoYUrSEZjZCz2I+s0kYBH1jINTguMsbR3ECVV/4/IhT3aDmwJI6py/12gXGR2ZR3gPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fgx8RVE7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fgx8RVE7"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64b3c8153a6so19487957b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 21:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636904; x=1720241704; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=noOlfQUa2/5XniX40b614TPnZq/cMjt6hUwCRNEoLZQ=;
        b=Fgx8RVE7TwnqlPqAzRnKXut2ObS8HsjRKMJBPx9qOVXAzz0/HYtk91OxLF1NQ9zgNN
         wP22ep2mz7ZcbGjLxKeH9kT8ZlNiJo8QWUF0MBAoqJksb44LCMb7BRN5afr54WK1gchU
         tbm/QLwR/vMG3AetGS/ZL4yh/Rm4d1sESq7pu38DKlrODOOuiEae0Tt0RLOqR4ru3u0j
         2OmeoeN7pc08n7gcOJH+RP/wxgsJ0c8TbOxTXsIdRczDGz5F/rDoEH7jItF25Th07k6Y
         w+JeIN+pWZaAj9Lr3dFTKLenMdsLHTo6nFFdErwhemWditIzILKTrL83Cns3GsZ8rQuh
         vSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636904; x=1720241704;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=noOlfQUa2/5XniX40b614TPnZq/cMjt6hUwCRNEoLZQ=;
        b=jjZsMxyN4E89Wc1iZajQytoH+t60gPrwloLOmQc0t+LnltnrLi7p92nrVKiFn5WWs3
         WNJZWls4DQ+QtdjyXhG1L37J49d/sovq6smx1FSLaJlSsdzkUimuGxfteVDYCXpkNJkA
         s+eZEWHZ5gQ7HuKxvUZlggiQfGQ705QTr6stPoR9WodVPX8LLA6AFtxFQ+RECuIe90Af
         gOhZh0d3wmqY0C+E05vaJsCKEMEftDhKuhNUBeLFIuyqHJUNZ4G1MCkhcnBpWVOWmDpg
         OUGksi+Xwe1HUzoCXuh/8lwvFv8xR+T0eN5IaZ1OftfaC0aNpaTDtKvMBBx2ztMXr/q4
         NQWg==
X-Forwarded-Encrypted: i=1; AJvYcCURuozyaFTDTTJ8XsLY45udSfpiR8ck/hUSkgvo0PYMgtmXbeQrZhc5FJ1fpW9r40QcYwynfYbS3mqb1W6sdYjkH165Ap9n6KghArlzM3U03A==
X-Gm-Message-State: AOJu0YwPTi3Mp3DpRwplEbLXz00756K9FlhX5AzJRqVGAxNCvCIzdQtw
	PhFpYxg5/KE9UYg9hgGjyBkcoOeiUbScjXNWbW4fhUEYPEz4egxEFA9FOQhC6QxrCsqOHRv22SG
	+CrdIMQ==
X-Google-Smtp-Source: AGHT+IEKYw++EBM3BOpjxqBCYOk7yHdmndAqP8d1uXeeoD7Shcgt85q+rgf6pDTYxLWW1zGq4YNyK5c40syM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a05:6902:1004:b0:e03:5d0e:7886 with SMTP
 id 3f1490d57ef6-e036f29783dmr534276.11.1719636904177; Fri, 28 Jun 2024
 21:55:04 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:47 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-26-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 25/28] perf test event_update: Ensure tools is initialized
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
2.45.2.803.g4e1b14247a-goog

