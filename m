Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5503115B8
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620033; cv=none; b=NFI+eQZq+08wClJV6qMUUnoPd361d2Wj11IhjR9eeUOFheo8oQUEXKlk6U7bqJMEKASuEPBQp3Ck8Q9i/Mi466OwL2KLkZLA1eLR65OGhLGJviudy5IYV8YPCSFctH25gXGdlb/Afllx9UWZbm9RT4O9BuGC/vmQkxjq5bVlD3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620033; c=relaxed/simple;
	bh=ygkZ2NV9CzXQEBLW75S0u9VO4UGEv71W7akG3FSI7SQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lkizUGjvBkgl50h2d4sqX4rz5Te+o3j42t2s4t/DW1d09nNgDr1SfBNwwI5K76fg0NdnL92z+gUFM1YoZeZsJf8U37N/J0GCFNEOWDwaT6fBF7SiJM5ijC1u7U7gvQoFTH+pXHMgX1LZhye5Q0qqR/R5+EWnYIr2KEGnxVNJFUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uiT74FlT; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uiT74FlT"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-342217d8d53so10702211eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 11:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790620028; x=1791224828; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nrFYfO1RB7wYUoxKF7HuImTU0zenJ98UxHD+fgpiL8E=;
        b=uiT74FlTZ6+/8tLaWGrYPPuIIPRTAnRkhc6wPWktWojizzXU+YriSvo/a51yIGPWa9
         ejpJfNVc2Z7d3+zal9FXmWbKQOLOr1NJ4b9rzPX9r4vZQHVL60IPOk3hm/oeqZQcGDdU
         NSgaDViXG5wVQXiNqSNPcZ9T+w7UV2c2jsSAhmFGNZfZQKBsD96rWsFMP3ND1Dw5F4tD
         wiJvYJ+KxDtAaqbY1dvUdtdEqOB93bUmd8aaBTT5nAUrb+yXshjiCrcuu0bmSACNjOD/
         vi2pa9spRpwTSZw6MGc/MygmGgK4EWSY247zySygmQf/yBL1SqC2LuZlTfzE1kVa9n+0
         Wj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790620028; x=1791224828;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nrFYfO1RB7wYUoxKF7HuImTU0zenJ98UxHD+fgpiL8E=;
        b=uIh/HFLr6v2rSCuVw1IRlwF6VSuyEfKJnumYyPmyI0RYdiCYK0OxWGyyhdTmAFm5WU
         YPz+HSRrYfTSYk42nDRNy8LKHjggtO504oR6r0RHPgiSbUWlXy9EH8BWv8SUr9i0qURR
         JF/j7lI1Vc4XHgbAAKquBmImxVExpM3clxaRIu4Hm+2xuX5InAlWlWj3Cb1ZSOlEblKR
         4aM3k5ao07cegll848cdia2TKe+z4G0l5X4ulKKOLQtCymwLE71a2OfTWzRPsadjI4dC
         5+x3+JLwLhmRwCmokUumn6VhDClxwwnVOCX5DiVGRnZY+1MJVh4HrUcHHpMz7SDU+RyL
         dg5A==
X-Forwarded-Encrypted: i=1; AKwUvBzpyu2PerSK0Ck4ZXnygXSQ9RUfw6h2Z7JSQqY3sL7vDno0lkqWiVubu8cs7iLbbRlpSW/pViDXg8H0xz7g3ZC6@vger.kernel.org
X-Gm-Message-State: AFuF++ngsWNjfGhZ5fnvZLBN4UUzvwSgjAOi3w7OdM8OJqoEICO0etqx
	+bQqM/02TTVZ22SHfhacIXXFd1HxEfjVnOPJ5fhp/q8kCjA0xyd6OeVaMijlEHHI1AlEpYYpg2r
	wh7JxMAmTWg==
X-Received: from dlbpu5.prod.google.com ([2002:a05:7022:e885:b0:144:f4b8:ee5e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:20de:20b0:145:5c7:71bc
 with SMTP id a92af1059eb24-146cddbcfddmr11474719c88.5.1790620028324; Mon, 28
 Sep 2026 11:27:08 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:26:04 -0700
In-Reply-To: <20260928182605.3649015-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com> <20260928182605.3649015-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928182605.3649015-26-irogers@google.com>
Subject: [PATCH v6 25/26] perf test: Remove exclusive tag from perf trace tests
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>
Cc: Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Namhyung Kim <namhyung@kernel.org>

Now it's safe to run multiple perf trace commands at the same time.
Let's make them non-exclusive so that they can run in parallel.

  $ sudo perf test 'perf trace'
  113: Check open filename arg using perf trace + vfs_getname          : Skip
  114: perf trace enum augmentation tests                              : Ok
  115: perf trace BTF general tests                                    : Ok
  116: perf trace exit race                                            : Ok
  117: perf trace record and replay                                    : Ok
  118: perf trace summary                                              : Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20250814071754.193265-6-namhyung@kernel.org
[ irogers: Keep trace+probe_vfs_getname.sh exclusive, as without BPF every
  perf trace opens its probe:vfs_getname* probe. ]
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/trace_summary.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/trace_summary.sh b/tools/perf/tests/shell/trace_summary.sh
index 273199a29a20..0e603addb2a9 100755
--- a/tools/perf/tests/shell/trace_summary.sh
+++ b/tools/perf/tests/shell/trace_summary.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf trace summary (exclusive)
+# perf trace summary
 # SPDX-License-Identifier: GPL-2.0
 
 # Check that perf trace works with various summary mode
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

