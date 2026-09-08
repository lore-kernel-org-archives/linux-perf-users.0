Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1D853FD5A;
	Tue,  8 Sep 2026 12:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871659; cv=none; b=XU+s7g+w/rKdEE9ejd9Pr+YWc67f5od3LxltLUKLmcQAbbivHTifMrHS5fUq3QDthUMRu0H0lDCpm7x8aHuxy9icek/aIksMQbzY4uQWGmqcjgs37puJAWrj9CZI7h0IYr4iVUHjm55wwwAoZ/efLbAxdmuAYTzdEOt5i1D1GgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871659; c=relaxed/simple;
	bh=SjAm8KsiC1rp8zi8IOo56ZfLs21Jr9k5NzBwZwT5spk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u27jXqfG88t0LNJAHqeQ+9oF80dpxTOPMHSzDBvegruD2tEnDzwkJ+/Fbq897X2kpsZi8a0Vu9EE6XFbjGe/9+oBJ7W12Vb3757rbX53hhu+i7rqXlsryZLIqiA2TNq/EIJJbGGnngR7Dpy5w6GijowOS5aA+UiBVMVESF5GOc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Lg3hQczS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Lg3hQczS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3iwiiQmAlU8enifR6QY44I57i3gUB3NZPzvMn8cgozk=; b=Lg3hQczS+6CsrXLaGUJP8xOLSk
	SS9xphKhDY8HntlM6yMVO0UjTkXpH+IBJoIhA3uQMwpDGAiCTkC7A0U7ZZgV9ArI5C/6mzjLQasye
	n7qErS98uKbiwtY3cpepGG+ILCX072Yy3dzPCtj6v+sz8QEFpMTARgnwGnE4rlV2O59Hi2UQwk3bS
	AiF+9L1IgyHRqNv7n9BDrtU2Hsf20e7Y4N0FAr8e28Jn5l7vqzRPf6Mh837G3EyS6M9atzuMNXkn+
	idbZ6csgR2ehxgPWJfrwu6wGISWm1mOPdmw79XR6320D+QhTyE8EqUx6aQCc3fOrY5HwLqdlzNcyj
	rZyGwhCw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58402)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1x3vEY-000000008Uo-2eoX;
	Tue, 08 Sep 2026 13:47:30 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1x3vEU-0000000043Q-0WTK;
	Tue, 08 Sep 2026 13:47:26 +0100
Date: Tue, 8 Sep 2026 13:47:25 +0100
From: Russell King <linux@armlinux.org.uk>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-perf-users@vger.kernel.org,
	loongarch@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	James Clark <james.clark@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Waiman Long <longman@redhat.com>, WANG Xuerui <kernel@xen0n.name>,
	Will Deacon <will@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>
Subject: Re: [PATCH v2] ARM, ARM64, LONGARCH: Delay HW BP notification to
 task_work()
Message-ID: <aqAD3YubuHDy8Fva@shell.armlinux.org.uk>
References: <20260903160710.vVf4gEL2@linutronix.de>
 <apmknG55qFAn8EPf@shell.armlinux.org.uk>
 <20260903133146.07095885@gandalf.local.home>
 <20260904155404.ESPFg3zi@linutronix.de>
 <ap7OMYBVKUrQjX9O@shell.armlinux.org.uk>
 <20260908075455.OffmMhrB@linutronix.de>
 <ap_AhKXlAWecV3BI@shell.armlinux.org.uk>
 <20260908083740.0qERUBOE@linutronix.de>
 <ap_Kv73A8exPhK-j@shell.armlinux.org.uk>
 <20260908093826.ofGxmRRK@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908093826.ofGxmRRK@linutronix.de>
Sender: "Russell King,,," <linux@armlinux.org.uk>

On Tue, Sep 08, 2026 at 11:38:26AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-09-08 09:43:43 [+0100], Russell King wrote:
> > > > > The linked report shows a backtrace by "BUG: sleeping function"
> > > > > originating from el0_breakpt() -> perf_bp_event() following by sending a
> > > > > signal force_sig_fault() followed by rt_spin_lock() and
> > > > > __might_resched(). It also contains a reproducer.
> > > > > 
> > > > > The first sentence has the part
> > > > > | The hardware event is
> > > > > | delivered with disabled interrupts and perf intrastrucure expects
> > > > > | disabled interrupts while the overflow callback is invoked.
> > > > 
> > > > *Where* are interrupts disabled?
> > > 
> > > On exception entry point, that would el0t_64_sync() for arm64 as in the
> > > report.
> > 
> > Oh FFS. So why does this need to be done on ARM? Explain it. This is
> > what I'm trying to get out of you, but you're being very resistant
> > to providing the technical details. I can only think you haven't
> > actually done the analysis.
> 
> I had the feeling that this is not what you were expecting but I wasn't
> sure what you were expecting either.
> 
> The hardware breakpoint is delivered to the OS via an exception and on
> exception entry point the interrupts are disabled. This isn't unique to
> ARM but the same on other architectures, too.

Yes, architecturally, when the CPU enters an exception handler,
interrupts are disabled by the CPU. However, that doesn't translate
to "the kernel runs with interrupts disabled". In most cases, we
re-enable interrupts if the exception comes from userspace.

However, I have no idea where in the call path is between the
exception being entered and the code you have a problem with - and
I've now forgotten where to find the call path, and I don't have
time to find it again. You are making this incredibly difficult,
and I don't have time for this. Sorry, this is my last reply for
a while, because this is just too much stress at this time for me.

What was a simple request has turned into a major source of frustration.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
