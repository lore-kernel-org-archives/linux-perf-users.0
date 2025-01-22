Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA8B84A3E;
	Wed, 22 Jan 2025 22:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737585388; cv=none; b=KefIBTpVNDkpLX1XHEf2yFJLZA2D296k/fIZq8OBCSbpOfqRycxj5vasZa4yPYz1cDdZ/nbZ7Wheke8eVweSc4SxU3ThfNo3TK9H+Y7nGvSwf1T9hAE7cM0yiVDDFG8WSGPbAcjf0SFXkpUvNIx8EHkZ7JtEB8qqUsr/GSV9+TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737585388; c=relaxed/simple;
	bh=SKWVTQcjbHQEPjTboETudRnVEe7+06NBAZO2pcK12is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSDoz8nfHQpm9kkiOoyx4uJU58jVVfi+VqwjWLLHawsmgphYtgXgy+hMq9RgN/0zgtcwoL9Ji+a1YEKKDp3VWz48Da/pWIDUvG/nGdFWMgnbac3wUDsEqTXeXwrZT9TJQXrj3q7V+8SI9cFO6nmaizvpF639W3AHag61PwdUsPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/pZDU/y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/pZDU/y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A9AC4CED2;
	Wed, 22 Jan 2025 22:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737585387;
	bh=SKWVTQcjbHQEPjTboETudRnVEe7+06NBAZO2pcK12is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R/pZDU/y6Qx6wp0rC70qfsP5XBDxsmYGtn7YoH/F0qO5rd25ml9x9By6zars412ls
	 Wsc2ql3AgmvArvJG0RsGu7ls8KXcrl3uc+ixvsLrpZy9Trw4wq2OtnzV2kHONyVHFS
	 OrMBSmftQU2jsScnmFhvGnAJJ3USQFxwhbkwILvwXK+hD5amOq1KfVdXTQC+9yhpqD
	 FfCJfZyH3UNW1+6C/DDnFlmR6ES9uF/mWVKxzBuE9Q8lt1Ksxk176WNuP2X0zxxVX7
	 KCiN3Cnib963mDEt9/XJn16om0DGudeQpFX66TA1EVLM45U7Hc3iCveFh1YBdyb3VH
	 2KejvMsqPUoiQ==
Date: Wed, 22 Jan 2025 14:36:25 -0800
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
Subject: Re: [PATCH v4 29/39] unwind_user/deferred: Add unwind cache
Message-ID: <20250122223625.aibbrh43pjkzve6c@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <51855c0902486060cd6e1ccc6b22fd092a2e676d.1737511963.git.jpoimboe@kernel.org>
 <20250122135700.GS7145@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250122135700.GS7145@noisy.programming.kicks-ass.net>

On Wed, Jan 22, 2025 at 02:57:00PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 21, 2025 at 06:31:21PM -0800, Josh Poimboeuf wrote:
> > Cache the results of the unwind to ensure the unwind is only performed
> > once, even when called by multiple tracers.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> >  include/linux/unwind_deferred_types.h |  8 +++++++-
> >  kernel/unwind/deferred.c              | 26 ++++++++++++++++++++------
> >  2 files changed, 27 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
> > index 9749824aea09..6f71a06329fb 100644
> > --- a/include/linux/unwind_deferred_types.h
> > +++ b/include/linux/unwind_deferred_types.h
> > @@ -2,8 +2,14 @@
> >  #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
> >  #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
> >  
> > -struct unwind_task_info {
> > +struct unwind_cache {
> >  	unsigned long		*entries;
> > +	unsigned int		nr_entries;
> > +	u64			cookie;
> > +};
> 
> If you make the return to user path clear nr_entries you don't need a
> second cookie field I think.

But if the NMI happens late in the exit-to-user path, with IRQs
disabled, right before nr_entries gets cleared, the cache won't get
used in the task work.

However I think we can clear it on entry-from-user.

-- 
Josh
