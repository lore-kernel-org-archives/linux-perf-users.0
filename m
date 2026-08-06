Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CED9314A65;
	Thu,  6 Aug 2026 01:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785978398; cv=none; b=Bd5n/8D5xBUzrGyJVWp19IiYVFvLZIbNLLago791dQgGP1f90oyf44q/e1Dkax4YqSiK7ptIfoIbVx1E5tzDFeWfT7lmDeGRsKjLKxz7RGIhhT2Ves/V0IKQ18FinG/cMTGwmk+qklJu4KM0Gg+LKoN81POu9Xg6xOprVVg7Xbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785978398; c=relaxed/simple;
	bh=oZWwZpZaBfzxETIvWVQkgF8pn49zjf7hHwVMF/yEMXs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DdDndkPTd8QgaADcbX17mmiJRrwY2ExeJ2PZwQAqo5arDFoKfhdvLSt5lAUrnH2Ysa5dncr+naHlk6KAvRiGzwt8XCg6O8dRIbT+uto02cAZaWKJcmmXcvmdKcx6+638ipDFv4c/eMAwECKi6TtYKZXzQgCacfmcbWQHzJR2S5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id AF328160636;
	Thu,  6 Aug 2026 01:06:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 88AE92002E;
	Thu,  6 Aug 2026 01:06:30 +0000 (UTC)
Date: Wed, 5 Aug 2026 21:06:29 -0400
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
Message-ID: <20260805210629.138f6197@gandalf.local.home>
In-Reply-To: <20260805193909.GP776954@noisy.programming.kicks-ass.net>
References: <178565870538.714490.11309825813968306287.stgit@devnote2>
	<178565875046.714490.17724442147958346980.stgit@devnote2>
	<20260803070356.GV49951@noisy.programming.kicks-ass.net>
	<20260805153404.793691b8@gandalf.local.home>
	<20260805193909.GP776954@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: mhsa33wwby48gjw78tgp86dxqexr31di
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 88AE92002E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18XdjCfirfw72FGQ9YVW0CPH/Aw3ZhNJwU=
X-HE-Tag: 1785978390-582760
X-HE-Meta: U2FsdGVkX1+FvU7/zFEIk84yhlNo0mA36eU7jB2jMx1YEtUwtr57MlMTOGslZY7YEEhu8eyAao3FM5j5ciaM6L+kMlaKH478PsnKUjVijqcZB0SMKt/OANKa9F0NLDFO0iB0oWlBt0sPMom7CcvjGrdSUEw3R9YEc7F3trDb1jDjXI1I9c+Oyx0tYXohbFAuZRs2CYqbZkN9YuLozDEuP+7ZOuS6aaYpKHZNxEAW7QwmoVWi8eeYcy7avfBkfNK15tIYcegsyP4avQudY3uEjWh3Ra21/0ees28aTpE6+wDOEPFQHsrTCOUYQu+GOuuz9wbxg7Xc9sEp3plBeoC0ghChGuQRVXO890U47MvshZA1Kj5c9BfFygonuF94JNk4

On Wed, 5 Aug 2026 21:39:09 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > > This seems limited to kernel addresses only? Should not also userspace
> > > addresses be supported?  
> > 
> > Hmm, how would that work? The address is global for all tasks, so if you
> > add a user space address, what task would that be for? The one writing the
> > probe?  
> 
> Schedule the watchpoint along with the task of course. Given there is
> breakpoint/perf integration this should be trivial.

I meant, what task is it attached to? Usually the way a probe works is to
create the probe and then enable it.

 # cd /sys/kernel/tracing
 # echo 'w:my_jiffies w@jiffies:8 value=+0($addr)' >> dynamic_events
 # echo 1 > events/wprobes/my_jiffies/enable

If the address is in user space, which task would that address be for?

What would the API look like? Should we add a pid to that for a specific task?

Maybe use zero for current task?

-- Steve
