Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06934470449
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655251; cv=none; b=dyk2UpFvkuppB4UYiwn/d+iuSjn/8oUOOnVREULJJWnEXJ1lGo7ZGPZWdJ67QgrUZebALrQFAiHVv/2riWvJBwNUL0sSwSZF+cn+RLh4OqylEb8FYlw0pw6iGcBiu5sCwCFyT3yGBVHE+KP0MQqmpcl3nTm6K/O4IEvN7R6UwqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655251; c=relaxed/simple;
	bh=CEzrLZPHqPdQhLMLgsk270qr2KafmCep5+ZkSOMjTrI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RPgWfhuqnt2kF2SEDukX9G9Vi3LP3H1/xroTNXUKwnB5AzLgDuOXy6UPPJEP4ClVTd8AtiFAx+uNCRSPlx9HkxI1R8gNrxbuv9BIM5Q8+/fWvccTCORsY1QIgd4fgS+C4zArAIz4R849QmyYUgHZJMIZQl7k3HJfb59bce+eQcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K7eqcyYp; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K7eqcyYp"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so195850a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 10:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784655249; x=1785260049; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ypc5c864N+DZk1m/raoCh7jyW2ktVuTgipXiePtRM3c=;
        b=K7eqcyYp+wUTsWX0N4hgLz8pLiY+jlbwg7d7Iv/5b11hRoVE+6UhisQ9hEHDwarGW6
         XdjVqNwldcmvGfRzNKan0UdeJroU840ozxdZY9u1Tk09IfMdFqEEuEH1Qp0blfyX7g1/
         wDcy3T8srUXmREg/WwB9H1rY1QwWpWJYu3kdNFFyS+7Fr7GtSiUTZXMplPaAH1WVMCF9
         9QfExzjOKmTCOspVRbR20XD4hW6cl2Rn11uVKksZeFlrL3XB/IRZxW6B6af/KYA7xsJx
         f/j1TuTM2zC9Xu2mFQktJY8Tlf5mQ6crLthoCpIRXtWx6HVjM9qD/TCkaWMqufCIEB40
         l0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655249; x=1785260049;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ypc5c864N+DZk1m/raoCh7jyW2ktVuTgipXiePtRM3c=;
        b=lHaL+yjMWOPxIdtoARIXTVf8KBc+vOYeL24Xhg9o/iH2Q3j2cQUJU2NKHl0gavQcpp
         nmLEYwdjjamgWPrixx+i/+ZBFz0tTN1jkywcEUOZ82/FAUSZBxEgH0tolrnHENOZH8R4
         pSseALP5I5kQBqs9VwvdXB+r7yfya6aSEAXUIiR88F71p80h4iktyU7ArXfyFPHVc4xk
         /yFm2VFew5Wpi8q4WQi9uOsyR/+yasSoXnRSmGPlk9EJTWV9H7FmF39ddAQoRS3sjXC8
         nFGECz8aqHakjQY7IgzVp2zXd6iRcHsyiFFJ+iO4d+M9VIukBZLaSwqHrwXh67ZXgX8A
         agZQ==
X-Forwarded-Encrypted: i=1; AHgh+RqbM8XHOO65kQhebuXdpb3DvfY4Thq9al+1RIqBwrbbA60S2L6vLlg/u/DSXkKPe72JMN3IrI8XYlQ2RdGrILcd@vger.kernel.org
X-Gm-Message-State: AOJu0Yz62iJDyMM6sYSGPfy/6tBRpSXwwvEdSE2qX/YPYTNyKGpU8NFw
	0JqqDokyhaDgg3iR+i4vJ/lyBkVfOdCFOYqKW34NjI6K/F/L1lh6oUfPcuCEyZ+lX7fMA5gw5bj
	TDVtSHwVn3g==
X-Received: from dlbvg20.prod.google.com ([2002:a05:7022:7f14:b0:13c:f3ec:ddf4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5604:b0:37f:9ce2:348f
 with SMTP id 98e67ed59e1d1-38e4b55ab8dmr19806756a91.32.1784655248954; Tue, 21
 Jul 2026 10:34:08 -0700 (PDT)
Date: Tue, 21 Jul 2026 10:33:47 -0700
In-Reply-To: <20260721173347.9163-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260720225200.3810501-1-irogers@google.com> <20260721173347.9163-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721173347.9163-5-irogers@google.com>
Subject: [PATCH v3 4/4] perf synthetic-events: Fix bounds and union member
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
 tools/perf/util/synthetic-events.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 068323b9510d..6477a726c8ba 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -298,8 +298,9 @@ static void io__drain_line(struct io *io, int ch)
 	if (ch == -2 && io->data > io->buf && io->data[-1] == '\n')
 		return;
 
-	while (ch >= 0 && ch != '\n')
+	do {
 		ch = io__get_char(io);
+	} while (ch >= 0 && ch != '\n');
 }
 
 static bool read_proc_maps_line(struct io *io, __u64 *start, __u64 *end,
@@ -2447,13 +2448,18 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
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
@@ -2473,16 +2479,15 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 
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

