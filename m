Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0136B3CFF61;
	Wed,  5 Aug 2026 19:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785958406; cv=none; b=o8T4XeDE6rEZ+pESwXuTwuYsLnH4Dm79M374GL3BA+M7idV7QBpHBw+10z7X3Z3koFVaZQEZeC/z411DUPiQhShAzpU3FO10S/PReWRkZ2++0SRr6wQ79mhedgG4ATG9ayeSDHWLf0KpeCRf97d+zf1Gf9eIMIaegW3P6d4ORcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785958406; c=relaxed/simple;
	bh=bidEVgC5Ds+XJ+VGHWtsOlDGz/RBq5Ku3eFS4iE4IIY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nm+/Z1RbTHdZeIEkjFOQOYLjr4hDUb9kWaPlIYVQUMb+WhEVEU8zV0qM9Ecc4V6PctLxx2DjEgwcZFhZ1zBvZqoPCvCHxiQK/oZ0JdIQTIXFbF4AwJRwR1mbhNra5OquFpylQPryZ0ZQq8Tg4b2qsumpjbJMPc19B3RQrXfK9nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 98BE81605A6;
	Wed,  5 Aug 2026 19:33:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 39E3A19;
	Wed,  5 Aug 2026 19:33:13 +0000 (UTC)
Date: Wed, 5 Aug 2026 15:34:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, x86@kernel.org, Jinchao Wang
 <wangjinchao600@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v11 04/11] tracing: wprobe: Add watchpoint probe event
 based on hardware breakpoint
Message-ID: <20260805153404.793691b8@gandalf.local.home>
In-Reply-To: <20260803070356.GV49951@noisy.programming.kicks-ass.net>
References: <178565870538.714490.11309825813968306287.stgit@devnote2>
	<178565875046.714490.17724442147958346980.stgit@devnote2>
	<20260803070356.GV49951@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 39E3A19
X-Stat-Signature: 36kaj4s31uxdtocz8epyyd64b4a8o7fh
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18vOzPewqndsKKXmAb/ykNrqHv762QwPDg=
X-HE-Tag: 1785958393-487645
X-HE-Meta: U2FsdGVkX1/aeAJlcoe01mPSAErVYvZV+yb3FNkgx5Z8+bWOHMpH6SUAW9tuhQ6gM53sVtseq4qaAngCGN9g04YD3/M0YqS1ZornR4W5FOQUKclU5E79OOP5uja7DMcjHgPHjm5SCBkpbGhz7uLwA48pEzklBopjrfDMoMo1YCOWktRGrPfpeullnZX+jypeGmDS55mg85ezmCDE4v/DWJuXEowhf8x16rCfNMyofzEQY1Ls5KIcFNewcp9LwZmdRdL1wdmrOAvCOf7rC3yXOylcMcsctu6KXNmOP1SyiW6sB6AtVLzotigBb8uZi7vXFdOjuwMthEvXsYKciVJ4OIhWW0wMgFQdl4iL20nA1Ye8KM7DpT5bHrjvEAcqwK1V

On Mon, 3 Aug 2026 09:03:56 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > The new syntax is;
> > 
> >  w[:[GROUP/]EVENT] [r|w|rw]@[ADDR|SYM][:SIZE] [FETCH_ARGs]
> > 
> > User also can use $addr to fetch the accessed address and $value to fetch
> > the accessed memory value (shorthand for '+0($addr)'). No other variables
> > are supported.  
> 
> This seems limited to kernel addresses only? Should not also userspace
> addresses be supported?

Hmm, how would that work? The address is global for all tasks, so if you
add a user space address, what task would that be for? The one writing the
probe?

-- Steve
