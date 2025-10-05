Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF9828C86C
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Oct 2025 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688696; cv=none; b=T4eVGIKAsidW5mCmSqSOU3oU8t/1r2c1tNRgObNEGgYoYiBOTYNhbiZIHUMifwU6eR2GARRZw1qpXatGfWRWM6RNp8OxQMjEKTgIRPONY+8O/TIf/LFJ46afy10ao+Fic2rLtQvKWtHFMVbsQ8N+iUAFtOs3ELlVOOIqAX7DRWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688696; c=relaxed/simple;
	bh=oZnPNPyMW5ix5+T/Kd4AGKTs8ir+V+xUhPwOTmL9jbs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rk4gbHTuVrroa6zaiyEvop7WfSo2lg9b0ckL0Z/KtykLgbBLt0Sj4lil+TTWCQ31jrookJhxn7sD7lkr2aR24de7Xvaf/0n3fXHeWtalyY4/MNnMgyBNNEmB7cxwqbh6oS1uDxNGYGLm921V/Lq0lxXs+UBa74/xnB/4B7qLHnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HqN8sLLn; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HqN8sLLn"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-71d605339dbso51398017b3.2
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Oct 2025 11:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688692; x=1760293492; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D4arvNqKzsedVSCdkfpQZv0S1WpR+wuKFKQuvrv0EL4=;
        b=HqN8sLLnDjEymguEwvIeLLasbmcEJJnoxTUnuJxNyyVJuCXPN2Qeud+zkiPogFymn3
         8OuPVNJOWhAjaxylDJs95fv/b0mKatE4IBqhy78EJPeEQIeUl+zKM89PFOyVjJrK294N
         +wH0L5Dq0D1q3LwlwxBY+cokO7vN7poJ9ZHlyg/ur5cdflSM/8od1WEO1lPBm72FqZRf
         NhhSWMipjJMcgiEAew9RQcEyDPvPIF9LHG9WP85VZOxzpp/ORgm0zBKROSqVNHYc4fUi
         coXDCr61eF/TeU+RqtRvhgth0Wo/P5PSmzKvaUJ3kYYx/rF6sl++5+IS7FvKQ0vsGRsI
         Sw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688692; x=1760293492;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4arvNqKzsedVSCdkfpQZv0S1WpR+wuKFKQuvrv0EL4=;
        b=Qkmrsp/U0O442NLUq4Zs2uUaMtRaU2bLFrw/O7mia0Bl8PIWggMqYwEjclXPNeeaqs
         EBPvn8xHI/hzt65gGwjvijsNGZh0/y2E+WLmxIykVtWEyQL2r10tUvpZVVUtB6wsU5ED
         uDngKOX7lETMBqWzjeRYYVnjepjcXUFTuGrf8qC8zuJ3PY/fnKTI5GHB9aAn36LEmvKf
         hrG636CgujQyU3AbaEeD+2sz4W5+mJOy7pHxbibLKnJCky/skqjl9pSKcAFttOR+cTKF
         XNhch5emzXb6NN4A+gEjl4fArgp++vK7iotdLN4TacLQTw0zSbpkUNdBR9V6KT9QsVLT
         1BYg==
X-Forwarded-Encrypted: i=1; AJvYcCW+7ldJSIweyjjw1VVmhlwPD0nHa3By1PCcGYsvzMiua3CPHfzEvi1URQzg9bzCudwsrd5RKSAT9vR0Lu/XkW39@vger.kernel.org
X-Gm-Message-State: AOJu0YztjCsoSei/H/vPWq60DjtHccx6FSPq4Uey6KBZru3/5Bfw888C
	E0oXGDy9/CL6jzcvStGyEikOWDjuNALb8PvoXFzqWHbh58599/fSCmJ1TBjAi9PygSruXhWLuOV
	EItZLZgfiMw==
X-Google-Smtp-Source: AGHT+IEw2/JXqLShPZMslUk0GjRr0iuxlNgoFPDvapIN0gqC4oxja82ZpFUlCEDu9ZwJOU2j/xwpivCNzl1z
X-Received: from ywbhv8.prod.google.com ([2002:a05:690c:4988:b0:729:15e7:9e4f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:7341:b0:74d:4623:46d6
 with SMTP id 00721157ae682-77f9470ac39mr109550347b3.50.1759688692320; Sun, 05
 Oct 2025 11:24:52 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:11 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-9-irogers@google.com>
Subject: [PATCH v7 08/27] perf pmu: Use fd rather than FILE from new_alias
From: Ian Rogers <irogers@google.com>
To: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Ian Rogers <irogers@google.com>, Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

The FILE argument was necessary for the scanner but now that
functionality is not being used we can switch to just using
io__getline which should cut down on stdio buffer usage.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 876e87708b03..7992bd923515 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -563,7 +563,7 @@ static int update_alias(const struct pmu_event *pe,
 }
 
 static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
-				const char *desc, const char *val, FILE *val_fd,
+				const char *desc, const char *val, int val_fd,
 			        const struct pmu_event *pe, enum event_source src)
 {
 	struct perf_pmu_alias *alias, *old_alias;
@@ -614,12 +614,15 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 	if (ret)
 		return ret;
 
-	if (!val_fd) {
+	if (val_fd < 0) {
 		alias->terms = strdup(val);
 	} else {
+		char buf[256];
+		struct io io;
 		size_t line_len;
 
-		ret = getline(&alias->terms, &line_len, val_fd) < 0 ? -errno : 0;
+		io__init(&io, val_fd, buf, sizeof(buf));
+		ret = io__getline(&io, &alias->terms, &line_len) < 0 ? -errno : 0;
 		if (ret) {
 			pr_err("Failed to read alias %s\n", name);
 			return ret;
@@ -698,7 +701,6 @@ static int __pmu_aliases_parse(struct perf_pmu *pmu, int events_dir_fd)
 	while ((evt_ent = io_dir__readdir(&event_dir))) {
 		char *name = evt_ent->d_name;
 		int fd;
-		FILE *file;
 
 		if (!strcmp(name, ".") || !strcmp(name, ".."))
 			continue;
@@ -714,17 +716,12 @@ static int __pmu_aliases_parse(struct perf_pmu *pmu, int events_dir_fd)
 			pr_debug("Cannot open %s\n", name);
 			continue;
 		}
-		file = fdopen(fd, "r");
-		if (!file) {
-			close(fd);
-			continue;
-		}
 
 		if (perf_pmu__new_alias(pmu, name, /*desc=*/ NULL,
-					/*val=*/ NULL, file, /*pe=*/ NULL,
+					/*val=*/ NULL, fd, /*pe=*/ NULL,
 					EVENT_SRC_SYSFS) < 0)
 			pr_debug("Cannot set up %s\n", name);
-		fclose(file);
+		close(fd);
 	}
 
 	pmu->sysfs_aliases_loaded = true;
@@ -1041,7 +1038,7 @@ static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
 {
 	struct perf_pmu *pmu = vdata;
 
-	perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=*/ NULL,
+	perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=*/ -1,
 			    pe, EVENT_SRC_CPU_JSON);
 	return 0;
 }
@@ -1090,7 +1087,7 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
 				pe->name,
 				pe->desc,
 				pe->event,
-				/*val_fd=*/ NULL,
+				/*val_fd=*/ -1,
 				pe,
 				EVENT_SRC_SYS_JSON);
 	}
-- 
2.51.0.618.g983fd99d29-goog

