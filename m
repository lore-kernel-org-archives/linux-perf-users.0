Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A007638DF9;
	Wed, 22 Jan 2025 22:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737586145; cv=none; b=EFAr1QS4/51j4ccB2dtwH+zLUVF85wAyLy41iRgtn57cAQkCricf1+BxMQsUISWodPkrvLpzjm1x3VW9nRVIr36/6OPI464UG8aH3yA4SqH93hgPEhux0+mXUSHWjCESOJdjmFzIgTI176Raprh1i5/QhAGkWlHKWJuBiMKmGmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737586145; c=relaxed/simple;
	bh=1S1o4osM6QOI/S9VJ0ymlVuy8dEds3gl7awO7zxY79o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jStJpSgcG5Flkoc6x/tMgwOwJsrBC+NiGHezn2XTdqQyiGAF3VQt4tHV6kTakuEhKgKhnkvP0scWdDlbqUS4R9v8huaHk3HH/fSvXoH1xZTGoMJXz/IyIyl3UlqnBmXG7UUnFkwR47ihrvZ+rkUrPZVolEEaccXKiNYSQsrVMN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdI/8Cby; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdI/8Cby"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F00C4CEE0;
	Wed, 22 Jan 2025 22:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737586145;
	bh=1S1o4osM6QOI/S9VJ0ymlVuy8dEds3gl7awO7zxY79o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZdI/8CbyD4LifQfxgUADviB7MG6yd7mTJkcznbayfNFrYsd2aY2MvWjfyKY3P2Mr+
	 Dt2hAguk2Gc3ntNnnuoV++0eRpTAg5+GVgq8Rt1G7jlc+wXcxJpetquD3ZJ6ZzllJR
	 P43N3x63N8c1MXjhouXF6ImQy3eWC/Ooov61CypBc/16dM/TIB+s2B6o4g5jKAojth
	 Nk3Xyqsz2AtiWgCuqYW1YltxCDFeDswlEeFSe3YKSh1HxO8RFgiqLD4YA/CKYMKQaK
	 wZN/J+nMaUeWdscJefoqurRlfB3V6mCWcFds6Ww8gmnx4VHQYaWUV/s9MI3E/ciRCS
	 +Mwd8Jnk0lDMA==
Date: Wed, 22 Jan 2025 14:49:02 -0800
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
Subject: Re: [PATCH v4 30/39] unwind_user/deferred: Make unwind deferral
 requests NMI-safe
Message-ID: <20250122224902.hhpmhi7r3azz3a4x@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <4ea47a9238cb726614f36a0aad2a545816442e57.1737511963.git.jpoimboe@kernel.org>
 <20250122141505.GT7145@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250122141505.GT7145@noisy.programming.kicks-ass.net>

On Wed, Jan 22, 2025 at 03:15:05PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 21, 2025 at 06:31:22PM -0800, Josh Poimboeuf wrote:
> Oh gawd. Can we please do something simple like:
> 
> 	guard(irqsave)();
> 	cpu = raw_smp_processor_id();
> 	ctr = __this_cpu_read(unwind_ctx_cnt);

Don't you need a compiler barrier here?  __this_cpu_read() doesn't have
one.

> 	cookie = READ_ONCE(current->unwind_info.cookie);
> 	do {
> 		if (cookie)
> 			return cookie;
> 		cookie = ctx_to_cookie(cpu, ctr+1);
> 	} while (!try_cmpxchg64(&current->unwind_info.cookie, &cookie, cookie));
> 	__this_cpu_write(unwind_ctx_ctr, ctr+1);
> 	return cookie;

I was trying to avoid the overhead of the cmpxchg.

But also, the nmi_cookie is still needed for the case where the NMI
arrives before info->cookie gets cleared by early entry-from-user.

-- 
Josh
