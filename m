Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9E3382F10
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777737444; cv=none; b=QllG7BeDafp+IMM8+ueWrmJyp6Obpo+TROUAuby7MMEcvodbxQUmqiaODhp309kGLbhSTGw5LkBgMjR4r7EK7e+mBGgOxjPKP+8yLx8zfGLVaGgEKjsjjgNeQtP988mJTsvbQ02rhUXuWHkMYTD2+qvCwPYCusFQNh3TsAQXN2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777737444; c=relaxed/simple;
	bh=ds1Oe0e0nvO55IkZQO1U/MiR+jF6HIuo5Gz4q8JrD1o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lLZ7Vpc5+jvKc7YLsNRP9k6+LHaCAqKTMfpZqgGz0E0/p9hBpIFCVJRwZHdpBzdawMfaNqvcJektfv3gckSlkVarH4l2dHUJDZAOuNyKriiH9FXPiiihW+kleWjmS6WfmvgqMfp7a5y7ZWEbZIjuE+342LkutPO2qXjQIhXnpUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ji+XLLX8; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ji+XLLX8"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1275c6fc58aso5582388c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 08:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777737442; x=1778342242; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gp66yLPVBQoGa/v+8cqVP0kxyXDV2z8u4Se4Pcb+AKo=;
        b=Ji+XLLX8A8aG/m4/caTzxVlUDRkVF4trrMjzpEX0E7lxVyMddpWmNPKOVZeKytDpoC
         /N37W+OnYSdo4kPlWKazLN8gDOr/4PQMxbdVXZLmTsfMbnGhvtF+9nwiLZevf3iI6Rgq
         k+gMuY+hMPieuCUMgxIIEkRs8V159aQhP2R6anng8OlulOsgOLfxGLKg5WieigIABkSF
         VGh9Qdiq2ej4vg6QyBgUF1ZxIghQu3R6iaGBIvGuzUxBzZDcMpXna3/xAB4OnwLttrX5
         t4fdTJcKF93eNGIq3WJ4L54IAkxdfS4rTWH+zgio9RfkhCGQM8MSrsTFhJ/4uP0U2D4H
         BsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777737442; x=1778342242;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gp66yLPVBQoGa/v+8cqVP0kxyXDV2z8u4Se4Pcb+AKo=;
        b=NapsT5QfHbbaSe+EcCCxp37lBJ292cPHGOyietnVySQTuiiPYTo5ehJtiVR/0kfly3
         VNnKNvdAUA/cEs9iVfE80fITKnHg0E2LOoG2e6DePzF9YiPCn6kG3xh94gDvnK7NrP0x
         RnvmNglOYFw5UAQo9Ro3PoXr1niUDw3KWJIW4UpLchbnxz4OE/8x5mkzKPd0ZxelV0/B
         pcZL9UasxCcdgsNoRPXmf6I8f77wg/XPXXKGgiFBOOZq3IfAj0YBDkA3wSFur3vrmdvm
         Qj4Zy0x2PFlZwgJK61akUp6s9PVEJadUKiUkkvnpCTIplud7nad7z8jUPAr1yBhqShb9
         vlrg==
X-Forwarded-Encrypted: i=1; AFNElJ+ClZKYo+55BB6HfhsxrMsVv301OmN0yU3RSlG7iIkdfG4+phNY9cT30IMf4DMaNu4UioDpuKeM2sPMwZj+AaY6@vger.kernel.org
X-Gm-Message-State: AOJu0YyONxn52rhOyx7EWnI0GTqVLUFkpSO5aVUKWk41pVxgf7MfvEwa
	44GL2KbIlGdsAwb1zb/YEPURJ6KEc9VekQlPSPKwBUci4Z4Nhd8qTMQW1541d1ktRr6/T7w6TxV
	Ev7WGd0vr6g==
