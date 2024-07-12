Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804B717E8FB
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 18:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807985; cv=none; b=snyTcjo+H0GZ24ZlTpKZUZDdAMWfO5h89yGiaf3wIjI3VyNUjZ2nYCm1yPPciQbAeVOYHpKRq7cfET0FcDZBAdJ9eACOyC9zTjL39snfq2CHo0DsAz8I9jA82nPziDOIg4TPW5gJwQk2p1+w/n85hNtSwhpTtZPlL12PiGt3Y1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807985; c=relaxed/simple;
	bh=QJTLBouB03fYPDSHR5NUfnIzNoxc+9fFEDyXtvrnJyA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ACse9cYcYgO7NF1dAV0KD6Y8Rxci1fV6hl0MFL5HZGIHXT9HF8B0uMz04roTwkxlIScDfA+ScDLtvBniAdWyWIWoAdauudG64sXZFU2XgkUdnaghEw9kuKOZWVcAj7KuCXtvG19fTTUHHa5Oo2J1vLXWRyOBe6bDNxoAZsy9pLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g+2dJRJG; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g+2dJRJG"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64b5588bcafso39773297b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 11:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807983; x=1721412783; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2MNiLSniwVv1E9e5Lf2m3HZTOrICLuX9boz579z3/KM=;
        b=g+2dJRJGLes43brEiSWMPR4dnlcdJ38NfQNdreNPiMZImCQlxoGZsBtX/Y94P6e79r
         caR/NL12WEjfXJxYXQpxaM0+H0L1W92rAO/Xb+TaywL0X8BuSGkCxtn8zfqZmkGxImew
         +gkiTH/0sQMy18STO7sD+5QYmLzdQJiLhHSvxwnBVrMkIwacqAmp/AF5UCdeN5rdboPw
         wi/Nh5BYbviYmLpQsRKv6zMM/v8poVKQX5YJ6u6KslgjCkqgVpk5pLWL/A1Xo8Hg6TmU
         x4GzbT10fBv7hkGIdWoHObtKTFN1pODaVWjqReVuley0qqrxRca9BbatShDcui4hHew0
         APNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807983; x=1721412783;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2MNiLSniwVv1E9e5Lf2m3HZTOrICLuX9boz579z3/KM=;
        b=rxhbTMaw1XsIPUK9yv0TEfOJKniVVElnzuz/gP/Q0fZj5zy6fVfK7piIOb3avIhZMf
         1ESORqzAr2e7I+woqXGF2wUWmfqXHwR5dAeu9FudoZCoBIR2Zjlat4K+4s1mR8eItr6L
         ppo6szc8qdvDzynVleCnJoJdmNIGVM/Y5spcaNIVWbXEfQOdJqswqgdnFPDZsUIWicNE
         h4o5D7EluBqaxAGnPYdFhtRwEmzS2Aoq/S/9Lyv2OU/CY6q08CVsqNZOVI43AlvCjIvS
         U56xy5m2Q0fy/tMUnCvZnYflKtNkiRkc+g+icaik0w1C/aGNsWYJmXaFDD7jLBHQrAeS
         66Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWrNLADp7KZn0LMbnIZbd/HdpC1Hg3rvXJeMdwiH3o91ff0mRrWIa4stJk0uJFwZqc9SvfYI9buefO7u5rw3XTctDU+6dk6/LZnGG87C75Peg==
X-Gm-Message-State: AOJu0YyigY+IT28vTcSE+yPBeGp0JuVIEbKWme8v7AFMSv9fEGaU40v1
	8pjyNLeEBs2GLL/7ZbebtaYmfQpCxTh4XFa/e/JBPQBu9LRRdKQ+PwrESA4x/SjQGmzNSG6Srsf
	9og9DHw==
X-Google-Smtp-Source: AGHT+IHT+bmwbpCCDDBGyKMSZDJyWfQuQtb+HSakU4o5bWugocQR0tn5FoTRKGbLNL6FlQgXTAEyTtQZuZbw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:690c:4d8a:b0:64a:d1b0:4f24 with SMTP
 id 00721157ae682-658f06da930mr3078967b3.7.1720807983544; Fri, 12 Jul 2024
 11:13:03 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:11:05 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-25-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 24/27] perf test event_update: Ensure tools is initialized
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
2.45.2.993.g49e7a77208-goog

