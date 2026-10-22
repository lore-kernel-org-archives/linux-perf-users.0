Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700111;
	b=axBR6MCj3w3a2vSdUDLhsWvU1l7JGCAUVz54xJwy8EF0+kjYfTDv1sxzRnUEgO7uTdAH
	 wuq0ztdQyeHYtykMdft5YzIWbwxpK1nLWmNJREQdW1REoSOlrtrATrLW0YDNu/hhYwRs1
	 lPOQOgaPhIt0ZdHa0egaglKBLqJu0glawoAdxs5KuoS57hTueJC51/LNGl3y3l7/bJFVh
	 8RQDUGRsYkfzTMra4de0I2oeubrex8614/5JfSeB023Ri9kiNh8DQ3XBYM0/FkOwd9xYd
	 jGmRti7zuwzUdKDLympB4u1pZ+RcgPD/wC+3CAWwrEKJANUMyhr+L2GtI7q+RTmEuEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=5OI66hZlzn/cFny6HHofnoLn7Sz3L3IImkQeNPuJ/dA=;
	b=IlKL3d8+5L6erjNktwJpjhbd+H3bRBK8oowppBe8KDF54jwbKgv8bKjKWlsSEGHuOvHJ
	 bHYkJkwDZB2lmv2jqbzMC4H4jpOPQ4JF3A5Rt99NW1X5i6O+EpKfeUbIWEg3xOpoSQ3WE
	 aIQ3+Zr2p8xyNz8UIDg4U9NZztYiq4PuEIyO7RxQe4TZulKXhmDEWh1+db85azoEi4aLO
	 OI02h/CZbFbqsauQnjtWwFPCjnASTwrAHEv3PjBKEK4H8WXSaats0fFTpr44UIFPDF4LW
	 nXdjfdGMc5vmBs9eqHpJNxTzrvfx0MI0FWYw6looDnEhMTEJYj+waqPuvj1P0WjIQMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=YBWievkW;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577EF606A330
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 577EF606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=YBWievkW
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1383723dfddso245169c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 13:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792700110; x=1793304910; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5OI66hZlzn/cFny6HHofnoLn7Sz3L3IImkQeNPuJ/dA=;
        b=YBWievkWXjuDMsqw5zROegZhlbbSSmHp0Df05KN8Okcz6JGGuyytihMU5g1f2QFjWX
         7MBSvMO6bkf57fXn/45IJfRGPh9MxK6ryF1N49nbs56LojzY6dU9tuB26RQJVk1NiyFq
         qcaeMGifKQXPaLKr4fdgish6w0TVNnmWezRmh9uyKmKFJa6y/PsSl19MWrW1kTt6Rq1T
         B+te/UArUNIz4DBfCe9EhaFVBDxyAcnzuFfhYpZotTyXK3nUX5s6KNqW5zoZCOiobjio
         GG8TexqZIQQ+LipNEW+INc6EiNW73K0rGYa10ALttinmI2+b8LfPGIPM6f8t5AA46bSy
         8I3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792700110; x=1793304910;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5OI66hZlzn/cFny6HHofnoLn7Sz3L3IImkQeNPuJ/dA=;
        b=i+7TOPygnSxrlrdKRFgA2Ata/CidKwhxgwVJHqiR5gz/5459CH3S7mAnjnD3w/o28G
         a/N0C87BnbKeLCotYnisD6sI21Ihz81dzLgsvdHEZdtnnUUiDkUGcIZeaPhnhwwr0J02
         dxrBgKrB5XI4WfFJvmW+OK7kzRjzLVBr3mgnsEcZ+3YlFYfieY0WGmPIucdlfweoq59g
         9SspI0fqG8JWtW82+nfgPo4MJwBu6Z6kvJ8aHXPgzKamyl5BGAIh2BIWtbq4IOMlyiWS
         I19PKe53hsEuqW0OWJ9EeyfEy6L5w68K/X1fAtccMpECgWngXaCqjS+fH3RRAzUGaMtD
         eeJQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3L3IUGYjk/rzzfaSY+htGXa8kfKIPrY89HsSsNWfv1mvFK6K2cojJ+JbQB0wkMYZoZ4qsMFB8JomukSdQ2pLw@vger.kernel.org
X-Gm-Message-State: AFq9FYKJ3mgJngCZJhwm8QjwnnLZX2QoGJAoADIMc4DTuHrCh+MibnAI
	FATU/M9WXkDxbj9cuAJD0XWXoIK5Z2P59qHJi8gY6Pm++CPp8aX5CKej/xNdALRRGevH2uDwL6N
	6qPuJ8jWymA==
X-Received: from dly18-n1.prod.google.com ([2002:a05:701b:2052:10b0:195:13ae:9fe4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:404:b0:147:8a40:cdf3
 with SMTP id a92af1059eb24-195c5ad11d9mr576470c88.24.1792700109901; Thu, 22
 Oct 2026 13:15:09 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:14:34 -0700
In-Reply-To: <20261022201453.1717523-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021223905.715051-1-irogers@google.com> <20261022201453.1717523-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261022201453.1717523-2-irogers@google.com>
Subject: [PATCH v8 01/19] compiler-context-analysis: Avoid unused parameter
 warning in _context_unsafe_alias()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, elver@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, justinstitt@google.com, linux-kernel@vger.kernel.org, 
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
2.56.0.307.g5fe7bd680c-goog

