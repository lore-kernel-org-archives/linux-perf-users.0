Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1273AE6E4;
	Wed,  1 Jul 2026 19:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934207; cv=none; b=P2h4GJ/lQ/GtExMrpe7OxDLF5wXE+A0I7cDs3oyPaEAdAfXxiyoQr9F9TBnygNMvRF+z12aHhuZcVTfyFKgFSR19vTAGTOO75MBDVK2stZnK+b6DwMWZUDckHJcdzelhZx5SFa4RYdiBbuhI8gWZOEEmoRz1O21cBIdVAy7nrYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934207; c=relaxed/simple;
	bh=EXFDx5YLwQvUq1V2FSyBivdOf/4BefGfZI8fnVbymms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ky+cxgtFFhpedag1nrQHSG80LA7k8Kbh/OhqOjWbWRDRt32YkfJpmWVtjPkRXHXVdhy/hz3yiUK0yoXRGFpDIkPiuvw3CiYQSU/LofslKfP5X9NwfpmxhNsVXdWxH+kmVRotAUhWNWmTKtnAjIrCpCwVdzKCG3guNn/1JI3rFTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTnliEC0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTnliEC0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C54A1F00A3A;
	Wed,  1 Jul 2026 19:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782934206;
	bh=0pJReApdF4VfwcZ+I3abYw8EcT9F135p4+HAF/w0pMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mTnliEC0JfySNtlClaCpye6PvJr6ifYNGZy3Z6KQ9Q3gJdBPHQlTmoI2FJlAFrEVk
	 A2nyZmWXb7yLN4lUkUl/AbrPwNqphqz8vk07h43O7jjBvIYXwB2oE27m50ES73i/9p
	 YAIUrLwvb+A8QQTj/jJ01p0v2Tw8GMql4f+vCdARwgMJMnAl+FvhFKlCyme3ZaMnt9
	 S8P44vQN21ssKC0lpSuzj1doLMz4HnW5J6bTHeNfRlXYQbjehc1nfQm9eL0aKHUs3y
	 bJRxc8xuy6/93SEudDFz+lUFXQmBbws3ABpoieV2lkkuSd+cQF+nlYd4dUbCfSOWUH
	 Kqr4nbQfskG9A==
Date: Wed, 1 Jul 2026 12:30:04 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf build: Fix compiler errors with old capstone
Message-ID: <akVqvG7amtP99cmE@google.com>
References: <20260701182824.347941-1-namhyung@kernel.org>
 <CAP-5=fUzfFkErqnDp4iJEgCQdAO1pFRKMKWn3mhEGK5z2qZvWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUzfFkErqnDp4iJEgCQdAO1pFRKMKWn3mhEGK5z2qZvWA@mail.gmail.com>

Hi Ian,

On Wed, Jul 01, 2026 at 11:49:03AM -0700, Ian Rogers wrote:
> On Wed, Jul 1, 2026 at 11:28 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > It seems RISCV was added in capstone version 5.  Unfortunately they are
> > enum constants so cannot check with #ifdef but anyway we can define the
> > symbols.  Let's do it using the version number to avoid build errors.
> > It'll fail at runtime though.
> >
> >   util/capstone.c: In function 'e_machine_to_capstone':
> >   util/capstone.c:186:25: error: 'CS_ARCH_RISCV' undeclared (first use in this function);
> >                                   did you mean 'CS_ARCH_SYSZ'?
> >     186 |                 *arch = CS_ARCH_RISCV;
> >         |                         ^~~~~~~~~~~~~
> >         |                         CS_ARCH_SYSZ
> >   util/capstone.c:186:25: note: each undeclared identifier is reported only once for each function it appears in
> >
> >   util/capstone.c:187:34: error: 'CS_MODE_RISCV64' undeclared (first use in this function);
> >                                   did you mean 'CS_MODE_MIPS64'?
> >     187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
> >         |                                  ^~~~~~~~~~~~~~~
> >         |                                  CS_MODE_MIPS64
> >
> > Also note that capstone renamed CS_MODE_RISCVC to CS_MODE_RISCV_C which
> > would cause a different build failure on latest versions.  It's reported
> > in https://github.com/capstone-engine/capstone/issues/2977 so I think
> > they will add compatibility layer to prevent the error.
> >
> > Fixes: 12c4737f55f2 ("perf capstone: Determine architecture from e_machine")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Perhaps update the feature test from:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/build/feature/test-libcapstone.c?h=perf-tools-next
> ```
> cs_open(CS_ARCH_X86, CS_MODE_64, &handle);
> ```
> to be CS_ARCH_RISCV? That way we won't detect old libcapstones and
> avoid cluttering up the code.

Then it'll drop support for capstone version 4 which works fine on some
architectures.  Maybe we can add another feature check for capstone
RISC-V support but I think it's better to define the RISCV symbols here.

What do you think?

Thanks,
Namhyung

