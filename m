Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4CA37E5E2;
	Thu, 27 Aug 2026 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859421; cv=none; b=Ow4UNY7CHZeZc/25POtpNrqmQYAPpe7I7rCkriY/yYeaEeNGTRaFz3hYAfywC+pvPWfQOJhC2t7JoRwrsP3ZpZ95hHGG0+Kvh8rMHfDS+rGFuHClTGSQWGdwfw0rb/KINlAB2K6j7xgamWHnKWVFCO36SkQA93ZU93sFVKwRjuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859421; c=relaxed/simple;
	bh=+lW6Zq8/3+vy4xBdjLhVu5uVqUX2uzd2G6rWN4mYHNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4w8Nb/vbAWppgvvlOAc3NaRhVYHzM0vAdgakGvdXWn4uDu7Bdz0/1ME2jv4JAFt/8HJFeFDrMSdG/QEKIrqzVQx2KI0P709csuQvT+9Uzi6pQPl+FWk/B6vM9MLHZDhHj8Ohly+hVOhY97lTaEbh4CISlxCG6HrQaLbUQQw2+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRlmbtOp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRlmbtOp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48EEA1F000E9;
	Thu, 27 Aug 2026 19:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787859417;
	bh=zZyTpBvqVHzPg3I76gJW8qgYPfmmyEiwyLXXZKzkTks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jRlmbtOpXGAV7ivFbuU/QYeRqdevyAi5j5O9iCnmmD4FTomG1dg+LGvV1op2A4fZg
	 J6Erwcske23YkqW3DaxHQ2PjiaOHAw587S59es4KfuRBSApctPDLt/23VoJ8TlKxXr
	 /h++DAOtvOxXLQXua++lavUip2Ff4xpL4zw4Wako11l721A+W3fTT95pYB2NiKVj5G
	 yLpdFs1ehyQEutbFiVTU67cRHWxGy9AFE8SqCWQ7Mbb3JFJhHj1TRcSzoUhWybs/5v
	 K3MwBox/KIrt/xBOy2U5h7wt6+oikpUSCdDltw1J1c/OZlcrgOSlYvUGXrp/YsjbYJ
	 vbstVtCesiyZQ==
Date: Thu, 27 Aug 2026 12:36:54 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	tlipcon@google.com, eranian@google.com
Subject: Re: [PATCH] perf symbol: Do not use debug file as the binary type
Message-ID: <apCR1kJMBbdDC8B3@google.com>
References: <20260825062345.115073-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260825062345.115073-1-adrian.hunter@intel.com>

Hello,

