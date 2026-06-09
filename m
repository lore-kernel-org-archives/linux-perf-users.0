Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B605F3DBD7C;
	Tue,  9 Jun 2026 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990377; cv=none; b=U2jNH/mmzNq+0qX9qgZmXbTKPiw0xXnTH7dufqV5KzcCkWCcqio3OJPJwz5nQzKO2twQKu/G+X/7z2lQ4N4tzprXzXUPnbwwNt9nKpyrSRfV0rvQggj+FbuuDj36ML/4fil6m+ejrQWsUomDhGtghs6ENX0zJvTQ3hqUc8wY5WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990377; c=relaxed/simple;
	bh=TXPwTaqJf90GlD07J+Kv1JBU5ZJkhvOn//4lpMXqnvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3PDiOsmvBbdOytZ0NUV7e+sGsCWZVQ8sUqXePiW9EPUBChb0x3iXq3OctV0wIr42X7TUovi+gN4OOkVHjzQxMk9OwRir9lcVZUWk7mw2Dv+Dxg4eIcqijkLZrWUHPR3+tOxfWzzYuM5WamnI4EA6xVSJT6CXwQ3+tor8STHKtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from martin by akranes.kaiser.cx with local (Exim 4.98.2)
	(envelope-from <martin@akranes.kaiser.cx>)
	id 1wWqx9-0000000210y-46QZ;
	Tue, 09 Jun 2026 09:32:51 +0200
Date: Tue, 9 Jun 2026 09:32:51 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf riscv: fix register name strings
Message-ID: <aifBo1zkxfIacrXB@akranes.kaiser.cx>
References: <20260608192731.708606-1-martin@kaiser.cx>
 <CAP-5=fV6tVQA1TO_j9TDzPXV+ik3ww-mxX-VaO_XCGkAWYffag@mail.gmail.com>
 <aicll3FawrGwTQ-1@x1>
 <aicpIOkNGIn80TeN@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aicpIOkNGIn80TeN@x1>
Sender: "Martin Kaiser,,," <martin@akranes.kaiser.cx>

Thus wrote Arnaldo Carvalho de Melo (acme@kernel.org):

> On Mon, Jun 08, 2026 at 05:27:03PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, Jun 08, 2026 at 01:08:28PM -0700, Ian Rogers wrote:
> > > On Mon, Jun 8, 2026 at 12:27 PM Martin Kaiser <martin@kaiser.cx> wrote:

> > > > On risc-v, pref probe generates an invalid syntax for a named register in
> > > > a kprobe.

> > > > $ perf probe --debug verbose --add "n_tty_write tty"
> > > > ...
> > > > Writing event: p:probe/n_tty_write _text+8922528 tty=%"%a0":x64
> > > > Failed to write event: Invalid argument

> > > > The problem is the combination of

> > > >    #define REG_DWARFNUM_NAME(reg, idx) [idx] = "%" #reg

> > > > and entries such as

> > > >    REG_DWARFNUM_NAME("%a0", 10)

> > > > where #reg will escape the quotes of the first macro parameter.

> > > > Update the macro definition to produce the correct syntax for a named
> > > > register in a kprobe, i.e. the unquoted register name with only one
> > > > leading %.

> > > > Fixes: a90c4519186d ("perf riscv: Remove dwarf-regs.c and add dwarf-regs-table.h")
> > > > Signed-off-by: Martin Kaiser <martin@kaiser.cx>

> > > Reviewed-by: Ian Rogers <irogers@google.com>

> > > Thanks for catching this! Sashiko is also green for this change:
> > > https://sashiko.dev/#/patchset/20260608192731.708606-1-martin%40kaiser.cx

> > Strange,

> >   LD      /tmp/build/perf-tools-next/tests/perf-test-in.o
> >   LD      /tmp/build/perf-tools-next/perf-test-in.o
> > In file included from util/dwarf-regs.c:23:
> > util/../arch/riscv/include/dwarf-regs-table.h:5:9: error: ‘REG_DWARFNUM_NAME’ redefined [-Werror]
> >     5 | #define REG_DWARFNUM_NAME(reg, idx)     [idx] = reg
> >       |         ^~~~~~~~~~~~~~~~~
> > In file included from util/dwarf-regs.c:22:
> > util/../arch/powerpc/include/dwarf-regs-table.h:10:9: note: this is the location of the previous definition
> >    10 | #define REG_DWARFNUM_NAME(reg, idx)     [idx] = "%" #reg
> >       |         ^~~~~~~~~~~~~~~~~
> > In file included from util/dwarf-regs.c:24:
> > util/../arch/s390/include/dwarf-regs-table.h:5:9: error: ‘REG_DWARFNUM_NAME’ redefined [-Werror]
> >     5 | #define REG_DWARFNUM_NAME(reg, idx)     [idx] = "%" #reg
> >       |         ^~~~~~~~~~~~~~~~~
> > util/../arch/riscv/include/dwarf-regs-table.h:5:9: note: this is the location of the previous definition
> >     5 | #define REG_DWARFNUM_NAME(reg, idx)     [idx] = reg
> >       |         ^~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> > make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:96: /tmp/build/perf-tools-next/util/dwarf-regs.o] Error 1


> > Trying to figure out why Sashiko is green on it but it doesn't build
> > here...

> C preprocessor benign redefinition rule kicked in, this is a preexisting
> problem, the headers need to undef that REG_DWARFNUM_NAME that now is
> different in one of the headers, Risc-V's.

> I'll cook up a patch to merge before this one.

I see. We need an undef for risc-v, similar to mips.

Let me send a v2 so we have all in one patch, that should be simpler to
backport to stable.

Thanks,
Martin
