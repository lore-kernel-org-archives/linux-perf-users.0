Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5302BE7A1;
	Mon, 27 Oct 2025 23:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761608549; cv=none; b=T/jP0zLbO5dWxN2GtyHLSiCxtI3tmyycF+pI3SnuJtPIZnWBNnD1wXiQFH3LRIJ4cb3cbw8Ygy1F24xL3SmO5vAy2WMAfIV4/W4iBJHau9SeICqJjz8Wa+gbETZIvpLyXhkOeLweQHVZmIvmOwQX5BTu2QjoC/801YhH38Q0+gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761608549; c=relaxed/simple;
	bh=gG2hH7WhbSVVnynsoyf11RN3a15KjJlc/LYqB/bQr6k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nYEH8FCsyMCVJVB6KkX2bstb89eY138wCNvF+oaNbomCX8DXD8HCpbO+v6S0AUn+BnopMJzjyzdFfwc7Oshl+Zriktt/96yc2ERgSbmNOybthFK31/YQ7ZrMGmA50/zOUj5vp8sz7mU9zUUFBtaAv278UH1c75gSXEsF3gON3BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQpSmeEg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQpSmeEg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC26C4CEF1;
	Mon, 27 Oct 2025 23:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761608548;
	bh=gG2hH7WhbSVVnynsoyf11RN3a15KjJlc/LYqB/bQr6k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UQpSmeEgbKeE7n0VTh1TeiAoBQeZG363+PEtwIjtQe3waPrX5COqSqnSB3dTl5zM7
	 EhFzUbRu/xaFK9nfgaqPoI6GQustslioWdYRrTd2lTCVTdbpq4VHII9jKsRkYbM2Ed
	 Tgx6d1sPvXCGeuk4i8ZD/VC/ykUd1mJs9kuqvB4ga89qztME1MkgXQK2BWsOAc2IO5
	 0BOS2jSCzXb61VuE3MneYqCloavjOBJGeaQcWcj6SGl4eI+7yRXh9sfSCi9KDHE0AL
	 /b27W35ABmF0Su1mqLITW45SMmGgGo5yRDwIKoy8DgmoqbkIuc7XXrP8xUXbbMBBzI
	 TxDpfTeZqNkyw==
Date: Tue, 28 Oct 2025 08:42:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, Jinchao Wang <wangjinchao600@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v5 6/8] selftests: tracing: Add a basic testcase for
 wprobe
Message-Id: <20251028084222.a3c1ae97d125d9bd88fc565b@kernel.org>
In-Reply-To: <20251027224347.4c887cc956df63602f377550@kernel.org>
References: <175859019940.374439.7398451124225791618.stgit@devnote2>
	<175859026716.374439.14852239332989324292.stgit@devnote2>
	<aPvwGhMBJqMKcC9D@finisterre.sirena.org.uk>
	<20251027224347.4c887cc956df63602f377550@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 22:43:47 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Fri, 24 Oct 2025 22:31:06 +0100
> Mark Brown <broonie@kernel.org> wrote:
> 
> > On Tue, Sep 23, 2025 at 10:17:47AM +0900, Masami Hiramatsu (Google) wrote:
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > Add 'add_remove_wprobe.tc' testcase for testing wprobe event that
> > > tests adding and removing operations of the wprobe event.
> > 
> > Since this series has landed in -next we've been seeing hangs on a range
> > of arm64 platforms running the ftrace tests, it looks like it's all of
> > them.  Unfortunately the systems lock up with no output as soon as they
> > start trying to do something with wprobes:
> > 
> > # ok 19 Generic dynamic event - add/remove kprobe events
> > # ok 20 Generic dynamic event - add/remove synthetic events
> > # ok 21 Generic dynamic event - add/remove tracepoint probe events
> > # ok 22 Generic dynamic event - add/remove tracepoint probe events on module
> > # ok 23 Generic dynamic event - add/remove/test uprobe events
> > 
> > the next test being add_remove_wprobe.tc, which doesn't seem to
> > complete.  Full log (for what little it's worth):
> > 
> >    https://lava.sirena.org.uk/scheduler/job/2000440#L1860
> > 
> > I turned on -vvv logging and that generated the rather spectacularly
> > more verbose:
> > 
> >    https://lava.sirena.org.uk/scheduler/job/2000676/log_file/plain
> > 
> > (in a somewhat processed format unfortunately.).  Looking at that log I
> > do notice a bunch of "unexpected operators" reported by the shell, these
> > systems are running dash not bash, though that doesn't seem related.  It
> > looks like the script hangs in reset_trigger_file while grepping the
> > trigger files rather than actually trying to do the test.
> > 
> > Sorry about the delay in reporting this.
> 
> OK, eventually, I confirmed it is stopped on enabling wprobe
> 
> + . /mnt/ftrace/test.d/dynevent/add_remove_wprobe.tc
> + echo 0
> + echo
> + TARGET=jiffies
> + echo 'w:my_wprobe w@jiffies'
> + grep -q my_wprobe dynamic_events
> + '[' 0 -ne 0 ]
> + test -d events/wprobes/my_wprobe
> + '[' 0 -ne 0 ]
> + echo 1
> 

Interestingly, this stops in the cpu_function_call(). It does not call
__perf_install_in_context().

~ # cd /sys/kernel/tracing/
/sys/kernel/tracing # echo 'w:my_wprobe w@jiffies' >> dynamic_events 
/sys/kernel/tracing # echo 1 > events/wprobes/my_wprobe/enable 
[   54.942288] trace_wprobe: enable_trace_wprobe called
[   54.945306] trace_wprobe: trying to register wprobes
[   54.947367] trace_wprobe: __register_trace_wprobe called
[   54.949586] trace_wprobe: registering wprobe at addr: 0xffffb6ce429fb200, len: 4, type: 2
[   54.951639] Creating wide hw breakpoint on CPU 0
[   54.966390] Creating kernel counter on CPU 0 for event type 5
[   54.967758] perf_install_in_context: event 00000000736da1d9 ctx 000000005d4db900 cpu 0
[   54.972015] perf_install_in_context2: event 00000000736da1d9 ctx set to 000000005d4db900
[   54.976697] cpu_function_call: calling function on CPU 0, func: __perf_install_in_context+0x0/0x2c8

What happen if the cpu calls function on itself by
smp_call_function_single() on arm64?

  smp_call_function_single(this_cpu, remote_function, &data, 1);

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
