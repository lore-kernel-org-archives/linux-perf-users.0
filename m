Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4261386B3
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 02:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731121086; cv=none; b=An4QMwW/ZLNj2C75yvmXswK0uAznt2I4eormMt9DunAcu6Xbk5LDQ0kU52JZ1LXNQzKmgDDysnlP/Klx7WXMw6WmbF+s5ypjNLLxssoJkQvzz7kTyAV3hXYTGKQ54o763lTFF6V+KavHsxFLTnB5Tb9R9cav0QJsbmUM9+/lvh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731121086; c=relaxed/simple;
	bh=okD8PZlyuduO7Pj+Y0baUDgknvMMd1GbbUlD73IOEAs=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=O7BOLbxD5HMAC6kNyNEfJAqoduLKWDZC+r6KeKleomKbebQzxgEgRjpbUMRg8OHCx7WakSZsS8Vgkh1TtpTx64XFCuAvMyK6xDBTJMGIunrNbeiDK0aDTL3Naxjspa4y06nj1uuuSpCeKORKpy5P2x4AzH5cknR0ZGJnAw/VC4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qhTyiGM3; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qhTyiGM3"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2971589916so4654253276.3
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 18:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731121084; x=1731725884; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xeepDSMekLWdN9dw+iAAPG9h5iMUwhHzvrTsRjDcopM=;
        b=qhTyiGM3YP72OkvhbSh1SzP7WR/phQbKSCRD26bflYFb2LF436xv+Kn7H8/aVhRxsP
         N+rFg827+zrPyHqtDvkCMN1y3IolTTSxnR/i8ZsQnOULiZprXZ4HLeyFcM5hl4dgm9nh
         DbHsbev4/qu7B9CLAwYC4k7BBH1f39QfVoLHjV9t+6uqO7osm3M1PNQ3BDTeStrlRB2W
         RRWumz7WfaHVKuBUb26e677jP00DJ21R1/1AZgLbh0CLxpvNi+Qg80qIZmHearhOw9C2
         EezYGjfQ2PC7LnTNoEanUbn6F3aSsWK2Zon5Q71fT+1rtLxRN9iLw0a4t8i8KtPiCynn
         iPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731121084; x=1731725884;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xeepDSMekLWdN9dw+iAAPG9h5iMUwhHzvrTsRjDcopM=;
        b=oGxXbuhBLQ1oibiVeH2Tfethmh09r8GVeTatBVT9hdzrjD4watgIqObEkpIkaMyDWx
         Y1p5UhNeA8J4WmxBFedAHwICaOM1WRBIaa0gMqCFoE9pimCxz5BJRAylIgh3ANCd9SW9
         tBS+MFFlNIlLpAOKdcIdEpiB19kUaY/RW8oTiw0VKdrP0FJHofOc3pv5WiBhXonhLkLI
         c7iVsfaWJRTqfxOcxfDVhLl2UgzaOzjobT8rw9v8VKdixBITlGlGd243M3c9P6Aw2B0t
         R46gew2ebR17UEUu0rcGUz+ugDbfkysABJJc/JWqgM39hIMC7vMtflfFGVLtF+Nlbujh
         k5Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWGGmkHBE1854sZclbXK6cj7ksBa763NIUDf5iTtD5336XL0qjGznc3jxz+F7P359gFhUtisffViHr9dgXqHxcO@vger.kernel.org
X-Gm-Message-State: AOJu0YwjqKcCmkRU3NRtnjRhlX4zbDprSyk8SwNPsK77lWWpEpVi+LCo
	VPKb78/Ba+0kfKd6ebdwih66mAqAnJh4H10TKHJPjzBz2nLYgSKRb8EAPmdyGJr0GpoAqrVbtLE
	9oOygng==
X-Google-Smtp-Source: AGHT+IFyKQHcp6GwqhTuAtmFz55t1ESJhipFBhyeMD9PmkvvGJQ689MBuqnef3qOPc8jI+vcC4J712fGpHZ4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a5b:c09:0:b0:e30:cdd0:fc14 with SMTP id
 3f1490d57ef6-e337f8ed79emr4049276.9.1731121084313; Fri, 08 Nov 2024 18:58:04
 -0800 (PST)
Date: Fri,  8 Nov 2024 18:58:01 -0800
Message-Id: <20241109025801.560378-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v1] perf list: Fix topic and pmu_name argument order
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Jean-Philippe Romain <jean-philippe.romain@foss.st.com>

Fix function definitions to match header file declaration. Fix two
callers to pass the arguments in the right order.

