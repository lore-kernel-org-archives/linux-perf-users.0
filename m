Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418942;
	b=Do7D3OzWBuLIVQAsK0XR5ryHFZMhih8rrOiMxx3iUwNyt4AQrrBh8IEf2nwgBaoUt0x3
	 03z+KSNTOipthz5YQOTdHuNLjEXainhx9PsyxESXMMWHNGHdnz+WJvJng0gFdRUu1pnCN
	 Z9FQJftw6S86XbZOtS1s+650tLxGnv3xoOENOEqz6T+euP9a8d+MedX3ACGkEzoEUd0NN
	 tEK4ZinkB5SL7fPkiWr18YLjBWm5fKM3XdQmIrr0RvO8v8aDShAZ03exA/ikZJhQRsYhr
	 jLkNYkOysETtfYovFOSYA+jYKLsP+0zg7Qvyi80R/6MFs+uvO/fVSbA8dHgQ+tlIUTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418942;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=zDRXRDkvAvadJBp5vb4+ZdZF5QkdvjyK1sAy//1KamI=;
	b=KJWkc76/A+J6Go9AKZS+mdw0ahtVJGTlgnfetiQTwATTiYxpEcXkMpSK+9sWBAawWZFb
	 iPZlUnG5jOS2tD/IB7YwKAc+/jWEiC146p6X3c5+oh0I/junVFJUqxZhS/UwNNT5GHi6k
	 PhiPnFna4rnmfbrbUhppgIs/p98ovTmcVLhX1dYAXKJIFzag+H0ZF4Jbt5tMO6JXHilS8
	 X9E9NHiIDMQdapJZ5dh+EXVgkD44x+75lCswILNtV1ldlm10nTGqLBdF6IHInmdmenquk
	 ffVOhLrMCmi+Q2HNfP4ETwR8/UDhrPphc/yL0UefYKQef2xOLRSYvjDCS+RIymiQU7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Bu86TRv7;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C0A606A331
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 17:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68C0A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Bu86TRv7
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-375bac6bd21so52234eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 09:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794418940; x=1795023740; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zDRXRDkvAvadJBp5vb4+ZdZF5QkdvjyK1sAy//1KamI=;
        b=Bu86TRv7lWNL5ZRXbxQ1f3us+2YFob40eTV15x+VhwyhYhYoDC/8w761Xf8Z9/Eo1X
         d08ERGvVBUEvAeZZXTg+7yK3h2DGcePqSQs6xPtzDtrTvweUaEARPYhMyxGE4AzNXhKt
         3FlpO9HhQrUK2EE4+FcXgoSo5joiwMxEEgjR/9EvdQRSFYZBZDS1v1nAup63GKmPKQfk
         vUV5yC+cwocGYXgjHYGIeylmRcdpOl8k5DkTQeDp7DPGu24L0/mrlKX987AIQYfjDuBn
         i9QdMPAEMEXW2VVDJwIQ8puewsWfqAjOXEfeJZGOGje+qVpTnLSE1JectrYlRD6+HANe
         /3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794418940; x=1795023740;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zDRXRDkvAvadJBp5vb4+ZdZF5QkdvjyK1sAy//1KamI=;
        b=YwLeXJcKe/ShIJ095P4ge2QZ0O6hrPyjdfp6e8lABkDgdsrklXoLFzT7ONPyQYH4XM
         nPb5P5lClA2trFztJ01YrY+oEtzuM8QxHe+SZcaR5GLelLKXThts9IMO23rfnRGzUQ7i
         K/uo+mat7ZapJZBzCBVoBhJSOQhgFU/nE88YYbtcl3d0qLBExYs8Koieajp+CngzILxC
         AqJqu9jrgYgKUePno7BCJzRujVyWINrKxrWgIPAmeKLMkYnUwB43bHc+88u1OBfSkOen
         pbGaPxbAtXdJCjRzy/1B+2YK05bTZuRx2FIyzQLLdRms2DWFxD/zXp4exknRdVpxZMrX
         Q8LA==
X-Forwarded-Encrypted: i=1; AL+hErFXgDk84UOLI1hUjnaNWg+Cvg4ho2LsAsGU3Uetyr4q+kkJ8F5kaRm0Gsy8EX0D3LSHL6d/zZuo9rkcl30q8kt5@vger.kernel.org
X-Gm-Message-State: APuU4Z/Y9u/WY9KxULVLNvEJF3etMvvMG7n/Z4+LfKLL4gLe5NFg0qby
	Q+Z+m+2N4QgxzyL2s0BiqBh9QK26fotxnpR2yzXeo9lRtx6l+NNkTu5PZxjpq+Z6ofFDZFVZSxw
	REWmU9untCQ==
X-Received: from dyboe15.prod.google.com ([2002:a05:7301:3d0f:b0:36a:184b:374c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7fa6:b0:36d:38e0:79f3
 with SMTP id 5a478bee46e88-377e1af812emr141935eec.25.1794418940056; Wed, 11
 Nov 2026 09:42:20 -0800 (PST)
Date: Wed, 11 Nov 2026 09:41:53 -0800
In-Reply-To: <20261111174213.3526604-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261111174213.3526604-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111174213.3526604-2-irogers@google.com>
Subject: [PATCH v12 01/20] compiler-context-analysis: Avoid unused parameter
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
2.56.0.542.g3ef89b7020-goog

