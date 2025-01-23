Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C58120C03E;
	Thu, 23 Jan 2025 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737621745; cv=none; b=rpiW7BJj4+EpWUTup9g5vjp8vJln1EgCqPDR0Db0J3ry8MI8AKdhjby7ykWKXLVPElraN3WZxYotsoYgZjzeEOfM7VhrjVUnNYHqCnWS4rtZBCZV+MTHFQbbNvRATNAhPJxwd7qblC61RqbAOb2huq82G5mG5rp/IV0GbOGkczI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737621745; c=relaxed/simple;
	bh=UgVEL9zOtIXOvh+aY/oTJsTU7kdEnvO4cEEfiToTlQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwP5BjAOkuqtDzRxS3SO4EugZeiC3rhEwd5IEjVLdb9DzYrxYmOut1JrRzZFBrGp16sFLI6z0d0cp4Uk1nY0bK+wmWMU4o9sUt3Nx0+D78uBC4E8e9CBAEnt97b08wW94nCMPcujRR/xJQIUCDEDM7TstdeV3ha1EgEBcMZGZlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X8h65mc+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X8h65mc+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Jp4XBypSE1UqdJymdBaqzwusQSsUzZHT+Lrnm9PJBAo=; b=X8h65mc+jjuS6q41ZEg7Gg6QYR
	Y4f3/bmC3osesat2FIAQYNVExGbprpyzsfoCGFheB0rJkA1BdrD6CeJBeIdyHoeC7Qo9MXbd9EJAr
	9qSwriZzlAEZdoOCkJHK3b30cHmBB30POfSkO1sIFsQeo6Dw6B2uOvj0ixLsgrd0TAUcg5Co+w8rY
	SsNaYlIf3IqXij+qpgaXwQ2oCmSMziNiKkwDukW4J9FxbRlPq4MoZHWizB/iol9wboRtDW2pXPq17
	JtlZX7VQ3wKj1St7ddBTmZ8PxYUiqkQLGSJei3cbjwPOl8XNCF9JTaCVlwVGLLpn7qA8dsh4Kfois
	3ZuHx60Q==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tasmz-0000000Dl4N-3vqu;
	Thu, 23 Jan 2025 08:42:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 82AD53006E6; Thu, 23 Jan 2025 09:42:13 +0100 (CET)
Date: Thu, 23 Jan 2025 09:42:13 +0100
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
Message-ID: <20250123084213.GG3808@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <4ea47a9238cb726614f36a0aad2a545816442e57.1737511963.git.jpoimboe@kernel.org>
 <20250122142418.GV7145@noisy.programming.kicks-ass.net>
 <20250122225257.h64ftfnorofe7cb4@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122225257.h64ftfnorofe7cb4@jpoimboe>

On Wed, Jan 22, 2025 at 02:52:57PM -0800, Josh Poimboeuf wrote:
> On Wed, Jan 22, 2025 at 03:24:18PM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 21, 2025 at 06:31:22PM -0800, Josh Poimboeuf wrote:
> > > +static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *cookie)
> > > +{
> > > +	struct unwind_task_info *info = &current->unwind_info;
> > > +	bool inited_cookie = false;
> > > +	int ret;
> > > +
> > > +	*cookie = info->cookie;
> > > +	if (!*cookie) {
> > > +		/*
> > > +		 * This is the first unwind request since the most recent entry
> > > +		 * from user.  Initialize the task cookie.
> > > +		 *
> > > +		 * Don't write to info->cookie directly, otherwise it may get
> > > +		 * cleared if the NMI occurred in the kernel during early entry
> > > +		 * or late exit before the task work gets to run.  Instead, use
> > > +		 * info->nmi_cookie which gets synced later by get_cookie().
> > > +		 */
> > > +		if (!info->nmi_cookie) {
> > > +			u64 cpu = raw_smp_processor_id();
> > > +			u64 ctx_ctr;
> > > +
> > > +			ctx_ctr = __this_cpu_inc_return(unwind_ctx_ctr);
> > 
> > __this_cpu_inc_return() is *NOT* NMI safe IIRC.
> 
> Hm, I guess I was only looking at x86.

:-), right so x86 is rather special here, the various RISC platforms are
what you should be looking at, eg. arm64.

