Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B66A4C85
	for <linux-perf-users@vger.kernel.org>; Sat, 24 Feb 2024 01:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737276; cv=none; b=bV38i9bUs9RFmwLt+lM447qn/yj9WiqlcTdBfW46CU2LDxmkk5QlRRGyphPF+p0gLJOk8UByilBSJ62RuyR2lpbNs7CB1FuJgy21EndB+sO8jJBfoGEcBcpdJ7Kaotj5ShC1Pw8xKJqzZZRux50MbFZDHAOhoD7uIJJ2zmHQDc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737276; c=relaxed/simple;
	bh=SMuNfkStfp7m84t++OujGgQIFGUkm03rcf3YONhAgWg=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=RyFjsXR+6slgsiejvforClYOUteLFbtbJQ3/hh5D5s0bGFdRmiEtDT8CzrqHlMO9ZMtQp7ErG3LEaEAxFDXIjXPP89YozVWqSLaWoo8OgFAVjIaFp3oN+udyDqh6ZYWgUrBjx2Q5nD03NysU/Cgmo2Pt+yInFlkt45CYZNXDuyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N20h/Dzh; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N20h/Dzh"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc657e9bdc4so433683276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Feb 2024 17:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708737273; x=1709342073; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8txlAXE3kVJW8nyQ1VElcIl0nKZolbY0q/6ha7e2fxE=;
        b=N20h/DzhIDLoa5/B/fOpsfdnX2U3TGeXSMSUQqs37Q6IjvRvKSI1JPt+y+CMqKym9z
         xMhOUBG9l3HGZDqvguY0TVC0DrgFQ6Kyh/9A2lQIEIICJqICpqd1fbokSeiMZozDm6VG
         DJS0kweaZd18wYXqfhSZiEyaw3l20hOgmxeOQV6jU68YbJqHO4xyvpUfzum8JqwW8E7m
         EilBNNHYu2/Tl+hpPVALw/a546ros6O/rqtjq/m0kBK0xb/vxh1t1nit8138P6vsbj/0
         xBkfcf5c3golCgsQEMmCltTuZ9cNbIlV25bajmYGmFm0rFk/OxiPNqd+VsBBxKFhsswv
         R/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708737273; x=1709342073;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8txlAXE3kVJW8nyQ1VElcIl0nKZolbY0q/6ha7e2fxE=;
        b=MIe3pmhVggvPzoHluw1geJMaa0r9FyPVqKLJcGhS/PY5SA/9oCdrGPEDKlkcf1RUic
         668jxk/FvgpRs3RgA+FIafe4Ak5vW6kBQIuRyoMEWjAqjDB1ftf9vy8XOqi34CTv4n7G
         wHfSx/LhujEgGobTuwaXx7xUJRlkvXhxZ1kDhW1KrMHN6ymP3PjdFcGMIfzIIGXzRw+f
         v6Zw9vAN7LNTWFF4FcmhA/gDc4Fri0JhAAM3J0bIVnBxs3d1PWTTNQFTPBdfbIdY7UIf
         Ea3yHUVz4d0T9k67k2hJ86YL1YV0uA43ui/gCYK2QEtdya+IHfiABpj0XC7mXbvbtd9P
         gRwA==
X-Forwarded-Encrypted: i=1; AJvYcCVYNWLYJ9qlPG0bxx48Mvx+syGcixu6e8h8gIOQI5vcsQapRzolp94yXsvVcH/bC5xpckkhSweot2KOndTODG9KdzNtjE51ucX7AJhR3OqZvg==
X-Gm-Message-State: AOJu0Yy9GHuqbP+I+DYyH7BygPe8q0QDeJ9hSrl5N3MRDepYb/h88SUl
	eBuPFu5Bi5zimJ1j1Kqy9Tl9AD9jDcICEkiQpp8oAA63XicWvcFk3GtscgB8GV8nohKlSmWu2Hl
	+td+JtQ==
X-Google-Smtp-Source: AGHT+IGfbjPMKikwPwUK4BBr0sUlTbd9KQ7ODiJsvAJ5y+y7I2SW8IIsabX9/0fSj15betRz8cL0wU2eqQrP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3cf6:588d:1bf:3fa8])
 (user=irogers job=sendgmr) by 2002:a05:6902:100b:b0:dcc:8be2:7cb0 with SMTP
 id w11-20020a056902100b00b00dcc8be27cb0mr51925ybt.0.1708737273529; Fri, 23
 Feb 2024 17:14:33 -0800 (PST)
Date: Fri, 23 Feb 2024 17:14:19 -0800
Message-Id: <20240224011420.3066322-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v1 1/2] perf metrics: Fix metric matching
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The metric match function fails for cases like looking for "metric" in
the string "all;foo_metric;metric" as the "metric" in "foo_metric"
matches but isn't preceeded by a ';'. Fix this by matching the first
list item and recursively matching on failure the next item after a
semicolon.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index b24a1c177a80..2d6865c392ef 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -352,25 +352,23 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 	return 0;
 }
 
-static bool match_metric(const char *n, const char *list)
+static bool match_metric(const char *metric_or_groups, const char *sought)
 {
 	int len;
 	char *m;
 
-	if (!list)
+	if (!sought)
 		return false;
-	if (!strcmp(list, "all"))
+	if (!strcmp(sought, "all"))
 		return true;
-	if (!n)
-		return !strcasecmp(list, "No_group");
-	len = strlen(list);
-	m = strcasestr(n, list);
-	if (!m)
-		return false;
-	if ((m == n || m[-1] == ';' || m[-1] == ' ') &&
-	    (m[len] == 0 || m[len] == ';'))
+	if (!metric_or_groups)
+		return !strcasecmp(sought, "No_group");
+	len = strlen(sought);
+	if (!strncasecmp(metric_or_groups, sought, len) &&
+	    (metric_or_groups[len] == 0 || metric_or_groups[len] == ';'))
 		return true;
-	return false;
+	m = strchr(metric_or_groups, ';');
+	return m && match_metric(m + 1, sought);
 }
 
 static bool match_pm_metric(const struct pmu_metric *pm, const char *pmu, const char *metric)
-- 
2.44.0.rc0.258.g7320e95886-goog

