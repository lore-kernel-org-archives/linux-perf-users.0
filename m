Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361AD47DFBE;
	Tue,  8 Sep 2026 09:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860311; cv=none; b=mNnQ5pj6XKU3H9FV+LSo4vHexnC17tBKg89lHJeUOctvh7tuAxc+awf1Xs1RGgHbsELl9EmZzOwNscE/pkWeeU26aN9nKgt1VmVHkZbzw3ADuB1d75++7c3lFT7iivIWfnS8kRcMbOjjVjCbgWmtaXPwjquAU/I+t5ispeG0bsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860311; c=relaxed/simple;
	bh=k2UArcySfeHpVp9ykOmNXM3lQrV4LeySR1aU7F9hDP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mmp3Fj6Vl04d3hkMgJSe+5Lth8H1MVc2Bv4lxDIcz45/nVqDgfji/g1lJlrT6UEtPeTD9XYkHNiXzYCpK5TR2yVaWRa0zUw4WFPW7YTx8aQENdyy8DYLijUUrrcM5w31HTMm2iS2LBfyd8t2yL0G9Lj1lQWtmn/nL9mQPjqEGAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b3hKLnkp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FdytLzOH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b3hKLnkp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FdytLzOH"
Date: Tue, 8 Sep 2026 11:38:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788860308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S7fZnrtBd3MzTcOpfIWwsZnM6g3Bkm0P4fYMYH0n4+Q=;
	b=b3hKLnkpAyvy/BgVkCybg1woRIxg3mMEReV4irm3g+SWRIBY/HUN+jfcHA+o3n9G0TlfnD
	+4s6YCIeXuBTyVwkSPAv3U3D7JkVvrR6yovUqCS0khx5OOzcJe8v1GEof20VR38KQ4oUTA
	oTyrutQWkPR/hngX0h/NRQS+R5xWRlIAEc19xzXPIA2jsujxaUxym5GDcaKW6zSAL5CC6e
	lDsk1XMSUk2CNMcxwjMUwYz7zOYSI1aNT+7Gr3IBYzlwLyPrQftKZP41GUCKBcHdvrYVip
	gvCTlZjUpdow88Cjljtt2tYLi3/RzRW0NkG/zAFBnWdoVGh96Du3/CdlQ/c5Yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788860308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S7fZnrtBd3MzTcOpfIWwsZnM6g3Bkm0P4fYMYH0n4+Q=;
	b=FdytLzOH5qdsMjt74W6WRHV+nX7GW7p+ezl+S07BdlCbtDKIjIfC7jz/m6K25I/G20mubY
	8FlSJv/XjNyfjCCQ==
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
Message-ID: <20260908093826.ofGxmRRK@linutronix.de>
References: <20260814085118.OPEA_Ssn@linutronix.de>
 <20260903160710.vVf4gEL2@linutronix.de>
 <apmknG55qFAn8EPf@shell.armlinux.org.uk>
 <20260903133146.07095885@gandalf.local.home>
 <20260904155404.ESPFg3zi@linutronix.de>
 <ap7OMYBVKUrQjX9O@shell.armlinux.org.uk>
 <20260908075455.OffmMhrB@linutronix.de>
 <ap_AhKXlAWecV3BI@shell.armlinux.org.uk>
 <20260908083740.0qERUBOE@linutronix.de>
 <ap_Kv73A8exPhK-j@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ap_Kv73A8exPhK-j@shell.armlinux.org.uk>

On 2026-09-08 09:43:43 [+0100], Russell King wrote:
> > > > The linked report shows a backtrace by "BUG: sleeping function"
> > > > originating from el0_breakpt() -> perf_bp_event() following by sending a
> > > > signal force_sig_fault() followed by rt_spin_lock() and
> > > > __might_resched(). It also contains a reproducer.
> > > > 
> > > > The first sentence has the part
> > > > | The hardware event is
> > > > | delivered with disabled interrupts and perf intrastrucure expects
> > > > | disabled interrupts while the overflow callback is invoked.
> > > 
> > > *Where* are interrupts disabled?
> > 
> > On exception entry point, that would el0t_64_sync() for arm64 as in the
> > report.
> 
> Oh FFS. So why does this need to be done on ARM? Explain it. This is
> what I'm trying to get out of you, but you're being very resistant
> to providing the technical details. I can only think you haven't
> actually done the analysis.

I had the feeling that this is not what you were expecting but I wasn't
sure what you were expecting either.

The hardware breakpoint is delivered to the OS via an exception and on
exception entry point the interrupts are disabled. This isn't unique to
ARM but the same on other architectures, too.
It is not limited to ARM but also Loongarch which is sending a signal in
its handler (the one registered via register_user_hw_breakpoint()).
It is not an issue on X86 because they don't send signal but just toggle
the DR6 register.
powerpc and sh have different logic where the perf event is disabled
without sending a signal.
xtensa is the only one untouched which does send a signal from the
hw-breakpoint handler but xtensa does not support PREEMPT_RT and
therefore doesn't enforce proper lock nesting (so this is likely not the
only issue).

> So, NAK.

Would you reconsider, please? It does not seem justified.

Sebastian
