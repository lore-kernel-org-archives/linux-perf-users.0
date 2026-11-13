Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590313;
	b=twEcq1GoznDOmGK7aBR1CzlnGbqUqGsst8xioel9grtbcnIV5CdEW5ccUe3TFi8FMiE1
	 SKQQk3BB3YStG7yLI7+OE+0ezQmit4baRsNcXV097nN2At/f/saLqzrLjKquwxH2Z+6gj
	 6NxWsH4+8PiyAo/XB5sOukzFYx0yZMBUlN2sb0iCbyq5+XXRsH+fea72t2JMOL/rnZQ54
	 3zrIPJ0vW+ztZ1dEwGRijiOBvpe8+GggsXPGIQegqofxHl4XNiyInRwVUrnMu4C9P7XUV
	 SvLXiJpwRuMUNqYlqtfJQkrOwvlkf4qZKf7zi5XxGMfhx2CyEgIySUSlJiPkN3fFP/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=DoGiL5U0zs7GL2/JDFKi5D+u1zoCO0bvFJ6uJO6+43E=;
	b=iShpDqbfaUB+CY1ZA9O8O5O2ZBWI5N1Vs4cljNWOT2RQP4O2VPHczz7mvfLfEtbDVtGZ
	 ssN0+XfQqoQKYpkqPPOxQY2XWM2M/Bz02HmXB9AW/KSsuWoC82BJ/JhJ30QrerMch+atl
	 N5zKPTk7OZddJyOZ4F1Wv9hvvGtyYGnDOVjAAhr/HwuVip3gDJ2gsJQBpE7US+ILoAXkM
	 dljamAQ2OD77dtg4y5vnfGLCkAcGkdrfcyiIVS/jlRRgr3mMQF9sAmE8hzwZP2dqe0MZe
	 b1205Bu7O5K9eJLjRKp13eje5BC4m4FqHsEZeL9wplg4ao17EXDyiJBqkrvCKXDssXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QlFLX8WG;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7F9607D2E1
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B7F9607D2E1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QlFLX8WG
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-341eff9e381so1810018eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 09:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794590312; x=1795195112; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DoGiL5U0zs7GL2/JDFKi5D+u1zoCO0bvFJ6uJO6+43E=;
        b=QlFLX8WG0QiTbv1GLjKWe+J3fRlKx1AUN3rYaTTAYBb4Oqg/fXjeXtzUPZv0yV3OvA
         yJCIBP6QrJysV8/YIBwmNT4crMzy5XyI3LPo2gGUrHRff41zKfqxnNTs8v5kFpAAkuPi
         Lm09JL78DL3Do29VAE6ZoyoyXxy3pWA/ARZAp/5r8NEdDsgztrDE2TKQ1XS2jAYYeSNk
         DFJXT/rqzqjSbaJI3tealCiZMYFY/L0PuT9YElk1Byk3KHzKoTiL6KvhavxHk1LrNdQk
         KpJFJ7Bsq0u4dqdiIEWbRbpLtLnXrj0W+DUEH/X9MJQXKIS3JBzS/jZv6zziiHkgpRdc
         fTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590312; x=1795195112;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DoGiL5U0zs7GL2/JDFKi5D+u1zoCO0bvFJ6uJO6+43E=;
        b=eMP8ecu03PebY49XlHCzi4GvDwMnN7zDkrj2GU1viXElvBlb/VbffKnIBS3IUvNmc9
         I6KiiQYcBFuL63KKKxJLUnD9wVa4q2Cmu0DkUv3Kub50a9ZD/zrvgYUwRaBxAA24FnmL
         xiTtR9DYDHtyiWS3W3Ylz6JSN+MfEQZndyrz1M4m9vJmjtTmbrRYWJyN/Y+fWuPK30qi
         CuCMEE0qj7mdh6BRdviBA9AW7i+D+5WfXaDa9Jsr1Kk4ePUqZA+4QO5Rf/0CIVUbXe2l
         nuBjibFDgHoPrc08tmpAbH3TgrZFAZt5QHZIgvSgW60NvR6FO4CXaOjJbNsza7msSFow
         kDMA==
X-Forwarded-Encrypted: i=1; AL+hErE1HYCylP9wbWU0aS7U6ox/I+EhjfvRZbTCgZ5zStzDlXXdUF5CxsU0n4Rt/MDb4RQ7i+tgZFdeo/CdxDOCqajr@vger.kernel.org
X-Gm-Message-State: APuU4Z+WbSxFZnzNDVqxODIOhLXYZ5/Jf13qtJdUf0P2lVsAfkcFtbcn
	7ms3EgENcAy+GluRLq7JRqdps+jKGCevVXv9rqY6sxasmL4k6M7rb0SSO3/3juC5YP3cQ9tukfj
	mbUq+2fliHQ==
X-Received: from dybqo12.prod.google.com ([2002:a05:7301:678c:b0:35d:1771:4816])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:d814:b0:36f:be1f:1191
 with SMTP id 5a478bee46e88-37a8852abe3mr490970eec.29.1794590312071; Fri, 13
 Nov 2026 09:18:32 -0800 (PST)
