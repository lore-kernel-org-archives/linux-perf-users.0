Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA8838DF9;
	Wed, 22 Jan 2025 22:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737586380; cv=none; b=Q7HL134NcQcmAyDlL1wtMNT4fcZ0yYd8xl+YuvOlYTNRU2dY+mHfh4CjuUMPPXmoF/Q145dpNXdgvqwiBeiQuRcb5EyJrqTVX1DIHrYsVj8buan3ohDOz66DrNSDCaS4FoqlpULe9P6CVXhtAJLSiUCpapa/OgCoUV4aFIA3CW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737586380; c=relaxed/simple;
	bh=MRR4/KapLTaD3pLe5Drq1bMLY6g2y72NfAnrzHSjpSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDjP3g1jaEKAEFIdS9OWSd2inRo0b6AtUwtYlidLr5LbUJja+JRWVHOZ+DS2957c2CB8Br8hlz8hBnoGKQdnCQ6pWkeKTlzzgfbKwL8NbTsdPqAANZ6xemidkZfA3YYR5Hkk6NGo+l/lcr+NxtKEZ+MRpnp5fkT13GFKvIH+ZnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToHaSGxU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToHaSGxU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C399C4CED2;
	Wed, 22 Jan 2025 22:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737586379;
	bh=MRR4/KapLTaD3pLe5Drq1bMLY6g2y72NfAnrzHSjpSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ToHaSGxUS8L8EUvQgBOEPdm10kM7UVjfqs/lIh756pPmcml/XV8LZHVrMGtViZOmN
	 ViHOL8DH7eHs/qXGtyROnxEPFdmu4KHKWCzGPldnj6H2pnbzftqPaeSnCDslQAAHH2
	 hwzqDBXrVvOs9guAeIL9r+W5BdkfUwQuCbYerBWK8HsW/YbeQP4x1v5FPwJuoTmZ52
	 8K8NmHLAEZ4hSDAeeaqjP7ZBlRF2kdI14Jte0il5jPL+Tz0mCUh4lU/DF0gmx66+Sh
	 sCBXrVtmjcba9dhP0/1Q8pUiKlHHBWzRRGtPtvoDfYZElcTtHltJGi16I3HcMJMJPw
	 moEEvjQK5fREA==
Date: Wed, 22 Jan 2025 14:52:57 -0800
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
Message-ID: <20250122225257.h64ftfnorofe7cb4@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <4ea47a9238cb726614f36a0aad2a545816442e57.1737511963.git.jpoimboe@kernel.org>
 <20250122142418.GV7145@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250122142418.GV7145@noisy.programming.kicks-ass.net>

On Wed, Jan 22, 2025 at 03:24:18PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 21, 2025 at 06:31:22PM -0800, Josh Poimboeuf wrote:
> > +static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *cookie)
> > +{
> > +	struct unwind_task_info *info = &current->unwind_info;
> > +	bool inited_cookie = false;
> > +	int ret;
> > +
> > +	*cookie = info->cookie;
> > +	if (!*cookie) {
> > +		/*
> > +		 * This is the first unwind request since the most recent entry
> > +		 * from user.  Initialize the task cookie.
> > +		 *
> > +		 * Don't write to info->cookie directly, otherwise it may get
> > +		 * cleared if the NMI occurred in the kernel during early entry
> > +		 * or late exit before the task work gets to run.  Instead, use
> > +		 * info->nmi_cookie which gets synced later by get_cookie().
> > +		 */
> > +		if (!info->nmi_cookie) {
> > +			u64 cpu = raw_smp_processor_id();
> > +			u64 ctx_ctr;
> > +
> > +			ctx_ctr = __this_cpu_inc_return(unwind_ctx_ctr);
> 
> __this_cpu_inc_return() is *NOT* NMI safe IIRC.

Hm, I guess I was only looking at x86.

-- 
Josh
