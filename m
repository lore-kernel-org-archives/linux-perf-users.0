Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9878D1FCFE7
	for <linux-perf-users@vger.kernel.org>; Sat, 23 Aug 2025 00:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909177; cv=none; b=NaENB89s876wUWOaiF+bnwoJhGR5gsTqCq96yK+h3ZJ/dwGIPRdyWGATcTM1nJ5ZA0jh7sSPVOi5qWtp2+tqxbY8VuvplpTIXi//STXik1Tnypqgu9wJsg7W3JmWp4zDCHWufhi8bGIiA1Ww7NmPI9rzajWcx8SHBc352p2MG6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909177; c=relaxed/simple;
	bh=oMNPPVuQWueuqeTaC6AVAq9hnK5DBHVL3OMBSxQCNXc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=AKPEW1ZYn/uBfjycrboDuupGqy69jONKYNO/eJPG7j5g7BccsiYb2TKSBOj2TfZ7l8zW5E12okyc4n1LwNWrmewp8LVzMOl1D4wIHf2xLrzoOJltdrUJE+2vZEaPq8SlChWhkgWj1zWWjqdsUIePIyfawjaWVhqPbbrK+/BsRXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0kQKZkQB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0kQKZkQB"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-246736043cfso5634005ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Aug 2025 17:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755909175; x=1756513975; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNiFno0XS+i9yOAQUiwWzS21Iglobe5u+DScZb3psQ8=;
        b=0kQKZkQBQb6uLI1TtotF5kQa9PuJVnjleSplklVRsoCWNDW96oEXo8on5OEfiIfxxq
         qMc6a9hZv0zWF9rT1JZj50EucRepyV16pnnZJKvBhdWJatP06yWYsfOUgYF9ShWq3AXa
         6jt7jzgpoUJK3HqQ4sjMUpan4BpQ0rraWvZNiUd5rjziOlNlOLne/CKb+LnoaDPI6+ks
         ZS9aYU/8LkHBYFLPAPonYy4YQRSrzhU9N93kxMu/7WtKXvcTcVlGQG2hnV/4CKqWioFy
         uJHUjp+93pz+NucZDcnPXdfCMwWVueXg9JiaGiOU34o+bgvTle6b/i7cBpirKzWQ/IYw
         nOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909175; x=1756513975;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNiFno0XS+i9yOAQUiwWzS21Iglobe5u+DScZb3psQ8=;
        b=wnerNPrKSR1yoesea7nnNmz7LlmsSpM2o/1WC+nHWTNoIeNPRXpNXFkHKKrobhxgr/
         ClKSV+naZ4w1N0ym2LdGTvUs4OFLTSd+jV44t6tW/rrHLJPG7uvgbVOTmitWTVZ8FWPS
         99Fy7KlpciqGw3KsqN1u0Qyusarq9DUfR1qLGwZ0GyvPWl/xwo3JZjfAkwh9sMLmJU2z
         li+FvsS3nZ0WNjbmqDWeg2YFst7+qae/ZfehefyUPN5hGbuV8K2rCsU5vtcGBsxTrv4/
         uGBVjVbi7jVwyqtCRNr2K465ImYzov3ePLqyJRillpOri7FchwwdKop9IRluFezNiGEK
         YBdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH2y+d1DwCOLLizsRbtbRrUKxpgvQc2dHTDJZHl9B5MPQLF/HxHOlSjfTLCiiSFOdbXlhEPIYn7hxCRWDw5GtV@vger.kernel.org
X-Gm-Message-State: AOJu0YwPAi0DMYsWa7w79MakyzQ3h0j/pZJKAoJmwY9KYJSHUAwxrBwm
	AibgttrbLBz+MHBDUiuIUQr9/9KOIBgsloqIgaXGG2og1JCfzssGvvoA+3tJIGz8Rbc5lQym/x9
	GYlZZ67NIGg==
