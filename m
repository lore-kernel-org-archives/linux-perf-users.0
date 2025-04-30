Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BE82DC776
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 00:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745973706; cv=none; b=DlgAal0e7y4au88Z9O3MtLSgLTVjG60w4JtyU9W3BR75cC0dMPvpsgKHYYrPjJMgb03gmVo/u98Z7tztMebBmW6vrLEHrDBgHOh4Ur1P9nJtFFZUGjtJ+HO5s2UHo6Fn+hPnS2l8SEPegdj7PNc7xcy+hYbEIYcVJqsJPDpEaSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745973706; c=relaxed/simple;
	bh=bQOUZ5ooNOtzWZnFpHAynQKZLkRbyLSyu+YVQL5hQ8U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GAMAXRgPZ/GwooIU4xrp3+SEyEe4bl8Isktz6sfTDfqymIOwzBKJJ2sM0z7NOzrGl2NQSrTo0kA3V2AKphj42j3ETnvIHuOqMQ3Sn7g4MjLNvqZZDoc+uHbOLA3346ItejwFcrWgz1myW0pofU+0Y5Y4GsNuociYu5rmTpJdIBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=spaBFm9+; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="spaBFm9+"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-229668c8659so46431165ad.3
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Apr 2025 17:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745973704; x=1746578504; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3P8+0W8rcJSWHrA+D5OrYMrXp40a4gp5I5ey87XHEMw=;
        b=spaBFm9+O3gnVkVsjA8+1JMAuYnv+kV30KqWLfd73qsOO8OwEBZ+SeaHWpmuJ3K+AV
         WT/mt0RXDhRqKZI+GSddbO3ZZ4p+FdZm4+mdskNDngR0AsrRjvzjcfTeEWybDbwTsFc+
         1rHL1QA0uBdi4Y1pvpgaGKRIhmj/wnhzaV160qb3sjCbwmU3WDYmUrEs46idpUjHiiTE
         M/dwXJ2LX8ZiCTjRUfCZeJ5MBULmStqh98nzCL/D2wSUQ0d61k9yMrnt29T1HKGPNrbd
         LAY/dVSDpN58t2MhEfNqJ1mIbuL3QUCwiVTw+RLSIM7lmY4pjUkPl2iQXNpz93rtxOen
         K/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745973704; x=1746578504;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3P8+0W8rcJSWHrA+D5OrYMrXp40a4gp5I5ey87XHEMw=;
        b=OHl79lquvhelPA8NtsoGjOaBx+pN7cPwoP6I5bS9zXVkWN5oZCdJCSEKP1Ui6//n+p
         MF+4ho2LmfqRbGcUagRJCTkTRqh1Brbvakbemj9pHfDxRfG/ieRqt+d/qv+QPrZG6qt0
         YYJ9KevGEQrfAn/HXuA9qeGAKa+gsZi+QQtm7yAMcbc58HaQZBiIB6IC5FTuKAKA32w7
         OH2RkXPbzOZfYO8bcooXh5fl/BbiWvuV5jdOYlLRKK12Vgu9ojKfrbQoxNH7/mkEDrcD
         UgVhWYPzsR1H1rGFlUhE6zFGxwWpaJNHigJq95c65J26rK418m59fYGfrKtcv2xsWxIN
         U5Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUj5pnXc2MN3nPs6wmotFdcmXbNEnxoD3sUwKLGEFEzTThxpa76+HI1O/htIfBzYSs12Pu5xL49tCZpFlypB2E5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9iTVvjUR29+RY6yjcx5jHCwsgbxOLtI4QtIUlfZqAZfLuu+sq
	qI3I7xJOK0DqIrP3KFekcplK3QQMusCKUJKaw3fUCc0u0WCSRw885olAKec/hWUHWhybwt6cFik
	Wsybtog==
X-Google-Smtp-Source: AGHT+IF6rGQczrBYLKeu5PIevKkC9hGr0+f3qbWmXMTSLnxpnnROvoClomrm5O7BzJV9EQmtFyeGFOVFy560
X-Received: from plbja7.prod.google.com ([2002:a17:902:efc7:b0:223:f59e:ae50])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4d1:b0:223:669f:ca2d
 with SMTP id d9443c01a7336-22df356d961mr21753095ad.35.1745973703883; Tue, 29
 Apr 2025 17:41:43 -0700 (PDT)
Date: Tue, 29 Apr 2025 17:41:25 -0700
In-Reply-To: <20250430004128.474388-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430004128.474388-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250430004128.474388-4-irogers@google.com>
Subject: [PATCH v2 3/6] perf demangle-rust: Remove previous legacy rust decoder
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev, 
	Daniel Xu <dxu@dxuuu.xyz>, Ariel Ben-Yehuda <ariel.byd@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Code is unused since the introduction of rustc-demangle demangler.

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/demangle-rust.c | 269 --------------------------------
 tools/perf/util/demangle-rust.h |   8 -
 2 files changed, 277 deletions(-)
 delete mode 100644 tools/perf/util/demangle-rust.c
 delete mode 100644 tools/perf/util/demangle-rust.h

