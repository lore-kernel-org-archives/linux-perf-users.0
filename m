Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5B217BB3F
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720871; cv=none; b=ZpG1LveJQrha+GkKI6W+APCfw7ZDUQzpMYqvLzlpQNd9rWtXggVfVApgky2edeaUMySQyHIXwwES2zlBkPDm/mrfdd3D/cTwjDyOeQYklqE7TrKc2t8Na4lzX47xUeNhH1SJSQIGcOfEYZImi1AAm0PuYAnmHPrgtD5hvJeTysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720871; c=relaxed/simple;
	bh=QJTLBouB03fYPDSHR5NUfnIzNoxc+9fFEDyXtvrnJyA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=rydOd29PiG9TnexE500xAW4wkTEp6mMPcd0KDYA6fgkwQVz4IbjOO+T1ce6CRnEp74BWGCXuXyDY/IU7d74U6FwRsBNyAjFmJg3b0rPt6vLrSR544BN95VijS/tdfctQ3Pr09lJqTxxblQanx5+HGygxKv5hPdw8D07fa/1plvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UwMXmUMw; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UwMXmUMw"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6513899bbdcso17342617b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 11:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720869; x=1721325669; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2MNiLSniwVv1E9e5Lf2m3HZTOrICLuX9boz579z3/KM=;
        b=UwMXmUMwukNa6Nd4r6YnVtVgunpqe4UQZWTgZ7Qm/+RfdggDEzq3fC2n7mRjGMXVTk
         znxKHWl2b9MH5ZvZB27gJgbCGHTBMELZFao55TuzHH3FQob/siuw0U3lL37fkqciMMKs
         gGFyiq1F/+YNWrc1R+O+ut4tVAe0uT9NF3lW3CiUgy0snEM5d3o+k9v5axZGex74uf52
         m0EXL0B13ukHOs4cmlEWji+iRu88nxT8v4YF6k2c7P2U+m1dJ31X+Z6HGvuj1JAzpYJ9
         PReKqWbJi3MvygF1Q+RO2CeYmRz9SrTVGu+8Y2tGD/SVXhUpChCnAEOB00sS2OfDWusx
         t+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720869; x=1721325669;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2MNiLSniwVv1E9e5Lf2m3HZTOrICLuX9boz579z3/KM=;
        b=ljLvgmCQvz+QIzh0ycwnl/XSa/U5PBo9mwL60NiGTVqRPnXTi09yMJRFLEoOC8VywV
         XXd9Qprs345cHbIpe+Mx3/mkeOdEg5rmN3fCuEtp/6ndN8I5c2tgIEFzwiwhg6DBWDjT
         hWgy4UOtmrOpUD4iTdrdggPVHP2UPbu1qCw6zzArMENU0ATZUr4f07XH8dVVQhRgLh1M
         Ak3c+2BpYengkdes/cpwlPstzFAX54O5ZacpoAIgTTETC7AkpG2OTffdk16KVKAYKcCX
         0Jw7Wm85PbmFCpd+mrvXB8Nmv73jzDLIi6OayDYMuuBB4fSonm1D/zF+GS7eXtMhtPQw
         02LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn1EFm7w114/OOaub5Pz+g/anfghJqOmTa/6C0dpVv17N0bpZq/uGNJKpQK77Fryoh4RkpxZ5k982KuXymwwH78Yyl3w1UcUl5c74puP+Beg==
X-Gm-Message-State: AOJu0YzncX7DXpSP/HkOi6xAGnCmdfaRNWB978rOVjU3pp8sz2ZQAidQ
	eEMbcnaUJn25I2kx/5/F1CoN44NyoKedf4h38Db7HkSVXzEKH22nhJTirDKfhPCIjPpAAeq7jU7
	fblB19g==
X-Google-Smtp-Source: AGHT+IGM2xQme0Hs8QJpMwRrl0GnjElIf4QWIdg7meyT8+jpTN98FNf8secObYryk9mDw0GyqbyaX812usu1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:6902:1206:b0:e03:59e2:e82 with SMTP id
 3f1490d57ef6-e041b134afbmr16523276.10.1720720868643; Thu, 11 Jul 2024
 11:01:08 -0700 (PDT)
Date: Thu, 11 Jul 2024 11:00:05 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-26-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 25/28] perf test event_update: Ensure tools is initialized
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

