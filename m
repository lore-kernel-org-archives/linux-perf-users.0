Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99706317148
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882360; cv=none; b=ge+c+Ny2miTZnjyb4ATN3RIpwPmVkgJDC/GYlPGY0jVd8LcacVQHeDPMtnRGt2zBjB8d6jUFJD5DLBSBohGiz19Zdl97N+hJci53VcePyZ5rIA/pNfSBeG3heFLKB2l1cW7A2rlhHdKgjZa8tHYvtkr6ZmtpIA2ZR34hpcF5iOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882360; c=relaxed/simple;
	bh=ezr8slRwH9n2ZV1JvOOFyTaI1PUIDpT5biKxWiOeQak=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=noejtGEWzrYF6XImMHJoo5NSGyN3X/59oOZUlmGjEpSFRWR0zcg43W4qlhmvZdfWxibws8mNDOy6p+xAS+tvsGZyzD8BjoyXDeEVNS90i7hR1HSIvWTHBffgEFpspbqHjM+4xZ2kKbS1DLuZQPMqhK8tIXu1xGOYu1vjjcwgRXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T7fRFx8x; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T7fRFx8x"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2eebb099efbso5408655eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 01:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777882356; x=1778487156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rAfUSIRolAH4G9771FLWXZbdPKkv4l0+2rHJCOKFAXw=;
        b=T7fRFx8xmJ4OqV6aYvmPw/0fVmDLkgOATqoy40OLol1/TUxbl7oJTj15vi75Eu+G6X
         ihCojoFVLQ4DYQiZsFIBdcHW0GpRA+R7Ge4Wmuo0AaECno3AoI4+zsK4UjY/YlZVK1SA
         qNM2IMojBNkaniJD+bIwHjFg6zUYtUuDk7PynO+QXWiikqKhn/PQ0j2HTP0D4Bv7AUAK
         Q+dNoIAU/mv3Tp7xOkkMJf3iGr697Rwz3/3Bvx1aTs5NI/71S+hVtb/Oj3FXaDAmby6A
         6Tnrg1YEvLez53rfH7BORjptl9tBzyP2Qmi+sIVHq0NTlQUhaU4wgzVx8JLyxL+ufekW
         vRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777882356; x=1778487156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rAfUSIRolAH4G9771FLWXZbdPKkv4l0+2rHJCOKFAXw=;
        b=HkVHSg00PErXBZqX1Q6IDRd/YagP5Zi+rugkr0YfXOO8DSPiYMDYhtUibV2wrDIV6K
         vpWZBIErmPYZ3DSK8ZYPdFPoRlVXfoxlhrwyP8L64NusupmV+sJKBYRZjJkL5xxzjltS
         QvtxPP1NsrO7s5f6lJ7GJF8qwVi9juXs/IBzdlT6cBYgTuSzwcDUXkhYJX4kqN4Irk8X
         6hhe745JyO6hxaJrtI1qYaQ0455htH7Nb3GYoBCq9LdgJ6Xan5i0L2HVCrJzhnpKlu5H
         lKAWG8KoY0RNmwkPciJY2FUegieAmH1ziAEmw7uOCcHzqvwpuiWEW2Ti7X1lfCs2cJW8
         m2+A==
X-Forwarded-Encrypted: i=1; AFNElJ/54Zpcn2TmGyx7dmPzxEmFqkmXEcSJP1mYJzfK2Z7WMBCYeXjLehBlBZRII3QjO1j2+EE/ga/+IKllOTtBVcIt@vger.kernel.org
X-Gm-Message-State: AOJu0YzDudFE3hQoBp8Og9a9KwtQd+pwN2JqJFo1g5HRNyMmjC8ocoML
	92VXTy2nPumifkTUjxVzlutlKd1q702nEfMhMhZKp1TRPe0BHCHijebNIlgtz2OmsVpuf8fpi9F
	QDHE1j0SDow==
X-Received: from dyx13.prod.google.com ([2002:a05:693c:820d:b0:2ed:b77f:b02a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:2b08:b0:2dd:c066:bf7
 with SMTP id 5a478bee46e88-2efb80c0c41mr3580658eec.11.1777882356366; Mon, 04
 May 2026 01:12:36 -0700 (PDT)
Date: Mon,  4 May 2026 01:12:20 -0700
In-Reply-To: <20260504081227.2203848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503171032.1559338-1-irogers@google.com> <20260504081227.2203848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504081227.2203848-3-irogers@google.com>
Subject: [PATCH v5 2/9] perf dwarf-aux: Fix libdw API contract violations
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
Specifically, remove the strict `!decf` (declared file) check that
would prematurely abort line walking on generated or artificial
functions lacking this optional attribute.

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
v5:
 - Updated commit message to explain optional DWARF attributes and decf check removal.
v4:
 - Fix strcmp(NULL) risk and inherited member location fallbacks in dwarf-aux.c.
---
 tools/perf/util/dwarf-aux.c | 34 +++++++++++++++++-----------------
 tools/perf/util/dwarf-aux.h |  5 +++++
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 109a166a6d19..d7160f87ac7d 100644
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
@@ -998,11 +993,12 @@ int die_walk_lines(Dwarf_Die *rt_die, line_walk_callback_t callback, void *data)
 			if (die_find_inlinefunc(rt_die, addr, &die_mem)) {
 				/* Call-site check */
 				inf = die_get_call_file(&die_mem);
-				if ((inf && !strcmp(inf, decf)) &&
+				if ((inf == decf || (inf && decf && !strcmp(inf, decf))) &&
 				    die_get_call_lineno(&die_mem) == lineno)
 					goto found;
 
-				dwarf_decl_line(&die_mem, &inl);
+				if (dwarf_decl_line(&die_mem, &inl) != 0)
+					inl = 0;
 				if (inl != decl ||
 				    decf != die_get_decl_file(&die_mem))
 					continue;
@@ -1034,8 +1030,10 @@ int die_walk_lines(Dwarf_Die *rt_die, line_walk_callback_t callback, void *data)
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
@@ -1939,10 +1937,12 @@ static bool die_get_postprologue_addr(unsigned long entrypc_idx,
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

