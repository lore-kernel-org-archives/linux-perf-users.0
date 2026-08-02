Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BD23BBFA7;
	Sun,  2 Aug 2026 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785680859; cv=none; b=JtKqfGsV2zcv8nR1vxlY5Jm3wEzhKxAwW3DoKGjrUFqJ2jJOOKX/beckbB0JZuG9vR6F+VupQjhnmcR86FZT1jb9tj/sERz0E3hSyXjvRhg8D+8kswpwN7vlL/DaDQkly+O802sPpQY4UXPyrJhTHM3u3U4ekK76I4tfUIaTmQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785680859; c=relaxed/simple;
	bh=RssS8yXWgi99ltQFt5HsQBN1pUKisoH39b+GInwBNs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Es+pCas/W11ebkmmR00yI/PwVQ4Nn9yxahj6Jy15SKKvE2cDXweaTTWHICBrzOD651EamOb0cYbUhXEFx04GziXD300OwgXpuOws0i0Hkc1YsbK1p6gZ4PmsUXYDXxZKZvpla+MkM/00VCP/+3O0c9BQsyV9fdl762OhdJxY0rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neEzol0W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neEzol0W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70501F00A3A;
	Sun,  2 Aug 2026 14:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785680858;
	bh=UMPFYv9gvFZQWW2DITLYJDCibDQw6FEHiT9noD/oGKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=neEzol0WquA+aw9hSQ1vQNboZocNjacwd1T9m0VoYpKQ1ER9bCYXh/wDnCPebK+T3
	 McQ13L8VuGDqA8Pk1wJQNgwKY+ReBljglk5tuQUiQFU8uXl4/QnIli1ZcklycfgO6V
	 E4ajHnKux5EEj9r09w51gJTTiqT69VItmRIksE7UnEgTUP0eE0wD3H33+vwRSg+bpy
	 cG299zS/HMOKF2IccIh8uNKT+mcdGMyzbc4rjKZrCH4z0vpQKtDzeyvRUJPehLrrvk
	 DZxQhvf+vdZiK7inVNRXKm4ejVbxS8ze2Ez3yWaIK+6/7OinJO/f/AtETCdSh7mkul
	 yYsnVyRUBgMGg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Song Liu <songliubraving@fb.com>
Subject: [PATCH 4/4] perf libbfd: Fix memory leaks and NULL fclose in BPF disassembly
Date: Sun,  2 Aug 2026 11:27:12 -0300
Message-ID: <20260802142712.154726-5-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802142712.154726-1-acme@kernel.org>
References: <20260802142712.154726-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

symbol__disassemble_bpf_libbfd() has four resource management bugs:

1. free(prog_linfo) leaks internal arrays.  bpf_prog_linfo contains
   raw_linfo, raw_jited_linfo, nr_jited_linfo_per_func, and
   jited_linfo_func_idx pointers that are only freed by the proper
   destructor bpf_prog_linfo__free().

2. open_memstream(&buf, &buf_size) allocates a dynamic buffer that the
   caller must free after fclose().  The function calls fclose(s) but
   never free(buf), leaking the stream buffer on every call.

3. args->line = strdup(srcline) is immediately consumed by
   disasm_line__new(args) which internally calls strdup(args->line)
   again via annotation_line__init().  The first strdup result is then
   overwritten by args->line = buf + prev_buf_size without being freed.

4. If open_memstream() fails, the error path jumps to 'out:' which
   calls fclose(s) with s == NULL — undefined behavior.

Fix by using bpf_prog_linfo__free(), initializing buf to NULL, adding
free(buf) after fclose(s), guarding fclose() against NULL, and removing
the redundant strdup since annotation_line__init() makes its own copy.

Fixes: 6987561c9e86eace ("perf annotate: Enable annotation of BPF programs")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/libbfd.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index 0b7164f0e9fdbbed..33dc6158b2b1ffab 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -15,6 +15,7 @@
 #ifdef HAVE_LIBBPF_SUPPORT
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
+#include <bpf/libbpf.h>
 #endif
 #include <fcntl.h>
 #include <stdio.h>
@@ -510,7 +511,7 @@ int symbol__disassemble_bpf_libbfd(struct symbol *sym __maybe_unused,
 	char tpath[PATH_MAX];
 	size_t buf_size;
 	int nr_skip = 0;
-	char *buf;
+	char *buf = NULL;
 	bfd *bfdf;
 	int ret;
 	FILE *s;
@@ -620,7 +621,7 @@ int symbol__disassemble_bpf_libbfd(struct symbol *sym __maybe_unused,
 
 		if (!annotate_opts.hide_src_code && srcline) {
 			args->offset = -1;
-			args->line = strdup(srcline);
+			args->line = (char *)srcline;
 			args->line_nr = 0;
 			args->fileloc = NULL;
 			args->ms->sym = sym;
@@ -645,9 +646,12 @@ int symbol__disassemble_bpf_libbfd(struct symbol *sym __maybe_unused,
 
 	ret = 0;
 out:
-	free(prog_linfo);
+	bpf_prog_linfo__free(prog_linfo);
 	btf__free(btf);
-	fclose(s);
+	if (s) {
+		fclose(s);
+		free(buf);
+	}
 	bfd_close(bfdf);
 	return ret;
 #else
-- 
2.55.0

