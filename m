Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FF93515E9
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 01:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557363; cv=none; b=KGRsedbThZDp5s6/CufvxpRgD6gWi+s5y2rotkLg+7bRWHSgrk8eHZy0SQS0K7DdEIyN74XHgATtPNyEOpCJXkHRJIjhPvoGyhB/uD56Lyna8knwvIitOl153FLVgXj6esFrlv/MiEA+F9s+WQFuJg19pQWMdjc880kR3Rl8hMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557363; c=relaxed/simple;
	bh=YeaJ4Ia0VTq5E1Pkw5SVDSdPOiqtRjvDNNn7V/os76g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lyX8+EwMma6OnCqQXKy5OEAPeyZxACq96fM/KyvAAqTYgHb7/G8xTrajfwkqBKzIUZgN09nMOvdWmAtYj/u3Ld6OeMLfzNVuoE9tX3c1ARE4G2b+9n5VIq46sNyT0woPNYrkI2a6tEeSzQg6VPBo5+pWJMaOG65CIbSU0cnt9qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHccM71A; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHccM71A"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffb83bf7aso11379685e9.2
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Sep 2026 18:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790557360; x=1791162160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gD/C8uckJi4Nxey0HiO7Rb21XqdULzwYOsQTHmvqetg=;
        b=kHccM71A+E/6RLdRyGkCyygfTREtsDo9jvMw7ZGxZ55/crVo8SF3Sr7IMm5NIdRIcI
         hysYYkcv/CtOj3uGpM77XHyoaLA7a6kdnAEJmpe87eQF48W2OyT6zNVUYK8VZo1A+XBh
         pSvcfdyPwSE9M2PKLs/HrUsFESPQJW/YUa8ipSPOJdMrdl7au0m02iiiD0DDs71CpanZ
         /9/kbv5RxiyJXK8ByEoWqiG35sroRM40+nvo3WrcC8InFNHen12b3e3IWaBwFhG1lFsv
         BSJbgE7f+UdvOxAbgpU2FZZfuZHy0D6sxxBjGquh4neYNMytVn2U6bf1FcaMyBY+8Vjy
         wFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790557360; x=1791162160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gD/C8uckJi4Nxey0HiO7Rb21XqdULzwYOsQTHmvqetg=;
        b=KvrBMhlna4DOBSaTXLcU1ItpKPTz+GOKTTjZUPjd7Q1NVU/6clqx/8MXKSx7aE6mUW
         LiKBdSHUjYnASyulHmuvRYRxu/Hz2vsFlwmJxJmLOrPz9hRGaQzBje9BzxtE+CHim6Lq
         GDxhFcujI3IU0CAAgz5320hQSJZWc8nBugPGVQXGD9KnKhNJLrhzav6KPDfRNpUDSkLq
         BbIW+mFPT0lc7ZJIaw62NsyX+hkv6F3AU3LXoPWHb2MMSpZ/czVtArKg/8dKfgVRRrwa
         bb/pc6wKpD65pPvDjtiBEcSIsoelgJaM3y4vXAN/oILZu5QtFvPD/0N0Oll/39dkGgir
         1JJw==
X-Forwarded-Encrypted: i=1; AKwUvByqd0o6eUhUWYDBKutdBYWSfBTq9b+vmZbPftW1vJSIuiuEhny3Oo/E3XYLTY5z0KaaBQrLgk+BQrLm2pDx2TTC@vger.kernel.org
X-Gm-Message-State: AFuF++neZq3We3qB4R1jiZGQAA2+FM9P7g1Rk+Ib34qopG2giM5Jecf5
	A+kzFZYCiaQP1OOmZK/BpoQVID9HbaUl0l1mDq8KoF9JYjxfOhCfdQzy
X-Gm-Gg: AYBFou1l/18wO97Jg9SwG5/ulV7642Zw6zVrGFq1EZVXe29ETbQFs1Nvwv8zIQ3+3gh
	BD7lHgs9gir65JoBTRRzwOS9dXsmJGuE1Yp1GYfgp8UesMeSuRmvFi7JpQIpnAbVY+pCnV1LSTP
	d9V2VAUijcYXByGw3Cjnb6owdrjQVDMNli9xh8a3K1tfsktOxCcHo7N6yW10TjE8Z7aiR4wC7xj
	e5PKU14M/NRTq4pzp6NrR9eADFC2yG46U2yoummKxUuW6CEIervubN1ivBGngTSDe5udupY7wcb
	RPPyj1zn8lXJ3wVXbaZxky8SijY5+dKZ1PwNBa2WNzStI7Uz7BP3PLzUEbjYetfco1BEGLLbpFQ
	shWvCBQz3fc+van6aBtLCCPiNPbJW29B9Z6TJbo+rEA/yybpzaEZtjeHZVTPXsFBjT0vvr1ejEk
	wKeUMIjeow1kdM7uHYNEoMzOsqJHRu1rY1L9tkhfjYPsjz93AqXNRsZMZTGydKGugspNHfRP/xL
	LyXRMZ8FhwdAoeNzISrYscpg0babW64CuA7k5DidWt0VaVvfooJQWNJkSXpCk4p87fXYJAySpz4
	JLJ5Cv51yQYDS9ZfSUgNc40b5siPD/htT6tO/sOp3UB9NT0ovYc=
