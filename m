Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98CD1C3BE6;
	Wed, 22 Jan 2025 21:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737579822; cv=none; b=ikOrSIG0OTj5klruF7QWx/niTFUakqwjNBv2tsKZjTX+a9nRSZE+o6fZm9EmvfPAKG+cCO3cLFbbiSpxb/QoZvvCGqEdD0eUnLmLF8Q5wVyVD5SXnfiG4nzyUnWLaY1KLm6qkp4zN4s5PbOyBLJpuqG7tcVr77d6uwYoRuW7RYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737579822; c=relaxed/simple;
	bh=4/WOzLmxRHmIf3zcI7u2Vszl7y5naiQxuzhkQ6VdbGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlJKgYYM0IbxvZunXI1vC+Mu8ZIH5jT8MQ1JpHeoUK86y6aAj43DE2xtBBzJHEurFqeGczwBgJMWp3GfVx3iclL/UcyyqfHQ9eR5KM0upK2BU/dPiXJ0tP+celkEF+s1SlN5HuY+vajGuI1Rk1uJOy7n9HsT8GomsTIBP4dG2Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmAyOkjF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmAyOkjF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DB1C4CED2;
	Wed, 22 Jan 2025 21:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737579822;
	bh=4/WOzLmxRHmIf3zcI7u2Vszl7y5naiQxuzhkQ6VdbGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MmAyOkjFDr50Q6ttAyYozFPicaTt6l7pemlyo3DAB8nMfq+4maNGPFJpd9HiNjf61
	 NvJ4jyNif/+zg8hqiC/3qqQXYEstrxDYY3TmbftChcPwty0cdxxK3IHesj8kItX5tz
	 w4pzFvzpkay2uYW7vHSsE7SDdKCO/3HGuNOoFw6VaGMlCUhEkiZ6HLUCraF6VifQQx
	 tvSRQZzfKLnVf6UJPyk4aJXViRshn7Fpkb+Gqp/wR9jhJ8YxZv4x6S/vUVVl3Vk8gy
	 ydjBa8UgSsO075mNxHzYybboe4WlzkQwM80yRW7vXHKefIumu9FGhRFb+5o9giw1V1
	 mfrADLW5Qod6w==
Date: Wed, 22 Jan 2025 13:03:39 -0800
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
Subject: Re: [PATCH v4 02/39] task_work: Fix TWA_NMI_CURRENT race with
 __schedule()
Message-ID: <20250122210339.i6sehdw4ddzqyy5h@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <ad5fb696fbcd276c0902dbb94baa75fb79a6e1e2.1737511963.git.jpoimboe@kernel.org>
 <20250122124228.GO7145@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250122124228.GO7145@noisy.programming.kicks-ass.net>

On Wed, Jan 22, 2025 at 01:42:28PM +0100, Peter Zijlstra wrote:
> So I'm a little confused, isn't something like this sufficient?
> 
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

Yeah, that looks so much better...

The self-IPI is only needed when the NMI happened in user space, right?
Would it make sense to have an optimized version of that?

-- 
Josh
