Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893766;
	b=kluzB/IzQscV2qsFnaTpcrFJSE8hvVz/gaZLqh+PUcyRi1FuGZh4KtH65Z38j2tXko70
	 UWjjU9s05NX3CwZFzbq/kNz/tCjeLJQzz7ttptqVEPxzkaAuyYbt+hb8ASK+5iTXzl7N0
	 OB9SDoRz+nG+kyXck6ZdJ97oK3LPWEKzNmTtHbMPypWMv5Ga+3DCXw094AfBF+N5gDmbm
	 mSP8iueWPMgewcVZChhatdgRJWJTP7g2YMYqAoxMBhwudhF9Qoeb0iVuhuouV+yC3VOIN
	 3g3PhygFioDVLaNUDCyHbSga0BK08ZiVhNi95olklrtt892Y+h7BaWW6WvC3WFBrCDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=AIQ55/dcKZN2IJAZH63I7acCXZ9upAaCZhaczPqmRgk=;
	b=ros8R87RbgSnr/j7NmPX98TnYa8LVc2IryzD67YxgzpqghK3vAdeQ71u7wFW6BbS1oW4
	 uTyYrbqPLshZNlaEAP/6LwIXlSmeruYJfncpItRZuc/LCrmSQaRqV7NB4Li2piAvGNxB/
	 +U4zykuX5rHfJvm2O7LFwRPgLm7eBcdRrefDzmZTirDXJICYF/gi0N8zPQ23i9B3huZtt
	 3aB7Xuu2jzvRhu7kHK0aQTU/cjEOzucbYLT1fnTc4KztkgD2th7hiWb27Hvs+OIu+eisH
	 XuMHzB/Kx1ka1L5wDbUqSWmIsJwRLQ4VHTKb6dL7lFOeSkz6Khwtv0ogrSm9dmvZPsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tBjAsfx8;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A901660A2605
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 15:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A901660A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tBjAsfx8
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-490f38e9688so753974f8f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 07:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793893764; x=1794498564; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AIQ55/dcKZN2IJAZH63I7acCXZ9upAaCZhaczPqmRgk=;
        b=tBjAsfx8n1qzHmyyDxMBgCdw+7nf8sWru77orE1BFgUfLKr4+DFSP82bxone8sGjXu
         H6OLhJ3sxl6x10lnmpjREcOm7LdecHv2PjuypskpWo6Vvny7n1tPkIDB9A1z6nrNkEDj
         FGyvezl/66ffV2ORn8jx/UmjogvVsAWQzvR3EwEIVvgQgZllKo/uR+PhZTc0Gd4osWga
         DKR0swuUmZeu1cPf1dzrOPREaz+BacC28xhpsv08gTumTLD0t0XhgnAbps6yJnIGowsj
         vhhmm4tx2cy3DXQCuVzXeY9PuHjNKbKQuqGUdtyP173i19HjY1tA3+hY9B/y1zt9t8C2
         uHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793893764; x=1794498564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AIQ55/dcKZN2IJAZH63I7acCXZ9upAaCZhaczPqmRgk=;
        b=PfdGKTFQ83F06G/fZ4ro+rE5lUZPifh1dFBZjIu9eEQyNFoJl+jnbUfkP4Orl4vzI1
         sRMR7oObH1PhyDGvZM9LmpxrX6TCf314V62MdAHeBfphQvEAw+jx1Gco6CahPaUyCmM+
         88wuZAEos9flT7axyOUC+k2cqzccYAwXFXTJNu9HIv0PxhV8nV6YNPG1MGU0BDcJqG9T
         8st7+ykybwi36DzFVkIKr+TGysimY4WFccWR51cmn1ywU0UL8Nh+/OX05ZxOyCF9qNLb
         KKJiROGvLVSuNLHoDD3mYBLPYY8wQb9due/mj+n6DXeMoEWREBmw2gRNn9d249e9bz2x
         C5Iw==
