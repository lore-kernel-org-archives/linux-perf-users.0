Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E098215F77;
	Wed, 22 Jan 2025 19:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737573094; cv=none; b=Lq6k2709OsnvelWNwVEK+9qhlkN329PQpxEH29g8Vjvn6vjeydEt2xBNAiHHKhwFDjr4X2sA4f8pqcrhltOzMiXDCZZwDgRhIKED/cIjHT6Gs2x1qbbwu3tOCZ8sx8wU9iAL22ciMiBw4pdktyWF7/pKRtE6OQMPyc1mMf2u2K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737573094; c=relaxed/simple;
	bh=w31kqE5Zh9oAlyNqmV3jMpsRZgwWRKLSeaiGM7/tCEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwmEeUaQLLpDN64lwliTV37YF3ei1uxi9YKvQFVtrE1Gb0Cw25FaH/Bs0T0768Q17qp2I+fRr6F9mTPmLGpDey2vztc/h2/w1cOR7ZlUTjfu7kqAgm/eQTOgSBDJVmgQqycKu6OfjbS8nNdwwfUkCQD2BXCi2qJ+zp+awCUFXt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVZ4oxxn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVZ4oxxn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753C1C4CED3;
	Wed, 22 Jan 2025 19:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737573094;
	bh=w31kqE5Zh9oAlyNqmV3jMpsRZgwWRKLSeaiGM7/tCEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NVZ4oxxnsglyL6Jl31hvDLLG2oMZCVqZFIVM06zMbqBmfefRUgYzeRq5ac9wHBLeu
	 TJD3AHtIXgm2fqZDYsuc3SF2tIU6Xe7oQNl2tqhSb0RSbw88QraQFJsClodOCXwvQ6
	 k9m4SQVGW3bdb8nBHldzG7/28zy2Vx9ISC6h+TFXBQRU0+/txQZEQ1T195iV0D/xUL
	 coZTbBZJKwjFhFyCM0cncrT1wpfbsgtY2fQILRlseFoqzo0Ixv47m6jo1/8EUgY7OJ
	 46+tiLef2PzeEWhAG++f8YPEP4dDuAtDGIOeVghVZ7c+m8bE+RCEnI3A+6vln7mx4V
	 is0dq35agL0LQ==
Date: Wed, 22 Jan 2025 11:11:31 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, jolsa@kernel.org, irogers@google.com,
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf trace: Fix runtime error of index out of bounds
Message-ID: <Z5FC47bfDAPu75-e@google.com>
References: <20250122025519.361873-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250122025519.361873-1-howardchu95@gmail.com>

On Tue, Jan 21, 2025 at 06:55:19PM -0800, Howard Chu wrote:
> libtraceevent parses and returns an array of argument fields, sometimes
> larger than RAW_SYSCALL_ARGS_NUM (6) because it includes "__syscall_nr",
> idx will traverse to index 6 (7th element) whereas sc->fmt->arg holds 6
> elements max, creating an out-of-bounds access. This runtime error is
> found by UBsan. The error message:

I'm curious how I miss this.  Is this only for some specific syscalls or
always happening?  Do you which commit introduced this?

Thanks,
Namhyung

> 
> perf $ sudo UBSAN_OPTIONS=print_stacktrace=1 ./perf trace -a --max-events=1
> builtin-trace.c:1966:35: runtime error: index 6 out of bounds for type 'syscall_arg_fmt [6]'
>     #0 0x5c04956be5fe in syscall__alloc_arg_fmts /home/howard/hw/linux-perf/tools/perf/builtin-trace.c:1966
>     #1 0x5c04956c0510 in trace__read_syscall_info /home/howard/hw/linux-perf/tools/perf/builtin-trace.c:2110
>     #2 0x5c04956c372b in trace__syscall_info /home/howard/hw/linux-perf/tools/perf/builtin-trace.c:2436
>     #3 0x5c04956d2f39 in trace__init_syscalls_bpf_prog_array_maps /home/howard/hw/linux-perf/tools/perf/builtin-trace.c:3897
>     #4 0x5c04956d6d25 in trace__run /home/howard/hw/linux-perf/tools/perf/builtin-trace.c:4335
>     #5 0x5c04956e112e in cmd_trace /home/howard/hw/linux-perf/tools/perf/builtin-trace.c:5502
>     #6 0x5c04956eda7d in run_builtin /home/howard/hw/linux-perf/tools/perf/perf.c:351
>     #7 0x5c04956ee0a8 in handle_internal_command /home/howard/hw/linux-perf/tools/perf/perf.c:404
>     #8 0x5c04956ee37f in run_argv /home/howard/hw/linux-perf/tools/perf/perf.c:448
>     #9 0x5c04956ee8e9 in main /home/howard/hw/linux-perf/tools/perf/perf.c:556
>     #10 0x79eb3622a3b7 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
>     #11 0x79eb3622a47a in __libc_start_main_impl ../csu/libc-start.c:360
>     #12 0x5c04955422d4 in _start (/home/howard/hw/linux-perf/tools/perf/perf+0x4e02d4) (BuildId: 5b6cab2d59e96a4341741765ad6914a4d784dbc6)
> 
>      0.000 ( 0.014 ms): Chrome_ChildIO/117244 write(fd: 238, buf: !, count: 1)                                      = 1
> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/builtin-trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index d7c7d29291fb..8d3260bad10a 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2108,7 +2108,7 @@ static int trace__read_syscall_info(struct trace *trace, int id)
>  	}
>  
>  	if (syscall__alloc_arg_fmts(sc, IS_ERR(sc->tp_format) ?
> -					RAW_SYSCALL_ARGS_NUM : sc->tp_format->format.nr_fields))
> +					RAW_SYSCALL_ARGS_NUM : sc->tp_format->format.nr_fields - 1))
>  		return -ENOMEM;
>  
>  	sc->args = sc->tp_format->format.fields;
> -- 
> 2.45.2
> 
