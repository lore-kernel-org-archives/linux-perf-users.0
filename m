Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BE014F98
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 00:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745973709; cv=none; b=PIwXp7jnWyX1AScRpExQxQcU/rpGUXEY2iHYEdYITk0kkORwpn7I9inXAuC/PPtKHRTAsKywx0dlmc+Qqj6ECQHXaa6nl4OT6mEs9Fnxl1PVY3pBsPzMkfijhkutSJcSedZo/w6k+7BcNqH1tBqFDWliVWvrkk1ASKVImskM4bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745973709; c=relaxed/simple;
	bh=kRagKt4OqPImjkKD1oQH895FmmrMksgLNhCNLEEIoOg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Px7D2Hb3cnXABxn8M7CIPvULp4GM1C02XVWw8ko/k4NOc5vXyNFUd1MprCsaUQL7pdRMCJI60kfqINJIILS8hVVEp+CXOT8+5U1nK2+fNTlPAYZ3u3eK8CdQidVJ10uEeMiMJ9e8gbDoI8yKm1//AAEFURqXFNGfSXE7oYMc9Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LkejbkSO; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LkejbkSO"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7369b559169so4180344b3a.1
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Apr 2025 17:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745973706; x=1746578506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/DAYr6PusLm+/+Qz98aPjWyLm+UNylxUX3Sur2p0ihA=;
        b=LkejbkSOhskRJTZxZNtipszg10QFRFkR35o6SZTAABD3EXnwkCzjqTm6VXMmzzQmmx
         KBNECEV5y6A8+ConvQIayLp8Wx93oz+I0a5Tc/iYzWLh6kiUiLE03z1nI9nj7TcEpnWJ
         WgPyKBoRNNVnXnFlg4BICKl7UG110OnENZCrwOQOMLwqNxy1fyIALA6VyczUncJ2xTgI
         we4qzl+mluburiMCHusD+0bqGn14IDbBjQGkIg8sIhQXM5cOEO/paa7H0NsF3Tnl7SOr
         +LljZmYNixg8BEr2Z8nfGQ7Vt7tcNYLmB51u7yBKtzK8oXvUS2Mn/uHdroUacuFPw6OU
         eAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745973706; x=1746578506;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/DAYr6PusLm+/+Qz98aPjWyLm+UNylxUX3Sur2p0ihA=;
        b=XXSqvDlB1WLB5yWqxxQKmmIcIhGs/Ec0gNkpRC1i76Ehu3R3Q+1J+wuPfolsM+p/x8
         iHoqjA2MzqXu2rFwwDYTIS+qwWHlcW4v8I9/XI3iEWkDB2fwfFH6R3FESujeVFWRpzyk
         dB6SIgUe1OXFegGHdmjgRMtEtq1LTSm8z4ZczROBUSC869xNgZCoq976MKS13XgvjVFr
         x7+PYYLTywhcdoPvxi4zSKuqfY6gPCSLDHm3vwpfDp2wUDvUXojLbtGvRfmNFTN7HjJS
         hLH+rI93JBahgpZ4btlt7p1IaAl2ZefbdUMIXeYabiMrRsWKjx5XFsFM/TKQhaSyYQSv
         PLfA==
X-Forwarded-Encrypted: i=1; AJvYcCVTzOnV14gX+0G0aGUYx82D0MvVzk9hhWYsFZqvgTAfOT0cD2vqe7o4GJaJV/Jtl4nBKsgWTaqGUFbuykHO3Ltx@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5jHEYBsLDi7e2Ao0Mvekzh+XMybnX2IHvrc/159wM/Xum8xwk
	bMK+y7Y3kGCaJTscwSJSFHAaWxtB8M6214tDrLmQL0lUGJVEjyNAcnL5mcL4INTCbhBVyWixC/g
	M/RDrow==
X-Google-Smtp-Source: AGHT+IEO+ew6JL7Wqcne+i8I/KZRO0kBvB5Ye1PoPyHG4SG+gdGNhCGDl1UPMLXblvyoaO7J3mijbEI7HL1d
X-Received: from pgbfq21.prod.google.com ([2002:a05:6a02:2995:b0:af2:3b16:9767])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:6681:b0:1f5:7873:304f
 with SMTP id adf61e73a8af0-20aa468608amr977493637.37.1745973706097; Tue, 29
 Apr 2025 17:41:46 -0700 (PDT)
Date: Tue, 29 Apr 2025 17:41:26 -0700
In-Reply-To: <20250430004128.474388-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430004128.474388-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250430004128.474388-5-irogers@google.com>
Subject: [PATCH v2 4/6] perf test demangle-rust: Add Rust demangling test
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
 tools/perf/util/symbol-elf.c             |  2 +-
 5 files changed, 78 insertions(+), 1 deletion(-)
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
index 000000000000..904f966c65d7
--- /dev/null
+++ b/tools/perf/tests/demangle-rust-v0-test.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
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
index 3fc87309746f..8734e8b6cf84 100644
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
-- 
2.49.0.901.g37484f566f-goog

