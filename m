Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F4F21171D;
	Wed, 22 Jan 2025 13:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737553474; cv=none; b=EP+8XWIZ8THaxAf6nqM91GpdMC+Tc+7kt/6r5JF5qDrAJ7vyx1zoL7kYudpC7J3KDG+96FFdaYcbXNV22X1+B5g2nYZ5VQu+/iPHUklFGP0rY5Jt4ojFXU58QZwQNGJnxBop4X/KU7z+/3Ghvnux0pqoqNSFpSNR/ik6UV50mqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737553474; c=relaxed/simple;
	bh=YOEYpg8e6qOJYnPoCKrHsDrQVghreK/P1+amqc225kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIaVrHPgCJXx1byAXtr0SU6WnQcqAcHYjB+ONuyQwPun9h5OH6poR6jw0NSUiyXcEg3bNEEfkoocoELxZsG1cRjopgPwnvrc7wcsx2UcfUTNW39DP4KJkufJl2tn6JEh7s1PTmsJ8vhNG9SSPvpAaY7G/RQa4TApB56SiVa4H1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lGZ+YUHk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lGZ+YUHk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=app5zA+JZlXzyIAESu8G+Zswua+d9dY7hiJIGBIDQPE=; b=lGZ+YUHkXVxMKxGl87sJRkIzlA
	HzKd/n9IHkkdoJitPIIwV00N/wzVQWmnCWWonD12HppeuHkIP3ZGIaKMNsB55PO/qH/yHfkFA/xwy
	DItAGLgD14mUW3GtQ1zFB7FxEXaua7JRckOJUrUzvB3cKUliuNzosy7iaW/CtVvGqzUca38TvBv19
	PhygoLZWmzsW+00pHATgjkbWwVN6/jkMI+SVwzjuxZsk+CRzcGERNBeimtzqEXFWg4Ne2M/xJ/Jc9
	97Ab1tjUs7DSPtUC+HAXxsgau243P+53rpGs56Av22PNc70aIM2d0wqPdDy8lshUpIWyFTMVJbhGf
	xJQyoOcg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tab1p-0000000Da6U-1Kfo;
	Wed, 22 Jan 2025 13:44:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D96D6300599; Wed, 22 Jan 2025 14:44:20 +0100 (CET)
Date: Wed, 22 Jan 2025 14:44:20 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
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
Subject: Re: [PATCH v4 28/39] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250122134420.GR7145@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org>

On Tue, Jan 21, 2025 at 06:31:20PM -0800, Josh Poimboeuf wrote:

> +/* entry-from-user counter */
> +static DEFINE_PER_CPU(u64, unwind_ctx_ctr);

AFAICT from the below, this thing does *not* count entry-from-user. It
might count a subset, but I need to stare longer.

> +/*
> + * Read the task context cookie, first initializing it if this is the first
> + * call to get_cookie() since the most recent entry from user.
> + */
> +static u64 get_cookie(struct unwind_task_info *info)
> +{
> +	u64 ctx_ctr;
> +	u64 cookie;
> +	u64 cpu;
> +
> +	guard(irqsave)();
> +
> +	cookie = info->cookie;
> +	if (cookie)
> +		return cookie;
> +
> +
> +	cpu = raw_smp_processor_id();
> +	ctx_ctr = __this_cpu_inc_return(unwind_ctx_ctr);
> +	info->cookie = ctx_to_cookie(cpu, ctx_ctr);
> +
> +	return cookie;
> +
> +}
> +
> +static void unwind_deferred_task_work(struct callback_head *head)
> +{

> +	cookie = get_cookie(info);

> +}
> +

> +int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
> +{

> +	*cookie = get_cookie(info);

> +}


