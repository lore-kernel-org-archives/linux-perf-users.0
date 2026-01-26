Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC10226CE2C;
	Mon, 26 Jan 2026 20:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769459537; cv=none; b=mvGkmdHBoPnPsZQmcOOkJ+9KUcrW/l8omYR+JDOsejOGguA8dhc2ItM9DhmEdBKh3uTnEZ6NTS4HoxJA7XVqWYHyBhEx4Btwf0Dsq5hcepNQbNTSKAFzobFY5prMeVuxI9HPEgPakykyYe3uzuQeOeTR8WcPK1RnTCvfc38w4Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769459537; c=relaxed/simple;
	bh=WJH46dLRcVv1UNiwsRuEo5cd7wVEuA0Et7BaO9Ky2Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AZiAD43X66K57siSn2LFSKi0BtE63xVDJzgYgoZrbI4pa5LotoY6HniURizx1EC8Ox84eFnzaPl1z/DhYipK0iLXXLi4Hw5BHvlwUmLgJS/LE62B4qcmAN6gcK/GTBcXOyQGiQcxnrSiVrnpJT95ZHO4ehDJ631InBco0fHDZ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzMp2tyy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzMp2tyy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F31DC116C6;
	Mon, 26 Jan 2026 20:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769459537;
	bh=WJH46dLRcVv1UNiwsRuEo5cd7wVEuA0Et7BaO9Ky2Ls=;
	h=Date:From:To:Cc:Subject:From;
	b=QzMp2tyy3KEw+6RrEJAoLH4jtXHyMsWdK2GaZE2+r9z7DzPOgRUGHuB/PY4eKB1Y9
	 NDlHrEFqUQ+n0IZN2xe1Tbdo1K37Js1GpTbx/dyIu0SsJvvCNtyU+KdwCkqX0fnrPZ
	 Z/S1x7Hps0BtilCTAHAoHVkI6I8OQEcBaxltw40AHAjO7SUkpV6EqEpvjG4/s/D6xJ
	 A/e8pEq2ejeKOm4/h893dsBsn9f+lrYIUJ+we/ia2aa5VieSmHtfn/PK7MXlbHOnGs
	 8Fdvpk+teFvSZ/lJzcAN28EiDGyHVHQTKarzcM8fL7CHK3uqqQi+Bnqaa2xWlxOBrM
	 zV1YU0mbn57gA==
Date: Mon, 26 Jan 2026 17:32:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1 next] perf annotate: Fix BUILD_NONDISTRO=1 missing
 args->ms conversions to pointer
Message-ID: <aXfPTjbtnG7fXR8b@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix a few missing conversions to pointer in the usage of 'struct
annotate_args' 'ms' member in symbol__disassemble_bpf_libbfd().

Fixes: 00419892bac28bf1 ("perf annotate: Fix args leak of map_symbol")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/libbfd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index 79f4528234a9d6d5..63ea3fb53e77d5fb 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -501,7 +501,7 @@ int symbol__disassemble_bpf_libbfd(struct symbol *sym __maybe_unused,
 	struct bpf_prog_info_node *info_node;
 	int len = sym->end - sym->start;
 	disassembler_ftype disassemble;
-	struct map *map = args->ms.map;
+	struct map *map = args->ms->map;
 	struct perf_bpil *info_linear;
 	struct disassemble_info info;
 	struct dso *dso = map__dso(map);
@@ -612,7 +612,7 @@ int symbol__disassemble_bpf_libbfd(struct symbol *sym __maybe_unused,
 			args->line = strdup(srcline);
 			args->line_nr = 0;
 			args->fileloc = NULL;
-			args->ms.sym  = sym;
+			args->ms->sym = sym;
 			dl = disasm_line__new(args);
 			if (dl) {
 				annotation_line__add(&dl->al,
@@ -624,7 +624,7 @@ int symbol__disassemble_bpf_libbfd(struct symbol *sym __maybe_unused,
 		args->line = buf + prev_buf_size;
 		args->line_nr = 0;
 		args->fileloc = NULL;
-		args->ms.sym  = sym;
+		args->ms->sym = sym;
 		dl = disasm_line__new(args);
 		if (dl)
 			annotation_line__add(&dl->al, &notes->src->source);
-- 
2.52.0

