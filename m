Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AB21B4F15;
	Fri, 25 Apr 2025 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745602342; cv=none; b=ts8PMw9LArDqR3eazGoFL+SKLrlc+q3MPrcvnX+gIYTAf8C4G3m8G7NZxplKIgGdH6Uiew4bstYD873aU3Xh7Zilq6FC706gQZS3ezWsIVp0aWgk9EbQhL9IPraSg142RdFB44m3HHwQYgtuMN5eW8s9E+0aLt3eb1rh+h6ywWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745602342; c=relaxed/simple;
	bh=G4VOoYDvhLfIc54xRT4vzjjA9iFFlvqP5ptNnnlBd/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6m4+BUK41Hi8fSgbhupEjW17H3Yps2KW6N6geE9OQUK2M1xADBEkVsTrLnkVx296veF+ftO0coNlFKx/D4GdAAZvmxBlpvExGKHf+dMlekrPsdg/2I0v+gt2LN4p6D32oHdJwgSpjZju4v/udYUJpHVoBlCl+FFgcTD3y2cePY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0708C4CEE4;
	Fri, 25 Apr 2025 17:32:18 +0000 (UTC)
Date: Fri, 25 Apr 2025 13:34:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, x86@kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
 <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>, Sam
 James <sam@gentoo.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jens
 Remus <jremus@linux.ibm.com>, Florian Weimer <fweimer@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Weinan Liu <wnliu@google.com>, Blake Jones
 <blakejones@google.com>, Beau Belgrave <beaub@linux.microsoft.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Alexander Aring <aahringo@redhat.com>
Subject: Re: [PATCH v6 11/18] perf: Use current->flags & PF_KTHREAD instead
 of current->mm == NULL
Message-ID: <20250425133416.63d3e3b8@gandalf.local.home>
In-Reply-To: <2fjdalrdgadbt6kmv7wgbc2vs42ojkwh2vj6yfwlttmoo2rijs@5gtrvow66g7m>
References: <20250425145422.132820147@goodmis.org>
	<20250425145813.518795213@goodmis.org>
	<2fjdalrdgadbt6kmv7wgbc2vs42ojkwh2vj6yfwlttmoo2rijs@5gtrvow66g7m>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 08:09:55 -0700
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> On Fri, Apr 25, 2025 at 10:54:33AM -0400, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > To determine if a task is a kernel thread or not, it is more reliable to
> > use (current->flags & PF_KTHREAD) than to rely on current->mm being NULL.
> > That is because some kernel tasks (io_uring helpers) may have a mm field.  
> 
> There's a current->mm check in the user space unwinder (patch 1) which
> should probably also be converted.

Bah! OK.

I also plan on creating a couple of macros and running a coccinelle script
to replace all instances in the kernel of:

  !(task->flags & PF_KTHREAD) into is_user_thread(task)

and

  (task->flags & PF_KTHREAD) into is_kernel_thread(task)

As I've already screwed up missing the '!' (or adding it) a couple of
times. But caught it before posting the patches.

-- Steve
