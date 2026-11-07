Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794026479;
	b=us+ViR0UZx0HMjqNTVBUKNJtZJBlD89ocoMJRaQdvVJ70foEA/3O7a7Hy6L5SkfgtDHZ
	 lzabbchYmqx7qX2thFFPfTF7ooYrKZBH0m6ue4IBNQZX2xoVjoeKs3XNrhq+IO52VdMSM
	 /j+mHo4pf6y2WsPa6OXnujZNb5TAj0ocU8lMeywmSLJNvSyuexArGXAlssDokvqgkS0hu
	 8bV+63KcPbHOQ41pGYzFu6IXj3qrEnTcIUPLnIdGcR+tLNsrVWZ2g3xTTTn8zQfoH6yYX
	 oR0g8q9lv4gU0/SA/kYlic2n+T4hxAkRxJhaNOEViMzx9vM0oivKrojmYTW2pTz3NXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794026479;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=W68ZHdTr4uS4t3HLAWkunw91OyKFrULjE3FrBfJFUMM=;
	b=PwOJmzBg1cV/XYBZ6HVGVCMMcNGf9nr++nknDN9iUwibVcKwgfJhpL9nx/ZYBHT5x4Dj
	 mq2Ly5Qb5f8EbLrJMJSP4aTZpk1Jik9nbO7Aby1NRP+Z71MlmFlk7bZ2SjV8aWv++dy/o
	 QbBiDvY1B7zChtkTe9BY+kH07kn9f8BzLdzM0KVJddjF9FcjWNdf+q7ao40in+pJIKLeg
	 Pft/vpbAPDzcFcbQRwgmlY+vuMok/jjH95xq9e7H3eX23QiGWjc8C1y3CIMy39XoO9427
	 VQtZhYYkzrjcmaDlfFFXHOyJg0c4tKPWHjphNtVbj7BgoeDtXxuEDQ+daRiR3CuoDSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=J18GOLkx;
	arc=none smtp.remote-ip=209.85.210.72
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2907606A334
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 04:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2907606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=J18GOLkx
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-83edc5c5ae9so876242a34.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 20:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794026478; x=1794631278; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W68ZHdTr4uS4t3HLAWkunw91OyKFrULjE3FrBfJFUMM=;
        b=J18GOLkxlvm6dGUCxmB5aJeeDRuc4CaGp24n09+zcORqZKGvhLc/VsrFhZeV/305b3
         t3Dj1aK52Gwtr3Uu4OHJatzjlTkrYyZxf28HVPpaYWIw2/kd1uCJMQsOAyyrvr9YCi39
         mb/lOEA53MWVLvHAM2wPWORrdx2bSoK5tmXy1cFxTWTm53UxMaVOjl+SWKUDJWSzfoN1
         02sIz3cVZj7UatNdN1/vEr7U2WIYX7uLVTs8GGMiT+cXzU6Tbk8VjqhNjoFbv7akPLxm
         NMHs/jyqjLYcDanb4uwZBKbTh2EfpcW9XpyRBJ39v1JJzcwqiXhWQLJRATSThI0wT626
         96yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794026478; x=1794631278;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W68ZHdTr4uS4t3HLAWkunw91OyKFrULjE3FrBfJFUMM=;
        b=Mmoqe2WqqGInUoO8TcoUdnko8xAcm2qvTpjASEWIqGony83mtsE5XlhDs8fD2QQzcd
         ifpu5Ec4mCl7Fbha9zg6tlsXBMm1qUnp5gj894D/VcmFqMQV0pJKtLPb77vd0BKxx4oQ
         8M4TPYp7bQjzsSjKiuTppN5UbUEkHvfAS/t+GbedFjQA/77rRK1bPdPLNZReLB5/6t/4
         FdRNxznvRq2suFDUp/Kxtbg4VPPow0eEvSLy9rIc3p7rglGXiD94JnBd85NK09qdGQv1
         6aYaBLn4tQ8mrnHAF0DiQ9GsCfiGpifrgqNDgMYaLbWnnLm2edWycLiucbNlR+yiv1+g
         iIcg==
X-Forwarded-Encrypted: i=1; AKwUvBzupZNV94s2SZ8F2IOWOLOy1oVpgpmDwrnZ6R9QYKJRH7bWRaAQI5QwJadQmXUb/qS8DTm+uM1Z6KdxCB0nF7oX@vger.kernel.org
X-Gm-Message-State: APuU4Z/5YU63flEiadgX4P2v22BKy1IEJa9+GCClvJbOSlQSy0LtVKBd
	FU1mUQ86He2dHREekU+AMY6wCzjEdXmP5Zt3jU74OO6kdoXwpIabgrvns5ZPFjam7Afa2HQ0Y+5
	p0zXZ35JgyA==
X-Received: from oatp23-n1.prod.google.com ([2002:a05:687c:4597:10b0:4a2:ac48:4d59])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:b20:b0:4ad:8c55:4087
 with SMTP id 586e51a60fabf-4ad986619e5mr3163066fac.4.1794026477335; Fri, 06
 Nov 2026 20:41:17 -0800 (PST)
Date: Fri,  6 Nov 2026 20:40:46 -0800
In-Reply-To: <20261107044102.1506626-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261107044102.1506626-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261107044102.1506626-6-irogers@google.com>
Subject: [PATCH v11 05/20] perf build: Enable additional Clang thread-safety flags
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Align tools/perf's Clang thread-safety flags with the kernel's
scripts/Makefile.context-analysis by adding -Wthread-safety-pointer,
-Wthread-safety-beta, and (when supported by the compiler)
-fexperimental-late-parse-attributes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 3eb8d095cda0..b50702bac53c 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -64,7 +64,13 @@ ifeq ($(CC_NO_CLANG), 0)
   endif
 
   # Enabled Wthread-safety analysis for clang builds.
-  CFLAGS += -Wthread-safety -DWARN_CONTEXT_ANALYSIS
+  CFLAGS += -DWARN_CONTEXT_ANALYSIS -Wthread-safety
+  ifeq ($(shell $(CC) -Werror -Wthread-safety-pointer -Wthread-safety-beta -c -x c /dev/null -o /dev/null >/dev/null 2>&1 && echo 1), 1)
+    CFLAGS += -Wthread-safety-pointer -Wthread-safety-beta
+  endif
+  ifeq ($(shell $(CC) -Werror -fexperimental-late-parse-attributes -c -x c /dev/null -o /dev/null >/dev/null 2>&1 && echo 1), 1)
+    CFLAGS += -fexperimental-late-parse-attributes
+  endif
 endif
 
 include $(srctree)/tools/scripts/Makefile.arch
-- 
2.56.0.455.g6c5a503b38-goog

