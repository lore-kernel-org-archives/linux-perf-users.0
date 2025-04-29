Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDCC2550BB
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Apr 2025 18:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745953158; cv=none; b=ZP2gApMVpQzYWUTXuUhbZ79Nz+yuHI6m2lUzqnCRFy9TJYEmF/LiOnyWedYWmWT2GbSWBOmwm+Vs/Z1dy55K5/uwmQT1t0PdJt4XYWuvxn2UJ+6ZAExj7djklfM0BtSozvq9ZDi09gZQd23ttPy/z37KNEb0C1WXGwIl1c8yA5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745953158; c=relaxed/simple;
	bh=J3jpNhn0L0RmqQRHro2IecNg02DmmYFRiA3vyYti8QU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Doou+8HwDKRppuSbEsjFJoRYwC1VE4T+/D6XnqT3F9+CQRppEEm8sBt+h61Q8eDUtxuXhnxsCCsgYvg9z45EliKQBp59oz6wOLuko0lLohA86vnvCzfaAuXelHegWYIykOdVRdM/EXiiXqQQAKCyKvZXoia/RfxKhQQDZ1IWj1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jrhBgCCk; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jrhBgCCk"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3032ea03448so6122491a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Apr 2025 11:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745953156; x=1746557956; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kwZxu6T2B4sSkVVEcDdLfRn7wg748q/A7mexDtxkipg=;
        b=jrhBgCCkOpZgBHlg+DB2sgkVwZFUZI+maNMhC2jKFNVndr0/1TNtXQ7339vd4NFYDO
         bklORvd82gDFTgB0rXl75aHCQavuf+L78RGLwTdEVmuxL5XgaL5Qve8K34WsxPTAaTGD
         A/sUufBV5S5dDIfgWEdPxp/2kEXPKfX3BXYBw2pjGa0mls8se3ohaBxE0JUqyGsbTDyz
         aHUt8oZ88GhAapyLC3BrzRizPun61Lxo26VB3lPkyMpCdQ9xgXUEeG1BPd8/69bzT5ha
         7QvYntitSB7mJPDPkpkJgip6yYQGLg8p8fcTSBrOyI5wVdx6RoXwqzZkzWtiNlW8oby3
         EPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745953156; x=1746557956;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kwZxu6T2B4sSkVVEcDdLfRn7wg748q/A7mexDtxkipg=;
        b=CfuYGh2D3MFHWe6KdmFw0GcQ4dlPOTpyDm/cwE2svuXBpl9i17+NyZczcyMmmuxGpA
         EHmeT4kZmFNaAh3n5wwbJAcceaO34PozAjLtwlnqD4d9wwndZQGsFcs4e+Xq/nC2DYgt
         qRYFFaAfJ4Qmz4AL9GFphAiRKyudZqZPqJgzowIzsmrq+4Rag/9BdYd78P4Ub5NC7Jde
         Ib5GJLv9tZaebssKPhdInNVsLN6D5MBedOVZma5sj9QaL2yG7CSd78QFts2IYyf1oZWP
         DZlNOMew15dd9YK4u5dR+QEOxUOoC2k+O/V2iMIdAhLHSx8Lpgm/nwQQrOGJHhjvgFfy
         n4ww==
X-Forwarded-Encrypted: i=1; AJvYcCXVesl25xGIlpuOrYesQ2crR5+xiKTt9yw7H2tBfd+/bF98RysCLQd7gLZKbKOGKtMpvEhDim9esZcLJlbXyh4D@vger.kernel.org
X-Gm-Message-State: AOJu0YyrO6ZU1uYU7YdCcKciSdlFYsbAxycUiyuOefw0oOhzgoDHt1pK
	DcZEVFPXfyi8aQ1gKBTGwoR9Qz17JDI75qdP0hhYYaPomq8xPBP/kCUmCFmrYz0Ni8iKNmwUIPa
	X9JrC7Q==
