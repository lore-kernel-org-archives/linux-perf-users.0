Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56820318EE4
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777705223; cv=none; b=Jo2FrzaeeRFMyVb8T2iUdvhwhfvbhm5rq79qKUpRLY0yuxHZSC78lxu9nWRdU9OhNBV2zFfZh+++0NgBDhqSUhKDcuzQG/UXnMJgSLSl8VPfxzS9XXsocdwychyxLpW2Fo/i6RiiGDX4uH2ho0O898cO0K9xu2OdjBf3PudffdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777705223; c=relaxed/simple;
	bh=c4FiPhwMPGjOldhXx4uHpCVyzOAjd9KqZ+0a05dC6CQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JXwGPfEl4D+RpxZV5sxbC9gdFBhPHX39pnNy7Q9myNU48vZCOHuRc8aa3mzJ1oUCZRRtPqxGm5G0dY3V8VpQeT0YGRX+h8a36bgMoaoITPT0YxyDzqal4DOAw7yKwmv5N5SHi/foFbLyAnGc7niI2dFy/OKW8239utc2v3Voekk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TiWcYNau; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TiWcYNau"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so4142963eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 00:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777705221; x=1778310021; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NWG6WVYKqonosS/UYZznxYSjLbNNh2VpTpdvGbEDeek=;
        b=TiWcYNauAR8lclOwkz40/HL/Zd9KGhgQLInFOcBid1KY4q+nEAaUd4d0lGFJDv9saD
         7AF0YExkR9DO1Kj1FxBt27OOr0tl2/sdlK72GC/fnx6/Clq0HbeACcoHVRdElXEAGM6v
         YVjOTWVXAVJeTz7zYVy/KzL1jQ5qao7mrdbNmx6EtUaGsFIECJb5qwTPNcGcABl0tYd+
         tJvP0pU41Deyn+d1fS6eOPCK5acnVaW3vkudQQzBaZxDx+9Qcdo39pVGzesmNRFMhKrc
         gs/8EPp7h9WJoPzFlmJxdlsKvyEKP6oMlKthPJ6H9/SXI4MJ/AThBhdM5bCANkE3ERx4
         KI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777705221; x=1778310021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NWG6WVYKqonosS/UYZznxYSjLbNNh2VpTpdvGbEDeek=;
        b=SXc5RO/kqOCJt14qbVlr87sjEOyFfFpbpiP9zJfY6rlT/dKqcOgmnT01iEnLIip20w
         nFJK+uWbiPkVzuK9P4xfgHweB19WGlICPf+cdhu888xQIaQHVtiMG9dvzVxGfJWllhBE
         MyP1C8/Lw5UgFOwKiU1kPar8qRVAAuEO8ctizw13go4oEKM9upZRwM1kvB9iotnp1eVP
         p8OiMzksNpLVEzkxFH+E3UbeGFwdg9MQ1DkF7FupL7vgVamtzkIy0q6Kz0D4AVYAqc+T
         H1ax3K71GNzzROPpcztuVg7WtNlZSbzIrysZfusBAh0rmDL2y4A/z//OUzfamk1ulQW2
         EeGw==
X-Forwarded-Encrypted: i=1; AFNElJ+MKoPYL8VMiDZ+YguhnCZKRRwZKtdYlRiaFdLrhQjGDp2qIq7jpkNk34ZY37HSjnEGWCbij/nk8wfPEcXngxJu@vger.kernel.org
X-Gm-Message-State: AOJu0YwWozsydg1FyG7Q2XdEN6VHusFpI51kVtzaa3ih5yB6LnEBrUVk
	WWl2MFeq05G8ANmmz94v3BH+msmkW62UgdGZmAmkbtoSPv6IFr5tllqHcuiLKtmtnycYzHJ44iQ
	6UlryMA5Atg==
X-Received: from dlaj8.prod.google.com ([2002:a05:701b:2808:b0:12a:ad8d:be18])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:699d:b0:12d:ea4f:99dd
 with SMTP id a92af1059eb24-12dfd83a00amr1001470c88.34.1777705220946; Sat, 02
 May 2026 00:00:20 -0700 (PDT)
Date: Fri,  1 May 2026 23:59:32 -0700
In-Reply-To: <20260502065935.291960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409230620.4176210-2-irogers@google.com> <20260502065935.291960-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502065935.291960-15-irogers@google.com>
Subject: [PATCH v8 14/17] perf env: Remove unused perf_env__raw_arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The switch to using e_machine has made the perf_env__raw_arch function
unused so remove it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/env.c | 18 ------------------
 tools/perf/util/env.h |  1 -
 2 files changed, 19 deletions(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 97f4aa1131a1..5944acd28996 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -451,19 +451,6 @@ int perf_env__read_cpuid(struct perf_env *env)
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
@@ -582,11 +569,6 @@ int perf_env__read_core_pmu_caps(struct perf_env *env)
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
index 68dead1b36a6..a95fd7eb3524 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -191,7 +191,6 @@ const char *perf_env__arch(struct perf_env *env);
 const char *perf_env__arch_strerrno(uint16_t e_machine, int err);
 #endif
 const char *perf_env__cpuid(struct perf_env *env);
-const char *perf_env__raw_arch(struct perf_env *env);
 int perf_env__nr_cpus_avail(struct perf_env *env);
 
 void perf_env__init(struct perf_env *env);
-- 
2.54.0.545.g6539524ca2-goog

