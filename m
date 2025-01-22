Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F9B42065;
	Wed, 22 Jan 2025 20:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737578844; cv=none; b=T/8lZ4qMjmIWVSCTy1/VQ7kkSco9Tzkt55mUi5XV2KP+/n9xbvjc3yFTUuw9LOR1PWgCLflvRb0+sb9s/Y0zRfv4lQDDIo7vnObhFIjV/Z+SgYUvcH+FbYMOs4orTwiUG/UiOld6MlljUvZFA9+PG8AaRnyrJWgGZTJMbVV+rXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737578844; c=relaxed/simple;
	bh=yVY1iDt0GllR5XrawxzVAkczV+CiWgvvcuZmJvTZ6SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehGxR/FCQo+e7PDoeO3zbNRIiIbyrH8Li+zZYeZqv2CK9/eGMMoTzyf64cSekp9vJyXwrGKE4iY1y3+LCuBMAbJOn5Zxqvb6Sdv8t5R4TJomw82kBG8+08SUQ36CuCOMLZfHPAI7buqi7ScY1Vc949sgONEa9Ug5OIQGWch3/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnSsQsz+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnSsQsz+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832A8C4CED2;
	Wed, 22 Jan 2025 20:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737578843;
	bh=yVY1iDt0GllR5XrawxzVAkczV+CiWgvvcuZmJvTZ6SM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mnSsQsz+ZC8WOyFCH6U0cZkFSSCb1HGQ5jZVYPBXn6E9YjVgfea72FOFKuYOaOcLg
	 9bV7h1uAYa510DyrSSs3nZjndGZfkaRNBPG0lQt4udWMb2mi+7TMVJv7XaD5Mnhzum
	 /uAxgO2+fcE0Iv4WyjhCch9GO84Q3Zsqxqij1HytoeY3NIwAoGhn/qc29OvSiLEJdE
	 9qBIr3Xo5JAm/0B2wKe0HxyS0ybjiTbv07S1ltekiyfTKY9+kedcgHcAsQOWMhVsxd
	 i2UmHnz91HHE2OgDjbet79Vul4+HonPncdaCrQM11/QSRKi3gZIBSvzMg3qDlcinpI
	 RV1kxc7EfVHIw==
Date: Wed, 22 Jan 2025 12:47:20 -0800
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
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 01/39] task_work: Fix TWA_NMI_CURRENT error handling
Message-ID: <20250122204720.t42a4em5endxox3y@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <b46cca62b5ebd131d0a744572e57f5ebc53d5ef4.1737511963.git.jpoimboe@kernel.org>
 <20250122122821.GN7145@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250122122821.GN7145@noisy.programming.kicks-ass.net>

On Wed, Jan 22, 2025 at 01:28:21PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 21, 2025 at 06:30:53PM -0800, Josh Poimboeuf wrote:
> > It's possible for irq_work_queue() to fail if the work has already been
> > claimed.  That can happen if a TWA_NMI_CURRENT task work is requested
> > before a previous TWA_NMI_CURRENT IRQ work on the same CPU has gotten a
> > chance to run.
> 
> I'm confused, if it fails then it's already pending, and we'll get the
> notification already. You can still add the work.

Yeah, I suppose that makes sense.  If the pending irq_work is already
going to set TIF_NOTIFY_RESUME anyway, there's no need to do that again.

> > The error has to be checked before the write to task->task_works.  Also
> > the try_cmpxchg() loop isn't needed in NMI context.  The TWA_NMI_CURRENT
> > case really is special, keep things simple by keeping its code all
> > together in one place.
> 
> NMIs can nest,

Just for my understanding: for nested NMIs, the entry code basically
queues up the next NMI, so the C handler (exc_nmi) can't nest.  Right?

> consider #DB (which is NMI like)

What exactly do you mean by "NMI like"?  Is it because a #DB might be
basically running in NMI context, if the NMI hit a breakpoint?

> doing task_work_add() and getting interrupted with NMI doing the same.

How exactly would that work?  At least with my patch the #DB wouldn't be
able to use TWA_NMI_CURRENT unless in_nmi() were true due to NMI hitting
a breakpoint.  In which case a nested NMI wouldn't actually nest, it
would get "queued" by the entry code.

But yeah, I do see how the reverse can be true: somebody sets a
breakpoint in task_work, right where it's fiddling with the list head.
NMI calls task_work_add(TWA_NMI_CURRENT), triggering the #DB, which also
calls task_work_add().

-- 
Josh
