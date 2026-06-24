Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591D03DE434
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782332594; cv=none; b=ei3RrPI0uN7M39VTQPDih7ynfFr6+dFwVXostqHlKM0w0BVGdvms24Vo/CbCYRRy925iHIgAdvAKpWlQlyplAD7ZPDrxu0j65wOxTQdU0oespK4xhXaxZ5A4GnsGmjYs6WYEHvB0e4ZqSyaNzOZBN4+WjOL0Q/j5v0i+IQjtYnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782332594; c=relaxed/simple;
	bh=mXq8uhySQPF8ggxYuTh2tipsRsWg1T8BZ1/WQDfuJLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpvYSaCbvkZCxr6WbvjA6lH++ADIdndiBvzY7/+xiE74siWThQdNtUQFcmzboem+fb77H6MJsdv1POC94RFaRsDNT6PkTXfQ3JAywPw4zFw3QlKD+dlCmUL6Jf36dlcAO0F4u2THLKuP8OjqULiH3kYIwK/4V4PfwTbYccpN+gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAh1yISv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAh1yISv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0297E1F000E9;
	Wed, 24 Jun 2026 20:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782332593;
	bh=mmgPIp6anEqUUcgnOW35J5BU43jQifQPS1RKVOw0zXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RAh1yISvp3bvkmyW33ZaH7O7zetHOFjDrcTu2uqKeVffw1yuvZSCSicHmnqkNjzwy
	 +g8EnL+yHPR5g7bKFO/ZOB6/Ev5l07AYKAkMDHVcPwfpbDksRuUkToVi3l7XXtjrTp
	 daJ++wEAgCdcn46N3x2O7Z8B5oi5aXR3qG5YFetZ+Jy6fkKSMo3HlsNVV1oL0RFZe0
	 M4N1nAYTDCmL9LbEAajy5wlnkL4ji3yiYcq0icX1ravL+eBP3guOLUWSu0yYWrgFuk
	 ZUK+KY2go0nLBsdHHy+pYyyzr4qub5v2GCuqCzW2n2sFvJoSNYy8Hn4Kryot0+XqmY
	 Nem6FgvtSkQgw==
Date: Wed, 24 Jun 2026 13:23:11 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Todd Lipcon <tlipcon@google.com>, Stephane Eranian <eranian@google.com>,
	"Mi, Dapeng1" <dapeng1.mi@intel.com>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: perf script intel_pt decoding reading instructions from wrong
 shared lib
Message-ID: <ajw8r2Y2shs6sBJW@google.com>
References: <CAGH6UiG=RJLqBU3kLu9XJciPyPO1HZkbAPERguVUMRuWQgqf=A@mail.gmail.com>
 <c45fea55-b03d-40ac-a89f-8882b057fe5b@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c45fea55-b03d-40ac-a89f-8882b057fe5b@intel.com>

Hello,

On Tue, Jun 02, 2026 at 10:32:02PM +0300, Adrian Hunter wrote:
> On 15/04/2025 00:59, Todd Lipcon wrote:
> > Hi folks,
> > 
> > It seems there may be a bug in perf-script when processing intel_pt.
> > Specifically, in order to reconstruct the instructions, it maps
> > instruction pointers back to DSO-relative addresses, and then reads
> > from the associated ELF files to find the actual instructions that
> > were traced.
> > 
> > In the case that the ELF file has an associated separate-debug ELF
> > file linked via `.gnu-debuglink` (common in some Linux distros), it
> > appears to be reading the debuginfo file instead of the shared library
> > that actually contains the code.
> > 
> > I've posted a simple repro here:
> > https://github.com/toddlipcon/perf-debuglink-bug/blob/main/repro.sh
> > 
> > I haven't dug into the code yet enough to see where it's going wrong,
> > but figured I would report to the users list first.
> 
> Seems to be caused by commit 5363c306787c8 - see further below.
> Reverting that makes the issue go away.

Sorry for the trouble.

> 
> With that commit, dso__load() sets the binary_type to the first symbol
> source file type, which is DSO_BINARY_TYPE__DEBUGLINK in this case.
> That causes dso__get_filename() to get the file name of the debug file,
> not the file actually executed.
> 
> Leaving the binary_type as DSO_BINARY_TYPE__NOT_FOUND will result in
> try_to_open_dso() using either DSO_BINARY_TYPE__BUILD_ID_CACHE or
> DSO_BINARY_TYPE__SYSTEM_PATH_DSO.

Ok, I feel like we should split the dso access for the binary file (for
annotate or intel-pt) and debug symbols (symbol table or DWARF).
Probably we can use the binary_type and symtab_type respectively.

I'll take a look.

Thanks,
Namhyung

> 
> A quick workaround hack:
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index dd30f17cb1ca..09fd79ca1d48 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1825,7 +1825,10 @@ int dso__load(struct dso *dso, struct map *map)
>  		if (next_slot) {
>  			ss_pos++;
>  
> -			if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND)
> +			if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND ||
> +			    symtab_type == DSO_BINARY_TYPE__BUILD_ID_CACHE ||
> +			    (symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_DSO &&
> +			     dso__binary_type(dso) != DSO_BINARY_TYPE__BUILD_ID_CACHE))
>  				dso__set_binary_type(dso, symtab_type);
>  
>  			if (syms_ss && runtime_ss)
