Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A897C364AE
	for <linux-perf-users@vger.kernel.org>; Sat, 29 Jun 2024 04:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636857; cv=none; b=e6qyTVlBOmhSMNushYqm/qaKxO2v57nArJI2w4oE0MSFa9HG86GGjq4+BIvVabjDBr310WLri4DIqtAtKhvkTdt+CMojhOSVvuY88MADZ1kTQTabX7YU1+A+I5U6J4//gCm/7bO+ncMnhInwFYxjOicE2UtN9roPQ11bd2nfJL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636857; c=relaxed/simple;
	bh=gqyDi0O1/ve3RAF6Mkbp2f1MdyDz0lrbGCH1RCO8mHM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=P6xqq/Auix6emZYfzbMLJPoTm3JHV2Lo4nCLYQ7Cnow5niAoLSHPxOIVqwCZMApbQ5UUafFD43+Y5YrP5gOPvdRr/Gz96CCgU6dF4RBkIudT+2LoYWNjN4e8pBbeyzqkw/gYTL+iEkT7Jq3yHzfRLQeJpwIdRDNiGyNb7sxPm2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XPSoyJt9; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XPSoyJt9"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e035f7b5976so1789596276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 21:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636855; x=1720241655; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f+WpsI3yIr9mN4RMcQsfbBJbpJrC2f0IEM8v/SsuTU8=;
        b=XPSoyJt9Y0c2HHwiZfIA1kIFvWSGlFli7Jq/FbN2zRCbAvft7ZFa9hlbPfmXE397nc
         kLU2sbYen7KXx+SxJE19ah4l5nx7jS6F095r9XKh5cbeql0qPW7ah85OQc9usGqkFPrt
         Porsdp3PhvwoMvkiVlbgazRvcCgC0ZE8EdJ7++y+KmMcv7S1eqhvN6FlKdbr57S4yDSy
         kH3SUAVkYNWTRrzjsgXffXVazc84EeWCWd4AleLPFHBPX6J0TAdY00sDsmVfNxSWYnqC
         OQ6Z3esLji8ZifxqNtyvaVvG5QF4Wz6sFeYNME+g6P1WL9/jEHr78ynclcuK5d5U89Ty
         /6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636855; x=1720241655;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+WpsI3yIr9mN4RMcQsfbBJbpJrC2f0IEM8v/SsuTU8=;
        b=QaVsre+NtvS90f/MZbUZT+egt5HLWTmdfc0zu9Pf26kholxaVYqUGX6mVYeoTRGQf4
         V1vCUtRZ+iufK5gsVSBB6xtarimO3BIRoGab0njI7A8axB6frW4nh0x8iq0NuUEtZDJy
         WvMmR3YrfdyPPu5OiVsGfV0rxXSAtaMwNTCA+8H7zCUiqOMtJNHI+uOGg16dgembuXOn
         Poww6FqMtrxXSAL4m56IxZBlRZH5XFQMPJ4inll2LwyxuYiKV6JzTTeXILeggOGyBpN3
         fyvchnCPV7IDz8V+gDwIUNyoWpRUExoVk+9e0mlCu5K0Hc05Y0W7tBUUkRjkbldex0jy
         8QEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE1UhE96/7cMYCfFwGojQkF5pFXeMuDsvweeIiz0SNi4AgXH2Xk1o2ws9eth/g09tI7DCsVYNodbJE9op/7i1p6IZYdw7anvPjBpe3FYOb2w==
X-Gm-Message-State: AOJu0Yw/YX4L/sQoYtlg5O+1iyM+UavXBizf5DaBiovUMOIyrROZtTE5
	AVSPhis+CemL5og2tV2iBeswja2SbnoqsPxD3R0gjr9fe9ZOhQ0QIRNvUfFwla3/Wwh0cuBLfe4
	D5U/Q/A==
X-Google-Smtp-Source: AGHT+IGMi/lHrEFtm0Z40jfIFCI9s35ScBy5zlFP4QYSWWuLbXB3dXTlsTE45QCbr4hFKjzKSU0BaZaSc2PA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a05:6902:102f:b0:dfa:ff27:db9 with SMTP id
 3f1490d57ef6-e036e0b506bmr33645276.5.1719636854757; Fri, 28 Jun 2024 21:54:14
 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:25 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 03/28] perf cs-etm: Fix address sanitizer dso build failure
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

cs-etm.c had been missed from having accessor functions added for the
sake of reference count checking. Add the function calls and missing
dso accessor functions.

Fixes: ee756ef7491e ("perf dso: Add reference count checking and accessor functions")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cs-etm.c | 10 +++++-----
 tools/perf/util/dso.h    | 10 ++++++++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index c53812f343e9..7fd976ea954b 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1013,7 +1013,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 	if (!dso)
 		goto out;
 
-	if (dso->data.status == DSO_DATA_STATUS_ERROR &&
+	if (dso__data(dso)->status == DSO_DATA_STATUS_ERROR &&
 	    dso__data_status_seen(dso, DSO_DATA_STATUS_SEEN_ITRACE))
 		goto out;
 
@@ -1027,11 +1027,11 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 	if (len <= 0) {
 		ui__warning_once("CS ETM Trace: Missing DSO. Use 'perf archive' or debuginfod to export data from the traced system.\n"
 				 "              Enable CONFIG_PROC_KCORE or use option '-k /path/to/vmlinux' for kernel symbols.\n");
-		if (!dso->auxtrace_warned) {
+		if (!dso__auxtrace_warned(dso)) {
 			pr_err("CS ETM Trace: Debug data not found for address %#"PRIx64" in %s\n",
-				    address,
-				    dso->long_name ? dso->long_name : "Unknown");
-			dso->auxtrace_warned = true;
+				address,
+				dso__long_name(dso) ? dso__long_name(dso) : "Unknown");
+			dso__set_auxtrace_warned(dso);
 		}
 		goto out;
 	}
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index d72f3b8c37f6..878c1f441868 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -280,6 +280,16 @@ static inline void dso__set_annotate_warned(struct dso *dso)
 	RC_CHK_ACCESS(dso)->annotate_warned = 1;
 }
 
+static inline bool dso__auxtrace_warned(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->auxtrace_warned;
+}
+
+static inline void dso__set_auxtrace_warned(struct dso *dso)
+{
+	RC_CHK_ACCESS(dso)->auxtrace_warned = 1;
+}
+
 static inline struct auxtrace_cache *dso__auxtrace_cache(struct dso *dso)
 {
 	return RC_CHK_ACCESS(dso)->auxtrace_cache;
-- 
2.45.2.803.g4e1b14247a-goog

