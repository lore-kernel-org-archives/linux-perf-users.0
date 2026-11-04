Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793766627;
	b=UdZhEkjUFrpuO8kglSEFOsZ6suHtWFWeN0TYYtzJmqz4L0t58dhCf5ZLBu0E9PuktjGo
	 +KShq3DErnXYQPdgH9xtXNjIJ3j6KXNch0SM+R9NkLObAmFyy4/r6NjfJZeEu6JjIp6g8
	 GnP5EiK56rngAlyhPoEj9IJOWM3ucc8YXZrkItA+lPiS6vaNHTFrWvaDhdmVdPUq51s//
	 x/CJGrGdiMd8EXz/XG7wD2Xw04B4crKxYc0RkY31s36WViiaolEw5oSf3ygD5NXzfzUWx
	 N1eYy0APeHna8KrdODNdd/qlrQ/WqSL/W1mfhoAApbhglyxr8U3Vz9dfbMnFEXpi0BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793766627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=h4jb5xa1q8l407p1Mod4RUtxmtTO0FmmjcGLjgwkwiY=;
	b=jgf32ac1ZI6X7SO2bTZMUCInLlfMsVrpxEnIXsM8wPZ21CE6j0CJi3uyu1v6LAwEfZUT
	 W6vqZNjoVln8gvmNZlz1BMpYeJCVb2Cu6UDohHO8UbLZMwD7Cz+G36x/3aa7B6lIqsiUe
	 Lfn/wbI632vWK/IFhQMnEHUimduHu+JQkcGkW/etESU717XUyjlAP2V+Xun+aZ7vkrRLD
	 hFiKFFPzAPDQ+lLn/GUoQbMggbkYFneJ6TNKWe/N5xW/7VoPZ2R/zq3z1FKQn3CelfrZf
	 dpmMVJajqdTwOFgAnr+rW+yJqUpojWEPr3v8CaG5q/Xrtb/+VPfxZ8XSL768CUMWPDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pHVZB5Sm;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D64A606A329
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 04:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D64A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pHVZB5Sm
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36a223755e4so1036762eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 20:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793766626; x=1794371426; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h4jb5xa1q8l407p1Mod4RUtxmtTO0FmmjcGLjgwkwiY=;
        b=pHVZB5Sm3KMzAWRcG28OSC0xG4KhDva279w0FY5Sm5aS4tVtOIetvUeR4aQO6qMm63
         3AYFfDUIXcYkK+98I5H9IBbYM5SNNUe20vZiG4WQ6m3K+/7cjZqmrjPQjv0Ezar9DJFs
         dlpc22KihrXhls+bw0HGNJZSfMY59L/Y8n1Uf118kXyuzzTALHSC05/2FIfa/CV0uUkU
         lrPFfBWAE3crGj6fZEsnwjIa4ak4hO2mhy6fb1CByxnYxV9ElCBdQ05G8XmQrzf+sbeN
         pFAj9t5R9qxPK6fHRbBUGE02laq41gIeqJhULiodhKLiFqKSYrbtWXept5noL1OO3BfG
         bmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793766626; x=1794371426;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h4jb5xa1q8l407p1Mod4RUtxmtTO0FmmjcGLjgwkwiY=;
        b=hpK5MfNxxuUTbYAVA3l/tig3BcWbNfr1S9HzS77FGg/NfMgzYbxeZ9Nbf+2/hfJwFT
         xCzZ2zfzm5op4rx6LL28O6nHft+pX5KHT8EGYG4LwoMYZg9EXTdRJaOQQrSxA4oWYcIX
         VH3bLiSLhqrpioxLRj7kFow5Cq1HwsK1uf+v6roTpful1sel6cyD8DeTiHxs7QkDDXvz
         rUWNYlLeX6lKtO6zyu/3JWWZsUqaVCcN0vfys05ZYLJCjn8rsGG37nz31h77Al+9gq0r
         4Z6Ljp2luaCefx3AyL/h/5mMUQBWrUMQFJJVaXmfGkocJDlIv2RuV7DlQW6XtrGq+xNx
         tNWQ==
X-Forwarded-Encrypted: i=1; AKwUvBxbTdlddGiSLSgQ04tp/qbFfiYokxiYWR4UX+yy68tTeZsTBcEI9oYDOkcJXjPvVl8VmdiZKv1U3nnRFgYFxITP@vger.kernel.org
X-Gm-Message-State: APuU4Z8GDGeF5w4LzC9llld2jxPb6gOY8/LE5kdhlqLwunE+c+GwWz7G
	j7AHH9I/dkM00KI9FSZYpKUjTLcOq/uSv/5rjhYSKfJUzesu/sGX7OpGU9SZWTAPVEJ4bvGfMo7
	SVbSwLF2GgQ==
X-Received: from dycc2.prod.google.com ([2002:a05:693c:60c2:b0:359:a8c8:38e2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:2a05:b0:36c:b138:651e
 with SMTP id 5a478bee46e88-36cb1386818mr2042119eec.22.1793766625795; Tue, 03
 Nov 2026 20:30:25 -0800 (PST)
Date: Tue,  3 Nov 2026 20:30:05 -0800
In-Reply-To: <20261104043006.1199857-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104043006.1199857-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261104043006.1199857-4-irogers@google.com>
Subject: [PATCH v3 3/4] bpftool: Add explicitly sequenced -lzstd to libbfd
 feature fallback
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Quentin Monnet <qmo@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, James Clark <james.clark@linaro.org>, 
	Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Distributions like Fedora ship a statically compiled binutils libbfd
that depends on zstd to decompress sections (e.g. undefined reference to
'ZSTD_decompress').

Add libbfd-liberty-z-zstd to FEATURE_TESTS and FEATURE_DISPLAY in
tools/bpf/bpftool/Makefile and append the '-lbfd -ldl -lopcodes -liberty
-lz -lzstd' branch to the libbfd fallback chain.

Acked-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/bpf/bpftool/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index b0f7168e7943..1cac4508eb0c 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -125,6 +125,7 @@ FEATURE_TESTS += libcap
 FEATURE_TESTS += libbfd
 FEATURE_TESTS += libbfd-liberty
 FEATURE_TESTS += libbfd-liberty-z
+FEATURE_TESTS += libbfd-liberty-z-zstd
 FEATURE_TESTS += disassembler-four-args
 FEATURE_TESTS += disassembler-init-styled
 FEATURE_TESTS += libelf-zstd
@@ -135,6 +136,7 @@ FEATURE_DISPLAY += libcap
 FEATURE_DISPLAY += libbfd
 FEATURE_DISPLAY += libbfd-liberty
 FEATURE_DISPLAY += libbfd-liberty-z
+FEATURE_DISPLAY += libbfd-liberty-z-zstd
 endif
 
 check_feat := 1
@@ -201,6 +203,8 @@ else
     LIBS += -lbfd -ldl -lopcodes -liberty
   else ifeq ($(feature-libbfd-liberty-z),1)
     LIBS += -lbfd -ldl -lopcodes -liberty -lz
+  else ifeq ($(feature-libbfd-liberty-z-zstd),1)
+    LIBS += -lbfd -ldl -lopcodes -liberty -lz -lzstd
   endif
 
   # If one of the above feature combinations is set, we support libbfd
-- 
2.56.0.385.gac671c819a-goog

