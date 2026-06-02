Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCDB3F7A85
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413976; cv=none; b=scTNJJngJc3JqByMPSncaX7/LWCIM32WtMSuZhdOGUNl2kWVRTQJkpIkn8Whbb7kvlbSQnBinZjsOZcg3jIN3QKu2l9Fc84MgxIG1Cqr1LJ77/HWJb/h2f6/tdA9yrZf0ziyco4NtFdyvv4zOIEKV1X1z28R862PmBOfdBKCdjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413976; c=relaxed/simple;
	bh=wBx2XjIbGKm4f6lxUHRV7mNoOSTxIfLQoUK89yQfzt4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xy93Y6e0+tz170XihPvwb4fUQWHtdjae3l7RXLrL/Z1nkBdiN5UM8XUGFN5/Gv/P0bIUXe+Hvlpm0eBtKBnovh8jZBFTcRZx/+GlyEdL39TuEUGy0ZNn1Uyp8vQra1wC66Qf3nD2C8B1hEMfER+xA0sz5PStJJmd0Fqs3+1RUm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WLgBe3Eg; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WLgBe3Eg"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-3074797dfa9so557560eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 08:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780413975; x=1781018775; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=harhKEg0rLSKe3QU5NRI1JfZjDmZUxT37Wq4SdyYcDA=;
        b=WLgBe3EgWJEmIlat/WvXPEEfmDVj/AEn8Xe9Xl+LMCnJ1SR6v5ggvgUGuip9wjvdlZ
         5no5yejQdCwxve+KI8s4HDO71FoxN7IjtpRVqrRcs8yyXrEhd/MGXhkqczShXae1Vs6i
         GnRbHddNJyGWLSA6ZSr2SFCFiTZJYvFSvShV8pvr+1cSWKNSFhNkBFUJ43K8ES690+8z
         YX6M3/IT4vhdj4ruExMdPLWFVSCRWDmfy5B9Di11Bj4P1V0K0H58c+F/TCFzGBBcEqqA
         TpxrYQ7ZXZ60FugwmQHxLTRRNUpXbqMcqp1UxbtWZFlbOabcorx0bhyo8l7z5uRNKUiK
         JsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413975; x=1781018775;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=harhKEg0rLSKe3QU5NRI1JfZjDmZUxT37Wq4SdyYcDA=;
        b=ZkEuvl97TtuRlODyFF8wF7LEexkcz41Si6YfbiEHN3Ew1V8axEw01dmCkE/OA0qCBd
         Jt3ObJ24/yV7tYBGGwMKGFmiiYc64EKK7O0Q2HR/nbVQ47tfj6GBEGpIDmzxsaakU98a
         4fClmYpImh7Vg39/4WqhmNX3mCkEDFbka0EEtwZZ7dkwV0Q2Po7UnRg6ISO6twH9fp02
         EPbuq6HLGOlHrDL01cRTmJ6VDcSMQi+lUM3rfxS2nqJMwDQQiN1FAqNEH/uPTBFhVv/v
         E42Md5ftkLK/V0izR9C1exsOao4fDh9tSBio/gVDnkHJAYqzgy2pDZXc7XzaUJ+zUr47
         m/oA==
X-Forwarded-Encrypted: i=1; AFNElJ9fPWajAVdB3y7CedR+avJcEVdS1TVLiP5ddtboEFGOenVZjMKb9qDEC0NXQmBmF8YCh4IRy/85ft06jE/K3bOY@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo7+D2B8pYE2gJQYnPLIy0e9UGx7TzC5K+jcMKEt40Yho6a+I6
	AyWGegNy7xwxiRUEBrwAQ0lg8MhhJp1p+7azyqmj6ZTAd9WNrz9BCZX9q5luIuI71wnKHbDiIe0
	DItjmIsTFTg==
X-Received: from dybmd42.prod.google.com ([2002:a05:7301:182a:b0:300:7c0d:9eac])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4918:b0:304:630d:e4ec
 with SMTP id 5a478bee46e88-304fa666a76mr7942028eec.28.1780413974271; Tue, 02
 Jun 2026 08:26:14 -0700 (PDT)
Date: Tue,  2 Jun 2026 08:25:12 -0700
In-Reply-To: <20260602152516.2831152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602062452.2583619-1-irogers@google.com> <20260602152516.2831152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602152516.2831152-16-irogers@google.com>
Subject: [PATCH v12 15/19] perf env: Remove unused perf_env__raw_arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The switch to using e_machine has made the perf_env__raw_arch function
unused so remove it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/env.c | 18 ------------------
 tools/perf/util/env.h |  1 -
 2 files changed, 19 deletions(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index b41562fb06c6..28c54c58193e 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -470,19 +470,6 @@ int perf_env__read_cpuid(struct perf_env *env)
 	return 0;
 }
 
-static int perf_env__read_arch(struct perf_env *env)
-{
-	struct utsname uts;
-
-	if (env->arch)
-		return 0;
-
-	if (!uname(&uts))
-		env->arch = strdup(uts.machine);
-
-	return env->arch ? 0 : -ENOMEM;
-}
-
 static int perf_env__read_nr_cpus_avail(struct perf_env *env)
 {
 	if (env->nr_cpus_avail == 0)
@@ -601,11 +588,6 @@ int perf_env__read_core_pmu_caps(struct perf_env *env)
 	return ret;
 }
 
-const char *perf_env__raw_arch(struct perf_env *env)
-{
-	return env && !perf_env__read_arch(env) ? env->arch : "unknown";
-}
-
 int perf_env__nr_cpus_avail(struct perf_env *env)
 {
 	return env && !perf_env__read_nr_cpus_avail(env) ? env->nr_cpus_avail : 0;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 5a917271ca0d..83e74328798f 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -190,7 +190,6 @@ uint16_t perf_env__e_machine(struct perf_env *env, uint32_t *e_flags);
 const char *perf_env__arch(struct perf_env *env);
 const char *perf_env__arch_strerrno(uint16_t e_machine, int err);
 const char *perf_env__cpuid(struct perf_env *env);
-const char *perf_env__raw_arch(struct perf_env *env);
 int perf_env__nr_cpus_avail(struct perf_env *env);
 
 void perf_env__init(struct perf_env *env);
-- 
2.54.0.929.g9b7fa37559-goog