X-Received: by 2002:a05:600c:4e55:b0:49f:bd3c:bc1a with SMTP id 5b1f17b1804b1-49fe66f506fmr192589715e9.21.1790557360115;
        Sun, 27 Sep 2026 18:02:40 -0700 (PDT)
Received: from mikebook.tail5724d6.ts.net (83-244-142-114.cust-83.exponential-e.net. [83.244.142.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0017652d1sm144207825e9.5.2026.09.27.18.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:02:39 -0700 (PDT)
From: Michal Pluta <michalpl2003@gmail.com>
To: acme@kernel.org,
	namhyung@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] perf symbol: Grow the Rust demangle buffer geometrically
Date: Mon, 28 Sep 2026 02:02:25 +0100
Message-ID: <20260928010227.1903673-4-michalpl2003@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928010227.1903673-1-michalpl2003@gmail.com>
References: <20260928010227.1903673-1-michalpl2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a demangled Rust name doesn't fit in the provided buffer,
dso__demangle_sym() adds 32 bytes to it and formats the name again from
the start.  The number of attempts grows with the length of the output,
so the total work is quadratic.  Names with deeply nested generic types
need many attempts, leading to noticeable slowdowns in larger programs.

Double the buffer instead, reaching the maximum buffer limit exactly
rather than stopping 32 bytes early.  The demangled names are
unchanged.

Add a test for a symbol whose expansion exceeds the bound.

Signed-off-by: Michal Pluta <michalpl2003@gmail.com>
---
 tools/perf/tests/demangle-rust-v0-test.c | 12 ++++++++++++
 tools/perf/util/symbol.c                 | 10 ++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/demangle-rust-v0-test.c b/tools/perf/tests/demangle-rust-v0-test.c
index ee4ddb61174b..d1e0636d73bc 100644
--- a/tools/perf/tests/demangle-rust-v0-test.c
+++ b/tools/perf/tests/demangle-rust-v0-test.c
@@ -69,6 +69,18 @@ static int test__demangle_rust(struct test_suite *test __maybe_unused, int subte
 		free(buf);
 	}
 
+	/*
+	 * A symbol with more lifetimes bound than fit in the largest buffer
+	 * must fail to demangle rather than give a truncated name.
+	 */
+	buf = dso__demangle_sym(/*dso=*/NULL, /*kmodule=*/0, "_RINvC1a1fFGZZZZZZ_EuE");
+	if (buf) {
+		pr_debug("FAILED: symbol larger than the buffer limit demangled to %zu bytes\n",
+			 strlen(buf));
+		ret = TEST_FAIL;
+		free(buf);
+	}
+
 	return ret;
 }
 
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 3cb42805a82f..1a52bc2980a0 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2737,29 +2737,35 @@ char *cxx_demangle_sym(const char *str __maybe_unused, bool params __maybe_unuse
 }
 #endif /* !HAVE_CXA_DEMANGLE_SUPPORT */
 
+/* Buffer limit for a demangled Rust symbol name. */
+#define RUST_DEMANGLE_MAX_LEN (1024 * 1024)
+
 char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
 {
 	struct demangle rust_demangle = {
 		.style = DemangleStyleUnknown,
 	};
 	char *demangled = NULL;
+	size_t buf_len;
 
 	/*
 	 * We need to figure out if the object was created from C++ sources
 	 * DWARF DW_compile_unit has this, but we don't always have access
 	 * to it...
 	 */
 	if (!want_demangle((dso && dso__kernel(dso)) || kmodule))
 		return demangled;
 
 	rust_demangle_demangle(elf_name, &rust_demangle);
 	if (rust_demangle_is_known(&rust_demangle)) {
 		/* A rust mangled name. */
 		if (rust_demangle.mangled_len == 0)
 			return demangled;
 
-		for (size_t buf_len = roundup_pow_of_two(rust_demangle.mangled_len * 2);
-		     buf_len < 1024 * 1024; buf_len += 32) {
+		for (buf_len = min_t(size_t, roundup_pow_of_two(rust_demangle.mangled_len * 2),
+				     RUST_DEMANGLE_MAX_LEN);
+		     buf_len <= RUST_DEMANGLE_MAX_LEN;
+		     buf_len *= 2) {
 			char *tmp = realloc(demangled, buf_len);
 
 			if (!tmp)
-- 
2.43.0

