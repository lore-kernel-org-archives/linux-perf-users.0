Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244316;
	b=vnC6tFXNcIzcWvFyrznxna1BEWAA3Y0y+mxRV6HCbJ+dFCNFsWKJN6l4rtK3Z+93XswK
	 oaOtLvvRKtlE/OgUBZ7FF/ChdFi0vQRwreokOsrp9ySzlLqTfSyDhP76ia2FaTjuQznsi
	 80xk2StBX5xza99PXcRwgztVtW3VFYeSfjYgit9lHxq/UolvCxc/wrkgu6PysdeXlSjsu
	 BKB4clYtvY62aAjxWJh7Uz/pInvCK/BvCb++ro9FlcARcytfqLoeiIgJ0ei/355w7Wr7q
	 dGlTo71k7D8d4AQIvx+ghNhsnyVVE/GgYgzW4uQaq6xgCbmCzzTsLuqBa9wYpDdFuVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=WFQYbBMhFIDNWh8RpPfdlWzTylnEhajA5E05wFXNi1k=;
	b=Hwco8VrcWPQyYAI9BZAlR2HU3Rat3RLwNK2ajAzGgzfBz3Ihb4pAHtNLjmUDUJfxKPJ/
	 WrxmH4b2P50EPG1DUkIMGfpVuuMbMqs/LRTIeXYHLtuf8vGWCvI1iqe0Ne7oNI5rI/Kaf
	 X+cksL5RQY6IXGoIPUh/9bCaVZmm5AsYwf6kb+AerelF0ijSZCDG+IenlYB5DnOy2EAgp
	 JSDmgIDaXMBLMX8p0+9dkxVT8DnUeWfjF0lGmtrai4Jcv5c9DeBPcPT5LJYP8PKzIL8/Y
	 WQ41b6mUS0wKzDhnjD9fGJ4VSY5sBHr0cFGKpFxqaEpZ8ZMGBdmmhl1AqBSp9SXpO+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JFYp3AiY;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F879606A32A
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 06:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F879606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JFYp3AiY
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-547ae874949so2783636b6e.2
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795244315; x=1795849115; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WFQYbBMhFIDNWh8RpPfdlWzTylnEhajA5E05wFXNi1k=;
        b=JFYp3AiYr2KxTluRFn6uMY7+yBx6+T7HVipHkYOk9Cez6+9NOVHCYf/1XHQvoqqhYi
         kuTEGw27MbAqIiq9lj62ufeFNKUuGJe9LTgTPBqISdFmvpdyCYf1ZAkZ3wSvKYDUGwfz
         T+faDkqA8yLt73wfcrpmH/5y3MaQEyarDdetrktLzodFY9LHSMFzHw5R/yS9BmRmMg7S
         uXkMMv9p17DA1Js2E/yz9a/fq7GysX9eBK/9QV9SPjOwWi/umVw02v5pq9Dcv9kkPXbt
         I9+q2Fo1vzetwxkYzcNdAx9xWCerlftk2PrWgUOXvpHSo9CFZb+KFYCOfwN5aS3vKaCG
         9pJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795244315; x=1795849115;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WFQYbBMhFIDNWh8RpPfdlWzTylnEhajA5E05wFXNi1k=;
        b=pAS7vWCsHp8sBrUiLqlF3UhQwgsEDIthIWsUmJi2rD3+kZX/QqJ0uSmPT1Mqi7AK/E
         CQ52mUEFk32aQURN3FUlx/liaumWr5jKWcHnjib6lGVEZfgjM/MDTpjNjxNLOOGwWzlp
         4tTRraYVKng1n1yV7SI34ukpf+8ijMgMDALqr5VxmYV+XrOIEm5VjZ9EORpuhwW+qBFS
         u2x+hoa7pzsSVmWFLet6A6Qej48IB/PfOa/nkJzHZ+4RqSThGeDegRz29FA95buubWkC
         FwwG5W4qpNiIBauMBqkcE4fCfwvymjDdcYIIMQnX4Q9E8LcAZY/di8Rel4VZWFadU5G9
         +0Og==
X-Forwarded-Encrypted: i=1; AL+hErHSEnCn4FDWD+p0ox5hI8ggbZr80zFwQoqrwdbmIhKKl6v6xnpVLBO58hOL62LupgMe0SMwIhBvRI+UIh5HxoRx@vger.kernel.org
X-Gm-Message-State: APuU4Z+jZCbWQctLQ3CeCFcv0aSL6V2q7HrlxPvAGlkGRC0SGTXpRKUN
	3Msqqza3EkDsS4ezU3RaWt9pYTm4vrNwzKcyMVdm3RcBbsOkDXgyU3jT/NsaiDKx/v1AzexLgsW
	mYJau+b2EzA==
X-Received: from oibmo2-n1.prod.google.com ([2002:a05:6809:702:10b0:579:7e19:d2e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:1314:b0:572:75e6:1cf3
 with SMTP id 5614622812f47-57a0b3464fcmr6263252b6e.35.1795244314813; Fri, 20
 Nov 2026 22:58:34 -0800 (PST)
Date: Fri, 20 Nov 2026 22:57:50 -0800
In-Reply-To: <20261121065813.4143649-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261121065813.4143649-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121065813.4143649-2-irogers@google.com>
Subject: [PATCH v15 01/23] compiler-context-analysis: Avoid unused parameter
 warning in _context_unsafe_alias()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
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
2.56.1.750.gf70dc682cf-goog

