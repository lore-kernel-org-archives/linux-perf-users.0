Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F221DC9B3
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 00:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779755260; cv=none; b=ClEm+ng9ocD0uGg8aee4pu8xsfncOKhpapXYeVdiA22wXwVIu0jNIr+Be4VgzJaFmSW0e7F6VhjccrRFUeWjhdazDfIIFjKPiI3Uzh8M/TCG/ZJNz9o2PrxLjcI2gl8nbQI1NcT4Q+bPNhWbn6K+NphBK5imsuFvtgvNBLAmSqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779755260; c=relaxed/simple;
	bh=Ma15ZUBmePtiTo5Oak9wHf/2oDbsmHBtZ5j79KQWjNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyHwyrDlD8dUwoYLOvwBJ/UTARkEtLAbwMO7H6EmQ2xn6BWtU/2cBzogFdRvUYgTJ0jjTAfBfXGORV6dP6jk7aH4wnew+vXkaYoflBitbHzzxuqoCGvfPIMshCnfLreNiDGi8a3ynmhNnw4XqwrWNOjlvth7o8NHOt76tuzwTHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvJypeyg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvJypeyg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722DB1F000E9;
	Tue, 26 May 2026 00:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779755259;
	bh=Kqf7dliJdJsnn2jlxpt/z5y+LtdcG1GmFX4pn5QSIfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AvJypeygqcr8IVjFNhAF3Uaat/C2heQnKY9QdeVXM5vNgUEnlUFa3yuimEyPjnT2n
	 YH4o43XRhcZABGn86pNWzQz2T1ehPxL0nWXDWutlMRGKZfcHGKt78pZ0s2Dms1Lo4/
	 5E5+E30xXCfTh9TiAY8yEavbq1aYj8wysXHBMN6kYRO7i8iPaACzGdJ7UgP/VvUS7V
	 arNe6wI0JcOSJN5iFWddvyDNpfjrlHT9Agj4lNYFUWzwAaKQJ1fBUJzQRuTHGPG9nt
	 JMQ7YMcrYILxJBmQ3xHHh3YQjZyRYqxqZHiXG0uKyGQ6433A06lSbgLI0AkQA+xrPK
	 R4wWi+AgVGaKQ==
Date: Mon, 25 May 2026 21:27:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: Summary of perf-tools-next changes and patches sent to
 linux-perf-users
Message-ID: <ahTo9zn-NAw5fUb5@x1>
References: <CAP-5=fX=vEmTaz6mWgExmrgyYMJmSyOD+1sMCzf7JTk1SkA-zQ@mail.gmail.com>
 <ahTmJyLLZYOPpnKa@x1>
 <ahTnmDoG6i_7nO8-@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahTnmDoG6i_7nO8-@x1>

On Mon, May 25, 2026 at 09:21:44PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, May 25, 2026 at 09:15:35PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, May 25, 2026 at 04:35:51PM -0700, Ian Rogers wrote:
> > > I've been working on a script [1] to summarize what's been sent to the
> > > linux-perf-users mailing list (using nntp) and compare it to what's
> > > merged into the perf-tools-next branch (using git). The idea is to
> > > make it slightly easier to track down patches that might have been
> > > missed. The script shows what has been merged and what's pending, what
> > > Sashiko thinks, and whose turn it is to work on the patch (author,
> > > reviewer or maintainer) using some naive tag analysis. The output is
> > > quite large, so rather than adding it below, I will send the last 4
> > > weeks in separate e-mail replies to this message.
> > 
> > I'm doing this locally as well, helps.
> 
> For instance, from earlier today: 
> 
> $ cat /tmp/outstanding.txt
> 
> Outstanding patches for perf-tools-next — 2026-05-25
> (checked against next2/perf-tools-next)
> =====================================================
> 
> Tier 2 — Likely ready, needs closer look
> -----------------------------------------

I had alredy processed Tier 1 at this point so deleted it from the file
:-)

- Arnaldo
 
> 1. perf stat: Fix uncore metric scaling across aggregation modes
>    Author: Chun-Tse Shao <ctshao@google.com>
>    Version: v3, 2 patches
>    Reviews: Namhyung reviewed v1; no reviews on v3 yet
>    Message-ID: <20260521201505.124690-1-ctshao@google.com>
> 
> 2. perf python: Improvements and callchain support
>    Author: Ian Rogers <irogers@google.com>
>    Version: v9, 23 patches
>    Message-ID: <20260522220435.2378363-1-irogers@google.com>
> 
> 3. perf data ctf: Replace libbabeltrace with babeltrace2-ctf-writer
>    Author: Michael Jeanson <mjeanson@efficios.com>
>    Version: v1, 1 patch + Ian's 2-patch feature test
>    Message-ID: <20260512194710.162215-1-mjeanson@efficios.com>
>    Ian's follow-up: <20260512215621.468685-1-irogers@google.com>
> 
> 4. perf test: Harness improvements
>    Author: Ian Rogers <irogers@google.com>
>    Version: v1, 14 patches
>    Message-ID: <20260513230450.529380-1-irogers@google.com>
> 
> Tier 3 — Single patches, needs review
> --------------------------------------
> 
> 5. perf bench: Add --write-size option to sched pipe
>    Author: Breno Leitao <leitao@debian.org>
>    Version: v1, 1 patch
>    Message-ID: <20260515-perf_bench_pipe-v1-1-3c5b805ba178@debian.org>
> 
> 6. perf evsel: Fix error handling in tp_format lookup
>    Author: Hongling Zeng <zenghongling@kylinos.cn>
>    Version: v1, 1 patch
>    Message-ID: <20260521025738.17867-1-zenghongling@kylinos.cn>
> 
> 7. perf kvm stat: Update the exit reason mappings
>    Author: Gautam Menghani <gautam@linux.ibm.com>
>    Version: v1, 1 patch
>    Reviews: Ian reviewed (needs v2 per feedback)
>    Message-ID: <20260512120408.59332-1-gautam@linux.ibm.com>
> 
> 8. perf build: Fix Python extension build with GCC 16 hardening
>    Author: Jan Polensky <japo@linux.ibm.com>
>    Version: v1, 1 patch
>    Reviews: Thomas Richter Reviewed-by
>    Message-ID: <20260520125637.105681-1-japo@linux.ibm.com>
> 
> Already merged in next2/perf-tools-next
> -----------------------------------------
> 
> - perf tests: uncore/topdown event sorting (Ian, v8) — 9f116f4b811b
> - perf build: parallel build cleanup (Ian, v7) — 85cc481af5ff + 5 more
> - perf build: Update kernel headers (Namhyung, v3) — aa13e4b120f9..5a433107fab6
> - Fix SIGCHLD vs pause() race (Swapnil, v4) — 35c9fb22000f
> - Fix kwork ASAN + libunwind test (Ian, v1) — e898c505b0ee, fdec0a81cad5
> - Fix cgroup metric with BPF counters (Ian, v4) — 65bd18199ad5, bd2a5be1fe73
> - tool_pmu enable/disable (Ian, v2) — 0b18bced5444
> - libunwind multiple remote (Ian, v5) — fdec0a81cad5
> - tools/build: LLVM versioning (James, v2) — 98e68cb77823
> - perf inject intel-PT LBR/brstack (Ian, v3) — daac18e7c42c
> - perf trace --show-cpu (Aaron, v4) — e445b78ffb8d
> - stat delay duration_time test (Ian) — f83deb058025