diff --git a/tools/perf/util/demangle-rust.c b/tools/perf/util/demangle-rust.c
deleted file mode 100644
index a659fc69f73a..000000000000
--- a/tools/perf/util/demangle-rust.c
+++ /dev/null
@@ -1,269 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <string.h>
-#include "debug.h"
-
-#include "demangle-rust.h"
-
-/*
- * Mangled Rust symbols look like this:
- *
- *     _$LT$std..sys..fd..FileDesc$u20$as$u20$core..ops..Drop$GT$::drop::hc68340e1baa4987a
- *
- * The original symbol is:
- *
- *     <std::sys::fd::FileDesc as core::ops::Drop>::drop
- *
- * The last component of the path is a 64-bit hash in lowercase hex, prefixed
- * with "h". Rust does not have a global namespace between crates, an illusion
- * which Rust maintains by using the hash to distinguish things that would
- * otherwise have the same symbol.
- *
- * Any path component not starting with a XID_Start character is prefixed with
- * "_".
- *
- * The following escape sequences are used:
- *
- *     ","  =>  $C$
- *     "@"  =>  $SP$
- *     "*"  =>  $BP$
- *     "&"  =>  $RF$
- *     "<"  =>  $LT$
- *     ">"  =>  $GT$
- *     "("  =>  $LP$
- *     ")"  =>  $RP$
- *     " "  =>  $u20$
- *     "'"  =>  $u27$
- *     "["  =>  $u5b$
- *     "]"  =>  $u5d$
- *     "~"  =>  $u7e$
- *
- * A double ".." means "::" and a single "." means "-".
- *
- * The only characters allowed in the mangled symbol are a-zA-Z0-9 and _.:$
- */
-
-static const char *hash_prefix = "::h";
-static const size_t hash_prefix_len = 3;
-static const size_t hash_len = 16;
-
-static bool is_prefixed_hash(const char *start);
-static bool looks_like_rust(const char *sym, size_t len);
-static bool unescape(const char **in, char **out, const char *seq, char value);
-
-/*
- * INPUT:
- *     sym: symbol that has been through BFD-demangling
- *
- * This function looks for the following indicators:
- *
- *  1. The hash must consist of "h" followed by 16 lowercase hex digits.
- *
- *  2. As a sanity check, the hash must use between 5 and 15 of the 16 possible
- *     hex digits. This is true of 99.9998% of hashes so once in your life you
- *     may see a false negative. The point is to notice path components that
- *     could be Rust hashes but are probably not, like "haaaaaaaaaaaaaaaa". In
- *     this case a false positive (non-Rust symbol has an important path
- *     component removed because it looks like a Rust hash) is worse than a
- *     false negative (the rare Rust symbol is not demangled) so this sets the
- *     balance in favor of false negatives.
- *
- *  3. There must be no characters other than a-zA-Z0-9 and _.:$
- *
- *  4. There must be no unrecognized $-sign sequences.
- *
- *  5. There must be no sequence of three or more dots in a row ("...").
- */
-bool
-rust_is_mangled(const char *sym)
-{
-	size_t len, len_without_hash;
-
-	if (!sym)
-		return false;
-
-	len = strlen(sym);
-	if (len <= hash_prefix_len + hash_len)
-		/* Not long enough to contain "::h" + hash + something else */
-		return false;
-
-	len_without_hash = len - (hash_prefix_len + hash_len);
-	if (!is_prefixed_hash(sym + len_without_hash))
-		return false;
-
-	return looks_like_rust(sym, len_without_hash);
-}
-
-/*
- * A hash is the prefix "::h" followed by 16 lowercase hex digits. The hex
- * digits must comprise between 5 and 15 (inclusive) distinct digits.
- */
-static bool is_prefixed_hash(const char *str)
-{
-	const char *end;
-	bool seen[16];
-	size_t i;
-	int count;
-
-	if (strncmp(str, hash_prefix, hash_prefix_len))
-		return false;
-	str += hash_prefix_len;
-
-	memset(seen, false, sizeof(seen));
-	for (end = str + hash_len; str < end; str++)
-		if (*str >= '0' && *str <= '9')
-			seen[*str - '0'] = true;
-		else if (*str >= 'a' && *str <= 'f')
-			seen[*str - 'a' + 10] = true;
-		else
-			return false;
-
-	/* Count how many distinct digits seen */
-	count = 0;
-	for (i = 0; i < 16; i++)
-		if (seen[i])
-			count++;
-
-	return count >= 5 && count <= 15;
-}
-
-static bool looks_like_rust(const char *str, size_t len)
-{
-	const char *end = str + len;
-
-	while (str < end)
-		switch (*str) {
-		case '$':
-			if (!strncmp(str, "$C$", 3))
-				str += 3;
-			else if (!strncmp(str, "$SP$", 4)
-					|| !strncmp(str, "$BP$", 4)
-					|| !strncmp(str, "$RF$", 4)
-					|| !strncmp(str, "$LT$", 4)
-					|| !strncmp(str, "$GT$", 4)
-					|| !strncmp(str, "$LP$", 4)
-					|| !strncmp(str, "$RP$", 4))
-				str += 4;
-			else if (!strncmp(str, "$u20$", 5)
-					|| !strncmp(str, "$u27$", 5)
-					|| !strncmp(str, "$u5b$", 5)
-					|| !strncmp(str, "$u5d$", 5)
-					|| !strncmp(str, "$u7e$", 5))
-				str += 5;
-			else
-				return false;
-			break;
-		case '.':
-			/* Do not allow three or more consecutive dots */
-			if (!strncmp(str, "...", 3))
-				return false;
-			/* Fall through */
-		case 'a' ... 'z':
-		case 'A' ... 'Z':
-		case '0' ... '9':
-		case '_':
-		case ':':
-			str++;
-			break;
-		default:
-			return false;
-		}
-
-	return true;
-}
-
-/*
- * INPUT:
- *     sym: symbol for which rust_is_mangled(sym) returns true
- *
- * The input is demangled in-place because the mangled name is always longer
- * than the demangled one.
- */
-void
-rust_demangle_sym(char *sym)
-{
-	const char *in;
-	char *out;
-	const char *end;
-
-	if (!sym)
-		return;
-
-	in = sym;
-	out = sym;
-	end = sym + strlen(sym) - (hash_prefix_len + hash_len);
-
-	while (in < end)
-		switch (*in) {
-		case '$':
-			if (!(unescape(&in, &out, "$C$", ',')
-					|| unescape(&in, &out, "$SP$", '@')
-					|| unescape(&in, &out, "$BP$", '*')
-					|| unescape(&in, &out, "$RF$", '&')
-					|| unescape(&in, &out, "$LT$", '<')
-					|| unescape(&in, &out, "$GT$", '>')
-					|| unescape(&in, &out, "$LP$", '(')
-					|| unescape(&in, &out, "$RP$", ')')
-					|| unescape(&in, &out, "$u20$", ' ')
-					|| unescape(&in, &out, "$u27$", '\'')
-					|| unescape(&in, &out, "$u5b$", '[')
-					|| unescape(&in, &out, "$u5d$", ']')
-					|| unescape(&in, &out, "$u7e$", '~'))) {
-				pr_err("demangle-rust: unexpected escape sequence");
-				goto done;
-			}
-			break;
-		case '_':
-			/*
-			 * If this is the start of a path component and the next
-			 * character is an escape sequence, ignore the
-			 * underscore. The mangler inserts an underscore to make
-			 * sure the path component begins with a XID_Start
-			 * character.
-			 */
-			if ((in == sym || in[-1] == ':') && in[1] == '$')
-				in++;
-			else
-				*out++ = *in++;
-			break;
-		case '.':
-			if (in[1] == '.') {
-				/* ".." becomes "::" */
-				*out++ = ':';
-				*out++ = ':';
-				in += 2;
-			} else {
-				/* "." becomes "-" */
-				*out++ = '-';
-				in++;
-			}
-			break;
-		case 'a' ... 'z':
-		case 'A' ... 'Z':
-		case '0' ... '9':
-		case ':':
-			*out++ = *in++;
-			break;
-		default:
-			pr_err("demangle-rust: unexpected character '%c' in symbol\n",
-				*in);
-			goto done;
-		}
-
-done:
-	*out = '\0';
-}
-
-static bool unescape(const char **in, char **out, const char *seq, char value)
-{
-	size_t len = strlen(seq);
-
-	if (strncmp(*in, seq, len))
-		return false;
-
-	**out = value;
-
-	*in += len;
-	*out += 1;
-
-	return true;
-}
diff --git a/tools/perf/util/demangle-rust.h b/tools/perf/util/demangle-rust.h
deleted file mode 100644
index 2fca618b1aa5..000000000000
--- a/tools/perf/util/demangle-rust.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __PERF_DEMANGLE_RUST
-#define __PERF_DEMANGLE_RUST 1
-
-bool rust_is_mangled(const char *str);
-void rust_demangle_sym(char *str);
-
-#endif /* __PERF_DEMANGLE_RUST */
-- 
2.49.0.901.g37484f566f-goog

