Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EAE3839A8
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619983; cv=none; b=nEX7rVjoHa5AJmsA11JmGXdjIxom7Vt87LcYnQ2kaIQhREtTibsl7oygM6Tfx0bmV/f1td/RYfPnSKVY30lFAtW+L60EejXWGRRyW/hklIY+XBWoP/v1xyATwAzQlC2mbpeDlJJhpsswAbhnglbtJYV7STfT46RjoytRnLMN8Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619983; c=relaxed/simple;
	bh=a5nWc3sT/mZZe9sKh97b0E5/VmkW2VfrKL6107mIakw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rvuwxd6U3iEzntkRAKwyGH2AS3FteLBVTyH59tSU0KMQNTT98/BOleQAsrIVyiIua+Elh7LZIih8Dhko0OlCmKK816EMAKCjuRhoJB++4bZwC1FH3PQkVGLtZYB3azHd4xpa/ySqxSHSLea65wyZWPpsJ2M9L2GUi/10J1uZaHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u8y9HsYG; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8y9HsYG"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-34316295d86so5294697eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 11:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790619981; x=1791224781; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ue3Wk/UGQHR+sKLjW8U0Y3mC2wPWB7OszqpJJYjXwZo=;
        b=u8y9HsYGSThi9qGo9TbiowwllR2MrkIu4nBKTXkQLPtZ2hncOIsJ6UYWk67Hl+BdG6
         XYEY8cqIOVGF1NFqSWFW6KuFJZRDLbXZV/6/rMYDYD9M1WpL/9nqH0UAVYkDRsflrgzX
         Y6P6GkbuF+9ypatRv+K/gaO7jfWOElE6jm5uQ8vs42a6JCMxdGbXeENfRyI9DIAsu+3m
         a1MWn79lX1WVceddw8xDCYhixpaE/55jvu4gccfqkUObIVwUuqd0BNYgVVoDY4BW39/L
         vWohP+4I3sTVkbACGRZ2zgcrP9sT8xc8ri2QCJkzc0U0BP4/nBgvZkRe0MepPHSKULVk
         u6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619981; x=1791224781;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ue3Wk/UGQHR+sKLjW8U0Y3mC2wPWB7OszqpJJYjXwZo=;
        b=08aZOhRdWl2/FtM71KtwnreKAoWOLRwxkTr+QIEDaBnBZv8t4XAF35+r8xpjdmwouc
         eRthQu7EKD6Jczyc+ZWnKCfIZcrg+pSspcfse213gW3nwpB5BH46SZ1OHgxnGWf88BuY
         KwqN7vlGXFBdD30snEBPxKxvmwudCAQ7ovnnEGieGV8Cixwm3WAIp3iYRFx7ADfHN2+z
         mJ3+xhzqVyzkcvHMrqUS7LYeaE9xtnImW8+usGx5+m+VH3G872CLzcVBimXUH4tiMiLR
         tyEo8DbvG7r+P1q2Y+lcraTz61hXRTRTgUGmdvFGVIMXKsVk95gqIAkCRGEQR8yzMTqd
         mTQA==
X-Forwarded-Encrypted: i=1; AKwUvBxrvUJH0zETJeILMiT5Lqc1M1Ic30BfFHxZI9VmRMqtBMBhPDshwo5tKpYXpnu8FgI1KkIwxin6Jz+8wzG9rrxi@vger.kernel.org
X-Gm-Message-State: AFq9FYL982HJOQoLp8FQcqOsVFMWKjMQ4rIP0yQxTnMqY232dkXEZ8sD
	28Tdhlr7SiiUwoZCaUgEVjDl0X0FSUSzIKK79xMkYdkkPwG6vA6ExjAWwB6/NKtPnsGz8EyT22v
	WitYyGNxDkA==
X-Received: from dyblz39.prod.google.com ([2002:a05:7301:1627:b0:343:6340:dc83])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4d14:b0:33b:eae9:946d
 with SMTP id 5a478bee46e88-342711ab345mr9524068eec.8.1790619979498; Mon, 28
 Sep 2026 11:26:19 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:25:42 -0700
In-Reply-To: <20260928182605.3649015-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com> <20260928182605.3649015-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928182605.3649015-4-irogers@google.com>
Subject: [PATCH v6 03/26] perf trace: Don't read sample padding as an
 augmented argument
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>
Cc: Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The kernel pads PERF_SAMPLE_RAW data to a u64 boundary without zeroing
the padding, so a syscall record without augmented arguments still has
up to 7 trailing bytes of stale data. syscall__augmented_args() passes
these to the beautifiers as a struct augmented_arg, whose size is then
garbage, causing a crash in syscall_arg__scnprintf_buf().

Ignore trailing data shorter than a struct augmented_arg.

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/arJ-gpzqOHk-gF8T@x2/
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d327603ae454..c39de91140a0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2961,26 +2961,29 @@ static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sam
 	 * traffic to just what is needed for each syscall.
 	 */
 	int args_size = raw_augmented_args_size ?: sc->args_size;
+	static uintptr_t argbuf[1024]; /* assuming single-threaded */
 
 	*augmented_args_size = sample->raw_size - args_size;
-	if (*augmented_args_size > 0) {
-		static uintptr_t argbuf[1024]; /* assuming single-threaded */
-
-		if ((size_t)(*augmented_args_size) > sizeof(argbuf))
-			return NULL;
+	/*
+	 * The raw data is padded to a u64 boundary with stale bytes, so less
+	 * than a struct augmented_arg is only padding.
+	 */
+	if (*augmented_args_size < (int)sizeof(struct augmented_arg) ||
+	    (size_t)(*augmented_args_size) > sizeof(argbuf)) {
+		*augmented_args_size = 0;
+		return NULL;
+	}
 
-		/*
-		 * The perf ring-buffer is 8-byte aligned but sample->raw_data
-		 * is not because it's preceded by u32 size.  Later, beautifier
-		 * will use the augmented args with stricter alignments like in
-		 * some struct.  To make sure it's aligned, let's copy the args
-		 * into a static buffer as it's single-threaded for now.
-		 */
-		memcpy(argbuf, sample->raw_data + args_size, *augmented_args_size);
+	/*
+	 * The perf ring-buffer is 8-byte aligned but sample->raw_data
+	 * is not because it's preceded by u32 size.  Later, beautifier
+	 * will use the augmented args with stricter alignments like in
+	 * some struct.  To make sure it's aligned, let's copy the args
+	 * into a static buffer as it's single-threaded for now.
+	 */
+	memcpy(argbuf, sample->raw_data + args_size, *augmented_args_size);
 
-		return argbuf;
-	}
-	return NULL;
+	return argbuf;
 }
 
 static int trace__sys_enter(struct trace *trace,
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

