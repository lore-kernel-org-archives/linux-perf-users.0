Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91582C3242
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 02:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769479608; cv=none; b=pJAxebi7IvdhUcxDvWXcQHseoNRb46off5/DRI1f3CV51BzVQV9qIzOY3pNX/cywbEI3kekRU1RucYFU9xbJ4HbHuFS6Jq8UStxSN7TBrN4+FaWnCYLdbxKynoOgtz+6WJvYKu5g26lotJWFPH0yfy5LzOSRE+HX38GMECUYc8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769479608; c=relaxed/simple;
	bh=b57Ock6we7x/mhDuBxpj3syCmE1BZKO8JFrTsuTWzrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFBjmksc2/v1XLYerne4sBUrQ3Tg/S2R1LZm6ZVwE6LnbTFtZ2wqUPDScYfMVN0YIHomaygA4Q/nEkfSpsRm/FD7dTqdsFXsaI0+XMoCQenqe8yLwrLT9CKKDAk4oZvO/2N/6g+u5fhVIObgM4A8gFDJXNYczzHseC942dj3XEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=QdUEy+51; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="QdUEy+51"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6496a048323so2214696d50.3
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 18:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1769479606; x=1770084406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZ3wA5lS89Oy1XytQhdRYz1uEnxzfP2eJ7+UqS1aa2s=;
        b=QdUEy+51XjwAAw8kPv+ySk3/HVuTMqkTc7YE6oKek/EI4wD1yKmNv403Xq8RBvRTv2
         besMs1PL3sCJW/LzfRy+yWj4cYLJFYhjW0c/Di82hYRazUOID3PqRofwu3Niga9OxRlq
         TJq0ohw/8+EELNww+c1rGgIeNF0/h3s++1BJWieyRq/Wn1hwoyX3ZGTywTNWBDMM6NF7
         H1ygXrfcMbSMTJ6XQbMegICw9CJo7rqLiViKSYTwfQxGBLPzaTZaASAr8KSMeSPuxsyW
         SVbMPwcDPK5KGRAwcLhfEwcxrXPgMd8xiHoeNJZJSSEu1BLwhqfuBfYiEz1qWP+uRU3C
         LwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769479606; x=1770084406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TZ3wA5lS89Oy1XytQhdRYz1uEnxzfP2eJ7+UqS1aa2s=;
        b=a+kBxNewD9XGUs0zTKCgfCgNLDpOKA2+DmB97I5fLlrfR2gnF3MOfF0mLarlaDc5Ww
         UsTTTz32ylbsuChxCeXIRDKqu5gRALaJKdOB5EgCLEMoinilxQvbCu0CB71NSWH84VTg
         WTV4bcJuxgTFz20JLmIGPTMsh6/tgo4j8GdeyJbpgJYZtftIrYMjTbMVbcsrLnIlX6l3
         e2J9ydsf+9M7zs2LggUEf1g022+Y9H69gqluTiXxpwnpwQAMRRVpRRnLyRDcWD0vLnLR
         mbSleWSWQoSfn9lBJ53Ot0m+gQoHjL2Mu9Gee0qozsJJxVwDaA1ESEK751aHS5+blhmb
         K80A==
X-Forwarded-Encrypted: i=1; AJvYcCXz99+fkBIWb8c2NiviIl6BRBhcslrYNDdBUahucNTXXcJBJtkH3L80bm/Vc7aFjxJU9Dg1+jCJAOsuhMplsde4@vger.kernel.org
X-Gm-Message-State: AOJu0YzN5hWKJDNRpZDK5DesgNW4mvpOrg2pq17OXNRccKrCzxpXOOaT
	5Ai3eqnjwlFwTm7wSxpCYYEWZLAMHhoKEP7h0ZXSbzKWWQRpIm/eQBALw4tTSdUwug==
X-Gm-Gg: AZuq6aLLzsoEgUJuWyZ3OGZw22yDrIr+Faf9fP8e7LHL5rqqz2skMJqpb7Jn77Rdqe5
	kfsXLCkd+CZrIj9cyu168DgmH6pokdQPW3VU0AUZRZLjIDy7Rh1pvGorq1oTHh6aqXhg3yEKxK+
	emF8SHOk9c+v5CtK2uboh1wZyr2V1TWL/FshW6ps2h95WSL/YDlqkfIYqowHvo3qt3agAMtYRJR
	VUrL95Jn3PPcJIzIkiGWVsMUoU52ysemkB4syoHNMDjQXK0azrZYbZl+Lz1YFePkGp9MVdpsfSX
	NO3nA4FXpG/Xli5e8dLIUntdMAoRs9VVQoyUAWfQKWeFwtSnEpEeAFc2/xQ3UrixbQKbG3n2zwB
	imL2yH6mpVCrLfwyNDCADObgCpKILBBEfvnDbWDItECULRresn0m3UOHxsluuP6XibnUe7OwWc7
	MIh7GNDypTAg==
