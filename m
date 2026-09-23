Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A020E44E642
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147663; cv=none; b=slGN+8LKLOiY/TMULFTglo1XoPAVQ2GNksRHeWFrvsVoCk0/iuR7rEsSxaQIG0+f2Ng9fidlMjZQOfbpoJX6CXj4NSLHXIfMc4bfIUe+DyaOngKSLjNY/2QfSN3qWgCGjo9sRlQbQYgJ1Kv1dVfzACgZq0wBOubppDKQww5TkTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147663; c=relaxed/simple;
	bh=tfm1p2pRKzqOayDkke0ZfWjT6Us+27QzzqDaoPShW5s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cpBglm9ALAtq8I0ISz6wRJMvZ7Wpd3Z1Sip7hN3RELxp086DUdWSElQtgxcULTKRN2KYxIEemHS6N4h/ckz2Db8dUGSuRmXVm3X+Fr1UP+fYc59SnfdZ+KcR3EH9R3BtTV8TI8ts6CFifyAAv4k66HwzaAZXkAU4J57u6o7VOQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bZNbc5Sg; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bZNbc5Sg"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33310847fcaso1069527eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 00:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790147661; x=1790752461; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G1ZTCAAIe4gWr/dGyhrEdH001VOEkbOqkOfQNugcAEc=;
        b=bZNbc5SgA1njAeGS8yfFUjrbrjMHVPJly4zv9C1WtKp6AGKQz9DrlhScFeV3fP4sGU
         eFyB0X/c0vQuQa4kzXJhBYiGlZM5TjnPJRJ2dhH3RwDizXzUsPkGWGZ8NScCJ0J8wqXO
         pxvbj+uHcv4F3L4z/EFFD3xakWKgI2mEoJDH47vlcYmanScHTavI7mmRQm10BOfXQB7Y
         2bTjIlMBiiHSnJo/o4e9ORxaWWqBz4FcGwEXKYB0KuzQ6uPDUqxtqe3OuKc+t92/P+j9
         GqcZ/Pmv+WueQRMwnUdvOEaZssNHOjDK5s0aibgGb22+gdC3ZeFtueGmS0CBjdIZuWNb
         J2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790147661; x=1790752461;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G1ZTCAAIe4gWr/dGyhrEdH001VOEkbOqkOfQNugcAEc=;
        b=sHR+shNL358Kes64xgqrX65WJPdFsbRhdSmQPBaHJN0aehoLWKKJi2+XKq4XHi30+T
         8zMoya5ZqUpCgprULi/L3YvsC+sQ9pst0Yr29v8C/6s/dlH5F6nTGqMk0CcUy9ruPfxu
         5bTUcO2pCiaE1woJiAnNHjZ8DXql2FKxCOi45MUqwEqCrMlVtfXeB1O6HpzAV64fHZ2N
         Dt/weRPOHMYn8Z4gJ9UhTxRyL5Bx02Fn5MuIf3dkS7V7aL59fY4O+fPWxrRMCsVPDWrN
         6Xir53nyqLMooRjl0je5cYsb/C87gRCNIyo9M6ipbpPKmVYBxg06HEdNNn2FShiaZjNR
         SXcQ==
X-Forwarded-Encrypted: i=1; AKwUvByyc/IVuqx4tusdDa4VsgZ+bGrXQBur5sfL8XRipU761zP75Q0vHb7N9cP8B3IL0Qx5zLVzGxOeHFy76y7k9oCT@vger.kernel.org
X-Gm-Message-State: AFuF++lyZZwqOgcur+KULRwT8ntETOPRXgq6jVkIMuReuBbpaT3H/RfI
	aXTx32avv3yfpsFCeIWHnp2q+19rNlKoD7wl93Djz82qrz4voDz4DNTgTwdnxUdCzbSPruIH7LJ
	W4DA/heiWAg==
X-Received: from dymj19.prod.google.com ([2002:a05:7300:6b13:b0:33e:51c3:47b8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:4144:10b0:33b:e9a7:d819
 with SMTP id 5a478bee46e88-33e8c05fe92mr1904022eec.14.1790147660249; Wed, 23
 Sep 2026 00:14:20 -0700 (PDT)
Date: Wed, 23 Sep 2026 00:13:44 -0700
In-Reply-To: <cover.1790145937.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <3cda6a7189745fc6251f18f9308dca3b1a32a33d.1790145937.git.irogers@google.com>
Subject: [PATCH v5 04/23] perf trace: Free the whole evsel_trace in evsel__put_and_free_priv
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, howardchu95@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Every evsel->priv in builtin-trace.c is a struct evsel_trace, allocated
by evsel_trace__new(). It holds a syscall_arg_fmt array in its fmt
member, which evsel__syscall_arg_fmt() allocates on demand for the
syscalls:sys_{enter,exit}_SYSCALL tracepoints and for every other
tracepoint that gets its arguments pretty printed.

evsel__put_and_free_priv() only did zfree(&evsel->priv), releasing the
evsel_trace itself and leaking that array. Use evsel_trace__delete(),
which frees fmt first, exactly as the out_delete path of
evsel__syscall_arg_fmt() already does.

The current callers are all error paths that run before fmt can have
been allocated, so nothing leaks in practice today, but the helper is
the obvious thing to reach for whenever an evsel is discarded and it
should be safe for that.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 20fffc24507b..f67557e7a254 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -464,7 +464,13 @@ static int evsel__init_tp_ptr_field(struct evsel *evsel, struct tp_field *field,
 
 static void evsel__put_and_free_priv(struct evsel *evsel)
 {
-	zfree(&evsel->priv);
+	/*
+	 * evsel->priv is always a struct evsel_trace here, so it has to go
+	 * through evsel_trace__delete(): zfree() on its own would release the
+	 * struct while leaking the syscall_arg_fmt array hanging off it.
+	 */
+	evsel_trace__delete(evsel->priv);
+	evsel->priv = NULL;
 	evsel__put(evsel);
 }
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

