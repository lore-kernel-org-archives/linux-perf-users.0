Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7679118E34A;
	Thu, 24 Apr 2025 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501951; cv=none; b=i685Cr8jotv6snFVWE7RRq1UM95kjG/C6YCLdof4CXlbp7rAJ9+0RPfxxSIvXcBcA0rY6CX1gOP9EgfG1qsbUu7rznAU1vgl6cXoP5OpyK70R5KO51bq53K8+LC8Loh9XxqnQBg8pexAiko+gxPW7Rh883Yi5mkdZBTwVhZQqXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501951; c=relaxed/simple;
	bh=qgnyhI7G1sbn3+oID5OpHpCLMNHcLsKjgs4//IEb2I8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pP+rqfyoyc6kwIFHs1kGQwGVq9upHMrW9Hekj0fnr+drup9OXVdGU/tdmb0ODkE5SsE5E+ZgubOF9bY02q47DHFiQvhzoTC3RvkGcRlpE126x1GY+3OnaUuQB7JEc6Ct/iFjdzbfld0yTyvG7AUYsPoo/jCLgDgusK4YNfb4bew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D063CC4CEE3;
	Thu, 24 Apr 2025 13:39:07 +0000 (UTC)
Date: Thu, 24 Apr 2025 09:41:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, x86@kernel.org, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, Indu
 Bhagat <indu.bhagat@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
 <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>, Sam
 James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org, Jens Remus
 <jremus@linux.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 12/39] unwind_user: Add frame pointer support
Message-ID: <20250424094102.0004f8f8@gandalf.local.home>
In-Reply-To: <20250124181610.zdqvdaeqrp7kyzis@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
	<10b92f2fd065b67e6e3fd473ca145c34ea74b73a.1737511963.git.jpoimboe@kernel.org>
	<CAEf4BzaQr1ruCh1beyhJ_i+aGuw4rGSftF_Zr5ZB=8Jim1jyyQ@mail.gmail.com>
	<20250124181610.zdqvdaeqrp7kyzis@jpoimboe>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jan 2025 10:16:10 -0800
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> > Do you plan to reuse this logic for stack unwinding done by perf
> > subsystem in perf_callchain_user()? See is_uprobe_at_func_entry()
> > parts and also fixup_uretprobe_trampoline_entries() for some of the
> > quirks that have to be taken into account when doing frame
> > pointer-based unwinding. It would be great not to lose those in this
> > new reimplementation.
> > 
> > Not sure what's the best way to avoid duplicating the logic, but I
> > thought I'd bring that up.  
> 
> Indeed!  That was on the todo list and somehow evaporated.

I'm getting ready to post an update of these patches, but I want to mention
that this has not been addressed, and I'm replying here to make sure it
stays on the radar.

-- Steve
