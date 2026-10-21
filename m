Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622355;
	b=q+CMGhnVU7QR2B0ewr/wqosKTsr+CSuYqyndcEy/O48L7t0QQYpsXQjh+K9n8S5Dqwfx
	 MVcX5y5gjHJHzzbjqKBfLZziVweL4p+FMKeCpOTkLtVHAHK6M8TJFVxXGOXDsvZ2PbrWx
	 NrLbOrXjtdpA2mKVV/MR9xiTfsi3P9DTFuVWURopy91SvTMnLuRRuJ5//B7FLZzAiAVAb
	 QAV9H8lqxJCX3RBfjxd2V4Gs8Q6LZvQiBSGxPu8ruu2v+Kom7Sq4ct/aRSTMzasvgvA2b
	 aYfsFKv6xkyML0lvyyskctgpaMP3UE0OXJAGvjwMOWxVG4GRaRjhWi3fV/kxzuZHeaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=EfwNfupZ0TIPuuv+IGtyp0tzfxdoSxsiIGDg+mfEKAU=;
	b=vET/yfoc58l2/u9lHRcgmO1zbg+oLxFLKhmFlSkRtUz0PQMU7r4IeGQ3W0t3si6by3Nl
	 jzE6ETm9LoeXG0Uf4xp2Ll9DzWVc1vpD3SchalhUw9a06YM77dPMZSafnfaUkhuk5V8OA
	 yJ8sRbK6rqFwmD2Ly4epVQOoi05XAMm64cnLw4GwfNUoNVBZu6qn6uApappDjjJfmCOEz
	 aDwcSBWmKRDi6oVS5+YFmpa7ps7lYpJXLH8BM6ocaTlZD9JXFSsZb1gy3GK/qK43G2XAH
	 zu132AJXPk5IAmD4LvASMkRUnpsm36As6KaS69eu5r7xYRGmu79eLKzeeM4JrRiqxrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=j61J4hAe;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2521606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2521606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=j61J4hAe
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-35c5aef2a74so1986273eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 15:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792622354; x=1793227154; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EfwNfupZ0TIPuuv+IGtyp0tzfxdoSxsiIGDg+mfEKAU=;
        b=j61J4hAettOCJAV2Yf12i7cgtPCGYtlzFiqpXht5gWErhlUAEAzDBETkRZggx6k8FD
         3pKFKSyhmPY7afOsnoTl961fj6+xMqNJTOoiV3Bfkp2w4XxS583Mv2e5ktX65e3fBgw9
         4SUsMxknLozAOfP/HnHD3PD54Z+QQhX2at5AshLIqb5Z6rzLn1FIMSkXxP/HjNY3qtE3
         QiJyKYj+adEg5GtNicESm//2EBXPirqDJZgTspxsGnent0HcKAHhZfvpY+dZ3lN11AhN
         JWqt4iY4FCgGNv0KVI3wwG0hmLqSuh98E/e77OmqyvjzPAMRC0vj+i8fCtYEujOYRT1u
         FUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792622354; x=1793227154;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EfwNfupZ0TIPuuv+IGtyp0tzfxdoSxsiIGDg+mfEKAU=;
        b=ppDQAksD6WGar1yoxyYEDIVkK7t23i1RVVmq+nMJtuM2eAPcEAPLx+ovccK0tesYuH
         /+6cpBhHPe8OkKpTCgiJOAPc9jtFw69e4fwKjVd75jcdyMsgD9ZlQsKGbdWxm0THox/y
         7alEvSLkm65gUXI+wK+tvH+hhgcmE0yfRSIOGsa8rfuVDNtUqDpJ58Lolzjb6eaSYPNn
         0LU6C1wpsvcsum+0S91At4iLKeeifZorDqE+Fp2BijJsH20aJ/KrtCo/eoEEs8l4hmlH
         0HSrWhXM048en37TeuCYVb1vqO7uaRh6b18o17dANhy626ufgjKyItE7gSocxp5PuTDb
         jvZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzXhJbODowLbUSUC7scFdbbtT2nCki1DQxBnePpmpSbRg02q1qU6o5flasOfgnM27kL1uQnWelEn0zLIXVmL4d3@vger.kernel.org
X-Gm-Message-State: AFq9FYKDw/SAyCXtLeuUBOO4tmAIc2r6TYa28al1AsXfwn5m5iSwyN6/
	7FbBB5b9aA3t9x8jNxT23yq9gwG3j7SflN5NRPCwmLCUvHtKqVEjwvUpbNd/rWEOiBixJirlD6F
	6YRZUkYwJgg==
X-Received: from dlbur22-n2.prod.google.com ([2002:a05:7022:ea56:20b0:191:1417:6caa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:d0d:b0:168:3243:c911
 with SMTP id a92af1059eb24-190a6dbcf54mr4906912c88.37.1792622353590; Wed, 21
 Oct 2026 15:39:13 -0700 (PDT)
Date: Wed, 21 Oct 2026 15:38:49 -0700
In-Reply-To: <20261021223905.715051-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021171044.155240-1-irogers@google.com> <20261021223905.715051-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261021223905.715051-2-irogers@google.com>
Subject: [PATCH v7 01/17] compiler-context-analysis: Avoid unused parameter
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
2.56.0.218.g1ec904b173-goog