Date: Fri, 13 Nov 2026 09:17:25 -0800
In-Reply-To: <20261113171734.2188066-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110220803.2503416-1-irogers@google.com> <20261113171734.2188066-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113171734.2188066-15-irogers@google.com>
Subject: [PATCH v4 14/23] perf demangle: Add fast-path prefix checks for Rust
 and Java demanglers
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, haghdoost@uber.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

During DSO symbol loading in dso__load_sym_internal(), dso__demangle_sym()
is called for every ELF symbol. Both rust_demangle_demangle() and
java_demangle_sym() previously performed string searches or buffer
allocations before checking whether the symbol name could possibly be a
mangled Rust or Java symbol, adding unnecessary overhead on plain C
symbols.

Add fast-path prefix checks in dso__demangle_sym() before calling
rust_demangle_demangle() (using strstarts() for '_ZN', 'ZN', '__ZN',
'_R', 'R', or '__R', keeping demangle-rust-v0.c unmodified relative to
upstream rustc-demangle) and in java_demangle_sym() (requiring 'L', ';',
'(', and ')') to reject non-Rust and non-Java symbol names immediately.

Using 'perf bench internals symbols':

  Before (perf binary):
    Average DSO load + sort: 7.348 msec (+- 0.069 msec)
  After (perf binary, -4.2%):
    Average DSO load + sort: 7.041 msec (+- 0.051 msec)

  Before (libLLVM.so.21.1):
    Average DSO load + sort: 81.196 msec (+- 0.780 msec)
  After (libLLVM.so.21.1, -3.2%):
    Average DSO load + sort: 78.599 msec (+- 0.857 msec)

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/demangle-java.c | 23 +++++++++++++++++++++--
 tools/perf/util/symbol.c        | 15 ++++++++++++++-
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/demangle-java.c b/tools/perf/util/demangle-java.c
index c3cb327ed562..5625c4de39eb 100644
--- a/tools/perf/util/demangle-java.c
+++ b/tools/perf/util/demangle-java.c
@@ -158,14 +158,33 @@ char *
 java_demangle_sym(const char *str, int flags)
 {
 	char *buf, *ptr;
-	const char *p;
+	const char *l, *semi, *open, *p;
 	size_t len, l1 = 0;
 
 	if (!str)
 		return NULL;
 
+	/*
+	 * OpenJDK JIT symbols have the form:
+	 *   [prefix]L<class>;<method>(<args>)<return_type>
+	 * where the return type (such as 'I' for int or 'V' for void) is at the
+	 * end after ')'. In __demangle_java_sym(), the parser starts in
+	 * MODE_PREFIX and only reaches MODE_TYPE (required when ')' is reached)
+	 * via 'L' (MODE_CLASS) -> ';' (MODE_FUNC) -> '(' (MODE_TYPE). Verify
+	 * those delimiters appear in order before allocating the output buffer.
+	 */
+	l = strchr(str, 'L');
+	if (!l)
+		return NULL;
+	semi = strchr(l + 1, ';');
+	if (!semi)
+		return NULL;
+	open = strchr(semi + 1, '(');
+	if (!open)
+		return NULL;
+
 	/* find start of return type */
-	p = strrchr(str, ')');
+	p = strrchr(open + 1, ')');
 	if (!p)
 		return NULL;
 
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 0deda26181e0..cea8b9db8cd3 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2732,7 +2732,20 @@ char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
 	if (!want_demangle((dso && dso__kernel(dso)) || kmodule))
 		return demangled;
 
-	rust_demangle_demangle(elf_name, &rust_demangle);
+	/*
+	 * Rust mangled symbols start with one of the prefixes checked by
+	 * rust_demangle_legacy_demangle() ("_ZN", Windows dbghelp "ZN", or
+	 * macOS "__ZN") or rust_demangle_v0_demangle() ("_R", Windows dbghelp
+	 * "R", or macOS "__R") in demangle-rust-v0.c. Check the prefix here so
+	 * we avoid calling rust_demangle_demangle() (which scans the entire
+	 * symbol name with strstr() and strlen() for ThinLTO ".llvm." suffixes)
+	 * on non-Rust symbols, while keeping demangle-rust-v0.c unmodified
+	 * relative to upstream rustc-demangle.
+	 */
+	if (strstarts(elf_name, "_ZN") || strstarts(elf_name, "ZN") ||
+	    strstarts(elf_name, "__ZN") || strstarts(elf_name, "_R") ||
+	    strstarts(elf_name, "R") || strstarts(elf_name, "__R"))
+		rust_demangle_demangle(elf_name, &rust_demangle);
 	if (rust_demangle_is_known(&rust_demangle)) {
 		/* A rust mangled name. */
 		if (rust_demangle.mangled_len == 0)
-- 
2.56.1.703.gf848ed807c-goog

