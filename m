Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D5A46EC7A
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 18:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784658133; cv=none; b=kR/nBjMATMtZqz6JlWKNlBLyj+VdRLU9H2SlsBxPIvM/7fV44i/c1Vj+CZEPogbQTkqwCy0SyR7MYGtjS0ic7O/8dqFnMPRGtBilOMWESfNzKOK3j2lLGw0M3pv3J+MYXb3LJbJMtgkevSxgn6VHz/JAxgB+uJkUwas3jP1bhq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784658133; c=relaxed/simple;
	bh=A7ELJzohcBlvD9DGCB6ldigxQdAFB2ZZ7CW9ki6fKqY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=krisxKDcXfkR6z8KtkJb55nGu7RHOZzx4QVOIrKy9k3zIMG+kIwB7izb2H8dSnDaDHMmMv0Pq1gyeg4YmD9KGaXR7DhkdUqCOiKTBfGNLjkkuGeShH8VfVQseb3E8IQtlvW60kfkjmFpAFhQ0F5s44PCkKAsK0DUlIRVWrxKz1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cJKqNkk0; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cJKqNkk0"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbb6433e9d4so1733542a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 11:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784658131; x=1785262931; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BE8WZ74FQc82iPrgnQrSwAZj7UdSUheiNt1ByX8Xbi0=;
        b=cJKqNkk0jYfOdpF0f/twIHfYLbkp5tnVoc499ErjaoAJFAH8CzvKdGqWnwpSJKGBh2
         tXvW3UyrRKcQCmY+h1uu0BM1SUjzRaZCFUicuFGL6A1wF2ObgoSCywUnCTSMivBdNVF8
         jK+7otU/FlNZVEg1kS0zrJ56ED0b/hkJHeTDTwFtE3jhb8OPoZHEJRj0cDk4yyWAQiZb
         3hC5/micXblpZhhkhAxAvl0ezqJnq4u9vylY2puLxKaIjVhzO3MMR7JAFP5EgFvbODIb
         Cw4DNs7C7362QORr4KLj9oeOm/hHhgQbSaJrm8i2GU939fdVKmk2Hd+jeLQEfAkLBUJf
         T1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784658131; x=1785262931;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BE8WZ74FQc82iPrgnQrSwAZj7UdSUheiNt1ByX8Xbi0=;
        b=j+N4g5LTIP7bYPsH8MIYPnU/tQcdyayObY17D7W+zFWMRYcUC2LVAXzG6q1HEdBgH2
         AsDkXRD0xgzZh2H53TsddFFi4rug9Z2wT++oGg59uNWBVKeBrCoR5xUkKvhryAs3gg3M
         UKMWbK/Td5LebRnUF2GFjlttxbsUEmpEu/Lxsitg573Fige/C3Zl4KBy9oeCsvNLqTG3
         +Hu2/O+igYJSdc4ircCVsS/WrfZ9FveAdDyTanY0JTy3C97mBAYqLb9+LiNINzJl5/U6
         0TgCm7oLMXDQaNWGI4eDtTMKICwavm5g4t1Ta14QdmOcWk7g4qgwCJEaWbf3eWYsZVhS
         1xHA==
X-Forwarded-Encrypted: i=1; AHgh+Rp7R6ZZ6dHRU/Q4mCPbz6GFktNU4R3ujL94QGVKRtARfZ2npWcLOwkx4QrYtbrsKTPJ3SdP9JhLZoClzcpbVlT/@vger.kernel.org
X-Gm-Message-State: AOJu0YwXD+Bq9CwwlrXvJpqXrsQxUg9zVvfs0pGGRj4swF+IxR9GMhY+
	dMc9fxIxXZFuvD6dCfGqtVucCHMGLH8KSCGyxNcTTUZ65udYxBkoEOwXm5CONz26a3Ka89SqZkJ
	NYZHmmnMZww==
X-Received: from dlbqj15.prod.google.com ([2002:a05:7022:ec0f:b0:13b:4811:2202])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:728a:b0:3c0:9c19:6584
 with SMTP id adf61e73a8af0-3c3ad9a1868mr21570949637.62.1784658131000; Tue, 21
 Jul 2026 11:22:11 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:21:50 -0700
In-Reply-To: <20260721182150.94016-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721173347.9163-1-irogers@google.com> <20260721182150.94016-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721182150.94016-5-irogers@google.com>
Subject: [PATCH v4 4/4] perf synthetic-events: Fix bounds and union member
 access in mmap2 build_id synthesis
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com
Content-Type: text/plain; charset="UTF-8"

Fix a critical logic bug in perf_event__synthesize_mmap2_build_id() where
the wrong union member structure size and offset boundaries were utilized.
Safely calculate the exact maximum allowed filename length to guarantee
absolute stack and alignment boundaries for ID sample trailers, preventing
-E2BIG overruns on very long filenames while meeting strict standard C
compliance.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index e547874b77b2..06a960e8ba85 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2448,13 +2448,18 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 	size_t filename_len = strlen(filename);
 	size_t ev_len;
 	u64 sample_type = sample->evsel ? sample->evsel->core.attr.sample_type : 0;
-	void *array;
+	void *array = &ev;
 	int ret;
+	size_t max_filename_len;
 
-	if (filename_len >= sizeof(ev.mmap2.filename))
-		return -EINVAL;
+	max_filename_len = sizeof(ev) -
+			   (MAX_ID_HDR_ENTRIES * sizeof(__u64)) -
+			   offsetof(struct perf_record_mmap2, filename) - 1;
 
-	ev_len = sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + filename_len + 1;
+	if (filename_len > max_filename_len)
+		filename_len = max_filename_len;
+
+	ev_len = offsetof(struct perf_record_mmap2, filename) + filename_len + 1;
 	ev_len = PERF_ALIGN(ev_len, sizeof(u64));
 
 	if (ev_len + MAX_ID_HDR_ENTRIES * sizeof(__u64) > sizeof(ev))
@@ -2474,16 +2479,15 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 
 	ev.mmap2.build_id_size = bid->size;
 	if (ev.mmap2.build_id_size > sizeof(ev.mmap2.build_id))
-		ev.build_id.size = sizeof(ev.mmap2.build_id);
+		ev.mmap2.build_id_size = sizeof(ev.mmap2.build_id);
 	memcpy(ev.mmap2.build_id, bid->data, ev.mmap2.build_id_size);
 
 	ev.mmap2.prot = prot;
 	ev.mmap2.flags = flags;
 
-	memcpy(ev.mmap2.filename, filename, min(strlen(filename), sizeof(ev.mmap.filename)));
+	strlcpy(ev.mmap2.filename, filename, filename_len + 1);
 
-	array = &ev;
-	array += ev.header.size;
+	array = (void *)((char *)&ev + ev.header.size);
 	ret = perf_event__synthesize_id_sample(array, sample_type, sample);
 	if (ret < 0)
 		return ret;
-- 
2.55.0.229.g6434b31f56-goog

