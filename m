Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477E717E905
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336410; cv=none; b=ZBkSkOQ0oML4JJpSGhUzztSkb7i8X0jKs77ivvVCw9rc3XT3v+sIe/fN+2CUuNfwn4GG/BiG6AXBfpDUZL4qQ0lNEfB/EAz8jU/cc2pl+vBs9S3LtEXm80xtYAc1ySTwGRMTN8ud7Oel0Hzba5FoDusmIEt9oUXvC0zaDCuSPG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336410; c=relaxed/simple;
	bh=NNpDhvLM21Dx7gpxRlWCOf8pWQqxyB122lzmpjrWI8Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=eD/2lGagsD31yKLUaptad9IyUumG0ysp0V+cwiSDepalosJIPozPcfUESMSJTKM9mUMdbKLPxauKKQkaOz4Gg3n30avEe/6EM0K09ftbpPS94AarpMEKtC92OOfMpHSPsE7GC5ETFgVcIY5NTQgayoigZzAS+NOVw+cuKBJRD6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FUsXmK/g; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FUsXmK/g"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62d054b1ceeso120071377b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 10:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336408; x=1719941208; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6FKqc617GU6y9EZBzym/gHkh1HBEMH2nzxihyAHq3eE=;
        b=FUsXmK/gfTKJLh9BaL/WoKmOvbB0+U/Mhr4wmsIpgTXyiTKByBbNOpoP1Bc8poTIjX
         D3DW0uUt/sK8xY7jwiYLwlfaYjBGzO6mmpVuGjjtwp3tAMMytwlFR2ioe7SYdqer+lnf
         xBarM/uNv/AKI0QO8vrLEiuyXYVLNbPt7SfRvR1708SBr5zJaWY44haMrNrsWINQk8nP
         eNi/fQqB2hcdQ/eqY7larPtH+jzvHuTzBBymihZXqZbgfXW2xfozDuR72aLjqAWsMKQl
         0wfNyJXfSi0KCYgCGQ2uoPGsj4eHoOV6KnehZXKsQGnstOK83FBzU7TzuhzX/7C+wf30
         UUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336408; x=1719941208;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6FKqc617GU6y9EZBzym/gHkh1HBEMH2nzxihyAHq3eE=;
        b=JHv3j1ARHDYDnSVxpOoVd9Hxr1KG1uJ2MKICx0cDKKOUhHLN4FvJ4YX2mNtMPKA9p7
         CjLLz4SLv/ogn4VME7WVYSDZrqWXY5oJycQHm+MD1sfNxIxuvP4HKQHJNLMyPQMX8beR
         M01nbJLFhiFnv1ZKe7I6qwbrnAos0Lahgg/V3+qmIX033SKDPBnrFKyK3G4XSw/00arN
         K8a1RSh2pPNEfboZ2RDhO7cEB0wIKuVZ8PY14WrHdVFLzUseeVbQaOa3EokElrmYG9up
         J4WpPUj5uFBjBjSe59HLrZDG5lqC4snFthySY/hGtsPr8jvuuG4C9VWpR2E9M2xYNy0a
         g9cw==
X-Forwarded-Encrypted: i=1; AJvYcCW021yK2+j/TaBmoFASO6HISUgb4Hu8iEsu/B9tFAOrneaj2iHaobMUl/y0QJD7EcOD7gQyxBU/3/00ngVN0dy4F/phtryfvI1Vu7ONaniVqA==
X-Gm-Message-State: AOJu0Yy/4ei1ObIRDPWHqL2S7Lz7c/WV+57tHfqxwyx2OpzBlgr0KdzC
	Iyw7XJaCY70A/Wdbp5NBY1OodaTtm0ctRYTtAjR5r5hsMFroDL2W/X7XiWbqYOXZ40dffLIUhdM
	aORgjxw==
X-Google-Smtp-Source: AGHT+IHvID5MqiYuIdDZtsB0PM+VSxrqQRo84zi8LvlxFkQG16oOJVmUwBr7Nyqswk+S8IE/3vFBpBPetX8T
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:690c:6086:b0:62c:fa1a:21e7 with SMTP
 id 00721157ae682-643adb94892mr2966057b3.6.1719336408291; Tue, 25 Jun 2024
 10:26:48 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:25:54 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 17/26] perf mem: Use perf_tool__init
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
 tools/perf/builtin-mem.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index c2038a32543c..c12ca0ec1237 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -285,7 +285,23 @@ static int report_raw_events(struct perf_mem *mem)
 		.force = mem->force,
 	};
 	int ret;
-	struct perf_session *session = perf_session__new(&data, &mem->tool);
+	struct perf_session *session;
+
+	perf_tool__init(&mem->tool, /*ordered_events=*/true);
+	mem->tool.sample		= process_sample_event;
+	mem->tool.mmap		= perf_event__process_mmap;
+	mem->tool.mmap2		= perf_event__process_mmap2;
+	mem->tool.comm		= perf_event__process_comm;
+	mem->tool.lost		= perf_event__process_lost;
+	mem->tool.fork		= perf_event__process_fork;
+	mem->tool.attr		= perf_event__process_attr;
+	mem->tool.build_id	= perf_event__process_build_id;
+	mem->tool.namespaces	= perf_event__process_namespaces;
+	mem->tool.auxtrace_info  = perf_event__process_auxtrace_info;
+	mem->tool.auxtrace       = perf_event__process_auxtrace;
+	mem->tool.auxtrace_error = perf_event__process_auxtrace_error;
+
+	session = perf_session__new(&data, &mem->tool);
 
 	if (IS_ERR(session))
 		return PTR_ERR(session);
@@ -449,21 +465,6 @@ int cmd_mem(int argc, const char **argv)
 {
 	struct stat st;
 	struct perf_mem mem = {
-		.tool = {
-			.sample		= process_sample_event,
-			.mmap		= perf_event__process_mmap,
-			.mmap2		= perf_event__process_mmap2,
-			.comm		= perf_event__process_comm,
-			.lost		= perf_event__process_lost,
-			.fork		= perf_event__process_fork,
-			.attr		= perf_event__process_attr,
-			.build_id	= perf_event__process_build_id,
-			.namespaces	= perf_event__process_namespaces,
-			.auxtrace_info  = perf_event__process_auxtrace_info,
-			.auxtrace       = perf_event__process_auxtrace,
-			.auxtrace_error = perf_event__process_auxtrace_error,
-			.ordered_events	= true,
-		},
 		.input_name		 = "perf.data",
 		/*
 		 * default to both load an store sampling
-- 
2.45.2.741.gdbec12cfda-goog

