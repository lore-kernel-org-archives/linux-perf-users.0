Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789A01373
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 00:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745973704; cv=none; b=N3oWqlPu9T9c4YZ5QvRXVaJONt+rnjJqiyic6bklfFesJQScF1iNsub6MVUdBCxQRUYiVBGg+22Xsa/pJdTnazH3Dk/aonWAkoKcb5pCh/SIK080aECazpctSAcfepJdABaOG9OuXmYeVrE0WBViv/gZ8FMN8Z0jbWj+7Z4R/YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745973704; c=relaxed/simple;
	bh=aQ8Ixb2ii7TM17c5CxHc/kZsrUa4Me1nM9JR+KWLbRA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gqqOmGWrEvYC4vwsSfP0UGtsfLnje2eHzZspnNWHNBfBNs2OiucZYzMFPUXJ/hlb/G9nZr6aeIq00HUok0A1cKPeiv1ov5a3IeqRmBEUEREkZpDW0l9VDLlzRvstzozKaqc0K7PNnANhDuX1x3RwJUw17D8PiJy5yWlRDwG1+Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pmvxetvA; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pmvxetvA"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b1442e039eeso3732496a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Apr 2025 17:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745973702; x=1746578502; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e1KMrryhTDqYQRcc+MhBf4Nju0O0E10cRTohQDGFkGY=;
        b=pmvxetvAX5sZV7/2/HiEwwwKtIl4NEgCdbbTwT9PYG1y72zDXeVY9cUSDGl5UycIxE
         uBb6dBzwblJhxkHppRcinXejNF97yEhE9sJQ/Xc19htP+OCXXkWY53T4mj6CzBSotSwj
         h5nFEOZxvr/XFrv8BAtvIgTWlAO0Fkz9OqPid+Xn9RQtBWG06WmeNxL+z1x795fLVU5l
         4Kd2Js40qdyti4Pqjba+8oASCTL98Pqd8JWlAk6e6f3jGgi+p2I17H9Q1nELreo+OTQ2
         /3Uj3ZbwT2GpUd0dO+dam4KnXrpDRpM/pcCtvm19hSyhiYqH8XVGNTHdBEBXebWu2vNI
         Rkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745973702; x=1746578502;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e1KMrryhTDqYQRcc+MhBf4Nju0O0E10cRTohQDGFkGY=;
        b=wDySFP1HoQqlJmQmcSwxwhmzTz36MPHomBuljDCEDvGhBPXlzc97I8JE7o2KvrOK1L
         Cwbzb9b3W9MBJd24WxZnsyWHr0bz4FHvNUXE9xlcVFKOutPcaMLe5Knh7QMFKgVKkswN
         203zD7/np7uN4A9VrjAZFELx59esrC5yUGWS2nuBAGfIWXknp+JXRQLjL6QU6vfOeWcs
         hhtVu/JhHhXCI4Q09GxZVRZRim27w07I4/BXdrtqji18Kmu4smkFVf2q2B43pQODOf6Z
         v2FLZE7MdOFzDGNBftk7Tsc2YXLQvYCmuKzBlOFlloiBvsNpxSwFqIVH8f2Pnr31VwwO
         J3SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtQq8H5eCwTTcDx24YPCgnfRhwALx07oywpwOfwJ5yXD+vt6DdTCF2hJJGL40NO2CnxjaQcxLvgqaFTceKsbM/@vger.kernel.org
X-Gm-Message-State: AOJu0YwVsFJGFAFxJbSivSSGraUDnp7h+lhlfF9OV4b0sI2SvBkdJMz/
	YYbKPRDsn6ERoW2+Jb3rU84bsYiEJjhawQcNJX+R0ijd0TGIowyfvVL9nhoYVINXA1KmbM22D/R
	aeb9KSw==
X-Google-Smtp-Source: AGHT+IH5AV8B/lmxOmO7bvKCtJ0Ps0gr6YLjC9VmSVrpHIqji0bGhb7vyMUNXXGmFCeguUAOJMfQk3WEI6qq
X-Received: from pfbfn23.prod.google.com ([2002:a05:6a00:2fd7:b0:740:555:f7af])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6f09:b0:1f5:70af:a32a
 with SMTP id adf61e73a8af0-20a88e1c278mr1607808637.32.1745973701640; Tue, 29
 Apr 2025 17:41:41 -0700 (PDT)
