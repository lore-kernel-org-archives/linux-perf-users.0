Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB12B286417
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Aug 2025 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151894; cv=none; b=lD+vXl5ejZktF5j9NFjhG31fnBd+JVCoQZxEk3uaS19FfZTw8dCYzslTyUgy9VD+NL81l6VnKW9JBIvHOy+j2HMz1Ko8znw/bssMJiSEM0nECHtBi0AUSxAejX7xbxKx6VdfsWUN1lMohUPkCTdBDXV4gISm/CNvY0is2vBZwUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151894; c=relaxed/simple;
	bh=szObGV+gwE7z1rj5+IXEnTs6yjSF2EZF1pz2whHhrL0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kCVZqP/VU3rFrmPufl0jxrHZ79DcWcCuX7Q0sVTw0eah7twODEffGwKZcGmFs5+SKHQqz6JLDUt4hRX6xLUid4D+oVPVrR7WUWq7bnGVgpS63z/hGohUYGAtIIl1hMo2Sbx2gsZOlykDKavJKANExD5SoNPa352BckNjE9OKVrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vUYLQlJQ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vUYLQlJQ"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e931c89608dso6464637276.0
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Aug 2025 12:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756151891; x=1756756691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ghjqEgsQklBtFU4Rwq5zn+ao1xU4h/z/1xnp/73adaE=;
        b=vUYLQlJQqlyeul8pcaV8PTG0e0+Ja9803M642G5zV75hSam1o2Q5FSF0zb/HrwrN1S
         UCz9Vnn+SmN0viL7l6IE5VKCzkGkes8xVqndnbyGiPGbCD7hRtZweB1Fw8B3dcRRoWV1
         0ctDADXHE2ddKpLw4kXS+0m9oISYoVpGZZoqhD3cYTqeEsbt6O/lxMITXD4ujBu/u0vJ
         9JIJwf+7d+rAiCsv1qZtjwu3yHTCaQSqVttQWl/FMLvwt3N8QRdmypY5F0HuCVOYCzSw
         DEyeMnNzo/ogZOQSYXeHYB8NQPNhGeWfESmhmRTXaozqQjwv31gQHuX3zlShBH1jv/R9
         9oxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756151891; x=1756756691;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ghjqEgsQklBtFU4Rwq5zn+ao1xU4h/z/1xnp/73adaE=;
        b=VYhqji1UrPVdLbwBsuySfTdESlG7K/0PwmBffUH53Np4MnZyNMJRJO412QcTMK9LjK
         hSB/WgehpfWa0iroOcDsPLvIXhlTJ7Ojlx7U423mbH4zZ8bi31KwdcaCQ4DdHceYxcoS
         nY9qj8DUmcdjsQhn5x5rDg9jUdDD4I+1R1qelaPW5VeItVy6QhEHNSvIF/gzsgCHmXtE
         /GBNnv1ei9IR5Xr54H6UexVYN2b7u7D9NsfevlEdpb2ma2QAeYXRTRS9TXzCyS4DopuD
         dHPN+i8bNCaIz6v6hZdRqtuuVYNXpa+CFW79gCH6uP6DiVHieAlMxQRbS5uVos8u8Dan
         a8Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWrU7onlYw4OIdvaaLzA1LVjL6TeKcfrZEtYoQ/2+3Bc9AOLUtEWVG7WWZwOqxm1aphvCq/OdxCcXfcLzOL4tKK@vger.kernel.org
X-Gm-Message-State: AOJu0YwSHRMHfb3ZJ5gaiYwL7HCUb3SN0cBvFm35De4d2D9gB9D6zLer
	slXcFT4d26p7UGXttgnj2g/6U+zILAwmpPhaTkF5NhIaMkR0pqn+wgKFeqJoItX259FsyKS5Ohp
	tuHTnvzPagw==
