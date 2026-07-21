Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F6A473C6C
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 20:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667490; cv=none; b=l8T7RzbSYEyMHUyFlh45YFxP6Z2oqBkc0xYXwmQYWktmgigIWtjk3gLMzsAXY8YGMO/qkKG49qv3Zws0uxZ9SVrhQrUn7cJucmnNAd8cPnxw7kP0AAqdQGbXrP+OpPR28hR/cGaWqHvdXnKPOgmHLbeSSJMLejMcm/y1zNAVidg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667490; c=relaxed/simple;
	bh=Rhr9/VWiAOU2ysPViZ6y1/ZtZdHQlWxwu4lXWxiMujo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C7nF0MEMO1eAeRcVkHD0FIKZmBpy6ELYiZpJVDzo5cHiQXSZx76918dKZCu++VuMRr4mRFgETxegbFXydG9hjRwT15vIPdT0vsi6Vvyx68B0n1niKkk1vuE48UNMOVgfJcgdWyVZDf4IPtEpsECHBEQk1Y8/OsvUgyzF61j8B7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SaZBC2Zn; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SaZBC2Zn"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3811ae55313so7494484a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 13:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784667477; x=1785272277; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WPc/SptN9OuaHPCuk46SdIx0RLVLfa1pOthKWdfhXgQ=;
        b=SaZBC2ZnnQ5quRLHCQeJ6pmmuIw2IMAbE1D9Ym9M+OWFUvYt+pdwk4aXbiLHwkwKCD
         h/02jhs6nxp6SuGG54yrmnuYZxhOzj7tcc/J68w+7o+xxxLR+xDTqOdvBSoe9juOOX7g
         wlsn8q8n+ZBAUONoKrHFUq/j50t5ThDgC0BbOM7QLblnQE3WkLXmV92XmlIYViF7m+gy
         mrUcSCNdwAO+N78SEJSiPq9Dk25bpbgp+tS1+rL0PMSkLsbstCBtq9Qlwa022mJfZWod
         pKfxcTU08tWslpivH6xunPQwEwHwabYO5iV8L20sI9jOKsMJJPRmnr2xF1ViwztzA1Hq
         ql0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667477; x=1785272277;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WPc/SptN9OuaHPCuk46SdIx0RLVLfa1pOthKWdfhXgQ=;
        b=IxJPfEjOQ9lPlpKMPWT29SKfabfBErj3GpPNUOjNqureuFr5O7EpQD8nvyqAnes0nc
         O1WUl7/pnRFgdQscVBGPNg+7VaiJNe5wCT66SHp6FKTvVNLdV4/8zEmBu06uxISnhh51
         TLOEKTcC+FoXfmSHYjGiT/ap4mSpX7ouKaV4z+MLrRIySN5LzKDTuZ9EsrQuU1diYAJ7
         q6fIcFDKsE1It5A09yALYU7U6SzV69C6lNozPoEZDZvBLpogHhFqtFKljfHltDGKKrXn
         FRrLMk86+SmqBt7dzZbTFn4UpWW0ie8O8THxh/hhczGBg4KHpYjHrb5MQ3O8dhm7sYC9
         Dy2Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr6/133Be1CDdSJqUg/34sy3H7DjyTe3g5Yq07XRPQX1jkfX8YqsjI1UCJQFBxibbK7pmqukBEDNOUmcfI9Vntd@vger.kernel.org
X-Gm-Message-State: AOJu0YzJUtNMiI89rhxOaULYdiU3/M/F8k9reCT0YU9PNaRuAYvxkuMa
	g8D88+QE9xH5RLrYRC5Ql7BTTr2d1Narm7zB9QuLPLW4meUIX6kwDGzjG10WutqD2E4Xb4WEDtu
	5G5GU1ucd4Q==
X-Received: from dlea1-n2.prod.google.com ([2002:a05:701b:4201:20b0:13b:8289:9a55])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d886:b0:37f:9cdf:f03c
 with SMTP id 98e67ed59e1d1-38e4b54082emr19361084a91.31.1784667477256; Tue, 21
 Jul 2026 13:57:57 -0700 (PDT)
Date: Tue, 21 Jul 2026 13:57:46 -0700
In-Reply-To: <20260721205746.183206-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721182150.94016-1-irogers@google.com> <20260721205746.183206-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721205746.183206-5-irogers@google.com>
Subject: [PATCH v5 4/4] perf synthetic-events: Fix bounds and union member
 access in mmap2 build_id synthesis
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com
Content-Type: text/plain; charset="UTF-8"

Modify bounds and union member access in mmap2 build_id synthesis. Bound
max_filename_len against the minimum of filename array capacity and the
outer union stack layout minus sample ID trailers. This prevents both
-E2BIG overruns and _FORTIFY_SOURCE array bounds aborts on strlcpy even
if the enclosing union expands.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 4043d17a6140..704760e1dd5d 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2450,13 +2450,18 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 	size_t filename_len = strlen(filename);
 	size_t ev_len;
 	u64 sample_type = sample->evsel ? sample->evsel->core.attr.sample_type : 0;
-	void *array;
+	void *array = &ev;
 	int ret;
+	size_t max_filename_len;
 
-	if (filename_len >= sizeof(ev.mmap2.filename))
-		return -EINVAL;
+	max_filename_len = min(sizeof(ev.mmap2.filename) - 1,
+			       sizeof(ev) - (MAX_ID_HDR_ENTRIES * sizeof(__u64)) -
+			       offsetof(struct perf_record_mmap2, filename) - 1);
 
-	ev_len = sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + filename_len + 1;
+	if (filename_len > max_filename_len)
+		filename_len = max_filename_len;
+
+	ev_len = offsetof(struct perf_record_mmap2, filename) + filename_len + 1;
 	ev_len = PERF_ALIGN(ev_len, sizeof(u64));
 
 	if (ev_len + MAX_ID_HDR_ENTRIES * sizeof(__u64) > sizeof(ev))
@@ -2476,16 +2481,15 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 
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

