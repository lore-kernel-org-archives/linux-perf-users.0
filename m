Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61782C0323
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Oct 2025 21:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759699353; cv=none; b=gwUeblAEkyACX/FfyWyxQd1eQ7Erd807tL4SI6g7BFfiiWjLKahhNmdZqIl/Wy/+8bMaohQnRsnUv3QePr1Gc1z8MiyX30QB4auJuOIhWAWj5lEdgZOta7L6LNR82UoBWAxmqSc5ZZtgFMGNZkFuliLOCQvBACpGMW7Pcq6Eu4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759699353; c=relaxed/simple;
	bh=Apk/dx4vry6NQH8mEaGDTQ4foAvl3cC+7BrNRcZnR4k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=rbLVBrGnXX9I6etXoY5QoNTZYBzHZurzCC3Ew7HQrx/BYSvOcJQqIwfI1qdf7iCs2kGHmM+Tq2Hl6hWQKeFTfl9dwwMu0cJvU50j/pzZJseNL8cPRw33UaMx1i9LVGAb3wiqdlkFMjQzNfupRUDlIC236VAlaF5K+B4cVrIfqPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qojujbkf; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qojujbkf"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5527f0d39bso5328775a12.2
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Oct 2025 14:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759699351; x=1760304151; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DCU0ELaC9EV+pXq9bhGKOQtESKkLJzIPHgh+H1HErVM=;
        b=QojujbkfO5KiFAtldBpCsGcEmNRwxdIk1ERELte4Y78gihIoIZsWvq3zjLPWPIO6X8
         4otoWE+vzvRAnp+8Sn9v9DtNO/VsHqRMg2kSpmWLSOJSsOyTbt+bP82ELLcdLeA17kly
         5aPIa4j8KsdsXiL1yo67669f5H5GLMk1rTACliY47QtjYAo18DbyLwVeiwTrhFsnlutO
         HeyG/jvvY6UI6mHzN0afI2CIGDdSLdkOdpam7C4YB7zxOAZkx4wkB/j7Hs7qBbjJZMdI
         hhNb4ucf1GFO3ksVowYg0iDJwlGMtRb1TsMgsDACje2N239YlZFQ3d3Fage0IqFGtoU/
         bo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759699351; x=1760304151;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCU0ELaC9EV+pXq9bhGKOQtESKkLJzIPHgh+H1HErVM=;
        b=PtfQNLma4JmFYV6ayB3VxbpJVaRDVpveFPgW0+V1zEo5QfVE3Oa0Nrbql86xiUHI7u
         EuC3nH+KTc2J2UpLvu2ck28H2SBXM5b7DAe4r0Hy0IrwCgchnjxMQNhwZUOmo4fWAIDh
         /wZJMMZQsuYkrkrcPVO1CBwiCQgvGUmvEnBF/ZIFJt8uOz9FUqPHJc57tQRkg1HQdiZa
         r9M0XcKII16lzedPAVVqi9K8AE+ffXUilE6dh6xphIt8CH12rsG8KaX9r7ES49xZMftg
         p5erZ+z0wP1EfJTMN7Qde2iNlYXEPcD8F1m7T+DexsHLNcDpoxMj56l0Kcz+TF6LKNm+
         x7gg==
X-Forwarded-Encrypted: i=1; AJvYcCXPapHPvZvr/nXA653gP2RzbBG344knQH4LQ4HKBEQJ2/6kzh0hCVcNBZDq1eYQPyN5Gv1yPEhn2SKmjrug/GRa@vger.kernel.org
X-Gm-Message-State: AOJu0YzjHBUi34GGUujBvrXq3EI76SnaslRugb+/GBrYxhl0F1+u75DG
	0IPVsif3iW3xG47khISOtj3dYmcrdHxYbSuXkSimvILv+lv5a3Ih1r3Lr4BbNk1L2Fjejx1wWta
	aFUIRuFg8NA==
