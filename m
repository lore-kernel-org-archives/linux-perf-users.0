Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5433FFAC7
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078969; cv=none; b=lJgjeJDY7uZpyrZnF1PFxbNEE+M+HWspbDlmpNbDxiSxWY4z4FgLXPm2vQcGAiYDW6g2mrx2FmiofpbprpRqsOrx8uJK0snlf3zOIQih4ZsXVEye6jRuWAybrPch6T4mf/paC1qKkvG9//yeSvZ4hREWo5ojCunvm8490xcyj3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078969; c=relaxed/simple;
	bh=yfqm2QIm9DrBHUBV2T+7awknKmkDXbJNSO4jPUJtrEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAxinJn5giegtNlcrS+3I+8RKIc0fScwqypjkwqZOPQrTcQv30H5tHFbKh84qKuGiRJYKYLyf8bS/YYTT74nj5LZpS2RZ7y5/0+fP9qARtiCimblE4JX49WvPbtzLawvWNiBlC/gHndQIOqS1DwOcn8f+JNh5OExHkyufmi5P4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=ebqiCELc; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="ebqiCELc"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64937edbc9eso10913745d50.2
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 10:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1773078965; x=1773683765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Icb2OeUbMfEBKUBW7i3iadIMPsLzVm7CTfwwfYCzkE4=;
        b=ebqiCELcg+zrBS777S3ABGM73wthsfcTxvO9/0Xgs1TizbLlqw870debfi2AsyEGsk
         8qki/M44WhuLQdT3jqG9syEqUxK2Hrh9pd6ilOeMXa45CR8K2cVRbERc51l70XXAOdIX
         I4HOloVN4Lfc0LYJjvT+5hWYysSuPjwlACrpXD5qAK8IwmpwIK8o6KtnQv/Yu1OZCV4J
         DOSSTC21o3Zn0X1dB+R5OuLyZ7A1jqw8P3CI6Dv9QcfB5zw/EcjWgveb9QxAKysfcjBC
         ldrBAa0CubgXisjpy9S+cUVWkTQYVgXqK5eu7ql0fh7Hlq7JSkMTwh6QcCXL9dx5ZRX9
         HIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773078965; x=1773683765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Icb2OeUbMfEBKUBW7i3iadIMPsLzVm7CTfwwfYCzkE4=;
        b=oDBZLRcTI+zC3WS8csuSGcItBsffPpGLyFQ1m7eSgUqWiqhBe84R4j0e3CNn3bfK5o
         3ByWCbQfFIVyEcUzY1+Is6snzasEgKFjeQCi51aTOB+3Ekv7ktjuQNsi2q6761G4Z2Ke
         f9dVqgnZ9/qDEyxU3uO7ph7fC1AUymp+HQqUiAczUQlOQx8poFKIXgmGLcQyniF18U5d
         hkJU1bO0jGVVqPNWcCDUyLHcN34TKbtiiiJ2W7DFut8CNn/GkX3P7wgsJybbqWTVuZS0
         XxDRA5reNExSawTFgqM70aYTecV5VQmOG1/3l5MMlZKVghEoLGyPFcXAIu1alhuLxhEG
         aYjw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ8YcTrF2IW/KEWSCcpliyuGRIoyJ6tKcZNXVlfebM3KWHauhnuzL15rDGtMuAPPCfF0UNp41MvTv8V9c9f8Xs@vger.kernel.org
X-Gm-Message-State: AOJu0YxO059UNEKcAwkaqsi+pJTDO2bug5kt1C2zTd5/CZDNJ3IxXClF
	D365kn0oMiWBgkk88c8EpTQABsDohsuE8xR9KHtipdFiOc/bmGemgghbfnh+l4BQc1mfCofuYEK
	9iSw66Q==
X-Gm-Gg: ATEYQzx+hNGh5L01KUP7VCmWnP68XxaDHcyPjZCWPTaJ1kh5cGd3SxM8NBWg5lEFj38
	bT2AyIp5VE6jrNj+wbyAWeYBD4aMNEpzjDngqDWOfRfxcpk/hkIq2RkunkmvgNQ+fLLDip1+Zxb
	56SSp39yJybNQ9od4BgXCF02/tyoS6oqkEuTiI5A03rDnezC8PHLawvRT4P867OiagBjTJdPZx4
	9he9FwfVQd3KvPVjYo8ZqqJ7vc6Qb4OasujcTZFy/HLG0vZbWJFl0wx+PtupVxt9mkf+2olGaSj
	pxCslt+YvtVE5CCd2VjzxOJNDgNwkjjCgfgIongoV90X+CJtiFL7fVmZ0v8dHSujtj7n81JLCGT
	20u4xMHHhM72vneOK6ev9koqmdUSVQ/7CNAvQCxHvIDbjydtM+APASFzzXIdUKswGz8U5LAcEyn
	7QBdHYibjsGC5o5JpKoHh2iAxyTdSBrSBtTTtxjEJgmhWpbQTt10FNcnpM
X-Received: by 2002:a05:690e:e27:b0:649:c308:90ab with SMTP id 956f58d0204a3-64d1418d3admr9582783d50.32.1773078964886;
        Mon, 09 Mar 2026 10:56:04 -0700 (PDT)
Received: from um773-cachyos.sd.ncsu.edu ([152.7.255.206])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d176e70e7sm4992535d50.20.2026.03.09.10.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 10:56:04 -0700 (PDT)
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
Subject: [PATCH v2 11/11] perf dwarf-aux: Collect all variable locations for insn tracking
Date: Mon,  9 Mar 2026 13:55:24 -0400
Message-ID: <20260309175546.916039-12-zli94@ncsu.edu>
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
index 0710c875416f..92db2fccc788 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1645,6 +1645,7 @@ static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
 	Dwarf_Op *ops;
 	size_t nops;
 	struct die_var_type *vt;
+	ptrdiff_t off;
 
 	if (tag != DW_TAG_variable && tag != DW_TAG_formal_parameter)
 		return DIE_FIND_CB_SIBLING;
@@ -1652,41 +1653,40 @@ static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
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
2.53.0

