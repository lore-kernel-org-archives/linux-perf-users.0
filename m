Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12861DC9BC;
	Fri, 24 Jan 2025 22:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737756327; cv=none; b=u8U013n5B8vEJbnKBDfzlNuQ/frwRpDeG78iezZKG5YfNKEka056MJvhK7LAcSuZh4aQkLeGlhcvaL2s4gVL7MJC39wErW0J6FTvp9Uw5VdBYFYToHnI+w30VevwKd5to9iJw0o+MfF1ujVEheVgQItwn6QYaaBQC4kn55Q1LAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737756327; c=relaxed/simple;
	bh=q932PiqM/4cgXHWRt0+mExtXMfYRyDAHqC/oYIBjqAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8sk3UI3vyoYgNFm9IGA7XyUdaUisKCB7eiKwv+6Qu920LvHHEDBx9QePHvRDjCvhU12YPK7uOdVzZ3zEDcjKH9kXPLfj3MxyUxWgs/VkhLANtq0iq97u7dBsQXn2ICwiKqpoN/jGNowidyQS0xnHRqyPocxKS+daTcDjAGjqnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPVS/Ne3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPVS/Ne3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C45BC4CED2;
	Fri, 24 Jan 2025 22:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737756327;
	bh=q932PiqM/4cgXHWRt0+mExtXMfYRyDAHqC/oYIBjqAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NPVS/Ne3jA8wPxM1VDcmuvN1cqphuyVNnayvbNmbbz6icNReIunWHpQkmFmcgLzwM
	 1uR/31snMQbQqYtIJ8mZI54Lnp67KLU/icRniud+UxghA6gHrnaY2pqnDyAGvnZC+S
	 YOHOT4756Xf0Nh/fEgS/dDNFrrvE7IvIOpIyM2n2HLX9KibAUIggn5v+NKDSEx4Oiv
	 0pfGaiGrYP20RkGYdUkQS9eAUU/mbVMACHXvCmzuWU8buH0J9Pzi8yKgKEu9nwK0lx
	 3mas+Pzy24OrbwFwzbQCLsYsJe/3DrzrRI2Sg3BQ9OGV74rKOQlXmdctMIR7vryKay
	 xnYwi86of+Upg==
Date: Fri, 24 Jan 2025 14:05:19 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH v4 11/39] unwind_user: Add user space unwinding API
Message-ID: <20250124220519.xglhqzmce4tb5hm5@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <cd54347d26967427bc831f473d76e424ba3eba95.1737511963.git.jpoimboe@kernel.org>
 <20250124150211.4e252fc8@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250124150211.4e252fc8@gandalf.local.home>

On Fri, Jan 24, 2025 at 03:02:11PM -0500, Steven Rostedt wrote:
> On Tue, 21 Jan 2025 18:31:03 -0800
> Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > +int unwind_user_start(struct unwind_user_state *state)
> > +{
> > +	struct pt_regs *regs = task_pt_regs(current);
> > +
> > +	memset(state, 0, sizeof(*state));
> > +
> > +	if (!current->mm || !user_mode(regs)) {
> > +		state->done = true;
> > +		return -EINVAL;
> > +	}
> > +
> > +	state->type = UNWIND_USER_TYPE_NONE;
> > +
> > +	state->ip = instruction_pointer(regs);
> > +	state->sp = user_stack_pointer(regs);
> > +	state->fp = frame_pointer(regs);
> > +
> > +	return 0;
> > +}
> > +
> 
> I know this is just an introductory of the interface, but this should
> really have kerneldoc attached to it, as I have no idea what these are
> supposed to be doing. This patch is meaningless without it. The change log
> is useless too.

Yeah, sure.

-- 
Josh
