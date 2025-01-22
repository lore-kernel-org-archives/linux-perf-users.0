Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B253B1AF4EA;
	Wed, 22 Jan 2025 23:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737587322; cv=none; b=funOaKsheUtdA1BSlxpqE6soOIqE40b4b+MKHTrss+rM+jkKsOMfe0hfhA5j2NSRke1wPYvrgCHewKCz2sgjBHCRAwIoJFqwEjJkGLYDMnxjz35ENA+qCMT+OvyMv5oFdSrexo4Nr67HPUi4RO81cV65x3HBXXqzaCPQmwiyyx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737587322; c=relaxed/simple;
	bh=928PHrzmRk2SOln4QABz37ALCXcCLBO437kQdMyFoqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwT3xgpCR+8Fb9NvlWZz87qG5VzSFLOTFBRAQw6+b9RrU8VpVoYw33XaSmk4nG8stdY9z/6TJGl9n9rNSMttTjb1Dblb7o7CS48Sj1nO7oFVqyHDhvWiiNyVTKvBgxyB6oUrho3aGsxZMKlsxRak2QxbDws+SkhIetpRFu517vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+D/hA32; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+D/hA32"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C438C4CED2;
	Wed, 22 Jan 2025 23:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737587321;
	bh=928PHrzmRk2SOln4QABz37ALCXcCLBO437kQdMyFoqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+D/hA32VP97Icd0t1mrEXcFpRWMxpdgOjiChtFS3b/0t68cmzJYi9ktSeFUq/VWW
	 zyVb4WdqoeAAXFdaAXBHMHf1xBWCE4bn99syXC7olX6WeKxR5PqreOsMHLugbB/8rR
	 up4TgzLcGrWvHVrp33k8iefWEBDrIoaTrQf10uwZUBtj38ApPcuaOql1nmL/3kigLf
	 oDankMik9N7T8bKet7o9+lQiXr+vsZQ7WI8ZRQcU+nRKojWKJK/gJReotdynQ9OcU/
	 b33BCuGX7+vu0AxmgI4Gbbh+dhBrC0VL1trBEC8FVWa8zoV0MJ/E6eOG5vPetjCcTS
	 NNLAY0ZnjNWBw==
Date: Wed, 22 Jan 2025 15:08:38 -0800
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
Subject: Re: [PATCH v4 34/39] perf: Skip user unwind if !current->mm
Message-ID: <20250122230838.lrmuxhowq6ezvoqp@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <24cde1381495cd637f0d5663ab7629572bc0eca6.1737511963.git.jpoimboe@kernel.org>
 <20250122142910.GW7145@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250122142910.GW7145@noisy.programming.kicks-ass.net>

On Wed, Jan 22, 2025 at 03:29:10PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 21, 2025 at 06:31:26PM -0800, Josh Poimboeuf wrote:
> > If the task doesn't have any memory, there's no stack to unwind.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> >  kernel/events/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 99f0f28feeb5..a886bb83f4d0 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -7792,7 +7792,7 @@ struct perf_callchain_entry *
> >  perf_callchain(struct perf_event *event, struct pt_regs *regs)
> >  {
> >  	bool kernel = !event->attr.exclude_callchain_kernel;
> > -	bool user   = !event->attr.exclude_callchain_user;
> > +	bool user   = !event->attr.exclude_callchain_user && current->mm;
> 
> What about things like io_uring helpers, don't they keep ->mm but are
> never in userspace?

Hm, that's news to me.  At least this patch doesn't make things worse in
that regard.

IIRC, user_regs(task_pt_regs(current)) returns false for kthreads
because the regs area is cleared.  We could add in a user_regs() check?

-- 
Josh
