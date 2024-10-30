Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABDA3398E;
	Wed, 30 Oct 2024 06:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730268646; cv=none; b=FvneLLedpbTbPUv+kXEwe4BE9LqsdG6An7jfoT8j6tu/FoDoeW/MyQsw58R1voe0bAs7wy3G8RfFoMlk2L/zn6lPhRlN5V3ajUIaTBnYW3xfKF6wZqpnyos9re2oESJOUordcn+5X7idi7BYCOroOZxGUr/c9z3PR5RmPqk8SnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730268646; c=relaxed/simple;
	bh=rW9ZRiGneWdDtpEs5PUPnc55YvzSdqFH7ITM61lpf/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUIfn7i1YwZQM6upDp+Pt0N4XifDmk82LKYXD9/vpp67ZQGI3YVhy4qsS2yfGxeXAZevZJF/b9tDA9jGCI7q6Nd+A6wOcUoiZtQN6osxwAvHSHaXBOi+B1g9PXmhZp/2q2cGcID21EbXqiW8WzpPNXdaUMk5MY2hDNFVfGYh/tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OesXNJH5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OesXNJH5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B96C4CEE4;
	Wed, 30 Oct 2024 06:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730268646;
	bh=rW9ZRiGneWdDtpEs5PUPnc55YvzSdqFH7ITM61lpf/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OesXNJH5LkNQCmaK2oMf8w9RUWI7XKDemQkC2bQK6xNIf3UI4vWOy5zma2AI96MEX
	 xAHRjC0ckMcMWtaYCDPCIjanReF99ZDWPIhbQE58M+rwPsqlUjZMU8r9YkdmaUTcil
	 PiKRRg82GrjlVVBJ8ZvxI/lnf2ySptnZFxlnvoxsKVBTi4lZjV5VuHenlRZdjy5E9r
	 Re/8cmrPEibAujUQNhu5TE4qE/DSVe2uyK/yTIF81qciIE6P5gEOHMwQtmz20LB0PG
	 2qZDjZcav3+D8Q4zcusZA5dhJP6PNIg5y9uJBipMrjxQ7u92JWlKDIof0ZRNtmGvrl
	 WDdYp8eUTt2Kg==
Date: Tue, 29 Oct 2024 23:10:43 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
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
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 11/19] unwind: Add deferred user space unwinding API
Message-ID: <20241030061043.eo2vuqgsoqmjytjr@treble.attlocal.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>
 <CAEf4BzY3xJ=W2qPD8i6UbSB=zNqpiA1gSd+SC3wKxQAJWjeHhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzY3xJ=W2qPD8i6UbSB=zNqpiA1gSd+SC3wKxQAJWjeHhA@mail.gmail.com>

On Tue, Oct 29, 2024 at 04:32:46PM -0700, Andrii Nakryiko wrote:
> >  struct audit_context;
> > @@ -1592,6 +1593,10 @@ struct task_struct {
> >         struct user_event_mm            *user_event_mm;
> >  #endif
> >
> > +#ifdef CONFIG_UNWIND_USER
> > +       struct unwind_task_info         unwind_task_info;
> 
> this is quite a lot of memory to pay on each task, a lot of which a)
> might not have sframe

Frame pointers are also supported.

> and b) might not need stack unwinding during their lifetime.

Right, I'm not super happy about that.

> It can be a pointer and allocated in copy_process(), no?
> Though ideally this should be initialized lazily, if possible.

Problem is, the unwinder doesn't know in advance which tasks will be
unwound.

Its first clue is unwind_user_register(), would it make sense for the
caller to clarify whether all tasks need to be unwound or only a
specific subset?

Its second clue is unwind_user_deferred(), which is called for the task
itself.  But by then it's too late because it needs to access the
per-task data from (potentially) irq context so it can't do a lazy
allocation.

I'm definitely open to ideas...

> > +       if (!info->entries) {
> > +               info->entries = kmalloc(UNWIND_MAX_ENTRIES * sizeof(long),
> > +                                       GFP_KERNEL);
> > +               if (!info->entries)
> > +                       return;
> 
> uhm... can we notify callbacks that stack capture failed? otherwise
> we'd need some extra timeouts and other complications if we are
> *waiting* for this callback to be called

Hm, do you actually plan to wait for the callback?

I assume this is BPF, can you give some high-level detail about how it
will use these interfaces?

-- 
Josh