On Tue, Aug 25, 2026 at 09:23:45AM +0300, Adrian Hunter wrote:
> dso__load() sets the binary type of a DSO to the type of the first symbol
> source found. For a DSO with a separate debug file linked via
> .gnu-debuglink, that is DSO_BINARY_TYPE__DEBUGLINK, which makes
> dso__get_filename() return the name of the debug file instead of the file
> that was actually executed.
> 
> Consumers that need to read instruction bytes, such as Intel PT decoding
> in 'perf script', then read from the debug file and produce wrong
> instructions.
> 
> Prefer DSO_BINARY_TYPE__BUILD_ID_CACHE, and otherwise
> DSO_BINARY_TYPE__SYSTEM_PATH_DSO, over debug-only types, which restores
> the behaviour of using a file that contains the executed instructions.
> 
> This is a workaround. Properly separating the binary file used for
> instructions from the file used for debug symbols is left for later.
> 
> Example:
> 
>  Create a shared object with a separate .gnu_debuglink debug file. Note
>  that 'objcopy --only-keep-debug' leaves .text as NOBITS, so instructions
>  read from the debug file are zeros:
> 
>   # cat > foo.c << EOF
>   unsigned long foo_work(unsigned long n)
>   {
>         unsigned long s = 0;
> 
>         for (unsigned long i = 0; i < n; i++)
>                 s = s * 31 + i;
>         return s;
>   }
>   EOF
>   # cat > main.c << EOF
>   #include <stdio.h>
>   unsigned long foo_work(unsigned long n);
>   int main(void)
>   {
>         printf("%lu\n", foo_work(1000));
>         return 0;
>   }
>   EOF
>   # gcc -g -O2 -shared -fPIC -o libfoo.so foo.c
>   # gcc -g -O2 -o main main.c -L. -lfoo -Wl,-rpath,'$ORIGIN'
>   # objcopy --only-keep-debug libfoo.so libfoo.so.debug
>   # objcopy --strip-debug libfoo.so
>   # objcopy --add-gnu-debuglink=libfoo.so.debug libfoo.so
>   # perf record -e intel_pt//u ./main
> 
>  Note that branch samples must be requested, because it is the resolving
>  of the branch target symbol that causes dso__load() to be called, and
>  hence the binary type to be set, before the decoder walks the code.
>  With '--itrace=e' alone, nothing loads symbols for libfoo.so, the binary
>  type is left as DSO_BINARY_TYPE__NOT_FOUND, the correct file is read
>  anyway, and no errors are reported either way.
> 
>  Before:
> 
>   # perf.before script --itrace=be 2>&1 | grep "instruction trace error"
>    instruction trace error type 1 time 2350.467489498 cpu 9 pid 75634 tid 75634 ip 0x77d48480718f code 6: Trace doesn't match instruction
>    instruction trace error type 1 time 2350.467489832 cpu 9 pid 75634 tid 75634 ip 0x77d484807341 code 6: Trace doesn't match instruction
>    instruction trace error type 1 time 2350.467496412 cpu 9 pid 75634 tid 75634 ip 0x5b4de37a8074 code 6: Trace doesn't match instruction
>    instruction trace error type 1 time 2350.467593393 cpu 9 pid 75634 tid 75634 ip 0x77d4848070d0 code 6: Trace doesn't match instruction
>    instruction trace error type 1 time 2350.467593954 cpu 9 pid 75634 tid 75634 ip 0x77d4848075a8 code 6: Trace doesn't match instruction
>    instruction trace error type 1 time 2350.467595728 cpu 9 pid 75634 tid 75634 ip 0x77d4848324de code 6: Trace doesn't match instruction
>   6 instruction trace errors
> 
>  After:
> 
>   # perf script --itrace=be 2>&1 | grep "instruction trace error"
>   #
> 
> Fixes: 5363c306787c8 ("perf symbol: Set binary_type of dso when loading")
> Reported-by: Todd Lipcon <tlipcon@google.com>
> Closes: https://lore.kernel.org/all/CAGH6UiG=RJLqBU3kLu9XJciPyPO1HZkbAPERguVUMRuWQgqf=A@mail.gmail.com/
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks for the patch and a test case.

Arnaldo, I can take this to the perf-tools tree for v7.3.

Thanks,
Namhyung

> ---
>  tools/perf/util/symbol.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index cd379ced19e5..1f714b47bbf4 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1947,7 +1947,16 @@ int dso__load(struct dso *dso, struct map *map)
>  		if (next_slot) {
>  			ss_pos++;
>  
> -			if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND)
> +			/*
> +			 * The binary type is used to find the file containing
> +			 * the executed instructions, so prefer the types that
> +			 * refer to the actual object over debug-only files such
> +			 * as DSO_BINARY_TYPE__DEBUGLINK.
> +			 */
> +			if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND ||
> +			    symtab_type == DSO_BINARY_TYPE__BUILD_ID_CACHE ||
> +			    (symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_DSO &&
> +			     dso__binary_type(dso) != DSO_BINARY_TYPE__BUILD_ID_CACHE))
>  				dso__set_binary_type(dso, symtab_type);
>  
>  			if (syms_ss && runtime_ss)
> -- 
> 2.53.0
> 
