Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBAA3F075E
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078961; cv=none; b=FFlAgVjiEpMKU3zqXIFpuzRgGdNFDx/aqanQLe1lZi/2114YJpBJTdEpkOIzIoGQxwvSIyhSo0Wpq9NVTfY9dqGojBQRU1b2/4YjFfKy/CXsvisDOf5P/QZUDZE/Z4poFEqQ4CTq9Dz+/BudVaFeg1y+1p0QoHEWK9mmhAHsB0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078961; c=relaxed/simple;
	bh=I0bHNrXIoabZx/3kXJ4rgQ5TfmaboCIWyV/MOFLzpcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teb2eJvN4TA1vgLC6jpnKBjwDSdEEHpNROry4vFk4BLw7IC5Fvacw5Cyi+p0ycq2riQZhawS8rfoAmLReipf+SJPBFs5BjwV6cKAZHMOQ6XKQL9foFBHnW1Dt9CAPIm5A2maW5VinIXjo/iNQAe/dWlbWrT6J/nMkLI0n4Y1KXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=fjF4P9fu; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="fjF4P9fu"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64c9ebd1369so10890148d50.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 10:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1773078955; x=1773683755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=id5lmV/YuEYOAzPj/+aTg1r+vark3Tzx2cS0LXicP3k=;
        b=fjF4P9fuA4286PTqBOLFzkGzZQKkFCyI15OhuFixBBCsW31YlyqVDZzZBwfHPpdvE9
         46UIn20O+z0fJX889yX7+zHIq8c2FU+0TCyyoEfWkunaqzsXar6yy+EFQRcAY1NzAFSS
         nL7q0ht9vJPCLv0SXS35eBuKVrw9+x4kcbfLhVFvy43PjAZY9paEkDwH5hHsnPAEPAzZ
         1BY+ura8szZtlQvT20oWcGokENrhSyjM8ye1z42WnmqlI6vdTsZOmP1d51QaAVswnK4I
         CwinkirmK4aAyCA9Z4NQWTLkIv3hERO0Ydz2bbpoTtDDzzGtqC1h2y0K1JNvZ+skywAa
         0eTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773078955; x=1773683755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=id5lmV/YuEYOAzPj/+aTg1r+vark3Tzx2cS0LXicP3k=;
        b=D2ge1biZGz2rNE8qizWBCsjv3PDxM/kRr7/CSo2Fr0uXhD4VSFT1uhcjgWi+2iPNaE
         DmMChKqs1CD3CDuMBOOF4ihM9m+/UYO9H3HKd1Wpg2VaereYPSHwMT/TjQStBGYVkJDj
         ITulbfo4/XDVZt85aiqmNfqPtq6IeMhKK8qUdtUPbSpUnIJMUVgpDEZV1JPLfB5B+rTg
         M1eYTZL/YZNnPFzaY5P9HrFZ62V5qsq8mhHkMnU+OJP3TGo7wtUhi5sY1o7hKqhgfZd4
         H1ws03aM/+kj6kbUt82ulzPOCj1MCsExOvYSR1y72JTn2x+fpl+w8eR2qXdmZtgEmmSe
         J99g==
X-Forwarded-Encrypted: i=1; AJvYcCXow+UiR1OuDxu2QEslh1Iay+5igJ+vzPvRKfTV990cb+U7RpaM86ZJodb7QUEaCLswBuricOZrUYMdowamzYzc@vger.kernel.org
X-Gm-Message-State: AOJu0YwinvulvscYnWu/HJd1Zx711PPTyqxCWzjvEByJCb6hfuY8V8XO
	G8JSaqpP4VZgp5S6vT3EFL4xzOhhtoWNZlDC5b0ck9EYUxz+xSe31e472PzQjlpyqA==
