Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261A713D244;
	Tue, 25 Jun 2024 05:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719293545; cv=none; b=tcVPSPnYX6spz2eUDTgkkbfFMrSyATPTuQHBAxChedk9L/Pww+CFQaArfyxk5FTO4Se4LF+WoMAXP1aTVhPrdHaWZcrgfEfv3Ht5EqT79GyHOQPv3aYQPJphj6j9oSxyLiUV3rzralsu6cbXYfwKyYkQRBsiLHB/1k57ZFCKq7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719293545; c=relaxed/simple;
	bh=3Z7LyAhh4LTv+HNrBs8+IYT8Sjq4E0mp/A8dkZddR7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwXzpL4TuQyrm9+VBuMBkLIeYwD3hW4FMVjUMENbSneoJDGkB3/oSj22rRyICb5jBzHAA7DOnsfdIcZ3N+YDFkKcqt8Qx6b7ZUMnWBLgb5PlTyVzl5ioRcu27VlQfX4f8PCpJMZs3ha8AKnzdoj8/7bU/PObQS86fVC1gw4nUeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehu6Shsh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehu6Shsh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3220FC32782;
	Tue, 25 Jun 2024 05:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719293544;
	bh=3Z7LyAhh4LTv+HNrBs8+IYT8Sjq4E0mp/A8dkZddR7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ehu6Shsh30K9d1HWMHxun7sN8Eg/DiR6XASTLsXqTwthhOrRuj8ExbNvKkT0uYs2l
	 0XPRQydpOsnYYKSV1lHBTf6Ra0TKoYLk7G+dVxmEd9nsCuTVOHarnRNAlujD9Bo1Gd
	 JDjwmKAlAjl7bv+hB5NV8wECed1BdIS18MZPmxgWGa9JJcg1ZXMG+yRW+3wuJYEIwX
	 WrNIpWYKgXwu8aC4OJap5S9Ab/T1ywsBp/yVLwsITg5DenGnaO601b6PpvPnCuPrqZ
	 VDXXd/Iewg6vjxHXIJxvwYsOydsJ3A7rzeEFC49grlIfkt8eIW5/Zg/ieBqhhqYKvB
	 l5g/S7pP4d/Rw==
Date: Mon, 24 Jun 2024 22:32:22 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	irogers@google.com, segher@kernel.crashing.org,
	christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	akanksha@linux.ibm.com, maddy@linux.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [V4 04/16] tools/perf: Use sort keys to determine whether to
 pick objdump to disassemble
Message-ID: <ZnpWZlz6T2PyG6R6@google.com>
References: <20240614172631.56803-1-atrajeev@linux.vnet.ibm.com>
 <20240614172631.56803-5-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240614172631.56803-5-atrajeev@linux.vnet.ibm.com>

On Fri, Jun 14, 2024 at 10:56:19PM +0530, Athira Rajeev wrote:
> perf annotate can be done in different ways. One way is to directly use
> "perf annotate" command, other way to annotate specific symbol is to do
> "perf report" and press "a" on the sample in UI mode. The approach
> preferred in powerpc to parse sample for data type profiling is:
> - Read directly from DSO using dso__data_read_offset
> - If that fails for any case, fallback to using libcapstone
> - If libcapstone is not supported, approach will use objdump
> 
> The above works well when perf report is invoked with only sort keys for
> data type ie type and typeoff. Because there is no instruction level
> annotation needed if only data type information is requested for. For
> annotating sample, along with type and typeoff sort key, "sym" sort key
> is also needed. And by default invoking just "perf report" uses sort key
> "sym" that displays the symbol information.
> 
> With approach changes in powerpc which first reads DSO for raw
> instruction, "perf annotate" and "perf report" + a key breaks since
> it doesn't do the instruction level disassembly.

So as I said, it'd be nice you can read the raw insn from the objdump
output directly.

Thanks,
Namhyung

> 
> Snippet of result from perf report:
> 
> Samples: 1K of event 'mem-loads', 4000 Hz, Event count (approx.): 937238
> do_work  /usr/bin/pmlogger [Percent: local period]
> Percent│        ea230010
>        │        3a550010
>        │        3a600000
> 
>        │        38f60001
>        │        39490008
>        │        42400438
>  51.44 │        81290008
>        │        7d485378
> 
> Here, raw instruction is displayed in the output instead of human
> readable annotated form.
> 
> One way to get the appropriate data is to specify "--objdump path", by
> which code annotation will be done. But the default behaviour will be
> changed. To fix this breakage, check if "sym" sort key is set. If so
> fallback and use the libcapstone/objdump way of disassmbling the sample.
> 
> With the changes and "perf report"
> 
> Samples: 1K of event 'mem-loads', 4000 Hz, Event count (approx.): 937238
> do_work  /usr/bin/pmlogger [Percent: local period]
> Percent│        ld        r17,16(r3)
>        │        addi      r18,r21,16
>        │        li        r19,0
> 
>        │ 8b0:   rldicl    r10,r10,63,33
>        │        addi      r10,r10,1
>        │        mtctr     r10
>        │      ↓ b         8e4
>        │ 8c0:   addi      r7,r22,1
>        │        addi      r10,r9,8
>        │      ↓ bdz       d00
>  51.44 │        lwz       r9,8(r9)
>        │        mr        r8,r10
>        │        cmpw      r20,r9
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/util/disasm.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index f19496133bf0..b81cdcf4d6b4 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -25,6 +25,7 @@
>  #include "srcline.h"
>  #include "symbol.h"
>  #include "util.h"
> +#include "sort.h"
>  
>  static regex_t	 file_lineno;
>  
> @@ -1803,9 +1804,11 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  	 * not required in case of powerpc.
>  	 */
>  	if (arch__is(args->arch, "powerpc")) {
> -		err = symbol__disassemble_dso(symfs_filename, sym, args);
> -		if (err == 0)
> -			goto out_remove_tmp;
> +		if (sort_order && !strstr(sort_order, "sym")) {
> +			err = symbol__disassemble_dso(symfs_filename, sym, args);
> +			if (err == 0)
> +				goto out_remove_tmp;
> +		}
>  	}
>  
>  #ifdef HAVE_LIBCAPSTONE_SUPPORT
> -- 
> 2.43.0
> 