X-Google-Smtp-Source: AGHT+IHyLv9syzy5lC6+KqrMJVbX4BQiVno/sGwJNoIqQ9CLYpfd/7+Vm5oy4fKcRhcoOhNH0ahMu23+toeX
X-Received: from plbme5.prod.google.com ([2002:a17:902:fc45:b0:235:6d5:688b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce81:b0:246:6446:8ae1
 with SMTP id d9443c01a7336-2466446a05cmr27382065ad.19.1755909174770; Fri, 22
 Aug 2025 17:32:54 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:32:08 -0700
In-Reply-To: <20250823003216.733941-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823003216.733941-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823003216.733941-13-irogers@google.com>
Subject: [PATCH v5 12/19] perf dso: Clean up read_symbol error handling
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ensure errno is set and return to caller for error handling. Unusually
for perf the value isn't negated as expected by
symbol__strerror_disassemble.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/capstone.c |  3 ++-
 tools/perf/util/dso.c      | 14 ++++++++++++--
 tools/perf/util/llvm.c     |  3 ++-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index 5aeae261f7ee..88e270237443 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -12,6 +12,7 @@
 #include "symbol.h"
 #include "thread.h"
 #include <dlfcn.h>
+#include <errno.h>
 #include <fcntl.h>
 #include <inttypes.h>
 #include <string.h>
@@ -463,7 +464,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	buf = dso__read_symbol(dso, filename, map, sym,
 			       &code_buf, &buf_len, &is_64bit);
 	if (buf == NULL)
-		return -1;
+		return errno;
 
 	/* add the function address and name */
 	scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 277c7e81f1c8..0f2051285393 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1831,6 +1831,7 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 
 	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE) {
 		pr_debug("No BPF image disassembly support\n");
+		errno = EOPNOTSUPP;
 		return NULL;
 	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO) {
 #ifdef HAVE_LIBBPF_SUPPORT
@@ -1849,6 +1850,7 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 		assert(len <= info_linear->info.jited_prog_len);
 #else
 		pr_debug("No BPF program disassembly support\n");
+		errno = EOPNOTSUPP;
 		return NULL;
 #endif
 	} else {
@@ -1859,26 +1861,34 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 			.ip = start,
 		};
 		u8 *code_buf = NULL;
+		int saved_errno;
 
 		nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 		fd = open(symfs_filename, O_RDONLY);
+		saved_errno = errno;
 		nsinfo__mountns_exit(&nsc);
-		if (fd < 0)
+		if (fd < 0) {
+			errno = saved_errno;
 			return NULL;
+		}
 
-		if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data, is_64bit) == 0) {
+		if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data, is_64bit) <= 0) {
 			close(fd);
+			errno = ENOENT;
 			return NULL;
 		}
 		buf = code_buf = malloc(len);
 		if (buf == NULL) {
 			close(fd);
+			errno = ENOMEM;
 			return NULL;
 		}
 		count = pread(fd, code_buf, len, data.offset);
+		saved_errno = errno;
 		close(fd);
 		if ((u64)count != len) {
 			free(code_buf);
+			errno = saved_errno;
 			return NULL;
 		}
 		*out_buf = code_buf;
diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index a28f130c8951..1607364ee736 100644
--- a/tools/perf/util/llvm.c
+++ b/tools/perf/util/llvm.c
@@ -9,6 +9,7 @@
 #include "srcline.h"
 #include "symbol.h"
 #include <dlfcn.h>
+#include <errno.h>
 #include <fcntl.h>
 #include <inttypes.h>
 #include <unistd.h>
@@ -365,7 +366,7 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	buf = dso__read_symbol(dso, filename, map, sym,
 			       &code_buf, &buf_len, &is_64bit);
 	if (buf == NULL)
-		return -1;
+		return errno;
 
 	init_llvm();
 	if (arch__is(args->arch, "x86")) {
-- 
2.51.0.rc2.233.g662b1ed5c5-goog