X-Google-Smtp-Source: AGHT+IEgShAFHftTTVxbrvVcDqE2v6HQyys2Tjgrus0Ml4unFOZkCNqcLxKiT5FKmZLOfryZx2Mt7AWcMLto
X-Received: from pjbdj11.prod.google.com ([2002:a17:90a:d2cb:b0:2ff:6e58:8a0a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:55c7:b0:2ee:e113:815d
 with SMTP id 98e67ed59e1d1-30a332ee938mr337025a91.8.1745953156249; Tue, 29
 Apr 2025 11:59:16 -0700 (PDT)
Date: Tue, 29 Apr 2025 11:58:36 -0700
In-Reply-To: <20250429185839.1807005-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250429185839.1807005-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250429185839.1807005-5-irogers@google.com>
Subject: [PATCH v1 4/6] perf test demangle-rust: Add Rust demangling test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
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
	Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"

The test cases are listed examples in:
https://doc.rust-lang.org/rustc/symbol-mangling/v0.html

This test was previously part of a different Rust v0 demangler:
https://lore.kernel.org/lkml/20250129193037.573431-1-irogers@google.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/Build                   |  1 +
 tools/perf/tests/builtin-test.c          |  1 +
 tools/perf/tests/demangle-rust-v0-test.c | 74 ++++++++++++++++++++++++
 tools/perf/tests/tests.h                 |  1 +
 tools/perf/util/symbol-elf.c             |  4 +-
 5 files changed, 79 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/tests/demangle-rust-v0-test.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 934f32090553..2181f5a92148 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -56,6 +56,7 @@ perf-test-y += genelf.o
 perf-test-y += api-io.o
 perf-test-y += demangle-java-test.o
 perf-test-y += demangle-ocaml-test.o
+perf-test-y += demangle-rust-v0-test.o
 perf-test-y += pfm.o
 perf-test-y += parse-metric.o
 perf-test-y += pe-file-parsing.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 14d30a5053be..45d3d8b3317a 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -126,6 +126,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__maps__merge_in,
 	&suite__demangle_java,
 	&suite__demangle_ocaml,
+	&suite__demangle_rust,
 	&suite__parse_metric,
 	&suite__pe_file_parsing,
 	&suite__expand_cgroup_events,
diff --git a/tools/perf/tests/demangle-rust-v0-test.c b/tools/perf/tests/demangle-rust-v0-test.c
new file mode 100644
index 000000000000..efbc0fc25ffc
--- /dev/null
+++ b/tools/perf/tests/demangle-rust-v0-test.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include "tests.h"
+#include "debug.h"
+#include "symbol.h"
+#include <linux/kernel.h>
+#include <stdlib.h>
+#include <string.h>
+
+static int test__demangle_rust(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	int ret = TEST_OK;
+	char *buf = NULL;
+	size_t i;
+
+	struct {
+		const char *mangled, *demangled;
+	} test_cases[] = {
+		{ "_RNvMsr_NtCs3ssYzQotkvD_3std4pathNtB5_7PathBuf3newCs15kBYyAo9fc_7mycrate",
+		  "<std::path::PathBuf>::new" },
+		{ "_RNvCs15kBYyAo9fc_7mycrate7example",
+		  "mycrate::example" },
+		{ "_RNvMs_Cs4Cv8Wi1oAIB_7mycrateNtB4_7Example3foo",
+		  "<mycrate::Example>::foo" },
+		{ "_RNvXCs15kBYyAo9fc_7mycrateNtB2_7ExampleNtB2_5Trait3foo",
+		  "<mycrate::Example as mycrate::Trait>::foo" },
+		{ "_RNvMCs7qp2U7fqm6G_7mycrateNtB2_7Example3foo",
+		  "<mycrate::Example>::foo" },
+		{ "_RNvMs_Cs7qp2U7fqm6G_7mycrateNtB4_7Example3bar",
+		  "<mycrate::Example>::bar" },
+		{ "_RNvYNtCs15kBYyAo9fc_7mycrate7ExampleNtB4_5Trait7exampleB4_",
+		  "<mycrate::Example as mycrate::Trait>::example" },
+		{ "_RNCNvCsgStHSCytQ6I_7mycrate4main0B3_",
+		  "mycrate::main::{closure#0}" },
+		{ "_RNCNvCsgStHSCytQ6I_7mycrate4mains_0B3_",
+		  "mycrate::main::{closure#1}" },
+		{ "_RINvCsgStHSCytQ6I_7mycrate7examplelKj1_EB2_",
+		  "mycrate::example::<i32, 1>" },
+		{ "_RINvCs7qp2U7fqm6G_7mycrate7exampleFG0_RL1_hRL0_tEuEB2_",
+		  "mycrate::example::<for<'a, 'b> fn(&'a u8, &'b u16)>",
+		},
+		{ "_RINvCs7qp2U7fqm6G_7mycrate7exampleKy12345678_EB2_",
+		  "mycrate::example::<305419896>" },
+		{ "_RNvNvMCsd9PVOYlP1UU_7mycrateINtB4_7ExamplepKpE3foo14EXAMPLE_STATIC",
+		  "<mycrate::Example<_, _>>::foo::EXAMPLE_STATIC",
+		},
+		{ "_RINvCs7qp2U7fqm6G_7mycrate7exampleAtj8_EB2_",
+		  "mycrate::example::<[u16; 8]>" },
+		{ "_RINvCs7qp2U7fqm6G_7mycrate7exampleNtB2_7ExampleBw_EB2_",
+		  "mycrate::example::<mycrate::Example, mycrate::Example>" },
+		{ "_RINvMsY_NtCseXNvpPnDBDp_3std4pathNtB6_4Path3neweECs7qp2U7fqm6G_7mycrate",
+		  "<std::path::Path>::new::<str>" },
+		{ "_RNvNvNvCs7qp2U7fqm6G_7mycrate7EXAMPLE7___getit5___KEY",
+		  "mycrate::EXAMPLE::__getit::__KEY" },
+	};
+
+	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
+		buf = dso__demangle_sym(/*dso=*/NULL, /*kmodule=*/0, test_cases[i].mangled);
+		if (!buf) {
+			pr_debug("FAILED to demangle: \"%s\"\n \"%s\"\n", test_cases[i].mangled,
+				 test_cases[i].demangled);
+			continue;
+		}
+		if (strcmp(buf, test_cases[i].demangled)) {
+			pr_debug("FAILED: %s: %s != %s\n", test_cases[i].mangled,
+				 buf, test_cases[i].demangled);
+			ret = TEST_FAIL;
+		}
+		free(buf);
+	}
+
+	return ret;
+}
+
+DEFINE_SUITE("Demangle Rust", demangle_rust);
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 8aea344536b8..bb7951c61971 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -157,6 +157,7 @@ DECLARE_SUITE(jit_write_elf);
 DECLARE_SUITE(api_io);
 DECLARE_SUITE(demangle_java);
 DECLARE_SUITE(demangle_ocaml);
+DECLARE_SUITE(demangle_rust);
 DECLARE_SUITE(pfm);
 DECLARE_SUITE(parse_metric);
 DECLARE_SUITE(pe_file_parsing);
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index f953868521f2..8734e8b6cf84 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -319,7 +319,7 @@ static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
 	 * DWARF DW_compile_unit has this, but we don't always have access
 	 * to it...
 	 */
-	if (!want_demangle(dso__kernel(dso) || kmodule))
+	if (!want_demangle((dso && dso__kernel(dso)) || kmodule))
 		return demangled;
 
 	rust_demangle_demangle(elf_name, &rust_demangle);
@@ -338,7 +338,7 @@ static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
 			}
 			demangled = tmp;
 			if (rust_demangle_display_demangle(&rust_demangle, demangled, buf_len,
-							   /*alternate=*/false) == OverflowOk)
+							   /*alternate=*/true) == OverflowOk)
 				return demangled;
 		}
 		/* Buffer exceeded sensible bounds, return what is there. */
-- 
2.49.0.901.g37484f566f-goog

