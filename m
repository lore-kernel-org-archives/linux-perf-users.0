Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9490823A9
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 01:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264501; cv=none; b=daCYfjukIccyewtkHR2bhacH/+ZYAe7Dbt/FkE1S7u0RqKuTXqWVLAkowcnJRYy9xwSeWeLK30wGWvbUrvyAS9uFnuQzW/pUk/1wEtGNB67VNlmP9dkQOnxjiz57zDjC0Ezqp6l1g9/4vICjlT99Ts6MlMq98MZTxggT4zaGnvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264501; c=relaxed/simple;
	bh=Nt/c1EHasj2QZc8mVbjZQ0vxsj7VTWwQPPvRYVn2ii8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=p398BjbB+ZRIms+Ltx6TzL0mHxHVE3xE2uI3Uw9ow901WgiJD5gB1bhrCvfoySnjPUEy6MyFzfFS2kNQYJJ58QkCxc17BYamCEeqgQMK+tQ9Z7RRVtN1VzRDbplZDFBsj77Kuu15f9g0SzBDRKpDhFigYo6xspKi5g7sxwNzgjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iC3rjNlq; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iC3rjNlq"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64b70c4a269so6457917b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 18:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264499; x=1721869299; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VI+1UrmSH+U4tsTCU1WpnUiPEx/6DVcJnUZK6PtxySs=;
        b=iC3rjNlqtXu2d2djsF0UBPeTT5+7b++di0WS/SZsizZ74v6G8vHppOLITCVRyJMXlu
         kn2WotlbgrBox/E/KSrVHkMzoqs+8X8uhYgA9wO3QgJsiM1gtEXuvtZVXpMvBUsReu17
         kWtKhCuAMuD5Veqxan8G7f6yTqnTNTGcyRP9syna61e406YXghn2ZfZj6Y7aE78YhIQR
         XUG/1I0YRcGs3+wOyui0/aVfUt5jOFZ85yZLZsQuYNU/YIfi61slZGAHIqZQEtNSL2DP
         n8UPpt/nCpu4lHoep+bF9ncH8Axs/xfc8NGL35FauW79WOqCvX9z47KRq5nB4wn22Ftm
         aAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264499; x=1721869299;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VI+1UrmSH+U4tsTCU1WpnUiPEx/6DVcJnUZK6PtxySs=;
        b=HXp6fL3pAULvtw6kfU4AbE3kpsqlclU8/zPuVOqR7W7GcqcjSznDVqAGN0EjcUdBkU
         WPkyWR105UITyDtiy/LRDxymY2FS+KhYbpLPFJh7FTfdjbdl2neiUIrNZd0EVbpKvM+4
         XR4ztupMTGiTAMOhmezwlfllwCACXL822cWw8wyWTbU9tYBRS7lc2TUpO4HVDt+cZBWI
         B4sN5ubKu8BGXLtW/AqoFAk39HDJ0YwUQKr2I6GiBLCw+Lr5s/c3gk88xb40+8SvKGTn
         SSYH/9uy1WdvF9Yfbc+B2/lifpPbwPd+/0WXY1m6RJJayGRcnuQVPZPxhqe+JGzONz3Y
         rJuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWdpqNdGnxB+ogBcCkLVS8IddWlQW0pWsVSi1I4jKIH5Yp/fi3h+g5vcIyFeovII7ufFX4QFJvid3asPt5J92Z/U7zc0vf6fJQd9faSgEmag==
X-Gm-Message-State: AOJu0YzYQleTR/NxWVMXOmoSnq1iRI2kmiCNpWhAqQC8KFEknmc3VdH1
	N0JZT9U9GnEV8oNYj/4pcYYOy+7IGPOdbEjQK2UOw0FrsIxgohm40kVaevzzi321Kfhg+TdQ/fX
	U/nhaMQ==
X-Google-Smtp-Source: AGHT+IGQt5ri8LAL7TX8J0R4Z6KxrCn64uDLn1sYG1dmmUfG8en4e1ioo3g5nWqMwIk/M1O4Qs9bCX+5dLdq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:690c:110:b0:65c:1db1:9235 with SMTP id
 00721157ae682-666005395bbmr263907b3.0.1721264498698; Wed, 17 Jul 2024
 18:01:38 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:23 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-28-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 27/27] perf session: Constify tool
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

Make tool const now that all uses are const and
perf_tool__fill_defaults won't be used. The aim is to better capture
that sessions don't mutate tools.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/session.c | 6 +++---
 tools/perf/util/session.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index ad5da61d2330..0c7cc092887d 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1765,7 +1765,7 @@ static int __perf_session__process_decomp_events(struct perf_session *session);
 static int __perf_session__process_pipe_events(struct perf_session *session)
 {
 	struct ordered_events *oe = &session->ordered_events;
-	struct perf_tool *tool = session->tool;
+	const struct perf_tool *tool = session->tool;
 	struct ui_progress prog;
 	union perf_event *event;
 	uint32_t size, cur_size = 0;
@@ -2195,7 +2195,7 @@ static int __perf_session__process_events(struct perf_session *session)
 		.in_place_update = session->data->in_place_update,
 	};
 	struct ordered_events *oe = &session->ordered_events;
-	struct perf_tool *tool = session->tool;
+	const struct perf_tool *tool = session->tool;
 	struct ui_progress prog;
 	int err;
 
@@ -2245,7 +2245,7 @@ static int __perf_session__process_events(struct perf_session *session)
 static int __perf_session__process_dir_events(struct perf_session *session)
 {
 	struct perf_data *data = session->data;
-	struct perf_tool *tool = session->tool;
+	const struct perf_tool *tool = session->tool;
 	int i, ret, readers, nr_readers;
 	struct ui_progress prog;
 	u64 total_size = perf_data__size(session->data);
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 7f69baeae7fb..7c8dd6956330 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -43,7 +43,7 @@ struct perf_session {
 	u64			one_mmap_offset;
 	struct ordered_events	ordered_events;
 	struct perf_data	*data;
-	struct perf_tool	*tool;
+	const struct perf_tool	*tool;
 	u64			bytes_transferred;
 	u64			bytes_compressed;
 	struct zstd_data	zstd_data;
-- 
2.45.2.1089.g2a221341d9-goog

