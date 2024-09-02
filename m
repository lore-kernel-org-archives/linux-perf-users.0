Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEAE19E972;
	Mon,  2 Sep 2024 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288835; cv=none; b=otr34ba1gfG8+bVPR7nDg5NYXi38mtYWQLpVC5pGAK4uKY1+75HtHA7gj4m/Dws1Vxyy2FpSrg3rVdiXCwP7kPDKlXYQUrXVm4K7sSmGljuQ2fNIQNMbQuFEAk6aNjK3YrRekaaafcTfOqcPut2zqlmYKihPxCD1YIpj9VlveaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288835; c=relaxed/simple;
	bh=z9+/kAUCxg2nXhWZUoTVhXRLlu9ZYYhdIcq3W8qbdEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/sQEBwkhD4Ea1YpQFhHwc5Gq+SYUtPCg3t6R7kaUoOA+lbNG5E/aEClLsG2pUsYIs7yEuDK0y9PJLtJoiPVkxU6UQFkzIDVekWBGTqu30A03qpB9rx8kmJN47VebIjJBYhQBGt7krIxBalXZJp//EewPGQagafCSiserZ/OUfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aliITXSr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aliITXSr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F07C4CEC2;
	Mon,  2 Sep 2024 14:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725288834;
	bh=z9+/kAUCxg2nXhWZUoTVhXRLlu9ZYYhdIcq3W8qbdEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aliITXSr77H3qs9xL1FMrheGwHVArQs1lSiHKitu1h2u2hq6KcvrJ4TxOCMQ5gd/q
	 Su0K2UZelXu/uwUMmr96dLFgTYMlmGwF2/AuTrFueT7SNxUNDKw/SEpkospYTHO+Gg
	 ddFq6rfgC7jcFqFOlCBUngJKOd22Tsom1bb+TUi2YSN3q2yQEXIXAMKRcDAUkpZJdU
	 EgjrFTlnWzHv1OiRh6bqITICZYcGzqPXrFYqFfJBWTE+fZkUNPYEo0qHTq8klNpITM
	 wdjPf3sBNBWfacX1qh8HGHHQeCQAos+NXQmba1aqdgXXZH0LDBKa+r1/mc3XrWFZrk
	 HHNeYFVB32TTA==
Date: Mon, 2 Sep 2024 11:53:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Steinar H. Gunderson" <sesse@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	irogers@google.com
Subject: Re: [PATCH v9 3/3] perf annotate: LLVM-based disassembler
Message-ID: <ZtXRf7OjEOMwg3qg@x1>
References: <20240719150051.520317-1-sesse@google.com>
 <20240719150051.520317-3-sesse@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719150051.520317-3-sesse@google.com>

On Fri, Jul 19, 2024 at 05:00:51PM +0200, Steinar H. Gunderson wrote:
> Support using LLVM as a disassembler method, allowing helperless
> annotation in non-distro builds. (It is also much faster than
> using libbfd or bfd objdump on binaries with a lot of debug
> information.)
> 
> This is nearly identical to the output of llvm-objdump; there are
> some very rare whitespace differences, some minor changes to demangling
> (since we use perf's regular demangling and not LLVM's own) and
> the occasional case where llvm-objdump makes a different choice
> when multiple symbols share the same address. It should work across
> all of LLVM's supported architectures, although I've only tested 64-bit
> x86, and finding the right triple from perf's idea of machine
> architecture can sometimes be a bit tricky. Ideally, we should have
> some way of finding the triplet just from the file itself.

<SNIP>
 
> @@ -1730,6 +1918,11 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  		strcpy(symfs_filename, tmp);
>  	}
>  
> +#ifdef HAVE_LIBLLVM_SUPPORT
> +	err = symbol__disassemble_llvm(symfs_filename, sym, args);
> +	if (err == 0)
> +		goto out_remove_tmp;
> +#endif
>  #ifdef HAVE_LIBCAPSTONE_SUPPORT
>  	err = symbol__disassemble_capstone(symfs_filename, sym, args);
>  	if (err == 0)

So the above makes it unconditionally be used, and if the user installed
llvm-devel, that now gets checked and suggested at build time, then that
is an indication that it should be used, but I wonder if, for debugging
purposes we shouldn't have this done in some configurable way, i.e. some
~/.perfconfig variable that allows us to try a specific disassembler,
something like:

	perf annotate --disassemble=capstone

I can even envision having some perf test that compares the output for
some well known function to see if they really produce the same output
from different disassemblers, etc.

I'm applying the patches, thanks!

- Arnaldo
