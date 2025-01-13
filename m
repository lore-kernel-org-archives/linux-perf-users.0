Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EE923A105;
	Mon, 13 Jan 2025 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779676; cv=none; b=HJCWDEi11wAD//7nQsWS6GDZwRd2OI/vXfgfLsBnefoS/z6OTb7bPcPQWwSnIXiNUgMA29f3oqZIE1QX1Lvn2mg+hBIkF9iFaEDEM1HLs5y0NRBvXVWqlEfv1WuPBFsSsB9jTuFQH+gHN/OkzucIXkhBQnn6W3LdM5I6yqes6rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779676; c=relaxed/simple;
	bh=dH/YbMwK9IrJFK2gys6RrpsjV02bYk/+hTb0jjXQCUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8m87r+HKK4vplaDJ9beiL3gqcKoINE8DcFr6PmrxYcHTE3fklcIpgTaaKr0s8AvgfkVvUye8+p5oI6cLeQZqu2npKINLnE2gmRANn5oQQbbf1X4Hh6VUFFEDHNZbYQVm2L+qkDk0EEOluxXZamSJ4XSvI1HBCwz8x0PVfoh728=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJKiE8kY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJKiE8kY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44B6C4CED6;
	Mon, 13 Jan 2025 14:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736779675;
	bh=dH/YbMwK9IrJFK2gys6RrpsjV02bYk/+hTb0jjXQCUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJKiE8kYMPIA+pSRO3LRi7ykQXYI0A1nqkfrmJRHQY4pf38QcIk0w/N9rYGyhTzyy
	 U1BcYrJoVmkTNs/4gR1ynvRCgorAqsNcFvO+6lcyvlECuOq1NgDxhS6GMHKoU5OtxT
	 pGQ+7HCemLoAZIXXm44pyrXgtDHRqO8Y/matY5NTPvKLqexvBAEJs3UHWY5exRO8He
	 GngkyMfB70hKeNgj3Hj7KYdAExsxjcmKddJlOu51iOV8m/ZG0BNjJm5+8wpk1Bu0sM
	 qgmZANOb7TGX/cJa0RRFZmSrkuptiLHa4K80EYnKZbQcBeBOFhPKufNVwDG32C6hIw
	 QL/IPEzpluR/Q==
Date: Mon, 13 Jan 2025 11:47:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH FOR-NEXT] perf tools: mips: Fix mips syscall generation
Message-ID: <Z4UnmCHYHAqpEF_1@x1>
References: <20250110-perf_fix_mips-v1-1-4e661c3b710a@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110-perf_fix_mips-v1-1-4e661c3b710a@rivosinc.com>

On Fri, Jan 10, 2025 at 11:22:51AM -0800, Charlie Jenkins wrote:
> The mips syscall generation was still based on the old method. Delete
> the Makefile since it is no longer needed with the new method of
> generation.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Fixes: 619ffe669496 ("perf tools mips: Use generic syscall scripts")
> ---
>  tools/perf/arch/mips/Makefile | 18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/tools/perf/arch/mips/Makefile b/tools/perf/arch/mips/Makefile
> deleted file mode 100644
> index 827168f1077a670d558878e4de2694ce2083d046..0000000000000000000000000000000000000000
> --- a/tools/perf/arch/mips/Makefile
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -# Syscall table generation for perf
> -out    := $(OUTPUT)arch/mips/include/generated/asm
> -header := $(out)/syscalls_n64.c
> -sysprf := $(srctree)/tools/perf/arch/mips/entry/syscalls
> -sysdef := $(sysprf)/syscall_n64.tbl
> -systbl := $(sysprf)/mksyscalltbl
> -
> -# Create output directory if not already present
> -$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
> -
> -$(header): $(sysdef) $(systbl)
> -	$(Q)$(SHELL) '$(systbl)' $(sysdef) > $@
> -
> -clean::
> -	$(call QUIET_CLEAN, mips) $(RM) $(header)
> -
> -archheaders: $(header)
> 
> ---
> base-commit: 01d08f525d260b547fd6dcf9fc8405219331bc34
> change-id: 20250110-perf_fix_mips-a72aa8326a10
> -- 
> - Charlie
