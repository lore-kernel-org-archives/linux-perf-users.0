Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232104;
	b=CnP0SRGbhZAzXqdMkOxnVX/GR8HcjE7roJB3pDfT+r5p0fL+EToXaMkK2A9KXSjuyvOM
	 xRtlZT3KstCrT6Mu8PxK4c0FrlWbd6H8xdJ8iu0i/UksAOviMyeVIPO1DYMhYkiAr4tCB
	 +UIZXXaxBPJYoX3A1rq2leRKVBTO8cOvYbbE06fBmZkNFsV5H9l5g3yCfXVdYPwiWK3n9
	 3DOiT8GfyXr2vjbVeK01miua0INjAG4N54AXCAioGvQk2hQ3WqBcop0PZMaePd3yve1ms
	 jXOyjXIeXGwdO3ydI3X7xILM97//TM5cP11dsK6fPkAAikOWeAlas+Jxfg6fdNdBEtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=oIWLoa5g/fdYrkLvLxADIE71/WrnQMWwPiN+l5QI7j8=;
	b=iPc949Hg16O8Zz5Hu2x7SImNEegt5/w3K6JnpVLYTvcSwX+vPK6SjDO1T5r0uwHnNary
	 g8ar/ONTYJnjtVF6HwFBPoGFfNs/Gj7C1EXhyIKn8YCQtaS5MrZjCwaoVlHJcMuPfotg8
	 pCXk+JGsxJuKgeCN5NQIicCCH5+2XGktQaGu/z4EZMtXe1JTKNaPgvCUHl5jbfLS6G/lK
	 E5ZZaPvJf/wDaPD/FIOVbqSooghnF3Gjpb0tgXjlahSidM+AB5SWdeC8/Z3HDZFFtLsd+
	 1PkeRXkbD91jTCWMJYLvzPMGHPWYIfWSXH3IIBf1GhNZjz5ZCzUCA8ToqbMdqKTovbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qCoLQ1gZ;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886BD606A323
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 13:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 886BD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qCoLQ1gZ
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a214af2076so6365025e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 05:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794232103; x=1794836903; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oIWLoa5g/fdYrkLvLxADIE71/WrnQMWwPiN+l5QI7j8=;
        b=qCoLQ1gZUkK86B5wMyNztDk2Ob1tRTwT+aXHGfPWdU0JycAbGnrrshRsU189lYu8u9
         BdMDVfJfwX1FYqKk8tbNSRneQV7QIhKGMh0AhfEMj3j0NoZYkKYqSJtXJZieFQ0jjM/7
         X3x+yuSAD9L1x0ZOF+/lmjyiw+sHmld745Mx4wAjRdo3U0X4zgdjEx48hBwVKHMKdzj6
         fKhxQu5bX/dqKC0bIZbF32ssXsijh+TKrakD0M+TvqZrpgg9ueCOa9eRi4hFnW0YWzS5
         EuQzETo5AJw8jBHi/+omQd/LNj8fNT1IKnM3kDX59QDR0bttDsg6Niq1gwudXpoYFaLl
         1JnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794232103; x=1794836903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oIWLoa5g/fdYrkLvLxADIE71/WrnQMWwPiN+l5QI7j8=;
        b=U6+ZcB1T3GftrnbtYsKwW/eATF20u1LD+ev+G7ZZaTkVsQxYh5pfA2HYJ8MWBmCCh0
         NS/8HrvJEvFYkYiJcbw4pf+AfPiD7RXCJlGkb2BTnll4rKoSYWimL5Ih91EVnQlNhEoJ
         PO92TgaLZBZp1F6IU2NDf1Pq0oCnESlP/sDCgUwdXtIQA55FvTfjpO8nIm/+OONyFATy
         hD7scFuk4tLsQRLTVaRn+YaWtagRYIowloH3t4H60kn6pj2ukLVhkt0dX55SrN268PJ0
         C0vU3qIeOthEDYwxhuEyALtX0v/esYO0fjWnJUKFZqqX5ztnTw+yZ4R1nru3uqhv6lp9
         fxmg==
