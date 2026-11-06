Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793948634;
	b=JU7qyBob8Kn6rjgnL8fIN+HYOmNgwD4ocRFbojH1PBYR3+KYQCbwWS3t2f26RekmPqTH
	 Xjk9IM7sKUp7f6OSlXxOVbIVXRApD4rYihGKSIggyChbEF60ZLC0KKwcyePKM72v/Pxte
	 A/CYH8u6O//3ByFKTCZR36Lc40wf5NSUBD5K6hM3d5W3ZTaMOJTusMR+exrL2wSLJqaKN
	 vuRbH+wpQtTxeWjlZpDOcw2Tm7yUUCRWkIerp3MmRY41bbR1xNkeTpZpIO8t6w0rhLrLY
	 O8UBa+ZTKWf2InPHOspqDVC89LYd6KbFGR4xmmneEHpqkE0Vb/QitEoXFSh1DsBY5Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793948634;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=pVkLc8xSyhslD11C4DSvZnRo7dsv6FWhh8v0TPGw3qA=;
	b=IWZC5GLnAbRH8DkwkAWUqaVCTMOxA5kGA0+bfYXSSxbdCcpX/bNsiiV1cjVuSYTgZ/uK
	 Kgv2i8c35lRyLJBHOJw+gP8KS8f/TOo6O6FeEP7+Hpj1pSHRRdLMJKcLGuz9XOuHkNUKz
	 9jaN8rH5rAf3OKQOBJlFsTPzZ7sGQeFxsJd6auPnIe28dt+zg140UIiWpNB++/g3nI2sq
	 Lf05zUUABXRczM/pAioIPLs6m6yl5mrwdlA0xjKnXtQEYzcq/m2/Th+FLXsakhEwLToaG
	 x2ou0eqPeQ1gQi15byZxbeyDzaRsd38y8BQySDYI8krGYDjvgoOpv9XyqGvmlHCVFzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WoAyz1xu;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F63606A337
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79F63606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WoAyz1xu
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso732706eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 23:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793948634; x=1794553434; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pVkLc8xSyhslD11C4DSvZnRo7dsv6FWhh8v0TPGw3qA=;
        b=WoAyz1xuLgPIjgKGVX8xfj4G66jiVfjF2EjsQH87enOL497TqD6jRRCTQo3CYdGm8q
         1H5UXgYVLVZQ++I62DmIwYRP4PPMaffFwQN5RwZ+UH5GnggFHoEyBgTEketxs6V07EfY
         I8Yf4i8TqGVVjbcBVg/kc8cuqirZO1Cy9CxG8cnhYdWNw36LxKjwMEIfCqhBM3b7eUEf
         aHHAUiz6GsTwqYpjkjPXvkh33pcTBJCt4ESFWU6r1x1XUoZpjmbrGNe1k13UnIyV7hGz
         hU4HvQZJ7+ciTYkw/WydNx6rrdFDCif75WvxOWT1wvXWmePUsjfKdHWNE/XuYKXA14o0
         eR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793948634; x=1794553434;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pVkLc8xSyhslD11C4DSvZnRo7dsv6FWhh8v0TPGw3qA=;
        b=iFifQc0D8ICOLBC4cYE87ZSSmrdLKEQoWJElyY/WU+OUT4p1ELGak9krlD1xhjE9xf
         qUJWF1BfhxpY/p+XH/DpEp9w59wVIEHRdiAcEyh3iESloldbJeZBbjt143UEx7HaSSYR
         VF9ca2SH0+TQqYWfy1uiNSp7c+v9oaTCsQv2QAQMSpG1jsgNUFEjqC/+csAjfiYedOpf
         441WY6B8+yOKNclg2CrtMFRn2PIVkuq4PidPWDA9az4eMJYfoexzquDWo287dT6cHftn
         t/DnFxfivBwxRLkYnTJVG/B5kXQMHJAh2ElkMVi1+KwPzt9syoXMDHdq4NKOEMHyITHj
         9zQw==
X-Forwarded-Encrypted: i=1; AL+hErHgZNECMxCKGoa//FuTT9jFtbUCqxaPfV3Z40vWwLlGlq6zRJIIkkA/ochRylvrPlE51DdCIOSqFf1P2zRk+Kkl@vger.kernel.org
X-Gm-Message-State: APuU4Z9TJZ8gdi4/ceeBS8cpCxHV0/pTpYTZTM7bufDwEK6pplRuVoPT
	77ndPQQQkgXueY2BefIbi+cDzhoQtkAbAqV5KkxlB+Cr1Uo1/iP2yIR+XPy8/q4Nde/7zhE3yMT
	JxuCuZeWfIQ==
X-Received: from dyvp21.prod.google.com ([2002:a05:693c:8855:b0:369:f864:c5e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:40c8:b0:36d:2b02:86a6
 with SMTP id 5a478bee46e88-36f72cc1ae3mr2730314eec.4.1793948633131; Thu, 05
 Nov 2026 23:03:53 -0800 (PST)
Date: Thu,  5 Nov 2026 23:03:25 -0800
In-Reply-To: <20261106070344.329897-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106070344.329897-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106070344.329897-2-irogers@google.com>
Subject: [PATCH v10 01/20] compiler-context-analysis: Avoid unused parameter
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
2.56.0.455.g6c5a503b38-goog

