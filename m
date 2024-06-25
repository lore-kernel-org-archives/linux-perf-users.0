Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A24717F39B
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336415; cv=none; b=ovf2aQOTAIR5yA9h5yd1czMAcCDHlsMQdcTLDvp1GCQUruAM04tSUTaL++yX+OZTxM77YAJF6We+Cc9tNIPAmNVd13fa6VLVcSUdvSa6NMCI3MByYvMQI3J9VZafVVGJNBy8KpHhv5U8oMD1FGaifB5BqN+Pa9w2/TRXbAo3xBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336415; c=relaxed/simple;
	bh=76f5hIdhPASzAgHsGB/OHAjt6PyB0XUm4Scq3YWqa1Y=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=R3FqkfaACXap7QNSiHsi03sEP4sjaCcS6ofB0KI1sTy12N3CqDRgZEYspMi3lUQZy/zCjb3VtRaQH+g4249hCV1KTUDUwlueYo2Xvo4/Z5ycxapFEwbeGZQjTcjElieqYTkQPf2vmkqXyYSR9Ty28U8qPPSZej1wdC5gGbN1hDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I3oo9ZX7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I3oo9ZX7"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfab38b7f6bso10645227276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 10:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336413; x=1719941213; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+eUWDVM6QBZsAa2Jo8FHym45eB780ogdLDPw0XzQlM=;
        b=I3oo9ZX7G1dWgspm8AGUL3sVubVPvKfArJtGYAaulwz7BfSRRTNHGCo0a86M3Bqcl5
         2QEBB/zgiFxkxAu+AJQHTWGcVg82Y/bUZhXgNgOCu0Vgn9EPZrZH/M/yoRv8MHGUmEpK
         f3DugM6pUUlgLGMYT3FBBWAUBGGkUFdq6xrCwGuBGJQrh/wTshwtTuZzLQt2t0NWQgIF
         ykgd0we2yc0sU4mowpu0vHJPk77l5jHJ30BIpKRvBi0/JBs0BBptJ6Cgs8sTxiVxEXuY
         J5u7MT1ms1Fb07LAe4vEXm1Q8bKN6jmBN48WUG5utM7TpP+feJo27jwUgKCYWmF6UZDb
         ufKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336413; x=1719941213;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+eUWDVM6QBZsAa2Jo8FHym45eB780ogdLDPw0XzQlM=;
        b=iVRG1hXQ/9O/YO6n+DU8Pul1BqwE3RC6j28EW8O7KK9E+3rpieMC3IoFBSLSkmpOiB
         XploN/ji0paLwXT/reyosJWaIkPXxIIyIT29seRZrkUqvPgnEL6P6UruCWXRc48dfDns
         Hq2IIUPufqAqoNTNfzOsjOKAPeSk+BAoojNon59OxXIljPMAc4RUzd5Q9VzMFYZ5EjeZ
         4iMcdJDtqDcBQ6/5DNfvN7VbbVYfhQw480/bvPAIwqJKZjQeU1Br8CnZZ3bqkWZTt+w0
         qp5OCaOvGEBjjuzS1OWYcJy7HufVDbH5oPFPkYhLuwKMMthEjon9nKF0N2/smp2pHEX3
         KRMA==
X-Forwarded-Encrypted: i=1; AJvYcCUMsd6uM4/5qt1lf2kCyy8AEsh9HVADrqNCPgTDT5AD6rHJt/0wEJ/C/gZTC9mfG2jtHkBDGgInqaDqTUqDmV7nyg5VM3B5eftO+3FemngRCA==
X-Gm-Message-State: AOJu0Yw9/BVv4Ushi9x5U5nTDi6JO5vmh4/0GyedUHfS8pXM6oG70bGs
	VWJWON1OHtkP2uFNKj+a/CgBYO/affx/bPbXe/XW93RXbN7T2dnt8OCiofMsVmSXhnK5dgK2vXH
	UC5yzBw==
X-Google-Smtp-Source: AGHT+IGYUWAk7sz5e9sFF7M41smXZ1CEVHp2Cz1P5m1lWGWU877bLmIa5jj7HXTTuyGtmfk+3jtWIxnjSAp/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a5b:609:0:b0:df7:d31b:7a29 with SMTP id
 3f1490d57ef6-e030412398amr101841276.12.1719336413209; Tue, 25 Jun 2024
 10:26:53 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:25:56 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 19/26] perf diff: Use perf_tool__init
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

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-diff.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 4c0567882a7a..28c5208fcdc9 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -467,21 +467,7 @@ static int diff__process_sample_event(const struct perf_tool *tool,
 	return ret;
 }
 
-static struct perf_diff pdiff = {
-	.tool = {
-		.sample	= diff__process_sample_event,
-		.mmap	= perf_event__process_mmap,
-		.mmap2	= perf_event__process_mmap2,
-		.comm	= perf_event__process_comm,
-		.exit	= perf_event__process_exit,
-		.fork	= perf_event__process_fork,
-		.lost	= perf_event__process_lost,
-		.namespaces = perf_event__process_namespaces,
-		.cgroup = perf_event__process_cgroup,
-		.ordered_events = true,
-		.ordering_requires_timestamps = true,
-	},
-};
+static struct perf_diff pdiff;
 
 static struct evsel *evsel_match(struct evsel *evsel,
 				      struct evlist *evlist)
@@ -1959,6 +1945,18 @@ int cmd_diff(int argc, const char **argv)
 	if (ret < 0)
 		return ret;
 
+	perf_tool__init(&pdiff.tool, /*ordered_events=*/true);
+	pdiff.tool.sample	= diff__process_sample_event;
+	pdiff.tool.mmap	= perf_event__process_mmap;
+	pdiff.tool.mmap2	= perf_event__process_mmap2;
+	pdiff.tool.comm	= perf_event__process_comm;
+	pdiff.tool.exit	= perf_event__process_exit;
+	pdiff.tool.fork	= perf_event__process_fork;
+	pdiff.tool.lost	= perf_event__process_lost;
+	pdiff.tool.namespaces = perf_event__process_namespaces;
+	pdiff.tool.cgroup = perf_event__process_cgroup;
+	pdiff.tool.ordering_requires_timestamps = true;
+
 	perf_config(diff__config, NULL);
 
 	argc = parse_options(argc, argv, options, diff_usage, 0);
-- 
2.45.2.741.gdbec12cfda-goog

