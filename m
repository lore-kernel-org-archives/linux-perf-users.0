Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E603C2FB99C
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 19:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139101; cv=none; b=ljaQPQ75lnKxnI1LeeT/3OpRQGh9dzCKQQuAK1o2Xk+Prh3vrZjytu0cuR0WMT83eE6cA8/D/ytN8HQe4BFCI2vqRGEPsYcahq45281icV6yJOKlqOCvVPjXBXJD931Bz/BbvvOY3y6dPuZ2W99LFGWZVLRzHuHFAFdY9t5b+3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139101; c=relaxed/simple;
	bh=fB/6i1qanI6SJs8QAzxHrArcw2uiQzagwE/LnBHWUVc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r6t353qcg5Pj4YxQE4yai67NjWJbCvdKsDDSyv0F1DhRPc+ROruvwwHILIe2adfok4uyuYYRUnmJ1QIkY0j40l19Of0zigoOKokMcXuRLwIxddyuOqhj7nnRZCjVEkZdUHGguFBP8ttUg6ivQosLuJDoZnkWFhkAvFNJqeBRJYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=foHAGZAb; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="foHAGZAb"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e934323e6d8so374574276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 12:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758139099; x=1758743899; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T4aZ86fc6szpTU0Yd+pCMzTGqFuiPjIauERb4YlvtW0=;
        b=foHAGZAbvdXHuRjqYhY+kDfrJdj9PvmEaopotQ8J7innL0lBwwNIt/BIOwmNV6OJqj
         G3uLkwjheHc/pNeXk29NEjCubXv8XtXc93E+5gEFNvgYT5VqSZL3ezMptOXRtUwFWM3n
         7I1SNemcoaxHZhxkNAnvpTua2uBCi8wFRGURxctrAvIinkccP15aP2N5Sp2nDbgX/BHP
         K56CHewbvyvRfGwPl9C2ZgaVB42e2yFnWE4ftqMpnAN2RW2MTu3SrnS9d0wGFlwM+8Z8
         UloFFUZ7+x1s1jllP+h3iJKLw8axbpg9cgdnSE8+bAKwia7zqdTnO1XziCDKBc95WaOO
         8vvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758139099; x=1758743899;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T4aZ86fc6szpTU0Yd+pCMzTGqFuiPjIauERb4YlvtW0=;
        b=QRa5ggH9skFXdY/+ZzhFLOn9OEGEgQ9HK0Wgf0EkUiiTqAdwaxBFNsEI23fbtouviV
         FNwQjqUyggcJVgpi7/btYnVAWmWUURqWLPtEpxDu1wzfjMQFYWKcMpIWw9GyI1QeYmvu
         wr6GmlcIb2zlyM6wJrETFGspQDFYPM/+cX04s8va0MOO4Jp1QKD+e7L569gfbFkGFv8R
         +i3HRy6XQPj69s8ZDWEUpRzui41l/o2niIasGOUhsDuS26XHHA4Ql33XFM07sOj3rJgw
         aivDfeHAlZmp7PemB1fyeRZoKzlzQIIVlTzLTGpxC30tEf5fyBFpGvJPWYvnesZdxwbP
         W4dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeY6CCbRsNi31J3Zn3lvnOcFtMGm/CU0oWca4j4xK5gw/E30V4JD0tM0LGKKrnATobUj61TluqYbFlbiHP3ogV@vger.kernel.org
X-Gm-Message-State: AOJu0YwEuFLD+auWlchzpUd13SC7hu9Yt3ISQTouHZqPgBx7E+FBN+US
	C9+YJM1QwTjsCT45AE480xCKMQGDLhaYYvAeu5WjrsH5rsRXXqUXACXtmJdm2WfHxwcdwZZpTNw
	9V6NtI7k0Bw==
X-Google-Smtp-Source: AGHT+IFbRYoLbefNIf9LIPamUpqMmx0NkDKL+ovOKnmXT2DhvKlRz6nOoq9G+z1EqrxiE2xu8RBFvItx5bky
X-Received: from ybey13.prod.google.com ([2002:a25:dc0d:0:b0:ea5:cbb5:9bb9])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:1884:b0:ea5:ce42:68c0
 with SMTP id 3f1490d57ef6-ea5ce427a12mr812601276.42.1758139098955; Wed, 17
 Sep 2025 12:58:18 -0700 (PDT)
Date: Wed, 17 Sep 2025 19:58:05 +0000
In-Reply-To: <20250917195808.2514277-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917195808.2514277-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917195808.2514277-8-zecheng@google.com>
Subject: [PATCH v3 07/10] perf dwarf-aux: Skip check_variable for die_find_variable_by_reg
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

Return type from die_find_variable_by_reg via a new `type` field in
find_var_data.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/util/annotate-data.c |  8 +++++---
 tools/perf/util/dwarf-aux.c     | 18 +++++++++++-------
 tools/perf/util/dwarf-aux.h     |  2 +-
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 68c69d343bff..7e4c045d0f4d 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1596,19 +1596,21 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
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
2.51.0.384.g4c02a37b29-goog

