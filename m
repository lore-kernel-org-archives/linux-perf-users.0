Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A64378823
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773856707; cv=none; b=QNXF6B8iJmAOERr3T7J36VxsT6M2uptnF4gqkH41qEk97MxHdSD+V6aCiBfEu9Mm3uMC9pjcnsjO1eqe8IdnypS3bDGVFE4uNfNcHq5D98Mz0PlM1iX7+CB/QC5CNYfLYBMIelvpboZ4AZp7oLwEcH/5JRfFiL2TeBu84YWkZpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773856707; c=relaxed/simple;
	bh=AT0BGB6UrGLZA1M+tVNdNXzlDjYmvZvAEkPOTSTH+IM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DyDMnSKybprId3MTmUdkSDdDcgyuDOrmIl97MbUFMKTOZYwC5eZsUL3d6ysFnXNAwTXeOfW3Yu8chHLg/rJM4i7zNhO3we7YRamQhYkJenohD2Frzf1qdt1V8EvI4Lx7cl5SXw/vmnuXrzyQRB438AJKq0VQS9qhRdh36yXRCy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LWCfF2UN; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LWCfF2UN"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0bddb9196so99624eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 10:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773856704; x=1774461504; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tQVp2xNbIouZw2DsKLWRE3G9FMoorezshWZvQPd6XX0=;
        b=LWCfF2UNhL6Jch4lENdJtDfdQMjYCnFOzHoN2rh4tKKe5Cl42qytHZZ026UAWqrMOo
         ACUGTC9dreo1Onar5rihAFpmDq75OvJClxhU0djsBdTYxhxEYubWh1k/WoAlLqhNuioh
         xPjmUeRB1U8b6FeY3lKpWXprUVVQy7G3ARPugdyprX/kGGl0nqibWdN5tWzDd047j5Ro
         e3qsXozx637II3laFWyYyV0Ew89Hke29fEO3N270aLasXPVPKMaK8UY5NwCalFUfcqRY
         hdH8cMj1WgwSRCsfsIYfeKs2rmRj6Ssx/w71viUtstAcI0HaIoOs42/my5ISLXcx+zTf
         3PPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773856704; x=1774461504;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQVp2xNbIouZw2DsKLWRE3G9FMoorezshWZvQPd6XX0=;
        b=WCfCFi0pRBS1xd6pFxxySCge0u3KEMAg9szpWryJHqGK4fGNpYoAjVSqvlbALmoSwd
         r78AJ4qGiVqcy5tAGGkMjl8GTgB1utLlp19a6Hj2I/cu4GgdBIhZsfnRMohcby/+clyg
         38wpayvYgIoRDAMwWKalj67MvKe+uRRdZknSBwJA5vQgqcy2Iah2M9tUycDp/o8tYjkp
         SMURStUreGMEvRyORw+1dx4ZpvoGTxeLbWhj3ZYVCpDVYnHxxYo6wqq5CVKw51jwUIUr
         RPK9P/+SjjgStsXyqVOzrrNOLFj/7iQhxJIKc+sZYZ7av7I9VGLE+myLEWGLWlcYwSlF
         fI6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXc9Py6dcvwGGRnAmWD24kxeqbtf0jgDWZLHXBFYKYxAfqCTVjDSuwyQ8D3G8MTe6qWPIPVqLJKZhM7dBDNd9Qs@vger.kernel.org
X-Gm-Message-State: AOJu0YwPnDn7IYhKZBAkV/NPhJu/TSA2KG2Ya/gO2F/Wlf2XJnFjKHo5
	cM10CG5Arrthd9EESpJdYsvHr5sLw+xXMJT92Yn0WJyxmzfbvsq0BDskj4l1AzfqtOs+mySPCzf
	F1h+zGzB1iw==
X-Received: from dycrm13.prod.google.com ([2002:a05:693c:2a0d:b0:2c0:d104:830b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:dc91:b0:2b7:fdb6:ccf6
 with SMTP id 5a478bee46e88-2c0e4fb8e1dmr2171218eec.14.1773856704365; Wed, 18
 Mar 2026 10:58:24 -0700 (PDT)
Date: Wed, 18 Mar 2026 10:58:05 -0700
In-Reply-To: <20260318175808.582009-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fWCf1TFMW8epW8moOcUbMuzRjrG1r38SWFevH35mqR0+w@mail.gmail.com>
 <20260318175808.582009-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260318175808.582009-3-irogers@google.com>
Subject: [PATCH v7 2/5] perf target: Constify simple check functions
From: Ian Rogers <irogers@google.com>
To: tmricht@linux.ibm.com
Cc: irogers@google.com, acme@kernel.org, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Allow the target to be const in callers.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
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

