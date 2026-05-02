Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E211F38423D
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777737446; cv=none; b=hElwT7fVhRJVcW7MdJ38stOTlF742bYcnJHPG8oSTfAwwZyx3OYk4z/QRfLFkaSMcd41KONItVTj8J56F5cFH2MSsjFJjkWJhZ1YwEifcF8WH4KI64Hg3KYI/V1zdnB3zsg9fdd1wBOr4l4osThg85aBjKoIqC8n2pJ46q1ExX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777737446; c=relaxed/simple;
	bh=5gLxise+rZ+bFPmlstkxp+NbVs8kBWQOZpMC2jqtjrY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dSBE/JRMwyb+1KkmPKkwBmmMVVfpwDQOHyYrPTz0DxEorevQRCVz0nyf0UCPUZ9jG0YWJ9Ln17I0n0x1fAIWG0bZiOOBQiIVvDhRIGXwXmblEcUDIeLNKeMmsOiaRxgCyPCB97F8LiM8KUF+ypmhAZy/dx+aQ1C8hIo1HLWN00Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fh3aPr1d; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fh3aPr1d"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2da19227bc1so1532874eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 08:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777737444; x=1778342244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RFMu+NMSt8/XDqsoxIh3OWm3JYI+p2qOMDVKWn0qr8Q=;
        b=Fh3aPr1dmKp9lCYvg9EJPhMn+u4CgQaPDSf4sUsFddxWFyQlKsA4uz4QcBnPsdbQTc
         s8Mw5QnguELKWXaJrvwF4i+v5a2sCT2RLf0SJQ3j9/pfkFCuCQBnr4YiGumyTnXd356A
         7QTDZYPSiArYDHEFu4FqgCim+xNRexMMJjofD3dKrRv8h3c9Je+jhJNIXlASKj6x/0sm
         usvR9ZvmfUUhZZdQTNhRKZOGTSQBfb9M9ccxcL5LsolLI64bveRl3k30/L8RLoBdbVh3
         WNHv/kwg3Wb6xDHzBeFLl1hbb+h0Siin1MbH7uuOD58W3/KR9xw3qjGW7tcw9FWjc5tG
         /cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777737444; x=1778342244;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RFMu+NMSt8/XDqsoxIh3OWm3JYI+p2qOMDVKWn0qr8Q=;
        b=RV29bVzPSoBlmT6BOL6EiVbu+LBy/Jj2GbzBVr8ixMX5G1B1HMb5eejAJSvblCacUs
         suy9IrTz5Y87EjVcmNkXDqFfypF8LNEXEdnsABR5aaFs1zX/ixzwqIX6Mw6fxptwSJcs
         ATjazpk3AVTtWRpUQJctlmsFymPJgtjmRZXCayQk4SzoBpr5uh8dSloVFM97E0sk4c3p
         Omf30sb10lijHr8RAxli9/6Cen4WaleLK5FZZlMQXQtmG7z8M+uE6MDFa7VD8GRsqDGi
         hE4dbf3Ft1W5xT/Q6x4GFPytaGdQqQOkUOYlhIRbQjjpspBKNbs8zuMTCxc1DcilS9qx
         J6Gg==
X-Forwarded-Encrypted: i=1; AFNElJ90Up0ZZEnryF5W8NWT+CWZ5MHrnqCO8PDkCn9oJF55Htr7MQ9/DDDlbHPles4LtHbiZgihHeVtXZmb7q6XlvFD@vger.kernel.org
X-Gm-Message-State: AOJu0YyZRhM4pEb9trxqXCnTkxeO+AvMp2yMv+8XO7hl1BckSRsUhAy8
	ehsZSLW07RPlsoA8WDe54Mk+JqoEtukNxUQanweSMVHAMTT6qpHR4OpbmWLyb18QRpIBY1RRZun
	OqD6Jfx832g==
X-Received: from dlaj8.prod.google.com ([2002:a05:701b:2808:b0:12a:ad8d:be18])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2227:b0:12b:ec96:c936
 with SMTP id a92af1059eb24-12dfd7d11cemr1450375c88.14.1777737443762; Sat, 02
 May 2026 08:57:23 -0700 (PDT)
Date: Sat,  2 May 2026 08:56:52 -0700
In-Reply-To: <20260502155656.478642-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502064839.282422-1-irogers@google.com> <20260502155656.478642-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502155656.478642-3-irogers@google.com>
Subject: [PATCH v2 2/6] perf dwarf-aux: Fix libdw API contract violations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Zecheng Li <zli94@ncsu.edu>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Check return values of `dwarf_decl_line`, `dwarf_getfuncs`, and
`dwarf_lineaddr` to prevent using uninitialized stack variables or
incorrectly reporting success on failure.

