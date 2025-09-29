Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED3228689B
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 19:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759172957; cv=none; b=LWmDySTB2rVbryLSPc1XKKQ/DB+3ChjJuOFiGAzT0ym4JUbFdP7SRTMFzrJWtItzQz5JrXafh1zyi5WVBwVWImdVYGz2ZViLBOdifekqxPHxVR+aAkQjIe//MCgADmhRjC8KWl73Zv3wBGlBdS44Aw1RpInNB9wXxM28guwEAhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759172957; c=relaxed/simple;
	bh=3x6uHsyrBbNmgRCRMDBpOpkaIRMxB51Rh5aACDVUbqQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=mt8+TOTVUvIPNGG4ljB+3XQ/gCpd0R4EeV2NUV7zvBlon1q25DqsCz2pfHAFYcdpeXb8DQACkMhhRFFpIpyEy0rSsX9Y9UJcyVcx6CmaLHjfdd1ythyDc9/anwI0B+rq95r6NZ1xNoVoxsOKWn/fbDUXjQ3A2ujaHXE/f7/jhzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qdnnRnic; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qdnnRnic"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-780fb254938so4265613b3a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 12:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759172955; x=1759777755; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3VdaBDHiSOtBGNqPCgDdEXCvLGYer8aP4O1DydDNh98=;
        b=qdnnRnic2peqJ5xGdkkmPK78qprcwpK+0tf9KckOr2j7TP5w6mb6wiHvWu3tzLmmX2
         Z0h95lC1oX41VTEUIcswf9BZJ+qJ9OFbTkVQ0rRO7WSTUw8OQTPjkYcGpvX2iRCcBFhw
         pn2iB5z5xJJGe+3qenwwqCwefOVOUP7KyrA9ZYTexiB4qhBZM2tWTix7TWn984njINrS
         QKaIxdA/iYZxuDFTuLgT6rglQOkd1V0G7AiXAr/HzLaAG78D2ivwALM3HGl9Tw4i+Me3
         AQrChhFDoOVtuvFaG3rVDTNWEgMC9+yNwU7BFj7uVqdLaPphaiToEeG3sCtvGVaoxIY4
         Lf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759172955; x=1759777755;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3VdaBDHiSOtBGNqPCgDdEXCvLGYer8aP4O1DydDNh98=;
        b=AQ77MNiuDS78TsjFxcNAPEY68AfdckQkG3dGlabfMdJVqdwMOpiAF3/2cwD7v0FY8Z
         WN4FyhqHmHLUj4DrS909pDPZJH49tH3EJzOpQ3dWK8teWxNkq6b8DYyJGRvqd0IYtv2Y
         yNDx9FCAFB2lcqif8SyOUOJhYbaKhExSHkMwuXZyI1tQHVx6t0Wod0RRAsUEukwEby4F
         iDUA9pR5ZpI0mNW9SzLiXl4nqUYEALFYmToR5MfWw2zQdnD1bbWoHyhaWFm+SAuEDS6j
         yGlFxKofq452mVsMKk2HMtatzpSbhe/G/pFEZR0BThZnPauHVVKdPELRkbuEC4vqG68t
         wOCA==
X-Forwarded-Encrypted: i=1; AJvYcCWuAIh/NBTtQ+UIcPlZ1k5VSf0OXauJj/T8AknTtG8Yan80piQD18ny/s0HDMltq2GcFN87Bw33lI8a1eUfaqul@vger.kernel.org
X-Gm-Message-State: AOJu0YwCKX4iL/Sj2Jf5yIuNAjCA2eyJFyzbxRInaC0wGKEAo8Roxy/M
	Y4PW2s5xNV6XZzQ4LTTMz7hXtGALwSFupKrEHzQL/JGnCS9r+aVozHg9nCldb5bbsGHTU3u6N0Z
	tsopVtZj38w==
X-Google-Smtp-Source: AGHT+IFGhoOWjQgkF0L/NciS7Xfc7ntjSvsp7meQoiLbtTvTPGEmfOtvs2UKevw6zAF7rh0zR61UX/7++OhU
X-Received: from pgng22.prod.google.com ([2002:a63:3756:0:b0:b56:3de0:d767])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12cb:b0:2d9:b2ee:7855
 with SMTP id adf61e73a8af0-2e7d7c04d2dmr19511013637.51.1759172954887; Mon, 29
 Sep 2025 12:09:14 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:08:02 -0700
In-Reply-To: <20250929190805.201446-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250929190805.201446-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.570.gb178f27e6d-goog
Message-ID: <20250929190805.201446-13-irogers@google.com>
Subject: [PATCH v6 12/15] perf dso: Clean up read_symbol error handling
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
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
2.51.0.570.gb178f27e6d-goog

