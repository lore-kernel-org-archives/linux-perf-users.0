Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6F01DA63D;
	Tue, 22 Apr 2025 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745343734; cv=none; b=O1ujKiJnm/u8Xy+XNVvlGtwyvNQGPyQoLMVXVIrhs5vUIz0CdEj5boN8LaooytkH/yW5PUKsJhVg5wwccF2rhG0K27ehv3hYXODuFk4yrBwRR3tsFwx+nUO8wAHQ+oPn+nSOOdbrbxhGuwL2K1zd0Q8vMp+NhoAHV0AOK2x3nIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745343734; c=relaxed/simple;
	bh=QaEXmCGSZOW0nPSYRQqYZLcN6XSKT+AUR8R/rRFsWb4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TjOaooRCjnHo//LPBwnu/EeUsuQZPmDu1l4/o6C8p5C9yyupWUksLQ+Ouz07d845aoEpdN/SDt+zLyTN9mPBTSPWgtpuARSNjPW9GTdMu3I8I0XI8vZpHXF2SOAM+yVh8jEXFibdlqdhPQztZgXK9cwpofvXQx/WUQ6GyuCHkbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AC0C4CEE9;
	Tue, 22 Apr 2025 17:42:11 +0000 (UTC)
Date: Tue, 22 Apr 2025 13:44:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, x86@kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, Indu Bhagat
 <indu.bhagat@oracle.com>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
 <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>, Sam
 James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Florian Weimer <fweimer@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Weinan Liu <wnliu@google.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v4 09/39] x86/vdso: Enable sframe generation in VDSO
Message-ID: <20250422134401.55178c36@gandalf.local.home>
In-Reply-To: <20250124164332.gqgzimfix3vk4bsw@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
	<c93fbd53f01c2c86f747af27040ac11f16dee032.1737511963.git.jpoimboe@kernel.org>
	<cde90a82-6bdd-4a12-872a-7b39edf3eac8@linux.ibm.com>
	<20250124164332.gqgzimfix3vk4bsw@jpoimboe>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jan 2025 08:43:32 -0800
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> On Fri, Jan 24, 2025 at 05:00:27PM +0100, Jens Remus wrote:
> > On 22.01.2025 03:31, Josh Poimboeuf wrote:  
> > > diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
> > > index b195b3c8677e..1c354f648505 100644
> > > --- a/arch/x86/include/asm/dwarf2.h
> > > +++ b/arch/x86/include/asm/dwarf2.h
> > > @@ -12,8 +12,11 @@
> > >   	 * For the vDSO, emit both runtime unwind information and debug
> > >   	 * symbols for the .dbg file.
> > >   	 */
> > > -  
> > 
> > Nit: Deleted blank line you introduced in "[PATCH v4 05/39] x86/asm:
> > Avoid emitting DWARF CFI for non-VDSO".  
> 
> Indeed.

Note, I'm getting ready to send out an update of Josh's patches.

This particular nit isn't really an issue, as #ifdef's do sometimes replace
blank lines.

Just mentioning this so you don't think I'm ignoring it, when I post patches.

-- Steve
