Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F55129D19
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Dec 2024 01:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734313614; cv=none; b=UAZqpcIs+u2L1MKFfr9kGm2NrozSHLID8xhRkuA5ZuiFEV7qcd4WXu0v8OIxOshASNDGn9CIPsF1GSKqFYEdcaweUFxLaYetoVif0gz8jWpJJ6SrUEgNSgxw3ACj5YiHWmKo3a16ddBBwcjhgxw3Lr3/M7thxkA2VaXNRXJ/u9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734313614; c=relaxed/simple;
	bh=BrUJvr7HXzMJyoNYnziI4wlrd5p8WOXp8dhXnVgi80k=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=YSQyI7sjaUQJd6IQnSncy38YjOUjKpJlo1D+3gCjFQXZGI+Po5//m+kMHTJUKDQBO/aXpKR9HfOH46qTMzQt68vxVSbiPU4aMb1dHwf0qQ+OKk/F8m1G4wfzjOD/2GlUSUoUKOJ7+r+rGyAA0pskPJTBg1FX8FHa867uPYltjWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HtVt+Ncb; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HtVt+Ncb"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f28f5f2c5eso17487867b3.0
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Dec 2024 17:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734313612; x=1734918412; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cLJ1stvpEh/i9mxehEqquhSJV82oFfMq3Eq8V809bTo=;
        b=HtVt+Ncbj0ke2mXvsTWPVqooTA7cR4aTCPPleArCr0mDd/Y7K13uzqxpHWD3XIkmrY
         JDKMb8T9XdBbvZwoSSxT5tIBWxDuUOS4Jy9Emb4b/3XUhfE+VFxHPz8A4yNUJoc9UZJc
         00UjjDvXY2u/MDFnEtJ9JX7Bt9wlQE3puVXCjEDUzm/ICzhI6cSsRVcgKkKxwSXPepBr
         SXR8kqvkI9EMQT2VLvUEmEA3qjmkHfiBcSIF/Gr36YRxAER8wQT5lh/7rDyqvERyCeei
         D2upK1zEh/ryGCZeI9T1FJEe4OeKe+tHSM1J0emSPhFpl3euwncPt/D+Edm2quLS8J+a
         1fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734313612; x=1734918412;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLJ1stvpEh/i9mxehEqquhSJV82oFfMq3Eq8V809bTo=;
        b=wA/Kij8Qs7+VCCkfmjt+OZ+aYXULv/R7fFAfMgvzYNUkZY2i4rhjESNUy1JhaOuQlO
         XQEnKT7DBdt91EGwiKvzspnjr4i0Zdiip2bjD+LK5bJf+sHYdA9hAYUapgZBvqzX3RfE
         u8CzQusek8ug9rrGfrgWy8HJf05CR0+DbiW9xNVe2oWoT3wqM6ogh1V7r6xUI9f2xyVf
         nyeVofTh8nA+FOWfvyy2E0LUfUNOl0LU4Z2Q7LSUcT43T64JskIUDIRFKHzy54cMvUHk
         0ygasB+GG/gOEMTergMLUs1ubwaZgcVYLXGT04IR4htpZvWpttJeVGhXJfv/DlhPVxkL
         G4+g==
X-Forwarded-Encrypted: i=1; AJvYcCUi1MW2z8lVvs190mRNNIE0rKoKmohv+pASOg2LokxC4ho/tjti7+EbisaCiBMVLskmmyLz2z1iB5xV/A+Xgg4E@vger.kernel.org
X-Gm-Message-State: AOJu0Yx822UQzkljiPjvYCm8/Jm1/OiN0xCECQBsNUIL/alc0RjodVIQ
	1p6+RlefK4wyAXjPITrVgbPBjJ2df177HCLxLzTMkitDC5MA9x4ZvOkpwxScwv1KdDsGRsGyIK+
	En+qqRw==
X-Google-Smtp-Source: AGHT+IH2cUWwsL9JMjl42pSLLJeRpiHnjnnVLW9VC1RCfNNSRe+MuZYjvNjozP5TUM4BheqLIjfDT3IzB3go
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:175d:4db2:deb4:d450])
 (user=irogers job=sendgmr) by 2002:a0d:d107:0:b0:6e3:d670:f603 with SMTP id
 00721157ae682-6f279ba2810mr1250687b3.3.1734313611808; Sun, 15 Dec 2024
 17:46:51 -0800 (PST)
Date: Sun, 15 Dec 2024 17:46:35 -0800
In-Reply-To: <20241216014637.304761-1-irogers@google.com>
Message-Id: <20241216014637.304761-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216014637.304761-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v2 2/4] perf synthetic-events: Ensure features are aligned
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

Features like hostname have arbitrary size and break the assumed
8-byte alignment of perf events. Pad all feature events until 8-byte
alignment is restored.

Rather than invent a new mechanism, reuse write_padded but pass an
empty buffer as what to write. As no alignment may be necessary,
update write_padded to be tolerant of 0 as a count and count_aligned
value.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c           | 7 ++++---
 tools/perf/util/synthetic-events.c | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 03e43a9894d4..d10703090e83 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -168,11 +168,12 @@ int write_padded(struct feat_fd *ff, const void *bf,
 		 size_t count, size_t count_aligned)
 {
 	static const char zero_buf[NAME_ALIGN];
-	int err = do_write(ff, bf, count);
+	int err = count > 0 ? do_write(ff, bf, count) : 0;
 
-	if (!err)
+	if (!err && count_aligned > count) {
+		assert(count_aligned - count < sizeof(zero_buf));
 		err = do_write(ff, zero_buf, count_aligned - count);
-
+	}
 	return err;
 }
 
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index f8ac2ac2da45..ee6e9c2fb11b 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2401,6 +2401,8 @@ int perf_event__synthesize_features(const struct perf_tool *tool, struct perf_se
 			pr_debug("Error writing feature\n");
 			continue;
 		}
+		write_padded(&ff, /*bf=*/NULL, /*count=*/0,
+			     /*count_aligned=*/PERF_ALIGN(ff.offset, sizeof(u64)) - ff.offset);
 		/* ff.buf may have changed due to realloc in do_write() */
 		fe = ff.buf;
 		memset(fe, 0, sizeof(*fe));
-- 
2.47.1.613.gc27f4b7a9f-goog

