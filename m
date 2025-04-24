Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92EC1DF988;
	Thu, 24 Apr 2025 18:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745521127; cv=none; b=APckKjzQETGtCmf3j5V4oLqWmPl9/zHWzZCV1OrjIMJyouD5kcurBKhBOJbu+wRB7mcl8+aSk0ZaBCUXDedDWewi8Jcd3D9DTtG9GnmgSeNCjr43MgKMx2CeVLpvNsmOzuBp3uV7xstGs+GdHDpn1DFSJtsMtKUwRMZI1xtXcpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745521127; c=relaxed/simple;
	bh=Vn4HMPh7rlBo+ytHM0vJD56lFXWnVYZpS6hl9nO1imQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BrW8XeG3Hse2CXPVbsgRQoahxkJP0QRlW+1iKwRWv6ONMWYT6imiB/tFwMjsmXpGsxz2h99UH9rp4yQarEMcvg8ielsUcvDjWRA09zd5/PoLCJCJHZGRjH+SrfaAoUxQRpnwj8NP2ACD3pADjxWJHQZXE7qhwzASSFF4OyA53I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEA6C4CEE3;
	Thu, 24 Apr 2025 18:58:44 +0000 (UTC)
Date: Thu, 24 Apr 2025 15:00:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, x86@kernel.org, Peter Zijlstra
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
 E. Marchesi" <jemarch@gnu.org>
Subject: Re: [PATCH v5 08/17] unwind_user/deferred: Add unwind cache
Message-ID: <20250424150039.5a8c452c@gandalf.local.home>
In-Reply-To: <20250424162632.532889212@goodmis.org>
References: <20250424162529.686762589@goodmis.org>
	<20250424162632.532889212@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 12:25:37 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> --- a/include/linux/unwind_deferred.h
> +++ b/include/linux/unwind_deferred.h
> @@ -12,6 +12,11 @@ void unwind_task_free(struct task_struct *task);
>  
>  int unwind_deferred_trace(struct unwind_stacktrace *trace);
>  
> +static __always_inline void unwind_enter_from_user_mode(void)
> +{
> +	current->unwind_info.cache.nr_entries = 0;
> +}
> +

Hmm, the first patches just had unwind_enter_from_user_mode(), but the
later patches (that I'm currently working on) have unwind_exit_to_user_mode().

I think the exit is better than the entry, and I will change this to just
use the exit_to_user_mode and removed the enter_from_user_mode.

-- Steve
