Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297020;
	b=oIEfr2swiHElRWm3M/G0oiyjaagwJ2ENiRzmwKjW/wRNU0yHvQ5P+ZtltPppiHlyO56T
	 pQ0PeMKJsM249eQA0G0ULoe8YVIeWW7ioqs78scnQxFA4enXBjE88Vi3xX8f4qXdEoySp
	 tLrHkdZ1rFCYcAz5HbeREU30O++HBfmBqBx9VXr0C4Io+Z2mvo8qMWOE8gnM1OQF52Tku
	 YQuLkz1IqN0U0qEagr3D6eQ53qtpfmPw0bL5WSp7qlON03/4FBHAJ+guskmH6Pgi96Wnr
	 lkJXcXjUh5wDzo3rAxdtkCBB2f//eJPZ9OgaLkNysVqbdY3KxVNW7MYjnsc+YaDVIkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297020;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=63CZrMtGcQlClpiL21azWW0LHyKIVqNYpAKHa21JDoo=;
	b=dgKRAzTD9J9VrR7g2v1A3h2iGSCJtQJWs5eRvRpaQX++rrjUlFGj7Yle+HQ3Au70di6X
	 6uKbJq2qzUItbrWfwYcXLOWLV+CpWOpN+MrzGzFiiIootvips/obJlPEoTzd1sazNEYpt
	 hgjqeutcqQzslKXbcgN8PVoW2g3Cf/kFZRXm5uRVDq4Z2spUDsG0tuFGKHfpEI3KDTJos
	 LDS4AKkLh84soUM/3HvblXol5+L7zwLM2T2W9+2d3xKq6dadd8chQ0IIxZL2lLYEBAV9s
	 bRXFYxoaM4Ep6Z64iaTUPb6cH6XEXDjxXFdX6wYjNCjRpw3qq9XWVm+UQjolx60xayg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MNVGjWhQ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47888606A31C;
	Thu, 29 Oct 2026 18:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47888606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MNVGjWhQ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DA501682;
	Thu, 29 Oct 2026 11:03:35 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E77923F673;
	Thu, 29 Oct 2026 11:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793297018; bh=i8iHH4lB14MXZsmaBvM9GhJ2IkOhplEK+iLl3dHE+BU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MNVGjWhQQrvfjLwXQVHwIY9Gt/WjKBxsN3KkL/NCujlzi/NjOXdY7wGey76gB5QtY
	 +NNscg5odXnpfAwSyK29F0DnVe55rUgbiHK/scEPp7rw0Xj/yH5CHyxaHEr8DMuucr
	 kY6w7DE9juSejGZ87yReyMeGsp+EGaj2wJC+YdvQ=
Date: Thu, 29 Oct 2026 18:03:35 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Mike Leach <mike.leach@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Subject: Re: [PATCH v2 11/14] perf tests: Check CoreSight IRQ entry and exit
Message-ID: <20261029180335.GD9176@e132581.arm.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
 <20260923-perf_cs_etm_fix_non_taken-v2-11-6ab8c07a5455@arm.com>
 <d371220f-9ad2-41ca-a2a5-930c46801c31@linaro.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d371220f-9ad2-41ca-a2a5-930c46801c31@linaro.org>

On Tue, Sep 29, 2026 at 01:22:55PM +0100, James Clark wrote:
> 
> On 23/09/2026 16:21, Leo Yan wrote:
> > Add an AArch64 branch_not_taken_loop workload and a CoreSight shell test
> > checking IRQ entry and exit PCs. Use cpu-clock generates timer
> > interrupts.
> > 
> > Retry at different timer frequencies and skip if no complete pair is
> > captured.
> 
> Maybe we need to look into storing existing recordings somewhere or
> committing small ones into the repo again. This test took 3 minutes to run
> on my N1SDP, which is 3x longer than the entire Coresight suite, and then it
> skipped anyway:
> 
> 173: CoreSight IRQ entry and exit:
> ---- start ----
> test child forked, pid 6804
> Recording timer IRQs at 1000 Hz
> No complete exception entry/exit pair
> No complete IRQ pair in this recording
> Recording timer IRQs at 4000 Hz
> No complete exception entry/exit pair
> No complete IRQ pair in this recording
> Recording timer IRQs at 10000 Hz
> No complete exception entry/exit pair
> No complete IRQ pair in this recording
> [Skip] No complete IRQ pair after three recordings
> ---- end(-2) ----
> 173: CoreSight IRQ entry and exit
> 
> 
> Really this test is only looking for how a single exception on a single
> branch is decoded, it shouldn't be affected by how it was recorded. Even a
> few bytes of trace would be enough to test it. Or maybe we could add some
> kind of unit test framework that mocks out OpenCSD and allows us to script
> how different packets affect the decoder?

As discussed I will reduce the loop in branch_not_taken_loop.c and
don't skip the test if no IRQ pair found.

> > +++ b/tools/perf/tests/shell/coresight/irq_entry_exit.sh
> > @@ -0,0 +1,37 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# CoreSight IRQ entry and exit (exclusive)
> > +
> > +# shellcheck source=../lib/coresight_exception.sh
> 
> No need for these anymore, see https://lore.kernel.org/linux-perf-users/20260921-james-perf-shellcheck-source-v1-1-adcfc107c997@linaro.org/

Will do.

> > +record_trace_with_cpu_clock()
> > +{
> > +	local clock_opts=()
> > +
> > +	record_freq=$1
> > +	shift
> > +
> > +	# A zero frequency omits the cpu-clock event.
> > +	if [ "$record_freq" -gt 0 ]; then
> > +		# Generate timer IRQs without delivering a signal to the workload.
> > +		clock_opts=(-e cpu-clock:u -F "$record_freq")
> > +	fi
> > +
> > +	# FIFO control bounds the trace to the workload.
> > +	# --kcore supplies the running kernel's instructions for decoding.
> > +	taskset -c "$cpu" perf record -B --no-bpf-event --per-thread --kcore \
> > +		-e cs_etm/timestamp=0/uk "${clock_opts[@]}" \
> > +		-m,4M -D -1 --control fifo:"$tmpdir/ctl","$tmpdir/ack" \
> > +		-o "$tmpdir/data" -- \
> > +		perf test --record-ctl fifo:"$tmpdir/ctl","$tmpdir/ack" -w "$@" \
> > +		> "$tmpdir/record.log" 2>&1
> 
> There's a shellcheck warning here:
> 
>   (warning): Word is of the form "A"B"C" (B indicated). Did you mean "ABC"
> or "A\"B\"C"?
> 
> You can avoid it by passing the whole path as "$cf" and "$af" like the other
> coresight tests.

Will do. Thanks for suggestions!