On Intel Tigerlake, before:
```
$ perf list -j|grep "\"Topic\""|sort|uniq
        "Topic": "cache",
        "Topic": "cpu",
        "Topic": "floating point",
        "Topic": "frontend",
        "Topic": "memory",
        "Topic": "other",
        "Topic": "pfm icl",
        "Topic": "pfm ix86arch",
        "Topic": "pfm perf_raw",
        "Topic": "pipeline",
        "Topic": "tool",
        "Topic": "uncore interconnect",
        "Topic": "uncore memory",
        "Topic": "uncore other",
        "Topic": "virtual memory",
$ perf list -j|grep "\"Unit\""|sort|uniq
        "Unit": "cache",
        "Unit": "cpu",
        "Unit": "cstate_core",
        "Unit": "cstate_pkg",
        "Unit": "i915",
        "Unit": "icl",
        "Unit": "intel_bts",
        "Unit": "intel_pt",
        "Unit": "ix86arch",
        "Unit": "msr",
        "Unit": "perf_raw",
        "Unit": "power",
        "Unit": "tool",
        "Unit": "uncore_arb",
        "Unit": "uncore_clock",
        "Unit": "uncore_imc_free_running_0",
        "Unit": "uncore_imc_free_running_1",
```

After:
```
$ perf list -j|grep "\"Topic\""|sort|uniq
        "Topic": "cache",
        "Topic": "floating point",
        "Topic": "frontend",
        "Topic": "memory",
        "Topic": "other",
        "Topic": "pfm icl",
        "Topic": "pfm ix86arch",
        "Topic": "pfm perf_raw",
        "Topic": "pipeline",
        "Topic": "tool",
        "Topic": "uncore interconnect",
        "Topic": "uncore memory",
        "Topic": "uncore other",
        "Topic": "virtual memory",
$ perf list -j|grep "\"Unit\""|sort|uniq
        "Unit": "cpu",
        "Unit": "cstate_core",
        "Unit": "cstate_pkg",
        "Unit": "i915",
        "Unit": "icl",
        "Unit": "intel_bts",
        "Unit": "intel_pt",
        "Unit": "ix86arch",
        "Unit": "msr",
        "Unit": "perf_raw",
        "Unit": "power",
        "Unit": "tool",
        "Unit": "uncore_arb",
        "Unit": "uncore_clock",
        "Unit": "uncore_imc_free_running_0",
        "Unit": "uncore_imc_free_running_1",
```

Fixes: e5c6109f4813 ("perf list: Reorganize to use callbacks to allow honouring command line options")
Signed-off-by: Jean-Philippe Romain <jean-philippe.romain@foss.st.com>
Tested-by: Ian Rogers <irogers@google.com>
---
Note from Ian, I fixed the two callers and added it to
Jean-Phillippe's original change.
---
 tools/perf/builtin-list.c | 4 ++--
 tools/perf/util/pfm.c     | 4 ++--
 tools/perf/util/pmus.c    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index b8378ba18c28..9e7fdfcdd7ff 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -113,7 +113,7 @@ static void wordwrap(FILE *fp, const char *s, int start, int max, int corr)
 	}
 }
 
-static void default_print_event(void *ps, const char *pmu_name, const char *topic,
+static void default_print_event(void *ps, const char *topic, const char *pmu_name,
 				const char *event_name, const char *event_alias,
 				const char *scale_unit __maybe_unused,
 				bool deprecated, const char *event_type_desc,
@@ -354,7 +354,7 @@ static void fix_escape_fprintf(FILE *fp, struct strbuf *buf, const char *fmt, ..
 	fputs(buf->buf, fp);
 }
 
-static void json_print_event(void *ps, const char *pmu_name, const char *topic,
+static void json_print_event(void *ps, const char *topic, const char *pmu_name,
 			     const char *event_name, const char *event_alias,
 			     const char *scale_unit,
 			     bool deprecated, const char *event_type_desc,
diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
index 5ccfe4b64cdf..0dacc133ed39 100644
--- a/tools/perf/util/pfm.c
+++ b/tools/perf/util/pfm.c
@@ -233,7 +233,7 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
 	}
 
 	if (is_libpfm_event_supported(name, cpus, threads)) {
-		print_cb->print_event(print_state, pinfo->name, topic,
+		print_cb->print_event(print_state, topic, pinfo->name,
 				      name, info->equiv,
 				      /*scale_unit=*/NULL,
 				      /*deprecated=*/NULL, "PFM event",
@@ -267,8 +267,8 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
 				continue;
 
 			print_cb->print_event(print_state,
-					pinfo->name,
 					topic,
+					pinfo->name,
 					name, /*alias=*/NULL,
 					/*scale_unit=*/NULL,
 					/*deprecated=*/NULL, "PFM event",
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 107de86c2637..6d4c7c9ecf3a 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -501,8 +501,8 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 			goto free;
 
 		print_cb->print_event(print_state,
-				aliases[j].pmu_name,
 				aliases[j].topic,
+				aliases[j].pmu_name,
 				aliases[j].name,
 				aliases[j].alias,
 				aliases[j].scale_unit,
-- 
2.47.0.277.g8800431eea-goog

