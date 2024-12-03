Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB2E1F75AB;
	Tue,  3 Dec 2024 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733260818; cv=none; b=p7/BrShKT1OCV5W/EGq3f9WiBEXhzQeErrcnhgpaqq7hjTKLazTuocqdH8XlQI43NBiJuWmvRJSzP2ikNqhGJ3XkZntbfXLECGEliyhXfKmujDDX2Ap0ik8uxtmL/BDTi8nIvJ8lDW9pL6l6bd2xFcJvcVE5GEjulF0l9TY/r+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733260818; c=relaxed/simple;
	bh=cPMvh73fw4oUAnM1Wq+H1USVK8TY/X6SMWmynwXaBOs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZFrV7tuWkffUwwTMQLeUU8mn4YVHRjoXCMEH4KCwY39zFslBRMNv0GqO+fZpntcj4E3OB6EiV3NhwT5GN7mMVUBGBftEhXDKyRNRZI/9QKEW78vg4To1y3g8bcOya61EoZ7R800o6496VDt6aGg75dlvKAbWEK4/U/RDnZ9/eAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxLnzLW7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxLnzLW7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC84BC4CED6;
	Tue,  3 Dec 2024 21:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733260818;
	bh=cPMvh73fw4oUAnM1Wq+H1USVK8TY/X6SMWmynwXaBOs=;
	h=Date:From:To:Cc:Subject:From;
	b=jxLnzLW7XynIWEPw3g5CrlrLVAQB9SoUm+2eskatKdG8jIjDwX0OX/XzhhFwFXvVF
	 QVrMht1NYZGGvAhwKGHyW6e8JjsFg/F7y0k/ZswnyxTQePrfeVxXYaPAm1inCw/mem
	 I5eWi4j3glKpufK36cZDgqHfNs4MtZeJ/4MAXZxYjV9+sy3QNwaO/Nt9OpUqgntY5t
	 15j7X3uYRxDkpxtIg5OAcOdMQxPxYuLpO7X5rmNmftO8qQusopa7EeD7/584cXqKzo
	 OCctSxtROby+F3D1oqCg9UcI7bsICP/0ykpP0SrdCX/PR1Ug6gEj7mh54QhegWKlJD
	 zfmAsoc6q0/SQ==
Date: Tue, 3 Dec 2024 18:20:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Francesco Nigro <fnigro@redhat.com>, Ilan Green <igreen@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1 perf-tools-next] perf disasm: Return a proper error when
 not determining the file type
Message-ID: <Z092D9-r_iOgwIWM@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Before:

  ⬢ [acme@toolbox a]$ perf annotate --stdio2 -i acme-perf-injected.data 'java.lang.String com.fasterxml.jackson.core.sym.CharsToNameCanonicalizer.findSymbol(char[], int, int, int)'
  Error:
  Couldn't annotate java.lang.String com.fasterxml.jackson.core.sym.CharsToNameCanonicalizer.findSymbol(char[], int, int, int):
  Internal error: Invalid -1 error code
  ⬢ [acme@toolbox a]$

After:

  ⬢ [acme@toolbox a]$ perf annotate --stdio2 -i acme-perf-injected.data 'java.lang.String com.fasterxml.jackson.core.sym.CharsToNameCanonicalizer.findSymbol(char[], int, int, int)'
  Error:
  Couldn't annotate java.lang.String com.fasterxml.jackson.core.sym.CharsToNameCanonicalizer.findSymbol(char[], int, int, int):
  Couldn't determine the file /tmp/perf-3308868.map type.
  ⬢ [acme@toolbox a]$

Reported-by: Francesco Nigro <fnigro@redhat.com>
Reported-by: Ilan Green <igreen@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.h | 1 +
 tools/perf/util/disasm.c   | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 194a05cbc506e4da..c6a59aaefdb8b3a1 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -441,6 +441,7 @@ enum symbol_disassemble_errno {
 	SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_REGEXP,
 	SYMBOL_ANNOTATE_ERRNO__BPF_INVALID_FILE,
 	SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF,
+	SYMBOL_ANNOTATE_ERRNO__COULDNT_DETERMINE_FILE_TYPE,
 
 	__SYMBOL_ANNOTATE_ERRNO__END,
 };
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 41a2b08670dc5b0e..b7de4d9fd0045d71 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1245,6 +1245,9 @@ int symbol__strerror_disassemble(struct map_symbol *ms, int errnum, char *buf, s
 		scnprintf(buf, buflen, "The %s BPF file has no BTF section, compile with -g or use pahole -J.",
 			  dso__long_name(dso));
 		break;
+	case SYMBOL_ANNOTATE_ERRNO__COULDNT_DETERMINE_FILE_TYPE:
+		scnprintf(buf, buflen, "Couldn't determine the file %s type.", dso__long_name(dso));
+		break;
 	default:
 		scnprintf(buf, buflen, "Internal error: Invalid %d error code\n", errnum);
 		break;
@@ -2289,7 +2292,7 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE) {
 		return symbol__disassemble_bpf_image(sym, args);
 	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND) {
-		return -1;
+		return SYMBOL_ANNOTATE_ERRNO__COULDNT_DETERMINE_FILE_TYPE;
 	} else if (dso__is_kcore(dso)) {
 		kce.addr = map__rip_2objdump(map, sym->start);
 		kce.kcore_filename = symfs_filename;
-- 
2.47.0

