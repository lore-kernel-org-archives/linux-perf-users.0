Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAF017D355
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720878; cv=none; b=pTBy4L7RMUypztASbsK2ErEd55gSdEdE8sMCMIZXfUkqzH0D6u09w6FM4abjcJi1FQ2HV5wUbc7GHq/iA2bIHURn3QEaeUovfkOLSDUL8FkdYTRpiM3jgXHmzX2+xKZZhRTmbZpuyL419iwKcFp6EpX+rBUjP7YeBbxDwh7BEDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720878; c=relaxed/simple;
	bh=sUheNSIamO8SvMj19zBLNxCVmjvlLRxDlh7AUAyjtXE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=iS3cRp00zUnNYGQkqxSHFZrXaDCOvzqv8JXnRWxApTziiZOxNjMvR99Va31gvzDqCuVjjNxvHR8xYS/iuCSN3FIJBJra5ZCEE4QWz4UsqIzZAtWJB8q2Iew/J8YbGHp9E9+UBsHxZb83ip+/1Zc2Jvg59cgZjq7cnCu34GIkXiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A62cr04h; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A62cr04h"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03a7949504so1956005276.2
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 11:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720875; x=1721325675; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DzgUQ0L67yHK9ZgYOmZnLIT3MZDT9EVRhOxDmj12OGQ=;
        b=A62cr04hkQQibp8J0OdcECSoPMzacbWQ/GxOr3Az4CjlWJJe12QTN8OUPgQSRlkVhF
         ENyvH1fbqpWq/A5FViAXBwUCHsV9FXQgC4lYX/GN33y6VApwYa9+vs47xiH+vOozn6Vq
         rff/IzHvuo8VlT29alNRbdHzWcyBDzAUo3SeZ5o2OuOSDioa/57NMBFsh2bGG7WChNdB
         fjSEbn5wUDbv3BCVnukhWLAOn5EygM+uc9LV9ttxFn7GAwO7tYNBK+3cy7wPfra5io+o
         TWDdF2QH0Nchz4oAL5oZ/OZWPaYGZiZy22rBGWNTXxy4tMQlC3ak5HoPtTJU7bGVq2Sd
         2NxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720875; x=1721325675;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DzgUQ0L67yHK9ZgYOmZnLIT3MZDT9EVRhOxDmj12OGQ=;
        b=pF35OBEZxWbJD6EdKbuVPOB7v/mUVEHylh5R/ag+tDCXNd9kOZnscd5zAFmBSNR9fg
         uN8MhoxjkRd2TSW7OrHOBDHzb1wSIHc8iiexcxHXCtRzEWuuM4ixSHgFdEBElyLn/Dxw
         cOgQeJ2ZnK39NweyBPbLUwu7BNTjzelx5ez71bjYEiRIa8UPJrEPEnNn1TWg/AT3e9k0
         OpCQ2ZSyY9pDUqrhbe3rY0DT6FMO3qrUQ3paTWmq2GieGPKEKD+PtZ/ZRN6nm4hCfyxa
         gtpeJEi+606rC83ydeuAPa+Iy6M71wSH4JTka5Mv9Nj5RORGrQJSYd0ZHRUhSfuK6Dto
         B/lg==
X-Forwarded-Encrypted: i=1; AJvYcCUd0nLCW1MiqYyAzY9wM1fxnv+v1naD/TbDlLovPpWMhrMNMbhkpwSlGNk80xdsrUaHbvuE2un5/NMqY4JW7lZGuNGIabCmMaPfvVc2MSbpFQ==
X-Gm-Message-State: AOJu0Yw14AwoZFP07gL2ZdqG5U2yGGYJFEEg9j6Mu7+3zNcu7rhqIgNx
	YulO5cmIeus9ACLAvimazofFyJh9fWMVrWvaFIidkdgcwE5DcJWyj3yz9T00nPvoZa+U0ZulIGz
	YtQsp9Q==
X-Google-Smtp-Source: AGHT+IF6ZsAvtsfjEpCo3Gdjx73peL+tpHFo6fSjhaKLM0gD5zmtULo0VxwhlOW9Ohb+tLATOGzcVSe0U1oD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:6902:2403:b0:e03:554e:f396 with SMTP
 id 3f1490d57ef6-e041b05b915mr366242276.6.1720720875256; Thu, 11 Jul 2024
 11:01:15 -0700 (PDT)
Date: Thu, 11 Jul 2024 11:00:08 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-29-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 28/28] perf session: Constify tool
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
2.45.2.993.g49e7a77208-goog

