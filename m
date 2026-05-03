Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECE53CF67F
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777828249; cv=none; b=DsqXHgsuWRYV1BVgAo51kMq+Ti59CcjvJpGEP5CvEgxZZ1CEY4vAweN7uONp1UrtvMnQ8ASolnmG0P7GQmNxCz+YLGveUU1YY3lXv916p3hBYbSxaPNu2PtcPU4KaZIeWOp5qfk+YMP/HJ7I1MOIGSktQ++4RoZ+7PfwZ7Rv5jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777828249; c=relaxed/simple;
	bh=yjcs1D6pGw7KPynb26FlbUjS/OAEHH4cdgoxuoNVwLM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SW86Y6pmlrxyY4MIgENXc98c8gdUag0f1Q6ink2wGb0z0Cxh2CNAoaF8pudLl7WwEOI0eCnPHY9QCSEZquV7ZSkV+LPPrUxCiUIc66e+lY418Ypqk5/m+fQMThgRGG9lFPkgJ4F5AIz5czrEKW5KaLgFi89DZIaE1CfbmziSg8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cgKka/Iz; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cgKka/Iz"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ee34588671so2914286eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 03 May 2026 10:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777828247; x=1778433047; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n7qKK0k5c4yxl6VaFAc+LrAt0pI1jotb392xlOeZ7Wo=;
        b=cgKka/IzZQS6nNYL9/vSrn0Q4VdE901nUshVtR8mCJOUDZUJOj9iWq55oioU9rBjcL
         o21muNUCydCoxuZOGplz9gxaElVEaco3srTxPeNBpENWfRU/v2s3mOf/+EMP+XwAM2u/
         qYddpQ8n8qSmTPwD6JEhIZQDzpzkAmkR6k+ISwh2lkeUWDDQ+fCCD19bt20+DoAQ9YTg
         pXVlyJlJM0NWv+fqoKW2+JQ96GqFv0mfg9fgFxizIILoRhSyhu4EFk/ThgzP2qLeWa5P
         Rztk8IRfcm1fIP1SyCCKriKcchtffMOSXorxvNT73E3PQhxw9zQ2QagDdyfddadxKmUl
         e45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777828247; x=1778433047;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n7qKK0k5c4yxl6VaFAc+LrAt0pI1jotb392xlOeZ7Wo=;
        b=j2fAEagIeC8q2i2sv1kRIEpIIsQZnuayI3zwfZgWzS3VcVXLRiUDQ8YqQtD1pyW3Fw
         DyVz5TzvUpzB0MFik5k7PGn/V9qZH2lpD/EIrGMfkNBr0irq3zkX7jM0uGjDmApt3Nax
         /h4lOIMPGvsiQyG9laLxQDLXy/iwZBnaHa535mVwJypXQOl0KIZ9bNwlZ1zWqZwHU3oT
         XJkHMkzjf0Om9mPaN2LNPgF7HOSba5o6OTxfqDLblv1+iLgW67m0G9cb9AGuQ0HmIiyE
         SuukVFuq1XZ97Osw7mEDdI69BYcBiiqGZWSv39djMx+FB7bmr2SSWBpHV9iBYubKfymt
         S2QQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Fa09VzZ+FHmPuRHlxXHtydaIh35Vh18UmWchW6gplW4aw5EoknWJOqMbYdViqNxzsEwaYoWWSDls7SqEbGtgH@vger.kernel.org
X-Gm-Message-State: AOJu0YyJCwk/ilZD8jyGYgedHds9cFWe1JO3QVaUPy7dt4WxxgcqjuN9
	rkqgG/3Xd/MMdX97cPBloAP9NjDnCyf/uXjAwgb3MlAPrucFoYyseYyPX1KG96Rf2I6yg+ysqpz
	G/YhTYQs7xQ==
