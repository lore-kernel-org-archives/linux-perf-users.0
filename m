Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AA42D9797;
	Wed,  7 Oct 2026 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791387113; cv=none; b=TgUnambzhbUidBB/o0sLof442HJ0OBxrbMoQudSCkDDUzm5xAg01yiGLWyDMqExhNkxLswFtpuYRKJVQYVm8BK6ZExZUmq7PbxdYO44v6oegELN5ZMXSDYmg5inAdioP5YatfiIGT4bg3Be+5k+DfgtMXl8H8COMFuHsMowVq8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791387113; c=relaxed/simple;
	bh=LPOEcdHq2apy1mUIcV7DDDIun01AlQm1IXhnJZ00uIQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oAarNTou3vwxbWmgOi+VwVpmUaF1goPZgzH0Gy+izT90dszRttea500K6gRRGIG6CFxYZIY4CJpAmVYwARZIXT1T2NpCUETfZfqGoQsX0l0FkIRbY3y5zTN0q8ZRGtEO3t9eJ66FGRTct5wV2g4CmIFfgJBuYETzDHhV7FcF2p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCz9UumV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCz9UumV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FF21F000FF;
	Wed,  7 Oct 2026 15:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791387102;
	bh=NeSUlDsVo1s6+AYYrQ/dOA7YcHXnvKye1ADL9d8nv6w=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=RCz9UumVg7MCcfX/YLxNtqhItlWET/Z1k3RTfAdRoaVqQs3a3NbcouYkfoRa6pqRa
	 jwfkKjqQFvJme9MJKzccjiWaBIYZnIQSr30tk3sN4Oj/ENR3fiTTmnTFWWwKGQFoeb
	 x9MjmhgJ0kmmNmAq7/tqTt3LsMeN1sIUKC0DCxHLXLAtieAlsD1mwQnpdmG5vQOb9x
	 gKl7THQ6pA6fWIQSfzbdAEF4m5wwnmOXtTZPUxHiS3kdutQ2LiJefIBqdvg40dMq37
	 aGslvNm0CR4bws0xNVP1YK9frHlVIP5ANSZZpLjn1VMDryR0iTmV1KpEpZDZdQ/QN0
	 RS+2rsBgM/2fw==
Date: Wed, 7 Oct 2026 09:31:36 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
cc: Chen Pei <cp0613@linux.alibaba.com>, acme@kernel.org, peterz@infradead.org, 
    mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com, 
    alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
    james.clark@linaro.org, leo.yan@linux.dev, john.g.garry@oracle.com, 
    will@kernel.org, mike.leach@arm.com, pjw@kernel.org, palmer@dabbelt.com, 
    guoren@kernel.org, linux-perf-users@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] perf tsc: Declare TSC support from the build
 system
In-Reply-To: <66136aa8-adbe-4fdf-9b7c-d44ea0e5cf1e@intel.com>
Message-ID: <d58889fc-71a1-0144-dc5a-4eb354536748@kernel.org>
References: <20260929034133.2153-1-cp0613@linux.alibaba.com> <20260929034133.2153-3-cp0613@linux.alibaba.com> <66136aa8-adbe-4fdf-9b7c-d44ea0e5cf1e@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 6 Oct 2026, Adrian Hunter wrote:

> On 29/09/2026 06:41, Chen Pei wrote:
> > The "TSC support" subtest of the "Convert perf time to TSC" test decides
> > whether the architecture is covered by matching compiler macros for
> > x86_64, i386 and arm64.  That list has to be edited for every new
> > architecture and can drift apart from the set of architectures that really
> > provide a counter.
> > 
> > Declare the capability where the implementation is, following the
> > PERF_HAVE_JITDUMP pattern: an architecture with a usable counter sets
> > PERF_HAVE_RDTSC in its arch Makefile, Makefile.config turns it into
> > -DHAVE_RDTSC, and the test keys off that.
> > 
> > x86 and arm64 keep the same behaviour, riscv starts running the subtest
> > where the previous patch defines rdtsc().
> > 
> > Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> 
> One minor style comment below.  In any case:
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Paul Walmsley <pjw@kernel.org> 


- Paul
