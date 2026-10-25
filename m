Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792965898;
	b=bYUOYkd/DndKiSNZfIM6SvnVMZ3tXXSog/IKXDeFnZHJmm2zwMgQHy8i83N9JXshGXYE
	 l5QsnYunFmjUjUIo26kZhWuEuRaod5zHIIXBbyLPJvf8BQWJ/xIvMUiSzHdIbT08XAjtD
	 uxrASjwmm9+q18kFX17T41M0PKL31+Y2mpCxHRcveB9+AU4JJAJk3iyJ5MU4HhdQA1TTX
	 UBlj9Kref8FHXqPNkX/1XhxU3lPwhuFsrN0XJoYsDPZ+9MpWgltw4o5pTeEAIorQx8D4p
	 m94Q695Vglii6NLnBRWZ/DFgmgS6ETN8BDKlhWGmR7ZI3HLTWQQRmA9C+SAJGzHHZ0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965898;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:
	 Content-Type;
	bh=aL/VaqLWH9lnIsP5naB5jHKeC9px7R9A0oK/nE/LFOM=;
	b=X2tB32hMT4r3f5Ef4io0Xgb0EUFc03jk/gtaRdCSr4KaBOx/0tn46WjjIpd+bq4g4kNI
	 7VgnFFdDvHWQ0EGc3w2KQmCOpe+kLvTE1xLkeQpl7XTNhI0tibjpbKtpVCqaU8oTCALQn
	 /XPqG8Nem4y5MUhiTFS4IuuWL14oo+ofB+WGY8AYr8GQVS+2iSAu0StwCbuozHEmFeCjb
	 /VudKJ7yrzvYYRJJBhF1psEqT+cUfSH5v7U/QbRgBtFLKnSZD9+shG65gsr3wH0wPEalc
	 Alyq/RV5wQEuTk0R0kxFqfTeMq0JyOzONPEXAdglk0GIPQk5FiE8qhi0DNyeGgp95pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=u6UwIPrC;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ADF606A339
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 22:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8ADF606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=u6UwIPrC
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33713e5e6daso4801662eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 15:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792965897; x=1793570697; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aL/VaqLWH9lnIsP5naB5jHKeC9px7R9A0oK/nE/LFOM=;
        b=u6UwIPrCTQKmmEBfMsxfOJL1fS1Cbr/zEvTWGruSs32PgfFfXLjdbOFNj6BLfmJW+D
         lbISytdeajDuLBMimSGk4v3f//jZGAJ4CXsHLrVn1HY8OtxwLjjacAjIvnQ/KZHBTE6H
         idpBVhHYKUSYbb7V3HljoM8IRepbubMq6MwFSJOfrzJDotvifYgy0bT8R89v6HVHWSGo
         YJhvmZu9zzAtFQ903Izot/Op/TY85fhaBcqnCH7uiFhL06Zsk/1upaWTsM5Hqazgtfhn
         ha3MB2Ptr0vWrqUt8jtVuqdCjWUIkJDGOEVXj9vNwLjP8+e75ih9jTa9mHDfJfakLf66
         P20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792965897; x=1793570697;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aL/VaqLWH9lnIsP5naB5jHKeC9px7R9A0oK/nE/LFOM=;
        b=Pk9mL6TiDTqyEwSE+OQy/bmFuO4/BhZ+RdruzEBxWEuliNmXfhDjDerxlysjdlu1Rq
         UVak6oKMB2LUacza+uSgKY8x0fdXTfbNHri0bNqeUIX/FRGbhz4JUoQ8LsHWLXoan0Ld
         am3MLO/w2zQKOgGbGjLP0s2IpznSXKcQ2XQwRkRaUKbU2VKYOu7mBLk0+noaRQ91md5L
         3WwiG1HHNyeeyTlclvIIgyoTEPYXc2efL3CLOz5N1JZpYUbBesBDnzW775lcXUdMUXWE
         WW1XB379q/S7GsWguCgc68OLN6gFor3vSLgvnd0xLntQus+Nfi7T+pJwgSjGXLt/157J
         oleQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/UW+GjB1h6hUq9FFqELeMXg51qHUJJ4U3yKUfHW6lr6+Q9S02jZcAseOK4pnumulJASzssWZQ9hj1TDtKm+p5@vger.kernel.org
X-Gm-Message-State: AFq9FYInwfs5MOW7iJc09I6bMWS3AcKEgkMrKnZPqJu0SycXkig2FTon
	LovQpMTtK5sqW3wd+VF4wjsEQ/PEcTzRPKYQztrLV6u/QRKW/lsB0FBSzeDOOZD09Wut/H1/cCL
	Yi7pr2q/6gA==
X-Received: from dloo4.prod.google.com ([2002:a05:7023:a44:b0:199:4f68:8e41])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:7f06:b0:166:3e26:c4b5
 with SMTP id a92af1059eb24-19935be7e56mr7748009c88.18.1792965896672; Sun, 25
 Oct 2026 15:04:56 -0700 (PDT)
Date: Sun, 25 Oct 2026 15:03:49 -0700
In-Reply-To: <20261025220349.1244499-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261025220349.1244499-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261025220349.1244499-7-irogers@google.com>
Subject: [PATCH v1 7/7] perf session: Check lbr_stack for NULL in callchain__lbr_callstack_printf()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

callchain__lbr_callstack_printf() can be called on an evsel with branch
callstack enabled even if a particular sample has no branch_stack payload
(sample->branch_stack == NULL). Check that lbr_stack is non-NULL before
dereferencing lbr_stack->nr.

Fixes: febea9ec382f ("perf inject/aslr: Add ASLR tool infrastructure and MMAP tracking")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/session.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index d9d06337933f..a58b4fe44b62 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1302,7 +1302,7 @@ static void callchain__lbr_callstack_printf(struct perf_sample *sample)
 			break;
 	}
 
-	if ((i != kernel_callchain_nr) && lbr_stack->nr) {
+	if ((i != kernel_callchain_nr) && lbr_stack && lbr_stack->nr) {
 		u64 total_nr;
 		/*
 		 * LBR callstack can only get user call chain,
-- 
2.56.0.307.g5fe7bd680c-goog

