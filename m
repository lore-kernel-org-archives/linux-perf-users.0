Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465FC7C097
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 01:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264487; cv=none; b=sLzeH8RscGnqjORBuOGHHLJiouHtv4HE7WXizp5U1lF7PjORez/Jo3aOGvo6N4TL5raMNG/COyGTcS9UT0IzhiQJkzEGcJIKLXPJCUPTZ3x+MI7bEXzYjpTdySOYIsD3Q+IAWKDAnf1s+LTUfR8ejBr3c2lwAI2rYJEMPloGFwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264487; c=relaxed/simple;
	bh=mu4vuD1HD7G3ToT4iQRGX7fu03viURBKFaa4tQ+TMC8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=iVUIUAixVDBpRHuAtMYV9+jKEwPYjrBLuXkkkFJ56ai1ukzb1baMmkJ74z+rTViccH3Qg16JX0GhTDUSM/5oLIxo7syJPSt+sBZ6cE91bvuflloNOX4vCr7sQR3H3mChCXdeiZ1/CI2fZfDYnPrEdhB9mJ1smAhoMR/d0n9ZUBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eNjXwrZP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eNjXwrZP"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-665a6dd38c8so6556887b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 18:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264485; x=1721869285; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=86P6lehyXq0UCz+szOa7LpHKfu0TP8+WJUv3yJsN71E=;
        b=eNjXwrZPN4xHDS5hqEmnTNdvyPGQUZAp7+busv0w9p7U/x3dB1AvW2ObqmWywwT3Kw
         AjXovCZEWcOCJQJnkHHOJ3SSL0NIKZb6qKN809m5Fp14K6iqDk2zb9iB6fxy/SFjdb/E
         m74jCCzLCMp/jdaqCSg6C3PChCgr1pVfiiQ1tzBpkoBJqlCFhbZWH8lQ7I0r5FdV8jn8
         jCKhrDenVAYqpjWxYwfF/1VA+7cHA+AxdIxEZhCPK8cmqU9/OQU9yjdFhyM7JzTUTQlC
         VkREAcT4iWpJr34Y70u6qro3y32ZYzf6tklv3q5OXfD3GcrCBVqxjSvOEzgUPdyMojTj
         A9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264485; x=1721869285;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=86P6lehyXq0UCz+szOa7LpHKfu0TP8+WJUv3yJsN71E=;
        b=I5xML1qtPjY3/w0B3VJDkJjNEL1vXMSuJdmP65RI19Mi17mAF2Wq8H85l+Vatb/nwJ
         U+PAPNMRuTcd2VL7JKgjt5rkBqiUG4mMR9ZDCHWKp1LO9aNXQLBaDFIVwrw8WjnEXJ5L
         XFIaH3lbdOFKaaHHF+vvUhMW4SBMq/nGo6+u1ti+iOhZg3JR4fXYIA0EVQBAq7xUdwyi
         x4RTU5W9f6lD2umND74uc4OVr5Q+giMoTtop4Ao/Df5cc8mjDFNxMllJVDIqZBwxJ0Q+
         ghhjFJb8jrDwWf056wKxOKJYmlyUtlW2SwleVHtBT+lA6IcM/MZ2S//uZKIxU0kMvAK1
         9gaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ/TbeJhdzqRcPAM6PwTqHVYrv/je5PpBSUwCMJ6LEX05PV7kTw2aKmCMki+0ZHwOgg5uTsHVyxfmLWPJfkVq5KZAxu8yEfN04sbw92UCyog==
X-Gm-Message-State: AOJu0YzF0OWSLUh23obdCNz49DG+F+6ZXuk0F5E7F4h9H22VKOgajuUU
	Ud/TpkjD98APU8muT4lIKKUwSYzQCdGAccXrGheGDIj5ja241+m/6xGkNRTQfRWLN4hOuN7cVOd
	P2vaFIQ==
X-Google-Smtp-Source: AGHT+IGW5p0HgLAn8l5aYZBJ4Boo4bm6ly1P78GV/4bDdqw7hMUFDKApK0Y7U+/yyqc8Q3iikYnotrKwO6YX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:690c:10d:b0:631:259b:fce6 with SMTP id
 00721157ae682-66603ed354fmr233327b3.9.1721264485416; Wed, 17 Jul 2024
 18:01:25 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:17 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-22-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 21/27] perf diff: Use perf_tool__init
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
2.45.2.1089.g2a221341d9-goog

