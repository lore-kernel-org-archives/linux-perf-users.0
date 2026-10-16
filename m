Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9880857F740
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792171877; cv=none; b=n/PWeqU8ZNNOLJyo5tRaRFg+MbL9ayIZ/P1a0YZ4NyNwfVMygybj+qRRinfmmcOQNcIk1FmHvqeXH3Oyt0BDobNqdkLHEqYR5gDNYgbKaJiyp+VcQ72mhD28fn1k4XEr4qDTMrhhye7o1KlKkxXCxjkAXwDMprs4A3aC8CtSCDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792171877; c=relaxed/simple;
	bh=wrvIrrRxxCxbjC5y19PcJbeqSjug7uXwZUzwZWAtOzg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NJLHEcnI87phuf22oicHe1jm5uRrcirFHN4g6sY47CEoEUwEjNzT+il60S/NFTotspYNm6orZ1Yy2/3jsOYR60+vHx1nANW5/ZTXQSfCqLIZxRL/+IhCuj8iXeZxqM7Ym/RRzdYadwSlE3ytOdRGH7SsnwNYtw4H6L4ntKZoM0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I9FOVSIY; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I9FOVSIY"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-351788121cfso356633eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 10:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792171875; x=1792776675; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=viOIzDo9krKszOCmVOjeW9f2aQpRArqmnQIoNv00KM8=;
        b=I9FOVSIYQUT00SaPdUhzRmq1rK4SEHUUF/leIAiajrrORfFAvVMJhIcDqgRbvGRJ4o
         lfEUOrdCMQnB2xtEJJ5UGStiT0SfTirfpjWM2a02p+hq0Dz8kyFrzcVGh36m2pEX0LwG
         N5vnzbj5tz7B4pKRjmyYaETMKOcX1cYdTzYn4iLeIECNOXdLpWEG3LsvF+L06xJhctwQ
         NUiWzBq7x2br+Q7wWKx63XWMm52bdHz5QYOE3G7GfjEgK15zsz7iXrNRtDcMEBu5qsM3
         jVPGI/zssV8Jm8H7gkm4zVBL0fdXoe3uCaH13hUD4eokK8mVj0lYCvRjx1dvOSzeXJb5
         w8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792171875; x=1792776675;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=viOIzDo9krKszOCmVOjeW9f2aQpRArqmnQIoNv00KM8=;
        b=iLUoUnfOFAkFitmVc/k0MwBg2ZkWnXUPPZMJZ/45kvUrP8kJU1YG67Hs8pANWiHKJu
         /PatGRf6HyoL2d5Kw1d3VzTe7dJC1sWvV4Fmm0vgiolcgpOhbqLealDnyJ9hwJu0N9gj
         3dr4Wl7b24HhFrVdMGSzu6dc3yqCgX5NB/oltXl6PYUnDrn+xMlsWbkD7cJeeNHnk1tS
         xwPyN0eXLppepZKsOs6T6V7YlLg76OU8fLabUWb0a2sFwTkQDgps/fqYxBmU0Pq4qYrC
         TyNpAuhSf8vDodAM2b9fUpAeRz1FerGtH/T9eXfSIeI5HDS/dw2gDzlqZUK/ePIdCNjw
         yR5g==
X-Forwarded-Encrypted: i=1; AKwUvBwt8bsWk39Z2pN8eNQKLGrM4wS6F/AZMICK6cfvvnYO7BuaUaZBJhyJKtDC0Hnbj57SgoHuHzL8+BOgTPjzPYZL@vger.kernel.org
X-Gm-Message-State: AFq9FYKp7uuV/8uCeIdyRDCT7q/nrVHP6uc9duq3BPOQJZBGBpLSWfhc
	k7FQaQuDz1SDKGa09jUpWA1TBYnlxX25MSK7Fuz4PpbegqPhWtANedAOmHkLdwVyCjF+gkAA88Z
	6kliGvzO7iQ==
X-Received: from dlbtp9.prod.google.com ([2002:a05:7022:3b89:b0:16c:8019:50cb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2097:b0:14d:c9e:a356
 with SMTP id a92af1059eb24-18511ad8b0emr658014c88.12.1792171874071; Fri, 16
 Oct 2026 10:31:14 -0700 (PDT)
Date: Fri, 16 Oct 2026 10:30:50 -0700
In-Reply-To: <20261016173106.679725-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013222622.1822619-1-irogers@google.com> <20261016173106.679725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016173106.679725-2-irogers@google.com>
Subject: [PATCH v3 01/17] compiler-context-analysis: Avoid unused parameter
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

