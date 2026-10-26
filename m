Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792997467;
	b=ec2WFbeZozOgFGXjxxVPgferbcvqkpjcV+xCMHC5cHbTNlhugSbWvcfxd1FaIIV5hzXx
	 W5OIeCQrpDYUy4/WBsQ6nCFYTLwgE5RHK1P92GLsSkEjZNnitGE8vCOJWFO+nQA8KRg3G
	 F+gl7YOyy25E11/Kziu7QK9wsax1+oLu5TLGAnNlV2DXZLwTsWfnDiH3XVKueRXC66RHE
	 b3ioZjvjLpDb4rDn5wCyTipMFkNVPqrVtygeJC9ruBah+EMuHbEW3iZLw0KcFttnHC1Q9
	 HbbhEzHWBn67bZx8XGhcAPO0J5hW9aZX8MnaSGtcY/vGNLWEo97qCI1/lH7HzLF4BtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792997467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=HJ/ko24xNUw7f4THn9eSHgX5xHebsEMU8p6tkMkx2vY=;
	b=gXZlbLe25J5ciJpHDGnHeDqcaqGCkOnQOc/R8/G7QK7Wp0fjOCtKsv/OqKwv3vRewwox
	 nMK6E9lLFG9+xVxrG1J/CPB2q11AcIc2LdN6mwNGBgl6gPmP+lUefGILSfMaDouXjOPHu
	 09VMcTXITZtzydqALJA/tOGHj++0lkzfRNMAhB2Q5S2ZEK3yEhF5oBvL6/cxsPJiTJr+z
	 qzX7DWV0gaVsJTghrMyp6s0jwErjWAoDcdR7g0widWoPqloym6BV/OOY/3TjlGP0UtgDM
	 +oBvAuvPjgzZHEubn5rkgsSUY4FK/dFo6644mofdqBpQbrLVSmBeI5OVVy1M5H2CC+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fRwJkYix;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D76606A323
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 06:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5D76606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fRwJkYix
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35cbea41088so4504049eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 23:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792997466; x=1793602266; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HJ/ko24xNUw7f4THn9eSHgX5xHebsEMU8p6tkMkx2vY=;
        b=fRwJkYixrjvWqCGaUEnetIcGphq0OlE6LrIHAZRs+qr48oCbbYVYRhVuzoAOwwOrht
         GYxrnho+ZyRIIx0qqLDDBvfz2Vix7d4JMoYFHWcyXH9lDwcjC+iTnfKGvy+crNOcGzBS
         xOqD3WP9eIHTuu6HNp/YSLFf552i33Fafh7I8H7hs0Wzittm/uxNietJAK93itLm6YEX
         YcpkcNqz7zaxP1W7sPSxhUrW1/Z1PLOZhVhWsnlzm4fxOAAH75LQVyS1AST8hI2ExqTi
         8LpY0BPDYSBQmlMkFC/Ez8iGI9qa49tJvopytmV9Vnx8Ats+vDzxgjMYRmO+uyuyyhPc
         VJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792997466; x=1793602266;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HJ/ko24xNUw7f4THn9eSHgX5xHebsEMU8p6tkMkx2vY=;
        b=1pLpfmtayLRrM6YGTEut5Ru7uF4aQpb2tKhyz1RcXb3FFqvhtYpVQoIvBos2btTi0s
         emz+x5risfGNWEpKwlKt4uy3RQ+/EOUzvsvbtd4iTHAfQZS2C1Gar7LqHTChl2XY7wTa
         lj+fg2aXlt0FEeiJbzghtKPuSX4v6ynOaplZvrkRwBJ0j0oW3r7FO0OXtEX2z/1Xr+Z8
         UFlnx/tcAoqUHzNL94aNwMnVu6D7iIrEGJwBgRDS4qM+3n8OAlexlGRJCnkUgIIHk8Dt
         c0CAY8OKcFeUVEJPsEn/+pAB716QifHoN9kmAtx8wZq6oWvICKc3fZWb8XvW5/ePkXGu
         KHyA==
