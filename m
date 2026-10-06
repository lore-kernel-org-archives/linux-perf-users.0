Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A85213E89;
	Tue,  6 Oct 2026 06:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791266715; cv=none; b=qIPk9ev5hmb0wEg2mMmWRDp6szunKXc3kq2a+Wye1QXbF1rXdR/O7uSBzPfb1o3A6yUJN1VpDMB+glaGmVgs4d8SURFQ3wAiIOjrUKpIhCmHO1Wf/YNlu/WWdtk/85UIMVmd0t/HZA0jSpBcdSlxTe1TZgK75qczO7Gn5DTKMkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791266715; c=relaxed/simple;
	bh=oeVsaWVRwUY8UabuZJbOtx7bxTbpsDqQ2PMtYwnk40k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKaa4RWYxwcTDpPoeSbu4Mti547PUUX0NL53zHBha3CQLH71N8k8yp8vSx2863DpIkfR/+GjuiA7o/EzURXT8Bk4zVBggNOt1X3KCDUvqFi57LF5thNuLbia2mVbey91upAU7QfsA1ueLP6AhluQ0JPJsJSJ9Xfz9oTpHM2uwQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhAD3/G0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhAD3/G0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52901F000FF;
	Tue,  6 Oct 2026 06:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791266714;
	bh=pTmvkGAqgb+iZ5Kpfl4ORbCDIO6bkB6jfDP3sseGY7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hhAD3/G0YU8gke4GO2Ctf5agyIhCXKCCHeBuR2z8b73AYbvVhX1UuoQFj6vvcCNOw
	 xBrqBYxcCweVb7iFEyLctzsO6qX0Lzkx7X4t10yiNXMM62+obw8GOVMfHcgGBIpvsm
	 kHuqfsDaqLw6owG29fPA61L02W/gtKhtDnld5m/Zqpfv8ZQQr2eFVMNhgyE1zEiFks
	 WccWm+Hz8M5rZc1m4br6e4kh6vA2I2wB9OkjOKw1X2Quzp+PS7T3KZlhGKtFRAGuZh
	 XeYBE3Cs9a7mcON7DuMFdQwUS/J0ROSav9G+kfNDJwSfmW2UnLyPAVSem5h5eZnpDM
	 QeonvF00uNlww==
Date: Mon, 5 Oct 2026 23:05:12 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 6/7] perf symbol: Set binary type for JIT map DSOs
Message-ID: <asSPmK_QgxgE6SON@z2>
References: <20261005063411.114244-1-namhyung@kernel.org>
 <20261005063411.114244-7-namhyung@kernel.org>
 <20261005064616.F07241F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261005064616.F07241F00893@smtp.kernel.org>

On Mon, Oct 05, 2026 at 06:46:16AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf: annotate regression on JIT map files due to unhandled binary type
> --
> 
> commit 79781ef5615895fe2ec492b108f82094b6a0246b
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf symbol: Set binary type for JIT map DSOs
> 
> This commit explicitly sets the binary type of JIT map DSOs to JAVA_JIT. This
> ensures they are identified correctly and bypass attempts to load dso_data, 
> as they only contain symbol names and lack binary instructions.
> 
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -1859,6 +1859,7 @@ int dso__load(struct dso *dso, struct map *map)
> >  
> >  	if (perfmap) {
> >  		ret = dso__load_perf_map(map_path, dso);
> > +		dso__set_binary_type(dso, DSO_BINARY_TYPE__JAVA_JIT);
> 
> [Severity: Medium]
> Does setting the binary type to DSO_BINARY_TYPE__JAVA_JIT here bypass the
> historical early exit guard in symbol__disassemble()?
> 
> Looking at symbol__disassemble() in tools/perf/util/disasm.c, it guards
> against unsupported files with:
> 
>     if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND) {
>         return SYMBOL_ANNOTATE_ERRNO__COULDNT_DETERMINE_FILE_TYPE;
>     }
> 
> With the type now explicitly set to DSO_BINARY_TYPE__JAVA_JIT, this check
> fails and allows perf annotate to incorrectly attempt disassembling the text
> map file. 
> 
> The fallback binary disassemblers inevitably fail to parse the text file as
> ELF and return -1. This propagates back to symbol__strerror_disassemble(),
> which handles the -1 return by printing an unhelpful message to the user
> instead of gracefully exiting:
> 
>     default:
>         scnprintf(buf, buflen, "Internal error: Invalid %d error code\n", errnum);
>         break;
> 
> Should symbol__disassemble() be updated to check for DSO_BINARY_TYPE__JAVA_JIT
> so that it can exit gracefully when users try to annotate a JIT symbol profile?

Ok, but I think the dso__disassemble_filename() should be updated to set
binary type correctly and just use dso__get_filename().  Will do in v2.

Thanks,
Namhyung
