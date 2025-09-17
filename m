Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAEB2D46B7;
	Wed, 17 Sep 2025 22:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758148975; cv=none; b=I5yEx6xi+FU6Cav99318J+qbF/03BpJgYpdb6EwXwCmAVlDiukkSt9WaEBGv98mYNccO+jGVnngYBbPeFt5DTHdLc7uZCZ/3SIC7vFyUf7LKFYgmW6v7etHA4Xl7gVvfsyLgChQWIBRZrutoJ5kehq4u/Yyr99b0YFVxk6A6JtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758148975; c=relaxed/simple;
	bh=1fYjV9I/mts9hAv/Oa99SQdbOQ5xxivRisDGmyAWMSM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tdQH70f33XDxN3ZL/eG1Be+XGIE9NNFXR0jNEmlNgAxyV9CSh9rCOClDDnZGODtq4dR47I7VOi6Zug6A2hNRVG4nqRTxl0lj6xTsJ8pTxAvXi4/9XcpQ2F+1/5YAEuq3CZBuRr2eNaQN2THy8Jml5JlNJd22faBL9uN748vX9ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLKzgBEF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLKzgBEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4AFC4CEE7;
	Wed, 17 Sep 2025 22:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758148975;
	bh=1fYjV9I/mts9hAv/Oa99SQdbOQ5xxivRisDGmyAWMSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NLKzgBEFZ4Zyy9Vu1S7pJNy1W+OOx1we/8MNJZgHs6vBIFDyDpOBQABwtI+sS+NZt
	 JUzwocZAwa0giR4M3UmUQl5QebDUywpZNjbPrlCAa+G25DYnbqE7BWksR17SbBhdYO
	 8lVwzxofNTv3Sjuo8tfh0Vvg0F619jva3aw1GZDMYVyq/J96VRXQtzhJhfitKZ3TUh
	 V8XNJGkDqD6JTHTzIWVceN4U03pUaFKIKmuvumkvctHeXe9SGootBsdYrbh01HboQH
	 XSB2KOOwq/l+umVioi+qMSK3drlwHEvRE9zQPASM9vO0/fhPZIOjcxKhg3JXe3Vi30
	 cLP1XXeAtlmoQ==
Date: Thu, 18 Sep 2025 07:42:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
 Jinchao Wang <wangjinchao600@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 1/8] tracing: wprobe: Add watchpoint probe event
 based on hardware breakpoint
Message-Id: <20250918074248.09cc039bd81ad7ffe2b4b09f@kernel.org>
In-Reply-To: <f8d432e0-e220-4857-8d4e-427332ce837a@infradead.org>
References: <175785897434.234168.6798590787777427098.stgit@devnote2>
	<175785898586.234168.14883193853242691280.stgit@devnote2>
	<014136d2-8599-4a1f-ab8e-c5be4f522e5a@infradead.org>
	<20250917233818.71678d0164a6fc2d11fa6e38@kernel.org>
	<f8d432e0-e220-4857-8d4e-427332ce837a@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 10:13:36 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> 
> 
> On 9/17/25 7:38 AM, Masami Hiramatsu (Google) wrote:
> >> +  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> >> +  #              | |         |   |||||     |         |
> >> +           <idle>-0       [000] d.Z1.  717.026259: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
> >> +           <idle>-0       [000] d.Z1.  717.026373: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
> >> +
> >> +You can see the code which writes to `jiffies` is `do_timer()`.
> > I'm having trouble getting from tick_do_update_jiffies64+0xbe/0x130,
> > which I expect is
> > 	jiffies_64 += ticks;
> > in that function, over to do_timer(), which also updates jiffies_64,
> > but is not called by tick_do_update_jiffies64(). AFAICT, there are
> > no calls to do_timer() in the file (kernel/time/tick-sched.c).
> > 
> > Can you explain, please?
> 
> Let me try this again.
> 
> I understand the stack (call) trace/dump and your explanation, but
> then your next comment says:
> 
> +You can see the code which writes to `jiffies` is `do_timer()`.
> 
> Does that need to be corrected?

Oops! sorry I missed that. Let me fix that.

Thank you for catching!

Thanks,

> 
> thanks.
> -- 
> ~Randy
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
