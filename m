Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30AA285072;
	Fri, 17 Jul 2026 23:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784332068; cv=none; b=UtDdkzokRpzhoQIi38hEwLAJdaX6MmWp5degy1jVyJvNNEAFwuebTV4jvGHazTPUAiERIGpe0T9EvjoPcXBaCXuh0MIqM7IIW68WkSDXfSd/bkhxDVg44tszWPwokuvwb/AmuOufJA46793tmKHo5SfMjX3howHai5d9SE5f/zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784332068; c=relaxed/simple;
	bh=6+iLXcukO9kKo93gmI/NEwqNvTXl/93g9fGAf+hyOBQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qaceQWfG8c3Sa1qtrrUbfh9vqVbuxOBQr02QD4GYuqHAiemG5setwzBFWlTmSN+3YeIcVDUvF8UAHYupZykqlSSeyLUcl56xU9Ck8jzQ5QyH2OTsL6YJPvVMfsHfO8psj4RxW4xzv8Sw1GgqKQd7jTlAaXcKgRfQBzD1oUKqqPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDZ5XqSS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDZ5XqSS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB6D1F000E9;
	Fri, 17 Jul 2026 23:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784332067;
	bh=7SggbiWRchPG09jtp9thpfg+zNw5Jym2Nljf2aMAvd4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IDZ5XqSSafOEbGFdCxhLODkiS/IY2t6WA5yubO6QRIfwAsPsWsy8h8decOJTBNRSa
	 mRmZnn6cHG4dnm/ApMq0DPjkk3EmIUKZ+bYD1KCM4+1m0ZzOPgwxs+/vQILwE/Ba+x
	 MK0IMNIeXKiPkhu3BA7MA0DOgjI2hrtM68n42CaaqH5QD4ch9EXk3NASoEH+Q5tT+3
	 PjTrEtEpFccQLs9fgwAAkGCH6pi/YuR/hCW56RYsHy2Ir35UkGOUXLCPmrylxPaZG7
	 GgSX22DtMdayBHPu9Q1qJOSjgCAo375shZ0lFB4i8wW+j8Q1UdxLgLzjCWhQrUWdSA
	 BdWdtJigbUTBw==
Date: Sat, 18 Jul 2026 08:47:41 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
 Jinchao Wang <wangjinchao600@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v9 00/10] tracing: wprobe: x86: Add wprobe for
 watchpoint
Message-Id: <20260718084741.c2ae6e41f2a1510ffa06d12e@kernel.org>
In-Reply-To: <20260717162857.GAalpYSaZ_emTMUEEW@fat_crate.local>
References: <178429796992.157981.3393977217853767915.stgit@devnote2>
	<20260717162857.GAalpYSaZ_emTMUEEW@fat_crate.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 09:28:57 -0700
Borislav Petkov <bp@alien8.de> wrote:

> Hi,
> 
> On Fri, Jul 17, 2026 at 11:19:30PM +0900, Masami Hiramatsu (Google) wrote:
> > Here is the 9th version of the series for adding new wprobe (watch probe)
> 
> any chance you won't blast out your patchset every day?

Ah, sorry about that. I'll rate limit myself this weekend on this series.
(I hope I have fixed most of major issues...)

Thanks, 

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