Date: Tue, 29 Apr 2025 17:41:24 -0700
In-Reply-To: <20250430004128.474388-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430004128.474388-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250430004128.474388-3-irogers@google.com>
Subject: [PATCH v2 2/6] perf symbol-elf: Integrate rust-v0 demangling
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

Use the demangle-rust-v0 APIs to see if symbol is Rust mangled and
demangle if so. The API requires a pre-allocated output buffer, some
estimation and retrying are added for this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build        |  5 +++-
 tools/perf/util/symbol-elf.c | 47 ++++++++++++++++++++++++++----------
 2 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 4f7f072fa222..7910d908c814 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -241,9 +241,12 @@ perf-util-y += cap.o
 perf-util-$(CONFIG_CXX_DEMANGLE) += demangle-cxx.o
 perf-util-y += demangle-ocaml.o
 perf-util-y += demangle-java.o
-perf-util-y += demangle-rust.o
+perf-util-y += demangle-rust-v0.o
 perf-util-$(CONFIG_LIBLLVM) += llvm-c-helpers.o
 
+CFLAGS_demangle-rust-v0.o += -Wno-shadow -Wno-declaration-after-statement \
+    -Wno-switch-default -Wno-switch-enum -Wno-missing-field-initializers
+
 ifdef CONFIG_JITDUMP
 perf-util-$(CONFIG_LIBELF) += jitdump.o
 perf-util-$(CONFIG_LIBELF) += genelf.o
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index fbf6d0f73af9..3fc87309746f 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -16,13 +16,14 @@
 #include "demangle-cxx.h"
 #include "demangle-ocaml.h"
 #include "demangle-java.h"
-#include "demangle-rust.h"
+#include "demangle-rust-v0.h"
 #include "machine.h"
 #include "vdso.h"
 #include "debug.h"
 #include "util/copyfile.h"
 #include <linux/ctype.h>
 #include <linux/kernel.h>
+#include <linux/log2.h>
 #include <linux/zalloc.h>
 #include <linux/string.h>
 #include <symbol/kallsyms.h>
@@ -308,6 +309,9 @@ char *cxx_demangle_sym(const char *str __maybe_unused, bool params __maybe_unuse
 
 static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
 {
+	struct demangle rust_demangle = {
+		.style = DemangleStyleUnknown,
+	};
 	char *demangled = NULL;
 
 	/*
@@ -318,21 +322,38 @@ static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
 	if (!want_demangle(dso__kernel(dso) || kmodule))
 		return demangled;
 
-	demangled = cxx_demangle_sym(elf_name, verbose > 0, verbose > 0);
-	if (demangled == NULL) {
-		demangled = ocaml_demangle_sym(elf_name);
-		if (demangled == NULL) {
-			demangled = java_demangle_sym(elf_name, JAVA_DEMANGLE_NORET);
+	rust_demangle_demangle(elf_name, &rust_demangle);
+	if (rust_demangle_is_known(&rust_demangle)) {
+		/* A rust mangled name. */
+		if (rust_demangle.mangled_len == 0)
+			return demangled;
+
+		for (size_t buf_len = roundup_pow_of_two(rust_demangle.mangled_len * 2);
+		     buf_len < 1024 * 1024; buf_len += 32) {
+			char *tmp = realloc(demangled, buf_len);
+
+			if (!tmp) {
+				/* Failure to grow output buffer, return what is there. */
+				return demangled;
+			}
+			demangled = tmp;
+			if (rust_demangle_display_demangle(&rust_demangle, demangled, buf_len,
+							   /*alternate=*/true) == OverflowOk)
+				return demangled;
 		}
+		/* Buffer exceeded sensible bounds, return what is there. */
+		return demangled;
 	}
-	else if (rust_is_mangled(demangled))
-		/*
-		    * Input to Rust demangling is the BFD-demangled
-		    * name which it Rust-demangles in place.
-		    */
-		rust_demangle_sym(demangled);
 
-	return demangled;
+	demangled = cxx_demangle_sym(elf_name, verbose > 0, verbose > 0);
+	if (demangled)
+		return demangled;
+
+	demangled = ocaml_demangle_sym(elf_name);
+	if (demangled)
+		return demangled;
+
+	return java_demangle_sym(elf_name, JAVA_DEMANGLE_NORET);
 }
 
 struct rel_info {
-- 
2.49.0.901.g37484f566f-goog

