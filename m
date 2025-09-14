Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47D62E0B69
	for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873504; cv=none; b=XoS/gtfVR6ZSwD3uu+gHzfpaZ02DiQMqNClHCjFKvyM7mU7gvlmkSlueihtmqt3O6NdXeIWeTTffDJwKLWBmeAWyXMjyWgXzwP24tPMifxQRqgOUWCCQ6+E+f7JkSwmKAGKlnBZAEEoj/1dKI51UkbFBV5PxcOvywYy0JS2Herk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873504; c=relaxed/simple;
	bh=/sGoxOpcqHieAabWs8RTqxWD9NIBXBKT+WIphoDadic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FLtIksoeQExWWIvYRRMggMolchPSmVGcJwS4sLw+lZoQIs51NS/1U3BXZhh1JA1HL8kck4Lr4xJHXL5NxgE4xSYkJQ+6G7rHfrEE9/SxqOvuGjUbMruuwFBRaFppxzT/+sYFm1TCn3+Ai2du9YP73DEctqan+uMYmwbnZAWNibo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PXX0pWHD; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PXX0pWHD"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-25d449089e8so43130385ad.1
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 11:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757873502; x=1758478302; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2x7UN9xYjTxwuiXaCS6BwXwGf6viS5ovD7MumSmPSqU=;
        b=PXX0pWHDl6B/+YaC3FSsGz3Mgs5KNt0g5YkgjdrgmMYLw4WZfocg/bBvGWBn2oJwqU
         n1rs+egNbPsp+sPoeo7nKDoFSI6idB6rbiJbrGv+2o0rmLj3sTTaxoFzJpJ28NGzEoOh
         cXPnWyhw4d7eB9n3XyOdwfORvzHEyGV1NMCtXkvCyUZEzBH+ngSW62SIB+lNXprnQuK7
         cPSZ4pjw3zRnKBsu4BmfkGdPX51Ph37f0oJ6UAgxGNS9zDGeP6a4kCR2givHGER3qhHL
         20kBWLQkDN5BWFYtHafVUBB5IKvi4rrHwrKguJbpbTvT1lmQ22AIwwibmgf8PTV0eXSh
         eeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873502; x=1758478302;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2x7UN9xYjTxwuiXaCS6BwXwGf6viS5ovD7MumSmPSqU=;
        b=u80Q9s83yNIACMC9aAYcrUWcrUo9FugpfsntpFtABAMuG+gqz3539gxw+zqSRjhGrr
         JrtENfFCZ9ga/SxHxjbbp50cdabe5nIkh06njy6c4fHFtF73bIJiyGhzGcC2DqWqinjk
         EapIYyc3GUTpTx+UNfxi7OiFHyo3hmZBnQxA0E3kjb7wKWm3AvDwsYZYSG9w6AkN/OF9
         u6EKV0hgvpU0H7AKBY4FpaZosurQYeF5jEYxDFSNsskEC7Ya/x8rKA7p1dhAIWVkDuja
         fH1Tmt91IMvxS+whcHlgpaT3D3W/R4NKk49L/MTa96usfFV0V8CYfTLkXIaOR/qyvY3E
         Yi8A==
X-Forwarded-Encrypted: i=1; AJvYcCW5H5IXmdEgoONuKLK8I0ox425fyP3YEPAF/g7MXPg2aDPFRhj9VIA64Apr9l2HgBxwr5SBmJB22DR1msxzB0UN@vger.kernel.org
X-Gm-Message-State: AOJu0YyMfWauTw7bZ+nkmq6MwLsqlSx6wNxWgvfhI7V5IYo7kxaw7yw4
	oSAQDhYXRn5422y7mlTMJul9fNTaC4HZ2fv3ZHSHFM02XzOcXW0JfIdBZyUAnbnQSK42D3r7cRc
	WTjleeIDEZQ==
X-Google-Smtp-Source: AGHT+IGNmCa3OE/bNeEFCHWoQYVJlaarMANPWbYZySaIttgIKAho/oGbWPRsja1jumx3TcAcuLhNDi20QmO+
X-Received: from plbkx6.prod.google.com ([2002:a17:902:f946:b0:263:7af2:fcc9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22ce:b0:264:4e4a:904a
 with SMTP id d9443c01a7336-2644e4a929cmr31326135ad.53.1757873502281; Sun, 14
 Sep 2025 11:11:42 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:11:08 -0700
In-Reply-To: <20250914181121.1952748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914181121.1952748-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914181121.1952748-9-irogers@google.com>
Subject: [PATCH v4 08/21] perf pmu: Factor term parsing into a perf_event_attr
 into a helper
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Factor existing functionality in perf_pmu__name_from_config into a
helper that will be used in later patches.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/pmu.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 818be59db2c6..36b880bf6bbf 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1763,6 +1763,24 @@ static int check_info_data(struct perf_pmu *pmu,
 	return 0;
 }
 
+static int perf_pmu__parse_terms_to_attr(struct perf_pmu *pmu, const char *terms_str,
+					 struct perf_event_attr *attr)
+{
+	struct parse_events_terms terms;
+	int ret;
+
+	parse_events_terms__init(&terms);
+	ret = parse_events_terms(&terms, terms_str);
+	if (ret) {
+		pr_debug("Failed to parse terms '%s': %d\n", terms_str, ret);
+		parse_events_terms__exit(&terms);
+		return ret;
+	}
+	ret = perf_pmu__config(pmu, attr, &terms, /*apply_hardcoded=*/true, /*err=*/NULL);
+	parse_events_terms__exit(&terms);
+	return ret;
+}
+
 /*
  * Find alias in the terms list and replace it with the terms
  * defined for the alias
@@ -2595,21 +2613,8 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 	hashmap__for_each_entry(pmu->aliases, entry, bkt) {
 		struct perf_pmu_alias *event = entry->pvalue;
 		struct perf_event_attr attr = {.config = 0,};
-		struct parse_events_terms terms;
-		int ret;
+		int ret = perf_pmu__parse_terms_to_attr(pmu, event->terms, &attr);
 
-		parse_events_terms__init(&terms);
-		ret = parse_events_terms(&terms, event->terms);
-		if (ret) {
-			pr_debug("Failed to parse '%s' terms '%s': %d\n",
-				event->name, event->terms, ret);
-			parse_events_terms__exit(&terms);
-			continue;
-		}
-		ret = perf_pmu__config(pmu, &attr, &terms, /*apply_hardcoded=*/true,
-				       /*err=*/NULL);
-
-		parse_events_terms__exit(&terms);
 		if (ret == 0 && config == attr.config)
 			return event->name;
 	}
-- 
2.51.0.384.g4c02a37b29-goog

