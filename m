Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AA014430E;
	Thu, 31 Oct 2024 06:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730356755; cv=none; b=Az8qOOWrM6pWsIoF+OpkQm9SMbD28g84UvjHo/Us8bmVpr0rQ1x35IGLaWNSRnvCKHOymlhz4u051nZZVrtPgfMsXKh9pGx6ipK+1KtwCHPsdeaEk5eruOSmXMEtOTwkpOwJPiHASwwRWALIFWqfZz6HCkHRpac4+P8OqRey1aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730356755; c=relaxed/simple;
	bh=wmZlcSfbiMvha+zyF3fElD72hUqYGvHQwam70xsM8Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jun/SJatXyJC+LG1q8eJzjEVj3Tm1bSrsTnjFrNfvoKfsuFFaCBqSjvsYWNP4qlgQI06opWpB6o/mcPlCEEgyeD6lNABYOWE90sXvu/m+IEOLfV85qKSqUASR/cUbQlAi/PhPDzHb+7uM0K698ZMbqlR/MaPFk8l/FDTohIXGu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWHZIGM9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWHZIGM9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD7DC4CEC3;
	Thu, 31 Oct 2024 06:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730356753;
	bh=wmZlcSfbiMvha+zyF3fElD72hUqYGvHQwam70xsM8Nw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pWHZIGM9ygudLPKNds16EL4U5Y5A7GuA0hyOetdXS/Ccxy30pVVnqN8iPNuCh2Vm/
	 MWV3nI9qyFOsg8WO2aTpZZJIcf0irYLZh/bdLYJ7HJrQkACWos5oX+L0CV+Q9PYiuv
	 0+Kc/W4tMP7koUAN2KrpOfyDzUn6FFxmrcHnHHkhBOx7cI19scqVjv38b14apXMpll
	 bhKW6BKPt+YcoR3sVbwMcmHYSdOnk7DzqBp2vuJPd6epl0qmGO0C1krQvM13h5aeJw
	 jMuYQHLl7uln38ISnEcRJd0tlsnjYsCP9OknBELTNv/DCNWM0ZR5MyuIDOLR3kewHJ
	 +EhJ0biRI+Ewg==
Date: Wed, 30 Oct 2024 23:39:11 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH] perf, riscv: Wire up perf trace support for RISC-V
Message-ID: <ZyMmD1SdqpIg8Wox@google.com>
References: <20241024190353.46737-1-bjorn@kernel.org>
 <ZyF_whZ4Ez-jwd-W@google.com>
 <faa08151-3090-4c36-b4af-32f5378ac5a6@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <faa08151-3090-4c36-b4af-32f5378ac5a6@ghiti.fr>

Hello,

On Wed, Oct 30, 2024 at 08:31:35AM +0100, Alexandre Ghiti wrote:
> Hi Bjorn, Namhyung,
> 
> On 30/10/2024 01:37, Namhyung Kim wrote:
> > Hello,
> > 
> > On Thu, Oct 24, 2024 at 12:03:51PM -0700, Björn Töpel wrote:
> > > From: Björn Töpel <bjorn@rivosinc.com>
> > > 
> > > RISC-V does not currently support perf trace, since the system call
> > > table is not generated.
> > > 
> > > Perform the copy/paste exercise, wiring up RISC-V system call table
> > > generation.
> > Can anybody with RISC-V please test this?
> 
> 
> So before this patch, I get:
> 
> Error::5File /sys/kernel/tracing//events/raw_syscalls/sys_(enter|exit) not
> found.
> Hint:    Perhaps this kernel misses some CONFIG_ setting to enable this
> feature?.
> 
> After applying this patch, I get a proper trace:
> ....
> 
>      7.435 ( 0.332 ms): ls/1307 openat(dfd: CWD, filename: 0xb36ef668,
> flags: RDONLY|CLOEXEC)         = 3
>      8.023 ( 0.454 ms): ls/1307 mmap(len: 23171, prot: READ, flags: PRIVATE,
> fd: 3)                   = 0x7fffb36cd000
>      8.558 ( 0.065 ms): ls/1307 close(fd:
> 3)                                                          = 0
>      8.850 ( 0.294 ms): ls/1307 openat(dfd: CWD, filename: 0xb36f9f80,
> flags: RDONLY|CLOEXEC)         = 3
>      9.223 ( 0.152 ms): ls/1307 read(fd: 3, buf: 0x7fffe27b3c20, count: 832)
> 
> ...
> 
> So you can add:
> 
> Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks for your test!
Namhyung

