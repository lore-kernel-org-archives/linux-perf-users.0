Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA0221C191;
	Mon,  2 Sep 2024 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288905; cv=none; b=Cx+07LRkycV3NcwTImlhrbC5bp094MEciUK371DFs2AD6V5wvuftZvjaGir8/6Sq+pSSB47ZvmLQ6YbF+JEXqLchAkVbtzUqjcwh9/pitBOeCNInZVg+cMJLR7reObW49+ln/9QwfHOhHdfPTPW4jov3aOboBRcmkRSmV/9UjfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288905; c=relaxed/simple;
	bh=HslvvXlV5s0iDjGnzMgwZM2g6j0w9etAdh0SWpLPhhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHJifx+eRvuhvFWCZjnGP8wcz5IQZ3qPyGlDJB5T29K0UUYQA1BsvuQPYfkLPddbUccP5rVmPQNEA8kPPer0wLeSwDsxjW/WyPRlsCP5e1vAfSIuqVgFfvvGdIO8MYiXNTH3kzYPL3jlImdvfk0t2vWkxYjAArGTyAfbfxBkAiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxQiyzB6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxQiyzB6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1A2C4CECA;
	Mon,  2 Sep 2024 14:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725288905;
	bh=HslvvXlV5s0iDjGnzMgwZM2g6j0w9etAdh0SWpLPhhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RxQiyzB60epa0nonhB5X5HeA5hOQz8N8ccS8aSj3nO8Nz2Vs2rH98XQqcUwE2kLjJ
	 wHzsROhmRZDrs55/JrwIZWmu5MUjNNZY91QW3tpzFjGSIdtTEr9BQ8v8oSfNLC4au4
	 gucbrtIeIxedgjG7bDGAUx/RBjaX3AmhSdCvcbRjVnadtQw1N/4BtrKmpOtaB03yGb
	 lvtim01b973kdES0fKjFeYvTVr+7LBDFJhmTysJtivcVxMHYNymsAPeT3vyFxseox2
	 2VcydzDMTQFwdQZ8AUxzI5x3p52KsHLq7C2T6Ae8Vbvq5OjM/eDXOWTxwGcH7Zw1ld
	 Kqu43wsmK18/w==
Date: Mon, 2 Sep 2024 11:55:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>,
	"Steinar H. Gunderson" <sesse@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	irogers@google.com
Subject: Re: [PATCH v9 3/3] perf annotate: LLVM-based disassembler
Message-ID: <ZtXRxYE5WM1vScoT@x1>
References: <20240719150051.520317-1-sesse@google.com>
 <20240719150051.520317-3-sesse@google.com>
 <ZtXRf7OjEOMwg3qg@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtXRf7OjEOMwg3qg@x1>

Cc'ing Namhyung, see below.

On Mon, Sep 02, 2024 at 11:53:55AM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Jul 19, 2024 at 05:00:51PM +0200, Steinar H. Gunderson wrote:
> > Support using LLVM as a disassembler method, allowing helperless
> > annotation in non-distro builds. (It is also much faster than
> > using libbfd or bfd objdump on binaries with a lot of debug
> > information.)
> > 
> > This is nearly identical to the output of llvm-objdump; there are
> > some very rare whitespace differences, some minor changes to demangling
> > (since we use perf's regular demangling and not LLVM's own) and
> > the occasional case where llvm-objdump makes a different choice
> > when multiple symbols share the same address. It should work across
> > all of LLVM's supported architectures, although I've only tested 64-bit
> > x86, and finding the right triple from perf's idea of machine
> > architecture can sometimes be a bit tricky. Ideally, we should have
> > some way of finding the triplet just from the file itself.
> 
> <SNIP>
  
> > @@ -1730,6 +1918,11 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
> >  		strcpy(symfs_filename, tmp);
> >  	}
> >  
> > +#ifdef HAVE_LIBLLVM_SUPPORT
> > +	err = symbol__disassemble_llvm(symfs_filename, sym, args);
> > +	if (err == 0)
> > +		goto out_remove_tmp;
> > +#endif
> >  #ifdef HAVE_LIBCAPSTONE_SUPPORT
> >  	err = symbol__disassemble_capstone(symfs_filename, sym, args);
> >  	if (err == 0)
> 
> So the above makes it unconditionally be used, and if the user installed
> llvm-devel, that now gets checked and suggested at build time, then that
> is an indication that it should be used, but I wonder if, for debugging
> purposes we shouldn't have this done in some configurable way, i.e. some
> ~/.perfconfig variable that allows us to try a specific disassembler,
> something like:
> 
> 	perf annotate --disassemble=capstone
> 
> I can even envision having some perf test that compares the output for
> some well known function to see if they really produce the same output
> from different disassemblers, etc.

Namhyung, do you see a problem with this?

- Arnaldo
 
> I'm applying the patches, thanks!
