Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34DF13DDCD
	for <linux-perf-users@vger.kernel.org>; Sat, 29 Jun 2024 04:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636913; cv=none; b=kRztHleiD/QEoPo9LqDWS/moG4EAlDKwza3PfhOjrXH6oeok4qhBL7EyTmXmQz9VTk/n4qHeSlXx5+WgUkqx6cTKNCQp+yrWs66gpkuhlPYEiDWCKtJ464IeO0w9sgStJAdMhJml+afsluq6hsyK/T19WNx9KH8kx3VxOXR7ltE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636913; c=relaxed/simple;
	bh=LHUR1TtI8mjnffStNAsHkz9pS7nlHhMp1tJRMZ9MeSg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=jH6E089Fz1dJf93jB88OfX/5as/q3yMLaOy0r9+ykxgM8pjnbYxHyBrty0tzwb558H+RRlA0j3UdBKVMo/nwKzBPx1zW1rR0GuUCWPn9g57D12mqfhD9H7Os9KfQZId/HxkGmis4oLZvpwwofCHh2Jrb63CTcK150EkBz4f4lG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fvcNo7j1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fvcNo7j1"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64b3c8153a6so19488737b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 21:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636911; x=1720241711; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5I8Dk3Jx18DLwgnut7bHcO920rFAKP8Txv5pQFBGNLA=;
        b=fvcNo7j13pqJty/CVGWl75FCEgaUjN2YrgxfkgIA5e2YUzL1IWEzwRMVkcLb0XmbNZ
         xGydguIpDITqpARLL5xRLp1kfAUJpFiTmfrktGtxQ3EGlUGnZCIrSL9AcO1FGBSBK6VD
         09Otdn0RrF1F0LAP1XQz53JfCEqGiEAZByvU6veSpdst8E0tlZ2u8pP1BR+pq6NzOjLg
         No3Efkl6VG3rbVzlvilkzZF7Jh0wpQfOiJ8rjUWkQIl35ofvZmabJLnarBWWHIst7Msk
         JlBPty+vIaZyfgmA7ooJumP3SykEzvIy4ZXlJ/RfWVK5pcuys7kHAN2JSpcR4mhCQOIW
         8Yfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636911; x=1720241711;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5I8Dk3Jx18DLwgnut7bHcO920rFAKP8Txv5pQFBGNLA=;
        b=k//cbEEHIqfLEzUZO62cSNt1UagK2seiH0c0SMcAGhWNyCz+XRhBtpfU0I//TezcOI
         KkKQYHTiFcff2iFn+vv4JhMkd254pO0tVVUbRKmDNwiaMKAMkDeqidwThQp7jQBYg2TP
         6MTF6Mr9Pfr6s4gHOaofD6ER9uCwZfpLSSotiyR7LQN227QI1ZAuKZ+837oE2aa+Ms3b
         9VHxi2WBGUzEJ8Obn9lAhRDz+DIRGbXeiSXYnVjoX28SaRpEqBoHVu9vwuz5i5IVhPCk
         ZSmmZxnEznhn9sQUOlxtRuuHSt8SiJuI1COAZ1x/J/lv2KOER+bOZ/r9Vi+jRZLwawr/
         0MOA==
X-Forwarded-Encrypted: i=1; AJvYcCXbLLzRwcb4Ws6MUd7gkq9Z+fFXuGJQEUChuQSvLPYbhTf7JghNz7AR2mE/CL0s7/2LJ6Dtz1hx+KY5pJkTjx8pHFTeS7e0NBosqR6M+9s9nQ==
X-Gm-Message-State: AOJu0YyR3I2WM4GWSUjshZxzULFFzACG7sCejEI4E3PI1NOEIemmSmuw
	REr371cu1qoATWfcRqfwzM2GCyfijvEQs0ys2UIqz1gUbKRj57j4o35iFaLcgtJhP18NJr7LiGk
	hCkzMpQ==
X-Google-Smtp-Source: AGHT+IHlhj9A+3l7M0c3Zsg//bzFK4sGoQmqySkzynjsb5X2abAc4H7qqAulmEHW+TVVXLld2Zhy5UyS6h0g
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a05:6902:150d:b0:e03:554e:f396 with SMTP
 id 3f1490d57ef6-e036eb5c458mr765276.6.1719636910826; Fri, 28 Jun 2024
 21:55:10 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:50 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-29-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 28/28] perf session: Constify tool
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
---
 tools/perf/util/session.c | 6 +++---
 tools/perf/util/session.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 6f5692902892..e0eec409e951 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1771,7 +1771,7 @@ static int __perf_session__process_decomp_events(struct perf_session *session);
 static int __perf_session__process_pipe_events(struct perf_session *session)
 {
 	struct ordered_events *oe = &session->ordered_events;
-	struct perf_tool *tool = session->tool;
+	const struct perf_tool *tool = session->tool;
 	union perf_event *event;
 	uint32_t size, cur_size = 0;
 	void *buf = NULL;
@@ -2183,7 +2183,7 @@ static int __perf_session__process_events(struct perf_session *session)
 		.in_place_update = session->data->in_place_update,
 	};
 	struct ordered_events *oe = &session->ordered_events;
-	struct perf_tool *tool = session->tool;
+	const struct perf_tool *tool = session->tool;
 	struct ui_progress prog;
 	int err;
 
@@ -2233,7 +2233,7 @@ static int __perf_session__process_events(struct perf_session *session)
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
2.45.2.803.g4e1b14247a-goog

