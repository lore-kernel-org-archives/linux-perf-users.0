Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B169C1547FE;
	Wed, 18 Dec 2024 18:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734547295; cv=none; b=YcptEybVpCOoHKw+hb+lsh3OgXtK5JST/llLQ/k6LfKVTH26zYuhSPXKZg24wIrzqwRdkuSZU2l8g38p8M4c55DEjhEdqIjEHeg/Y+HkxvBWcAlFqeQVq/tVucm0WJf4BcvLqjT0Q8RissR3rYDvwO+wJEq+h1/lXm0gwe46Dd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734547295; c=relaxed/simple;
	bh=1Pk+Poo09suXrcvpVp1oeGmHxV7JSee/hgW3Otg+GAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=of1cLxemnEEOiiOQd9hKFeA2ZG+thQASR3sas1c0mP4XYxj/efCEgvSKoxiBWy/VQe2LEnUSwFPtuS1TYygGLJZnSsRl3c3Pyd8Vu1n6EvdjcF1RGLDC6eLd8BgC5E8aBwGTZpwfjPTqx/ooEAn30ewrJ47ttkSfelNOHasf30M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uy330i6b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uy330i6b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9084FC4CECD;
	Wed, 18 Dec 2024 18:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734547295;
	bh=1Pk+Poo09suXrcvpVp1oeGmHxV7JSee/hgW3Otg+GAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uy330i6btvqwZgD3agJyLdpKiwp+PX1tQV0zDq654AyMEhBdyQm/UEzu8RrjK4RLB
	 7yT8BbG7fFfUcVyRZ6KSRe8bBpM/uPoVL/JNstJi/clCMSjO/C23S4q9Q0pwWfoMZa
	 /uM2ofy+8XL3Xf6Ytbedoi3zgGU0YyRIlY37c/AI1JeJwXdTRvwkss2UkqjETmbexE
	 T+kv6sITMUtX0NeLDbFdKv0cH5uY43wx/jXrgd+z4V57L+/AHPiROUog9JbuOcWfjb
	 av1xFUrtzpAt7r4YmRzkhTEiC2FLWU2lOn/zYQporOQJUHJpA2dCL1zA91sM+YFWYh
	 QT3q8QjhL1CLQ==
Date: Wed, 18 Dec 2024 15:41:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] tools: perf: tests: Fix code reading for riscv
Message-ID: <Z2MXXFhUzoQmW4xV@x1>
References: <20241217-perf_fix_riscv_obj_reading-v2-1-58f81b7b4c7d@rivosinc.com>
 <CAP-5=fXK6HRzBKHzF=T_w9cn7ohWOdmZNRMXvJzN6QG11HE6tA@mail.gmail.com>
 <Z2IXl5cuKQJInJb0@ghost>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2IXl5cuKQJInJb0@ghost>

On Tue, Dec 17, 2024 at 04:30:15PM -0800, Charlie Jenkins wrote:
> On Tue, Dec 17, 2024 at 04:18:32PM -0800, Ian Rogers wrote:
> > On Tue, Dec 17, 2024 at 3:52 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > After binutils commit e43d876 which was first included in binutils 2.41,
> > > riscv no longer supports dumping in the middle of instructions. Increase
> > > the objdump window by 2-bytes to ensure that any instruction that sits
> > > on the boundary of the specified stop-address is not cut in half.

> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

> > Reviewed-by: Ian Rogers <irogers@google.com>

> > > A binutils patch has been sent as well to fix this in objdump [1].

> > > Link: https://sourceware.org/pipermail/binutils/2024-December/138139.html [1]

> > > Changes in v2:
> > > - Do objdump version detection at runtime (Ian)
> > > - Link to v1: https://lore.kernel.org/r/20241216-perf_fix_riscv_obj_reading-v1-0-b75962660a9b@rivosinc.com

> > > --- a/tools/perf/tests/code-reading.c
> > > @@ -183,9 +244,30 @@ static int read_via_objdump(const char *filename, u64 addr, void *buf,
> > >         const char *fmt;
> > >         FILE *f;
> > >         int ret;
> > > +       u64 stop_address = addr + len;
> > > +
> > > +       if (IS_ENABLED(__riscv)) {

> > Not sure if there is a consistency issue here. Elsewhere we're just
> > using ifdef, such as:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/include/dwarf-regs.h?h=perf-tools-next#n69
 
> I don't have any strong feelings about that. I can change it to be an
> ifdef. On other lists I have been told to use IS_ENABLED whenever
> possible, but it's only a small difference.

Can't we just use uname here?

So that we don't use kconfig.h since its not used in tools/perf/ and
makes it looks like perf is in lockstep with the kernel source tree
version it was compiled from?

$ git grep kconfig.h tools/perf/
$

BTW, what would happen if I collected a perf.data file on x86_64 and
would read it in a RiscV machine with such a objdump version? The same
problem?

- Arnaldo
