Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310FB181334
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372190; cv=none; b=Yxu4rETNq4J+MxpnDVETxFQCIUZog7dbAoa2av7ez+mjtqXH9TZgkopI0HFlUvxsukCDIuQ59VOg0Mougm2Yv2F1hswavwlHixbznp9WiEVpLZssCQF7aS13ObAd4XGlMqS7CHleE1kS/LBspD/bQ7PFBBnBc1bs63/URpP1BHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372190; c=relaxed/simple;
	bh=qbqs/VtYLAHCycbx4vi5LsbINYh1rKMwgZIZNf+A82Y=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=mr4SKww19DgyhCWNpQ4e7Q3UIGSkwNb9t7BSxuD9gN4GBflIbqVpX8PH/27Oluw7no8zulORIj2ZYa3bPJ3xjqoOesU/GHD03523XcGmlNd8fw4i4m2BhUSJfh4DGnuNGjPAQQDjPyt6pUuBpaVeLEaj5hbaxCc03uodnCOFHCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n+SQBwt0; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n+SQBwt0"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e25cef43f5aso1092003276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372188; x=1727976988; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e3phwsESgNJAD/gtYgEfjCS2iNNfK4v5IWyCQ1BF22U=;
        b=n+SQBwt0zg2e2EJmWyRJNGTac6GP3aJQPMK+djbEKTsNEl32w8PUjttE6XB03MB52Z
         v857Q7sWQZwXMkTFLA7fixRIPnBXrCy8Fh8d8uz0pJyUSRnnTsDzlGyBFlft7ZvNK5iz
         dVxsEU9O7XAeeNSHluDGtmqz/OVEmwrMWtGssprqGlxk64CYRE6utTL9EbjvaRUe8v5t
         rwnvBwOnEP4rVmMw+pzs/eDrQ5hQUoyY/w48LVXPawn4mkGLWkHHzY3PkRg/EipGlZvK
         bndllz9DHbeOLm2L6GrxaiACAwn8adqzn85qAw8semMEW4XqusSVxVGylVU3Kqz147I3
         9p4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372188; x=1727976988;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3phwsESgNJAD/gtYgEfjCS2iNNfK4v5IWyCQ1BF22U=;
        b=oajm2W0mETItmMpA8xZpA5m8LlWx3pEadCcyvdY9JoFKsGNwDhjjdSkybfOm1BC2bt
         h4/GjbIMTgHS+0s+/gn9rIwFRGrGb08rtEApkYG5efhXsIoPjEudjf1hD5bTP5QRRKKS
         wj5K2ml88SVLOWsP0HLjRE7pSLYsVIu1U/OOhUgaRm7rfHZVzSvx2gQINDz/l5EWQ1m3
         16Y+oK+l/21OB7WgSDaucNszl47g6G3GjXairTMVOp62m9Kw3pK9+QWwzt9tRjcULbbq
         gHdb6suwzttWs1Xrh1C5IsEFCyhOGi9AQBbCz/ezGiB6sqluKZZ3YcRuBBScz1/9DUOw
         p7Lg==
X-Forwarded-Encrypted: i=1; AJvYcCVsWSS3CgSU68eG1wkt16V66EysL2JCpd+QbNeh3MxSwtzo3VODOPxNVLN/slUFkMvb0aCS+fI3qsjGK8UwnAdy@vger.kernel.org
X-Gm-Message-State: AOJu0YzhDyKUPF4OVzMxArexUeRKLidtoWluomnE69KAKlycj1pJVkEd
	nxkRSS4hOX/nXrfPUN3Pd09/C0dhRdXFtcbumj/aNfxQ+rQj0g8KDWUBWVFiFQ0lCi6KfbEMnAf
	rhc6pZg==
X-Google-Smtp-Source: AGHT+IENGkB1Fu9MiFrm2Rau858bJwo6nKsMX5S+m/q2KN3wYJTLbrV0xtxHf15FckIrJ4ISm7FtJs3Q+xml
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a05:6902:504:b0:e17:8e4f:981a with SMTP id
 3f1490d57ef6-e2604c8fd7emr141276.11.1727372188130; Thu, 26 Sep 2024 10:36:28
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:35:51 -0700
In-Reply-To: <20240926173554.404411-1-irogers@google.com>
Message-Id: <20240926173554.404411-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926173554.404411-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 09/12] perf jevents: Drop duplicate pending metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Drop adding a pending metric if there is an existing one.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 8d2cecb87e88..7b4239e8b08b 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -473,7 +473,7 @@ def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
   for e in read_json_events(item.path, topic):
     if e.name:
       _pending_events.append(e)
-    if e.metric_name:
+    if e.metric_name and not any(e.metric_name == x.metric_name for x in _pending_metrics):
       _pending_metrics.append(e)
 
 
-- 
2.46.1.824.gd892dcdcdd-goog

