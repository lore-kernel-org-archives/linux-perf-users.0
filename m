Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24164F7CA4
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740437; cv=none; b=TmuEesa8F+i8EVwrh3rBkOHAZ6IsmDIDqI9baUjTsMKDtNRWeglV/tpRb9OcA2UqBYDFChFglMK4ClsciW7O7ptsWip3RZEgYicQY8sL1BWvNts+JDq8SB8T9vhKBZhpcG66F1eNkdiyd1ra/Ufw/EhketpCxiTp1OSLmiMMeKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740437; c=relaxed/simple;
	bh=GPdTrvCkiHU3/coaruf9IhbjFFcf1z7GDHB3eC+nIgM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UUOlYuO8vxMFruascVMU3qUuq+hifn5XvGwtFWjWCbGI86DuiwmVDrnHk1B3OvD+cUJnpgtuvjMiJv/zLFj58CwlmKM8nzilw2BzIv3PW70QM+qBAchEyBK9SxrOagR4EyOitmQpnFCUL3zW/byRXY/b7Qq9/NV3AfKuRaNHTaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=doEywkou; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="doEywkou"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39e3c10ac70so2090376a91.2
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 07:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789740434; x=1790345234; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ajb49arDbZGSllkSDDxIszaTKHNJOa78okU0Ays49S8=;
        b=doEywkouEu1g8XHlO8VK/KpeR8pf7PNeK4w6CeQzdjA37qDNa+9NV5WW8ZvcIE8Olv
         fksiXOq5cWTMVh9LD+kaQ3Ix+zOuSfJhB93HTlivlK34zZ4pzrAXSG9zA1wRDSLUiPT9
         WSDLIyCnMz+dEjW0DxsX8JyYBK9unl4waKQvmi7SbKVGKYUQmtxhbQT467PY3+MxSmzp
         cbMvFUXE/5oQoY9N2bUVdgJuha+WiDy1SWxlFaQQHhhlq1iq8hAavR8g4dqKwmaR+Zca
         Vr2I6NXoAE165eWk939oWebDH4KAINAPVfcAC3Bo8hTuLkLMlLUAh5xGoHZNB1VRuhB1
         WI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789740434; x=1790345234;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ajb49arDbZGSllkSDDxIszaTKHNJOa78okU0Ays49S8=;
        b=KlkIrdL8Ux5iT4hk0PFSOotI7zXlDFzu9eIIxrQ0SRzYJSKgjxkS6RF7qeW5DIRFCa
         yKk/BywgYYU+BV9Du8UvKvPNZ7z5FVmM76v4j42pj9zQ/i24t0Q9tZP0Nw0s+5BPG13v
         n5q8Rb02i5BBJrr2AEn19yxPfOoknNiN25zgKYwJXKKOA6oB2ACx7T7621TPjJUa6xvh
         YgL4j7C6lyQ+0Vv0+gB0LQEUGiLOeGB1W0CuWVa2arTPZ+YDK7aK6NDTK3Tmz22aSjv6
         qFnoVWZ0tHS42D8uCYX007fyj0gqPU+2cvzzsxyWs2nqdOwjnTnKZ+LLePTGc4l2Mv6d
         Sr4w==
X-Forwarded-Encrypted: i=1; AKwUvBwsF6eptNKmbvwV1TSQPeM2Fvb7Rpix8KDSkEmoqw07go/NNrksTYwPpUnz/9kTh7YF0P02t6nLUXi/V1ThHptN@vger.kernel.org
X-Gm-Message-State: AFuF++mICrhbYuR/hHNU70PSKWfDbepqzRTEeeG2ciaULoX1ZYAJ7MUv
	qxVo4eHUCbQwuUi7viNFQ4gzU7Vp4yNSJ5LKpKsHLXKGprCstOm1k1UmSY+7ZqOMhW+/H/kV2/H
	MLaE5WO9sjQ==
X-Received: from dlbro10.prod.google.com ([2002:a05:7022:158a:b0:143:91fd:56cb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1cc8:b0:39e:1329:7816
 with SMTP id 98e67ed59e1d1-39e54d703dbmr6319757a91.15.1789740434094; Fri, 18
 Sep 2026 07:07:14 -0700 (PDT)
Date: Fri, 18 Sep 2026 07:06:45 -0700
In-Reply-To: <20260918140659.2501976-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789662556.git.irogers@google.com> <20260918140659.2501976-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918140659.2501976-3-irogers@google.com>
Subject: [PATCH v3 02/16] perf trace: Free the whole evsel_trace in evsel__put_and_free_priv
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
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
2.55.0.1082.g2b9226bbc0-goog