X-Forwarded-Encrypted: i=1; AKwUvByp5FHFKhAPpzm+zW8ziCM/56Piyg6p474EH29u6UGyOJOqLwCzRJ670A72MqG7gxEEaP+Ez43T+Syizi7YyTzn@vger.kernel.org
X-Gm-Message-State: AFq9FYI4xQNcal+WtSlA5WTM+HHJdxjKzk1NWTXMN1LiSU9NPRHRd52m
	5nfhjHfW/zCKBe/kktiPChMptxdvQbWTOUzaLGf/+gr1HHqTYHGxC2OfvaZ4nodtf+VvE1+69i8
	B/qHBNk5wxQ==
X-Received: from dldyr13-n1.prod.google.com ([2002:a05:701b:450d:10b0:197:f679:f62d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8352:b0:35a:5153:ab24
 with SMTP id 5a478bee46e88-369e845b07emr6600704eec.9.1792997465537; Sun, 25
 Oct 2026 23:51:05 -0700 (PDT)
Date: Sun, 25 Oct 2026 23:50:43 -0700
In-Reply-To: <cover.1792995775.git.irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <cover.1792995775.git.irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <6cb3acf7a54ed1638ce0172a79c7e3263be17780.1792995775.git.irogers@google.com>
Subject: [PATCH 1/3] perf libdw: Optimize fallback logic for missing DWARF
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alessio Podda <aleph.pi.gh@gmail.com>, Michael Liang <mliang@purestorage.com>, 
	Shimin Guo <shimin.guo@skydio.com>, Tanushree Shah <tshah@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When libdw encounters a DWARF definition it cannot accurately un-inline
or an address block natively missing structural line maps,
dwfl_module_getsrc() returns NULL. Previously, libdw__addr2line()
returned -1 in both dwfl_module_getdwarf() and dwfl_module_getsrc()
failure paths while addr2line() in srcline.c only stopped its fallback
loop on ret > 0. This caused perf's addr2line_style loop to fall back to
llvm, libbfd, and the cmd__addr2line() subprocess wrapper on every
unmapped address or stripped DSO.

Update the addr2line_style pipeline return semantics consistently:
1. Backends return 0 to denote conclusively missing information
   (e.g. valid ELF but no DWARF inside, or parsed DWARF with no mapped
   lines), stopping the fallback loop.
2. Backends (and uncompiled stubs) return < 0 to denote initialization
   or backend errors, instructing the loop to iterate to the next
   configured fallback.
3. Backends return > 0 on successful source line resolution.

Fixes: bf96e296d52d ("perf libdw: Fix Dwfl discovery with split files")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/addr2line.c        | 28 ++++++++++---
 tools/perf/util/dso.h              |  2 +-
 tools/perf/util/libbfd.c           |  6 +--
 tools/perf/util/libdw.c            | 25 ++++++++---
 tools/perf/util/libdw.h            |  5 ++-
 tools/perf/util/llvm-c-helpers.cpp | 66 +++++++++++++++++++-----------
 tools/perf/util/llvm.c             | 12 ++++--
 tools/perf/util/srcline.c          | 21 +++++++---
 8 files changed, 115 insertions(+), 50 deletions(-)

diff --git a/tools/perf/util/addr2line.c b/tools/perf/util/addr2line.c
index 6f64f6b42442..960dd48701bb 100644
--- a/tools/perf/util/addr2line.c
+++ b/tools/perf/util/addr2line.c
@@ -298,6 +298,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 	struct io io = { .eof = false };
 	enum cmd_a2l_style cmd_a2l_style;
 	const char *current_dso_name;
+	bool a2l_synced = false;
 
 	mutex_lock(dso__lock(dso));
 	current_dso_name = dso__symsrc_filename(dso) ?: dso_name;
@@ -316,11 +317,14 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 	if (a2l == NULL) {
 		if (!symbol_conf.addr2line_disable_warn)
 			pr_warning("%s %s: addr2line_subprocess_init failed\n", __func__, dso_name);
+		ret = -1;
 		goto out_unlock;
 	}
 	cmd_a2l_style = cmd_addr2line_configure(a2l, dso_name);
-	if (cmd_a2l_style == BROKEN)
+	if (cmd_a2l_style == BROKEN) {
+		ret = -1;
 		goto out_unlock;
+	}
 
 	/*
 	 * Take ownership of the a2l subprocess so we can safely perform
@@ -344,6 +348,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 	if (written != len) {
 		if (!symbol_conf.addr2line_disable_warn)
 			pr_warning("%s %s: could not send request\n", __func__, dso_name);
+		ret = -1;
 		goto out;
 	}
 	io__init(&io, a2l->out, buf, sizeof(buf));
@@ -353,6 +358,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 	case -1:
 		if (!symbol_conf.addr2line_disable_warn)
 			pr_warning("%s %s: could not read first record\n", __func__, dso_name);
+		ret = -1;
 		goto out;
 	case 0:
 		/*
@@ -373,6 +379,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 			break;
 		case 0:
 			/* The sentinel as expected. */
+			a2l_synced = true;
 			break;
 		default:
 			if (!symbol_conf.addr2line_disable_warn)
@@ -388,17 +395,23 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 
 	if (file) {
 		*file = strdup(record_filename);
-		ret = 1;
+		if (!*file) {
+			ret = -ENOMEM;
+			goto out;
+		}
 	}
 	if (line_nr)
 		*line_nr = record_line_nr;
+	ret = 1;
 
 	if (unwind_inlines) {
 		if (node && inline_list__append_record(dso, node, sym,
 						       record_function,
 						       record_filename,
 						       record_line_nr)) {
-			ret = 0;
+			if (file && *file)
+				zfree(file);
+			ret = -ENOMEM;
 			goto out;
 		}
 	}
@@ -421,12 +434,17 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 						       record_function,
 						       record_filename,
 						       record_line_nr)) {
-				ret = 0;
+				if (file && *file)
+					zfree(file);
+				inline_node__clear_frames(node);
+				ret = -ENOMEM;
 				goto out;
 			}
 			ret = 1; /* found at least one inline frame */
 		}
 	}
