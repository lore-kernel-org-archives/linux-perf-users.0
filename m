Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE20440F732
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 22:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189094; cv=none; b=l0Rv5UskvrBIh+bwgQr5VGOrIrOerk3k1TUECu9kpyUAm+mDkXEhJYg7E9JRQexPqvkBx9LUvzAW38UZfDZZyC/GTOoIA+yIrrHGzjR3xAMKuMcTwRrH0Uga8CoQtFF4i+dKqD+croeYC2js4PhfI5420xXNslzjdILmMNsoYg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189094; c=relaxed/simple;
	bh=wrvIrrRxxCxbjC5y19PcJbeqSjug7uXwZUzwZWAtOzg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=czqYrOTPOfpIZrZy75nn1suAKibpDACObF5ojWxV/gp9Q7rUDMGkbMoSFu5ja9ewGExyPK4DSrWOtxkFOXWQ9f6maKGJPgNS+egfORbWGtztAYygfdbVQHbaoU7T2nDfl1Kro/BrMwMjeN0cZ20uov1jd3wcXh/mIkJVt8awEgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GERgQ7VE; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GERgQ7VE"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-147be78cd56so1168139c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 15:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792189093; x=1792793893; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=viOIzDo9krKszOCmVOjeW9f2aQpRArqmnQIoNv00KM8=;
        b=GERgQ7VEptYHtuywXeGPexcRRABvAQlOCTyBqWgsp03EktZ9iq6MC2XaYh1+OH4SfX
         783Tefip3c7gxWwZCHrPcRH9gnSZ94Q18yx2O6ePin/mnFrtg/se76AleW2HJmFPk+BQ
         z1ETQ35cMMYyzwycJIqRwvnyQg57hu6y5AK6THK+CW4/X0JkhaVT1bCanI2wFzaOqHLk
         ce1vfuJ76j/Vufazemzq8cHEf2/TzBSPztY6ku7wJ7ThBVsZpCV836+7Rio1jq134ytO
         1pnR83OpesSGOnl37kVKjeheOFJHabCzOXkAre8UXl3fmSMKTliXuTnn8ehLaWw8sKMH
         RrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792189093; x=1792793893;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=viOIzDo9krKszOCmVOjeW9f2aQpRArqmnQIoNv00KM8=;
        b=mDWuZGjTwYSZCnq+eexN/hPvyVYnMFmcnFWVcZQvQ3Ata8gq+3VBHfHzp545hU9oK1
         S1fcCCdzL18tp9PhVGQzFPNB1tGOQ2nUBt2gnpNFwBcWWJC8cfqWi3rt1S2+am6htSwC
         QW8629wauCyjKV2WH9d9q4NMDT0kE7Dt2fNW5JuvmgyNA1Nv5QRs7vSCOretELT6+wMO
         rrX9g+AU9YHCeyGmPpUbUkg7iXQ+UHAMa9V/B4XYRStfG5HLxOrHYkgk7PTma5o0s5Nl
         etq8gZLUljsqf+xJVBmhSnzBu1Vz8lONj+ld8PcHG2vAmz2eWlwmtrjYkyINCCtNmfNL
         tdiA==
X-Forwarded-Encrypted: i=1; AKwUvBz6eYFB30OG4wY19eh6eWK3cJP2l+s+gEJs1G3iAHFkpERHq4w4hTiIau0pFk4u0FfmRh3XC2j0MDPUE4KLeYUo@vger.kernel.org
X-Gm-Message-State: AFq9FYIz4efTHb+gVFaiS97Z+N51qzIAi7KGaHC/GSPHBXcxmRS620FJ
	ZU8DkI3qRp5Fp8JZcLRcUQHZdc44GRmKTxwQwKr88MtSjrZUZm7A+fGFrmcJgBTijzwyrBqNoBx
	rQQzOYpvp+w==
X-Received: from dlbut6.prod.google.com ([2002:a05:7022:7e06:b0:15a:d2bd:6a16])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:464a:b0:143:868a:20c1
 with SMTP id a92af1059eb24-185151be30emr1295600c88.46.1792189092510; Fri, 16
 Oct 2026 15:18:12 -0700 (PDT)
Date: Fri, 16 Oct 2026 15:16:44 -0700
In-Reply-To: <20261016221700.1282659-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016173106.679725-1-irogers@google.com> <20261016221700.1282659-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016221700.1282659-2-irogers@google.com>
Subject: [PATCH v4 01/17] compiler-context-analysis: Avoid unused parameter
 warning in _context_unsafe_alias()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, elver@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

_context_unsafe_alias() does not use its parameter 'p', which triggers
-Wunused-parameter when building code that enables -Wextra (such as
tools/perf, tools/lib/perf, tools/lib/subcmd, and tools/lib/symbol).
Explicitly cast 'p' to void to silence the warning, matching
__assume_ctx_lock() and __assume_shared_ctx_lock().

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/linux/compiler-context-analysis.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler-context-analysis.h b/include/linux/compiler-context-analysis.h
index 8302ebc2ea8c..024e303188ad 100644
--- a/include/linux/compiler-context-analysis.h
+++ b/include/linux/compiler-context-analysis.h
@@ -243,7 +243,7 @@
  * alias as a function argument).
  */
 #define context_unsafe_alias(p) _context_unsafe_alias((void **)&(p))
-static inline void _context_unsafe_alias(void **p) { }
+static inline void _context_unsafe_alias(void **p) { (void)p; }
 
 /**
  * token_context_lock() - declare an abstract global context lock instance
-- 
2.56.0.212.g129ede20d9-goog

