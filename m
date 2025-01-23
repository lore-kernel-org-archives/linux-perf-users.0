Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A8520C016;
	Thu, 23 Jan 2025 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737621640; cv=none; b=QMctARVs/nrcHzxSr5hWKGxoS/TdBC/mN8ZGtwK2cdMH1/eqxkehdOYYolz1jQqMPpvGKyNuSXLY7eN9sCmnlBHu7usorlH3dcczn3THJbMO3kKlRjW+APK7x7EuzhLxK/LHlcCUrO0Ny1TJHmLUu7Oa7k4WkkncSH6/HJaLrf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737621640; c=relaxed/simple;
	bh=4yZw1/VhB7OmXrBnvyGYtpyG/yT6UJDKwZdOJ6iGPKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X69Zdaks4jTtz6M0Nxi9N+wuHksFD8lO1hOaJXhrd9hqyZiC/9UEczgaXHWCeUfXLbCiQQAL22ZpoK5PHRsYNgvmKxvlE2ZgPHzHIvMsJ4tMlE82QB5CfEO75wEAPtdaaARJsLz/UxWf491p3qYjEwSRmkwlZvcP20WsujXAsqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jpXZNP7j; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jpXZNP7j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Pqt+fUTStPC9oCNZMvxh/lkt7vFV6m8xwr8cKmVb3/c=; b=jpXZNP7joGIaPjxyvc5W40tJk8
	rrRMmElT424E7bGJ/wRhH7dCiJovT2uNai57FTMRfvPg1esQZ2vo+265Q7lsAIEoYPn0Lt5R9Tdle
	l0F/xQBtEhA33ppDwHJbYJiv1ug0JUyslxCJldI1pOSMwmvIR5WHVIlpTp8xvBPNqLn1jR1v+Nxs4
	Ba/KtPFAbafZhga4QLp1RBA8yo0Vk3MZsNxyGmObESs3gRSe7UB/J51RXQ5zgyykljh1ETwTCLsPm
	OflWWDiaPosPorMd02O2ZhHjmbslMqv9tZ5KjbdBVnBoe/8W6vTVJXmjWdaZ5eivRo+3J859vu5Lq
	5OrUnAYw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1taslG-00000008ju1-3UqN;
	Thu, 23 Jan 2025 08:40:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 445D5300717; Thu, 23 Jan 2025 09:40:26 +0100 (CET)
Date: Thu, 23 Jan 2025 09:40:26 +0100
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
Message-ID: <20250123084026.GF3808@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <4ea47a9238cb726614f36a0aad2a545816442e57.1737511963.git.jpoimboe@kernel.org>
 <20250122141505.GT7145@noisy.programming.kicks-ass.net>
 <20250122224902.hhpmhi7r3azz3a4x@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122224902.hhpmhi7r3azz3a4x@jpoimboe>

On Wed, Jan 22, 2025 at 02:49:02PM -0800, Josh Poimboeuf wrote:
> On Wed, Jan 22, 2025 at 03:15:05PM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 21, 2025 at 06:31:22PM -0800, Josh Poimboeuf wrote:
> > Oh gawd. Can we please do something simple like:
> > 
> > 	guard(irqsave)();
> > 	cpu = raw_smp_processor_id();
> > 	ctr = __this_cpu_read(unwind_ctx_cnt);
> 
> Don't you need a compiler barrier here?  __this_cpu_read() doesn't have
> one.

What for?

> > 	cookie = READ_ONCE(current->unwind_info.cookie);
> > 	do {
> > 		if (cookie)
> > 			return cookie;
> > 		cookie = ctx_to_cookie(cpu, ctr+1);
> > 	} while (!try_cmpxchg64(&current->unwind_info.cookie, &cookie, cookie));
> > 	__this_cpu_write(unwind_ctx_ctr, ctr+1);
> > 	return cookie;
> 
> I was trying to avoid the overhead of the cmpxchg.

We're going to be doing userspace stack unwinding, I don't think
overhead is a real concern.

> But also, the nmi_cookie is still needed for the case where the NMI
> arrives before info->cookie gets cleared by early entry-from-user.

So how about we clear cookie (and set nr_entries to -1) at
return-to-user, after we've done the work loop and have interrupts
disabled until we hit userspace.

Any NMI that hits there will have to cause another entry anyway.