X-Forwarded-Encrypted: i=1; AL+hErGgjKyployboGSMCTJsWCbOqeC7dH2iiXOtrbE9B3NZPOmjpfPpXugJWKIKUDqUP3aknjekRwsmCnJ3H94QvhmF@vger.kernel.org
X-Gm-Message-State: APuU4Z8NZXx5q3SRp1cylKAx5fNLsYY+Pjs9LTzk4HRxNDhPomV741hJ
	GFGNVyM6+bAPBQzYffJvRRelGLMb8Sv/Pns+4AzVZ8jlLhOLTDL6D0PqGHVlTevuEyY=
X-Gm-Gg: AYBFou0o4nVXUktWjlxqzMdtqJ2TNYId804vNtOg/Oem7IXRnKDOGPIlovfbA44WVSx
	VTCCkVLX69n0IqkSuh3cbk6G/gTCaeo1QV7inzI28irFrMUW4jx0fjrh0MMgsrwjZS8wHfoV3vU
	nS9UY1ShkLVSdT9mTFhaFKAICz3l5CYqOO56ERHQSAneqVZOpC5NeZUllPlDOkiW2RnfmkINKZz
	9U5HaidcG9ygzMs33dFKMvwvKKIlUvGLGPgDGDjqOHEXVIncXfwiY8AYcs0EGA/vb5zb2xCIml8
	4JvbBRg1jcOiqik5sdXxXtlePd0ISHDrC4/e+VhlOvAPsJlbYlddICc9U4QZqijxhSbAl+iW4JF
	5wSAIArYwqk055DsG6BWd46yjY+3ocytbMgVqGspjmNHpzE9QCWXa4ZxYNPYuActIDNDBtombcE
	ITNzEkaAsVAFd8ijHoig9Ha+rap1aVGhVEE8FKm/yUwOfSX16mKWZd3luF4bBm48xMOZVswc6+j
	0ZpdGENkuAjBuXNnodcJOXck43hDHkx53WU8Y4glzruueV98ncf2sYycc0w2R13tVRBdX+n9/nB
	/rEO6cMB8kniKeO4iFBnNG4ymTS/IaXb
X-Received: by 2002:a05:600c:4e92:b0:4a8:f2ad:a9e5 with SMTP id 5b1f17b1804b1-4b94d76c213mr83961285e9.3.1794232102984;
        Mon, 09 Nov 2026 05:48:22 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7bb101537sm98522045e9.0.2026.11.09.05.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:48:22 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 09 Nov 2026 13:48:08 +0000
Subject: [PATCH v4 1/4] perf libdw: Find the CU by iterating all CUs when
 aranges are missing
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-james-perf-test-fixes-v4-1-355ee6b81917@linaro.org>
References: <20261109-james-perf-test-fixes-v4-0-355ee6b81917@linaro.org>
In-Reply-To: <20261109-james-perf-test-fixes-v4-0-355ee6b81917@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Jakub Brnak <jbrnak@redhat.com>, 
 Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

libdw__addr2line() finds the CU with dwfl_module_getsrc() and
dwfl_module_addrdie(), which use dwarf_getaranges(). In elfutils 0.190
this only reads .debug_aranges, which can be partial. For example, when
Perf is built with LLVM=1, clang doesn't emit .debug_aranges by default
so the lookup then fails and no source lines are found for most of the
Perf binary.

This used to be hidden by falling back to the next addr2line style, but
now missing information stops the fallback since commit (62d7cdc8d587
"perf libdw: Optimize fallback logic for missing DWARF").

find_cu_die() in annotate-data.c already handles partial aranges by
iterating all CUs in .debug_info and checking them with dwarf_haspc().
Move it to dwarf-aux.c, then look up the line in that CU with
dwarf_getsrc_die() and use the same CU for unwinding inlines. While
moving it, don't treat a dwarf_haspc() error as a match.

