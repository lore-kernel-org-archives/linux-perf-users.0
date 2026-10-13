Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866E11DF98F
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791915993; cv=none; b=cBuiypX4bl54isuoMzq2DbAVTSZCyW9TkQedtQoqmd4nUpTqyH4soeCZ/sbcboGVRCUEgMl5mmnviUshOVHGnLwWyv/s/CJeVQBVOEyM4i9i2HBCDXONIqaihy+hU+IrgFid227jVN7jwsfR8yYK8XNsDptXDFB5pCqvYw0algY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791915993; c=relaxed/simple;
	bh=x2csqR8dDP2NCSK8ek5vU6PAamZazjSrMmyYhw8xZI4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kDTcH3ySLTmM30WQ074D2T0+WiqphIGUJgxaumDQPo7sbELifmq2flSCrS2bIcGiBSzp9t/QMUHtvh3dxuJkTrV51MJpSDDFeAi8mbs538TetLZHi21fvWD/MWwAkvh9uhDkazd5KR2rVzuhGUmIEoN9Td0+tv3yWQdFAvwVzEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f0MA0i2v; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f0MA0i2v"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3592749a017so166389eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 11:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791915990; x=1792520790; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BZIK7O2vtZmPG/MzaFS6aJid7lIfJvEiqBHfvqhoMys=;
        b=f0MA0i2vovznKZG18UqGB8Pux8Dfro4XD6Yy5fVIbs8wCD7n9xjSQX7+LWVH+gVryh
         deG9+tIP+tzmi4g46aeYUYkZ1G4bbNSj0vhU8OXjSzOxnmVi1dbbR07fZWqMknKmTB8N
         XZi/g8C2kKC19KC+NTY8GUetBM5RuDYzUv4mqQv6Nx/9C3meRe0acetb20OfbzSNv80/
         Zn6QvXDk15SucI+u5jXY+ckJEmmeb4T2ud6fcp0U3N7v/rurw6amrXjNsX5dHUfcuc/o
         Oxxnp+9ElhEqKtzcn7FP98tZnW1j6wM2xeehW8pYRa6mmgBqGNzJoDIY58/bsZg0KSD1
         xx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791915990; x=1792520790;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BZIK7O2vtZmPG/MzaFS6aJid7lIfJvEiqBHfvqhoMys=;
        b=lcAi5fIOtIAg2CKD7Xro55WXpoolsNm16xBQT4FKU/oyBb7rEeyU4oRm91KQtGHOCH
         wTFBvNEzOqcyKiqL8FjgE38RL8Ftj6OinjBeXyPTNTFunpcyZgeRDtPWjp06GWzCriht
         wS86pGqcYqoa/vfr7ET9QiDLdq8WW9jI9qr6OYn8k/+rKfXAejNPngAjBpg1W1A2epDf
         UT8oiN5NetJBHZIY8fFdjtgac+hf9M4qYo7q876AqjshOwhSGtVUfGFIbnYk5CqfLmP/
         OaUIIFg+6AwO/t4qJIiSSC3FaBwbIcAYKNQ2bTjo8vLJAAEeFrzOj26WGA75yW3Ws/Ps
         6Brg==
X-Forwarded-Encrypted: i=1; AKwUvBzS61KBVFlC+z7ZGtXDsiBOJhO3TV9CXwyMYzB7sBVfFxgbqN+wcJTgIlbpU2JObUVolgrz4lux1YvDbMHdTwmQ@vger.kernel.org
X-Gm-Message-State: AFq9FYJHZzh3GQmDb3cs3C3dex3wtnqkSazojTilVszX3AqtY5rQCs1T
	D/fTc/fqY71wO4aq1Apj1zaI+L+KniH5reL9Gjf7d3DpgT+tkUEPQz1zVeWqMoZ+gD9yJ68xafH
	q9+ezhgSiBA==
X-Received: from dybry2.prod.google.com ([2002:a05:7301:4d02:b0:351:4ac4:5ff5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:dd95:b0:353:58b7:b5fa
 with SMTP id 5a478bee46e88-3535f48136amr18225249eec.1.1791915989888; Tue, 13
 Oct 2026 11:26:29 -0700 (PDT)
Date: Tue, 13 Oct 2026 11:24:49 -0700
In-Reply-To: <20261013182458.1234616-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013182458.1234616-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013182458.1234616-2-irogers@google.com>
Subject: [PATCH v1 01/10] compiler-context-analysis: Avoid unused parameter
 warning in _context_unsafe_alias()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

_context_unsafe_alias() does not use its parameter 'p', which triggers
-Wunused-parameter when building code that enables -Wextra (such as
tools/perf, tools/lib/perf, tools/lib/subcmd, and tools/lib/symbol).
Explicitly cast 'p' to void to silence the warning, matching
__assume_ctx_lock() and __assume_shared_ctx_lock().

Assisted-by: Antigravity:gemini-3.1-pro
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
2.56.0.385.gd3acb90ef8-goog

