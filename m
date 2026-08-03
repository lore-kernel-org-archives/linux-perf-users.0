Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464B7281503;
	Mon,  3 Aug 2026 07:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785740661; cv=none; b=VPzgyltDC2IvSIgK0KyUPQKyvEmBZ5rmNUhEgkN5NKM3AI9ifM3JTWBgz0paKDqAnkQ1CY37ONQdQLi8uFoxA2TAXa8bL3DOVmeDu97WuvWEk77TXCe2IIvBSPUhxogDRKsidjD40ylgiBRWxw2o216G8EQcu/2kR6aLNfWbNPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785740661; c=relaxed/simple;
	bh=45B/4YxpGwiSyosWOVmD5P//n4CuXFA9CAl5n5a1Zkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLbLlE9idS5XmEdNy5groJSxNLeR4sS0ZTdC4vmMk2o3bs3Hd4fIK1zCRLqjAau5ku7NGJV2w0Y0O2r8qh39nAo83/tN1DvFp/t1HO0VgwfVdCKx6Xb8ia1Gdb2QeBupcHvlb985OJFMOlAOzBE9VO01bIbiRn46p7Ddn5eyTuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h98Mshf3; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h98Mshf3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pN2mZZaKvdXjyFzFkW14Jlowmta22s09z5QPGKFDCvA=; b=h98Mshf3A1PPjJWaIRuyAiaG9K
	O0eApEEkQJ7zQcZu1Us7uWTISWdY29sgXm3btM7LMW7wQBOH95tpNvde8ttM52G6PxqLoxHmObMJt
	6BXo9EbbhhDCrU1e3h1QfE1cOzl1/NE5uDHOb4MmKnemaeyOmQoRwGdxCmOsSMpYMf9D7vioq+iGv
	p0NqfLhbcoUIL4ybXWdMRb9BbFtJ/yb8B+Oi4W9jlF4Dw4H3OLXmnSo71IhKQ0y0QvMOrZZKrGT5B
	Y4SSMTGV3I1HWrOG8l20K76RhdwmOjsN7/VoOidyBIBsb96SVpLhDdnU22sFsGQITk+FDpOfQbbyo
	ru2eoeDA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wqmiM-00000008lIh-06kY;
	Mon, 03 Aug 2026 07:04:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 20CA430045A; Mon, 03 Aug 2026 09:03:56 +0200 (CEST)
Date: Mon, 3 Aug 2026 09:03:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org, Jinchao Wang <wangjinchao600@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v11 04/11] tracing: wprobe: Add watchpoint probe event
 based on hardware breakpoint
Message-ID: <20260803070356.GV49951@noisy.programming.kicks-ass.net>
References: <178565870538.714490.11309825813968306287.stgit@devnote2>
 <178565875046.714490.17724442147958346980.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178565875046.714490.17724442147958346980.stgit@devnote2>

On Sun, Aug 02, 2026 at 05:19:10PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add a new probe event for the hardware breakpoint called wprobe-event.
> This wprobe allows user to trace (watch) the memory access at the
> specified memory address.

s/the memory/the kernel memory/

> The new syntax is;
> 
>  w[:[GROUP/]EVENT] [r|w|rw]@[ADDR|SYM][:SIZE] [FETCH_ARGs]
> 
> User also can use $addr to fetch the accessed address and $value to fetch
> the accessed memory value (shorthand for '+0($addr)'). No other variables
> are supported.

This seems limited to kernel addresses only? Should not also userspace
addresses be supported?
