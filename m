Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28909348465
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 23:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773877569; cv=none; b=jwuUQX/wxhHYDtMtwl6zdgPedqyhIZiBkh272B/yTd6LGRWjD4gZ2UjmHZVuF5bArSwvenAInmqey5O6SQqac8hMDqi6PkPyVkg82tmtqDvKQ1rL8W8pe5Z+NL7fcZXHk+Zj4nbn4SWFrR3pJShcuMHe2ikEG5H8SkIvg7RTHa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773877569; c=relaxed/simple;
	bh=AT0BGB6UrGLZA1M+tVNdNXzlDjYmvZvAEkPOTSTH+IM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bnrH1cYHvNHJ7Pbxg2cZuDBv8/pgZgahm3YcO8qSKag6CYbUNzwM85J1TjRFFUPeNI0izEjpVLcIDzOQQxpgShnAaZFnIBqkLGQMVWO1xzX7cMKRJkhGGL9UtuRuBNdAtxptkVmPemfQQMReekDgtm6VjROs/65Mc2LhyIrTWrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eFFxukJo; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eFFxukJo"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so405833eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 16:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773877567; x=1774482367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tQVp2xNbIouZw2DsKLWRE3G9FMoorezshWZvQPd6XX0=;
        b=eFFxukJoIwm93af97U7nWY6GelLr3kLO3o8PC/hgxic/A4hEwADtw6vt8BoOVz+Npa
         aq2MeH1HdlEyIO0Y6ydLETH79WejFjlv6ODR67Um9BG/Uf6y/o8q/kKyW46pot75pQGD
         1Sac//uGc0KmOu3k5fgLGxREy6m27jJLfMNpqLVMESOVLVWf83y742JQSofwrw0as3Kd
         9QRTan4A8ftYlwSSqb7ph9YCHpXNnKn9D5mBaBmkx3wc0wosGS4FEpaKO+dtDiyazFzV
         t0QuYVyG0A271ugqIE4xi1v4igz/v0TvgEIAet14Jrmq5ACYNQ/NT+54iXFUc6OzXpKI
         +Ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773877567; x=1774482367;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQVp2xNbIouZw2DsKLWRE3G9FMoorezshWZvQPd6XX0=;
        b=rREkJ84r6b+XWod5DNbBtzgZek/zkznoI/FmADw1UOYRCq+pfm/TMUtxtYdO2e1t0+
         1WQT6UWS4UahIIGkqva+OLB65x6kbZvmXd386J6tWogUlroj/wIztJrt5dEC1R/mrUjl
         OzenbM2VgWLDwSCni1RX3aU48LvXjh0lRLiRkqqzHh7vvbcYcrfxqkoNV8lcJ8ZkPHUg
         tD+wA2ypHMmjslHsPpznHrgQJYEdCoivnNNbDby2sY1JPwZDZSiXnMUjAfpxyeqH2BTS
         e+mqfwcoBD7FGc7Tu8hULpmJr+Sm1wToRvdZRieZWGPyPcxmdYndTKHtAzq+g9QsbbVw
         R1Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWOVk5Z7ZgFxY3lpZo7IH81Wt09XBlTIQeeqiCWM4U77IQqwW8+CeZ2Vpal074rAUZqsn/ASM91/rCWWLTxco69@vger.kernel.org
X-Gm-Message-State: AOJu0YyHdwWPPVXK3l/B99ZmMrWaakazmOUfgoeKHrbzajPflHUlwdeD
	F96FNwb8kQrPRJaSPj8iZdN9dn4s5ojD1r9Wuig7ZSOzuAvJQWTPxyrUKL9kBV2WcwPM7/oMnID
	MX3F6kjw2BQ==
X-Received: from dyckg8.prod.google.com ([2002:a05:7301:d188:b0:2c0:b1d7:935c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2152:b0:2c0:cb34:7d54
 with SMTP id 5a478bee46e88-2c0e5110301mr2350996eec.28.1773877567053; Wed, 18
 Mar 2026 16:46:07 -0700 (PDT)
Date: Wed, 18 Mar 2026 16:45:57 -0700
In-Reply-To: <20260318234600.730340-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260318175808.582009-1-irogers@google.com> <20260318234600.730340-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260318234600.730340-3-irogers@google.com>
Subject: [PATCH v8 2/5] perf target: Constify simple check functions
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: irogers@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
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