X-Forwarded-Encrypted: i=1; AKwUvByLGxXIZtzGEIyHXr4LLpdKGU8bTRjylRpTh0I0V7vQJfl2Y3RVaK4Qxl+ZC64otREmPN6cScu39laTS6qMIfRv@vger.kernel.org
X-Gm-Message-State: APuU4Z+YfVamUieXlrC8dje6WFWKTorDKRtpmpxrUNH2cDG60ugoy1Y+
	k9q4uwDRzdfkXbDTdnmwlpiOjcadqooHA9w9T7YHSi2iqqL2a3Y4UyTOEeq2FJ5+vBs=
X-Gm-Gg: AYBFou0/peDmG5Hd2ozGF6+RJOXDmdRCxqpFwW9tPrP5hvigO5Tvc0j6KG7Od6kiDJk
	po6+ttdLCX26IQ9gjVF13GQPUC6VASEOGWuBVotQPDL8+C2BtzB19uJOpYuZleW9+c3OSZhOjND
	3JNb6YRMW+4G9w5UoAvZJDKvvmSwy8vh8iq2URMT3qX06TeJmjzOg92EOjsFrZrHm8x4b8T+2HU
	ezxMHj5tu22FnHzOPji949U9mkrrFiQxX21TqEJqLbgADRYgVy6nBNoRSCbUuF2YPoXXADPkNnI
	v82n7WzEOXMy8CWd5Sd1rK8xgKZCW+sgwCdT5rGfgHPCuneX4Pe6UYR6gDEGialU77LPkYyWuhs
	tJlT7unFFCUHfRitbWmKyHTIkQHDT6Vee/V5tTTwjHRtTZhHSNdqCHfx4xidhNBly/5JiXmU5W4
	km4Ja7HXE466HBUr12F6QW5p1Ja64AQmmrnj10TCHEhygzc4V41r1lbPEfeS6EVAogixw6Zf2hh
	Y/dOxwwSiJYTVIk0OwCa3a1n0o/5MfzSkhR5mQ4+h0LtB7dFxShT+PTw1xq8FrRx5waFCm6xgyD
	khvGCWuHxT6mPOxfUcl7fCvqUsZQSQ6L
X-Received: by 2002:a05:6000:2003:b0:491:d721:548f with SMTP id ffacd0b85a97d-491d72156c2mr3831522f8f.12.1793893763950;
        Thu, 05 Nov 2026 07:49:23 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec9cd40csm10650462f8f.13.2026.11.05.07.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:49:23 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Thu, 05 Nov 2026 15:49:03 +0000
Subject: [PATCH 1/4] perf libdw: Find the CU by iterating all CUs when
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
Message-Id: <20261105-james-perf-test-fixes-v1-1-0b279bee5830@linaro.org>
References: <20261105-james-perf-test-fixes-v1-0-0b279bee5830@linaro.org>
In-Reply-To: <20261105-james-perf-test-fixes-v1-0-0b279bee5830@linaro.org>
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
index 25e3169ea8ad..8092ef9d2045 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -523,31 +523,6 @@ static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
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
@@ -1827,7 +1802,7 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 	pc = map__rip_2objdump(dloc->ms->map, dloc->ip);
 
 	/* Get a compile_unit for this address */
-	if (!find_cu_die(dloc->di, pc, &cu_die)) {
+	if (!cu_find_by_addr(dloc->di->dbg, pc, &cu_die)) {
 		pr_debug_dtp("cannot find CU for address %"PRIx64"\n", pc);
 		ann_data_stat.no_cuinfo++;
 		return -1;
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 54f8b5ec74a2..742fccba5376 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -106,6 +106,43 @@ static Dwarf_Line *cu_getsrc_die(Dwarf_Die *cu_die, Dwarf_Addr addr)
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
index 6f9145510adc..cc3fd61374c4 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -23,6 +23,9 @@ const char *cu_find_realpath(Dwarf_Die *cu_die, const char *fname);
 /* Get DW_AT_comp_dir (should be NULL with older gcc) */
 const char *cu_get_comp_dir(Dwarf_Die *cu_die);
 
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