X-Gm-Gg: ATEYQzymgFTkSRV5DC44jLggZk7Erep43e776O1q03XkA87H7og8x/hQBdLjkLpVRjX
	aULFdlwwvsl3WbnurfdyGpgitGvXclpeDsYAfBe740sWTws/iwGexMkqQBeyT43AiwTmyRTivfq
	hDh9Gzy0KhmdL3gVdTN1Ymu67/NCyiqLDfF83kyGAOVEZqzmEXAzbgGrVaaVEPeN2QjIyT9zy6i
	7CcqXk1A3I4l+Eqe5VNl8p8cGBWEPkymWG0u4S99scx/zYItkloKVB2cvWQ6Y7sqZGUsgTaiccZ
	kUX5f2hpBikFp7BsdDm5Gq5Af4VgBlUkBDSDt71dJ/JHb0x+mcfDiwPQv91UWBpDV9zsvUbbDmF
	wWV760N1OEqNY2jSk9xssyiABrnPn9sqozteSGW+ei1jnq9e6/AoMt1Nxc3xOei7bywyjYGbDjs
	SQodBDhW4ZCT1bKMuhL1GQmiChH4zi8Hpz6Iv74esN25diqnCRUkMKapT1
X-Received: by 2002:a05:690e:1a8d:b0:649:e4eb:cc6e with SMTP id 956f58d0204a3-64d14141211mr8245960d50.34.1773078954804;
        Mon, 09 Mar 2026 10:55:54 -0700 (PDT)
Received: from um773-cachyos.sd.ncsu.edu ([152.7.255.206])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d176e70e7sm4992535d50.20.2026.03.09.10.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 10:55:54 -0700 (PDT)
From: Zecheng Li <zli94@ncsu.edu>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Zecheng Li <zli94@ncsu.edu>,
	xliuprof@google.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zecheng Li <zecheng@google.com>
Subject: [PATCH v2 03/11] perf dwarf-aux: Skip check_variable for variable lookup
Date: Mon,  9 Mar 2026 13:55:16 -0400
Message-ID: <20260309175546.916039-4-zli94@ncsu.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309175546.916039-1-zli94@ncsu.edu>
References: <20260309175546.916039-1-zli94@ncsu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zecheng Li <zecheng@google.com>

Both die_find_variable_by_reg and die_find_variable_by_addr call
match_var_offset which already performs sufficient checking and type
matching. The additional check_variable call is redundant, and its
need_pointer logic is only a heuristic. Since DWARF encodes accurate
type information, which match_var_offset verifies, skipping
check_variable improves both coverage and accuracy.

Return the matched type from die_find_variable_by_reg and
die_find_variable_by_addr via the existing `type` field in
find_var_data, removing the need for check_variable in
find_data_type_die.

Signed-off-by: Zecheng Li <zecheng@google.com>
Signed-off-by: Zecheng Li <zli94@ncsu.edu>
---
 tools/perf/util/annotate-data.c | 42 ++++++++++++++-------------------
 tools/perf/util/dwarf-aux.c     | 13 ++++++----
 tools/perf/util/dwarf-aux.h     |  5 ++--
 3 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index cda020ea18d5..23a09bf58f86 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -814,9 +814,8 @@ bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
 	}
 
 	/* Try to get the variable by address first */
-	if (die_find_variable_by_addr(cu_die, var_addr, &var_die, &offset) &&
-	    check_variable(dloc, &var_die, type_die, DWARF_REG_PC, offset,
-			   /*is_fbreg=*/false) == PERF_TMR_OK) {
+	if (die_find_variable_by_addr(cu_die, var_addr, &var_die, type_die,
+				      &offset)) {
 		var_name = dwarf_diename(&var_die);
 		*var_offset = offset;
 		goto ok;
@@ -1606,12 +1605,13 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 
 		if (reg == DWARF_REG_PC) {
 			if (!die_find_variable_by_addr(&scopes[i], dloc->var_addr,
-						       &var_die, &type_offset))
+						       &var_die, &mem_die,
+						       &type_offset))
 				continue;
 		} else {
 			/* Look up variables/parameters in this scope */
 			if (!die_find_variable_by_reg(&scopes[i], pc, reg,
-						      &type_offset, is_fbreg, &var_die))
+						      &mem_die, &type_offset, is_fbreg, &var_die))
 				continue;
 		}
 
