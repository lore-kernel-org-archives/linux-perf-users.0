Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02D427FD76;
	Thu, 24 Apr 2025 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513971; cv=none; b=M9lhUvNj5+uA54ZNduJMST8ntJdMA+q64GQTOTW4C8bsXukOM5rM6hn5JOjRPDzQZ7kQf+LQFEh8j2uIafJ2JfIXLxO0DjAJX08KJSbgW74AylOZK5hW+Bg8aEfFu0XaEi8erRMVM25prDWEofmEz2SW0KJXq8vrbOWHNwz83+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513971; c=relaxed/simple;
	bh=knzsGm15P6a2Z39+5aVkyTJFWX9Hojaj1ywEJQ3gv8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/IeOQiT33FuKVrDMIrFY0prZDW52LWJ3Bn5Q+lQz/zH6wIM9ulkb4/e+JFJUqg2IU34RThVyMIF6e3zbB7KOeNJh8+ssMOV4R8ftLIhTklu1xH5mzx9TiEdhMYuAS50swIUw3eJbFEQwmja1qNvmYscFktKJxwClUOxAYmMeLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C50C4CEE3;
	Thu, 24 Apr 2025 16:59:27 +0000 (UTC)
Date: Thu, 24 Apr 2025 13:01:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Mark
 Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, Jordan Rome
 <jordalgo@meta.com>, Sam James <sam@gentoo.org>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Jens Remus <jremus@linux.ibm.com>, Florian
 Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, Weinan Liu
 <wnliu@google.com>, Blake Jones <blakejones@google.com>, Beau Belgrave
 <beaub@linux.microsoft.com>, "Jose E. Marchesi" <jemarch@gnu.org>
Subject: Re: [PATCH v5 12/17] perf: Skip user unwind if !current->mm
Message-ID: <20250424130122.4b6ee0df@gandalf.local.home>
In-Reply-To: <20250424163718.GF18306@noisy.programming.kicks-ass.net>
References: <20250424162529.686762589@goodmis.org>
	<20250424162633.216110813@goodmis.org>
	<20250424163718.GF18306@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 18:37:18 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > Note from v4: https://lore.kernel.org/all/24cde1381495cd637f0d5663ab7629572bc0eca6.1737511963.git.jpoimboe@kernel.org/
> > 
> > - From the previous version, Peter Zijlstra brought up concern about
> >   io_uring helpers, but this was never resolved. No update was made.  
> 
> What is there to resolve? If you want to check for kthreads, don't check
> for ->mm

I misunderstood what the issue was then ;-)

OK, so the check should be task->flags & PF_KTHREAD ?

-- Steve