X-Received: from dll26.prod.google.com ([2002:a05:7022:21a:b0:12d:b48e:8597])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:395:b0:127:3b1e:7e0e
 with SMTP id a92af1059eb24-12dfd807253mr1396621c88.20.1777737441668; Sat, 02
 May 2026 08:57:21 -0700 (PDT)
Date: Sat,  2 May 2026 08:56:51 -0700
In-Reply-To: <20260502155656.478642-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502064839.282422-1-irogers@google.com> <20260502155656.478642-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502155656.478642-2-irogers@google.com>
Subject: [PATCH v2 1/6] perf dwarf-aux: Fix libdw segmentation fault in cu_walk_functions_at
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Zecheng Li <zli94@ncsu.edu>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

A segmentation fault was observed in `libdw` when running `perf kmem`
with `--page stat` on some workloads. The crash occurred deep inside
`libdw` (specifically in `dwarf_child` and `dwarf_diename`) when
processing DWARF information.

The root cause was improper error handling of `dwarf_getfuncs` in
`die_find_realfunc` and `die_find_tailfunc`.

`dwarf_getfuncs` returns:
 - `0` on success (when all functions have been processed).
 - A positive offset if the callback aborts early (e.g., via
   `DWARF_CB_ABORT` when a match is found).
 - `-1` on error.

The original code used `if (!dwarf_getfuncs(...)) return NULL;`. On
error (`-1`), `!-1` evaluates to `0` (false), bypassing the error
check. Execution then proceeded as if a match was found, returning
uninitialized stack memory (`die_mem`) to the caller
(`cu_walk_functions_at`). When `cu_walk_functions_at` passed this
uninitialized memory to `libdw` via `dwarf_diename`, it caused a
segmentation fault.

Fix this by correcting the error check to `if (dwarf_getfuncs(...) <= 0)`.

Fixes: e0d153c69040 ("perf-probe: Move dwarf library routines to dwarf-aux.{c, h}")
Fixes: d4c537e6bf86 ("perf probe: Ignore tail calls to probed functions")
Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dwarf-aux.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 92db2fccc788..6752adca8ee8 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -171,7 +171,6 @@ int cu_walk_functions_at(Dwarf_Die *cu_die, Dwarf_Addr addr,
 	}
 
 	return ret;
-
 }
 
 /**
@@ -620,12 +619,13 @@ Dwarf_Die *die_find_tailfunc(Dwarf_Die *cu_die, Dwarf_Addr addr,
 	ad.addr = addr;
 	ad.die_mem = die_mem;
 	/* dwarf_getscopes can't find subprogram. */
-	if (!dwarf_getfuncs(cu_die, __die_search_func_tail_cb, &ad, 0))
+	if (dwarf_getfuncs(cu_die, __die_search_func_tail_cb, &ad, 0) <= 0)
 		return NULL;
 	else
 		return die_mem;
 }
 
+
 /* die_find callback for non-inlined function search */
 static int __die_search_func_cb(Dwarf_Die *fn_die, void *data)
 {
@@ -647,6 +647,7 @@ static int __die_search_func_cb(Dwarf_Die *fn_die, void *data)
  * die_find_realfunc - Search a non-inlined function at given address
  * @cu_die: a CU DIE which including @addr
  * @addr: target address
+ * @dbg: Dwarf session
  * @die_mem: a buffer for result DIE
  *
  * Search a non-inlined function DIE which includes @addr. Stores the
@@ -659,7 +660,7 @@ Dwarf_Die *die_find_realfunc(Dwarf_Die *cu_die, Dwarf_Addr addr,
 	ad.addr = addr;
 	ad.die_mem = die_mem;
 	/* dwarf_getscopes can't find subprogram. */
-	if (!dwarf_getfuncs(cu_die, __die_search_func_cb, &ad, 0))
+	if (dwarf_getfuncs(cu_die, __die_search_func_cb, &ad, 0) <= 0)
 		return NULL;
 	else
 		return die_mem;
-- 
2.54.0.545.g6539524ca2-goog

