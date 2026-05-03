Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E6A22F74A
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777828247; cv=none; b=UWSoOv6xvMTKrlqpjkj8RUU3SJKDzvol29t/7J+e6QgrryKhIvnX8W7+3PNce+h6LZK1mwEJjsZ/wgKz0sMSirtuk8JG5GDA46y+e3sBKb+/cHa1rnHY2c11PXkbuV7T+CrTnRkuzyADsSvxV0oAzXaS0USyw/45JZcYpdAjQkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777828247; c=relaxed/simple;
	bh=zbHYAlo7dJ6R+XPlY9Xu4bAywdb1MOjhflrOAQn4RfE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KZH17WBTn0NkxSOO5L/tDy0adL6nZ5VFmb8jR/1nQGJnbt+l3FeoYbPY2209rw/xn514MPY/oKb7Qjj5M+ymZftLkJQPMgLAd25jEmXpiRXG9G5Q5Nv9EP+Zc/zLuLTvJpNumVHfuYYQdfQN4Ee2hdTPqKN1zDWe4QR4sqOPtzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rdTCbWwr; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rdTCbWwr"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2efc342ef15so1844144eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 03 May 2026 10:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777828245; x=1778433045; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=unHJ4YhQvNl3r+8GWeRKMAqsKkQhrEiTWJRAvguRxRM=;
        b=rdTCbWwrAjavKDBmauD3N0cNuZ8nYZ1LDD2N0T7b0+CCk3xH5kj05HP/ihvOUNDF8Z
         55Ac6hcKUZLKFxUmocHjMQEu1K01xUQVVQkcB2gLOChAWTxbpobyiWVJ7pVp26vWhDUv
         0pGFrERSMlclqzJ5uj+ljMDcBlLM78YEiCIAmTzJ5Ot56jaypfFZHOKnHTLEzWpAGK6E
         z9Mi3/lbXtnEXMjK2Pn7/UC90GGBgmcJsKKEku93zZxKf/cJ+q0MmBe9fJCyrmgH77vq
         ell9DBXUm3XHHk1ToDySvkE9Eo6+p+HtaswmLl2vFZ+DsDi1o8UtAhZR6bJTCLpTgxsN
         PObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777828245; x=1778433045;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=unHJ4YhQvNl3r+8GWeRKMAqsKkQhrEiTWJRAvguRxRM=;
        b=pYD3SV3eQ8xhV9eRYkBqKemnW9bGG68zzzxlGcZtqq6fNP46xIE/Qs/cRMFdzb30u/
         FkWKABpMXYzTYsG0HSd/+2ATrCyYL8AjME6b5WOImLnx7MqF0PWve9DbuxgjKmB42ohH
         GCIFYPjKUdHIVtVZDRSwz1PfYrDI5RiUD3DzNoDIVnaKdwKNyj8NKh+kqWamWubK/YD7
         RLNMwY7BFs//jm0p88s+w+2NEA+z3LcHjdp889uIlLdm/Br6sNC7niI2jwdUnfMDv/A7
         rtT64noPK20l2R3f6vAY0sQe+DZzvIsI5GP0KC8AtLAh9/a9XEk9BsSr8XhJgb7zPoke
         5I7Q==
X-Forwarded-Encrypted: i=1; AFNElJ+ub+k8GCc2+QJpVAwaz4VcfS+TlvR07yHRkODkzYrH7wit22CNoLglq9pGXylCuJ+n5d2oO+42RKGmmFIFXu2X@vger.kernel.org
X-Gm-Message-State: AOJu0YyBhioelgGm5izXbLY8UvON/D3MP/LrASa2sEoTmmSTo3mLiGry
	V0oCKDELZmvsySNTEijS7Y2yhP3HhPrdZzMNHTD2t2rJrtZfJgt9scL6XaVJlX8mPhyakVxUAy1
	Lsgc9asammg==
X-Received: from dlbuy8.prod.google.com ([2002:a05:7022:1e08:b0:12d:cb64:e75d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4590:b0:122:2f4:b285
 with SMTP id a92af1059eb24-12dfd81a3a7mr3135963c88.25.1777828245223; Sun, 03
 May 2026 10:10:45 -0700 (PDT)
Date: Sun,  3 May 2026 10:10:27 -0700
In-Reply-To: <20260503171032.1559338-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503003552.1063540-1-irogers@google.com> <20260503171032.1559338-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503171032.1559338-2-irogers@google.com>
Subject: [PATCH v4 1/6] perf dwarf-aux: Fix libdw segmentation fault in cu_walk_functions_at
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
 tools/perf/util/dwarf-aux.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 92db2fccc788..109a166a6d19 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -171,7 +171,6 @@ int cu_walk_functions_at(Dwarf_Die *cu_die, Dwarf_Addr addr,
 	}
 
 	return ret;
-
 }
 
 /**
@@ -620,7 +619,7 @@ Dwarf_Die *die_find_tailfunc(Dwarf_Die *cu_die, Dwarf_Addr addr,
 	ad.addr = addr;
 	ad.die_mem = die_mem;
 	/* dwarf_getscopes can't find subprogram. */
-	if (!dwarf_getfuncs(cu_die, __die_search_func_tail_cb, &ad, 0))
+	if (dwarf_getfuncs(cu_die, __die_search_func_tail_cb, &ad, 0) <= 0)
 		return NULL;
 	else
 		return die_mem;
@@ -659,7 +658,7 @@ Dwarf_Die *die_find_realfunc(Dwarf_Die *cu_die, Dwarf_Addr addr,
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

