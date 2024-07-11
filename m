Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE2817C7CF
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720873; cv=none; b=YDFSohj27YkFHtvTcc38mDiekHw9FEQeV3H4+jVqiZ1/ioylINY13c39o9TvJPtXGB2a933KqHMhd5DA8d+fl8KO1NjcQ6cYr2ihzNMspO7nndAs4v9JBLcjsCsFD8eH+3LKnz1nNOT5GtkfPmlJp6BA3vo6MoMVfegPi64ZsxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720873; c=relaxed/simple;
	bh=Vut48/dGoEfPl82dZRBs1EiuBD2BZmTC7MWAiL1FIkY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=i4lrlHUSpai/5SGsJrXkP/PmORqFKmy8JNHB6o+MLVo37aZw6tQyiw5K9zw919BSxlAwqE4U6MWOtP16T8Z+My7KCHnX84IN/ws9vWs6nPVUgoGC8oPGCEoeSbEwfzbYZj19/B6E9Ob75GYlNHbMrqJz5wudUZ2GYu6sN3xdvHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0xUqBDCG; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0xUqBDCG"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e05600ade22so2355460276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 11:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720871; x=1721325671; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=phxqvYyYZFcsS+fO7HmN6BaHRpzOxQeFfvDLLgr+3hE=;
        b=0xUqBDCGfyuwy8qpZpVlBqmQVconYW645bN8exRhjwVOWu3WDrrzfXJOR9HD1en6Dw
         9FPkwG7/Gv/KSEmtCri8dhMGLzd/AGLke6btrFcpUaHYwPpY3O1rMZ+3w/L6ZXR6ruw/
         U8z1gM26CUfkSaVWqEBOWhFpbP1p1Be8Ovb0r+AHsErlTd74MAqNatVx/RAJRfa6rFkH
         uWZfRVBPyQX9CwSp666FSPluE4BuxnGeVqjTQo7YL+dAw9venK9O0o8pLeqFHg0kH9wp
         ZWzNgDINgQ3C+rauH9s1i1v6NN/yFROvCZAp99pmirNeOhOeb5QQRO1OEDC8JneclWKH
         3Hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720871; x=1721325671;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phxqvYyYZFcsS+fO7HmN6BaHRpzOxQeFfvDLLgr+3hE=;
        b=op9BMz3n3wYEyTys1x5gS8lz6xUeXzC2h7lPDioQmUn3/WPTRGcBg/3mJGSF9gdfHu
         jatyfKuzLsi75+SbIqWwsGSMmWTO654gQIqPOqAtIJb8P835CfUuPts+6/UtH/UoRgzb
         IEHBhMldX9mZKZR97wtU1ChD7Uxmc954UC6x80TU9Mets7mGDMoLOy2fdkZKoLDGZ79J
         wHgE53Z8/KjgGJov3Uzst7o139+sQQqXqloFAQEE6u1dvu+6PqdmTXSfn+3tXWcykN3y
         PkHFsHcfEOMOX4kNL66/zpKDDE4l2H5aglEwb5+x9eVCVih2J0y2l4I+mCObrbeCxE+9
         gRcg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ47Ve+iWWTcYFNJQ9SFjvAXpKd45sbiEkCb7xtwuqxb8i8k5Gz5eKGRFWWDhKMT9uLsydXliRbMm7ZdhE5o4Nisrwnvx/2CD4iF3zP2YPhg==
X-Gm-Message-State: AOJu0YxskrtZ1socbvd3btjjCgQjuZNus0eAV6Dev5UK1qC3CQCJBu/P
	q7yOci+clykJHnd2M6g/UJ/ih07hx6lHn1rY73BQWXpRDZ5RAe3Wuw+mVo6Gqkxxy0e0V3SysFo
	CZkSj3Q==
X-Google-Smtp-Source: AGHT+IHZsWRlk2KFoxmTrNHpb3twRLUr9YEReI+JPWVj//rgcz8mi631WHmc5+OCJP04cre0HLmnLn54Z7fH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:6902:1389:b0:e02:f35c:d398 with SMTP
 id 3f1490d57ef6-e058a707db8mr1072276.0.1720720870908; Thu, 11 Jul 2024
 11:01:10 -0700 (PDT)
Date: Thu, 11 Jul 2024 11:00:06 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-27-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 26/28] perf kwork: Use perf_tool__init
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
 tools/perf/builtin-kwork.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 8ffaa80a2d1d..6a4281b8fd10 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -2322,12 +2322,6 @@ int cmd_kwork(int argc, const char **argv)
 {
 	static struct perf_kwork kwork = {
 		.class_list          = LIST_HEAD_INIT(kwork.class_list),
-		.tool = {
-			.mmap		= perf_event__process_mmap,
-			.mmap2		= perf_event__process_mmap2,
-			.sample		= perf_kwork__process_tracepoint_sample,
-			.ordered_events = true,
-		},
 		.atom_page_list      = LIST_HEAD_INIT(kwork.atom_page_list),
 		.sort_list           = LIST_HEAD_INIT(kwork.sort_list),
 		.cmp_id              = LIST_HEAD_INIT(kwork.cmp_id),
@@ -2462,6 +2456,11 @@ int cmd_kwork(int argc, const char **argv)
 		"record", "report", "latency", "timehist", "top", NULL
 	};
 
+	perf_tool__init(&kwork.tool, /*ordered_events=*/true);
+	kwork.tool.mmap	  = perf_event__process_mmap;
+	kwork.tool.mmap2  = perf_event__process_mmap2;
+	kwork.tool.sample = perf_kwork__process_tracepoint_sample;
+
 	argc = parse_options_subcommand(argc, argv, kwork_options,
 					kwork_subcommands, kwork_usage,
 					PARSE_OPT_STOP_AT_NON_OPTION);
-- 
2.45.2.993.g49e7a77208-goog

