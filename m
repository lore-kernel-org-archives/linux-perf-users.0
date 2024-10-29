Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7C71CD2B;
	Tue, 29 Oct 2024 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219473; cv=none; b=PXXl9UCYdSqrtpL2O9fuYlXWhQmw16D/06oqWTIIfgiO+QqnwvEEae3TOhSqUqDRB3oDqfF1lD1cR5eUUhBYqmEoAT+WqJpI+fbeVY0PDkc37+t30DcrmBNGmKi2AXtkfrMS2eH1r38GpxjeP2XcxA0ZfqGf9hk8mE8mZm+3fz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219473; c=relaxed/simple;
	bh=T5XAEMTGYNcVrVOLqsPspj87vONbe6l/2fmCiUAEOec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K14i0fFYKR28rkgfZTpOaSm90nGkmDKntgM5REUtIq7kgwHAPWW9YeC2J2RbFPABhtcHx+APWyKQ2Uxru9sa7qkNq8urLwKECw3ebbs7pSw5rHOcDv602+PoMM09+nrM8cEqpgYwG0KI/2SQ3cDKvDCkMp8rnd1pbfachCOzoY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRA+bTJk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRA+bTJk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389F9C4CECD;
	Tue, 29 Oct 2024 16:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730219473;
	bh=T5XAEMTGYNcVrVOLqsPspj87vONbe6l/2fmCiUAEOec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gRA+bTJkPChYft7mJH/fttEGyuL/avIx6PC3/oQF58O21C8JtC17Q3KIItH1XcG+m
	 gilh4aN1R8Y/bDcx/kI4EGT1tzBxw4QJqAyl7QCA3XvDFJVco5H2k/rDlvInahd4TX
	 h4DMuXV5eWMlOO6zExkKG+xWitcditJEBFZs4AfelkVy2b6TJlaYLQQRi+pj7e6D5B
	 uH4vTTcNXjCGLxIqdL1ghA87VzYaPSuW3yZi81SOjHG1eX4SHEB1an7Pc/V4QRe+lc
	 M6rLHD9uk3gatD9yahIx3jTecIKwilJ436SclrYjRMb5QXAu3WPN644/4lh7QcAVit
	 D7pw0OfQcoFcQ==
Date: Tue, 29 Oct 2024 09:31:10 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 08/19] unwind/x86: Enable CONFIG_HAVE_UNWIND_USER_FP
Message-ID: <20241029163110.xf5o2bvfbfcenlla@treble.attlocal.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <2354d43022bd336c390e1e77f7cee68126d5f8c8.1730150953.git.jpoimboe@kernel.org>
 <20241029131303.GW14555@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029131303.GW14555@noisy.programming.kicks-ass.net>

On Tue, Oct 29, 2024 at 02:13:03PM +0100, Peter Zijlstra wrote:
> On Mon, Oct 28, 2024 at 02:47:35PM -0700, Josh Poimboeuf wrote:
> > Use ARCH_INIT_USER_FP_FRAME to describe how frame pointers are unwound
> > on x86, and enable CONFIG_HAVE_UNWIND_USER_FP accordingly so the
> > unwind_user interfaces can be used.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> >  arch/x86/Kconfig                   |  1 +
> >  arch/x86/include/asm/unwind_user.h | 11 +++++++++++
> >  2 files changed, 12 insertions(+)
> >  create mode 100644 arch/x86/include/asm/unwind_user.h
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 0bdb7a394f59..f91098d6f535 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -289,6 +289,7 @@ config X86
> >  	select HAVE_SYSCALL_TRACEPOINTS
> >  	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
> >  	select HAVE_UNSTABLE_SCHED_CLOCK
> > +	select HAVE_UNWIND_USER_FP		if X86_64
> >  	select HAVE_USER_RETURN_NOTIFIER
> >  	select HAVE_GENERIC_VDSO
> >  	select VDSO_GETRANDOM			if X86_64
> > diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
> > new file mode 100644
> > index 000000000000..19df26a65132
> > --- /dev/null
> > +++ b/arch/x86/include/asm/unwind_user.h
> > @@ -0,0 +1,11 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_X86_UNWIND_USER_H
> > +#define _ASM_X86_UNWIND_USER_H
> > +
> > +#define ARCH_INIT_USER_FP_FRAME							\
> > +	.ra_off		= (s32)sizeof(long) * -1,				\
> > +	.cfa_off	= (s32)sizeof(long) * 2,				\
> > +	.fp_off		= (s32)sizeof(long) * -2,				\
> > +	.use_fp		= true,
> > +
> > +#endif /* _ASM_X86_UNWIND_USER_H */
> 
> What about compat / 32bit userspace?

Sframe doesn't support 32-bit binaries at the moment.  Does anybody
actually care?

You're right this regresses existing perf behavior for the frame pointer
case.  I'll try to fix that.

-- 
Josh