@@ -1619,26 +1619,20 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 			     dwarf_diename(&var_die), (long)dwarf_dieoffset(&var_die),
 			     i+1, nr_scopes, (long)dwarf_dieoffset(&scopes[i]));
 
-		/* Found a variable, see if it's correct */
-		result = check_variable(dloc, &var_die, &mem_die, reg, type_offset, is_fbreg);
-		if (result == PERF_TMR_OK) {
-			if (reg == DWARF_REG_PC) {
-				pr_debug_dtp("addr=%#"PRIx64" type_offset=%#x\n",
-					     dloc->var_addr, type_offset);
-			} else if (reg == DWARF_REG_FB || is_fbreg) {
-				pr_debug_dtp("stack_offset=%#x type_offset=%#x\n",
-					     fb_offset, type_offset);
-			} else {
-				pr_debug_dtp("type_offset=%#x\n", type_offset);
-			}
-
-			if (!found || is_better_type(type_die, &mem_die)) {
-				*type_die = mem_die;
-				dloc->type_offset = type_offset;
-				found = true;
-			}
+		if (reg == DWARF_REG_PC) {
+			pr_debug_dtp("addr=%#"PRIx64" type_offset=%#x\n",
+				     dloc->var_addr, type_offset);
+		} else if (reg == DWARF_REG_FB || is_fbreg) {
+			pr_debug_dtp("stack_offset=%#x type_offset=%#x\n",
+				     fb_offset, type_offset);
 		} else {
-			pr_debug_dtp("failed: %s\n", match_result_str(result));
+			pr_debug_dtp("type_offset=%#x\n", type_offset);
+		}
+
+		if (!found || is_better_type(type_die, &mem_die)) {
+			*type_die = mem_die;
+			dloc->type_offset = type_offset;
+			found = true;
 		}
 
 		pr_debug_location(&var_die, pc, reg);
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 3b0fc9038f19..1484aa756826 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1560,7 +1560,7 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
  * when the variable is in the stack.
  */
 Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
-				    int *poffset, bool is_fbreg,
+				    Dwarf_Die *type_die, int *poffset, bool is_fbreg,
 				    Dwarf_Die *die_mem)
 {
 	struct find_var_data data = {
@@ -1572,8 +1572,10 @@ Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
 	Dwarf_Die *result;
 
 	result = die_find_child(sc_die, __die_find_var_reg_cb, &data, die_mem);
-	if (result)
+	if (result) {
 		*poffset = data.offset;
+		*type_die = data.type;
+	}
 	return result;
 }
 
@@ -1617,7 +1619,8 @@ static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
  * This is usually for global variables.
  */
 Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr addr,
-				     Dwarf_Die *die_mem, int *offset)
+				     Dwarf_Die *die_mem, Dwarf_Die *type_die,
+				     int *offset)
 {
 	struct find_var_data data = {
 		.addr = addr,
@@ -1625,8 +1628,10 @@ Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr addr,
 	Dwarf_Die *result;
 
 	result = die_find_child(sc_die, __die_find_var_addr_cb, &data, die_mem);
-	if (result)
+	if (result) {
 		*offset = data.offset;
+		*type_die = data.type;
+	}
 	return result;
 }
 
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 99d2735122d5..939a59c91796 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -165,12 +165,13 @@ int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf);
 
 /* Find a variable saved in the 'reg' at given address */
 Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
-				    int *poffset, bool is_fbreg,
+				    Dwarf_Die *type_die, int *poffset, bool is_fbreg,
 				    Dwarf_Die *die_mem);
 
 /* Find a (global) variable located in the 'addr' */
 Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr addr,
-				     Dwarf_Die *die_mem, int *offset);
+				     Dwarf_Die *die_mem, Dwarf_Die *type_die,
+				     int *offset);
 
 /* Save all variables and parameters in this scope */
 void die_collect_vars(Dwarf_Die *sc_die, struct die_var_type **var_types);
-- 
2.53.0

