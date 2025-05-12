Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75C419C569;
	Mon, 12 May 2025 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747059721; cv=none; b=NglHlEXJn4FOJNPip9UZwB9aWFhEnyEib/Ld+teNqbuH6IED890oNJOBY1mAtBWCK8yV0Gg4dTzFlc96LRHtF8lXwdoZkWhCJPpRzKbqTTN3cF6cNaQWe0mJ5O3SrQwx2hJzKnK1/5DNzJgh1O0McPI5Lv4A5Y/lViDBuvkvHgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747059721; c=relaxed/simple;
	bh=XazQU+jVZ/SD7VaLSIC1WKsOVuuL6b+J+gGOXL01grQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFkSkfwNMqw+a2bdIdSJiUWTEbrl5CbzEwTelF+D/AWngDu5gkDppnJRDeWgdvAyhHKRB1bdMBIgAtS0uq0eqycMRbCUc6fDqW4m5COCrV5VSn87LSL5uNu8xdBINtwkEIA3xq9/DTISpNrkYjLkWC1LIKfxttwJ2O7nL84LKTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F78AC4CEED;
	Mon, 12 May 2025 14:22:00 +0000 (UTC)
Date: Mon, 12 May 2025 10:22:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG?] perf_event_open fails on synthetic event created through
 dynamic_events
Message-ID: <20250512102222.2361a57a@gandalf.local.home>
In-Reply-To: <CAP4=nvS2r=-1GgnmsEA9s7JPs1EVg9R63FLLNboN=f1cq0WEqQ@mail.gmail.com>
References: <CAP4=nvS2r=-1GgnmsEA9s7JPs1EVg9R63FLLNboN=f1cq0WEqQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 May 2025 16:08:42 +0200
Tomas Glozar <tglozar@redhat.com> wrote:

> It seems that it is trying to access a struct tracepoint object whose
> func field is NULL. I have not tried attaching to dynamic events
> through perf before, so I don't know whether this is just
> unimplemented and poorly handled or a regression. For what it's worth,
> it also happens on CentOS Stream 9 kernel (5.14.0-578.el9).

I think it is unimplemented and poorly handled ;-)

If this is something you want, we can add the feature for it, but for this
release and stable kernels, as it's not a regression, the fix is to have it
not produce a warning and give something like "-EINVAL" back to the perf
system call.

-- Steve
