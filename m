Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7CAE555;
	Thu, 20 Mar 2025 01:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742432592; cv=none; b=k+OxVXOmHWd96/oECo77YowLU+/U+3CIzqAmTMncbp22Mpf08tS6t9rBblk16xgJTGeWMSaCnj4Ce8W/HwytqWMwetgFyiol8NDGZ4saJzsz6/eV/vitl7cuO4OhBucgZkr9HIYQDseVboxWicLSwpe8KNH6ovXZX5Sn5S5qHCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742432592; c=relaxed/simple;
	bh=rLVoV3SKUTmxCuAqDm86i1FuF3iLcodh0NdngaNhT1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JefrIHmkXC0icktBZcbSRY3gevN31maL9jRhTvRmjQzOGbrr5MnYZgoYCwpP+fvGNDjFnOn0yEZiKb+/Bfs/lw7qJDLkc7PBUOpyT/FzZlTObJq1sn/gWVYdkb1Y5LaDgQKNXwarfa/L0m7XW35+Z5i+hV8bam3ch9qJHVjXC6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuPHIOCI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuPHIOCI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B43C4CEE4;
	Thu, 20 Mar 2025 01:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742432591;
	bh=rLVoV3SKUTmxCuAqDm86i1FuF3iLcodh0NdngaNhT1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iuPHIOCIz3nJgwX2+jRRC1pXO+QB6UYqlPUJqsBXHZf00ZbKkJkbN4MuKtPdlU9TQ
	 0hNmRRN0MsAs9TRz5R9P8dosRcQY95H1Mz2My1kOuT1+QFFs35ha0IISdIHlwUPeJf
	 ub0kh+txHa6soKHNly71drIAd1Ox4UbxiDna5I5qy6jsYZEbPT33bsFCs6N7EVzNxJ
	 x6NF+YaVuGncdvD0kDvg3A7T/ro7ba7W3fpuDdRH/SF/5DZXoJMWu9Th+nxKAcOjyq
	 P/LjcNPb3iRf/2L6resCLbvnxSmjoZGZVnCriJleeb7EhS5YfVxoh8P6ySXNNOdRiO
	 RsGnBdTGb0lKg==
Date: Wed, 19 Mar 2025 18:03:09 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Leo Yan <leo.yan@arm.com>, James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf build: Restore {0} initializer since GCC-15
Message-ID: <Z9tpTfHa4DquTzAT@google.com>
References: <20250319110454.3230687-1-leo.yan@arm.com>
 <16b146f7-7568-437d-8ee5-f26bfb0354bd@linaro.org>
 <20250319133055.GA3249206@e132581.arm.com>
 <CAP-5=fUp492RATRhc-OmikK7knO+PUWAt6Z-60Cax0QOJPrFgg@mail.gmail.com>
 <20250319182806.GC3249206@e132581.arm.com>
 <CAP-5=fVkCaX9DRokAEqDq-3Bvr8txM7oBmw63R+O2ibg2AzDuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVkCaX9DRokAEqDq-3Bvr8txM7oBmw63R+O2ibg2AzDuQ@mail.gmail.com>

Hello,

On Wed, Mar 19, 2025 at 02:05:17PM -0700, Ian Rogers wrote:
> On Wed, Mar 19, 2025 at 11:28 AM Leo Yan <leo.yan@arm.com> wrote:
> >
> > On Wed, Mar 19, 2025 at 08:26:10AM -0700, Ian Rogers wrote:
> >
> > [...]
> >
> > > > > Adding options that allow people to add more non standard code doesn't feel
> > > > > very portable or in the spirit of doing it the right way. Maybe there's an
> > > > > argument that it guards against future mistakes, but it's not mentioned in
> > > > > the commit message.
> > > >
> > > > I think Linux perf shares the same understanding with "we do expect
> > > > initializers that always initialize the whole variable fully" (quote
> > > > in [1]).  Furthermore, the reply mentioned:
> > > >
> > > >  The exact same problem happens with "{ 0 }" as happens with "{ }".
> > > >  The bug is literally that some versions of clang seem to implement
> > > >  BOTH of these as "initialize the first member of the union", which
> > > >  then means that if the first member isn't the largest member, the
> > > >  rest of the union is entirely undefined.
> > > >
> > > > So I think it is reasonable to imposes a compiler option to make
> > > > compiler's behavouir consistent.
> > >
> > > We have encountered this problem, here is a fix for a case:
> > > https://lore.kernel.org/r/20241119230033.115369-1-irogers@google.com
> > > It would be nice if rather than -fzero-init-padding-bits=unions there
> > > were some kind of warning flag we could enable, or worse use a tool
> > > like clang-tidy to identify these problems. In the linked change the
> > > problem was identified with -fsanitize=undefined but IIRC perf didn't
> > > quit with a sanitizer warning message, just things broke and needed
> > > fixing.
> >
> > I searched the GCC online doc [2], I found below options but none of
> > them is used for such kind of warning:
> >
> >   -Wmissing-braces
> >   -Wuninitialized
> >   -Wmissing-field-initializers
> >
> > For the "-Wmissing-field-initializers" option, it says "In C this
> > option does not warn about the universal zero initializer ‘{ 0 }’".
> >
> > Linux kernel has added the "-fzero-init-padding-bits=all" option in
> > the commit:
> >
> >   dce4aab8441d kbuild: Use -fzero-init-padding-bits=all
> >
> > Maybe we can do the same thing for perf?  This could help developers
> > and maintainers avoid endlessly struggling with potential bugs caused
> > by "{0}".
> 
> It looks like clang may be just changing the default to zero
> initialize everything:
> https://github.com/llvm/llvm-project/pull/110051/files
> https://github.com/llvm/llvm-project/pull/97121

Then I think it's better to add "-fzero-init-padding-bits=all" for GCC
to minimize surprises.

Thanks,
Namhyung

