Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2D219D8B4
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 20:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495702; cv=none; b=soJq8h1MXlpNSlKtS7JhO8NEzCSdsboU112+4htHXzsezMhwmxTgx8TvB8NZGT0904SBlldoCViMitkVWM7LjVAlBYc0k6/5lZ8SdBmLEN1KVME23wf06WsdP816Ofo07HFGwOsBPK/aycaC9wIsd6Mli3Rax2f66yZ6/UW8qYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495702; c=relaxed/simple;
	bh=k0D8y4XSo3WErX7je8ZpWPyhozBB7rGTE+pvrl2cKZQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=glf90PNySenZrjlYapkjjSdU5J4/hTTUoCty6OpfOLu0Zt23vUWulyGO5zsr68PKgUEBB4byBuqsNaVUxNPis5O/62Ft12kjH97uD9ockEKhm0hvWGZ/CqVG+3ojuQaAaOx4nGi8Dm9+4Jy9ONZoi3Dpt44ioTdpbSnuMLqNp4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0qiufs6x; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0qiufs6x"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02a4de4f4eso8545235276.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 13:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495700; x=1724100500; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kiqQs713NS2cwu9IGmflyeUpCc5+2eIUysSxdZONVB4=;
        b=0qiufs6xNL2dp715GpNy1/zj4t6xsd55u/G/dZiFysL6c0alaXeLQFiBSuEl8FVnl0
         FxEelhLatMLKvU0wBzvakJJiP0halXZuh3vUe71/yY/pSNSwbuyubzIuqGkUKL6s0FLt
         3annXynzQDXYTAqvNHfHP41QWACuHO76/UdFIaSKAqUWQRyrcG7XyuLUS5TAkn+x9nGQ
         EVae2/orL6nijUhtuszk3xIxWJSTtG7604I97N7GZwuvHTPS44zDgoXJVkqYHo6RhIB1
         6RDHlEfjnAirIkhJhjj3Fv0S1VCqVKaq7j68grbsOK7YvOtV2hVK4S2vMwCpfTgQIRIU
         ssow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495700; x=1724100500;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kiqQs713NS2cwu9IGmflyeUpCc5+2eIUysSxdZONVB4=;
        b=Csks8jR9hzdNVE8J2D0M2/qZEdbAL3lNOAEcsFGzRTHpsXHedco4d95phWgbxVNITX
         8tVeDLw1f6kHTsS+bUsneXu2Plnp3Y8LGbqKMcAAyfXo4zhmprCJH/muFWCQWOkv3EVJ
         6Efcvu+H6Zno3NJZYqbrLhaZDBFKz9ri7733iein4JDkyon01wiU4RCDNNFtW0+MbLnp
         ThiYaG0SruCgAwKRBL/8qH5EVGUuk2vzHAadssDlXCrz/ePvHhzcILDis3z10dAMZC2X
         eiTfa6RXhf/zXTsIQhcZ4+7UXGsShcv1avnRFPXhyICjCUXf4elA5O4/jNcbs0GEZ2Kw
         IRJw==
X-Forwarded-Encrypted: i=1; AJvYcCVS3DwfQJAzfDERLiPDxZ2xJ7kMqulXjiisOsMGLWZxhHBe/K+JG2Ius5o3qtivMsdXr4YSuU55wkSeQI05VpnO1K/0lV1R5Gc1jDp1OazhRQ==
X-Gm-Message-State: AOJu0YxrgqaQpBSbRA2rMOzCBtx0fgSLzJ498c9lVUXaaYUNxFy10HlN
	zigqs0QwPSU6P/bG5tTPWBozl8OHFAKIh63jK3Mw8jV5v3FHvyso0bfLDbfFUeDf5gDTtQXhbUB
	6dTR3+Q==
X-Google-Smtp-Source: AGHT+IH3KiTk750Irbjnomg6Lm7uXV9YcitFsOtYH/VB3qZCzlTL/MIwOsfRWnRrXOwHrMNRY7pbWgYokw0z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a25:3002:0:b0:e05:6e45:84b6 with SMTP id
 3f1490d57ef6-e113d176384mr2040276.8.1723495699659; Mon, 12 Aug 2024 13:48:19
 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:47:16 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-25-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 24/27] perf test event_update: Ensure tools is initialized
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
2.46.0.76.ge559c4bf1a-goog

