Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94089269CFA;
	Thu, 22 May 2025 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747951904; cv=none; b=sca8UREPt+Wi1jP6whsNMAqTYIaA0XIZhFRSaDMKsJMlaBt5oVDSHUU6tOIJYWVHzy+1IIsHAMgkvBE9HjyaRL41947dVMVy6U8azDNOiAqE44WY3F/azNkrleSctJpcZbtMbKrK1w2jn2CTyvsuvdasoXk7frtTLgvJ47smOPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747951904; c=relaxed/simple;
	bh=KZiFQSdib5SAC4/JvoIWXS6NRECRieWGZ7Tfu3oNlvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tg68xcNu/KpCyE+H+IKCWyEO09JPmNKvV5QmMx5Oq4vBi2K3w8EBCmCyHFLfGx6Mr2W1hx883C107xKIH3UQw54d9rpORBf7AvBUD3K4Ljz0A4RdmanmAiNRlUaLxlE/bpARkGftL5Aw7i2tAwamgEKttw2OgBHgwxjsKP2alIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5M1xSyC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5M1xSyC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04787C4CEE4;
	Thu, 22 May 2025 22:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747951904;
	bh=KZiFQSdib5SAC4/JvoIWXS6NRECRieWGZ7Tfu3oNlvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k5M1xSyCLAaTzrGsViDJk/UZITks+AuMEgusboQ3J3QPmFPax50ttimc4GWI6nWFn
	 pBlXxxgBEZCKHNlYz1Y1OFZaB5hwRlzqTqIEHYCSCkeWC9a2KvYZJjyoN0ldcK4bUF
	 Uo1rkZSDzRH+B01crReH2jA7snhqYbC5THBZT0R0lJRPhy6WVyd2dtFc8E+zi5A0tg
	 BNkXlYNsvyR2eLYuUqb1izVqaKvar50bauW2DxBbOCBp3yX4oXNsMWCjkXP6v8Sjsl
	 J5nQhrJ2LcezDcr0VPJa7JEMeakduAbqrrYqarinIggJl79zecVg16VypxOB4y5TFq
	 W6f2QhbIqMrmg==
Date: Thu, 22 May 2025 19:11:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>, Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf test: Add cgroup summary test case for perf trace
Message-ID: <aC-hHTgArwlF_zu9@x1>
References: <20250522142551.1062417-1-namhyung@kernel.org>
 <CAH0uvoiZ2difXdPsjkdLikHTRwYROYUeuCdZ+gQ5uRfQ2rzwGQ@mail.gmail.com>
 <aC9VoTL_Cv4R7J-j@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC9VoTL_Cv4R7J-j@x1>

On Thu, May 22, 2025 at 01:49:37PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, May 22, 2025 at 08:33:16AM -0700, Howard Chu wrote:
> > $ sudo /tmp/perf/perf test -vv 112
> > 112: perf trace summary:
> > 112: perf trace summary
> > --- start ---
> > test child forked, pid 1574993
> > testing: perf trace -s -- true
> > testing: perf trace -S -- true
> > testing: perf trace -s --summary-mode=thread -- true
> > testing: perf trace -S --summary-mode=total -- true
> > testing: perf trace -as --summary-mode=thread --no-bpf-summary -- true
> > testing: perf trace -as --summary-mode=total --no-bpf-summary -- true
> > testing: perf trace -as --summary-mode=thread --bpf-summary -- true
> > testing: perf trace -as --summary-mode=total --bpf-summary -- true
> > testing: perf trace -aS --summary-mode=total --bpf-summary -- true
> > testing: perf trace -as --summary-mode=cgroup --bpf-summary -- true
> > testing: perf trace -aS --summary-mode=cgroup --bpf-summary -- true
> > ---- end(0) ----
> > 112: perf trace summary                                              : Ok
 
> Thanks, tested and applied to perf-tools-next,

But then when running all the tests, since this does system wide
tracing, it fails:

112: perf trace summary                                              : FAILED!

It works with the following patch applied, please check and ack/review:

From 8c868979d886e2e88aa89f4e3d884e1b6450a7b2 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Thu, 22 May 2025 19:01:47 -0300
Subject: [PATCH 1/1] perf tests trace_summary.sh: Run in exclusive mode

And it is being successfull only when running alone, probably because
there are some tests that add the vfs_getname probe that gets used by
'perf trace' and alter how it does syscall arg pathname resolution.

This should be removed or made a fallback to the preferred BPF mode of
getting syscall parameters, but till then, run this in exclusive mode.

For reference, here are some of the tests that run close to this one:

  127: perf record offcpu profiling tests                              : Ok
  128: perf all PMU test                                               : Ok
  129: perf stat --bpf-counters test                                   : Ok
  130: Check Arm CoreSight trace data recording and synthesized samples: Skip
  131: Check Arm CoreSight disassembly script completes without errors : Skip
  132: Check Arm SPE trace data recording and synthesized samples      : Skip
  133: Test data symbol                                                : Ok
  134: Miscellaneous Intel PT testing                                  : Skip
  135: test Intel TPEBS counting mode                                  : Skip
  136: perf script task-analyzer tests                                 : Ok
  137: Check open filename arg using perf trace + vfs_getname          : Ok
  138: perf trace summary                                              : Ok

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/trace_summary.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/trace_summary.sh b/tools/perf/tests/shell/trace_summary.sh
index bb350dfabdc2bf5e..49766524dc21b534 100755
--- a/tools/perf/tests/shell/trace_summary.sh
+++ b/tools/perf/tests/shell/trace_summary.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# perf trace summary
+# perf trace summary (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 # Check that perf trace works with various summary mode
-- 
2.49.0

