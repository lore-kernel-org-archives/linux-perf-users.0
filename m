Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091913D47BE
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Mar 2026 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773433703; cv=none; b=KBicfsrCl0135JyTXgVLrm1m/NMc2fKdM1/qYnskx7bcL6T/pTu2jE1bfBEVyrslQPQ5RKZZSL4wkyL2/66rG0ZeYzA9cIK01MTWhYBlgRAy5AJ/v0q1WwJ5MHbXFfG9IUhnFuGxphRetsl79uFAmNZZpkY4yWZhi2I3FSL//YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773433703; c=relaxed/simple;
	bh=4mSJoDt19c1s52Ar2qiFo/PGbNpyNgJireRDLID11TM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g/uP3oquUH2aVCYZS2ol1HhwCfyrSl06C7dTVv7dHxULVeVDY/8+Keo+TUWawJiA7iB/zrAiFSp1vmXItpZBUncUIJ8KcuBw77ml3qbmkSmm84ic5Ba/bm2681tr6CguW4hMYkqK9z4nqzlBoAiBeSSPIl06Wg8STt6khZA9XG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dervKtwS; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dervKtwS"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bea80a5849so23533164eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Mar 2026 13:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773433701; x=1774038501; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jjPd8hYb03Ftsdibhr+aMw0AWnG2dzFR9qnmX2QMSHk=;
        b=dervKtwSKYVh/b0MfN1im6EA84VC/RbYu8vrPgB0F3TBfy/60yDWAKN5uR5vudboJZ
         2Zg9/IOsLzHpr78iAlplhdf2LUPr85rIzuczjqtcu2OekUELJFDo3+va1c2//Wn9SIek
         svhuLxLtdIOPtAa58pjFOb+ZYGfGZaOwcpYI6bwUs6cUU1FiUSRCT1mWVbM6ZYwueBGz
         WzE6lBp3PzrygmgVd8iZgW/UV0bD/6iMzxIoKkytaVPgInx1M7b6hAutfYTbo41c8zAL
         c9YizDZfO+l+dw7cTG3MlnY0DczYBFzHJ+FSCblbS4RqbHSPuUHFdrANCwnP6xU5LheD
         L6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773433701; x=1774038501;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjPd8hYb03Ftsdibhr+aMw0AWnG2dzFR9qnmX2QMSHk=;
        b=i+4FV3AEqUkCs2tHfbnPi07wPBARm2gV2uVxtF0dG0o7lnURlJSB0+VYDbvZ9WsZSU
         JWThL0FjtsGdJK7pmV5eEpHQuFikUnee/hgvIp6RnfXMPv2q5uY0dhUD+RMZD60b3qu1
         Hk+o88qRxtpvdiIC2OVrfo/kEoAPAcDUVlPd+5XiHjcViHu9TAOfjZynyNGCJj6MgoFV
         fPXlfaKty5egJGP8JcYq0eoG61D/+ZhH1CRE1F/rNKvgwsa/yrXVR7OFGMegphQVg8br
         Ru+Zb7DPxBQUD5PsVA2zPEeUzKOGQG3bQ+LgyBMnj4bq+QUoYYiTfipGp+T6+h8AVjYO
         wZ9g==
X-Forwarded-Encrypted: i=1; AJvYcCX+6CpfI9PKR4l/2M9Mqae2TT6FwiJ5R7xi6NPw4O7AudAbwLlSw7nspqMwuMTeD5R15pzG80sfYD4zcILRol2A@vger.kernel.org
X-Gm-Message-State: AOJu0YwknBj37f6VuqvomUFIX+N11DrrrsgYQXSQkri4fqN7ECNVSXu5
	ZCBAn36amZyOWjMMXmKaaB46iuFSZQNj1bvRjzkwy8bZhjSCCjPWhd1DEV88vNQ3FpX7kVu+BmW
	xgSlb7Q/XxA==
X-Received: from dlbtu10.prod.google.com ([2002:a05:7022:3c0a:b0:128:cffb:50d7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f97:b0:128:d2b3:5df
 with SMTP id a92af1059eb24-128f3dc5240mr2249642c88.23.1773433700828; Fri, 13
 Mar 2026 13:28:20 -0700 (PDT)
Date: Fri, 13 Mar 2026 13:28:10 -0700
In-Reply-To: <20260313202811.2599195-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260312061628.1593105-1-irogers@google.com> <20260313202811.2599195-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260313202811.2599195-3-irogers@google.com>
Subject: [PATCH v3 2/3] perf target: Constify simple check functions
From: Ian Rogers <irogers@google.com>
To: tmricht@linux.ibm.com
Cc: irogers@google.com, acme@kernel.org, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Allow the target to be const in callers.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/target.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
index 84ebb9c940c6..bc2bff9c6842 100644
--- a/tools/perf/util/target.h
+++ b/tools/perf/util/target.h
@@ -49,22 +49,22 @@ uid_t parse_uid(const char *str);
 
 int target__strerror(struct target *target, int errnum, char *buf, size_t buflen);
 
-static inline bool target__has_task(struct target *target)
+static inline bool target__has_task(const struct target *target)
 {
 	return target->tid || target->pid;
 }
 
-static inline bool target__has_cpu(struct target *target)
+static inline bool target__has_cpu(const struct target *target)
 {
 	return target->system_wide || target->cpu_list;
 }
 
-static inline bool target__none(struct target *target)
+static inline bool target__none(const struct target *target)
 {
 	return !target__has_task(target) && !target__has_cpu(target);
 }
 
-static inline bool target__enable_on_exec(struct target *target)
+static inline bool target__enable_on_exec(const struct target *target)
 {
 	/*
 	 * Normally enable_on_exec should be set if:
@@ -75,12 +75,12 @@ static inline bool target__enable_on_exec(struct target *target)
 	return target__none(target) && !target->initial_delay;
 }
 
-static inline bool target__has_per_thread(struct target *target)
+static inline bool target__has_per_thread(const struct target *target)
 {
 	return target->system_wide && target->per_thread;
 }
 
-static inline bool target__uses_dummy_map(struct target *target)
+static inline bool target__uses_dummy_map(const struct target *target)
 {
 	bool use_dummy = false;
 
-- 
2.53.0.851.ga537e3e6e9-goog

