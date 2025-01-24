Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D029155726;
	Fri, 24 Jan 2025 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737748924; cv=none; b=oZizTBSWne4gEs9XDZUmSHis62Mq6iiSWdgEpZi4059RkpKWh1t7XZE/Rs9N9EaoMjzMWHbJZQ9oeV4hV4OmTE6xU0CW85nNiTHtoHvzblZZqiu6weNtRoZdhJZrpqsbF7qXKD/rpc79GpI8mSSmPLU/32thH1gVnWosvNveHbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737748924; c=relaxed/simple;
	bh=fJ0VWZuJjz9pqzrMQFPBs/IgV6DxWBasM8K9Uj+VJlY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gaBvnK6SWDELZz3ARYNNLhan81gxq45nVWA5jBaEUTt0bc0D63a0MoChb8RBIsylkT2LRk0gkr5L/93NVbxwQVlBmM5Nqn2E6DyFSvGTNlekq+HBLK4P7Zp6cintK6w5onFUkCzWF8hX6/BRJzmSZFfjLrosd1UJSkwzyF27Bxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64902C4CEDF;
	Fri, 24 Jan 2025 20:02:01 +0000 (UTC)
Date: Fri, 24 Jan 2025 15:02:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
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
Subject: Re: [PATCH v4 11/39] unwind_user: Add user space unwinding API
Message-ID: <20250124150211.4e252fc8@gandalf.local.home>
In-Reply-To: <cd54347d26967427bc831f473d76e424ba3eba95.1737511963.git.jpoimboe@kernel.org>
References: <cover.1737511963.git.jpoimboe@kernel.org>
	<cd54347d26967427bc831f473d76e424ba3eba95.1737511963.git.jpoimboe@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jan 2025 18:31:03 -0800
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> +int unwind_user_next(struct unwind_user_state *state)
> +{
> +	struct unwind_user_frame _frame;
> +	struct unwind_user_frame *frame = &_frame;
> +	unsigned long cfa = 0, fp, ra = 0;
> +
> +	/* no implementation yet */
> +	-EINVAL;
> +}
> +
> +int unwind_user_start(struct unwind_user_state *state)
> +{
> +	struct pt_regs *regs = task_pt_regs(current);
> +
> +	memset(state, 0, sizeof(*state));
> +
> +	if (!current->mm || !user_mode(regs)) {
> +		state->done = true;
> +		return -EINVAL;
> +	}
> +
> +	state->type = UNWIND_USER_TYPE_NONE;
> +
> +	state->ip = instruction_pointer(regs);
> +	state->sp = user_stack_pointer(regs);
> +	state->fp = frame_pointer(regs);
> +
> +	return 0;
> +}
> +

I know this is just an introductory of the interface, but this should
really have kerneldoc attached to it, as I have no idea what these are
supposed to be doing. This patch is meaningless without it. The change log
is useless too.

-- Steve


> +int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries)
> +{
> +	struct unwind_user_state state;
> +
> +	trace->nr = 0;
> +
> +	if (!max_entries)
> +		return -EINVAL;
> +
> +	if (!current->mm)
> +		return 0;
> +
> +	for_each_user_frame(&state) {
> +		trace->entries[trace->nr++] = state.ip;
> +		if (trace->nr >= max_entries)
> +			break;
> +	}
> +
> +	return 0;
> +}