X-Received: from dybmk34.prod.google.com ([2002:a05:7301:ea2:b0:2ed:a84e:18d3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e68b:b0:2ea:4228:ab11
 with SMTP id 5a478bee46e88-2efb7ad867amr3108657eec.3.1777828247156; Sun, 03
 May 2026 10:10:47 -0700 (PDT)
Date: Sun,  3 May 2026 10:10:28 -0700
In-Reply-To: <20260503171032.1559338-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503003552.1063540-1-irogers@google.com> <20260503171032.1559338-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503171032.1559338-3-irogers@google.com>
Subject: [PATCH v4 2/6] perf dwarf-aux: Fix libdw API contract violations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Zecheng Li <zli94@ncsu.edu>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Check return values of `dwarf_decl_line` (where non-optional),
`dwarf_getfuncs`, and `dwarf_lineaddr` to prevent using uninitialized
stack variables or incorrectly reporting success on failure.

For the root DIE in `die_walk_lines()`, `dwarf_decl_line` and
`die_get_decl_file` are optional and their failures are handled
gracefully to avoid breaking line walking on valid functions.

Additionally:
 - Add NULL pointer protection for `strcmp()` in `die_walk_lines()`
   when `inf` or `decf` are NULL to prevent crashes on generated
   code.
 - Use `dwarf_attr_integrate` in `die_get_data_member_location` to
   correctly resolve inherited member locations (e.g. via abstract
   origin or specification).

Fixes: 57f95bf5f882 ("perf probe: Show correct statement line number by perf probe -l")
Fixes: 3f4460a28fb2 ("perf probe: Filter out redundant inline-instances")
Fixes: 75186a9b09e4 ("perf probe: Fix to show lines of sys_ functions correctly")
Fixes: e0d153c69040 ("perf-probe: Move dwarf library routines to dwarf-aux.{c, h}")
Fixes: 6243b9dc4c99 ("perf probe: Move dwarf specific functions to dwarf-aux.c")
Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
v4:
 - Fix strcmp(NULL) risk and inherited member location fallbacks in dwarf-aux.c.
---
 tools/perf/util/dwarf-aux.c | 34 ++++++++++++++++------------------
 tools/perf/util/dwarf-aux.h |  5 +++++
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 109a166a6d19..a8ab1c30d0ac 100644
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
 
@@ -459,7 +460,7 @@ int die_get_data_member_location(Dwarf_Die *mb_die, Dwarf_Word *offs)
 	size_t nexpr;
 	int ret;
 
-	if (dwarf_attr(mb_die, DW_AT_data_member_location, &attr) == NULL)
+	if (dwarf_attr_integrate(mb_die, DW_AT_data_member_location, &attr) == NULL)
 		return -ENOENT;
 
 	if (dwarf_formudata(&attr, offs) != 0) {
@@ -795,8 +796,7 @@ static int __die_walk_instances_cb(Dwarf_Die *inst, void *data)
 
 	/* Ignore redundant instances */
 	if (dwarf_tag(inst) == DW_TAG_inlined_subroutine) {
-		dwarf_decl_line(origin, &tmp);
-		if (die_get_call_lineno(inst) == tmp) {
+		if (dwarf_decl_line(origin, &tmp) == 0 && die_get_call_lineno(inst) == tmp) {
 			tmp = die_get_decl_fileno(origin);
 			if (die_get_call_fileno(inst) == tmp)
 				return DIE_FIND_CB_CONTINUE;
@@ -950,11 +950,6 @@ int die_walk_lines(Dwarf_Die *rt_die, line_walk_callback_t callback, void *data)
 		cu_die = dwarf_diecu(rt_die, &die_mem, NULL, NULL);
 		dwarf_decl_line(rt_die, &decl);
 		decf = die_get_decl_file(rt_die);
-		if (!decf) {
-			pr_debug2("Failed to get the declared file name of %s\n",
-				  dwarf_diename(rt_die));
-			return -EINVAL;
-		}
 	} else
 		cu_die = rt_die;
 	if (!cu_die) {
@@ -998,12 +993,11 @@ int die_walk_lines(Dwarf_Die *rt_die, line_walk_callback_t callback, void *data)
 			if (die_find_inlinefunc(rt_die, addr, &die_mem)) {
 				/* Call-site check */
 				inf = die_get_call_file(&die_mem);
-				if ((inf && !strcmp(inf, decf)) &&
+				if ((inf == decf || (inf && decf && !strcmp(inf, decf))) &&
 				    die_get_call_lineno(&die_mem) == lineno)
 					goto found;
 
-				dwarf_decl_line(&die_mem, &inl);
-				if (inl != decl ||
+				if (dwarf_decl_line(&die_mem, &inl) != 0 || inl != decl ||
 				    decf != die_get_decl_file(&die_mem))
 					continue;
 			}
@@ -1034,8 +1028,10 @@ int die_walk_lines(Dwarf_Die *rt_die, line_walk_callback_t callback, void *data)
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
@@ -1939,10 +1935,12 @@ static bool die_get_postprologue_addr(unsigned long entrypc_idx,
 			break;
 	}
 
-	dwarf_lineaddr(line, postprologue_addr);
-	if (*postprologue_addr >= highpc)
-		dwarf_lineaddr(dwarf_onesrcline(lines, i - 1),
-			       postprologue_addr);
+	if (dwarf_lineaddr(line, postprologue_addr) != 0)
+		return false;
+	if (*postprologue_addr >= highpc) {
+		if (dwarf_lineaddr(dwarf_onesrcline(lines, i - 1), postprologue_addr) != 0)
+			return false;
+	}
 
 	return true;
 }
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index a79968a2e573..161f0bf980b6 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -10,6 +10,11 @@
 #include <elfutils/libdwfl.h>
 #include <elfutils/version.h>
 
+static inline const char *die_name(Dwarf_Die *die)
+{
+	return dwarf_diename(die) ?: "<unknown>";
+}
+
 struct strbuf;
 
 /* Find the realpath of the target file */
-- 
2.54.0.545.g6539524ca2-goog

