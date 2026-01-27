Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE322BE62E
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 02:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769479598; cv=none; b=lXlJoJV+2oQJ5mkwuCsdki7acdo5FBbZrNYFIWFSKB+6sP1pKW/YjOIItYxbAaeXI0lTRjJaDSeP0LI1p2YuGt0BimDY1lKHlFsiLcSFgBicfJSnViZSwYknBC+rmsofXmbZT2RFJSphCnCy0qzWWevERGFSgFB1PHhuc8cFdCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769479598; c=relaxed/simple;
	bh=wNN3N/NzCz3P3ZWWF+PAB9YUE3liWJE6VpsO9my8gCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSEkOhFjqXygSj2ePoEFKLLsW3lU9CfT0/wJ+96Z5+2sdXFPwIYFZNIE94zqG3j/3aZZOZaGGnLdHNgDnZZB8NVjiLBp6eeHvGtjczIIM18vz6kkacQplf2ftUL/9xX2J6hWhUfyEwMmoYgiwIX/ozraU7hqe5seKEWRGI20Yqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=EzI45eaO; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="EzI45eaO"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6446c924f9eso4437381d50.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 18:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1769479595; x=1770084395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FY3qFNg3bogjE9vzWIEBFHpGKQmyoJ2iv+HZhNJmLDM=;
        b=EzI45eaOMqfR1K5sebAa/hLwgG74eegui+6cYb503nE0x7ixLeBN5+ee4wn5aOXgNe
         Nc7BIdgABKpiqdkpPSlw9cH+FpFK5gV85iW2nLq8LprDh50r3DY+AVLnRjeHkkCWy/Ua
         2RGi8Z5WNsQsLwVe59dmNS2UxfCHBgaBRBNKbc2/TfvaOWkHRgB/vXoTc8V5b3lkJlt+
         9wxRseIHiStr6zPgzpklug5oF+k7ThWswd/wJ24vhqZQvcD1MMM/HwNUuFQ3jOARPIvZ
         VGZCtRe0Q0/1wBCRyb+m0N+MVdeIqKVkYQpC/1bQ1KujsHCqZvrY0M99jlmUZXSzYLsp
         OnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769479595; x=1770084395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FY3qFNg3bogjE9vzWIEBFHpGKQmyoJ2iv+HZhNJmLDM=;
        b=E+OKczcpFtUriZuy84KpfRpTMGG8Izzt6LDHd/et9bTaFt6CgJAtv8KVYlNo5y17zc
         aC0XXEwyKtu6Fp2PBEdVgSmRThYQxrjwoggQCiaTpuJce+2NBXlpn8KoXtSwMrAyHYG8
         WzDOXBWUGd7EglCrFV4e9tMmxvzqeygegouyC2aV0W641jkqF1ahaMjZzrnawFbyerS0
         Jrp+oOy7NB7s0ZeX+21I0LGCB3IL3TR2bkqjzKk4bAREBoUbxiTSWFW/w46q74wchmAy
         9Mnb5MnotXg3CQFm/dQ3vyNzTLrB8THd1a1vg4ch4CN8vOuw/Xib6u0o65E+NfLkhYCt
         HQNw==
X-Forwarded-Encrypted: i=1; AJvYcCWtI5yWRdYiYHjh1meAylBm/SKHVX1mp7kKmJBadBc1wKeQ6LKBXUruKxYmFJDlQxLtBLOyPsB7N0g5+ZHKn/yd@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1DgQJdf3St2HFpjUMK7RxYnbt0tIzSmU+YO5So1Xl1lDNYDXA
	FKpX6hlEXdNp+Gor9SYV2Ntxivl7KiZsNfnh4jQhv34/jc3TOrrld/PIA0c7/T8tRw==
X-Gm-Gg: AZuq6aK6I/UW+bx1HpdiE9RfMJL6uTmVAikAYKz0W+l99cG9a1cVHzP+DCaOqFKrmVS
	QbdJlDvaqlwG5Ad3cApngwNHjZrBLnfoBfXrfMTwOP/ziL0ETvQuuf/nQYTtKLaN+LG/31SGDyJ
	1PTzanGH+gYJbe4FvOh3P5tOl1XkJHtPF4MHQ1jiUaXRjwpehuTSe7FvTqXGip1zIp4nziFaenW
	6l2daYHvHei2Z4/y9cQtg+5j9xPj5V0z79832Fl0iv0YTah2N8viJPJYdhKrpPC4gCNAB+z60Yu
	xA7tV0arIeOzpo67rqTYeh5wickjWWxPS6rpRFkYzHliV8rN0bipXWSHMrQf/9J1QZJoI3Msqxp
	VsWAFBhlzs83J20nWgP7mDSXo0Wrk2c9+cZycp75OTsWcaWHcaXgWNNEeb9KSRmSq411mpglR15
	rpvEIV5lDV+A==
X-Received: by 2002:a53:8613:0:b0:644:60d9:7510 with SMTP id 956f58d0204a3-64970d8386emr3518532d50.96.1769479594770;
        Mon, 26 Jan 2026 18:06:34 -0800 (PST)
