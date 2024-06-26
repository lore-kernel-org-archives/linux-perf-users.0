Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1590D197A67
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 20:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434250; cv=none; b=hfxX0UM6WBwiwDREuOMSH/gSgmcwnZddMdv6sKgQVWbHXwbkATAjhNNl1FzABBsd1dHBw+7un23BZ2b4SmrTE91MuVNklRoxq3217K5Ki07YeX3jlEu+R/lnXUJ8nNcaiOIZtf4N5p1vScZROA4LoDmdu+4JUFYDztSSENXXrBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434250; c=relaxed/simple;
	bh=76f5hIdhPASzAgHsGB/OHAjt6PyB0XUm4Scq3YWqa1Y=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=de+vnD5K8cMK3AZEL4zF3AOPighJdCDj1HMKK61h1ZXbWDP3MWGtGfzWyfk+KEzMUPr4sk5qqKF/8Bnn775R8geF9ZUsM9JHBX6HvarCdhrZJk2zS+zIuaZ1/f22WdDLJRbKnb4crvV9XTBH1ewKfohFk/8BYoBsBqx6lvAzDgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B/LYpcN/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/LYpcN/"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-63bca8ce79eso151481347b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 13:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434248; x=1720039048; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+eUWDVM6QBZsAa2Jo8FHym45eB780ogdLDPw0XzQlM=;
        b=B/LYpcN/fViwIGxr50Qem/TbICEM+qRsV8+UgzQs2Sx7POUn/s4dm9eDlZCPKTIjyD
         BY5h98rFHlT2d3nR6KKgEoDIAKG+JvMo/xOkOl5w14OZ8lNxmhfi9EhvZx3FiSr0x/Vg
         pEOn3P6QTJ+CcFUZR2I3yeWPhxsz2XdCovdmByjdHihV3oTZsbBY8rN7cNWfyoJs8TZc
         skwVhg97sa1EUP9D23Q3IjmPOQuooVToT2qo9Ocx14jev3soOFG0X9SP/I2XO1sSaUuJ
         MbgJr6jPRzXRDruyYZ2ftGzSRodmR6LQxVUX0VEjdbVQT8PTvi1ww/+tv++tFlsOlivA
         x1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434248; x=1720039048;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+eUWDVM6QBZsAa2Jo8FHym45eB780ogdLDPw0XzQlM=;
        b=h3yHMcXptRIxALkx2uuN7rsGfSShQXOS2CTHcwOBBieT+/J4XKZQWmh5arb4/aYsQm
         uyxMpnoWUFeWB/090938i9mA5jKRGV4Kg2Myg9w68BGU0OKSEhk6/eMuF+BWYEltvhqq
         oJX5cP6YAoJbn1XkHx8pQN1vTtsKZvw0wqZvEeXNvPzX8vQ+zbFou6sZvfCurggW9gFV
         fgyhsMpdDkFcs2G01xYg3bRnMZDOOTnD317TyYjNyWQuVTF0Kbq4H25zQs6f+b79uu9g
         h1WcTjta4lpwYmm1dHgTByYDDnCnXnkUriYl83gKE5gk6y8ZUd+NPv9j2aYVGhWMIZd3
         o6KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm/ir5RwY3Othx3cFWkDXSAHqnAmcvIEq2NgYu+p8iNTH8+30/yLfLcJNjn4huzcVbomr1bTzj8YP22/haEpiSw56lvyFBGdBRJM08EK4XFA==
X-Gm-Message-State: AOJu0YzcR2IIdIpkG7Q6zIePttKb6nlojYpOxwiAqVT44+VzayWuVfj7
	r8WcBlm4WG5QioLxpUFzCuy8/YVL7EB7bBqLOu85/abG0iL9Xq0Lw2ZL7DQ5Q4qD/kjP7wVn+x4
	UN+tT/g==
X-Google-Smtp-Source: AGHT+IGK7lEMZbXEloyFcWkWnNtovrkJgcXd3lNq1ruLQ78TDJ2ALy68c+95Mra/WGL6eiCxX23BeAO5lDBd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a25:dc84:0:b0:e02:e1c7:6943 with SMTP id
 3f1490d57ef6-e030400522emr31542276.12.1719434247639; Wed, 26 Jun 2024
 13:37:27 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:23 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-22-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 21/27] perf diff: Use perf_tool__init
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

