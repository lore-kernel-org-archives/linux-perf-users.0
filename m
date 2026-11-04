Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825957;
	b=Us7prBKvd7gbzOf03ejX4xYvJm7llH71znjU7rviZodBQQc3aT80cWDIfUDqhpyBHtyG
	 oOUt3Nc51cxhnLWIVfAz0ymMhykEl1BpZZM5vvMw3a6exUKrU/jjbAjHr/kskhQqSfTB/
	 hiObI6MOySe48uRR5Q3Iz0L8hXHuADSZnNa4VPbHmDZ6xDFWUnlE6/VMEh9F5MnL9TovG
	 BRpAqAVDzbbavrDSCxYoZRCanGkb5m+Y5S1WlP7/dIEZcT1DNicR4uGvARGVMEB0QzpVB
	 yNFiuGpeCuFbUENaKsjskKayDNR9SM7LOXeiv6bOMHKU4sxxgaD1nO4ABFV8OQJ6OUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=pVkLc8xSyhslD11C4DSvZnRo7dsv6FWhh8v0TPGw3qA=;
	b=1OX00yrO1DOdvFhwcHtir4lAcd68ZRdBbp+7IzUf0tKUPZ/xH2Wgythwa1Ulv0uimmf4
	 zWUBnSdb0IAA1BzRwyGHa99EXOsXO7I+kUgTEE18+N18+fVknfX4bPx/dAxZlPvJqLS7V
	 +7rbZIk6wXEyuh4+/fGHwA4nIp0VGxl7asOkX2rqCc+R6QV5w0SfL1+FLlrjbMyGJrjDR
	 DkLg8LKyaxoGjv6V7w/v1pIKIsmVvIhfISk9jedbRW7yRXKkbbuywAoqeqzElAo02IpO2
	 gYULCTzex9YAHuR3zdg/YJt+IxBicxBlm5xAbKjT07vVdQxQLlVXn3UK7qlTbuQD5aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l6zFms6C;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942BD606D161
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 20:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 942BD606D161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l6zFms6C
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1acbaf81bebso1547897c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 12:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793825957; x=1794430757; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pVkLc8xSyhslD11C4DSvZnRo7dsv6FWhh8v0TPGw3qA=;
        b=l6zFms6Ci0gFXFw30uQIWUkIkwYmvRxAMdghJhLpZ+go3ISZ7Jniiuzq66BwbUb56I
         8mb09obnK8YnNHaTkVm31Ea2v0UaaWNRllclxcfvlHrbTKPfpt2mWvOmNcQ2IyIK/0C1
         DfIhWhoWkiz1+kqpWV16xBvy84wx0BvptX+abXOT++5la9IwOK98ALjhdsIkleO8SRrZ
         UYTS5A7keueVD43yv1v4Sqo5zLBwYn6V+QQi8m0nH7D7s1TRarej/Z1/EIBqqvUN7kw8
         x4hVb+3XeIJvkIqd5V38nbi4MullO2BRucBgQ7ojyWt3+6qdewgcbox4mWSTpg4LYNx+
         Gf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825957; x=1794430757;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pVkLc8xSyhslD11C4DSvZnRo7dsv6FWhh8v0TPGw3qA=;
        b=IM9Fz7Jd/AntJEjMijh46cDD7gwuM0wiog+6VtOhR239G4kkHsPp1CLmhn0gOQkypF
         f8p6nPHT1lAIzoG6saqCmcYZDvmJ0L4AtQ9+7xps2P7lKUbFjmnQWtwlFhhNu7CJ5law
         UGIHvoLi69kq9S9gkklzBQiLQmSa8/ZSjX8n1/ewZwB5ZYa/7Vy/NMDjNabm44hRNV6R
         3g30fWYJqLwVtR4ysel+TCLRryb1ycWq9dTIszEa9KioMRZtgGofmponkQHGnBfWYZbE
         MxuOuzOXUgI1TiCEF6+mbYIp7CRefpon+i5R5dlO+s8IBfpJXDm9dhv0aMYYZ1cBRrlb
         WeaA==
X-Forwarded-Encrypted: i=1; AKwUvBxTcZnuN0c/HQC3HQjc2ofByyATsBGp+5rK+CiqcbT+zmlCmxHwLYVNNRih65xV72y8FUVxu/LUw82O4SoD4Bcz@vger.kernel.org
X-Gm-Message-State: APuU4Z9hdtgrJgCAEc8bpna3fIEiFsSnMIvx8HgavDu7SD7qQ9NO6IjT
	652Sh3oTpmjAaqj4nKfSfATotR/FDb1jmF8gPxxpzbx+3eXC4RHOEzfXB82bc27IdkW6m/g8s46
	ypahv5PpiVA==
X-Received: from dlbsj3.prod.google.com ([2002:a05:7022:f903:b0:1b0:4179:ee7b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:5f15:b0:16a:f5cd:365
 with SMTP id a92af1059eb24-1b009604eb1mr18474520c88.5.1793825956090; Wed, 04
 Nov 2026 12:59:16 -0800 (PST)
Date: Wed,  4 Nov 2026 12:58:51 -0800
In-Reply-To: <20261104205909.2078411-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104205909.2078411-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261104205909.2078411-2-irogers@google.com>
Subject: [PATCH v9 01/19] compiler-context-analysis: Avoid unused parameter
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

