Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C250027146D;
	Thu,  2 Oct 2025 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759427017; cv=none; b=ZwzJoPHwQedv2HVWdXJ169ePfdjWAZN7ng8JtNYnIG699H5hN4aq0iZHRdnadtgmL8fIZ9cny9HKy3Ch3utz9HZSWSqdhRlTpLenYxvEgPHuPHtDlf3MWQFSKcvZz5D/aiJj/TSaDYWnOiUaHFzjTBkmAoV9DV7BPHGAbtymnys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759427017; c=relaxed/simple;
	bh=Xqz5o+ZdJCPEwJsSHbsVWkehdw3RptKsEo6BDFHxa9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hURTQb75B0LcocN3wuHEHsbrYy6gBdt4IIMlMX6uDYavAvqwM4EjHHNNnFyplLPoycbMJeI/969OUwIeMIquGVP/CTcmqrYnc8+64pXFQmwZHNTPYEft0Pw/+cu3CSTnGqhRZrHSu4psDmjcNB4jomN5CdA9adBc30wodCsLZQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7X/wTr3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7X/wTr3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DBDC4CEF4;
	Thu,  2 Oct 2025 17:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759427017;
	bh=Xqz5o+ZdJCPEwJsSHbsVWkehdw3RptKsEo6BDFHxa9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o7X/wTr3NYgfOivRzqINdn9eHbE+mYwqJontKFsokLincUPL0yhN32HWvivnLf69a
	 Qct+ql80DOtSXdLhH3IjgXJvbIErrsUiNvsobaacXze4smzyn/fArVuh102PL2iCwB
	 hb4NBzlmnn67H8gFSFbMq0YgVrzA44LwIX/Kbs2GrG23CE8ayfg33SNCYBE4UHCmDr
	 Y4rbFost6z3pLR7qngNPD1DBt82H4mEt2b+6jc5taiAF/XeiMYZnWN6vUK0q5jRlNy
	 g/bXLGjLJI67SsP+0LapA//jcImbcqzPgzBGiRjxeY3/5g/GNgrPGbyxVHRaq1CWMy
	 t9ubP3mp4DwYw==
Date: Thu, 2 Oct 2025 14:43:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/8] perf build: Support building with Clang
Message-ID: <aN65xrFGqwue6jCx@x1>
References: <20250930-perf_build_android_ndk-v2-0-2ea440b7ef01@arm.com>
 <aN044EY-Ds9-E6iz@x1>
 <20251001152217.GQ7985@e132581.arm.com>
 <aN1yNKxXLnMtQczW@x1>
 <20251001183256.GS7985@e132581.arm.com>
 <20251001202050.GT7985@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001202050.GT7985@e132581.arm.com>

On Wed, Oct 01, 2025 at 09:20:50PM +0100, Leo Yan wrote:
> On Wed, Oct 01, 2025 at 07:32:56PM +0100, Leo Yan wrote:
> 
> [...]
> 
> > > + make 'ARCH=' 'CROSS_COMPILE=' 'EXTRA_CFLAGS=' -C tools/perf 'O=/tmp/build/perf' 'CC=clang'
> > > make: Entering directory '/git/perf-6.17.0-rc6/tools/perf'
> > >   BUILD:   Doing 'make -j28' parallel build
> > > Makefile.config:494: *** No gnu/libc-version.h found, please install glibc-dev[el].  Stop.
> 
> It does not set correctly --target as x86_64-alpine-linux-musl if
> distros are using musl libc.
> 
> Now running the container build for updated code.  Once pass test,
> I will send new series.

Thanks for spotting the problem after taking the trouble of starting a
container! Hopefully that will save time for other people trying to
cross-build perf.

Cheers,

- Arnaldo
