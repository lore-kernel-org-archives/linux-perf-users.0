Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11D437EFEA
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770213; cv=none; b=PnPvlAlBFpCZKEV30UQTtOJVuIT2KHYMOWHCZrAQ9IhWgemVHi/3KOeroKqUTw5yxQtDqIf1D0s7010cjAJ2b6Cf4Raez1MVfHYV/OOHSmDTaCfk9zBdqEtGp87gFiHR8oHbl1wD7DrT1ejNczr7W8FtcoLKtOsRG/uaq26qsxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770213; c=relaxed/simple;
	bh=4mSJoDt19c1s52Ar2qiFo/PGbNpyNgJireRDLID11TM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QUCnpEEaLzMf9skiUycCcUB3J+vPtzT2Hrtuw7JhCgoN6qkRblaY+VuPzAP/xYOSuXhqvwH+4YXic4KqgPUy58XelEuek+WA2YzONq7JZmO/GPTE5fdalBRzK0uPDd5xRYBLqyHZKP2LtyFWs3RZTKyJgEyBNouWAkRid+5RWWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b0MEFX3n; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b0MEFX3n"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-128d285d6c3so3354877c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 10:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773770211; x=1774375011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jjPd8hYb03Ftsdibhr+aMw0AWnG2dzFR9qnmX2QMSHk=;
        b=b0MEFX3nyUIlJFr4lNpX+j6cumxZqSK9Xp88Yu+hYw39NTaqlky/tYTHlZ57J0wqwv
         5Xaj8YvytaXWYYCY2m5M8zF5v/8XIh21LU5l/dBPY1XYgJs/pEaVbwXGCRkn2ZkSziUB
         wSf8bthyQ+HxgFTPVzmwJwi/3+gOhgwk5nrGaU/OIRd5RI2IbC7Viek0okDn7BmaoOkU
         AhrkzQ73/C/3YPGwZ8tTIPQSB5SPf+eJpImnjWMC+I6OjyE8IktRFWmcy/Q/xGgNKy8c
         Z9/Uh6CClpNiJWbM3M8HmxIomvWGrcgM2/V+O7Qo/IqifyXZ7a7JYRUmxVdyWNU2yO8+
         tDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773770211; x=1774375011;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjPd8hYb03Ftsdibhr+aMw0AWnG2dzFR9qnmX2QMSHk=;
        b=aV9qrrFMzRLuCx45jX5xGig4GPZUtYPoz0H+IXAubKSVK0eBZiyso3ddG0D7SnvDDx
         C6n0cTNlzB+5/nfDltcti4BTbrXxQ5Wz4gnstc/av9TrZpOViUT6CNdkhrqOwNULGAjy
         +0OTGKTC70thI86ai051xypdk3SRVzir+O97iJ48UevFQNCWvyw9vRHD1wWctnZEPRag
         McntgltX7z6FwkFA3Hn+3YHQLflnFtknFRlGYLz+iDqsXfIg3NDQjDvCdzVVjJMDCueL
         Qi242n7l2Qyrc8SNlqa2VKG5J82rGfAyXWgP1ogUljB6TEMnobp1TY1rIoMbAB82NL+7
         Ep5A==
X-Forwarded-Encrypted: i=1; AJvYcCUcC7xeE4cbIMF2PmWMQLIJp/1QJn96XPj2/bWO8TlNDz2VCzImkGD9XMy27p+FrBR+m4zZbdE8MG1Y/OH13sP4@vger.kernel.org
X-Gm-Message-State: AOJu0YwvxS9/mUFBC9wCeW6sPjsq8lYvYjur9r0fLgPgYRDrmm7xd2lB
	JpGY6vyPX4piCO1Akf5Ur9OwMCkHb0MFviyELuUjuGXGGzitSdcfcOWrDq3X94okJ7SX+D7YR0z
	rwNwIzJ72fQ==
X-Received: from dyw20.prod.google.com ([2002:a05:7300:8814:b0:2bd:fbeb:5cfb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:60f:b0:128:df3d:cd97
 with SMTP id a92af1059eb24-129a7177e06mr175017c88.35.1773770210718; Tue, 17
 Mar 2026 10:56:50 -0700 (PDT)
Date: Tue, 17 Mar 2026 10:56:39 -0700
In-Reply-To: <20260317175642.161647-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fUO8azimnOV2Ogb93nZ3eXnaLdGo6b+3wPVf0tMz29JqQ@mail.gmail.com>
 <20260317175642.161647-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260317175642.161647-3-irogers@google.com>
Subject: [PATCH v6 2/5] perf target: Constify simple check functions
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

