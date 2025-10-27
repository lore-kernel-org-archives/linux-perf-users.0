Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DD5212562;
	Mon, 27 Oct 2025 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572635; cv=none; b=NpNrmoZ/rXRtdt7k+zVM3aEy07wUSdKO6X/0XESbDTmkSmAT5uURgCqHTFVWB2UCF4Dt6w3DkjbcLXLxsG0ehWlrCZmB6ilF5oJemAFu84Y+uzlf5vChmQegAw3H19R5afm+EOXVq++XdrtXemaH17agWXcTQdM75Zuv+/FUHis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572635; c=relaxed/simple;
	bh=igDNAhFHKqtSgQ0qZDaeaIsIItKRa96qIdeht8uHaII=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BJarpINVzFOzVB4RRfZbnM0rz6JgpiSYyGCLrBO3kStMCD6RkqBW2GcLqFPNi9sGk9/s1k6BhcBwvOOwm800FvVSJBxyoCedHqq9Wo2wNYEkxJaIoGcVqqFPBb78kh4PbC7A6fqX2lfLOAyL9CvM1tlgc4b7jRi/dbpHLx/ohGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOTrgcaT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOTrgcaT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401E8C4CEF1;
	Mon, 27 Oct 2025 13:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761572634;
	bh=igDNAhFHKqtSgQ0qZDaeaIsIItKRa96qIdeht8uHaII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eOTrgcaTVMN3otzXTXqXybj2AvCx+1qQ6Yhz9GwBemKPHyBTESC4PYFXOYIfUGnIN
	 pkji8zUTWYbxFsb/DGW9DET0slCXn7fH7jaFqt90XdltmDZ8WnVD283vGxX5Eo07wq
	 ol/xSiCK+EcCRCA7oYhz24n9fiE01TWBhOPet39iAnqoqRbxkdLG4+iuGbCkLwC0R6
	 RsXipc2z3N/XFPVOD/TjAly2T19Geg7TVM91gVIsrvMmutCOJCcRSyeSazpE7iGsqv
	 BH+aHdixULzn4YwAyASxF/Bdv4DBapwURqY5G7ufNN25I6Fnav9vieA/iwVEHREgqp
	 HnBi1IZYRCaXg==
Date: Mon, 27 Oct 2025 22:43:47 +0900
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
Message-Id: <20251027224347.4c887cc956df63602f377550@kernel.org>
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
> 
> # ok 19 Generic dynamic event - add/remove kprobe events
> # ok 20 Generic dynamic event - add/remove synthetic events
> # ok 21 Generic dynamic event - add/remove tracepoint probe events
> # ok 22 Generic dynamic event - add/remove tracepoint probe events on module
> # ok 23 Generic dynamic event - add/remove/test uprobe events
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
> 
> Sorry about the delay in reporting this.

OK, eventually, I confirmed it is stopped on enabling wprobe

+ . /mnt/ftrace/test.d/dynevent/add_remove_wprobe.tc
+ echo 0
+ echo
+ TARGET=jiffies
+ echo 'w:my_wprobe w@jiffies'
+ grep -q my_wprobe dynamic_events
+ '[' 0 -ne 0 ]
+ test -d events/wprobes/my_wprobe
+ '[' 0 -ne 0 ]
+ echo 1

I also confirmed:

~ # cd /sys/kernel/tracing/
/sys/kernel/tracing # echo 'w:my_wprobe w@jiffies' >> dynamic_events 
/sys/kernel/tracing # echo 1 > events/wprobes/my_wprobe/enable 

Freeze the machine.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
