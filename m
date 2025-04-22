Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0590629009C;
	Tue, 22 Apr 2025 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745342411; cv=none; b=OAkZjkuLSWcQCiWPG2fUjkuCOQRfcv1upmypS9hiMLDVAqNgHzq15wVANTYHX+hV7fnpZwtXfXHXEktr47GYysktNmkOq9IM2AIXbDqpc2ZjoLJi4Trd9Yf+VihPqTlBnTbp1EEKZoFmw3YLD+LolXB6rx5U/6aM7aPOBgZJgms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745342411; c=relaxed/simple;
	bh=5ZxvhdNClByR4vmINTi77Ypw8R9ZTSNHOrP8sUy9igA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRcQR91v8uvTJh9bTnX82dnnby/5O9nRLMyMjLeYSUxsCnBTpNuMyE6XjlnCPDHCuHr3/gXUNJB2nT7b+UO4vljksxzWOm33sn2HpwSF+Z0co7P31c/6KokYgY5mmJQLE1Hki8BJxyH7LaFzFrnvPRr7ju0yRQb8DINOLfQHEQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uj6dQq3Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uj6dQq3Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B6EC4CEE9;
	Tue, 22 Apr 2025 17:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745342410;
	bh=5ZxvhdNClByR4vmINTi77Ypw8R9ZTSNHOrP8sUy9igA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uj6dQq3QN/9zpJbJL7393kB5eNFByRRBfuQo+3iPvMKFQzCxSd6cdbxOWT7I7Qy+V
	 SeJPJvCy7nQpg4F/J7zlRO2xB1nVaqAU25vMZKOrAZDpzu6T3tRLdqW1pG0CRdMMh9
	 r/GMJkYiUAnCv5UZ3+lT0zjhs9rKoEFigS3fFHMg+RHDWvk+z5XoBnrblYOy71AIli
	 o/dTxduGIvHthRQEbQNtvDEj8WIlvYKHU+rGnTrlZvq/72kjrPudCIsB15NBZlxUHG
	 5Hos6nVspsV8kGFLz8WWW24EwdWiLnrgDdu/KLLk9XTk3VaVXeZHWtBjNPqjooLaOS
	 ovPlSPTWIq3WQ==
Date: Tue, 22 Apr 2025 10:20:07 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>, Sam James <sam@gentoo.org>, 
	linux-trace-kernel@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Jens Remus <jremus@linux.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 02/39] task_work: Fix TWA_NMI_CURRENT race with
 __schedule()
Message-ID: <37bx6zbikhhxehbch6yi7urc2g2uwxrl4lktexl35zubo5xm6z@xf5o3srbjx7v>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <ad5fb696fbcd276c0902dbb94baa75fb79a6e1e2.1737511963.git.jpoimboe@kernel.org>
 <20250122124228.GO7145@noisy.programming.kicks-ass.net>
 <20250422121541.1cdacb22@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250422121541.1cdacb22@gandalf.local.home>

On Tue, Apr 22, 2025 at 12:15:41PM -0400, Steven Rostedt wrote:
> On Wed, 22 Jan 2025 13:42:28 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > If we hit before schedule(), all just works as expected, if we hit after
> > schedule(), the task will already have the TIF flag set, and we'll hit
> > the return to user path once it gets scheduled again.
> > 
> > ---
> > diff --git a/kernel/task_work.c b/kernel/task_work.c
> > index c969f1f26be5..155549c017b2 100644
> > --- a/kernel/task_work.c
> > +++ b/kernel/task_work.c
> > @@ -9,7 +9,12 @@ static struct callback_head work_exited; /* all we need is ->next == NULL */
> >  #ifdef CONFIG_IRQ_WORK
> >  static void task_work_set_notify_irq(struct irq_work *entry)
> >  {
> > -	test_and_set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
> > +	/*
> > +	 * no-op IPI
> > +	 *
> > +	 * TWA_NMI_CURRENT will already have set the TIF flag, all
> > +	 * this interrupt does it tickle the return-to-user path.
> > +	 */
> >  }
> >  static DEFINE_PER_CPU(struct irq_work, irq_work_NMI_resume) =
> >  	IRQ_WORK_INIT_HARD(task_work_set_notify_irq);
> > @@ -98,6 +103,7 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
> >  		break;
> >  #ifdef CONFIG_IRQ_WORK
> >  	case TWA_NMI_CURRENT:
> > +		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
> >  		irq_work_queue(this_cpu_ptr(&irq_work_NMI_resume));
> >  		break;
> >  #endif
> 
> Does this patch replace patches 1 and 2?

Indeed it does.

> If so, Peter, can you give me a Signed-off-by?
> 
> -- Steve

-- 
Josh
