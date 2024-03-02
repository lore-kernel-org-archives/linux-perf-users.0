Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFA017573
	for <linux-perf-users@vger.kernel.org>; Sat,  2 Mar 2024 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341222; cv=none; b=kXcEri8I8tgZFnpvR3ogHg+NLivc3qTNdbF3MWZVOuoeif1lXS4vcVcTD3MF1XdI3RE8DBfwdhgACq+bRhs88F7M/QZjlusOZDz/v8vuD/w9fFmqaIcXXDbv/mHlMtotOddxkkzaivgqwDrzc7t8/1bNCMM30GwUrsW+ZRz+/vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341222; c=relaxed/simple;
	bh=r7EPMWXB50WRmPs6Ybs2X/h0mr+Q2k6sSSuIvq/Jh3g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=kbaKfZT20yPK+PRawwoPoSIm2uK+wKjWrBK9wWbyCCJTgte+jhqthhf3a6yysGWD/fwLfrwYuRAQHVxjBR8dKPFv9dfGq8dYP4/dkeogHjRknZ+x43SR7+pEg1TL9Gw9D1DP2ZJjm7Rfksx0YAM+1xiVLUuqlFQwXVkQXxR5fd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xhr/ucg1; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xhr/ucg1"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso4152376276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 17:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709341219; x=1709946019; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yRxIvbPDDMCjNnVdacSzvCtMsT39EeStBSRtXaTCLVU=;
        b=Xhr/ucg1WzqHMRl4tmdOibBGQNwk518oDN4TEROUxHVsglY/zSmmMxbvN5Eu13nsax
         JUOJCZy7YSPIAb4hw6emVeJd/LJKx6Gwg93F4CCaTm3BmIWYbxSXTPavLJqutZ4BhkzR
         s9Fnliw+3uLd0tOZRQuJaYWuApofzAO5+fAVGMBS8MzHbb/eWEtY8VjFG76ocPc+ufoy
         taEJtRT4I/4UBA5d+Mf2Qsr0aptw9T7vxHzqCvEztVjOlhKkBfaeRHqNX7JwI4wvHTIa
         mPacVLdJXCwzw/gI9ZVbLy25OZgJzbRZXYciYCMt6FaXFpx0JSfkKB2aeO9MjI2r5bwX
         vWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341219; x=1709946019;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRxIvbPDDMCjNnVdacSzvCtMsT39EeStBSRtXaTCLVU=;
        b=MtelBRNK0AmtHKqEF6DmrxYUObX2WcpUAtWj0AuReQTIC+R07lafp8uAAM4be6YddH
         b0VeVGKdFCoeCRMudOcSr1wiHW63Ggi6/S52TkJcwJDv7YanddVi56k7NnnbO7d46QJb
         ANoRjnANKmk9FwD/aLDnDWlTG9dAbLWVBXuBgEEMWl57yRL9oTkS5vIgzq/P21llKtXo
         QPgBJv4AQG1vXa7b6kc2sqEJYDMotEhCi/j4IxOFoFA4DezF53uOZwn9esSQieDiga6R
         RO1W+MecBhNqCeF+OnpHeQjYeLw6PGZh+RpLeiBqccnIgc8VaHOrkWOgM8FP8OerHWzt
         Uc0g==
X-Forwarded-Encrypted: i=1; AJvYcCXooSiEc68D55MFHzo5NLcl0x8c3tzyDm8j/KT9rYewo+zBw1S7qH0UdjP5gj59JSI3btxuU6vMEESb3TyihIewXr4r5wqSvCoOTawgOIajAg==
X-Gm-Message-State: AOJu0YwdBUfnzFLMFO6j2cdcjeLYzB0h1EM1VR1XLoXX9z0JvDi/DLQ7
	opZw1FTyjOOL13uSY0AqyWFvfOACv5w1kw9dtvXUo/bBZGcVB7rDx/o8c9Z0r646VRMMHtrGtU6
	CREimJw==
X-Google-Smtp-Source: AGHT+IG4guLzt+eNWZAQFrcV514Mi43PlUwCoRXQSTCsH1uIyiTwKHP3ri7f8gA9K5LsfJKbD2saZIuBlXnl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:aba7:66c5:3365:7114])
 (user=irogers job=sendgmr) by 2002:a05:6902:18d3:b0:dc7:865b:22c6 with SMTP
 id ck19-20020a05690218d300b00dc7865b22c6mr117870ybb.8.1709341219679; Fri, 01
 Mar 2024 17:00:19 -0800 (PST)
Date: Fri,  1 Mar 2024 16:59:47 -0800
In-Reply-To: <20240302005950.2847058-1-irogers@google.com>
Message-Id: <20240302005950.2847058-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302005950.2847058-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 09/12] perf jevents: Drop duplicate pending metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop adding a pending metric if there is an existing one.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 65ab03ce5064..55205a260a16 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -468,7 +468,7 @@ def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
   for e in read_json_events(item.path, topic):
     if e.name:
       _pending_events.append(e)
-    if e.metric_name:
+    if e.metric_name and not any(e.metric_name == x.metric_name for x in _pending_metrics):
       _pending_metrics.append(e)
 
 
-- 
2.44.0.278.ge034bb2e1d-goog

