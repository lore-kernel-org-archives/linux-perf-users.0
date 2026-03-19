Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8539E37B3F5
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773963240; cv=none; b=Ar8wlbllSjvlLKhJi2XLVWcWFDwjg1cPMW6Aldt9CByFPfjx5WtYvVmEbkCshXKd4sm7dGn6gnXqcMoVivmL+ckR3qLE5ad9JaKcR7cSzNg60afrdigAWTtAIb0Kt61akfuV3fNtnwXemrymGzpd1bCovLsOWTlo7Ig44JYI7h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773963240; c=relaxed/simple;
	bh=jaKQNWDztSTVc9carY07JbD+L36D0ujHAkrR1d3xcKE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ML69Uxt6hpRATf2BNkWg+Y3lAVy27Xd+AJ0yGvYq6s0K6eNEuZR1/+cvkrWW/wk1YqNIV9V/7JORI4cKQ42i6ax8bSFsNKlw49l5ELCs9+DnTaohfKMPD4Iak5sBAR4cNwXYtJGXyaWv0EkCNj4hozrp2nfJA6YBA4gPLeWckDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bN2frJ+q; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bN2frJ+q"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3595485abbbso2074063a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 16:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773963239; x=1774568039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBprN/SDxVbpqiWt0IwbTwUWMFsC5LXCcAsRDziglik=;
        b=bN2frJ+qNxrBCarZjkkLMfMeevrsH4ZV07wQz0fwGrfWKjhAJkHJ82GSr5WfRA3mIs
         zLD1hFleN4/lbnsUds7IWGRrWYfguYxZAwayixzOFnksiMUZlk2gFrqiI5M1DtNbcmro
         U+zoaHFVh8DYSh/VXUX51TYtiM99CmfobzQwSdCe1FHcersjTC7tjmelTJku5TuvpqTF
         LorKkPd8aT5GIiaE0Dx1oYz2I2jmydaKT62/UgH33JMMxvR1flpTiG+0Wt3Nc5jB9Gx3
         Tzkw+G6cg3jybEb87MNw4gByHzob3yu6vnGIdEEQOYMzQQ6rC5T8ZD/r0b30ijG6yC3Y
         065A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773963239; x=1774568039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBprN/SDxVbpqiWt0IwbTwUWMFsC5LXCcAsRDziglik=;
        b=JNOcUpw0yZh64HSWrrOcgmz8YGry8XnkTGegrTM8IZbWJJyoq63X6PEWr9c9HrojFw
         rWfKkt/9Vtfz/3yVatneVsS55BdMI/ngneeiV5fswrTy/BtRpyw6KrT43i+pG5HYzv71
         QNFD3sMvdWQ/WnF351AkQ7IygXn+SGrjyfuXY3NLOBp+7KizWQen6ultiv+/+54qYohW
         27b7o1QinMm+04zh7qSfrb1P99kgqXOIcejpwsfKIlcdvZ3UfduSdZeiUrSjmyRqPa5F
         bbXVesHmoUh+vcN8GEBviygFTSAqh+Mwz/Tq6K9TE5/xCf53kR1akmAFuD4MDZMz9p60
         QdCw==
X-Forwarded-Encrypted: i=1; AJvYcCUGkBozcqx8nCf9FNsinXCXFj1rJ0Q4tCI9bT7row0f/KwpnCOaYVuJBRm2AaEyBhVhKAa7TflmonSW19pLbHkd@vger.kernel.org
X-Gm-Message-State: AOJu0YxamEYAjO1ManTXl+ZqdkiH7T7CxDA/TJgjAO+6TkJ5FjhwjNEV
	qmXzYPkHqrHR0e9OFSD++E5DU7ZHGzoTrFUgbfX+um9KxhB/+AVoGc+KtctMUwPNrHBZcZslCrY
	vB51ZPqD4KQ==
X-Received: from pjey9.prod.google.com ([2002:a17:90a:16c9:b0:35b:91c7:d49d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f88:b0:35b:a44f:b8a
 with SMTP id 98e67ed59e1d1-35bd2ba3293mr652535a91.6.1773963238705; Thu, 19
 Mar 2026 16:33:58 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:33:48 -0700
In-Reply-To: <20260319221215.207951-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319221215.207951-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260319233349.306012-1-irogers@google.com>
Subject: [PATCH v2 1/2] perf lock: Fix option value type in parse_max_stack
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

The value is a void* and the address of an int, max_stack_depth, is
set up in the perf lock options. The parse_max_stack function treats
the int* as a long*, make this more correct by declaring the value to
be an int*.

Fixes: 0a277b622670 ("perf lock contention: Check --max-stack option")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index e8962c985d34..5585aeb97684 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2250,7 +2250,7 @@ static int parse_map_entry(const struct option *opt, const char *str,
 static int parse_max_stack(const struct option *opt, const char *str,
 			   int unset __maybe_unused)
 {
-	unsigned long *len = (unsigned long *)opt->value;
+	int *len = opt->value;
 	long val;
 	char *endptr;
 
-- 
2.53.0.959.g497ff81fa9-goog