X-Google-Smtp-Source: AGHT+IFfH4xjYmswIJG4njl6lpYCfnR48saf3XIqsSRNR8vkz3EQ9W1pJZh7AaglfFMcit5X0DaOKaM427mS
X-Received: from ybbfp2.prod.google.com ([2002:a05:6902:2d42:b0:e94:ddd5:ab7f])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:e0b:b0:e95:14f5:5dc3
 with SMTP id 3f1490d57ef6-e951c4018femr12064077276.38.1756151890790; Mon, 25
 Aug 2025 12:58:10 -0700 (PDT)
Date: Mon, 25 Aug 2025 19:58:06 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825195806.226328-1-zecheng@google.com>
Subject: [PATCH v2 08/10] perf dwarf-aux: Skip check_variable for die_find_variable_by_reg
From: Zecheng Li <zecheng@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

In die_find_variable_by_reg, match_var_offset already performs
sufficient checking and type matching. The additional check_variable
call is redundant, and its need_pointer logic is only a heuristic. Since
DWARF encodes accurate type information, which match_var_offset
verifies, skipping check_variable improves both coverage and accuracy.

This change implements

- Return type from die_find_variable_by_reg via a new `type` field in
  find_var_data.

- In match_var_offset, use __die_get_real_type instead of
  die_get_real_type to preserve typedefs. Move the (offset == 0) branch
  after the is_pointer check to ensure the correct type is used, fixing
  cases where an incorrect pointer type was chosen when the access
  offset was 0.

- When comparing types from different scopes, first compare their type
  offsets. A larger offset means the field belongs to an outer
  (enclosing) struct. This helps resolve cases where a pointer is found
  in an inner scope, but a struct containing that pointer exists in an
  outer scope. Previously, is_better_type would prefer the pointer type,
  but the struct type is actually more complete and should be chosen.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/util/annotate-data.c | 12 ++++++++----
 tools/perf/util/dwarf-aux.c     | 30 +++++++++++++++++-------------
 tools/perf/util/dwarf-aux.h     |  2 +-
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index e067e91f2037..b1a4b02afeb1 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1551,19 +1551,21 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
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
@@ -1575,7 +1577,9 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 				pr_debug_dtp("type_offset=%#x\n", type_offset);
 			}
 
-			if (!found || is_better_type(type_die, &mem_die)) {
+			if (!found || dloc->type_offset < type_offset ||
+				(dloc->type_offset == type_offset &&
+				 is_better_type(type_die, &mem_die))) {
 				*type_die = mem_die;
 				dloc->type_offset = type_offset;
 				found = true;
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 6e8877ff2172..56e1b5690dc4 100644
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
@@ -1390,29 +1392,28 @@ struct find_var_data {
 static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
 			     s64 addr_offset, s64 addr_type, bool is_pointer)
 {
-	Dwarf_Die type_die;
 	Dwarf_Word size;
 	s64 offset = addr_offset - addr_type;
 
-	if (offset == 0) {
-		/* Update offset relative to the start of the variable */
-		data->offset = 0;
-		return true;
-	}
-
 	if (offset < 0)
 		return false;
 
-	if (die_get_real_type(die_mem, &type_die) == NULL)
+	if (__die_get_real_type(die_mem, &data->type) == NULL)
 		return false;
 
-	if (is_pointer && dwarf_tag(&type_die) == DW_TAG_pointer_type) {
+	if (is_pointer && dwarf_tag(&data->type) == DW_TAG_pointer_type) {
 		/* Get the target type of the pointer */
-		if (die_get_real_type(&type_die, &type_die) == NULL)
+		if (__die_get_real_type(&data->type, &data->type) == NULL)
 			return false;
 	}
 
-	if (dwarf_aggregate_size(&type_die, &size) < 0)
+	if (offset == 0) {
+		/* Update offset relative to the start of the variable */
+		data->offset = 0;
+		return true;
+	}
+
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
index f20319eb97a9..beb6926aaa71 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -167,7 +167,7 @@ int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf);
 
 /* Find a variable saved in the 'reg' at given address */
 Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
-				    int *poffset, bool is_fbreg,
+				    Dwarf_Die *type_die, int *poffset, bool is_fbreg,
 				    Dwarf_Die *die_mem);
 
 /* Find a (global) variable located in the 'addr' */
-- 
2.51.0.261.g7ce5a0a67e-goog

