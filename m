Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C58B1C4604;
	Wed, 22 Jan 2025 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555874; cv=none; b=r5/ewjCiyc4e46cgXUd3hwTmAhanWK60TWMSoxT3LDLpJBfhTDzr36rnZ/g9rb5Z4O6f0zV+2H/6skb9VgueURcCDqC2iJ2dSCkFZmATPGV8lorneLs06ikXMymZa6oJfcB0mZmTqWrH+LqqeB2h0WNuc6qGgUaFNm27UwgC6aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555874; c=relaxed/simple;
	bh=Q8E557foIqNlImiyxKchbjMZjtpDKfXELCuqkdlrqU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjGM5D3wCKP3qV9lGMtnr/i3MbRJ73TOSHA75BNFqnGkg5ZWKO9q7O9iEGeveJaeKIBiMVXqMHdQLEt8jYNZ2VCqF6pJhJqiIeoFwqpBWK0rzidaSAEQzI0dX9BGbOP6ki2+orITQrt5zC9xDE11Neu0BPOP/+1aY1LMSPzvznA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r68Vnm55; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r68Vnm55"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8g+1Y/xyu+IaefVGiwnyDa6MiB+BKYxq4TuRPZHGagE=; b=r68Vnm551ztpQ47rnwgLCm66NV
	z1AVDV+FRVwVsQh0WNaEW4VE/ANRTiswNIu2VF+cwSL5P2/MLiRAUay+sdh367gLSYwghi7af937A
	FE2PLQaOxlz1Miy7yE1zQcFw6nXJ0E3+bkLm6IQrWZY5JeDg7+GHRYktesahBtT2mnN0x6BQlLL7v
	ZYr1GEJPBFZ+2+o4JAzRur6dGRt5iOOJ9YbT41GKjkhTlY6L5kbefNi3b65+vGw5EZGFX0NJCxoFG
	+syQ8+qhzVxRE3d0XxM8Jh0T8zmhcbgVaUl5U9mF1BTHMgxw7LzJcc4fYk6S5Yb9x/+q98EB0aoAW
	qJwMBNvw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tabeU-00000001HTZ-3Fca;
	Wed, 22 Jan 2025 14:24:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 43F21300599; Wed, 22 Jan 2025 15:24:18 +0100 (CET)
Date: Wed, 22 Jan 2025 15:24:18 +0100
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
Subject: Re: [PATCH v4 30/39] unwind_user/deferred: Make unwind deferral
 requests NMI-safe
Message-ID: <20250122142418.GV7145@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <4ea47a9238cb726614f36a0aad2a545816442e57.1737511963.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ea47a9238cb726614f36a0aad2a545816442e57.1737511963.git.jpoimboe@kernel.org>

On Tue, Jan 21, 2025 at 06:31:22PM -0800, Josh Poimboeuf wrote:
> +static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *cookie)
> +{
> +	struct unwind_task_info *info = &current->unwind_info;
> +	bool inited_cookie = false;
> +	int ret;
> +
> +	*cookie = info->cookie;
> +	if (!*cookie) {
> +		/*
> +		 * This is the first unwind request since the most recent entry
> +		 * from user.  Initialize the task cookie.
> +		 *
> +		 * Don't write to info->cookie directly, otherwise it may get
> +		 * cleared if the NMI occurred in the kernel during early entry
> +		 * or late exit before the task work gets to run.  Instead, use
> +		 * info->nmi_cookie which gets synced later by get_cookie().
> +		 */
> +		if (!info->nmi_cookie) {
> +			u64 cpu = raw_smp_processor_id();
> +			u64 ctx_ctr;
> +
> +			ctx_ctr = __this_cpu_inc_return(unwind_ctx_ctr);

__this_cpu_inc_return() is *NOT* NMI safe IIRC.
