Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774081EFF93
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 00:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777768563; cv=none; b=j7S6xNRnDw69HnwZReqZyUpSg/zcEZ1bAX2WSes9WLNPDTk25lqvPTgyT6eOfFTe6T7HvoTJ/XTlK3QhZG12zUT+g/Gd6/qz3H0eNYTqqF/BEWL5py0QP2es2S+qLjZw3YdmYJYYx3jWptsQ+2iUpRHx1PvJnIdQHx+oSsu7j2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777768563; c=relaxed/simple;
	bh=B8lPhPkyBYn75j/w6V4mHVjbmAKvn0FEGtiJld/K6SA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G8GM6mU1GWCmKeliF2DAG3amNVS1/+Wj3moQYXBDfx+fSOwsyMJU3o2P2EZzaU3gTG5uvgjVBB5FH4SLJSmurG4fE+i6DETTaAtuNLNGOd2eRhrU780tHxHSuXGbDN2d4OUkMD3zMP1Hn813pk1deohLkqRdHESZXKVLpM6H2Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GVYhx4Sm; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GVYhx4Sm"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1275c6fc58aso5970220c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 17:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777768560; x=1778373360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/SLKmbcBWBxQ61L1rVy9BETcPORnn/ju3DpB5LsLCNU=;
        b=GVYhx4SmCkUahUyYkxySVLJW4tU5XiGoZQ+155l38fwY9CSlIA7Z5ey3UQG/RhkiVd
         l5O3yH9l/yaiOM8reTPnrRpDV5Tj3uLRGQePKHPIrtrdJtUVpeTKntNhC//yHn/BTutT
         S+4mPvgJj6FvjNsui1fZvwSs7R6F9+o8PSmhcA1CwLpsFMD9N0BUV8uw0CUs+dcGur+7
         KFpDRAC0/MRaKNEd6+GLX4f3yZ94aawgpWwfnryKyAw0Rpu9wbnA0t0d6whFGsXsN/DJ
         uH1LUki1UyjgFKNFqMDvZriaCV6InSLALPIlDPz3595d15Dq9QyrEVVZYtpVrAp4tdld
         10iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777768561; x=1778373361;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/SLKmbcBWBxQ61L1rVy9BETcPORnn/ju3DpB5LsLCNU=;
        b=NDrWLMTTSkrk1PuiWMR1z3ZlzfOwZw06eSrjs5p28mQbhzxBVuKGi6DAte97sBm4PE
         nYu64Nc0svN1WUQS+vKWq9+4uCxMaO0PSBVnmSqQUNGHjR9iVOgewwYjy5jmdd4/Ugq+
         MFDcHrcytOGq5jeD/cE22shEZnDDovjr0wfLXEN+cLwZQmLcycqKjR2vPj1KsHkBtH69
         7K6X5/OAYVlBV/TfnBmm0PktWoNEtCImmJIKIcQeAcfIeaoDlSS7JPfL9GrUpQkqMIAn
         vcKZPhsA6SGcLeC6BHLo1MQKQyfYZRTtXWFUP5UBgBZ9ZojhH56m8exWDprvkzdwobnO
         WLgg==
X-Forwarded-Encrypted: i=1; AFNElJ+78vb8AyV06b6r+VfOaNCaS/PUrJO9nK5+s1JSlR+75iNWFRHrYpGPaCQh6XM2qIlkqYu1HCu4X4ab54e0fbC+@vger.kernel.org
X-Gm-Message-State: AOJu0YwKm7+5Z28nvFQkzNlcwsFwA2ZjSPDv44NK65QfQCJtMeB+6uli
	F8s/aQOD1ec47eJ66joie7lIiZqCP3WGNXIChfEW4eBrq+ZprperRalQJovmHqU9QRo4NTM7ISf
	OFath6avyfg==
X-Received: from dlii2.prod.google.com ([2002:a05:7022:4182:b0:12a:7dc7:7b04])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6b81:b0:12d:ca31:f1b6
 with SMTP id a92af1059eb24-12dfd7be0a3mr2120634c88.18.1777768560323; Sat, 02
 May 2026 17:36:00 -0700 (PDT)
Date: Sat,  2 May 2026 17:35:48 -0700
In-Reply-To: <20260503003552.1063540-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503003552.1063540-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503003552.1063540-3-irogers@google.com>
Subject: [PATCH v3 2/6] perf dwarf-aux: Fix libdw API contract violations
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
 tools/perf/util/dwarf-aux.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 8e83cb2d565e..1168e69a9292 100644
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
 
@@ -796,8 +797,7 @@ static int __die_walk_instances_cb(Dwarf_Die *inst, void *data)
 
 	/* Ignore redundant instances */
 	if (dwarf_tag(inst) == DW_TAG_inlined_subroutine) {
-		dwarf_decl_line(origin, &tmp);
-		if (die_get_call_lineno(inst) == tmp) {
+		if (dwarf_decl_line(origin, &tmp) == 0 && die_get_call_lineno(inst) == tmp) {
 			tmp = die_get_decl_fileno(origin);
 			if (die_get_call_fileno(inst) == tmp)
 				return DIE_FIND_CB_CONTINUE;
@@ -949,7 +949,11 @@ int die_walk_lines(Dwarf_Die *rt_die, line_walk_callback_t callback, void *data)
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
@@ -1003,8 +1007,7 @@ int die_walk_lines(Dwarf_Die *rt_die, line_walk_callback_t callback, void *data)
 				    die_get_call_lineno(&die_mem) == lineno)
 					goto found;
 
-				dwarf_decl_line(&die_mem, &inl);
-				if (inl != decl ||
+				if (dwarf_decl_line(&die_mem, &inl) != 0 || inl != decl ||
 				    decf != die_get_decl_file(&die_mem))
 					continue;
 			}
@@ -1035,8 +1038,10 @@ int die_walk_lines(Dwarf_Die *rt_die, line_walk_callback_t callback, void *data)
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
@@ -1940,10 +1945,12 @@ static bool die_get_postprologue_addr(unsigned long entrypc_idx,
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
-- 
2.54.0.545.g6539524ca2-goog