+	if (record_status == 0)
+		a2l_synced = true;
 
 out:
 	mutex_lock(dso__lock(dso));
@@ -434,7 +452,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 	free(record_filename);
 
 	current_dso_name = dso__symsrc_filename(dso) ?: dso__long_name(dso);
-	if (!io.eof && dso__a2l(dso) == NULL && current_dso_name &&
+	if (a2l_synced && !io.eof && dso__a2l(dso) == NULL && current_dso_name &&
 	    !strcmp(current_dso_name, dso_name))
 		dso__set_a2l(dso, a2l);
 	else
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 3329f417810c..d5f7382d4e13 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -760,7 +760,7 @@ static inline const char *dso__symsrc_filename(const struct dso *dso)
 	return RC_CHK_ACCESS(dso)->symsrc_filename;
 }
 
-void dso__set_symsrc_filename(struct dso *dso, char *val);
+void dso__set_symsrc_filename(struct dso *dso, char *val) EXCLUSIVE_LOCKS_REQUIRED(dso__lock(dso));
 
 static inline void dso__free_symsrc_filename(struct dso *dso)
 {
diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index a4dcb406c79e..992e2c2a7198 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -288,7 +288,7 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
 
 		if (node && inline_list__append_dso_a2l(dso, node, sym)) {
 			inline_node__clear_frames(node);
-			ret = 0;
+			ret = -ENOMEM;
 			goto out;
 		}
 
@@ -302,7 +302,7 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
 			if (node != NULL) {
 				if (inline_list__append_dso_a2l(dso, node, sym)) {
 					inline_node__clear_frames(node);
-					ret = 0;
+					ret = -ENOMEM;
 					goto out;
 				}
 			}
@@ -312,7 +312,7 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
 	if (file) {
 		*file = a2l->filename ? strdup(a2l->filename) : NULL;
 		if (!*file) {
-			/* Leave ret as 0 so that another addr2line is tried. */
+			ret = a2l->filename ? -ENOMEM : 0;
 			goto out;
 		}
 	}
diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
index c4504cceb313..e660623338d5 100644
--- a/tools/perf/util/libdw.c
+++ b/tools/perf/util/libdw.c
@@ -7,6 +7,7 @@
 #include "callchain.h"
 #include <fcntl.h>
 #include <unistd.h>
+#include <string.h>
 #include <elfutils/libdwfl.h>
 
 static const Dwfl_Callbacks offline_callbacks = {
@@ -175,10 +176,15 @@ int libdw__addr2line(u64 addr, char **file, unsigned int *line_nr,
 	int lineno = 0;
 	int ret = 0;
 
+	if (!dso__has_srcline(dso))
+		return 0;
+
 	mutex_lock(dso__lock(dso));
 	dwfl = dso__libdw_dwfl(dso);
-	if (!dwfl)
+	if (!dwfl) {
+		ret = -1;
 		goto out;
+	}
 
 	mod = dwfl_addrmodule(dwfl, addr);
 	if (!mod) {
@@ -192,14 +198,23 @@ int libdw__addr2line(u64 addr, char **file, unsigned int *line_nr,
 	 * libdw.
 	 */
 	if (!dwfl_module_getdwarf(mod, &bias)) {
-		ret = -1;
+		/*
+		 * Free the Dwfl session so the mmap'd ELF binary is unmapped
+		 * immediately, and mark the DSO as lacking srcline/DWARF info
+		 * so neither libdw nor slower fallback backends (addr2line
+		 * subprocess, libbfd) are repeatedly invoked on stripped DSOs.
+		 */
+		dso__free_libdw(dso);
+		dso__set_has_srcline(dso, false);
+		ret = 0;
 		goto out;
 	}
 
 	/* Find source line information for the address. */
 	dwline = dwfl_module_getsrc(mod, addr + bias);
 	if (!dwline) {
-		ret = -1;
+		/* conclusively missing information -> abort fallbacks */
+		ret = 0;
 		goto out;
 	}
 
@@ -228,7 +243,7 @@ int libdw__addr2line(u64 addr, char **file, unsigned int *line_nr,
 				free(*file);
 				*file = NULL;
 			}
-			ret = 0;
+			ret = -ENOMEM;
 			goto out;
 		}
 
@@ -245,7 +260,7 @@ int libdw__addr2line(u64 addr, char **file, unsigned int *line_nr,
 				*file = NULL;
 			}
 			inline_node__clear_frames(node);
-			ret = 0;
+			ret = args.err;
 			goto out;
 		}
 	}
diff --git a/tools/perf/util/libdw.h b/tools/perf/util/libdw.h
index b12094737415..c8f319ce35df 100644
--- a/tools/perf/util/libdw.h
+++ b/tools/perf/util/libdw.h
@@ -23,7 +23,8 @@ struct symbol;
  * finds the source line information for the given address, and optionally
  * resolves inline function call chains.
  *
- * Returns 1 on success (found), 0 on failure (not found).
+ * Returns 1 on success (found), 0 when DWARF/line info is conclusively
+ * missing, and < 0 on initialization or uncompiled error.
  */
 int libdw__addr2line(u64 addr, char **file,
 		     unsigned int *line_nr, struct dso *dso,
@@ -47,7 +48,7 @@ static inline int libdw__addr2line(u64 addr __maybe_unused, char **file __maybe_
 				   struct inline_node *node __maybe_unused,
 				   struct symbol *sym __maybe_unused)
 {
-	return 0;
+	return -1;
 }
 
 static inline void dso__free_libdw(struct dso *dso __maybe_unused)
diff --git a/tools/perf/util/llvm-c-helpers.cpp b/tools/perf/util/llvm-c-helpers.cpp
index 004081bd12c9..d990166100f0 100644
--- a/tools/perf/util/llvm-c-helpers.cpp
+++ b/tools/perf/util/llvm-c-helpers.cpp
@@ -50,20 +50,20 @@ static LLVMSymbolizer *get_symbolizer()
 	return instance;
 }
 
-/* Returns 0 on error, 1 on success. */
+/* Returns < 0 on error, 0 when line info is missing, 1 on success. */
 static int extract_file_and_line(const DILineInfo &line_info, char **file,
 				 unsigned int *line)
 {
-	if (file) {
-		if (line_info.FileName == "<invalid>") {
-			/* Match the convention of libbfd. */
+	if (line_info.FileName == "<invalid>") {
+		if (file)
 			*file = nullptr;
-		} else {
-			/* The caller expects to get something it can free(). */
-			*file = strdup(line_info.FileName.c_str());
-			if (*file == nullptr)
-				return 0;
-		}
+		return 0;
+	}
+	if (file) {
+		/* The caller expects to get something it can free(). */
+		*file = strdup(line_info.FileName.c_str());
+		if (*file == nullptr)
+			return -ENOMEM;
 	}
 	if (line)
 		*line = line_info.Line;
@@ -86,30 +86,42 @@ int llvm_addr2line(const char *dso_name, u64 addr,
 		Expected<DIInliningInfo> res_or_err =
 			symbolizer->symbolizeInlinedCode(dso_name,
 							 sectioned_addr);
-		if (!res_or_err)
-			return 0;
+		if (!res_or_err) {
+			consumeError(res_or_err.takeError());
+			return -1;
+		}
 		unsigned num_frames = res_or_err->getNumberOfFrames();
 		if (num_frames == 0)
 			return 0;
 
-		if (extract_file_and_line(res_or_err->getFrame(0),
-					  file, line) == 0)
-			return 0;
+		int ret = extract_file_and_line(res_or_err->getFrame(0),
+						file, line);
+		if (ret <= 0)
+			return ret;
 
 		*inline_frames = (llvm_a2l_frame *)calloc(
 			num_frames, sizeof(**inline_frames));
-		if (*inline_frames == nullptr)
-			return 0;
+		if (*inline_frames == nullptr) {
+			if (file)
+				zfree(file);
+			return -ENOMEM;
+		}
 
 		for (unsigned i = 0; i < num_frames; ++i) {
 			const DILineInfo &src = res_or_err->getFrame(i);
 
 			llvm_a2l_frame &dst = (*inline_frames)[i];
-			if (src.FileName == "<invalid>")
-				/* Match the convention of libbfd. */
-				dst.filename = nullptr;
-			else
-				dst.filename = strdup(src.FileName.c_str());
+			if (src.FileName == "<invalid>") {
+				for (unsigned j = 0; j < i; ++j) {
+					zfree(&(*inline_frames)[j].filename);
+					zfree(&(*inline_frames)[j].funcname);
+				}
+				zfree(inline_frames);
+				if (file)
+					zfree(file);
+				return 0;
+			}
+			dst.filename = strdup(src.FileName.c_str());
 			dst.funcname = strdup(src.FunctionName.c_str());
 			dst.line = src.Line;
 
@@ -120,7 +132,9 @@ int llvm_addr2line(const char *dso_name, u64 addr,
 					zfree(&(*inline_frames)[j].funcname);
 				}
 				zfree(inline_frames);
-				return 0;
+				if (file)
+					zfree(file);
+				return -ENOMEM;
 			}
 		}
 
@@ -131,8 +145,10 @@ int llvm_addr2line(const char *dso_name, u64 addr,
 
 		Expected<DILineInfo> res_or_err =
 			symbolizer->symbolizeCode(dso_name, sectioned_addr);
-		if (!res_or_err)
-			return 0;
+		if (!res_or_err) {
+			consumeError(res_or_err.takeError());
+			return -1;
+		}
 		return extract_file_and_line(*res_or_err, file, line);
 	}
 }
diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index 722e71aab100..0ecb1a53359e 100644
--- a/tools/perf/util/llvm.c
+++ b/tools/perf/util/llvm.c
@@ -44,8 +44,11 @@ int llvm__addr2line(const char *dso_name __maybe_unused, u64 addr __maybe_unused
 	int num_frames = llvm_addr2line(dso_name, addr, file, line,
 					node && unwind_inlines, &inline_frames);
 
-	if (num_frames == 0 || !inline_frames) {
-		/* Error, or we didn't want inlines. */
+	if (num_frames <= 0 || !inline_frames) {
+		/*
+		 * Error (< 0 -> iterate fallbacks), missing line info (0), or
+		 * we resolved lines without wanting inlines (1).
+		 */
 		return num_frames;
 	}
 
@@ -60,8 +63,11 @@ int llvm__addr2line(const char *dso_name __maybe_unused, u64 addr __maybe_unused
 						      inline_frames[i].line);
 		}
 		if (inline_list__append(inline_sym, srcline, node) != 0) {
+			if (file)
+				zfree(file);
+			inline_node__clear_frames(node);
 			free_llvm_inline_frames(inline_frames, num_frames);
-			return 0;
+			return -1;
 		}
 	}
 	free_llvm_inline_frames(inline_frames, num_frames);
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index a8d16106f619..23951c35fb66 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -181,9 +181,9 @@ static int addr2line(const char *dso_name, u64 addr, char **file, unsigned int *
 			break;
 		case A2L_STYLE_UNKNOWN:
 		default:
-			break;
+			return 0;
 		}
-		if (ret > 0)
+		if (ret >= 0)
 			return ret;
 	}
 
@@ -250,6 +250,10 @@ static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
 
 	addr2line(dso_name, addr, /*file=*/NULL, /*line_nr=*/NULL, dso,
 		  /*unwind_inlines=*/true, node, sym);
+	if (!dso__has_srcline(dso) && list_empty(&node->val)) {
+		inline_node__delete(node);
+		return NULL;
+	}
 
 	return node;
 }
@@ -276,8 +280,8 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 	if (dso_name == NULL)
 		goto out_err;
 
-	if (!addr2line(dso_name, addr, &file, &line, dso,
-		       unwind_inlines, /*node=*/NULL, sym)) {
+	if (addr2line(dso_name, addr, &file, &line, dso,
+		       unwind_inlines, /*node=*/NULL, sym) <= 0) {
 		free(dso_name);
 		goto out_err;
 	}
@@ -302,6 +306,7 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 		dso__set_has_srcline(dso, false);
 		dso__free_a2l(dso);
 		dso__free_a2l_libbfd(dso);
+		dso__free_libdw(dso);
 	}
 	mutex_unlock(dso__lock(dso));
 out:
@@ -331,8 +336,8 @@ char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line)
 	if (dso_name == NULL)
 		goto out_err;
 
-	if (!addr2line(dso_name, addr, &file, line, dso, /*unwind_inlines=*/true,
-			/*node=*/NULL, /*sym=*/NULL)) {
+	if (addr2line(dso_name, addr, &file, line, dso, /*unwind_inlines=*/true,
+			/*node=*/NULL, /*sym=*/NULL) <= 0) {
 		free(dso_name);
 		goto out_err;
 	}
@@ -350,6 +355,7 @@ char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line)
 		dso__set_has_srcline(dso, false);
 		dso__free_a2l(dso);
 		dso__free_a2l_libbfd(dso);
+		dso__free_libdw(dso);
 	}
 	mutex_unlock(dso__lock(dso));
 
@@ -448,6 +454,9 @@ struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr,
 	char *dso_name;
 	struct inline_node *node;
 
+	if (!dso__has_srcline(dso))
+		return NULL;
+
 	dso_name = srcline_dso_name(dso);
 	if (dso_name == NULL)
 		return NULL;
-- 
2.56.0.307.g5fe7bd680c-goog