X-Google-Smtp-Source: AGHT+IEObakE2dl7ZB3J7e6NcFFPXma/CZs3oBgvcFiNAqIU+hl2VJBrud9gEmmuxGfQ8861tRaCUUzuXCrN
X-Received: from plpa4.prod.google.com ([2002:a17:902:9004:b0:28e:804c:cc96])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2b04:b0:27e:ed58:25e5
 with SMTP id d9443c01a7336-28e9a5b037fmr121304265ad.24.1759699351184; Sun, 05
 Oct 2025 14:22:31 -0700 (PDT)
Date: Sun,  5 Oct 2025 14:22:06 -0700
In-Reply-To: <20251005212212.2892175-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005212212.2892175-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005212212.2892175-6-irogers@google.com>
Subject: [PATCH v7 05/11] perf dso: Clean up read_symbol error handling
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Collin Funk <collin.funk1@gmail.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Ensure errno is set and return to caller for error handling. Unusually
for perf the value isn't negated as expected by
symbol__strerror_disassemble.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/capstone.c |  3 ++-
 tools/perf/util/dso.c      | 15 ++++++++++++---
 tools/perf/util/llvm.c     |  3 ++-
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index c23df911e91c..be5fd44b1f9d 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -11,6 +11,7 @@
 #include "print_insn.h"
 #include "symbol.h"
 #include "thread.h"
+#include <errno.h>
 #include <fcntl.h>
 #include <string.h>
 
@@ -245,7 +246,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	buf = dso__read_symbol(dso, filename, map, sym,
 			       &code_buf, &buf_len, &is_64bit);
 	if (buf == NULL)
-		return -1;
+		return errno;
 
 	/* add the function address and name */
 	scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 0aed5c8691bd..344e689567ee 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1827,26 +1827,33 @@ static const u8 *__dso__read_symbol(struct dso *dso, const char *symfs_filename,
 		.ip = start,
 	};
 	u8 *code_buf = NULL;
+	int saved_errno;
 
 	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 	fd = open(symfs_filename, O_RDONLY);
+	saved_errno = errno;
 	nsinfo__mountns_exit(&nsc);
-	if (fd < 0)
+	if (fd < 0) {
+		errno = saved_errno;
 		return NULL;
-
-	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data, is_64bit) == 0) {
+	}
+	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data, is_64bit) <= 0) {
 		close(fd);
+		errno = ENOENT;
 		return NULL;
 	}
 	code_buf = malloc(len);
 	if (code_buf == NULL) {
 		close(fd);
+		errno = ENOMEM;
 		return NULL;
 	}
 	count = pread(fd, code_buf, len, data.offset);
+	saved_errno = errno;
 	close(fd);
 	if ((u64)count != len) {
 		free(code_buf);
+		errno = saved_errno;
 		return NULL;
 	}
 	*out_buf = code_buf;
@@ -1875,6 +1882,7 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 		 * Note, there is fallback BPF image disassembly in the objdump
 		 * version but it currently does nothing.
 		 */
+		errno = EOPNOTSUPP;
 		return NULL;
 	}
 	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO) {
@@ -1895,6 +1903,7 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 		return (const u8 *)(uintptr_t)(info_linear->info.jited_prog_insns);
 #else
 		pr_debug("No BPF program disassembly support\n");
+		errno = EOPNOTSUPP;
 		return NULL;
 #endif
 	}
diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index 0369f3adcdb6..2351393e33c5 100644
--- a/tools/perf/util/llvm.c
+++ b/tools/perf/util/llvm.c
@@ -7,6 +7,7 @@
 #include "namespaces.h"
 #include "srcline.h"
 #include "symbol.h"
+#include <errno.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <linux/zalloc.h>
@@ -147,7 +148,7 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	buf = dso__read_symbol(dso, filename, map, sym,
 			       &code_buf, &buf_len, &is_64bit);
 	if (buf == NULL)
-		return -1;
+		return errno;
 
 	init_llvm();
 	if (arch__is(args->arch, "x86")) {
-- 
2.51.0.618.g983fd99d29-goog

