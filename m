Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60861361DA6;
	Wed, 10 Jun 2026 19:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121194; cv=none; b=PxwVtZeClZt4+fUFZ5E8fSIPbPQkCMuq7jLxdksrp8uwNJYLiBCSyJH4TX4H+YDDSzS4B7BIaWpEitdGNUDIL8cDmmgcRSPlS+BO7B1us82AWzA+QuJ3Zc6X6RbbzhUpJswlj54wD+1LNf/jBly6V1UNAHFK/NWzKgx7dDVilV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121194; c=relaxed/simple;
	bh=WU7DtfkJZsyTLdQftYMMWO+Mk9o+14gW1KLW1vrj9t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bB3CcJrPwWSMrwVPDQ/EwjgkODPvjJSUs6/xoU/Lrbnyy7ON/Fgb/EhmX+/Y1ni5g1z+EfLN4Uixq6eEult67fPRb6hYnTD/L/NrdLj5A/AGoJ0Xv2OpixQMqFiCxhgPPiC4gqXdnfi9XkxOqG4IUsto1SNEVB/PPHvsLV6CLgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cl0wxkSH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cl0wxkSH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4D21F00893;
	Wed, 10 Jun 2026 19:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121192;
	bh=mO4WLzxhes8QL5fiZbyvU5vhqNwlslk/CADkpNboLAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cl0wxkSHflqPTuvSadh9zdMvsz6VqhESuWd90LQ5YV72kROqnrxMxDW26rx11Nh3i
	 1QQI3XHiOTlX2QrnoqcklDma2EgcLfkoz9WfmObomPJ5yuKV5CJXX1iMLFSL15zJ/R
	 uPl5SK3LJvYcPD7OBv0vWsigKdrTlZ87hTyudWeKC/OQbZ64pSChGKEyOy2G9YBLXz
	 uejrDvgDI9U1c9fecfzyIqvoDLhwonRvlrwDzTYG+lVb7OWSL5CFyGHeN/9bzFJmBd
	 q9SXI3QU+L+jPnuyh1fU9RpoE+j8Ma5sJsMRNhajr6QT2ypHi2dFsmDG6I8tne8BPm
	 Yf2ez+blNS11w==
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
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 13/23] perf tools: Fix uninitialized pathname on uncompressed fallback in filename__decompress()
Date: Wed, 10 Jun 2026 16:51:46 -0300
Message-ID: <20260610195157.2091137-14-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610195157.2091137-1-acme@kernel.org>
References: <20260610195157.2091137-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

filename__decompress() has an early return path for files that are not
actually compressed.  This path returns the fd from open() directly but
never writes to the pathname output parameter, leaving the caller with
an uninitialized buffer despite a successful return.

Callers like dso__decompress_kmodule_path() pass pathname to
decompress_kmodule() which uses it to set the decompressed file path.
If pathname is uninitialized, subsequent operations on the path produce
undefined behavior.

Fix by copying the original filename to pathname before the early return,
matching the behavior of the normal decompression path.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Fixes: 7ac22b088afe26a4 ("perf tools: Add filename__decompress function")
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/code-reading.c |  7 +++++--
 tools/perf/util/disasm.c        |  7 +++++--
 tools/perf/util/dso.c           | 12 +++++++++---
 tools/perf/util/symbol-elf.c    |  6 ++++--
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 47043a3a2fb4f833..e82ecdc9577785e8 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -471,8 +471,11 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 			goto out;
 		}
 
-		decomp = true;
-		objdump_name = decomp_name;
+		/* empty pathname means file wasn't actually compressed */
+		if (decomp_name[0] != '\0') {
+			decomp = true;
+			objdump_name = decomp_name;
+		}
 	}
 
 	/* Read the object code using objdump */
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 59ba88e1f7443c02..0a1a7e9cf3efee3e 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1577,8 +1577,11 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		if (dso__decompress_kmodule_path(dso, symfs_filename, tmp, sizeof(tmp)) < 0)
 			return -1;
 
-		decomp = true;
-		strcpy(symfs_filename, tmp);
+		/* empty pathname means file wasn't actually compressed */
+		if (tmp[0] != '\0') {
+			decomp = true;
+			strcpy(symfs_filename, tmp);
+		}
 	}
 
 	/*
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index ee06a252a54d338d..6a34717c9f31f18d 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -343,8 +343,11 @@ int filename__decompress(const char *name, char *pathname,
 	 * To keep this transparent, we detect this and return the file
 	 * descriptor to the uncompressed file.
 	 */
-	if (!compressions[comp].is_compressed(name))
+	if (!compressions[comp].is_compressed(name)) {
+		if (pathname && len > 0)
+			pathname[0] = '\0';
 		return open(name, O_RDONLY | O_CLOEXEC);
+	}
 
 	fd = mkostemp(tmpbuf, O_CLOEXEC);
 	if (fd < 0) {
@@ -598,8 +601,11 @@ static char *dso__get_filename(struct dso *dso, const char *root_dir,
 			goto out;
 		}
 
-		*decomp = true;
-		strcpy(name, newpath);
+		/* empty pathname means file wasn't actually compressed */
+		if (newpath[0] != '\0') {
+			*decomp = true;
+			strcpy(name, newpath);
+		}
 	}
 	return name;
 
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 06cfb84f86eb2f64..10902a5dc6dbe6cc 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -920,12 +920,14 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 			return -1;
 		}
 		close(fd);
-		filename = path;
+		/* non-empty path means a temp file was created */
+		if (path[0] != '\0')
+			filename = path;
 	}
 
 	err = read_build_id(filename, bid);
 
-	if (m.comp)
+	if (m.comp && filename == path)
 		unlink(filename);
 	return err;
 }
-- 
2.54.0