This fixes the "test addr2line inline unwinding" test when Perf is built
with LLVM:

  $ perf test -vvv "test addr2line inline unwinding"
  ...
  Inline unwinding fp verification test [Failed missing inlined functions]
  ...
  Inline unwinding dwarf verification test [Failed missing inlined functions]
  ...
  Inline unwinding lbr verification test [Failed missing inlined functions]
  ---- end(-1) ----
   79: test addr2line inline unwinding : FAILED!

Fixes: 88c51002d06f ("perf addr2line: Add a libdw implementation")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/annotate-data.c | 27 +--------------------------
 tools/perf/util/dwarf-aux.c     | 37 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/dwarf-aux.h     |  3 +++
 tools/perf/util/libdw.c         | 19 ++++++++++---------
 4 files changed, 51 insertions(+), 35 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index dd9c1d7b2da8..2332d465f975 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -553,31 +553,6 @@ static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
 	return result;
 }
 
-static bool find_cu_die(struct debuginfo *di, u64 pc, Dwarf_Die *cu_die)
-{
-	Dwarf_Off off, next_off;
-	size_t header_size;
-
-	if (dwarf_addrdie(di->dbg, pc, cu_die) != NULL)
-		return cu_die;
-
-	/*
-	 * There are some kernels don't have full aranges and contain only a few
-	 * aranges entries.  Fallback to iterate all CU entries in .debug_info
-	 * in case it's missing.
-	 */
-	off = 0;
-	while (dwarf_nextcu(di->dbg, off, &next_off, &header_size,
-			    NULL, NULL, NULL) == 0) {
-		if (dwarf_offdie(di->dbg, off + header_size, cu_die) &&
-		    dwarf_haspc(cu_die, pc))
-			return true;
-
-		off = next_off;
-	}
-	return false;
-}
-
 enum type_match_result {
 	PERF_TMR_UNKNOWN = 0,
 	PERF_TMR_OK,
@@ -1850,7 +1825,7 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 	pc = map__rip_2objdump(dloc->ms->map, dloc->ip);
 
 	/* Get a compile_unit for this address */
-	if (!find_cu_die(dloc->di, pc, &cu_die)) {
+	if (!cu_find_by_addr(dloc->di->dbg, pc, &cu_die)) {
 		pr_debug_dtp("cannot find CU for address %"PRIx64"\n", pc);
 		ann_data_stat.no_cuinfo++;
 		return -1;
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 48a11c95a676..4cc231ffcb2a 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -114,6 +114,43 @@ static Dwarf_Line *cu_getsrc_die(Dwarf_Die *cu_die, Dwarf_Addr addr)
 	return line;
 }
 
+/**
+ * cu_find_by_addr - Find the CU DIE that contains an address
+ * @dbg: a Dwarf handle
+ * @addr: An address
+ * @cu_die: a buffer to store the found CU DIE
+ *
+ * Find the CU DIE whose ranges contain @addr. dwarf_addrdie() uses
+ * dwarf_getaranges() which didn't work until elfutils 0.191. Release notes:
+ *
+ *   * NEWS *
+ *   libdw: dwarf_addrdie now supports binaries lacking a .debug_aranges
+ *   section.
+ *
+ * Clang doesn't emit them by default, so fall back to iterating all CUs in
+ * case it's missing.
+ *
+ * Return @cu_die if found, otherwise NULL.
+ */
+Dwarf_Die *cu_find_by_addr(Dwarf *dbg, Dwarf_Addr addr, Dwarf_Die *cu_die)
+{
+	Dwarf_Off off = 0, next_off;
+	size_t header_size;
+
+	if (dwarf_addrdie(dbg, addr, cu_die) && dwarf_haspc(cu_die, addr) == 1)
+		return cu_die;
+
+	while (dwarf_nextcu(dbg, off, &next_off, &header_size,
+			    NULL, NULL, NULL) == 0) {
+		if (dwarf_offdie(dbg, off + header_size, cu_die) &&
+		    dwarf_haspc(cu_die, addr) == 1)
+			return cu_die;
+
+		off = next_off;
+	}
+	return NULL;
+}
+
 /**
  * cu_find_lineinfo - Get a line number and file name for given address
  * @cu_die: a CU DIE
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 803182cdff8a..26a887c85a4b 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -44,6 +44,9 @@ Dwarf_Die *die_get_vptr_class(Dwarf_Die *type_die, int offset,
 Dwarf_Die *die_deref_vptr_class(Dwarf_Die *ptr_die, int offset,
 				Dwarf_Die *die_mem);
 
+/* Find the CU DIE that contains the given address */
+Dwarf_Die *cu_find_by_addr(Dwarf *dbg, Dwarf_Addr addr, Dwarf_Die *cu_die);
+
 /* Get a line number and file name for given address */
 int cu_find_lineinfo(Dwarf_Die *cudie, Dwarf_Addr addr,
 		     const char **fname, int *lineno);
diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
index e660623338d5..90767361f485 100644
--- a/tools/perf/util/libdw.c
+++ b/tools/perf/util/libdw.c
@@ -170,7 +170,9 @@ int libdw__addr2line(u64 addr, char **file, unsigned int *line_nr,
 {
 	Dwfl *dwfl;
 	Dwfl_Module *mod;
-	Dwfl_Line *dwline;
+	Dwarf_Line *dwline;
+	Dwarf_Die cu_mem, *cudie;
+	Dwarf *dw;
 	Dwarf_Addr bias;
 	const char *src;
 	int lineno = 0;
@@ -197,7 +199,8 @@ int libdw__addr2line(u64 addr, char **file, unsigned int *line_nr,
 	 * between the regular ELF addr2line addresses and those to use with
 	 * libdw.
 	 */
-	if (!dwfl_module_getdwarf(mod, &bias)) {
+	dw = dwfl_module_getdwarf(mod, &bias);
+	if (!dw) {
 		/*
 		 * Free the Dwfl session so the mmap'd ELF binary is unmapped
 		 * immediately, and mark the DSO as lacking srcline/DWARF info
@@ -211,7 +214,8 @@ int libdw__addr2line(u64 addr, char **file, unsigned int *line_nr,
 	}
 
 	/* Find source line information for the address. */
-	dwline = dwfl_module_getsrc(mod, addr + bias);
+	cudie = cu_find_by_addr(dw, addr, &cu_mem);
+	dwline = cudie ? dwarf_getsrc_die(cudie, addr) : NULL;
 	if (!dwline) {
 		/* conclusively missing information -> abort fallbacks */
 		ret = 0;
@@ -219,8 +223,8 @@ int libdw__addr2line(u64 addr, char **file, unsigned int *line_nr,
 	}
 
 	/* Get line information. */
-	src = dwfl_lineinfo(dwline, /*addr=*/NULL, &lineno, /*col=*/NULL, /*mtime=*/NULL,
-			    /*length=*/NULL);
+	src = dwarf_linesrc(dwline, /*mtime=*/NULL, /*length=*/NULL);
+	dwarf_lineno(dwline, &lineno);
 
 	if (file)
 		*file = src ? strdup(src) : NULL;
@@ -229,8 +233,6 @@ int libdw__addr2line(u64 addr, char **file, unsigned int *line_nr,
 
 	/* Optionally unwind inline function call chain. */
 	if (unwind_inlines && node) {
-		Dwarf_Addr unused_bias;
-		Dwarf_Die *cudie = dwfl_module_addrdie(mod, addr + bias, &unused_bias);
 		struct libdw_a2l_cb_args args = {
 			.dso = dso,
 			.sym = sym,
@@ -248,8 +250,7 @@ int libdw__addr2line(u64 addr, char **file, unsigned int *line_nr,
 		}
 
 		/* Walk from the parent down to the leaf. */
-		if (cudie)
-			cu_walk_functions_at(cudie, addr, libdw_a2l_cb, &args);
+		cu_walk_functions_at(cudie, addr, libdw_a2l_cb, &args);
 
 		if (!args.leaf_srcline_used)
 			free(args.leaf_srcline);

-- 
2.43.0

