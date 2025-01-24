Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D36D1FDE1B;
	Fri, 24 Jan 2025 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737742119; cv=none; b=DjRwnqRQ1QU+Y9BWihT1HV8cQsx062cg6lIcC2rFjHnZKt9eCGId2GIt9ARXeaHhYxdPS2r/R30XmaBcRrv89VGgESpFzpNksQX9IV2wZASdNWiXd9OmCFJnYRwXIEvTPYIYR9C8drS6ZZ8SltA13fI9Bj5n33BtnXitP/i2sR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737742119; c=relaxed/simple;
	bh=QDY1S9kRacqojgE5wCyqVdU/D1IKxnYBzqI+rIRIWHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiOKYJzVY9EEQxSiplM3rnU8JVlETmy8HoszfB6E3yh0Fl3JcxiRtsXdYAGf+MHbcypJRzlsYdmV+mb+9lxrcLADMSJvbVe9WTNx7U/ZSqnqVqD+c8rtRvPI10E7FRffx3KE+a8l4PcEtqkh1R9G6aRJ4PBzPLneMgB8NWkYgh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otCQeYV1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otCQeYV1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C21C4CED2;
	Fri, 24 Jan 2025 18:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737742119;
	bh=QDY1S9kRacqojgE5wCyqVdU/D1IKxnYBzqI+rIRIWHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=otCQeYV1X7O/Eh3dlRdQVlJLdsdrDTf5qpyweiojWIfTNTRjMV4QPeiiY1s1x3YkL
	 UCQUrpbMfB2yc2p99qMZktG3QZF64rnpUY9e5uKXQPVbK6zx06ranp1a4c9s1C3jKZ
	 LO8NsMcvVxthZYsAqddBt304mYbVRQ4r4qnoLIoihfNTw0ATwzy+v3Z6SpNeg83i4b
	 6lwu2RHU0LyTNzAQyqXP+nDJlIebvey1iJEjdel6jqD7WE9NoVAQUHKMfzduGbKCij
	 yeZUjjXsTbEl79a3es/hHKRJMpfgybJjH/z2X7hSj44O0GakBbdIwCEQ5lxhyCNWT6
	 0kWlPi7fVqNag==
Date: Fri, 24 Jan 2025 10:08:36 -0800
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
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 11/39] unwind_user: Add user space unwinding API
Message-ID: <20250124180836.g34wzbtjxguja36w@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <cd54347d26967427bc831f473d76e424ba3eba95.1737511963.git.jpoimboe@kernel.org>
 <CAEf4BzbG3C5=8bB0DKrVdMHDxADbZxnAwku46QAqt8qLW6ngOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbG3C5=8bB0DKrVdMHDxADbZxnAwku46QAqt8qLW6ngOA@mail.gmail.com>

On Fri, Jan 24, 2025 at 09:59:28AM -0800, Andrii Nakryiko wrote:
> On Tue, Jan 21, 2025 at 6:32 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > +int unwind_user_next(struct unwind_user_state *state)
> > +{
> > +       struct unwind_user_frame _frame;
> > +       struct unwind_user_frame *frame = &_frame;
> > +       unsigned long cfa = 0, fp, ra = 0;
> 
> wouldn't all the above generate compilation warnings about unused
> variables, potentially breaking bisection?

It doesn't break bisection because no arches support UNWIND_USER yet so
this can't yet be compiled.

But yeah, it's shoddy and I fixed it after Jens' comment about the
unnecessary zero-initialized variables.

> 
> > +
> > +       /* no implementation yet */
> > +       -EINVAL;
> 
> return missing?

heh :-)

-- 
Josh
