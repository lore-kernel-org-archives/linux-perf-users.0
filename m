Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EBA13B2B6;
	Mon, 16 Sep 2024 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726501201; cv=none; b=Z10ztU3KETLBP8HbInCnubJHzPKTaRFyYzVVBx9z1RhS+1L9hokTa40kCeY1ASsSgY4aBJutrGEco7GbDSOSTGLPhU3I/sxXIGlS2MFYkKKPCTQh6z71p/rnKq1/+XO/s8iHGgABWO2Wskj05e1bZmelmH9AJEjfjgy+bcwrbUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726501201; c=relaxed/simple;
	bh=1AFbJegPKrMyVrzc1W5LFPXXqbB6e75NAfjEJqtL+xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKv6Q0okui2Th88qH27z8NKIQtz+tqTNT7CqPQd15GXvgb6fG8wRO3bJ/ghNKq4I0pygARD+LdvduK6hpD2ZifWuCDhwBEY0T0Mc8kyAeBd9p+9Dj+Qn4BM81TjCVmtHtjbiAW9DWC/SrDawG2OpOlBKmQLL7BaKPnL6gir7lnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4RmNnW3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4RmNnW3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1C1C4CEC4;
	Mon, 16 Sep 2024 15:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726501201;
	bh=1AFbJegPKrMyVrzc1W5LFPXXqbB6e75NAfjEJqtL+xE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G4RmNnW3y/RFemeTShTKwQN15IQqor0H05FEMBPI00n14/PF6sXMwJCPEj2lSO4l7
	 YB/MlObmVbPjC3uQLNTB6wAxzW9U0dWvUMvbQpovEIbhThFBqRAgkaTiheYEvj7IJM
	 DObFx3HufN6g5rPyWTGuume8kbflJZY6P6RC8c/Ttlr9XC1zoB4IHbfjzMLKcFd2Hu
	 1/wXv44pK+xCOIA+fBTyhnDxAbaZyB5SeXvelPJHHg1vpNi7ckwntZgV0Laz1cL1kV
	 wFB8p7m3gBAb/fjY3nkzbaXNopRrb3Ssc8hWTHajWVqueZNVv0jenez0vDrwooIZyV
	 BCCLNkYglrgMg==
Date: Mon, 16 Sep 2024 17:39:53 +0200
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
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
	Sam James <sam@gentoo.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 00/11] unwind, perf: sframe user space unwinding,
 deferred perf callchains
Message-ID: <20240916153953.7fq5fmch5uqg7tjj@treble>
References: <cover.1726268190.git.jpoimboe@kernel.org>
 <20240914081246.1e07090c@rorschach.local.home>
 <20240915111111.taq3sb5xzqamhb7f@treble>
 <20240916140856.GB4723@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240916140856.GB4723@noisy.programming.kicks-ass.net>

On Mon, Sep 16, 2024 at 04:08:56PM +0200, Peter Zijlstra wrote:
> On Sun, Sep 15, 2024 at 01:11:11PM +0200, Josh Poimboeuf wrote:
> > On Sat, Sep 14, 2024 at 08:12:46AM -0400, Steven Rostedt wrote:
> > > I think the unwinder should have an interface itself that provides the
> > > deferred unwinding, instead of having all the tracers to implement
> > > their own.
> > > 
> > > The user space unwinder (regardless of sframe or not) should provide a
> > > way to say "I want a user space stack trace for here, but don't do it
> > > yet. Just give me a cookie and then call my callback function with the
> > > stack and cookie before going back to user space".
> > 
> > We (Steven, Mathieu and I) have been discussing this at GNU Cauldron and
> > I think we're in basic agreement on this.
> > 
> > I think the biggest tweak we decided on is that the context id (aka
> > "cookie") would be percpu.  Its initial value is (cpuid << 48).  It gets
> > incremented for every entry from user space.
> 
> Why? What's the purpose of the cookie?

The cookie is incremented once per entry from userspace, when needed.

It's a unique id used by the tracers which is emitted with both kernel
and user stacktrace samples so the userspace tool can stitch them back
together.  Even if you have multiple tracers triggering at the same time
they can all share a single user trace.

Completely untested patch here that I hacked up today:

 git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git sframe-2.1

To avoid races, unwind_user_deferred() can't be called from NMI.  The
tracers will need to trigger irq_work to call it.

> This scheme seems unsound

It may not be communicated well in this thread.  We had much discussion
at Cauldron the last few days.  The patch may be the best way to
communicate it at this point, though I'm sure I missed some details.

> pin yourself on CPU0 and trigger 1<<48 unwinds while keeping CPU1 idle.

Hm???

> > > That is, we should have an interface like:
> > > 
> > > typedef void (unwinder_callback_t)(struct user_space_stack *, u64 cookie);
> 
> Just make it a void* and let the consumer figure it out.

I think it makes sense to manage the cookie in the deferred unwinder
since the need to correlate the stack traces is an inherent part of the
deferral.

-- 
Josh
