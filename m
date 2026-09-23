Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95711397936;
	Wed, 23 Sep 2026 09:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154965; cv=none; b=MuD4a6A/0hfkYyX6PQ3JjCu0dwipKjZvClQ20LnJ8/sTpY5A67iWWjOCkFplePusY8ZOMS6cTnU/7tbZIiJ/HsSu7/2Cw7L0LoNLHJZ+e9xDjUOHJ9UZK/Ux6o6ekOgsHRfSSEF5LQUIn+VQcXc6tYIsAevUZzAoiAPSrStpZUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154965; c=relaxed/simple;
	bh=QZaNMiuPOTWXuTVAqUvTyUac5XykdcD6UFqPlP9jct4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyIBgBlv5XmgPF+v9Ac9d7wyPzDTM0S/aUrVyYHq64m9qNTkOv+xHqkhcSUjARwIzGHes2d3wWzMdG9Q9pBSdRxaRcadj7TydhrNR1AvKlCAGEWbKekSRnP97XDduLFJRY0tJ7oFujTAhkWDFgKCSN/ISZzAbpOYmacCIIhuzbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vdpd31Ch; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vdpd31Ch"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WTwhp9A/SCl0ODNS9CuWwWOw8IfovcPATQvYCi+U9zQ=; b=vdpd31Chti1ak9N7JLYTNBvpxy
	lMQTBtkCMrHzSbNvzHMRywna8hN0otUtVAki7FUqjbtXLwPZu+IF0/NSznudu/3Een6JgUwkW5eV0
	0nlWUF8xFhAWyG8s0gtDXUo4GIDUdvZBFKykVYDRIIf8WMogBsC6vOndyh8B3tLvFOmEcM09dl5f6
	GqV9QEsbGZkVdd7PpmHROQGjhK28UsmFhiaIH1fUykrcv/dzSLBWs8rWlqwfvlV1+gDd3vqk2MS0e
	p3Mlk7vRpsZAVe1359gPp68ELNGicRpmcuW3VB6svGJSqLPf3bj48vavWpcN9h5ysL6E96FIzsd1n
	ZGhTeIjg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9J51-0000000CWTG-2CsZ;
	Wed, 23 Sep 2026 09:15:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1AC693008E2; Wed, 23 Sep 2026 11:15:55 +0200 (CEST)
Date: Wed, 23 Sep 2026 11:15:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org, x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v17 02/13] perf/x86, KVM: Prevent host debug register
 leak into guest OS on NMI
Message-ID: <20260923091555.GX776954@noisy.programming.kicks-ass.net>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
 <179005110742.388919.1509641807739909065.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179005110742.388919.1509641807739909065.stgit@devnote2>

On Tue, Sep 22, 2026 at 01:25:07PM +0900, Masami Hiramatsu (Google) wrote:
> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> index f846c15f21ca..0473a5c95856 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c
> @@ -102,6 +102,9 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
>  
>  	lockdep_assert_irqs_disabled();
>  
> +	if (perf_guest_in_guest())

That naming is hilariously bad :-)

> +		return -EBUSY;
> +
>  	for (i = 0; i < HBP_NUM; i++) {
>  		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
>  

Note how the other -EBUSY return is a WARN. Why is silently not doing
anything not a WARN in this case?

And I suppose this is KGDB again?
