Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094331BD9E2;
	Wed, 30 Oct 2024 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321297; cv=none; b=YAD7OgeI+ovgNIFI6ZOLH+zQPzBDzWPivb01t6Pn3fbUEM2StBwMIWjsWO3f7aD7WdAYe4ebXQO7e9jEQBD5ppnmsrlVAF2i9KaaRQRj6BCUi+8UQ/EV2dli9nJlt7iNMiadcx+oVPoijd66sQfdwihTJtjIVmmCz7+Wi+ciKhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321297; c=relaxed/simple;
	bh=HfeJop/UUlRuFQw/Hekxxiu9zAJhZVfSfpiAkceHfr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0r1KUqTBY8+lX/dIwjQYwzfKa4XKF+81NLTxGMoqaZgdR/soMamDmelfiylC53A3LZUoPuYjBaVsGLmQh7REytu3O99cRDc0PPQ461ZtS4vmBkuYAKIg52YDWl+Q2u2qbphmL3dMSMXmtmQmSZA08QWZ74/S8JZ+N3fBhsb8/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQ/HI2yk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQ/HI2yk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3E6C4CECE;
	Wed, 30 Oct 2024 20:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730321296;
	bh=HfeJop/UUlRuFQw/Hekxxiu9zAJhZVfSfpiAkceHfr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oQ/HI2yktVXVjMoXAvEks8mgpc2Kf6rtF1Vr0lGYkCOiEcA/i+raJxPigg6iQvQi7
	 DQ1WubJ01OkOxCxe5V7+e4Gk12Ff3/8HYvSxSRb7NCvc6NI08mDirCx5FGplTaO3Tc
	 gWp28BXPlvjFcz956IZ/dzZCH2GhGJOHBAFrmu2trwHs5Cucn1wASciMj4+KSuOfWM
	 F7bPuuUVXrSyGD3wlOOIpH/JvC/AGFXAaxFxGf1mJfSFhbu8/L2OGQNWWeUZAiHUb0
	 QyHGNaQ0z9yLkJ62FUGgMJ8Wq2rMtYZjZ5VDz5eU45qqw1y7TLvdY1rmHVFNOA5B5d
	 2f3MgXIl9bPPw==
Date: Wed, 30 Oct 2024 13:48:13 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
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
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 11/19] unwind: Add deferred user space unwinding API
Message-ID: <20241030204813.q5dvtyyhpqgg5pee@treble.attlocal.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>
 <20241029135617.GB14555@noisy.programming.kicks-ass.net>
 <20241029171752.4y67p3ob24riogpi@treble.attlocal.net>
 <bcd11a07-45fb-442b-a25b-5cadc6aac0e6@efficios.com>
 <20241029182032.GI14555@noisy.programming.kicks-ass.net>
 <20241030021722.2d1fe6d3@rorschach.local.home>
 <20241030140324.GM14555@noisy.programming.kicks-ass.net>
 <20241030155816.094edca5@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241030155816.094edca5@rorschach.local.home>

On Wed, Oct 30, 2024 at 03:58:16PM -0400, Steven Rostedt wrote:
> On Wed, 30 Oct 2024 15:03:24 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > You're designing things inside out again. You should add functionality
> > by adding layers.
> > 
> > Pass a void * into the 'request-unwind' and have the 'do-unwind'
> > callback get that same pointer. Then anybody that needs identifiers to
> > figure out where things came from can stuff something in there.
> 
> What the hell should I do with a void pointer? I want a stack trace, I
> ask for one, it gives me an identifier for it, then at the end when it
> does my callback it gives me the stack trace I asked for with the
> identifier that it belongs to.
>
> The identifier should be part of the unwinder code as it has to do
> with the stack trace and has nothing to do with tracing.

If at least most of the users would find the cookie useful -- which it
sounds like they would, maybe even including perf -- then it makes sense
to integrate that into the unwinder.  It also helps the unwinder
disambiguate which callbacks have been called and whether the stack has
already been unwound.

That said, I'm also implementing the void pointer thing, as AFAICT perf
needs to pass the perf_event pointer to the callback.  There's no reason
we can't have both.

-- 
Josh
