Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142925;
	b=jCEmz7qCtQE8IousTjV4Czx1IOYXHyo+3wTSV4aGARdwnt3skmuSqmyrJOkSGFZ4t7U9
	 hxLQf105XgKMPi1VdiYsMeC+sE71RcmJqt+RoN4JQPSiJN1IRFbyUHykz4UGX3xdJwg24
	 ckHHN3AjtjfLXhvF6enYliwspZcCatuMLiAb5QgDRONcSfI6534N7xEeK/M/D3ciCwlIm
	 3sdcpL/0raWawwgnn2k7DXCuWObHGstb0HMXr0j/NZ9zb19kqilSbTPgJSsFJSR5+PQaX
	 YJ0DHRlT4Rje0fjr6+V+GpLR/ba1vMVJU5zCg/l0VQXOCcHdq03kuaDRD6kv8jjhtSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ptu2Cc0GEGKDxeETDLH9JHqOyzOUYfVe0IfSZNyDWus=;
	b=bigLZMOJJmarTAsbIIZ66S069eIoMZXZN2hCIRf4iU31c/ubm8PrHfoMHKTmxGjLInbW
	 U5r4LniawhYRX4lOq6B116IEpgrEJPewMvOqOdROAypvjgsW5lpJaF5PQFQ/sIJ+iA7S8
	 tE6TNK+ZP9bru/ZX8F6oqDE+vgbgoZCndcF9IvSb/lLQ+reT/q61bAZ1UeVCsjZP8bT36
	 y/4yKKUmSiht4jgvLepAuFt0HfCPOU4globegfTfsZzud1lU9nV6A8RbfZbnj+YJzeECZ
	 ffhhTXyN3+EvnERjCnyMTf6CdVnNweAUJKSPJ+aQbJbIl69+bgfjnLyH0bi/X0z+LBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RVUwcXNs;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F6D606A327
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 23:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53F6D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RVUwcXNs
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3548cdfd2fbso458698eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 16:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793142923; x=1793747723; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ptu2Cc0GEGKDxeETDLH9JHqOyzOUYfVe0IfSZNyDWus=;
        b=RVUwcXNs7H924w68dQT38SbZSO3JOPu9WBW3zdmWHaWY1IWOleF5CTEFW6OosIGgCT
         sCvFQ+PFTLMz+1XvXsbHzaTym8jit1IIW8fjEHXH7P445rehgiatYKM8zwUh6cvK+waw
         yYazaHImi09jxcCzG0KCJHF1QKc4SytVae5ANUsVUzjMFTd918W1wR91zaPC5sPfHJAJ
         iWF6iZntj9dxZeYDHYk2vLigq8urfn9ZYxQBQsTZUqmZxe8b4TED4c1EUDzbqsUeJ0kR
         zWDjxxXmPjR6CvOOtqjJ/L+fzLbDwhFaoaKv4gZKL+Y52SYwfqmVTGOEXOGIhKXOZVqB
         RApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793142923; x=1793747723;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ptu2Cc0GEGKDxeETDLH9JHqOyzOUYfVe0IfSZNyDWus=;
        b=vjkrQIfqvCwP1TDJbDXdho8GEIS8epgL60fGsz8zaa2YMxICNRYbevoB3Irl37f7mE
         tpSt2AXCPpgqK+VY9jE526tVsK89xn4rOlcz7Wp/NEQmUz9lHes+aFFkuaxk4V6a6cwl
         ikaChZ+0TXK2UFINUZKbJxDdr6WLbQGo1ZVA9xRnKdkSADmUlnEuGSw7zEfcnGaKB6Nr
         OuybmErcHwVsWF72I//oWbI7BUASbluDk9Gp4u1A2sS8YIa+dbHl7F4xVIDzRxxug5u6
         x+gBia1VPuRahKUCG0HXasFijlJ2+Hexl1S9SEgcR05tDMipEyO9QBm1BXltpQrreVuY
         SiYg==
X-Forwarded-Encrypted: i=1; AKwUvByqEETILJLSB735Pu5jdHo74ZoT5avQ9uJe+GVLZT/4hrzyu0gSrWFYkHxUJVSjXp+8rEXkO9vkwHN1CWNdnmLN@vger.kernel.org
X-Gm-Message-State: AFq9FYJZW9WqaGwCD1HxTqKZWZskCRwoicTEugEspiD7kH1U+s+9NQbG
	gGw4QSL1WcP/jdK7O5aHxNDZIRtmwKjfugRBDIGmkKZ4Iq2waP5S2B0KqqW5dV9buEgiLNSz97n
	69Od/2elarQ==
X-Received: from dld12.prod.google.com ([2002:a05:7022:30c:b0:191:45cb:f8d3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:28c:b0:196:c1ca:3489
 with SMTP id a92af1059eb24-1a6c2a861e2mr963707c88.0.1793142922918; Tue, 27
 Oct 2026 16:15:22 -0700 (PDT)
Date: Tue, 27 Oct 2026 16:14:56 -0700
In-Reply-To: <20261027231513.816148-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com> <20261027231513.816148-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027231513.816148-3-irogers@google.com>
Subject: [PATCH v2 02/18] perf demangle: Add fast-path prefix checks for Rust
 and Java demanglers
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, haghdoost@uber.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
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
index b61a574ce9a3..dc70bbe8514f 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2738,7 +2738,20 @@ char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
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
2.56.0.313.g2479322e68-goog

