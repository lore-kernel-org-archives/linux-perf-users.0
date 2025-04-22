Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD3C292924;
	Tue, 22 Apr 2025 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745338434; cv=none; b=TWNuTw489ZD5EvicasX1b8XFHC2dnLWjjNg4DsIiLlhW8VTjt/+v2nEgPv/erILMjogq0r2XHOyLeflV40l2y+husIYTBwDMc465R6U8GmG7A64klhgAeSI0hDMvNt3U1RPLJK25/iHMxN88/sjLtpnO9wMnoLjaAiVIVyqXZao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745338434; c=relaxed/simple;
	bh=AIN5LR5ySFlPIB2LCfmVPklXxCUUSkvC09FOa+xwn5I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDiwl5vIQt2MY5KtZpaL/QOAHe77RkdHMW+peJYZm7EzYvEWBRcO1z9UNq98OrU63LZbDSVpV1+Q8wbJBn0bUGEMnjtEMmea1bRHFTT/vp2HhKSqB+2eLySY+BFrjUAmbboPdnwbM6mT1P9r4XLO4kSjdWET2zGaEWOlHz6A/5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0B9C4CEED;
	Tue, 22 Apr 2025 16:13:50 +0000 (UTC)
Date: Tue, 22 Apr 2025 12:15:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org, Ingo Molnar
 <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Mark
 Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, Jordan Rome
 <jordalgo@meta.com>, Sam James <sam@gentoo.org>,
 linux-trace-kernel@vger.kernel.org, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Jens Remus <jremus@linux.ibm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Florian Weimer
 <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 02/39] task_work: Fix TWA_NMI_CURRENT race with
 __schedule()
Message-ID: <20250422121541.1cdacb22@gandalf.local.home>
In-Reply-To: <20250122124228.GO7145@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
	<ad5fb696fbcd276c0902dbb94baa75fb79a6e1e2.1737511963.git.jpoimboe@kernel.org>
	<20250122124228.GO7145@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jan 2025 13:42:28 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> If we hit before schedule(), all just works as expected, if we hit after
> schedule(), the task will already have the TIF flag set, and we'll hit
> the return to user path once it gets scheduled again.
> 
> ---
> diff --git a/kernel/task_work.c b/kernel/task_work.c
> index c969f1f26be5..155549c017b2 100644
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -9,7 +9,12 @@ static struct callback_head work_exited; /* all we need is ->next == NULL */
>  #ifdef CONFIG_IRQ_WORK
>  static void task_work_set_notify_irq(struct irq_work *entry)
>  {
> -	test_and_set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
> +	/*
> +	 * no-op IPI
> +	 *
> +	 * TWA_NMI_CURRENT will already have set the TIF flag, all
> +	 * this interrupt does it tickle the return-to-user path.
> +	 */
>  }
>  static DEFINE_PER_CPU(struct irq_work, irq_work_NMI_resume) =
>  	IRQ_WORK_INIT_HARD(task_work_set_notify_irq);
> @@ -98,6 +103,7 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
>  		break;
>  #ifdef CONFIG_IRQ_WORK
>  	case TWA_NMI_CURRENT:
> +		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
>  		irq_work_queue(this_cpu_ptr(&irq_work_NMI_resume));
>  		break;
>  #endif

Does this patch replace patches 1 and 2?

If so, Peter, can you give me a Signed-off-by?

-- Steve
