Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A0833F5AB;
	Mon,  8 Jun 2026 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951333; cv=none; b=fFgBlshiHiDxAR1OrghQ2pVc9r2dHR/cMQ9kHmSIAdo04G9daYCAXwTsHU9OjXt4nfqIWxvNZqFSlxg5CoOsH/eUf8mDTnX8Xqi+y88NWa+Q+RHkBhGvndHTDSNPuoMScueALpP0A82GExqd9Rlp7rEKL5kJwBLps3VbujSuRyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951333; c=relaxed/simple;
	bh=n/k7k7XpRLWHszvfJ6GMCTEb7nVbdyXTTnGX9Mz8iYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZT42kGKbUftrHCCkHfu94rSaF62dgQtiyV23sqrmXV0MYNWTkHB7VN1BAW9LVoiUMfM3n9L9gfEgDSt0dHEjs+33HXWnqGqt8i+pnYsWkNhUHwk9ndyqF/rpACimLwxnwFAxtL5WVrYGECjZmicVPEQsLp/mNsW1mnQLo0H43+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNr99adO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNr99adO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F8B1F00893;
	Mon,  8 Jun 2026 20:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780951332;
	bh=PR7pG8wAfrRCPKNdFjSjuvjMT0lgk6g+9kyjolRDVK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VNr99adO/XePoVd/WKtJ5y97g+zTLllkLqZAmEOf6Ts50ou/IHNiVXVvw8DpoAE86
	 MvErgyJWYdkkHrnl1XeDdfmU68K1OiyxO2kXOXl24TcpFXBf1RYrOBrAX3FbF21AxG
	 zqTbcEepTsz4lNXs+KfNEFAkvGJk5xuYYLAKAki85m3yXKqo7ez62jv+/fX37th9f6
	 hlKYMc/0pGnuH6y3b2BBGQ/eDB+7ubHH8nYFPGuQe+OvXzmjIcki/s8GNhMf8XpfjG
	 aQjYdHBi4A1qVxIVemBiB9Piepue+wBnVznd4DeTFXNSVFg+C3GRB3tZM3K4n+amAX
	 SiBxvfMt9TzZg==
Date: Mon, 8 Jun 2026 17:42:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Martin Kaiser <martin@kaiser.cx>, Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf riscv: fix register name strings
Message-ID: <aicpIOkNGIn80TeN@x1>
References: <20260608192731.708606-1-martin@kaiser.cx>
 <CAP-5=fV6tVQA1TO_j9TDzPXV+ik3ww-mxX-VaO_XCGkAWYffag@mail.gmail.com>
 <aicll3FawrGwTQ-1@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aicll3FawrGwTQ-1@x1>

On Mon, Jun 08, 2026 at 05:27:03PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Jun 08, 2026 at 01:08:28PM -0700, Ian Rogers wrote:
> > On Mon, Jun 8, 2026 at 12:27 PM Martin Kaiser <martin@kaiser.cx> wrote:
> > >
> > > On risc-v, pref probe generates an invalid syntax for a named register in
> > > a kprobe.
> > >
> > > $ perf probe --debug verbose --add "n_tty_write tty"
> > > ...
> > > Writing event: p:probe/n_tty_write _text+8922528 tty=%"%a0":x64
> > > Failed to write event: Invalid argument
> > >
> > > The problem is the combination of
> > >
> > >    #define REG_DWARFNUM_NAME(reg, idx) [idx] = "%" #reg
> > >
> > > and entries such as
> > >
> > >    REG_DWARFNUM_NAME("%a0", 10)
> > >
> > > where #reg will escape the quotes of the first macro parameter.
> > >
> > > Update the macro definition to produce the correct syntax for a named
> > > register in a kprobe, i.e. the unquoted register name with only one
> > > leading %.
> > >
> > > Fixes: a90c4519186d ("perf riscv: Remove dwarf-regs.c and add dwarf-regs-table.h")
> > > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> > 
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > 
> > Thanks for catching this! Sashiko is also green for this change:
> > https://sashiko.dev/#/patchset/20260608192731.708606-1-martin%40kaiser.cx
> 
> Strange,
> 
>   LD      /tmp/build/perf-tools-next/tests/perf-test-in.o
>   LD      /tmp/build/perf-tools-next/perf-test-in.o
> In file included from util/dwarf-regs.c:23:
> util/../arch/riscv/include/dwarf-regs-table.h:5:9: error: ‘REG_DWARFNUM_NAME’ redefined [-Werror]
>     5 | #define REG_DWARFNUM_NAME(reg, idx)     [idx] = reg
>       |         ^~~~~~~~~~~~~~~~~
> In file included from util/dwarf-regs.c:22:
> util/../arch/powerpc/include/dwarf-regs-table.h:10:9: note: this is the location of the previous definition
>    10 | #define REG_DWARFNUM_NAME(reg, idx)     [idx] = "%" #reg
>       |         ^~~~~~~~~~~~~~~~~
> In file included from util/dwarf-regs.c:24:
> util/../arch/s390/include/dwarf-regs-table.h:5:9: error: ‘REG_DWARFNUM_NAME’ redefined [-Werror]
>     5 | #define REG_DWARFNUM_NAME(reg, idx)     [idx] = "%" #reg
>       |         ^~~~~~~~~~~~~~~~~
> util/../arch/riscv/include/dwarf-regs-table.h:5:9: note: this is the location of the previous definition
>     5 | #define REG_DWARFNUM_NAME(reg, idx)     [idx] = reg
>       |         ^~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:96: /tmp/build/perf-tools-next/util/dwarf-regs.o] Error 1
> 
> 
> Trying to figure out why Sashiko is green on it but it doesn't build
> here...

C preprocessor benign redefinition rule kicked in, this is a preexisting
problem, the headers need to undef that REG_DWARFNUM_NAME that now is
different in one of the headers, Risc-V's.

I'll cook up a patch to merge before this one.

- Arnaldo
