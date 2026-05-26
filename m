Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBD318EB0
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 00:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779754909; cv=none; b=MPC4o+qwYKKPN+d9fHBIbE0KOr2VHxrL1VcjPRBKHk/XuyFSXW5l3fiHKw+JxDp54ml5UCUcuWvdvY2Lirh4CICgMrlwEE0DW6P1f9uz5VL6tNWQSbT62/d7AEhLrHZiNXY3lvFslT424CA+1e7CQI/Pls9ev/+erIkMvJnvAYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779754909; c=relaxed/simple;
	bh=oJO6WiWM1OC4uA/XTtln85ObORmKmu07CtlXquy5EAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJ4iT8rlVDu46PUpxlsf4IxDfD4BzNoV+jhs501YBsO6v8e+S+f3qZTVOvsRUPpJOb7MQ1iRc/92tMah5YkJ1nkls2a2rS6IUNwjP4tIf+sMhm0mMOYPPHrKSupYWpdJ5sq8MrB9A0KCVSn1i8UkI44bsjwP/LpSFxl/KFfBMis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hq2ixnIp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hq2ixnIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B43A1F000E9;
	Tue, 26 May 2026 00:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779754907;
	bh=2aYWc8PUiYXRi4lGOabblXmb3uCLGzTj+CSJlDzlyl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hq2ixnIpEsKHjTNdTOt7t/QCj8/QYmtJ/exDyiXIoLlDne4mynceur8Fi5xTJSuoK
	 FPLY9FYJ6TEcJRCdihr6084Q8+NC0qyhKNfL86U6AUqC8WGtDvQuyrRreizT3YtYsv
	 rJCdkjboZEmEZf+Yy8rRumtEpfECDjayb2zIGd1ZOjoZYjWR2kuKbFUH9u1Sivi46I
	 sALGB47El1ZN542pTskfCyPyMMgByGDH2/48eoCwELuw28jV2PvW5SSWzpUdUjB7H2
	 QQwXbctmjkSZXXqrhV7b45YJDWp1LSih08dIY72K/CHhrtVVjMQpHzmUjyDQpBxwg+
	 8rUuWt3cyUuxQ==
Date: Mon, 25 May 2026 21:21:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: Summary of perf-tools-next changes and patches sent to
 linux-perf-users
Message-ID: <ahTnmDoG6i_7nO8-@x1>
References: <CAP-5=fX=vEmTaz6mWgExmrgyYMJmSyOD+1sMCzf7JTk1SkA-zQ@mail.gmail.com>
 <ahTmJyLLZYOPpnKa@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahTmJyLLZYOPpnKa@x1>

On Mon, May 25, 2026 at 09:15:35PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, May 25, 2026 at 04:35:51PM -0700, Ian Rogers wrote:
> > I've been working on a script [1] to summarize what's been sent to the
> > linux-perf-users mailing list (using nntp) and compare it to what's
> > merged into the perf-tools-next branch (using git). The idea is to
> > make it slightly easier to track down patches that might have been
> > missed. The script shows what has been merged and what's pending, what
> > Sashiko thinks, and whose turn it is to work on the patch (author,
> > reviewer or maintainer) using some naive tag analysis. The output is
> > quite large, so rather than adding it below, I will send the last 4
> > weeks in separate e-mail replies to this message.
> 
> I'm doing this locally as well, helps.

For instance, from earlier today: 

$ cat /tmp/outstanding.txt

Outstanding patches for perf-tools-next — 2026-05-25
(checked against next2/perf-tools-next)
=====================================================

Tier 2 — Likely ready, needs closer look
-----------------------------------------

1. perf stat: Fix uncore metric scaling across aggregation modes
   Author: Chun-Tse Shao <ctshao@google.com>
   Version: v3, 2 patches
   Reviews: Namhyung reviewed v1; no reviews on v3 yet
   Message-ID: <20260521201505.124690-1-ctshao@google.com>

2. perf python: Improvements and callchain support
   Author: Ian Rogers <irogers@google.com>
   Version: v9, 23 patches
   Message-ID: <20260522220435.2378363-1-irogers@google.com>

3. perf data ctf: Replace libbabeltrace with babeltrace2-ctf-writer
   Author: Michael Jeanson <mjeanson@efficios.com>
   Version: v1, 1 patch + Ian's 2-patch feature test
   Message-ID: <20260512194710.162215-1-mjeanson@efficios.com>
   Ian's follow-up: <20260512215621.468685-1-irogers@google.com>

4. perf test: Harness improvements
   Author: Ian Rogers <irogers@google.com>
   Version: v1, 14 patches
   Message-ID: <20260513230450.529380-1-irogers@google.com>

Tier 3 — Single patches, needs review
--------------------------------------

5. perf bench: Add --write-size option to sched pipe
   Author: Breno Leitao <leitao@debian.org>
   Version: v1, 1 patch
   Message-ID: <20260515-perf_bench_pipe-v1-1-3c5b805ba178@debian.org>

6. perf evsel: Fix error handling in tp_format lookup
   Author: Hongling Zeng <zenghongling@kylinos.cn>
   Version: v1, 1 patch
   Message-ID: <20260521025738.17867-1-zenghongling@kylinos.cn>

7. perf kvm stat: Update the exit reason mappings
   Author: Gautam Menghani <gautam@linux.ibm.com>
   Version: v1, 1 patch
   Reviews: Ian reviewed (needs v2 per feedback)
   Message-ID: <20260512120408.59332-1-gautam@linux.ibm.com>

8. perf build: Fix Python extension build with GCC 16 hardening
   Author: Jan Polensky <japo@linux.ibm.com>
   Version: v1, 1 patch
   Reviews: Thomas Richter Reviewed-by
   Message-ID: <20260520125637.105681-1-japo@linux.ibm.com>

Already merged in next2/perf-tools-next
-----------------------------------------

- perf tests: uncore/topdown event sorting (Ian, v8) — 9f116f4b811b
- perf build: parallel build cleanup (Ian, v7) — 85cc481af5ff + 5 more
- perf build: Update kernel headers (Namhyung, v3) — aa13e4b120f9..5a433107fab6
- Fix SIGCHLD vs pause() race (Swapnil, v4) — 35c9fb22000f
- Fix kwork ASAN + libunwind test (Ian, v1) — e898c505b0ee, fdec0a81cad5
- Fix cgroup metric with BPF counters (Ian, v4) — 65bd18199ad5, bd2a5be1fe73
- tool_pmu enable/disable (Ian, v2) — 0b18bced5444
- libunwind multiple remote (Ian, v5) — fdec0a81cad5
- tools/build: LLVM versioning (James, v2) — 98e68cb77823
- perf inject intel-PT LBR/brstack (Ian, v3) — daac18e7c42c
- perf trace --show-cpu (Aaron, v4) — e445b78ffb8d
- stat delay duration_time test (Ian) — f83deb058025
