Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5351EA7DB
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 00:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777768560; cv=none; b=TNSzQmTPhAfn1LNM90kUlAnxyWZbf0SDIuuGLEFjYY3g4rHYnTXn4NRWdkk/dIb4skypaWqMNHQSFf5rakBtHUTIhLatEceDxOE4N4N3Mh1gFGncM5s/dpHMFGJuQ98MOox0uKTywXPk4rRmeUEzH5Mo6g4qaFeuJYFIgEHwhxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777768560; c=relaxed/simple;
	bh=8JZDj9FsSiFtZTgJv9NSa3FaiaAa+RxFIzAHyFIkhq8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PhfYGG4Qa6dW/BVAnBp2LT0LaAvSJjjtaSj9boEGO8+8YTPnKFY21Nnj6604jhhGgS9DFcQ9NsCFdy+ya+1qtnyA14Zhjp9ynwZdoDQbYZiEvMeMVA2yzjs/8rFOu4rOyQPTYH+7cImil4kjwj71At1DJKpFNBWfJ9hRE7BoHVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ljo7+TgZ; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ljo7+TgZ"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2f1383b7439so104160eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 17:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777768558; x=1778373358; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nVHNOFHXHM4bgQvRUpFKg8gW6bF51M9wm8EnPDqQV18=;
        b=Ljo7+TgZUdX/c40G455d1ej+qTGyPjSiSJ85cVY1lakQNlYbv15ckfUMzqAdx7uwt8
         7xBBb2QNfRuC0a4jZQ771h8dc2KPp1nGdVuZLTybCVyH4cO+8sHJc2ygRv0HoQX6b37V
         7Qw4sIhk75rU42evK9xIS+kjUu6/+bHDMU5M8BLWGWMFtTikioaSogX7ivrwfanRNW8e
         3GCJL7lbNmYTjb/6+35lcoK9V/8dJ6+zBqRrMN084wQY5i6vVJGfflhMgppJGmCkkNZy
         S/yw1jY0g6mTKG+ilrU9st2ZEK7HMLUDH+t2mP/0rDU5510kteZjWJlqLxrC+b2RdUS2
         mEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777768558; x=1778373358;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nVHNOFHXHM4bgQvRUpFKg8gW6bF51M9wm8EnPDqQV18=;
        b=Azy9vrxy6z740CWBF5vJOG/4UeviDPYjtWrPxblFbFbFrRP66g358iGqezGPg+g01W
         bPZwCxUlDnnoLuMHq9LAnVacyf76aaG7HS17jVz/ABowEuSsCISgQrERjymKGXXSZHLo
         bjEic9VQpf1Jk4OZ/Acypxc4pSRyA2FiCLcTDcKlYT2Af4mLZfuws5fxKZp/oW00p28I
         We0H43wE0/ius5UNPg2smXbOPI/OtA4Q+0uJCcLNM/2IhTYE8QSHZw2DUsfqO0EMnhMT
         LlxhpiO+Tu327BCLHkErV4QfvIjOlhOepTkMRbsOfSm0QUrGA0Dl/E1jY2B+iXaKPtjO
         etqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+aJ2uDQ2KdkSN8pXAw4mS5o8SW0G6OuC+M8uihkkvlR1m4EtnxXF+6+eMDnzzGVAi9j1120HerNjb1bmhEaasw@vger.kernel.org
X-Gm-Message-State: AOJu0Ywggh2zRDuIjAQ5O1RTjXAmIUIhFOCcb+rNa/Se6YovYdInl+hM
	lNnHf6GABUorA9LRIidM5+ag0x20yPkhB+VTH2dhBECFKd9QQWnSm0nF/eC12N8nBfJ87zgsvGC
	zJN1F5vUKjA==
X-Received: from dlbcm1.prod.google.com ([2002:a05:7022:6881:b0:12c:177a:ac1d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f416:b0:123:3301:a718
 with SMTP id a92af1059eb24-12dfd51fe0cmr1791428c88.1.1777768558425; Sat, 02
 May 2026 17:35:58 -0700 (PDT)
Date: Sat,  2 May 2026 17:35:47 -0700
In-Reply-To: <20260503003552.1063540-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503003552.1063540-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503003552.1063540-2-irogers@google.com>
Subject: [PATCH v3 1/6] perf dwarf-aux: Fix libdw segmentation fault in cu_walk_functions_at
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
 tools/perf/util/dwarf-aux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 92db2fccc788..8e83cb2d565e 100644
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
@@ -647,6 +646,7 @@ static int __die_search_func_cb(Dwarf_Die *fn_die, void *data)
  * die_find_realfunc - Search a non-inlined function at given address
  * @cu_die: a CU DIE which including @addr
  * @addr: target address
+ * @dbg: Dwarf session
  * @die_mem: a buffer for result DIE
  *
  * Search a non-inlined function DIE which includes @addr. Stores the
@@ -659,7 +659,7 @@ Dwarf_Die *die_find_realfunc(Dwarf_Die *cu_die, Dwarf_Addr addr,
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