X-Received: by 2002:a05:690e:13c2:b0:649:3bd8:22b0 with SMTP id 956f58d0204a3-64970d3ee4cmr5023325d50.83.1769479605648;
        Mon, 26 Jan 2026 18:06:45 -0800 (PST)
Received: from um773-cachyos ([2600:1700:cc0:94af:eca6:9ff9:6f3c:5de9])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6496855d65esm4217415d50.12.2026.01.26.18.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 18:06:45 -0800 (PST)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 11/11] perf dwarf-aux: Collect all variable locations for insn tracking
Date: Mon, 26 Jan 2026 21:05:04 -0500
Message-ID: <20260127020617.2804780-12-zli94@ncsu.edu>
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

Previously, only the first DWARF location entry was collected for each
variable. This was based on the assumption that instruction tracking
could reconstruct the remaining state. However, variables may have
different locations across different address ranges, and relying solely
on instruction tracking can miss valid type information.

Change __die_collect_vars_cb() to iterate over all location entries
using dwarf_getlocations() in a loop. This ensures that variables with
multiple location ranges are properly tracked, improving type coverage.

Signed-off-by: Zecheng Li <zli94@ncsu.edu>
---
 tools/perf/util/dwarf-aux.c | 60 ++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index a05d73d6e9e7..3a028d4acb78 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1643,6 +1643,7 @@ static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
 	Dwarf_Op *ops;
 	size_t nops;
 	struct die_var_type *vt;
+	ptrdiff_t off;
 
 	if (tag != DW_TAG_variable && tag != DW_TAG_formal_parameter)
 		return DIE_FIND_CB_SIBLING;
@@ -1650,41 +1651,40 @@ static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
 	if (dwarf_attr(die_mem, DW_AT_location, &attr) == NULL)
 		return DIE_FIND_CB_SIBLING;
 
-	/*
-	 * Only collect the first location as it can reconstruct the
-	 * remaining state by following the instructions.
-	 * start = 0 means it covers the whole range.
-	 */
-	if (dwarf_getlocations(&attr, 0, &base, &start, &end, &ops, &nops) <= 0)
-		return DIE_FIND_CB_SIBLING;
-
-	if (!check_allowed_ops(ops, nops))
-		return DIE_FIND_CB_SIBLING;
-
 	if (__die_get_real_type(die_mem, &type_die) == NULL)
 		return DIE_FIND_CB_SIBLING;
 
-	vt = malloc(sizeof(*vt));
-	if (vt == NULL)
-		return DIE_FIND_CB_END;
-
-	/* Usually a register holds the value of a variable */
-	vt->is_reg_var_addr = false;
+	/*
+	 * Collect all location entries as variables may have different
+	 * locations across different address ranges.
+	 */
+	off = 0;
+	while ((off = dwarf_getlocations(&attr, off, &base, &start, &end, &ops, &nops)) > 0) {
+		if (!check_allowed_ops(ops, nops))
+			continue;
 
-	if (((ops->atom >= DW_OP_breg0 && ops->atom <= DW_OP_breg31) ||
-	      ops->atom == DW_OP_bregx || ops->atom == DW_OP_fbreg) &&
-	      !is_breg_access_indirect(ops, nops))
-		/* The register contains an address of the variable. */
-		vt->is_reg_var_addr = true;
+		vt = malloc(sizeof(*vt));
+		if (vt == NULL)
+			return DIE_FIND_CB_END;
 
-	vt->die_off = dwarf_dieoffset(&type_die);
-	vt->addr = start;
-	vt->end = end;
-	vt->has_range = (end != 0 || start != 0);
-	vt->reg = reg_from_dwarf_op(ops);
-	vt->offset = offset_from_dwarf_op(ops);
-	vt->next = *var_types;
-	*var_types = vt;
+		/* Usually a register holds the value of a variable */
+		vt->is_reg_var_addr = false;
+
+		if (((ops->atom >= DW_OP_breg0 && ops->atom <= DW_OP_breg31) ||
+		      ops->atom == DW_OP_bregx || ops->atom == DW_OP_fbreg) &&
+		      !is_breg_access_indirect(ops, nops))
+			/* The register contains an address of the variable. */
+			vt->is_reg_var_addr = true;
+
+		vt->die_off = dwarf_dieoffset(&type_die);
+		vt->addr = start;
+		vt->end = end;
+		vt->has_range = (end != 0 || start != 0);
+		vt->reg = reg_from_dwarf_op(ops);
+		vt->offset = offset_from_dwarf_op(ops);
+		vt->next = *var_types;
+		*var_types = vt;
+	}
 
 	return DIE_FIND_CB_SIBLING;
 }
-- 
2.52.0

