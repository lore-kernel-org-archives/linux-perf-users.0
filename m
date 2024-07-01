Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BC0145B09;
	Mon,  1 Jul 2024 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838608; cv=none; b=FMZQzuxkm8vG++wmwNTYMMjF9p9toAqRWfR4qNV0VoFkhEoae5aI4DJxmFPwFxBM3l4PCqk2J/Rm39z24WNKie+zz3MZi5Sw7jvPr8rpPIqxqJNJ9qSsSSJu978YBmS00TRFv4zZP5X1o0DY5+2rj0NAtMsSJ3yfwWBl5wpmKNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838608; c=relaxed/simple;
	bh=4abuYWviVGcFbfSub23I7YcPpLJIZ0K42garfyxmCmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwTmfpAFGdbPKUi3LD5vIFnZFUgSvcnRwo1RkSMgeXzDwZEBvavCpG3rK5ISkcn/jvHhcyms6YO8n6bkwoG01JyVXE6i1YU4jL4YsF/aFtLbf7hE1S/tV9CFJLSskAK8hFQCjE8ih8+q0KJy8KCLB3DgQTzTW/bE7QEptHKdV9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eAf5da1L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fzL8enEh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eAf5da1L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fzL8enEh"
Date: Mon, 1 Jul 2024 14:56:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719838605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dBApTZsHAhU7GXzgUJOuBx5pWY7Nk5ITlgRQcEs/IAc=;
	b=eAf5da1LgJ4oE317XtUcQl8aRT2HlNCAp6sAyTYDBF5uw14Kv2+OnROj1GjN9mJncq4Hvf
	N+BhsB8Z36XfeJAkO55fhONOUTc19XLVBMb4MU5PM/IYxpwkNg89yNyTINWqEAeVaQJd8n
	QFmuwPRr7CYm+Ybg3tUBgJalNU4tm+aOU//N7wbMJOWmYLGJXBk3I5I4K+7zXmcoTW4mKF
	7VGu5l4xvxyL1c7qGrYscaQ79JdWgs3DdoSq0tILBmeiZNukizOw5KzzDxh74rGVprHalO
	eL5uDsx6+7bWammQbKaI2Jz2sX/Q4+lW4m3kact77PlNGNrli+EUYNkKPgMebw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719838605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dBApTZsHAhU7GXzgUJOuBx5pWY7Nk5ITlgRQcEs/IAc=;
	b=fzL8enEhiUH9rZou/amr7qFMmFMc1kWGYvki/C7mlMajsDxuZVFxWyMwrbm07yK+N6StgI
	D2xoCx1eCqPM36BA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 3/6] perf: Shrink the size of the recursion counter.
Message-ID: <20240701125643.kqJWwrhW@linutronix.de>
References: <20240624152732.1231678-1-bigeasy@linutronix.de>
 <20240624152732.1231678-4-bigeasy@linutronix.de>
 <20240701123137.GF20127@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240701123137.GF20127@noisy.programming.kicks-ass.net>

On 2024-07-01 14:31:37 [+0200], Peter Zijlstra wrote:
> On Mon, Jun 24, 2024 at 05:15:16PM +0200, Sebastian Andrzej Siewior wrote:
> > There are four recursion counter, one for each context. The type of the
> > counter is `int' but the counter is used as `bool' since it is only
> > incremented if zero.
> > 
> > Reduce the type of the recursion counter to an unsigned char, keep the
> > increment/ decrement operation.
> 
> Does this actually matter? Aren't u8 memops encoded by longer
> instructions etc..

The goal here isn't to reduce the opcodes but to add it to task_struct
without making it larger by filling a hole.

But since you made me look at assembly:
old:
     316b:       65 48 8b 15 00 00 00    mov    %gs:0x0(%rip),%rdx        # 3173 <perf_swevent_get_recursion_context+0x33>
     3173:       1c ff                   sbb    $0xff,%al
     3175:       48 0f be c8             movsbq %al,%rcx
     3179:       48 8d 94 8a 00 00 00    lea    0x0(%rdx,%rcx,4),%rdx
     3180:       00
                         317d: R_X86_64_32S      .data..percpu+0x4c
     3181:       8b 0a                   mov    (%rdx),%ecx
     3183:       85 c9                   test   %ecx,%ecx
     3185:       75 0e                   jne    3195 <perf_swevent_get_recursion_context+0x55>
     3187:       c7 02 01 00 00 00       movl   $0x1,(%rdx)
^^^
     318d:       0f be c0                movsbl %al,%eax

new:
     2ff8:       1c ff                   sbb    $0xff,%al
     2ffa:       81 e2 00 01 ff 00       and    $0xff0100,%edx
     3000:       83 fa 01                cmp    $0x1,%edx
     3003:       1c ff                   sbb    $0xff,%al
     3005:       48 0f be d0             movsbq %al,%rdx
     3009:       48 8d 94 11 00 00 00    lea    0x0(%rcx,%rdx,1),%rdx
     3010:       00
                         300d: R_X86_64_32S      .data..percpu+0x4c
 
     3011:       80 3a 00                cmpb   $0x0,(%rdx)
     3014:       75 0b                   jne    3021 <perf_swevent_get_recursion_context+0x51>
     3016:       c6 02 01                movb   $0x1,(%rdx)
^^^
     3019:       0f be c0                movsbl %al,%eax
     301c:       e9 00 00 00 00          jmp    3021 <perf_swevent_get_recursion_context+0x51>

So we do even save a few bytes. We could avoid the "movsbl" at 3019 by
making the return type `unsigned char' ;)

Sebastian
