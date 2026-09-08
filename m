Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA393F1061;
	Tue,  8 Sep 2026 08:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856665; cv=none; b=XjrPzJoXlrZK84EnW6rslGPB+w4vvkkxQwD1dfSsQNnJMsVx+y2ylZjVBTOgVDQ6H/FIri9AxQVzOAZDaq0JybOTfY04eR1PUh4QoH1/lOfJrb65RHtCmQpOWvcHxvEFepCtNmfMXUqXEYvDtiBBNndyA18fLkvupPUW0RP5sTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856665; c=relaxed/simple;
	bh=aObaONEn1dCMGzMPvftgcPm+gNgsyc+7Qqxx0yvjCRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kbpem4SR+aO42yq5wTDZMbO3yF9nwgOlUaWyz5z1rIW8MGIv8KCkBJGUfwiaNIxhy+CrPZjQlLUlZEqfNFuQT+4lqPE4XF2LG2cm0bmmtL6JDvQWo5sRAbGCoUGmoXPts7oSLt4Cb/0lq3reHe17ugDT/DQVJnZ+X47EYNRKeO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UBTGZ9Oj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RA/YQ67z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UBTGZ9Oj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RA/YQ67z"
Date: Tue, 8 Sep 2026 10:37:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788856661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dj54Xu5hF3u2o6xkgppAffXJqB2xjIBxWbPiD6z1G84=;
	b=UBTGZ9OjVQpVqYvRdKAt1RHtHxAw+nECJyT1fIVZ4ltBrEJjWVEmW8/q/6h3dk8cRaLyjd
	cKiStOOGgvTjJJsvcuS9zqnyTDnCDkMDrbmegBiQjHap3j0geQ0hkiQFpCaza+Qv6pn/IL
	jVLfpU1MgZvrxGlhUfogeYAMogABmDghoILMkNQIGX5o8nucZ1S8XWcPBcRxha3pg/oMdR
	EfPyBzy6PrWQQatjK9zQMbvvEw5AXqpoVLy8J/uSlgCPw40vi1gxgiiu9SWzWcFsF2Q/+k
	QFyhaWPQD76bQQ33bKzHt3o9lyZHI2giOINmKraRgJNcPz7g6OgPGpghWG1s9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788856661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dj54Xu5hF3u2o6xkgppAffXJqB2xjIBxWbPiD6z1G84=;
	b=RA/YQ67z4ThvGbd+3ZVeDvPs8SzbDNBX0PMTP6wSHgp0XHD+MSmMJb5aPm2o0A8S3Cgj83
	HwhOCJvA9thKAWCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Russell King <linux@armlinux.org.uk>
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
Message-ID: <20260908083740.0qERUBOE@linutronix.de>
References: <20260814085118.OPEA_Ssn@linutronix.de>
 <20260903160710.vVf4gEL2@linutronix.de>
 <apmknG55qFAn8EPf@shell.armlinux.org.uk>
 <20260903133146.07095885@gandalf.local.home>
 <20260904155404.ESPFg3zi@linutronix.de>
 <ap7OMYBVKUrQjX9O@shell.armlinux.org.uk>
 <20260908075455.OffmMhrB@linutronix.de>
 <ap_AhKXlAWecV3BI@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ap_AhKXlAWecV3BI@shell.armlinux.org.uk>

On 2026-09-08 09:00:04 [+0100], Russell King wrote:
> On Tue, Sep 08, 2026 at 09:54:55AM +0200, Sebastian Andrzej Siewior wrote:
> > On 2026-09-07 15:46:09 [+0100], Russell King wrote:
> > > On Fri, Sep 04, 2026 at 05:54:04PM +0200, Sebastian Andrzej Siewior wrote:
> > > > On 2026-09-03 13:31:46 [-0400], Steven Rostedt wrote:
> > > > > On Thu, 3 Sep 2026 17:47:24 +0100
> > > > > Russell King <linux@armlinux.org.uk> wrote:
> > > > > 
> > > > > > What do you expect to happen with this? Which arch maintainer should
> > > > > > apply this patch that affects three different independently maintained
> > > > > > architectures?
> > > > 
> > > > Well, if you as the ARM person are fine with ARM part, an ACK would be
> > > > appreciated. If you have something to object, it would be nice to let me
> > > > know so I can adjust accordingly.
> > > 
> > > First, I only just looked at the email - you may have noticed I'm not
> > > very active with the kernel anymore, as I'm a full-time carer at the
> > > moment.
> > > 
> > > Second, I'm not fine with the patch as-is, because it's not clear how
> > > it could be merged in its current form. It would be inappropriate to
> > > give an Ack, because an Ack means I'm fine with it. I'm not.
> > > 
> > > Third, I haven't actually reviewed the patch itself (see first point).
> > > 
> > > Looking deeper now, I see nothing in the linked report, nor in your
> > > write-up that identifies what is responsible for the context being
> > > inappropriate to deliver the SIGTRAP. See the first point - I'm not
> > 
> > The linked report shows a backtrace by "BUG: sleeping function"
> > originating from el0_breakpt() -> perf_bp_event() following by sending a
> > signal force_sig_fault() followed by rt_spin_lock() and
> > __might_resched(). It also contains a reproducer.
> > 
> > The first sentence has the part
> > | The hardware event is
> > | delivered with disabled interrupts and perf intrastrucure expects
> > | disabled interrupts while the overflow callback is invoked.
> 
> *Where* are interrupts disabled?

On exception entry point, that would el0t_64_sync() for arm64 as in the
report.

Sebastian
