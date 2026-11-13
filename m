Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588122;
	b=ddNGslGU+YI4EsMoSBgU0X1uLTuh6IY4fSeKwH2X1KQKnq9nxXQI4vPKIaq1X0GjKgQG
	 hlKOCp4I16KC1RXGmTxuamPq4deAr8Zktp5x3E0qZzidaER2MWZVvKXwJcyR9zyd6mS5H
	 Hpa2zeoULAPGLTEmsjo1qrojJN0dYcJKZwyYQ5vOTuiHj3AfyVb/r70Abph4yORjTRtbu
	 l8ogGyyytN6Tp5LqAJj0ap7ZoxroUDof+AaBcf82NyRdL4sMMBQZ+BWBovPngYGiphI6N
	 FH3cV3qyaoNryERSUrrS0Nai9+V2FqRXAlvX3EaD5+YctU1R4RkHxNG1Rd8/JWO4Q1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=wNOZ8QyL0UheBANe+7QNGXLjq8SQVqhuN9MkvsYBKOU=;
	b=dM9l7kcZvrT29O8DGnXoKN6Ucs3fyy52sKV0L4BuVeSDb4ihZd6Bholyrfh17p01iOLq
	 pE7wd9/VO0aLHjdRYRAEDqJFPVpGWHhHjSrL84YRlHpu/HsGMqdcdBVyNFPTiupcho/le
	 M9TT8j1u+WtH0DTDXQui3DMnzslhO31XlOquGxJt14tMNXiHNaACr1e8O/b/pH3vpHllg
	 sCtb+f4K1RxtKaxpJiP42+/HhEk0tGXvVudiku5G2pFV0HLIg6b3eD+KFnk95IB1HZPKr
	 4DO3knNfjzmZocFtu89YU2He/P4Cw/OfFd8MEdd74HZlViQyUViObyTm+x8IS+3bvcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qJzeW58f;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0CE606A8BF
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 16:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E0CE606A8BF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qJzeW58f
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1b29df78132so401282c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 08:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794588121; x=1795192921; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wNOZ8QyL0UheBANe+7QNGXLjq8SQVqhuN9MkvsYBKOU=;
        b=qJzeW58frSJVc/bTLXJ1qVwDghwEIKW5P6kTNZCmkEMgWd9WdH4878RrtoAN22owpZ
         zQuKLqJofTK6ANlVd3cE0aznQ+ftaEXBhp+DsWIH+xdEDmgcGnS6NvJ5Hg/d7swNWSWe
         DjphfHHtwQWIka9/u9Pz03Pc5OkstVEuF20dNn1JKPgLzWfupWpQFgSfQ0Ln4utrOdht
         sLr93KOS+VpoBlBU2uNgztQInDmI/wXaxugzVPimdyA9vpFS3JYGLLKNoaRkf9a01W11
         vb5pLOoeQXjTC7g3K+zFrd1zLH+KmA81stNRwbIgWGmxIj1tfDTs8EIQqJlbySccO0eQ
         D1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794588121; x=1795192921;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wNOZ8QyL0UheBANe+7QNGXLjq8SQVqhuN9MkvsYBKOU=;
        b=FEGMWHaiW+hSGQ71T0oyprl+Fg4iVZNUTXvhVQPaRC3kHYIvVS2OQYmHx88BaLeDSI
         IWiCi/Jjn/uh9TxQ/xCfwW0SZr+rinYbuRMODl6GVlAfNCyOr5/imCyPvMd83LACGvd8
         xqG6UVudgL0ivDyuecl78YJ8LNX6HANY8xWSNX9Nf4cROH4jKwu5KWxi13/LnE/a7v8K
         yu8LKyFu/MSxcIagpssPRs//EwPdbIMDLc4CpjfU9cc2NBq2g7y8ZeJMvXbeXRUeYzsc
         /RXxn5huOzhPJh1/2pv+Qxld/Vkkf8CqCZx+g7onrFZaCmaEDxcoscq0ATlJZUKudFj2
         m+Bg==
X-Forwarded-Encrypted: i=1; AL+hErHVN+DRbI3C7aCAkWTUEDQbwmSU85/c6w/e+T6xVZnxG7Rk96LQBjARhDyB8tV7Ns36sd13wISWUx1XZIZzcz2j@vger.kernel.org
X-Gm-Message-State: APuU4Z8T2xPr05OnqKEw60HURu/90IpxxP0gkp7phIwvqpLZcLNJSct6
	ujAyxBlMjlubxGIEAFCgyZt3HOPTQRrgDupd/o3T+uOp0LNSKifBQMGQKs2AdkhOCCloKP6meWf
	smn1jMSpxhw==
X-Received: from dlep4.prod.google.com ([2002:a05:701b:4584:b0:197:f679:f62d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:41:b0:1b3:90f4:499b
 with SMTP id a92af1059eb24-1b502f8a8a9mr3200571c88.0.1794588120968; Fri, 13
 Nov 2026 08:42:00 -0800 (PST)
Date: Fri, 13 Nov 2026 08:41:32 -0800
In-Reply-To: <20261113164152.2095566-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113164152.2095566-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113164152.2095566-2-irogers@google.com>
Subject: [PATCH v13 01/21] compiler-context-analysis: Avoid unused parameter
 warning in _context_unsafe_alias()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
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
2.56.1.703.gf848ed807c-goog