Fixes: 57f95bf5f882 ("perf probe: Show correct statement line number by perf probe -l")
Fixes: 3f4460a28fb2 ("perf probe: Filter out redundant inline-instances")
Fixes: 75186a9b09e4 ("perf probe: Fix to show lines of sys_ functions correctly")
Fixes: e0d153c69040 ("perf-probe: Move dwarf library routines to dwarf-aux.{c, h}")
Fixes: 6243b9dc4c99 ("perf probe: Move dwarf specific functions to dwarf-aux.c")
Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dwarf-aux.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 6752adca8ee8..0b75b4af2b47 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -125,7 +125,8 @@ int cu_find_lineinfo(Dwarf_Die *cu_die, Dwarf_Addr addr,
 	    && die_entrypc(&die_mem, &faddr) == 0 &&
 	    faddr == addr) {
 		*fname = die_get_decl_file(&die_mem);
-		dwarf_decl_line(&die_mem, lineno);
+		if (dwarf_decl_line(&die_mem, lineno) != 0)
+			return -ENOENT;
 		goto out;
 	}
 
@@ -797,8 +798,8 @@ static int __die_walk_instances_cb(Dwarf_Die *inst, void *data)
 
 	/* Ignore redundant instances */
 	if (dwarf_tag(inst) == DW_TAG_inlined_subroutine) {
-		dwarf_decl_line(origin, &tmp);
-		if (die_get_call_lineno(inst) == tmp) {
+		if (dwarf_decl_line(origin, &tmp) == 0 &&
+		    die_get_call_lineno(inst) == tmp) {
 			tmp = die_get_decl_fileno(origin);
 			if (die_get_call_fileno(inst) == tmp)
 				return DIE_FIND_CB_CONTINUE;
@@ -950,7 +951,11 @@ int die_walk_lines(Dwarf_Die *rt_die, line_walk_callback_t callback, void *data)
 	/* Get the CU die */
 	if (dwarf_tag(rt_die) != DW_TAG_compile_unit) {
 		cu_die = dwarf_diecu(rt_die, &die_mem, NULL, NULL);
-		dwarf_decl_line(rt_die, &decl);
+		if (dwarf_decl_line(rt_die, &decl) != 0) {
+			pr_debug2("Failed to get the declared line number of %s\n",
+				  dwarf_diename(rt_die));
+			return -EINVAL;
+		}
 		decf = die_get_decl_file(rt_die);
 		if (!decf) {
 			pr_debug2("Failed to get the declared file name of %s\n",
@@ -1004,8 +1009,8 @@ int die_walk_lines(Dwarf_Die *rt_die, line_walk_callback_t callback, void *data)
 				    die_get_call_lineno(&die_mem) == lineno)
 					goto found;
 
-				dwarf_decl_line(&die_mem, &inl);
-				if (inl != decl ||
+				if (dwarf_decl_line(&die_mem, &inl) != 0 ||
+				    inl != decl ||
 				    decf != die_get_decl_file(&die_mem))
 					continue;
 			}
@@ -1036,8 +1041,10 @@ int die_walk_lines(Dwarf_Die *rt_die, line_walk_callback_t callback, void *data)
 			.data = data,
 			.retval = 0,
 		};
-		dwarf_getfuncs(cu_die, __die_walk_culines_cb, &param, 0);
-		ret = param.retval;
+		if (dwarf_getfuncs(cu_die, __die_walk_culines_cb, &param, 0) < 0)
+			ret = -EINVAL;
+		else
+			ret = param.retval;
 	}
 
 	return ret;
@@ -1941,10 +1948,13 @@ static bool die_get_postprologue_addr(unsigned long entrypc_idx,
 			break;
 	}
 
-	dwarf_lineaddr(line, postprologue_addr);
-	if (*postprologue_addr >= highpc)
-		dwarf_lineaddr(dwarf_onesrcline(lines, i - 1),
-			       postprologue_addr);
+	if (dwarf_lineaddr(line, postprologue_addr) != 0)
+		return false;
+	if (*postprologue_addr >= highpc) {
+		if (dwarf_lineaddr(dwarf_onesrcline(lines, i - 1),
+				   postprologue_addr) != 0)
+			return false;
+	}
 
 	return true;
 }
-- 
2.54.0.545.g6539524ca2-goog

