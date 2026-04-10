Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640FF346781;
	Fri, 10 Apr 2026 22:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775858713; cv=none; b=EExETPh8oZp6JV6aiVkpdRstTmlkVf5kzmty96DD5BNjWLikylIGU9MWil+Wsucrw+J/4noNLYjXX4PE6OYuxZn0wAHwncDpP8XzIXmixc++g8jddfdsO3Whu8K/rkPkZcGXvezEZEcMlbSDd6agyonBj0/1lacr4KE3cQOghPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775858713; c=relaxed/simple;
	bh=1aGhOd3AxAlBekv6ZZLQoxDGrkSC+gUNZs2lFVEs6QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDpDs+dbfowq7hel9BlPLy9RVg2whp4yjr0sQrpIcapJfF4dx62cNhUbuT94mBeiFxFKUsz+Pl8G1gjzzXyqQrqzUhgH9kAvVPoaSgiPBPcWwgB+Xkpog3Ew0V7KoVCJ28xEQRQHVwoVInIIxlIiPyr7eHigBnSF/KsMh/9iQUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0D3VwgE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0D3VwgE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86022C19421;
	Fri, 10 Apr 2026 22:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775858713;
	bh=1aGhOd3AxAlBekv6ZZLQoxDGrkSC+gUNZs2lFVEs6QY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F0D3VwgEfA4Gcl4ZtdmHo3hzgBxOhkzxIU8sw54XsQGU/ywFJi8DvvRb/LGXrAt7s
	 kkPcKoSPLtw3DkaWllEPRvRqUkBrUNb+27QxNcYfM757IzWqUq63gfDaDhXxyj6wbO
	 iqDxeVqBSNHUfttFeAg11OXZdV8FcduMjJT+VwKbwDAWnAQEfcl4CPH21mkkRZ7398
	 fRDA5oZ82rpDFpTS3fE2R5Q4MN35soFHSJPIeavX6MoNWkE4reDmK2kibVzID4tuRg
	 7lKbhH/uR/8NyyjiIrKWV+lKDJ03AYMqqU7miCXMRqLQYbrZ1qFFBQGAT8QXFgXATg
	 RvTo8g1ec3r+g==
Date: Fri, 10 Apr 2026 19:05:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Al Grant <al.grant@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH v2 0/6] perf arm_spe: Dump IMPDEF events
Message-ID: <adl0FblAxDv_at28@x1>
References: <20260407-james-spe-impdef-decode-v2-0-55d3ef997c48@linaro.org>
 <adkqSLNceF2OQuBo@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adkqSLNceF2OQuBo@google.com>

On Fri, Apr 10, 2026 at 09:50:16AM -0700, Namhyung Kim wrote:
> Hi James,
> 
> On Tue, Apr 07, 2026 at 03:05:14PM +0100, James Clark wrote:
> > In the Arm SPE raw data dump, IMPDEF events aren't printed. Add the
> > ability to add names for some known events or print the raw event number
> > for unknown events.
> > 
> > For example:
> > 
> >   $ perf report -D
> > 
> >   ... ARM SPE data: size 0xd000 bytes
> >   00000000: b0 18 c6 32 80 00 80 ff a0  PC 0xff80008032c618 el1 ns=1
> >   00000009: 64 e7 42 00 00              CONTEXT 0x42e7 el1
> >   0000000e: 00 00 00 00 00              PAD
> >   00000013: 49 00                       LD GP-REG
> >   00000015: 52 16 10               	EV RETIRED L1D-ACCESS TLB-ACCESS
> > 
> > On N1 the event line becomes:
> > 
> >   00000015: 52 16 10                    EV RETIRED L1D-ACCESS TLB-ACCESS LATE-PREFETCH
> > 
> > Or on other cores it becomes:
> > 
> >   00000015: 52 16 10                    EV RETIRED L1D-ACCESS TLB-ACCESS IMPDEF:12
> > 
> > Signed-off-by: James Clark <james.clark@linaro.org>
> > ---
> > Changes in v2:
> > - Put MIDR in arm_spe_pkt (Leo)
> > - Use for_each_set_bit() (Leo)
> > - Use BIT_ULL() to fix 32bit builds (Ian)
> > - Don't call strtol() with NULL (Ian)
> > - Link to v1: https://lore.kernel.org/r/20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org
> 
> I'm getting this on 32-bit build.
> 
>   In file included from /linux/tools/include/linux/bitmap.h:8,                    
>                    from util/arm-spe-decoder/arm-spe-pkt-decoder.c:11:            
>   util/arm-spe-decoder/arm-spe-pkt-decoder.c: In function 'arm_spe_pkt_desc_event':
>   util/arm-spe-decoder/arm-spe-pkt-decoder.c:377:37: error: passing argument 1 of 'find_first_bit' from incompatible pointer type [-Werror=incompatible-pointer-types]
>     377 |                 for_each_set_bit(i, &payload, 64) {                      
>   /linux/tools/include/linux/bitops.h:55:38: note: in definition of macro 'for_each_set_bit'
>      55 |         for ((bit) = find_first_bit((addr), (size));            \       
>         |                                      ^~~~                               
>   In file included from /linux/tools/include/linux/bitmap.h:9:                    
>   /linux/tools/include/linux/find.h:118:51: note: expected 'const long unsigned int *' but argument is of type 'u64 *' {aka 'long long unsigned int *'}
>     118 | unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
>         |                              ~~~~~~~~~~~~~~~~~~~~~^~~~

I saw this as well.

- Arnaldo
