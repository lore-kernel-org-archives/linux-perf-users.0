Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E8B1DFFC;
	Mon, 27 Oct 2025 02:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761532185; cv=none; b=kZg8oVdfTX4cAGs+NFBu3IgROLvTylrhA4HYIzq49e54Kp/UrLo2Mgyoxg2URULJ7LV6bgVlM8uZmfDZCBLnerJ+LyzY/sVlf9MGaF//UCThyZpX9qUm9EHxrKD2E1AXs0SxjVsYU1JrRmC0m/935vy8as9CGinSCEbA2dZM+b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761532185; c=relaxed/simple;
	bh=Jv0StzLdkPw7Qg9z8uEgyVO5Bn1RJ64wxzXC6DVC2TY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VFB6eUN3fNkrQ1WSdNBA2sn7YX1goViWGPEUj5bcovR5FN72FutKfUTA1zAuq73tudgXmqgO0pby68UDO+HDtwkR4XOoksv3OCjl9stuURBD0IIPzJbVr9qXGUSKNv7xSvHn8NxrqAT2WZVPYnZQyisg0yGHg8uKobOZ8XYVbyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9Vo/wKD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9Vo/wKD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2BFC4CEE7;
	Mon, 27 Oct 2025 02:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761532185;
	bh=Jv0StzLdkPw7Qg9z8uEgyVO5Bn1RJ64wxzXC6DVC2TY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c9Vo/wKDewFAO95sAbUUfzBcIIrwLYXwl11n70C70LnH/SRsZG4SZKClOTqX7sNGg
	 8muV+pnX0khJDJQzpbKarmehAOJcRb1x9dCkRM+mrpebzSDX71j0WM01OlCvVfjE+F
	 t+bymSOZLVB+rK3B8YGxwlWIwGzvXfLkH9W/LTNJy3kGIiZWzw9grdlmseXOTKq2AJ
	 rhbA77IeJVMSBU66HM6cFtYgAP96KgHOI7MOULEcqK+DPD8dodR4xEHUwqQEMWajm1
	 68SIrV2b1jeuHiSHyhIpyu3RT0PgZuL7kL06uHXew6OZjU7enbK0Aw2LRBvTMKYpwI
	 O8SmIOPPrRapQ==
Date: Mon, 27 Oct 2025 11:29:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
 Jinchao Wang <wangjinchao600@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v5 6/8] selftests: tracing: Add a basic testcase for
 wprobe
Message-Id: <20251027112938.bd34197bdbb5394bb2b220d9@kernel.org>
In-Reply-To: <aPvwGhMBJqMKcC9D@finisterre.sirena.org.uk>
References: <175859019940.374439.7398451124225791618.stgit@devnote2>
	<175859026716.374439.14852239332989324292.stgit@devnote2>
	<aPvwGhMBJqMKcC9D@finisterre.sirena.org.uk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 22:31:06 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Tue, Sep 23, 2025 at 10:17:47AM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add 'add_remove_wprobe.tc' testcase for testing wprobe event that
> > tests adding and removing operations of the wprobe event.
> 
> Since this series has landed in -next we've been seeing hangs on a range
> of arm64 platforms running the ftrace tests, it looks like it's all of
> them.  Unfortunately the systems lock up with no output as soon as they
> start trying to do something with wprobes:

Oh, thanks for reporting!

> 
> # ok 19 Generic dynamic event - add/remove kprobe events
> # ok 20 Generic dynamic event - add/remove synthetic events
> # ok 21 Generic dynamic event - add/remove tracepoint probe events
> # ok 22 Generic dynamic event - add/remove tracepoint probe events on module
> # ok 23 Generic dynamic event - add/remove/test uprobe events

OK, let me check.

> 
> the next test being add_remove_wprobe.tc, which doesn't seem to
> complete.  Full log (for what little it's worth):
> 
>    https://lava.sirena.org.uk/scheduler/job/2000440#L1860
> 
> I turned on -vvv logging and that generated the rather spectacularly
> more verbose:
> 
>    https://lava.sirena.org.uk/scheduler/job/2000676/log_file/plain
> 
> (in a somewhat processed format unfortunately.).  Looking at that log I
> do notice a bunch of "unexpected operators" reported by the shell, these
> systems are running dash not bash, though that doesn't seem related.  It
> looks like the script hangs in reset_trigger_file while grepping the
> trigger files rather than actually trying to do the test.

Yeah, it seems do nothing on wprobe. Let me check why it happens.

Thanks!

> 
> Sorry about the delay in reporting this.


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
