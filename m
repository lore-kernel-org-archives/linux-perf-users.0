Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE452DE71E
	for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757874550; cv=none; b=jMve03Gc+xyTsbCTLXPpRsHE333j2DQB9e/D1v6KNW8iaGVeV0ZJhtkxI5gK2EAr1d2rzdaVtnhY5htwp5FsEuWiCBOakbKGOQvVBk3mNP91TE8CpDsCcGRT6y4aqzYWLFi8TX2OztcojSj6XZzzIZEmZ8NL0v5sc4Njpenxe60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757874550; c=relaxed/simple;
	bh=mTOn6giSoP53VSWktwhOwxCbO9sMvgSdd93tY2pNJs8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=M055PdazMQCqkSgihIx5RIJuquGQF1raOeHXNdeYuwF5TMPoEKaIvdhBkbzkkDjvVDHgFKfmBMy/joGd9avgnPbN+LvlbA4nPn1atxHt3Dk7dk4c9RdYU/vUHCWrxJ/T+bKUd5IYkLHT/BKKatZtwPOVQYKDq4SQv1FEUjBrG4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZJC/1qLf; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZJC/1qLf"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24ae30bd2d0so31193375ad.3
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 11:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757874548; x=1758479348; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i1UXr9DddIml2mw3JC9NZw81ayshLyyLu0KNuaMckGo=;
        b=ZJC/1qLfZxPuxZYKyc43GsF9FWsz7giifTJq3rco4knDrbu54qFRJGzY4q/JKymt6l
         1ABrQmZ+BEiBAlzlV3IAL12A3dCBwejhzx8Mwgsu3een8cchj/OoMZ5UgotkSsWOOJQn
         UwjZVnD2yutzUEeuS4ThNqMYWFBNar6HgjU60oZIbjLNAtni7Ytw3AX75aUovf3HDc8z
         OBMFf5F6xCqdPY2TQKn6puvCtGjP9JRlv3jhAH3avbEUD767fzRKusVlTTFnJR2GDdJO
         izgFcSJLPGa8b9dFPm7/h8ynE3JoRcVN073TboTzl/MVZF4jnpYFuyIEJqHyKVNzihNB
         v4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757874548; x=1758479348;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1UXr9DddIml2mw3JC9NZw81ayshLyyLu0KNuaMckGo=;
        b=Tx5uYcxXQPGgQTFn/VA5cJCunrqfvKZlalRr8E58EN8W9lHgqJcg76rC4y8YYEjcvK
         IZ/NvegF0yhSAA65kK8o12juPs02C/AMGn7gTGwBfOTkfu1ofqSdIIIJVWlc1KDKMzOV
         djbGOXN8uKRNNQTcxS2MgvaxgvWC4l9okstikl40LHRMYz2fpV+hWCsgcjzSuDhGeU2h
         uUfTBpSDBFdwbeBskPvRpgwDMO6hP0omf1Gmcf9K/9KBiYF9ek9TDJgqRW+BSSZR7nQ1
         RX9VxCg5l4zsOPR2nqJciAyM+73iwKGCs++d38vMZ8St2GFAIHkbwDwHK6KzF71eLrtZ
         uUuA==
X-Forwarded-Encrypted: i=1; AJvYcCWJfBFPVmrSgmYDzYWQ9LBGFDVtzQkzoYJ50TMx96tIYYUs0drPkR1YO3oI6OpN/7ZtW2oWGWUOOQh0vYLZqG9b@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3YiPGIjRgyeBW+yAlQGbzpVH41+mVPEXoz/dCaW/+l69ZglGB
	M6eeJsV5KJ+eU6ZGXvmb+AOQzGz2crXC/JV5hzrPbvPmskOgdfPohtqBvVNkeURzBTCUfJBB/62
	DhhNNsYL98Q==
X-Google-Smtp-Source: AGHT+IFeXUQzkJIJjFsaSyL3OefAj4LJj2IjQXlqOLKAqr9meNr+oFat66AV3yKPiRMp+IW7ZIJe30YGIioR
X-Received: from plok6.prod.google.com ([2002:a17:903:3bc6:b0:266:d686:956a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc4b:b0:246:7a43:3f84
 with SMTP id d9443c01a7336-25d242f30e3mr113738465ad.5.1757874548053; Sun, 14
 Sep 2025 11:29:08 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:28:58 -0700
In-Reply-To: <20250914182900.1960567-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914182900.1960567-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914182900.1960567-3-irogers@google.com>
Subject: [PATCH v1 2/4] perf parse-events: Add debug logging to perf_event
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If verbose is enabled and parse_event is called, typically by tests,
log failures.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5dbbede45363..f96f2e750fe7 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2211,6 +2211,8 @@ int parse_event(struct evlist *evlist, const char *str)
 
 	parse_events_error__init(&err);
 	ret = parse_events(evlist, str, &err);
+	if (ret && verbose > 0)
+		parse_events_error__print(&err, str);
 	parse_events_error__exit(&err);
 	return ret;
 }
-- 
2.51.0.384.g4c02a37b29-goog

