Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD10B315D58
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882357; cv=none; b=b7S6FzsmSFTEn/uFHq+IAr22WnHdwKTk4fK771iUyZH4thzlNmkL/fLStvr5MIM8RmLzOau9dWtqECzIhVLn6FftHpsztl17oTiKCgXI3wsy6XfCrJg5zIMbKF6T/MvOs4AzWP3AwWa6YEfJmHynczQdssdcRrscxPdX57syzaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882357; c=relaxed/simple;
	bh=5S4ftJhHFEh1+pRNFqbdm9P+7JMRGdcHcrazpcFSIH4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o7pjxCqZyuOdnvoYDI5xUm5RnPEF5J0DK1R66x3LwxVRW+D7DGqQAIxm61eQ1VjwHVPQBIPF2TYPM4L5SQHCiUp4r7CrgghYAUOORbkAnt8TP8DS+3Iwbn+6ltTrwSOpaOwhjp5BJ74MJBAkQuHcuqwPMgCKqw0C9165jpLXeeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LqS3Pi9t; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LqS3Pi9t"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dfb99429bso4258982c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 01:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777882355; x=1778487155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UHBWWeBIGUlnWgiBEv8UalMVR2CPIvNqegyFZXfMREk=;
        b=LqS3Pi9tChCFHcmChyml9OEVhYmqmCjotkZ96AkJDimbg//KaNir2QTyZRCTeWNWpi
         INsUuA/sWJ3UgYdNPyeKYanlhDDgcqfvefpxP0FAE1QymhSRB++tpMiSFf28L4xlL8xR
         kEyyY0KY3Vh8iAXuEJecZVRcJRD3XtiJcegmFRmaf9r9aCtMLVZFbK73NiUaQHPtI1ix
         pV9p768nBQxgTJ5lBscZiborHL2ietIgMLLEZSGKOPnI/Lw60kP3o6nkL0LQfxwC06Jz
         K/CHPuZNehhczZWFaUfGJPPtDSFhJciSw+7QZmEV70y8z20OUTPGzv/+87n9LY9OzqUw
         tI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777882355; x=1778487155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHBWWeBIGUlnWgiBEv8UalMVR2CPIvNqegyFZXfMREk=;
        b=NOYYiX65uJimKmnbD8w5KWqM7OGMiMKEndcGxVD0xg76ggMg+F5z1m4NnXUQJLbFtw
         b4yxsw9T/YLnlnx3RXuTSuyeDIq1HjmfI5vGEJA4VNoTy97Um2caZ+5EaNXV4rauO/Vo
         m8MQ9EQPngmylPcn3VEZg1noOmMn7BLqzLCfd6pkaWSYFIhpRa9KL3tou2mfMmTPXFP7
         XXxPYDirCcCHpFTq8C/QcV51X4fE1ess/h3gUnJuuvDzI/MMbqS3U6yMXBrq6hDpllpz
         fx9+gCqqMdDJfUvO/WttjWC3ePEKUwYxp/N712hSPxMB/nI+3DOru68XRaQTVATpyuFY
         BmVg==
X-Forwarded-Encrypted: i=1; AFNElJ/jU4pNVBd6lkHYbN4C48EsMNwXUofVEeVZhnRkUlp23OAcvYkonvNPwhh9l9bhGMJEAlX8LXI0SFVHcrZ5/Sun@vger.kernel.org
X-Gm-Message-State: AOJu0YznNqWuYirkTlXMzbon7DWG3mSX2VdXq+iBcPOZ8ODYqXEgY7WG
	UxOD3a4gQxHDUy6e7ox1u3LcOnuD/PQLDy52lfbUt2oE7mjEemEMpYZdxsvV7qnOfyuMo5NEHE0
	MvreVs6GCkw==
X-Received: from dlb14.prod.google.com ([2002:a05:7022:60e:b0:12d:f5ca:970e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6286:b0:128:dbbf:fd35
 with SMTP id a92af1059eb24-12dfd824f81mr4009724c88.28.1777882354591; Mon, 04
 May 2026 01:12:34 -0700 (PDT)
Date: Mon,  4 May 2026 01:12:19 -0700
In-Reply-To: <20260504081227.2203848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503171032.1559338-1-irogers@google.com> <20260504081227.2203848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504081227.2203848-2-irogers@google.com>
Subject: [PATCH v5 1/9] perf dwarf-aux: Fix libdw segmentation fault in cu_walk_functions_at
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
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
v5:
 - Added Acked-by tag.
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

