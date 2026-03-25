Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85919329C7C;
	Wed, 25 Mar 2026 20:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472361; cv=none; b=LeynlgUdtuTej8HJx8XJG1o+TixOXuj52jlPgvMAYSBrtYqCOHSoQEI2bF0oYv2nGrYs7v3quMIOrKQnhmcIgS9q7UrCqr0wnp0DgV0EMqJLjtN6oBBDtf1hqV9uXWCmeQEqrPGU+Fiiu4S+GyjvhIPRjsfdVZuNnt9LmVUMdgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472361; c=relaxed/simple;
	bh=qdsdhA5npi4oRBexj5sCJDIYNcI6ym0119Z97aIEc6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+HzyACwe2xhLuOaaBWMioYKs5RRn9dUi6yYQrcor9LZZQmSV59qIIaU8uXk8FvSyq7ccEhlfg4xPa6G15YDutMtf7O7jDzqsjs3A/4KJixxtbubCzzL1wYrnLI6jE3c3Zik1GiGisbS8eUJmPPgs1QgreJjDgthak2Md2uN8sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=o21ygcPl; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="o21ygcPl"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60B821D6F;
	Wed, 25 Mar 2026 13:59:11 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E17393F915;
	Wed, 25 Mar 2026 13:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774472357; bh=qdsdhA5npi4oRBexj5sCJDIYNcI6ym0119Z97aIEc6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o21ygcPlU7AURZMZKvatyP74R9xOQ63yqd8YIZYSSGt9t+8BRhYp0ZYwdZmYJn9r/
	 ibRksOelJ4X/EhaEAhlQ1cJxUM0GXICWO0iunePPp/aaNucxIaaI6vysaKTdkHugde
	 hdw2DocIW9wloqfcN2FwPEYgGfwoDQQBsIIk31JI=
Date: Wed, 25 Mar 2026 20:59:14 +0000
From: Leo Yan <leo.yan@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Denis Yaroshevskiy <dyaroshev@meta.com>,
	Dmitry Ilvokhin <d@ilvokhin.com>
Subject: Re: [PATCH v2] perf stat: Fix crash on arm64
Message-ID: <20260325205914.GA356832@e132581.arm.com>
References: <20260325-perf_stat-v2-1-d986ef5b9327@debian.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325-perf_stat-v2-1-d986ef5b9327@debian.org>

On Wed, Mar 25, 2026 at 03:24:30AM -0700, Breno Leitao wrote:
> Perf stat is crashing on arm64 hosts with the following issue:
> 
> 	# make -C tools/perf DEBUG=1
> 	# perf stat sleep 1
> 	perf: util/evsel.c:2034: get_group_fd: Assertion `!(!leader->core.fd)' failed.
> 	[1]    1220794 IOT instruction (core dumped)  ./perf stat
> 
> The sorting function introduced by commit a745c0831c15c ("perf stat:
> Sort default events/metrics") compares events based on their individual
> properties. This can cause events from different groups to be
> interleaved, resulting in group members appearing before their leaders
> in the sorted evlist.
> 
> When the iterator opens events in list order, a group member may be
> processed before its leader has been opened.
> 
> For example, CPU_CYCLES (idx=32) with leader STALL_SLOT_BACKEND (idx=37)
> could be sorted before its leader, causing the crash when CPU_CYCLES
> tries to get its group fd from the not-yet-opened leader.
> 
> Fix this by comparing events based on their leader's attributes instead
> of their own attributes when the events are in different groups. This
> ensures all members of a group share the same sort key as their leader,
> keeping groups together and guaranteeing leaders are opened before their
> members.
> 
> Reported-by: Denis Yaroshevskiy <dyaroshev@meta.com>
> Fixes: a745c0831c15c ("perf stat: Sort default events/metrics")
> Tested-by: Dmitry Ilvokhin <d@ilvokhin.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>

As Arnaldo mentioned in v1, I also found Segmentation fault when
testing this patch:

 Program received signal SIGSEGV, Segmentation fault.
 metricgroup__copy_metric_events (evlist=0xaaaaab037750, cgrp=0x0, new_metric_events=0xaaaaab038210, old_metric_events=0xaaaaab038d20) at util/metricgroup.c:1662
 1662                    evsel = evlist__find_evsel(evlist, old_me->evsel->core.idx);
 (gdb) bt
 #0  metricgroup__copy_metric_events (evlist=0xaaaaab037750, cgrp=0x0, new_metric_events=0xaaaaab038210, old_metric_events=0xaaaaab038d20) at util/metricgroup.c:1662
 #1  0x0000aaaaaab05870 in add_default_events () at builtin-stat.c:2110
 #2  0x0000aaaaaab08300 in cmd_stat (argc=0, argv=0xfffffffffaa0) at builtin-stat.c:2838
 #3  0x0000aaaaaab40998 in run_builtin (p=0xaaaaaaf9d428 <commands+360>, argc=4, argv=0xfffffffffaa0) at perf.c:348
 #4  0x0000aaaaaab40c14 in handle_internal_command (argc=4, argv=0xfffffffffaa0) at perf.c:398
 #5  0x0000aaaaaab40ddc in run_argv (argcp=0xfffffffff8bc, argv=0xfffffffff8b0) at perf.c:442
 #6  0x0000aaaaaab41110 in main (argc=4, argv=0xfffffffffaa0) at perf.c:549

Last week I tested v1 and confirmed the issue was gone with the change,
I will dig a bit in tomorrow and share back if any finding.

Apologies for my lazy, as I should double check once Arnaldo
pointed out in v1.

Thanks,
Leo
