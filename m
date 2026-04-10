Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F123E022B;
	Fri, 10 Apr 2026 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775839820; cv=none; b=dUoobvFvIBafjqJ5vGFjglJf0XwpBbUPt6MbkLOJB5+J6dlVgfs6DQH2K3Ba6GoZCiM9JL3uTHr/mNVV3ggZEm0QjXF59ASR56WRVa95Ysey5vo1Upnn9rlgvO+Gzrz1dMrJhREzupIEmS62KGZBDzcPe70tTfo/evthOdaU6fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775839820; c=relaxed/simple;
	bh=pMfWqUL50U9uJZvRyzRrUAe3IDyJM8UFSorNX2tsNw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiD21udaevAJZqP/M+/XUPN04WrMl82Gmm+j+q8W1AEK3zsC0icLKlACPOuy6sLzzKSWrJkRotSgN/e41Ncik7h9vkUeUeHds2dgwZ9fLufnFvyXvabtrmRhzT8sZAuztJSsh2T65ur43j4rDPipsxFqERRGU4OrHm89q6jPw0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ny2puyZQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ny2puyZQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631D6C19421;
	Fri, 10 Apr 2026 16:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775839820;
	bh=pMfWqUL50U9uJZvRyzRrUAe3IDyJM8UFSorNX2tsNw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ny2puyZQhUYAM+38B7qKb965c/CJi/dQvWVVygiDPaMFJZfFaLeP4RaRskNk13DON
	 6ym39KDsGfHhM09JcFQzMTZ4PFIgyTaMSpY5XEykAzULo0NDROV+oxtP7Bf5sdtunF
	 2uAto/1nsJhOBTwGluX6gur+zNBhw9v9tqwrdd+IhTRWmFTmiqvZycWybZPc5KPUn6
	 Qzkza6IO6B4S2mALuqFGtJ1zDi2k2z6kFRaQyr49P1Y76rfgvW/08vSu+1edx0N0/O
	 nEXf2pVAL20jvy39DDLiQ9GD7aMHo6SZJQvxi1XUJ7coxL1a5SwdEyqW3vNiS3MCxt
	 LrhnR4ApN7WIQ==
Date: Fri, 10 Apr 2026 09:50:16 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Al Grant <al.grant@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH v2 0/6] perf arm_spe: Dump IMPDEF events
Message-ID: <adkqSLNceF2OQuBo@google.com>
References: <20260407-james-spe-impdef-decode-v2-0-55d3ef997c48@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260407-james-spe-impdef-decode-v2-0-55d3ef997c48@linaro.org>

Hi James,

On Tue, Apr 07, 2026 at 03:05:14PM +0100, James Clark wrote:
> In the Arm SPE raw data dump, IMPDEF events aren't printed. Add the
> ability to add names for some known events or print the raw event number
> for unknown events.
> 
> For example:
> 
>   $ perf report -D
> 
>   ... ARM SPE data: size 0xd000 bytes
>   00000000: b0 18 c6 32 80 00 80 ff a0  PC 0xff80008032c618 el1 ns=1
>   00000009: 64 e7 42 00 00              CONTEXT 0x42e7 el1
>   0000000e: 00 00 00 00 00              PAD
>   00000013: 49 00                       LD GP-REG
>   00000015: 52 16 10               	EV RETIRED L1D-ACCESS TLB-ACCESS
> 
> On N1 the event line becomes:
> 
>   00000015: 52 16 10                    EV RETIRED L1D-ACCESS TLB-ACCESS LATE-PREFETCH
> 
> Or on other cores it becomes:
> 
>   00000015: 52 16 10                    EV RETIRED L1D-ACCESS TLB-ACCESS IMPDEF:12
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> Changes in v2:
> - Put MIDR in arm_spe_pkt (Leo)
> - Use for_each_set_bit() (Leo)
> - Use BIT_ULL() to fix 32bit builds (Ian)
> - Don't call strtol() with NULL (Ian)
> - Link to v1: https://lore.kernel.org/r/20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org

I'm getting this on 32-bit build.

  In file included from /linux/tools/include/linux/bitmap.h:8,                    
                   from util/arm-spe-decoder/arm-spe-pkt-decoder.c:11:            
  util/arm-spe-decoder/arm-spe-pkt-decoder.c: In function 'arm_spe_pkt_desc_event':
  util/arm-spe-decoder/arm-spe-pkt-decoder.c:377:37: error: passing argument 1 of 'find_first_bit' from incompatible pointer type [-Werror=incompatible-pointer-types]
    377 |                 for_each_set_bit(i, &payload, 64) {                      
  /linux/tools/include/linux/bitops.h:55:38: note: in definition of macro 'for_each_set_bit'
     55 |         for ((bit) = find_first_bit((addr), (size));            \       
        |                                      ^~~~                               
  In file included from /linux/tools/include/linux/bitmap.h:9:                    
  /linux/tools/include/linux/find.h:118:51: note: expected 'const long unsigned int *' but argument is of type 'u64 *' {aka 'long long unsigned int *'}
    118 | unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
        |                              ~~~~~~~~~~~~~~~~~~~~~^~~~

Thanks,
Namhyung

> 
> ---
> James Clark (6):
>       perf arm_spe: Make a function to get the MIDR
>       perf arm_spe: Handle missing CPU IDs
>       perf arm_spe: Store MIDR in arm_spe_pkt
>       perf arm_spe: Turn event name mappings into an array
>       perf arm_spe: Decode Arm N1 IMPDEF events
>       perf arm_spe: Print remaining IMPDEF event numbers
> 
>  tools/perf/util/arm-spe-decoder/Build              |   2 +
>  tools/perf/util/arm-spe-decoder/arm-spe-decoder.c  |  17 ++-
>  tools/perf/util/arm-spe-decoder/arm-spe-decoder.h  |   3 +-
>  .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     | 144 ++++++++++++++-------
>  .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |   5 +-
>  tools/perf/util/arm-spe.c                          |  62 ++++++---
>  6 files changed, 158 insertions(+), 75 deletions(-)
> ---
> base-commit: 74e2dbe7be5037a5e5eed6bc1ad562747ac88566
> change-id: 20260331-james-spe-impdef-decode-d944f4fdcff7
> 
> Best regards,
> -- 
> James Clark <james.clark@linaro.org>
> 