Received: from um773-cachyos ([2600:1700:cc0:94af:eca6:9ff9:6f3c:5de9])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6496855d65esm4217415d50.12.2026.01.26.18.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 18:06:34 -0800 (PST)
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
Subject: [PATCH v1 01/11] perf dwarf-aux: Skip check_variable for die_find_variable_by_reg
Date: Mon, 26 Jan 2026 21:04:54 -0500
Message-ID: <20260127020617.2804780-2-zli94@ncsu.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127020617.2804780-1-zli94@ncsu.edu>
References: <20260127020617.2804780-1-zli94@ncsu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zecheng Li <zecheng@google.com>

In die_find_variable_by_reg, match_var_offset already performs
sufficient checking and type matching. The additional check_variable
call is redundant, and its need_pointer logic is only a heuristic. Since
DWARF encodes accurate type information, which match_var_offset
verifies, skipping check_variable improves both coverage and accuracy.

Return type from die_find_variable_by_reg via a new `type` field in
find_var_data.

Signed-off-by: Zecheng Li <zecheng@google.com>
Signed-off-by: Zecheng Li <zli94@ncsu.edu>
---
 tools/perf/util/annotate-data.c |  8 +++++---
 tools/perf/util/dwarf-aux.c     | 18 +++++++++++-------
 tools/perf/util/dwarf-aux.h     |  2 +-
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 07cf9c334be0..99ffc6d70565 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1603,19 +1603,21 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 			if (!die_find_variable_by_addr(&scopes[i], dloc->var_addr,
 						       &var_die, &type_offset))
 				continue;
+			/* Found a variable, see if it's correct */
+			result = check_variable(dloc, &var_die, &mem_die, reg,
+						type_offset, is_fbreg);
 		} else {
 			/* Look up variables/parameters in this scope */
 			if (!die_find_variable_by_reg(&scopes[i], pc, reg,
-						      &type_offset, is_fbreg, &var_die))
+						      &mem_die, &type_offset, is_fbreg, &var_die))
 				continue;
+			result = PERF_TMR_OK;
 		}
 
 		pr_debug_dtp("found \"%s\" (die: %#lx) in scope=%d/%d (die: %#lx) ",
 			     dwarf_diename(&var_die), (long)dwarf_dieoffset(&var_die),
 			     i+1, nr_scopes, (long)dwarf_dieoffset(&scopes[i]));
 
-		/* Found a variable, see if it's correct */
-		result = check_variable(dloc, &var_die, &mem_die, reg, type_offset, is_fbreg);
 		if (result == PERF_TMR_OK) {
 			if (reg == DWARF_REG_PC) {
 				pr_debug_dtp("addr=%#"PRIx64" type_offset=%#x\n",
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 9267af204c7d..b57cdc8860f0 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1378,6 +1378,8 @@ struct find_var_data {
 	Dwarf_Addr addr;
 	/* Target register */
 	unsigned reg;
+	/* Access data type */
+	Dwarf_Die type;
 	/* Access offset, set for global data */
 	int offset;
 	/* True if the current register is the frame base */
@@ -1390,7 +1392,6 @@ struct find_var_data {
 static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
 			     s64 addr_offset, s64 addr_type, bool is_pointer)
 {
-	Dwarf_Die type_die;
 	Dwarf_Word size;
 	s64 offset = addr_offset - addr_type;
 
@@ -1403,16 +1404,16 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
 	if (offset < 0)
 		return false;
 
-	if (die_get_real_type(die_mem, &type_die) == NULL)
+	if (die_get_real_type(die_mem, &data->type) == NULL)
 		return false;
 
-	if (is_pointer && dwarf_tag(&type_die) == DW_TAG_pointer_type) {
+	if (is_pointer && dwarf_tag(&data->type) == DW_TAG_pointer_type) {
 		/* Get the target type of the pointer */
-		if (die_get_real_type(&type_die, &type_die) == NULL)
+		if (die_get_real_type(&data->type, &data->type) == NULL)
 			return false;
 	}
 
-	if (dwarf_aggregate_size(&type_die, &size) < 0)
+	if (dwarf_aggregate_size(&data->type, &size) < 0)
 		return false;
 
 	if ((u64)offset >= size)
@@ -1529,7 +1530,7 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
  * when the variable is in the stack.
  */
 Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
-				    int *poffset, bool is_fbreg,
+				    Dwarf_Die *type_die, int *poffset, bool is_fbreg,
 				    Dwarf_Die *die_mem)
 {
 	struct find_var_data data = {
@@ -1541,8 +1542,11 @@ Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
 	Dwarf_Die *result;
 
 	result = die_find_child(sc_die, __die_find_var_reg_cb, &data, die_mem);
-	if (result)
+	if (result) {
 		*poffset = data.offset;
+		*type_die = data.type;
+	}
+
 	return result;
 }
 
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index cd481ec9c5a1..b3ee5df0b6be 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -163,7 +163,7 @@ int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf);
 
 /* Find a variable saved in the 'reg' at given address */
 Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
-				    int *poffset, bool is_fbreg,
+				    Dwarf_Die *type_die, int *poffset, bool is_fbreg,
 				    Dwarf_Die *die_mem);
 
 /* Find a (global) variable located in the 'addr' */
-- 
2.52.0

