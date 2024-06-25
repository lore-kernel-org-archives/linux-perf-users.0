Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9E5181BB5
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336432; cv=none; b=AiYNyBXl1GgWEA3wtrPU7wHbF7wy+OJijN+XFe3bpQXs6TJn5H9aCx8f/Ai/Rz1/+rhgn0GlajO9HasNNg0OuLOtFpMN/LAEZDFY5sdQIWLLdM7Wb7Kp7rzVMSN43M1H55YfN15D0J116MINuY7resv6LwXtKYzjiqbmFXK4gYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336432; c=relaxed/simple;
	bh=PS9rnPx3TBvKs9AyDXa3qau8sXJOlLW6UOldBMQhyOY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=g4RoPHGu+5AwN41zfzj1AlIPNr46OZFzOOuX3I9gIK39BMHmkicoDVOOovTRAbPgaubOfTeYgsiDumZWGe/sF5uHkgY2K09OGZADlhuKj+JPWhFXbONwZY7QxQnpB6ZyAJaJsa87WF0dlgRgl2ZoanLmsKQlMw/ISZXATuRiBbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eS3An/1r; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eS3An/1r"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02f7e5be48so7203067276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 10:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336430; x=1719941230; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ePwcA0wK3eP96yB3zQLlKRYoL1FvQsP7l/J+ZxdqnIs=;
        b=eS3An/1rxJPD4A6rbACL9PysiYTTHpK1SGKM/kdxOeBLOWtqT1eS1aVerqkfuas7xX
         u2Y7kBHbhmpzd35VyaOfG/ZooGUSOJY3AQSQnHtec3PznXFE4xE6Jtp39MQwxpYQnCq5
         fRUdrgAJoYukxiOtBesSXzm9cP3XHzKEbpIJwc3hw6qKykI2AeqcchOP9MujMgp8FQl9
         wVbYqVlHM9Cet4vJ45VmqSiZLhwtJQxNcl5mkrsxuQGoqxuxnIKxlk+HsQ+Yq9b3uglK
         o82yvv1/rwLgmHhe1MJ4U8l32jNPb6ND410oYg7DulgzcaVIUQyO2fUQolQF9EWLOr80
         Yy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336430; x=1719941230;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ePwcA0wK3eP96yB3zQLlKRYoL1FvQsP7l/J+ZxdqnIs=;
        b=IUgJ5DLVyZb/zCz9GpDAVAjAFa/YmdjDM4r+XEQF3JH0yOvcz8bOxXbJHjkDI+t1UD
         0rnEdl6qCHvzvpamdQB0datHm7R/MwNDxbhXQleNZx9+DUxLFnyx4W1Ijw15j5XOJxep
         sGs8hzMjCP0QkQZihER893v8Fw+7ORpWjkHpLwlrKvMUImL4Xt9VILOt8AwsB8099hEd
         OuAZh2F7qLoUBmXDnt4Goctd+YTk9WnrKS5cSVt8RctOhYJR856NrKIY4UpOWjce7U2W
         8FXDGTyGyPIrfmVRQU6sGv+2UxxB8wxsoYCixxfn3Cb+bHc5Gxt/aYlojGZlnFU/mOy/
         71Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXTS73TQ+cD+E/QtmmTTTLCXDfArz1zgomL0BbCHdIDxVuxQWktx0SD1QIw3jD414xXROqRjFOQ7yufuFrce2DnYxNgpqhA9S6oZ09rKYxkhQ==
X-Gm-Message-State: AOJu0Yydft3gqjCXIPCoDWPcIY4fwWHuWglne29xTXF+KF5iHsvoAIku
	AW73TZQv4g1KUg5gNhudHoy9RzXMvwPz+QtQ7rmJZXfJeVlGYdc1gqhx7i4QmMc4CHPORWTGor6
	W8hxkmQ==
X-Google-Smtp-Source: AGHT+IE+/1PkjC1dbP/eaOr2B4eDXRhOCZRz2W7LBZe3kC40WE3zktf40ITuetYB9yqxVda8D4GvJJ4iAyQg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:6902:704:b0:e02:b093:dc1f with SMTP id
 3f1490d57ef6-e0303edb60emr31288276.1.1719336429820; Tue, 25 Jun 2024 10:27:09
 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:26:03 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-27-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 26/26] perf session: Constify tool
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

Make tool const now that all uses are const and
perf_tool__fill_defaults won't be used. The aim is to better capture
that sessions don't mutate tools.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/session.c | 6 +++---
 tools/perf/util/session.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index c84a060b588d..66142420e497 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1741,7 +1741,7 @@ static int __perf_session__process_decomp_events(struct perf_session *session);
 static int __perf_session__process_pipe_events(struct perf_session *session)
 {
 	struct ordered_events *oe = &session->ordered_events;
-	struct perf_tool *tool = session->tool;
+	const struct perf_tool *tool = session->tool;
 	union perf_event *event;
 	uint32_t size, cur_size = 0;
 	void *buf = NULL;
@@ -2153,7 +2153,7 @@ static int __perf_session__process_events(struct perf_session *session)
 		.in_place_update = session->data->in_place_update,
 	};
 	struct ordered_events *oe = &session->ordered_events;
-	struct perf_tool *tool = session->tool;
+	const struct perf_tool *tool = session->tool;
 	struct ui_progress prog;
 	int err;
 
@@ -2203,7 +2203,7 @@ static int __perf_session__process_events(struct perf_session *session)
 static int __perf_session__process_dir_events(struct perf_session *session)
 {
 	struct perf_data *data = session->data;
-	struct perf_tool *tool = session->tool;
+	const struct perf_tool *tool = session->tool;
 	int i, ret, readers, nr_readers;
 	struct ui_progress prog;
 	u64 total_size = perf_data__size(session->data);
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 5cdef3e95c08..66a302f16784 100644
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
2.45.2.741.gdbec12cfda-goog

