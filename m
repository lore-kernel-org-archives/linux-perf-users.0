Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6F51AA3F1
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jul 2024 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722367070; cv=none; b=EMl5zsKw3BsmgvSaae5W0PTbMVBLUnw83woIgHsKbdYb1HFa2ie2t3x8/+Bzf9wASCstZxuhzwRYWam+gZKxl2hqRHHDB6xtuOif78Gto9o9xKKP9uAdox5ln1OAoRSqdwH9boF7R5exUE85R1wA1sV4VOh6RNHHS40zHIIrQfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722367070; c=relaxed/simple;
	bh=XFEeUN0IV3OvseSsWCX2dxHl2R27oAX3kgzjRpdZ5jo=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=GRl/v/NNoNBkwvBR6OvGnIBzraYzlpk6x1gHIcA9KmykX97BVI8dXDPXSNh887puXAtD8Pz/tq6two01lR8BWL9s39jei0sNJyNbYXITOXkoiYIvc+A34aqzuqMaNoJwL+hmxswTgd3rMLslhX7qYutsT7JhWIzIV8jpUAdDlJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2q41Bfgi; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2q41Bfgi"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b3742b309so6811384276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Jul 2024 12:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722367068; x=1722971868; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jnRKI2DZaKF19Vc7gkMAAWBTLm1lonuKlg3WaQu1cmY=;
        b=2q41BfgiZHxl4A+Q3trZDAShwM8MwBNGiHrARa02EdDYYsKHqlKAO8usTu96WSukKG
         0cATWuqCKSoqYXCPaUzag40nWatv6Zq6fYYSWA18JINYNLda0CxuvCvXEEEUZyj8iH1k
         IybrUVXUCcoVxerLEEc7XejhCBEu7411t7YXeGpht0g2UOeJ6n+Wz4f95x3qQESi/VZn
         cMdn11rEi/c+pxtwLOFzU7FHXwheHfBxVyq9BBmXOhh/FqaqWCoiMhbmSf1aKibk5wCj
         YPiWSvJVCQw3eRYmYgWzNpueZ7/DfpOKf5mg3k1y9awvmA8m+9gpiBoNIv4/quSdoDvl
         ljmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722367068; x=1722971868;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jnRKI2DZaKF19Vc7gkMAAWBTLm1lonuKlg3WaQu1cmY=;
        b=P0KMHi+41R4BFrkaNU8bweQOloWzhlxtrtZOn3UsrX7Nw64FJHIRI6hb1/+82WVbY6
         2c1PqodiA3ffBbHDhdqJn+8MncBrmb3Nr35VkMdxHqheZ+QxXhX4BKtvwShNnE85UhFk
         be8vpWikcG+rTqohHmMd12R2qTc6c37KQZ5oY33qEDUclXSjFfUy4Q/oj3CNWOXDybMi
         AILMKVwSCpyHQ+INCgKcbRIRdvuz5N4eZZ5L+g+mc9Q3P5u0ayYvBpxscuvXZUIYlq6t
         +L+BiNrq1Rwarv+8Q5bJBUab/GwZYktKS+IgpIuOOMt1t0EB5TSY6ohcvLhxN7Ag+sOW
         6urg==
X-Forwarded-Encrypted: i=1; AJvYcCU79ri1HTZcttwr+hYoSzot4+BBbjWichJ1W+t+oR/FmJmyTOmmMAQJzIB3wfc/mUT1JviYlpCj4Xb1YuZMw+YvnkZDoQSXDtrknt0p5Xt9fg==
X-Gm-Message-State: AOJu0YydFGUtVYzK92L9RNOgaNg/w7Ego50SW2Df6U4BjRI1FhgwygpC
	o7nqGdkMPtDz654peFYajzi2wKxFl4zTyP9mK+Hz/jhzysBrQL2gVqpjNhkoy5aGlDc/wtWRZW4
	BCWQ7/g==
X-Google-Smtp-Source: AGHT+IGHCOIfYE+jU3yP8n/6z+ayYRfbV7TpOWQuKGEYqkamORc80np3zqTC3an9irTD7xo5qfFitXAYjsOS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b07a:93d0:1b64:3771])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b8c:b0:e03:31ec:8a24 with SMTP
 id 3f1490d57ef6-e0b5450c532mr513973276.8.1722367067754; Tue, 30 Jul 2024
 12:17:47 -0700 (PDT)
Date: Tue, 30 Jul 2024 12:17:42 -0700
Message-Id: <20240730191744.3097329-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Subject: [PATCH v3 0/2] perf jevents: Autogenerate empty-pmu-events.c
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, philip.li@intel.com, oliver.sang@intel.com, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Rebase of v2 patch set on tmp.perf-tools-next.
https://lore.kernel.org/lkml/20240525013021.436430-1-irogers@google.com/

Review was delayed because of an Intel automatic testing issue,
confirmed not an issue here:
https://lore.kernel.org/lkml/ZqhGNm+WDcsNx05e@xsang-OptiPlex-9020/

v3: Rebase and add John Garry's reviewed-by tag.
v2: Add not found constant.

Ian Rogers (2):
  perf jevents: Use name for special find value
  perf jevents: Autogenerate empty-pmu-events.c

 tools/perf/Makefile.perf                 |   2 +
 tools/perf/pmu-events/Build              |  12 +-
 tools/perf/pmu-events/empty-pmu-events.c | 894 ++++++++++++++---------
 tools/perf/pmu-events/jevents.py         |  12 +-
 tools/perf/pmu-events/pmu-events.h       |   9 +
 5 files changed, 574 insertions(+), 355 deletions(-)

-- 
2.46.0.rc2.264.g509ed76dc8-goog

