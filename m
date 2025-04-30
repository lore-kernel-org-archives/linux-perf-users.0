Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567FEB640
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 00:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745973717; cv=none; b=n272YvESfO+sj5+ctimrUfhO6Kl7W+CONA4ysVtWgV8RfoISU52KSLhs/UHp0QzEQpTRqN0wervjEXQrY66R3M2QXgpSQK8bEaw7zdofzoagyKx7wwtwutle9bP0he8erwmYsIcwKgh9F33YM5X2POhq+xx90PgCQR3PSG8J4d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745973717; c=relaxed/simple;
	bh=pLvxUdxndsr2wYkJQYg49ecez/cviTwRj3eN4nJwgxo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ts9Ts26dCuC641vPkebi5KUWYN4cswrZL/EzQ5PSRF2GijrNDQb3L4MneT0PjeoAHgMPKu3chRNW5ioEyD4a+71HzTIBDKSG7urJheNNQya5Gfue37cljS/PalbGq1RRy/j58Mgya7DVLXlmg/hnOeiauKQ4IQdePjXMkfU4xPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=apNF28FV; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apNF28FV"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736cd36189bso9294164b3a.2
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Apr 2025 17:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745973715; x=1746578515; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VWjkucJuMaosxMcy1Z3rSUNsLtdDY3ZZywavpz7InSY=;
        b=apNF28FVbWdzH+0p7oT9pqhgVfytqVk4HeXo+6Pnia3EmomAcSMSbJQxSrx5jaqdv+
         +9rgBfJ7WR8ZIb1AQIrdBZpSvJdoOtkLqFDnVB5bV6hzfAwZgIKVv8/2pSJiSiZ7O8ro
         aOOxHiF6fqhWoRE/7cGosma/CCpMzJuGDnNx7kYgLDxHMdteOMvJZP/U6mhPM6e9g58P
         75/BKgxt+1kcfuxqKq+z9uOzONGN5f/ZMidHbVOGMhTnVnGPHEjJSLlRN9DiKcsZx84M
         WVra43nR9I9c4ShK8cQRuSXo708Z0UXlJWRWmYloVSAdwTMPf/tSHOLldBKRQrWtDlit
         lltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745973715; x=1746578515;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWjkucJuMaosxMcy1Z3rSUNsLtdDY3ZZywavpz7InSY=;
        b=hRTP8BDgf1Ze0tcITyBE2AzbVqN4cedBA13wlfMvYe1VDsdICPMUUcKfqE8hxVTzAC
         P16ZdlyeTORc5smwnDX0oIYU56HAipqUxQYKVGyPbtT1vRNsUrxcW4dAMGnfvYtFMO+w
         49MlDyzUiBllq7j/jCLvb+ldl+R/2D2A9z/ALm/NpMW1YcYNE1V+KcJmCBMeruNbdcQZ
         jBcc2YMe6Z0nKuab1USIKyfuewfeXuYqqI/5PQbSDrHop0GIx+M6wi4g+YH8p8jdBIIK
         3AYANXECty+3A4BY8EVeggynkO37nDQll4iD8ybUKYHlfeUz/Uq0C2fQylJScHqCiWbx
         JmNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmW1ZPl3yPWtv9wJLpiudSHw/UAumixWAnKhGOVWQSkytkEqxOQjv2ezTilsQyTBdSfN/+7Co5D4RXzQFMbtOA@vger.kernel.org
X-Gm-Message-State: AOJu0YwIb/Yb5Fdos7EVvHuA9/I0TqQTWVuEG/1NIiR9PlKVnWw9+lGs
	SQzlPkR4MaYiVhrAfAJXpkw/AE59eDGVTz3Ph2TnFbuirwdF4kMDm1aA846KEKa7/GP/qiNdUV+
	hHLEXRw==
X-Google-Smtp-Source: AGHT+IGBKZmj0xcnx3IB64TcbS0pb/r17lmOgH8lxAqqhmr49CDFUH1EBNpi6iyWZc1C2ZsKErjB7VbqxAQl
X-Received: from pfbfn23.prod.google.com ([2002:a05:6a00:2fd7:b0:740:555:f7af])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3924:b0:736:34a2:8a18
 with SMTP id d2e1a72fcca58-7403a836556mr988402b3a.24.1745973715575; Tue, 29
 Apr 2025 17:41:55 -0700 (PDT)
Date: Tue, 29 Apr 2025 17:41:28 -0700
In-Reply-To: <20250430004128.474388-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430004128.474388-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250430004128.474388-7-irogers@google.com>
Subject: [PATCH v2 6/6] perf test demangle-ocaml: Switch to using dso__demangle_sym
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

The use of the demangle-ocaml APIs means we don't detect if a different
demangler is used before the OCaml one for the case that matters to
perf.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/demangle-ocaml-test.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/demangle-ocaml-test.c b/tools/perf/tests/demangle-ocaml-test.c
index 90a4285e2ad5..612c788b7e0d 100644
--- a/tools/perf/tests/demangle-ocaml-test.c
+++ b/tools/perf/tests/demangle-ocaml-test.c
@@ -2,10 +2,9 @@
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
-#include "tests.h"
-#include "session.h"
 #include "debug.h"
-#include "demangle-ocaml.h"
+#include "symbol.h"
+#include "tests.h"
 
 static int test__demangle_ocaml(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
@@ -27,7 +26,7 @@ static int test__demangle_ocaml(struct test_suite *test __maybe_unused, int subt
 	};
 
 	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
-		buf = ocaml_demangle_sym(test_cases[i].mangled);
+		buf = dso__demangle_sym(/*dso=*/NULL, /*kmodule=*/0, test_cases[i].mangled);
 		if ((buf == NULL && test_cases[i].demangled != NULL)
 				|| (buf != NULL && test_cases[i].demangled == NULL)
 				|| (buf != NULL && strcmp(buf, test_cases[i].demangled))) {
-- 
2.49.0.901.g37484f566f-goog

