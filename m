Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8905B136345
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Dec 2024 01:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734313619; cv=none; b=NeMg9Ltrpn7G4+t5Zo9GxlgQqGxOySB/lOK00QK8EwxuyOU4eBzRYb1p4cLsL7gdVk0CZuDAJNlBUA33ShyHh1JlYXnaJbryeK/jS0hbssVAopjCC7V8c1p+JpxU8M96h5p8kJ0pI4EVRC0w+PVrNJCL9oDGUQumUA0r5qxEYmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734313619; c=relaxed/simple;
	bh=iEVYgx/hxX84VyoDEpscAjkrNLwDJylilFK5OuBYN9g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=sOvGxePRaNLO5gqDm0zqhmhcD6QMMLVQrye9Uy+USiSZEyygjIObS23JFyZ7u8ltyTwM4nnHN08ioAcMt9eoFNVj+X7iMjKT/JZB2tvCDYEbNnROjBL6fHZ8BBsQKQwFKAgP2uTxqhdseFE3/ZmumZYNaNPtfnyAPzJE4AN9Zr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2bQo9Or2; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2bQo9Or2"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f27dd44f86so36700087b3.0
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Dec 2024 17:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734313616; x=1734918416; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FTHl2TPsCH6LymZInluDoB5DdWMc8GssygaKpaKL3WI=;
        b=2bQo9Or2DQaDZb+IOytzFpTNi0ar+5mtAPEDnoCgunmAMMS996O8TwFI0hMVGuuaFa
         oqb8vj4Fd5HZAPqxkSRcSG1ZH3gK5+EMyzzALKZhBYhqDq7/aZ6DqRg8zdbssHWG36WW
         OkzCUyxnf1lo0/0ccWuCmxlFaNWqaxWhUe+wmhpl/gpPJqrxSk+8QJiEq9H1Puati8/6
         wYPye/vMAVxEARNf66mzaQDz/5RVFkDLZnQ7weEGbFSi5T759bgSmF91uU1Equlx1hu4
         fLW4E9klkNMPLIuG9Y+5HwsEkjxkBF5LcWApcEeigRRtGG2Ye7w+SMU7vG3r4lYh+J7s
         j2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734313616; x=1734918416;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTHl2TPsCH6LymZInluDoB5DdWMc8GssygaKpaKL3WI=;
        b=dwxVFtnA4LrD24H/XHYdyYvRoxiFGiYrkOyO82jsXlUpah1cAwaGMxweJEwppg6KNi
         lePC25p9ANHal5bjoSyhkkZ3XH+mZ6f0RviB10c7FUmWtWi281OMEWfR9VkAnvkYqyc2
         WSiKnUAo4XX7ACi+k1VU1QwQtZ8larNeWi5lS2OJOOMZIuthh1qCO3O+PEfPJ1n2naHH
         Qv5m17AkKLXRvbf6QoR1l2JI2keRSpWTYyjRJE+BlIjI4BpBthspDNmBcXl+bhzmPm6Q
         axdgY7nTRt3HUU5l/GC9n0XolVz+ciusbiOh9HaI60LC5MFi4EdqxDgQkbcwQqVPYQ4N
         o2Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXVR+odYDIBh/I/5C/QQoQ0EEs8rDOVzQdkhhiI+1xY+U9Crw+StgQU7fAsI+xNc6FKzYKfZx6Y6n+O6yUKHzu4@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/lMbLqltiSFjZSwl7+VxUyLdZvgqRzkyHONzdRv9PN8/+x6KG
	chBjJiaKiiOoRZxzLCHAAKmDjqHkcDV7aX3v7l1EMFQOjs6ttCe7ME0rPnEv0zKAkKZTRDmKH6W
	QOeeJJg==
X-Google-Smtp-Source: AGHT+IHzhopf++xHJgpWcD61mnNsp8wVUb1egX9jwPAyVVZFjVKzSAtoohRp+jls2hjdFscyiBoONmBj9leR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:175d:4db2:deb4:d450])
 (user=irogers job=sendgmr) by 2002:a25:ce0e:0:b0:e25:d46a:a6b6 with SMTP id
 3f1490d57ef6-e434fd22102mr7287276.8.1734313616433; Sun, 15 Dec 2024 17:46:56
 -0800 (PST)
Date: Sun, 15 Dec 2024 17:46:37 -0800
In-Reply-To: <20241216014637.304761-1-irogers@google.com>
Message-Id: <20241216014637.304761-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216014637.304761-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v2 4/4] perf record: Assert synthesized events are 8-byte aligned
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Capture that events are 8-byte aligned and avoid later misaligned
event problems.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index adbaf80b398c..a5689d0e93ad 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -624,7 +624,10 @@ static int process_synthesized_event(const struct perf_tool *tool,
 				     struct machine *machine __maybe_unused)
 {
 	struct record *rec = container_of(tool, struct record, tool);
-	return record__write(rec, NULL, event, event->header.size);
+	size_t size = event->header.size;
+
+	assert(PERF_ALIGN(size, sizeof(u64)) == size);
+	return record__write(rec, NULL, event, size);
 }
 
 static struct mutex synth_lock;
-- 
2.47.1.613.gc27f4b7a9f-goog

